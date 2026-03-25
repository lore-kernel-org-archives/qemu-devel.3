Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B576F103A99C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Dxu-0008I5-HR; Tue, 24 Mar 2026 22:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Dxt-0008Hi-8b
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:27:25 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Dxr-0000Or-Ov
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:27:24 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9961e4f71bso143239866b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405642; cv=none;
 d=google.com; s=arc-20240605;
 b=GK1Zw1KMDKGabyYIMSyw1VWZ54tYBN92ieyeB+fWYDZmUNa638ng3xq3giEihnKXWd
 oyszL52CRPbNx8o4c5PEgfXtiiomvFaJmmR1hLy2rENh+CepSrDRGZmP2negk2defOB3
 EA7S9zWitCw3l9zKb50yNpogbJICOHkLrKlqA2B0xQBd7f2BjpqcimSoEmQoyPshI37W
 pouTO0i9tTSx97AtvNMxHuWA4KXJHeHKPRbY2fPa0nMm5aHgKyRpqLgwoqtovDsBL+Ca
 Oz5xe5hEv9NT4kyyOEze96QASNZ/1/N59k01KYzVDEMtYhgQRA9LPylffXgVvzTFCMhQ
 urow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yw0mHhoVlzBYV73WlSVEIt/16UKQQ3fUztUm7IwdVks=;
 fh=Ykz535V6Tkaof7buRypbHUBTN2MzFgl0yupx65lIR2A=;
 b=NkzSpMxM3W8MWCvEPysEa9WWKng9qw8ZOo5JDGQXBRz0k+7jHZr8L8+zYyZe54SE/Y
 maouy93XJhol3VUSSiWeh61rOi8BAJ7qrs6St/fjrKikEBGYFZJ95pKMkHA3WTaTUImE
 R2fVYrj4wucC22nxKFFbVqOvVNJbRTn5mhb3GHDsHekmHqYwK8y0u1Yo+D1LJ4K1YHRV
 WsOR1OblwViUpdciL84+iKYNeVqj6TkgK5+RbXLgmXYsvcnoYi7P0kOUY5AYH+HDQgw7
 N9fYu3viGR0Y5s+Xz+xt/qlHsWCD4xFLb+uTbwXtTPCWaFWTGMS2y3yq92yeFxLwT/Gx
 vIAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774405642; x=1775010442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw0mHhoVlzBYV73WlSVEIt/16UKQQ3fUztUm7IwdVks=;
 b=fmFhnqqPQ9fWVxZoXJbeGnQ+1qofCLwxXBZum9R425m/4XwojE8suMMw3TjLkjCIlW
 CaEvRfWhteFPxuvJ+2ZEG4jFCFZlFs2xMmhcHSmSUA2WL3v2HhbhJV9qubnBI6l24bvO
 2SJn93tgnF2Lv2VP7JqfCe30SVtW1J0aM2VQ2H35V0fBiaWouELT9/S5FIkm7bunabnX
 EGTPK7SsJSJRSEyGWDk8Nh6WgwUTeag95IAsW4OdyJNqFsphxHp7Pv981Jpeygk0V4AP
 IcLwcu4mbkOUQVY7310hVMsQdEueBbg6bkhVLRAzjYVBrb3z54INhzRjnpf7T6BQi6P0
 wS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405642; x=1775010442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yw0mHhoVlzBYV73WlSVEIt/16UKQQ3fUztUm7IwdVks=;
 b=bRMRXRLmwVqyITtlXbwaZ8LanfvoqJeFk59hlgbC+4XYVLslqTGwQmDi2s4T5XxAp+
 Xi/h9MOLUXRad6t4jTslC146D3GKF7YxpAZEhoKYOkl0ePOCBex1I4XqyYTGNxDOCSIT
 MUlEKOAJunWXfaKao8IsWAraYBvsS/N1zKRuJ0WJbwUDqGth6wothtlCLInPNxNRc4sh
 9vXdpPT4OdomADRVcMqwY5EaBEmeLUjeICOXWYN5wnjLUBi6/ZtyQSsRtfbPOWZ5DNk+
 3nPcDVQlCXyedBXHPZVQiqmqBLhcHx0kggro3mRa54484R9jIuhNg/B/txhyZxJwcECp
 8qQw==
X-Gm-Message-State: AOJu0YzrE3CV7yYI81TjsCbNXBjEd1GSP+AGO6Zrite5Cg1ud3fQcPoA
 hKFxqaWRIscPj2tPh2BK3Zo5ePAeSMG1SHh2JYepQhQHqeB8Vvdmq7biQTuNQDxTFGvyy6/uTHy
 KnBqWO2cNURgqm6rRGfJB4ryD0TAlYEI=
X-Gm-Gg: ATEYQzyKSEjBB5fnepGHMvafUEw5p81p13U6bjUA4UVt4CMwigsvnF5Wd9yJPTpAeWY
 QuYoHnE3brmuoy4YCvNbksxCVSDxOcfvGCaQQhgvctB4OKKfpkSi4EEy17MSVsgvnC5/5J8CxmN
 6lGQb4+uEPfAZtm/KJTuPKtVUI3xcGycPI0xoihXHSIHzkj1Xqj8iJy7U9mp7pn2Ez0OCxv1Y+W
 IH1ogoA/RcnGumk74tNvrcCYEj3f1vIY1KihNdcgYFXPXbfdGx14P2mOXjBGBXLH/QH3CUaxOKW
 vWkXn91wG6eP/9xWiM4Bguqn3jkpyMCrc3imRw==
X-Received: by 2002:a17:906:2551:b0:b73:2b08:ac70 with SMTP id
 a640c23a62f3a-b9a542bba76mr87157766b.49.1774405641972; Tue, 24 Mar 2026
 19:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260325014856.58948-1-jay.chang@sifive.com>
In-Reply-To: <20260325014856.58948-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 12:26:55 +1000
X-Gm-Features: AQROBzBJVjzHr-Xu02PLozIIOWaQGcbIn4lyD2s0qwIJWzHQ5XfOruYnl6vHyS0
Message-ID: <CAKmqyKPYQWyYV91k-DkEOfQmUMQwkyZ4kHRje5YU9bAtxpUVVw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: Use standard EN_PRI bit for PRI
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>, 
 Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Wed, Mar 25, 2026 at 11:49=E2=80=AFAM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> Replace the temporary custom extension bit (TC[32]) with the
> standard EN_PRI bit defined in RISC-V IOMMU specification.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>
> Change in V2:
>   Align code

In future don't include the changelog in the commit message please

>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 225394ea83..30343e98d0 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1572,11 +1572,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *=
s, RISCVIOMMUContext *ctx,
>      riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>
>      iot_cache =3D g_hash_table_ref(s->iot_cache);
> -    /*
> -     * TC[32] is reserved for custom extensions, used here to temporaril=
y
> -     * enable automatic page-request generation for ATS queries.
> -     */
> -    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) && (ctx->tc & BIT_ULL=
(32));
> +    enable_pri =3D (iotlb->perm =3D=3D IOMMU_NONE) &&
> +                 (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
>      enable_pid =3D (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
>
>      /* Check for ATS request. */
> --
> 2.48.1
>
>

