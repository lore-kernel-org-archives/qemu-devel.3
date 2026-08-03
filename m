Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B3FC5518F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqprQ-00068Y-Bp; Mon, 03 Aug 2026 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqprO-000685-A4
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqprL-0000SE-I6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785752725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNr95apc5PDPRVlIwX/V/QlypOkWK5TF77CZ0ZaErlA=;
 b=VG8h5vE6lw/0OuhXserWanM6fYxI9DMYxmzwGqDa27KQkIiSg31Z4M6YKTxIknUxoDa96P
 YCejuf12ZMfw+OMQ7c/Lv1HzfZexbGACXr/XasBUKHxa43OAHxUpjDUrcchQzknlZoLPTq
 MmiCJ7FPojPM9MwfuXClVmCjfrFO+lw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-09x-OM3zO0CCW_byQyuwNg-1; Mon, 03 Aug 2026 06:25:24 -0400
X-MC-Unique: 09x-OM3zO0CCW_byQyuwNg-1
X-Mimecast-MFC-AGG-ID: 09x-OM3zO0CCW_byQyuwNg_1785752723
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso2094189f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785752723; x=1786357523; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GNr95apc5PDPRVlIwX/V/QlypOkWK5TF77CZ0ZaErlA=;
 b=LJ+Pokdx/XmJsOE0g1/3ih6hEIAFAYZvmJBrTmZLcmZsfIwJ5uMNnTVK8oDjnKu72G
 rya0PZ+NBhCZkjHvuatjjyo+1A6oWfLEbGe5AhfnG0AwgPv5gWOXScB5IpmzP/GDVghb
 jZA0T0FdxFlYMtVfUw5qSkJL4kjC7O1GZuAuX8PdLFDd5MkxtNFIcATxRNbIxDuEpQON
 +ZE3ZpIzRwtWqZs3Jqs/6A1/1ssa6gIFK4v5/1V4IyrJu2CbTwPpefi95VSsKCzOvehR
 nkOU5Fes6+qJnUVoLE85OMKgta7hdzfI/YSqu8SSGdbQIy85LCcoQRgV01E479yW+/5E
 Urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785752723; x=1786357523;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GNr95apc5PDPRVlIwX/V/QlypOkWK5TF77CZ0ZaErlA=;
 b=IflVXtRiD7Uwba60VdmHeIOlSGhwz7pcKV07qEYO3KXnpg/Z1SiJuu1WMbpZT/IK/C
 zxehLs1sdNgVwIpYt2D2elc+zQRQl557dIdPEHEnQAP6DKePxjfKGCbV1hYGWCWJ2Bba
 /vF9VB6bHtRTI3hJMLMH0VYMjOkgllF1NqW4YJBkYBGsopSs64yZE+U+iYLDo6HvJN5b
 JKhgYqnOTxhhIf2/Z78xZhMcV8vejt9k6tON1gbweq1dNYgS8MCZ72Ft/ta4gZPKWNdc
 AOaO9MSD7OW1FQRwKLe+GItvrkBAaoH0N4E+u9kMEkWuupY35X33zeEL/7UVRzZwgiTQ
 8m3Q==
X-Gm-Message-State: AOJu0YwU/ND4JAI/bDCWyqDVb+z6gE0cnwnC8BpHiQImbLX2Tybr6DM/
 n4nQF74xoALebx66e6vOHzbFhzLSanY7QgYPsgiBqc/CmEDV+Ap6mPeaIni6cU4tYfRmdQFRSRY
 ovLKcitfKhj//LJbN9PE2aKEQHpno9nESNuMK1KwJ1GnpHayzFOcfs5gw
X-Gm-Gg: AR+sD10ofCb6Cn/qRhiqiIiPAZhSwJedWzsFBsS5aJOFUz8FE16Ivx8ZrxrpDkAD1My
 a4LyLRCGKG4tpjHj2SifCvLcJW0Q2mlYsUfZugor2fU+ARHbCQ0dXnUZ3Z/AEouS/01S00V5OHQ
 AEE9zuiNpKFIKxq878KVvznI+RmmOHY8FRrBVYN15I8WyvtQomlCh8d5U2C8CgrF/8jqiqaGzGR
 nRdADi159Bw7T5HOtF+5d0NLpGvIbJmeQO57WHJjkriDgftQCLdKnMw/ywhJY2Q361rHB7xoOsF
 nBTuHmFYO1gbkkFEsr9m7IyZcqscengg7kMTOzdyyDIftLV1BMdGbvTupxJRQw+pjJx0ms3Ac/c
 F357sWGJFOsOstrAOydPSug==
X-Received: by 2002:a05:6000:469a:b0:47f:95ce:6f48 with SMTP id
 ffacd0b85a97d-47fd72ba4f9mr18202122f8f.11.1785752723072; 
 Mon, 03 Aug 2026 03:25:23 -0700 (PDT)
X-Received: by 2002:a05:6000:469a:b0:47f:95ce:6f48 with SMTP id
 ffacd0b85a97d-47fd72ba4f9mr18202051f8f.11.1785752722579; 
 Mon, 03 Aug 2026 03:25:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm29035868f8f.12.2026.08.03.03.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 03:25:21 -0700 (PDT)
Date: Mon, 3 Aug 2026 06:25:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/virtio/virtio-iommu: Reject inverted MAP range
Message-ID: <20260803062510-mutt-send-email-mst@kernel.org>
References: <20260803094302.95228-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803094302.95228-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 03, 2026 at 05:43:02PM +0800, Bin Guo wrote:
> virtio_iommu_map() did not check that virt_end >= virt_start.  An
> inverted range corrupts the GTree comparator contract (interval_cmp
> returns non-zero for a key compared with itself), causing an infinite
> loop in virtio_iommu_unmap() while holding s->mutex.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4104
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Same as 20260729131953.1720567-1-physicalmtea@gmail.com ?

> ---
>  hw/virtio/virtio-iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 533bd5073f..cc863e90d2 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -807,6 +807,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>          return VIRTIO_IOMMU_S_INVAL;
>      }
>  
> +    if (virt_end < virt_start) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +
>      domain = g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
>      if (!domain) {
>          return VIRTIO_IOMMU_S_NOENT;
> -- 
> 2.50.1 (Apple Git-155)


