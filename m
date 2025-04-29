Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC762C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9iCt-0004Ot-GW; Tue, 29 Apr 2025 06:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9iCs-0004Lh-45
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:28:54 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9iCq-0006jG-Bs
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:28:53 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so727362866b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745922530; x=1746527330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rOWVjl/1DXK0gZtSfaoRm6OeA5/IKVvn80lwHtioKQ=;
 b=gEsNQZz2UthWLMvwszqqYmpqX9514LN60MaifcauTKV+yXaIYkBRcE71+j3fHG6D6p
 9dIA2wOsvdu3IhFQzZnX8DrdrlSjj3TCX/948E6LpgsQbBTxMjSslyJtDMi43IgBpexa
 PNWj9aQwnwpvtzWXB9rdtulprGe2G9OnNNYTwbDIiVkZTHhl6xFNWoEGGQEEA96OGdqC
 VBtSAB8DXaM6BoxrYzrQ2xNcVn9iom44MJiKVM5j+td3CNWRrBjuQGvkPgAw4xOLSqsr
 prQkmuaAJTcJ6zpapzO5kKES/yqYsq3QIpvPyUb/xF4UTggTdytS6rIC3Kx1+99p2/vG
 LB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745922530; x=1746527330;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4rOWVjl/1DXK0gZtSfaoRm6OeA5/IKVvn80lwHtioKQ=;
 b=FmYJjo5I6gQPgHxzDCyqyVf5OkMuMF69twYE5ywRwjqHhc8hF0x9nwiW2SrffzJLbb
 iPtGYeiik/vVppqXN2VCg0R4HGM0OD8u+b/JO9KAF/DRSGw0YerAe63qCdComMeW6sOH
 wk9mL6/ISSYmS83g10J5iFsG0AmySxampWNmmjBOo7tZMpBWAnUxqp07bCJCizd4zKv5
 aLQP0W8eWnT+26Ile5aj30/SPtEhdlK97A0vpe+Zv4DAIfwtTDDQrEunZbAzDeZdo5D1
 C58y8qrF6912xYqBZSxIWBtYCVUzlT02Ln1DqWPXwPTe25jIqNBNQ2v/UJ2gLuORHNCW
 GJZw==
X-Gm-Message-State: AOJu0Yz/wESw+Tc3oosjMn3/hxDFLqeK/OQpv/If6zLDJHhgyuW+m8SJ
 7P7NA81j/rp007PWI6GtZd/JsATnQaGz1JCL6fE2udayVdmAT++sapwaWMdt95M=
X-Gm-Gg: ASbGncvjG22Sp52bSAn5zwINdpUJ+ostLcWoqOs2THKkm8mt+Doisl/5mCLUKrBiSyT
 aQBh1L0hKghmLGOkNeU/1JLdDesucxUJThOvWFIEOi3gPMTyp6MOGYeLMhWr4efdx/Ma+Xz997B
 qH91Nu5yHaMlUInoUTHXAnUuVPeMbwliGF4YSiZlP6Uw75DscqnTg5/NRQdLiAv2++niCedWUJj
 82MPxdBxJ2DQL+vxsuf3AEgRPWVuQQxOzOsnCoSueXJMzB3zdXKZrMLY7Y05aAp2WmyMjzAqTBT
 TSmSLsJhe0coxRXJSw4CBGMgsKRcbWoGdWJY1aUIcCc=
X-Google-Smtp-Source: AGHT+IEBZUnAyyYT54h37+wjYFYJg0lSj5oXqRABO3XpWGJh41kqGVVuJO5FVEJvP6bxnQODDW7u2Q==
X-Received: by 2002:a17:907:6d27:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ace8493c5e0mr1133416666b.33.1745922530486; 
 Tue, 29 Apr 2025 03:28:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ed49c2fsm752361666b.124.2025.04.29.03.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 03:28:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BEF45F863;
 Tue, 29 Apr 2025 11:28:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-arm@nongnu.org,
 anjo@rev.ng, richard.henderson@linaro.org
Subject: Re: [PATCH 05/13] target/arm/kvm_arm: copy definitions from kvm
 headers
In-Reply-To: <20250429050010.971128-6-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 28 Apr 2025 22:00:02 -0700")
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-6-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 11:28:49 +0100
Message-ID: <87msbz45y6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> "linux/kvm.h" is not included for code compiled without
> COMPILING_PER_TARGET, and headers are different depending architecture
> (arm, arm64).
> Thus we need to manually expose some definitions that will
> be used by target/arm, ensuring they are the same for arm amd aarch64.
>
> As well, we must but prudent to not redefine things if code is already
> including linux/kvm.h, thus the #ifndef COMPILING_PER_TARGET guard.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/arm/kvm_arm.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index c8ddf8beb2e..eedd081064c 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -16,6 +16,21 @@
>  #define KVM_ARM_VGIC_V2   (1 << 0)
>  #define KVM_ARM_VGIC_V3   (1 << 1)
>=20=20
> +#ifndef COMPILING_PER_TARGET
> +
> +/* we copy those definitions from asm-arm and asm-aarch64, as they are t=
he same
> + * for both architectures */
> +#define KVM_ARM_IRQ_CPU_IRQ 0
> +#define KVM_ARM_IRQ_CPU_FIQ 1
> +#define KVM_ARM_IRQ_TYPE_CPU 0
> +typedef unsigned int __u32;
> +struct kvm_vcpu_init {
> +    __u32 target;
> +    __u32 features[7];
> +};
> +
> +#endif /* COMPILING_PER_TARGET */
> +

I'm not keen on the duplication. It seems to be the only reason we have
struct kvm_vcpu_init is for kvm_arm_create_scratch_host_vcpu() where the
only *external* user passes in a NULL.

If kvm_arm_create_scratch_host_vcpu() is made internal static to
target/arm/kvm.c which will should always include the real linux headers
you just need a QMP helper.

For the IRQ types is this just a sign of target/arm/cpu.c needing
splitting into TCG and KVM bits?


>  /**
>   * kvm_arm_register_device:
>   * @mr: memory region for this device

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

