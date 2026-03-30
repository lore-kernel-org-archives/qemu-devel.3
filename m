Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDBBFF495F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w77vh-0002za-QR; Mon, 30 Mar 2026 04:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1w77vg-0002zD-7m
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 04:25:00 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1w77ve-000075-N1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 04:24:59 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-12732e6a123so2588004c88.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774859097; x=1775463897; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g5TduLyOB2E5auatV1YEbPKRJcZ4ZLa0E2+8Df6dxNQ=;
 b=RHI7wC7JHyPU5Nuz2pnarMWVW+F3aqOfYlQfirKl0px21VeSWn6FMBrl2l5Cc5nhi5
 dvzYTrJgUFS7KFLN1K9M+Vl47G2PQEFcWx9OAL9G0hL4OJf8PmTwrUPdiwamo7681fCH
 AheNmB4JOc2pzToRoFukZN4ZMYHwel9wzBblA7K/NSrdg12vB+dBTs9ZFfgNVa625iyu
 C0xNHbjkw6Lo3N8P3aKIzx5NnHzhx9CRnfjA/QdBNrF9x5ZR7VFMzwNmKBKmvSYVuK0H
 HY0ADXKS8t7TUZJ0tg3oT5gMaEeO5QHOKjinw5At1RwzWmol2PwGd+7XXlPAVYRyxbWD
 hR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774859097; x=1775463897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5TduLyOB2E5auatV1YEbPKRJcZ4ZLa0E2+8Df6dxNQ=;
 b=CaKlxhQrQ7PYinnaz/TW8PjNUUsxop0uKVJj5akztcj3kTRycHdCE5nlIDxDbKR/ta
 rJAisp34krmfsToMcgLkaeLCC6ADGsdULt3bTFwdtXSwaGrEvA1X37D20hNGJgIFLpe7
 9wxYtx8tVD2qBgsa/r0FOU6pi7zeSVmKkiPUrRmQ91ftgBmV2nZfaaQRh9xHMnvNFcA2
 hoXn2NE3VSZNmvCibAMDb3+OXS7zMiBrignB56rOFnV+ymRIq3oatlrvvGCbBlyJByPa
 xLmO2XEVgL76VOy3y5QJiYZqCj1S69qksSzHBLXaXuC1YER4XJRsm5dokhJk2XcrgryF
 CcWA==
X-Gm-Message-State: AOJu0Yyc5HrlkvURMvEkriwyq/x89BvadzIiLlpQajoccYtHb8qxREFF
 AGHucrrtxRgkOeoH36yMDJuMg/+v9D4tglh4tjvfszo4k6qgYJbOkyXt
X-Gm-Gg: ATEYQzw1rqDuR2ZT7a0N50Gh44fMQV2376ao4w1OeWMR458ZKQgwYESfX2N2utD3H78
 kzgA5Ly+a5q2n8yRliJb6V24cDUgSEPfpidwkvAWxgAnTgXSh2jHYW1N8WqsyEbNM8peZmnSWU/
 XuBYfdjvQoyokLW4jflNC6nh3EXuWKsd+SXJg3w/E0kPnOFmLW6HB4MkOl2OD+uyXkZ9NA7AX4C
 y+k4aNPZ3sib8mJrPezXqNyxAYlfHfCbAcKRSEbbDbcZjRlphTG8rOn4ShG7D4zqYO6jFFrunL0
 Mzzqb2CK0M6lCbwBv6dNkVJKNcrigcs1ZwPJ9pQf0+9GDO6o+uSQL5W4Zgn8P4HxAscFabWLvSc
 c1E2CWs/Anvw3SEKwxrimVFB2t+IHRugForcSyerbCEz/lP/6uKv+FRu6lIy7k0WeTXuJBGYnji
 eD+6vfxl3bj4U+uNjyYIC0XuB0gX7q0sb9EfvRrsEg5Ez8s9duTpfN4e/sTDFcnauf7aNFaWesF
 s08zTIcj2+u
X-Received: by 2002:a05:701b:221a:b0:12a:b3c4:c3b6 with SMTP id
 a92af1059eb24-12ab3c4c608mr3436080c88.21.1774859096593; 
 Mon, 30 Mar 2026 01:24:56 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com
 (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ab97e7a57sm8777404c88.6.2026.03.30.01.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:24:56 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 30 Mar 2026 01:24:54 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 lizhijian@fujitsu.com, mst@redhat.com, pbonzini@redhat.com,
 gourry@gourry.net, nifan.cxl@gmail.com, me@linux.beauty
Subject: Re: [PATCH 5/9] hw/cxl: Map lazy memory backend after host acceptance
Message-ID: <acozVjvVT1THZP_S@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-6-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325184259.366-6-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=anisa.su887@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 25, 2026 at 06:42:53PM +0000, Alireza Sanaee wrote:
> In the dc-regions-total-size flow, a requested extent is not backed when it
> is queued. It becomes usable only after the host accepts it with Add
> Dynamic Capacity Response.
> 
> Use that response path to look up the first pending group's metadata for
> each accepted extent, enable the selected host backend, and move the
> backend and fixed-window references onto the committed extent list. The
> accepted range is then marked backed just like the non-lazy path.
> 
> This wires host acceptance to the lazy backend lifecycle and leaves the
> fixed-window direct aliasing to the following patch.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c5427adb3a..cc7be6e68c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
[snip]
>  static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
>          const CXLUpdateDCExtentListInPl *in)
>  {
> @@ -3718,8 +3740,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    struct CXLFixedWindow *fw;
> +    HostMemoryBackend *hmb_dc;
> +    uint8_t tag[0x10];
>      uint32_t i, num;
>      uint64_t dpa, len;
> +    int rid;
>      CXLRetCode ret;
>  
>      if (len_in < sizeof(*in)) {
> @@ -3756,10 +3782,54 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      for (i = 0; i < in->num_entries_updated; i++) {
>          dpa = in->updated_entries[i].start_dpa;
>          len = in->updated_entries[i].len;
> +        if (ct3d->dc.total_capacity_cmd) {
               memcpy(tag, in->updated_entries[i], 0x10);
> +            bool found;
> +            MemoryRegion *mr;
> +
> +            found = cxl_extent_find_extent_detail(&ct3d->dc.extents_pending,
> +                                                  dpa, len, tag,
> +                                                  &hmb_dc, &fw, &rid);
> +
Btw, I'm using this patchset to test my current DCD RFC :) The main thing is I
want to test having multiple extents in the same add request for the new
requirements for tags on the host side. Since we can only add/remove tagged
capacity at once (no incremental add/partial release), would it be possible to
support that? Sorry I didn't have a look sooner

Thanks,
Anisa
 -- 
> 2.50.1 (Apple Git-155)
> 

