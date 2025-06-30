Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E5C7EE39
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 10:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWBv5-0000IQ-LF; Mon, 30 Jun 2025 06:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWBuy-0000GU-6V
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 06:39:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWBuu-0004IY-2X
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 06:39:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso5047935e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751279950; x=1751884750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aY2ljNQQ7s+olZYdhb6NcXGhl/GbIzPd8ZgET/oFbLk=;
 b=X06Utzbw/9r0VeOS8lx/Oq3rxMrLLUi59e20FlgGWh6bmduIXdb5gO5ouUPCAaicHK
 W2GRaA6DSTd8sV0GYzIQgvKN4R53i/n0bHMq0d4YzR18FcG+EYdNm5wDVkO2eM6lTmja
 dnj2HLJSZfIIqpeC5NDpiSy5KU/Qrf+vC2wElqtX58mGfU/YDjMP6HP7zquIud5YkeOS
 v/ucvmKHuumIjGlMTh8P30dDCBihPQgHGrMiXjyysHiGnRdLNf1Aqi9hsRvJlF6++y3C
 PNJA+zjMxEwBD2OG6gbT3XISRpeWcRGEuH80CIVxA93n3MpB/Kwn8/UDtAseJBQaYOsk
 hqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279950; x=1751884750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aY2ljNQQ7s+olZYdhb6NcXGhl/GbIzPd8ZgET/oFbLk=;
 b=B9R7ZHLoY/5XXknKseO3tOAH6k5W3IRhHmaBH42p5rdRWQgBn7Vm1m5ztBfKmR25Q4
 cu+DJf3N7+EOG2kH1/0B3eKhzMzPtCzxv84ZdK3vUhXm89t+u1tMUWScF7vpXizuXvu1
 0BpVibolNtmF1grZGLWwHQzh3CVwXlaFYrfYpfqOk6aKEp7bhZtxTwIw1eCRTszKP7uw
 UzB9vxSq3qCU2NUymNvExf/vUpbxVuOMd09+98amwncnKdHHdLX2Rzdq9mFGpgO8pBxD
 IZc3kXm5N2kcpNhcmnjOyjr7gBmxjGz9lhaebsvEDRodRGp3QIwNiyrvTHEcfRQDWrEG
 68Gg==
X-Gm-Message-State: AOJu0YzPQo+g1ft7MZKaBdBaPBVmOBCk375s99IAZDkdOm39m6TkznBW
 1FNWj7LP/1snXhAE1Khrmzyw69pLIVvRc4EbdIE8Y+TzHI5vQwKYdzpnTeUBHTCx74LgPiv6A+q
 okRNZ
X-Gm-Gg: ASbGnctGp3VZ36571nx5+2WZEelAfYkWghTpcyo8Bgk1HmTHAXH0VeooKtLFexWpcVh
 wfIkrfx++1VPj2dQGs/kPyr7YphSlk649P+PLk1sF2CFLf1Yzl/uTPPhCCnb6i+U2T8rzWiyAq1
 yP3pBV1a6wuJjvN70MAwGeLA/TgHlf3wKxsD7TXcHnOSCfxY4i1yTsN49VyvzYCVi0WdT45j8iz
 aWW2BNSufug2cWpcqKa33H60HVV7gsG9QereDcLU03uhKP9+LsDQXqzWS3uMHQP9CSymd4BwA8P
 ImgohFRxrnte2oUo/hJulcLnYUBKC35csACb5I3yPX2i+gXyoTN6U82lVjWjGgB9NLQUL3c07Pv
 1WvbBSvcfFqG653fBmNaTyzH7k7+lwA==
X-Google-Smtp-Source: AGHT+IFNhBcdHyj20tEsizIFcK97MLoriVP6w1Dr62XMrnK4u6j3KiXisn9MgQ0GTm/kkt4YtpK0UA==
X-Received: by 2002:a05:600c:138b:b0:450:d4a6:79ad with SMTP id
 5b1f17b1804b1-4538ee6e564mr117965735e9.23.1751279949555; 
 Mon, 30 Jun 2025 03:39:09 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59628sm9858422f8f.81.2025.06.30.03.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 03:39:08 -0700 (PDT)
Message-ID: <14f8aa18-1aab-4e40-9ee4-987793f08a33@linaro.org>
Date: Mon, 30 Jun 2025 12:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] arm: Fixes and preparatory cleanups for
 split-accel
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Ping? (series fully reviewed)

On 23/6/25 14:18, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (26):
>    target/arm: Remove arm_handle_psci_call() stub
>    target/arm: Reduce arm_cpu_post_init() declaration scope
>    target/arm: Unify gen_exception_internal()
>    target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
>    target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
>    target/arm/hvf: Trace hv_vcpu_run() failures
>    accel/hvf: Trace VM memory mapping
>    target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
>    target/arm: Correct KVM & HVF dtb_compatible value
>    accel/hvf: Model PhysTimer register
>    target/arm/hvf: Pass @target_el argument to hvf_raise_exception()
>    target/arm: Restrict system register properties to system binary
>    target/arm: Create GTimers *after* features finalized / accel realized
>    accel: Keep reference to AccelOpsClass in AccelClass
>    accel: Introduce AccelOpsClass::cpu_target_realize() hook
>    accel/hvf: Add hvf_arch_cpu_realize() stubs
>    target/arm/hvf: Really set Generic Timer counter frequency
>    hw/arm/virt: Only require TCG || QTest to use TrustZone
>    hw/arm/virt: Only require TCG || QTest to use virtualization extension
>    hw/arm/virt: Rename cpu_post_init() -> post_cpus_gic_realized()
>    hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
>    tests/functional: Set sbsa-ref machine type in each test function
>    tests/functional: Restrict nested Aarch64 Xen test to TCG
>    tests/functional: Require TCG to run Aarch64 imx8mp-evk test
>    tests/functional: Add hvf_available() helper
>    tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator

