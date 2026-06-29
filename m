Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FF0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 02:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we1wJ-0001BC-68; Sun, 28 Jun 2026 22:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we1wB-0001AK-At
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 22:41:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we1w8-0007Ze-M7
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 22:41:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f95so4835517a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 19:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782700887; cv=none;
 d=google.com; s=arc-20260327;
 b=onb5JhXuIfIOS62sayeVOPiWVj/AVtHUEOqLNb8HkuD3nPhZl4lMpF6vLHE9E1nTLc
 hNkv1zV72hx3gJjeSq1I6TLs/hdmqCWSY0vUlHYRxtKamZFB+jK51KBzA/5p3/3utMWU
 TG9gAozUpTWEsputF9O8plKIX477AflpJ2Ruwf1bA/hc4d2yzJGKG55Hej8Oa00AiQhq
 wCqA4HowpVQLVg3tl49aNKefu6yxA/0F4J80GG/Wg/X7I8PO0z5wnkMjbyb6AZtDJnDh
 Mkc9k7gBuAJvAd9OaWe2pgGt1wnoumpJ/HHuZ14GOZHohnWd6qSGiZbvfmx8CEcrO41k
 ECsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bBv1I/ZO1y/i1zHZqaZCewy9Qr2VDqFLv9ENiF1z5zQ=;
 fh=JXgRGc/KlTGn0KxZ9tReTCjfE6V82C8AZjzHlOeGekQ=;
 b=n5c/7FDGMQXx3Xp2o4g0IqSjiNomOwKmw9shVH22I5tLmHq9Hh7CThHgoH65YNbKXa
 gB48vm8d7ndalI4EmIO14ijnh+kvX4vT6U/R1wj25/B0UOFFjFwS9J+oq0redoNNd0Px
 tz8aBM1T+lPeGywVsUg2FhLgFSjCHdloGWD4zc1v1qXpuAzCueM8bwUak0Dhrm7BEjhA
 eTMN397NO9Sc4l2wSUXNlAcP8+gR2xKdLDFIpc+ggu0QpXHEQMchaBb9uEvKLbZXkYKe
 /idN9KjsHb8DpqWLIPpr401w13kR0YgvuC3A6f0QHU2hOAT5KOklNCIPT/C+vr+jjuXP
 kZGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782700887; x=1783305687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBv1I/ZO1y/i1zHZqaZCewy9Qr2VDqFLv9ENiF1z5zQ=;
 b=OGv93KUPHe75jNVBqM9wGrU4vQQiexXH3ehUY6Yhlosh2pzzgPUROqGSE8RGe0WPQS
 oOXVoUUWZxSuZ7qwToR7sGfGe+l5DtN3WMQ/OvJ7QrEYOZOfLngRMFIBEFyLsrFcazGH
 4aSKMuD8HyMpImOGTpW1FeXsdTq8w1dbgOIx4Fvfo5tb0/zApmhSZ/vYl6Z5WwbiyA0b
 cxcpfJrCvCZtgTRcUZnoRP6+vSCcydqOsj2XjjvXL2KT54+0tFfohDGlismZ9llYnAM6
 JGFcNa6nViaqSO9k23iUhnjoFsKSiNWyB5yVbg5MX4njnHXPBrDPDMPCHL0eHMPIvPXr
 zBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782700887; x=1783305687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bBv1I/ZO1y/i1zHZqaZCewy9Qr2VDqFLv9ENiF1z5zQ=;
 b=cFsqOQQp8lpqNXWamgZ+MmKBj56LBOz78r/+3ryfVVnxNRjqWPpcqyBRfOnhIhst32
 Esrgbqt/u33c3B7y0WkRXXKkBHxymm8egoKJPy+tazgkg2uuodZKgrtdmN3lSUrestFC
 g5ukuTU0Hsqrtgt5ocpnOPTxQrRBvGnvPPGq4R7xeLlpDGp/NbAsmLfE2rmHdB6jvha1
 4q1vkMQJq6no0hyguJRulaoIVQBoUAEk1ia2hVjIwJfIJpLH7Jd+45GqBrw7cfWIFrlK
 O8GVE3/Nm3P63Y+c+VPG6/lcs/hDWB07A8aghQZjDDxVJ2VuYW3tIuPDVV7SLr/K83+S
 l6uw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmfhvofKxrbjPZHfmdlg0Z2WELpVswg/2q4LJ/Iq2T/RaVvKIe48TYg8PIifpS/dISAMRwJWKL7nKc@nongnu.org
X-Gm-Message-State: AOJu0YxGuGR93bnKi4iX6s4KnIrq4eGkYnScEVaKrkP3v+s1nxtN9E9y
 57qQTjjkgawZTaPzLMznjm9gMm3ghx9AEg3eiupRs4KAOY+XKtdeAzgJqYEH/LH9xirTp2eR0T0
 rI+Bq/ZUCWHU1yas4lrHV9IFeobp0Nj4=
X-Gm-Gg: AfdE7ckRo6r9Gch4u1ADkE+Wyxbx6+Dcm7ZcZ5fr3mRRkk5D9XC4RymGzpXOd16goqP
 hqqYvqXI/qjtwKUF8CfJThFbBVel2RKSVmWtWe06JjzyuBP/ToVcsq74ouwiU2V2/5qzJfJq46T
 26ksAMZMhc+02g4QvfSAZTlYe2VHXWjVLS6ycZUNYx6kX7qEW/4BBjyQlKzkn+v6COJJghniFee
 SAfKpxEH/4ZPUrP9P/Dh4Y8v9TI0eUtkMdQDH1hH6tNx2loseQqpG45p2R3EvC4G0BfPna83tnH
 VapevqVCEYh6KDHZRyWNiSGaePA=
X-Received: by 2002:a05:6402:5207:b0:697:560b:f6b2 with SMTP id
 4fb4d7f45d1cf-69810a157dbmr5477045a12.4.1782700887069; Sun, 28 Jun 2026
 19:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260622065717.15386-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260622065717.15386-1-wang.yechao255@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 12:41:00 +1000
X-Gm-Features: AVVi8Cd1PPCiwz-wImhBZ3i32lzdKbi7DkqxbDKf41eQ5lhqgTo2l7_tAYxToOs
Message-ID: <CAKmqyKMhqavLeDj7fy-JpY8WGKO0m_o+94UMPX2sBK5Ldsid4w@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/kvm: add extensions after v7.1-rc4 update
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Mon, Jun 22, 2026 at 4:59=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
>
> Expose zilsd, zclsd and zalasr.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v2:
> - Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> ---
>  target/riscv/kvm/kvm-cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f0de5c3071..707b992d55 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -304,10 +304,13 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL)=
,
>      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINT=
PAUSE),
>      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> +    KVM_EXT_CFG("zilsd", ext_zilsd, KVM_RISCV_ISA_EXT_ZILSD),
>      KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
>      KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
> +    KVM_EXT_CFG("zclsd", ext_zclsd, KVM_RISCV_ISA_EXT_ZCLSD),
>      KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
>      KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
> +    KVM_EXT_CFG("zalasr", ext_zalasr, KVM_RISCV_ISA_EXT_ZALASR),
>      KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
>      KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
>      KVM_EXT_CFG("zfbfmin", ext_zfbfmin, KVM_RISCV_ISA_EXT_ZFBFMIN),
> --
> 2.43.5

