Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BAECD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPC3M-00006T-5E; Tue, 19 May 2026 00:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPC3K-00005f-4L
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:27:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPC3I-0002Pf-OT
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:27:33 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so487532366b.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779164850; cv=none;
 d=google.com; s=arc-20240605;
 b=Jhob/I3SV+gRtytuZtlc+xzM2q5Nyq3U2ny3K0eCG3lwMkoTHEDqZqep6fO0ouyqjV
 +2y02I/W/EAx50RZF5ozq7p26s4ToksTNpnvKxO6Hv9fsSerSJZS3aM7qqjuLAf6qFnR
 ImN3YWPY1+JYFHaijsixHt5Xjoj8U0AhiglsK9Ec4rDFF1N4qFgq8uSWGqjd2gllhAyd
 c/yuI/HdDfWa23YfcjizLGctCnPk9BOPXCKF/Wmcy8B7dKJyzkQJktLF1K3dYnE2TkcS
 a5z1/X3wHz8HO9xv3ZHItPSMPbUBRYxoGQYsWYkAFvkEVYqT3ZkUdwqRQdDS45eDaJUg
 OVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TjFXhCAGi6WMtc7uN4XDfO7NlItni8XmUJta/bwbuds=;
 fh=FNKFpuGENTOT3onTjSYMGTyEfekA6ETsKMLYhf2WhX4=;
 b=ZBn1y/US2tRzOK94/+bWtLaalO8Sk0rxu2KDY+b+9+EtXVAihptO3UzbIpoMHlttwm
 XKR6voIjVVJqsIyn1HpYx4Issf8F5EM3Lvvn9xgANT0Srmghl7LI8nLvisMdxmjxsPHI
 O0EXP6vFxATNrS0gxqRddXEi25+wlzVZ1lkhqNDO9+t/5noUBn3uRM20637XEJHsbsQw
 +c6LvNTJIPXqqXRubeB25u7k3L3fLezRmoyrF4aUlpR0tF9rO4fB2Xc9yry0VBKRg9Ez
 tjX2IDjZM70wFUM9wBn4Y3lPfuKuc+Aiov9YGWHV218OjOtUhkX9sAO1ZzfbQWf/iqs/
 O7+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779164850; x=1779769650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjFXhCAGi6WMtc7uN4XDfO7NlItni8XmUJta/bwbuds=;
 b=IJQ3FCdTb1DYbssaXya027SaNq55SFSGX49pMWeJWddGCKo6Hm0ExI9gGM5TXEzBqu
 al6NGaje1JTq2Nxc12tmXTEn5mw5it+DgkBKJX2yTmBvz12lgbGbsy5qklLT4ZHfI5vp
 B77pJ1SBIVrUp7oqACkAssCZ9VgkCHWA9rktyA6Ja+ylGYvrurCABodiOnRHT2joJeN2
 0LbFno4ofJ0YETIJOntWKZlxd3myBaW/peIdhj/23nsZyQz88HIyl7+0hN4u/2PKJN5Y
 32VZXWAoYBiDehoXNnRo5jzusqfDPD7Do9EOBpv6mq+DCvvbBrlowq+qrYDswIJEUo1Z
 yEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779164850; x=1779769650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjFXhCAGi6WMtc7uN4XDfO7NlItni8XmUJta/bwbuds=;
 b=KhvouPOfZzFoOpwSxwKSi/UPMGIDGeZ8pDbqTWlEZUPqT+t5XXZNSmNpT/a8x37T/C
 8o7gBU0YUhESpI/MIHGlBDXqXZQ26AhWl1Tkrj9xBoMSsl+iva9JyT55VyERCLJ4uVt8
 dBbbHtucHLKHPa4ZS17YTyn8gbD+ExNDVlFCvQyhccBnVu6gYRYlLn3d1PE7MYLFsYNZ
 25susccvjKiBQrDWwpm0hJ9nsIYW7C4rpF80nnA+NIl89QpL4TbIhNlBzXDq/JogNA9j
 5iBQhzuw5YoUoSwLJXayAt0UFXj8IabBnGnk3b8RIXk+sjUpb+QKnMCjt/SSHySSwfze
 HHGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LMD8qOrDaQuaYaPmDZlpUQPxOZlli1rBGLAtcMaChy5YZwdmshPFrJOO4JhIptEZ3SXg5Xrb/5vmM@nongnu.org
X-Gm-Message-State: AOJu0YyGR3h9CvLnLoIjORGLlNH4HzvQyJUbirlDZ7zdCR8RfiTfRaCU
 4ym5ccXiuPFbeQKYajj7F1u7ei9JTsSLgIKRG+Gfq9yHiaOazwxUZCDcrX2pAoqxpRNcPHEwBcj
 lLfss4tifqOwakt4mQoYw8lbfULRvuPg=
X-Gm-Gg: Acq92OG9gPnp+mfupFXUJTmnrHVKMLTP+IXpiBCHL5v6EYXPlFIckMsPg826mSZFqJc
 RbA7ieWMA5uisbF18nfbnVLZI3icNGrHjIrqplYrJaAob5mmNog4ZADU8L84Pj5adWQ95sTxYj1
 7DNZx9fBwst2t9VmMDdG0X7BkZSbWCWNYwclIVV1JlJZEEmjdCSFIv0ZfPLwDlZHome+Uze+U9K
 m87gMnP8gUlmDYxhrcNDIItpgvfc5k1IBcRM9yVpNk1whrKX6fb5C4KIX4B955hv+Ko+F05v/eC
 oKrLw6xpnWyVsiC3m0anUJxzhH0ztzL5qPU+rg==
X-Received: by 2002:a17:907:1c23:b0:bd9:b8c4:a6fe with SMTP id
 a640c23a62f3a-bd9b8c4acd3mr561966b.8.1779164849385; Mon, 18 May 2026 21:27:29
 -0700 (PDT)
MIME-Version: 1.0
References: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260509074941.99295-1-fangyu.yu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:27:03 +1000
X-Gm-Features: AVHnY4KEb0hR53rGA_uCEtDPlyRnHlOOt1ObIq3ZTVbFGFKNTZcwn5Vq2she00o
Message-ID: <CAKmqyKMRM+4i-qGRpS5Uj4+3ToKbAAbBsz+p44+uRh17xCUsag@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix IOCOUNTINH.CY toggle detection
To: fangyu.yu@linux.alibaba.com
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, tjeznach@rivosinc.com, guoren@kernel.org, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, May 9, 2026 at 5:57=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Fix IOCOUNTINH.CY toggle detection by comparing normalized CY bit
> rather than XORing whole register with boolean.
>
> Fixes: 2cf2a6c027ba ("hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index e8d284ac8b..5bf80a8db9 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -245,7 +245,8 @@ void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState =
*s, bool prev_cy_inh)
>          s, RISCV_IOMMU_REG_IOCOUNTINH);
>
>      /* We only need to process CY bit toggle. */
> -    if (!(inhibit ^ prev_cy_inh)) {
> +    bool cy_inh =3D !!(inhibit & RISCV_IOMMU_IOCOUNTINH_CY);
> +    if (cy_inh =3D=3D prev_cy_inh) {
>          return;
>      }
>
> --
> 2.50.1
>
>

