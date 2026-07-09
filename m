Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78923C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 04:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whg5r-0007cz-9F; Thu, 09 Jul 2026 00:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whg5i-0007cV-MJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 00:10:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whg5h-00055W-3z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 00:10:26 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so2584546a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 21:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783570223; cv=none;
 d=google.com; s=arc-20260327;
 b=nds2Y6AgkErSaHCQTMigasBxhJORqvXJaNb39I5Du9Vj+yBcn17GDqgpSyWTsZieQR
 4LntzAz7NVKzwfs2twRHCo/m+Kvj2+03p5XiX4K4a0CsQzIeXLS969l+AJ57lQaqQDwl
 9PBAU4MNTFKhfYH4cVnNBkQbI+SzyfuSFYSO0i6/wD5UfH65aRq+qZz2ZBZPlMdcshLx
 OGARYTSvDAPyx6o0IrWkYTtMk3i2Sv5uE3epLS6boKY0Qni3giUeJYmO/Kk8Eo1Ln1v+
 MSG8mNvmUQJep9oLNcRgQ6CQiry4DXtcmxPIhdwcXjmk04DxsbPkWmTaVw6uLGf7YNmG
 XWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dpzQuBKyGdg5EcK/lIOSzea7B50CLOo74uMhRoPTEKY=;
 fh=7zAs7d6ZtgFxUXQ6/BO45gKw70YnIpkeHsbJqXS0/ew=;
 b=dmAE2OhcXpft0I/FxSeTaP8MuJxmv0hzUp4yhAHbkKsuPFSb4jtLMpyp67hLDc/TXd
 13dSVUazzD6OmhkxwynlgR0VrivVFu8yYDy1USVJ5JEMo0QtIleFU8VoorZ6fOOBPwpr
 AmFh0MNW6XKWMGrdl7YmftPG+MvMkEInvqmCfRSg8RUX6FEpTavw49iF8BpHY2d2yvtu
 4daJVHtg+UUMU1SePHn5vokQ4QDLDxyyvhF9tCz8WLXDdXktuRe/0vaSkQs0s1w6oqWC
 5HU3ZaIQlsu8EzUrPwYThEMLpwzYkVLjxYQgJ4Yo0bHP/dHVwSRT8Rz/damqhFoyqgET
 4MvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783570223; x=1784175023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dpzQuBKyGdg5EcK/lIOSzea7B50CLOo74uMhRoPTEKY=;
 b=ABpHFd3gWVskojeKH/qJEof8c8Ntwr1IL03Kx77UFg6OH5ZGoelX1D25TOzgPmbY/x
 z7Irn9uwU29FIzurWjQbN/AsiysM0Stgy134DEos+6GTVabu5s2vtePbzZpRwg7vS5kx
 TdaAsYAE6ka8rNvICD+oujrjDuAWiIvlSCHmKaqWDbGJQd0xvsJe2OzWQ7xx7+cXbYpM
 bkvQsyOnZ3Vl2Tc3FaVQptH7MTqIHrYDyQKTG5GUcDve15hva/TDBN68HfpD58OJlutc
 w2a1phZx2H0cBioVWN2WjrcjVe2GSdv5lpM5sJfA4tp8hiIaekrVEWlnCYRiv1JubeQT
 s4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783570223; x=1784175023;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dpzQuBKyGdg5EcK/lIOSzea7B50CLOo74uMhRoPTEKY=;
 b=eEhE8RURG2mMKwShnRRtqYWxk0bqO4jIN1q/vThLvvRL1ggAUKUiTyK+yTDmxp5XpE
 c0KjSE4f1+6I4ZSGfS+LUz7jZItjC0OQIZaKxjjFG8QygkltILV1FR9y6glLqT/dn1s1
 egpNF+cF6gLs4GCqwe7sE/aw8zH2+QWRY/iKRJuvktu58KVL6+afofDs76komu5WbYCG
 WkKnCwgksBixA6USmpKJ6nWeRLFIoJnxbkR0uFpPs3K1loIUA9OKdsC2c8KXZLiV8F/i
 9b57sb3YsV5I+9EV+XfAyn18BbXnPawSKYNcknfKnW3jQD3vnVnt7h4u71P7iyVUNXtu
 dGbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMcT5VXqCYN5ZIrgF82Q70OPWwpuspzoV06oembRXIq1RQxMo/w/HPxYuTl0x3OjXwTlBFi6JQypcf@nongnu.org
X-Gm-Message-State: AOJu0YxUeJ3X0e+xafxSnpKOxmeuRGzVpudLqlUD2tkowfPNOwUuk7ZU
 sSyYcwO0lwVSIZ1fZ0aoIjM7v5NSuUU8bIymhWeCGx+M2TYJrSgeArfedtDR7cxaWSnlKb90ums
 BkBAcN7+EixPYwz/mqqkmqqdfb0c2lg4=
X-Gm-Gg: AfdE7clRp9H5+NzUo2JJkFVJNNll3/VjnC6sy2zCeoo0jsd3capgUjayDf3TBIvTgPv
 OxiTuyg/oEl4nIG71SUrmJoq+e/rZtZ1eV4i4e76VoMmzyH/gH11zYd6BklWKqOWFRLnTjo1+pq
 mdbfl8kj11/B5Yc6w+zfPJ7XVmeBzWawDIPPefiEE3H/ZXOTh1h92RrRPTmFyqSQ4G1K8Wfxwqb
 3x+jUvo1Qjv4XiRZ520ySXV+0IAneASq1mKPQCz/RxhWuBQC6BQXTfgzhSrOHYZ1v77guAJtHI0
 net0tG0AiGaXFfOwi2RiddPcGfk=
X-Received: by 2002:a05:6402:254a:b0:69a:b407:608a with SMTP id
 4fb4d7f45d1cf-69ab445e328mr2227138a12.3.1783570223381; Wed, 08 Jul 2026
 21:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260707072610.403595-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260707072610.403595-1-wang.yechao255@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 14:09:57 +1000
X-Gm-Features: AUfX_mwdaBMqu56Uw8Ay-i_wFnOSfuIB1K14iz-k3Og_8gQfzi-ILVJEDpEmC5E
Message-ID: <CAKmqyKMkMsAiAetyZ2Rcs3vrkOfiJGfzVTOSAp2G9aMQG2DcGw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] target/riscv/kvm: add extensions after v7.1-rc4
 update
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, Jul 7, 2026 at 5:28=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com.=
cn> wrote:
>
> Expose zilsd, zclsd and zalasr.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index dcdaf7f2b3..e2c6a4b3aa 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -303,10 +303,13 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
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
> 2.27.0
>
>

