Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0994C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdzlc-0005ZK-6z; Sun, 28 Jun 2026 20:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzla-0005Yx-KH
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:22:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzlX-0001mf-Dy
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:22:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c12381e0662so193788066b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782692542; cv=none;
 d=google.com; s=arc-20260327;
 b=QijelfFwzjx2BS3RgPCzZUDCtXq37Fy8tyge8Kjo3SPPxI6+3g24UiMw4+BjI1REUB
 Q7vINCMBJVxegZMcirAHDaynNQt5J2TfVYciHVIbx8qKnva9pedXjHX0kPYfcq5f3ISG
 R1rc5kIPK4hpTcy4BGT3jNOixEox3155e6m2ZNOcQfosLiDuRPpZ0F+0txSawklWn+It
 Brrl6Mf8mAXN/Rj4W4ju4cUMeN7rE3pr3TnsQNJeQjBlE4bgXE9iRctWqKQhwSscXQ5D
 RvtxmwDQwXeVHMD/K2Pe5DDm8zU688Ct4x8GNSLtfyojGzFJEv1r6ogZ9ExyxsUj7sO8
 Nurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HUxbEwHA86EudrbV5rPTvkDOzPEic83il00tjKAesWo=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=DS9y8dy0wt3agtngYQFLYTD54vs4YYLVa372ilwmZwBOaNkgnKYV+TNedhbCItprlM
 QstakMeLGBs5Rh8ufqVkrjee9F8uqXx8uthYZ683qdmRHzBxiHslnDPsIppDv8zUp/td
 aL/5bghsmbprSlFaPonihD4H8UBVXkHdmyu6Pv0X8XgvwdQu2VQsi8Ba/tSGDEZ8aMgn
 HOIGhiB98sM+B7tAzmhugYaXJAP4qEC9OYqs1j9JT4Bg4aSlDfZs+FtiZ85R6JFERZCj
 LmMCjKkRjHNi0fNUGzYIhk3zYYPA23+vkRLzXIko1sgFvMIGsGTZ0i/+AEqdV+i6Xdt/
 bBzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782692542; x=1783297342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUxbEwHA86EudrbV5rPTvkDOzPEic83il00tjKAesWo=;
 b=qo5/4ElPUr5sc7HPJxFiqzipEiJz7k4st1TDf0ym7KTNoSV2TRBwuBaLcQPM9DpbqO
 7lZcWLVteyqhy3CEyF5Im2P1ZDYND8TRBGbixNv5UpDBI5gw2sMt6m9+lP3VpBQufM+H
 ufHleYzX+Lwh5rguvqTyWYhjZjVAExP0o70swNWxRjpeV/90SZW60NEVT7yw7jPN/HAl
 y2JlJqp7EfMFFiYJc6Y4ygqp4myk7+/D5Mp4gNjKbyDVpXAptyvA0Sa4Ga2UaFIB13OT
 IznU8jpaiTqk569MH3sLe2sXdr3aGyRDvxgPY/4QUbC9L1tM8lZ0yR84r8MO2ot4LhyM
 Q6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782692542; x=1783297342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HUxbEwHA86EudrbV5rPTvkDOzPEic83il00tjKAesWo=;
 b=sRJy35e74MWeY2/KsIIkHnuXmUq3FSND2IFCCEXdutHqHZENxDOiVsm/qEVmc0wFPJ
 hr84GDI4l28CT4saj/jW4TSU9bdHXckc8+04wmtT0om1tMgd7F0Jtrm0MNOBkrXcy+N3
 Ht5bPvbvnwu7sp/b0BkagPENFiJcakUlIpsp/pU3K+9w1AxYsHMqcEmNDgN1FclVkwdu
 kFLJZOQlJAU3JBNCVkDsW8GMe3sYwa5v/a5YSpuhankXKWAIHliIcO+8cuFEL8Gsy3jx
 XoQQMAroiAj8aEXIbpTbCV1dBIHeYRYu5I864+CkPuLYrWRHfwSwafMjddcVZ4sCZBxQ
 EWnA==
X-Gm-Message-State: AOJu0YzYRn3x5Ho061HRTIqR/maCyT1/A6K0tmRvtlCGysBBOvSNsLJP
 wvjG7Db0iznWSXPLLyGpdECsCSmyxIad31ycalaaI5QVdnX2sfsrK2Ea0w7fCLKvPS92CApo5a5
 TPdRxYcRD9FQ1BM9MMdDJNKpEcMxTcvg=
X-Gm-Gg: AfdE7cmpY9tnLLD6ma5eXh6AihMXPmfPhVWD3vDKwa3KUQ+yMGV+Grk6LU7JH4wwj1a
 d0epXaFCkad0a/qorPeCloOzvYsXa6BZfuGHnCyj5N3L35v6NKTfjdIzM0Plf6f/kFGufgP+PKy
 sQQiIYqMuaiY4t87ho+gB5fDkGHOvIrpEOay4sHDgvBAOTmvApP5SBiEGWSZuKa7P+yDLYiOval
 2WFGxkUGiehb6I9ox+XXINVEv20Z8P9YPTDsK904rBp8wOdr+f3jjxiFAwShvexL0ThdtMuhODk
 x1mKXYivEQVDEFrsufX0NdlEWvM=
X-Received: by 2002:a17:907:a909:b0:c0c:de65:d2bc with SMTP id
 a640c23a62f3a-c1205ef9607mr782866166b.43.1782692541594; Sun, 28 Jun 2026
 17:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260626173341.3661446-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260626173341.3661446-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:21:55 +1000
X-Gm-Features: AVVi8CfTmJGyLoQx7wmIdCy4VmelxWF_sm33jG4_vSKJi2LiS99ZnRQdD_YJ0iQ
Message-ID: <CAKmqyKOE6rv5DDbc-Z0+4G1gDkvXcx-ME9ajWCff0TRpj50LCQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV
 appropriately
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Sat, Jun 27, 2026 at 3:35=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're hardcoding 'true' to FQ_HDR_PV in riscv_iommu_report_fault().  Use
> the 'pv' bool the caller provides that indicates if the process_id is
> valid.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3556
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d47abf9eb3..3ea9130860 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -580,7 +580,7 @@ static void riscv_iommu_report_fault(RISCVIOMMUState =
*s,
>      ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
>      ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
>      ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
> -    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
> +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, pv);
>
>      if (pv) {
>          ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->proces=
s_id);
> --
> 2.43.0
>
>

