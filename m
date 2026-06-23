Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F9CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwk6-0005CI-Sv; Tue, 23 Jun 2026 04:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwk5-0005CA-Gi
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:44:25 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwk4-0005fB-4s
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:44:25 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-662c360aa73so5709971d50.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204263; cv=none;
 d=google.com; s=arc-20240605;
 b=D2RhOd+w5igza1e1r57bdJLufyI6Ywoz75Bwgdsen4Ce72CGqzwq1fSmBtOVfDDyli
 JqQtctSmKDiTtsL6f/tko5JUEFthuReBFqEUzMsO48TKi1GcW9i0vsKfklBYdHDH+cYz
 Zv6pldkmux09d5DHL4tx+lsrUks51rs1E7i/h5DiP3K2ac+P5gHTimvClcMLmAutptRc
 k5NWMUV5lv8vRNDdH5u68cujB3hOV4crG/kr16/Pg7JAe0SDKa+8iagqztme3Le2Lm9b
 8wyBb1liGjn9CoWzSanfhudEnZhZzYlJPXqb4QHNA49F5mIcqEJKh7kDQT1tx6EQDFAA
 hZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=28ZYupx6bHUW6qjl8LHtCix01JPeQTjsxwA1obBQISw=;
 fh=nqU2qTrUylmjwSPaum8+DG0h3pDD6hPcgtsDXuA2oBE=;
 b=jaz42ZGp6sGwF0yfqJHiaYiXR8kzKPjth5eA+lL1A8ZSUUk+jdbf39hCUDNJvEwK48
 r4sD/xLyGMX3pIUkfLgVlGX+8RVOPHAwkmJ/L/ch3S75PnqwDjyXI7lilGVcqfizPAyI
 ctHSbmpm3KtgSF1h2IMLUkzDK+KV7XDZHezfno7F4F5MscqNiAr0TnJ4OrjEP6BrRbO1
 oj8Z1ecKatSvdUv+iVnW4DknvWuVehYUF8Hupd92uvcK0R5WYvwLdHuvt5J1uhUSEcd/
 Ss08l1ehfWZ1n+zeEzjLUUeL34Ks/aIh3XG8sIdGTIA24y1qECREX33Y5rMWep9ApEBL
 kIwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782204263; x=1782809063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=28ZYupx6bHUW6qjl8LHtCix01JPeQTjsxwA1obBQISw=;
 b=uXEJKNzNomCWuLGPQw0YxmMxila8yskXoMPPkNAfROnLlp5+0fEUWT6p1aHsuaAUI5
 H8KOSysG4UFJFwBSXKaT3jaVFTMKpKLlgvJ8JP8Sp2Um5R/8g/eBAMFrSOdN2Y7Blj/3
 NuC3l1QJFfa8JYyRaq4EGiftCUTaAFtXctDzD/Ygch+eGfExKPTUQ3dsUi5YG1GqFhZX
 1INKk2tnCJCF5TzvhV7+6x4SxSmty/BM9KGOVDpoS6mZ+nSQveyZren0gXd1d4yczuFQ
 Oaa1dkb0M8Spp1IjsBUJQGPtxafavx7TT/elLxRwhC34L9RlvoW/Zvxt4WJGK2jgHlZE
 aRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204263; x=1782809063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28ZYupx6bHUW6qjl8LHtCix01JPeQTjsxwA1obBQISw=;
 b=nHGw9HpK93c5ZYgJajeI0XfHRZ17zfmoW5ueYkDefhiDt0AgiaD4zgzPLz4mTNFae+
 nLBDBpfKCJGZseoJNDaTJCAnjeRx4dgt1oNXGiBfh77Lq7n16ln7Ba6HCsQFHebHzVen
 rapwglkESaEmaBHJkhhswR8YYi5NVyGmVj+jj9u78YXYvjbL/ewxbESRYwf5A45TORXW
 dTiCFp9Zbx6Lho2Z1Bx3lOoZpi9uO8g6B5A+QYRcfg+3kg7eDvDY8FhyR3JMBQZ2yvp4
 VsKMuq4oNuqIutA82Od6x3iPCkcCJj4IofmoHmg42f0u6r5cwKKxlc0x8ViimKzBk7IQ
 AVvQ==
X-Gm-Message-State: AOJu0YxALWlXI1yN4r3QzQYAuIj7ukWtfmSUP3V7jKXgiAaQCMUqrZgX
 nZAuUqEH5e+AcLMoyuZiXT7X1FqqSg1WpWbmhEBqr+S4vP5iKzDo9gjXTFRbW5XGK92NkVCLGaE
 T7chfqmkLI66gXIteQPDdlfMAmJ+8GHaWAVrudfj5eg==
X-Gm-Gg: AfdE7clrLXWdh8Df8wzHaURH4H8lfpfSQlAF/N/GWeYQHTSeFMRZ7zyvI3olrnZ7hfY
 nO5KbVy4/qEhediVIkOTpFrOK1w46AglBsKYcJYvaSROsIlwO1uwbFEOZBeCbU8mFY/nTrxqq5H
 u8ESMiUCWGU80eUV/rorYxvMNXKo5Nvm4wkYzR2zFgvZiGDgzkMN26u38/HCOZj/+Q5ISJkpITn
 KIDORlKioZJloQv7wKX8l6qju4zslO5+07Zec9v4jI4O2+XT4wossTyVkkdnVvKx1FoIbuKQlie
 33YHLgqUs30Ib8pmOieQWuXEQWkATQGwAD26cPh+su2cD6X3xWhjWf+d
X-Received: by 2002:a05:690e:a4e:b0:660:6ead:8997 with SMTP id
 956f58d0204a3-662ffce890bmr16671095d50.28.1782204262960; Tue, 23 Jun 2026
 01:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
 <20260623005813.984238-3-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260623005813.984238-3-alejandro.j.jimenez@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 09:44:10 +0100
X-Gm-Features: AVVi8Ccbz1VLgzK0T3FRCD2Vre2bhgFYR66IZFCFrPVggVhEVnicYXuuGOWecwc
Message-ID: <CAFEAcA8NKB6Wg-Gsbv_NXp72PLADS=h7p7KyLCW1gRCbywESfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] amd_iommu: Fully initialize XT interrupt message state
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sarunkod@amd.com, 
 pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 23 Jun 2026 at 01:58, Alejandro Jimenez
<alejandro.j.jimenez@oracle.com> wrote:
>
> When IOMMU x2APIC interrupts generation (IntCapXTEn) is enabled,
> amdvi_build_xt_msi_msg() builds an MSI message using the relevant values in
> the XT IOMMU General Interrupt Control Register.
>
> Initialize the local X86IOMMUIrq structure with zero for all fields. This
> ensures that X86IOMMUIrq fields not set in the XT register (e.g.
> msi_addr_last_bits) are initialized before x86_iommu_irq_to_msi_message()
> consumes them.
>
> Remove the redundant 'struct' keyword in X86IOMMUIrq irq declaration.
>
> CID: 1660056
> Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 0d273fd33d..9005dc7aab 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -195,7 +195,7 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
>  static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
>  {
>      union mmio_xt_intr xt_reg;
> -    struct X86IOMMUIrq irq;
> +    X86IOMMUIrq irq = { 0 };

This is fine for the Coverity problem, but you do also need to
get rid of the bitfield-union as a separate issue.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

