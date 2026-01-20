Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA983D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9jv-0006b0-Go; Tue, 20 Jan 2026 06:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9jp-0006Zn-GJ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:17:33 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9jn-00054X-TO
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:17:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-480142406b3so27370185e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768907849; x=1769512649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VO9eaYxTpxD9tjjG4lo+9Z3rY8GSxmLO5GHzDjby7Tk=;
 b=PSn+V1EdA9udgwvTQAQQpl/JWIfHjK3lpnNBYnnDEOHmrOHeZgpYNK1zLHgSGd8jfN
 5NA7dV8n1yEk5ZT53HOhNvHbvfcfWAQGFt5zb1kXoPtfiTm1cHlDfrYYnciACfpA/Zbd
 sqeoSBqDqMZ+uAUOoA2jKBsSw0/DiI2EvxKfUDtlt7zV5n+apZtzcC/DV8vdXSvWJYsB
 DleSgBMlUoMwmy62SIkEaJegbWQpTIsFM1LJW9kdGrxjriL7r9Qg6rgsMYQ7CbJDStxR
 MGLbCRj74kRPLxZmJ0MTrLAlynZqKMM94waXvPon74oamKP9yJfJUYJZx6I3BJepCXqt
 B80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768907849; x=1769512649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VO9eaYxTpxD9tjjG4lo+9Z3rY8GSxmLO5GHzDjby7Tk=;
 b=rY7yO2BXBLsaqM9xvacDM9mHit9J6GjGOtDhppw33SulHsjQR9StIw6SJhX9GvMIoE
 ef9/8BVvd5S0ljcP5eic1ofUHu2XZYbpTSL8zC+737uQrPM87JQl88SmgY9cuRJxoIqK
 4yH7mgXqSs1ZSPCM04JVCz5xn5mNIcY2Dve9BzBEmXQSTs7GdHEV9xVbbBcizdq+fVhO
 miokXUqLbavKD0srdmCXCaVHipvp5peXv9T/TR9moN+MozjBZmXGsgn3aE47nCh8rgqX
 THyW8iTfIcb2UpuRM4g5Bf9m4R5ylIobubsfyeEiztm/aq5oDV3dmIKause0DqshSz7f
 gewA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwatsuslOAKZ0Ivy5VpVyaTK0A53dravQ+6K5issxHtKA5Lw7sveDQk/ZOcvoHWcoyIfgSnY8LxG29@nongnu.org
X-Gm-Message-State: AOJu0Yy28ESE9NoJ1C+uzKZOkyV2v58kcnX/cZCqoniOQWlRTpwqdBJP
 C43W2Azkt4tDxIzh+DpueXt/RLz/h1QY5Lul7hVg55WDP/jemsQ0AF6gfjfetivo1Ql6/AG3Tnj
 rztHnQeU=
X-Gm-Gg: AY/fxX4kml2yEonKpP4pBK8E8wNerEtsvvyXAJlEACl7uXbnsLZhRHKDqaShUkSG3jS
 ootsFJuy24BxTFpNzaOkxPFTquRxrNcWn2pXF8TG5C/upVsd8kFkb+LU4nAwipavtQw3kGEdbfP
 LBjqRsgxqi7dpwq3pOQO1yqQz/6BYhIuLqkkCbPWzwJ12YJqCZEt3wCjCLLhFY+9+yBldnftvmd
 IyyLVp81U6jc4yqd2C2IRJ01vfli/cqcqdqLK4h6qMgMAIjLQQndc+8Y+0KQhljTyB6mcxtpzcG
 53LV8n9RQ3OLPn28RsV/Wp8dKL4nkZzJQz6b4pAWGgCNL5WaOS8IhcGx8RogGjXLk4sSpkUnDYI
 pDNHDzFTScT+n8kzl+ICVX8EZ56K47PdNWHhmpdfkhGTW4h0JjIZfEGZlJQs4Ozht4Nk+5PkxSr
 WlBUa+mKr6oz0PDx0HKJUB1C9kxU34PlNmVA4kSPNT/yxb4MNBF5PW4g==
X-Received: by 2002:a05:600c:a399:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-4801e345c96mr145015545e9.27.1768907849193; 
 Tue, 20 Jan 2026 03:17:29 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm304260535e9.14.2026.01.20.03.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 03:17:28 -0800 (PST)
Message-ID: <94f88409-f693-455f-9baa-34feaba3dac9@linaro.org>
Date: Tue, 20 Jan 2026 12:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/26] WHPX support for Arm
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:

> Mohamed Mediouni (24):
>    qtest: hw/arm: virt: skip ACPI test for ITS off
>    hw/arm: virt: add GICv2m for the case when ITS is not available
>    tests: data: update AArch64 ACPI tables
>    hw/arm: virt: cleanly fail on attempt to use the platform vGIC
>      together with ITS
>    hw: arm: virt: rework MSI-X configuration
>    docs: arm: update virt machine model description
>    whpx: Move around files before introducing AArch64 support
>    whpx: reshuffle common code
>    whpx: ifdef out winhvemulation on non-x86_64
>    whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
>    hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
>    whpx: interrupt controller support
>    whpx: add arm64 support
>    whpx: change memory management logic
>    target/arm: cpu: mark WHPX as supporting PSCI 1.3
>    whpx: arm64: clamp down IPA size
>    hw/arm, accel/hvf, whpx: unify get_physical_address_range between WHPX
>      and HVF
>    whpx: arm64: implement -cpu host
>    target/arm: whpx: instantiate GIC early
>    whpx: arm64: gicv3: add migration blocker
>    whpx: enable arm64 builds
>    whpx: arm64: check for physical address width after WHPX availability
>    whpx: arm64: add partition-wide reset on the reboot path
>    MAINTAINERS: update the list of maintained files for WHPX

Note for myself (rthogonal to this work): thinking about generic
accel/ infra we could add these common methods to AccelClass and
get rid of some per-accel #ifdef'ry:

  - accel_has_in_kernel_irq_handling()
  - accel_arch_get_cpu_features_from_host()
  - accel_arch_set_cpu_features_from_host()

