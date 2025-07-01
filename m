Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6602C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWY4U-0001Lm-Th; Tue, 01 Jul 2025 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWY4U-0001LK-03
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:18:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWY4S-0005tD-4O
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:18:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso35481965e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751365113; x=1751969913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LgnNOEMfhdY9VA8lAzP/UAe94NFoAHcMOH8/TPKyiSQ=;
 b=PHLeUfu+JoNqdgYbn6H+aU+3kpta+Qr9CyVDN0Zif5BHCQiejhfcf2luY4j4k/Y14o
 mS7A0XPesY39XIpYc+HUmj3PT6A0nxYXi/kwxVfa+fjZcS9clperZvSliWTKwGEo/g3h
 n31uh5jK4LvNBpYFc2rMq3pj/500Pq22M8R/xr9+ud9eItdxF3Dvsm3Z6Swy4RHAj0h6
 aQ9x33MPWCjwtzTyWzdiZBhQwET40jbz7UZmTrBIwjU7A/4Q08VePJ/XPYQdZNlDCRAd
 kPjpRw627TxqFQiiAFG3MNSBZ09KdF778Cr59DFs1pkrxACBuh1Yq7ije3jyGg2xFYwB
 7KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365113; x=1751969913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LgnNOEMfhdY9VA8lAzP/UAe94NFoAHcMOH8/TPKyiSQ=;
 b=Coa1i76FjM+cKAWlKCsoLWljbEwokDxLTJCs/FhH/wlepqyqK8ij6ca/9Wse1+Tfu/
 5xTBQHn/nZO9ilCAtYw0s46SLJbjVH63XXPzBM8D/N73Xmfq8vgpaaV++ZI9kTCdPCo2
 0nxVnouOecvJuQKtxDIm7i70Fo9HhqUWMKQ4FzS0+oBKTkNarTgQmx7V8N29CPJhL3QJ
 kR86llN/XkY2YiPP+0FB+91sIOM3gVmJ7BrhqDBjX7EwXRY3nGrBgij2pHMQsF4LWpL3
 +Lfq2i1DO3a+Y0uYQjC9b9mrJXn7EwSpfMXVct95gmlBffO31LrncV/jlsLxRE5vlzlU
 K1NA==
X-Gm-Message-State: AOJu0YwwOuLz9GVBkhQ/CFKxvJ7HMetOn6K7KVffKQE+0GZY8vrm4xnH
 b7u1PrCjofq4H0KRyrrPBMv2xm567K2kuOWlEygfYJ694NtNFUUTcpZ/f75VpDOX42w=
X-Gm-Gg: ASbGncsksyYZ+sUmNqBrkc9BAYmtaw3FEEoim8r/CzpCTw2druvU/2v0tZLbZNgzps6
 uBPnbjdyglB8SeJ/5f6ZzLFpQw2167wIBEVS9tGlgs6RpsQ1PDY619jeqVDJxTAVeen44M3SE8r
 1ArTFkQFyGFj/npdDErLUM64IDBI6G+kT3Isg+ZFbPBXM6Ed5YRPDz9C6a8xB2669mIlH6r+p6s
 cPO/tGMPXUaihviBTumAwSzVUHHCwV3xzMiHtE6m0SpKvQ3MiljHET6MDY1wGbf2+foChb998Dk
 4JND5a8A9PUh1EYavmsErL562ytNF3zesOUDJy98yUJQAcFZAcgQL/DmAOKbDB7roaH2A/yxoit
 Ff3n5JKMiSvSuZ79vozC93N/7PBpI8w==
X-Google-Smtp-Source: AGHT+IFb4W5g6wm6z7FzwAQ+UJUscW9Hb060Jxtit8cVodZVpioggdRu95VsxZAIY/qAELeUorDJxg==
X-Received: by 2002:a05:600c:4f06:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-4539002c9f6mr160576405e9.24.1751365112886; 
 Tue, 01 Jul 2025 03:18:32 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c3c7csm190478975e9.36.2025.07.01.03.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:18:32 -0700 (PDT)
Message-ID: <8d09d6bc-0fb9-4717-866e-7b557a4de3a0@linaro.org>
Date: Tue, 1 Jul 2025 12:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] arm: Fixes and preparatory cleanups for
 split-accel
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <CAFEAcA_hD_8XjMU+xdXM6ez-O8xmQtSddFLUA1j4JhstmJTFFQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_hD_8XjMU+xdXM6ez-O8xmQtSddFLUA1j4JhstmJTFFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 1/7/25 12:16, Peter Maydell wrote:

> Hi; I've applied these to target-arm.next:
> 
>> Philippe Mathieu-Daudé (26):
>>    target/arm: Remove arm_handle_psci_call() stub
>>    target/arm: Reduce arm_cpu_post_init() declaration scope
>>    target/arm: Unify gen_exception_internal()
>>    target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
>>    target/arm/hvf: Trace hv_vcpu_run() failures
>>    accel/hvf: Trace VM memory mapping
>>    target/arm/hvf: Log $pc in hvf_unknown_hvc() trace event
>>    target/arm: Correct KVM & HVF dtb_compatible value
>>    target/arm/hvf: Pass @target_el argument to hvf_raise_exception()
>>    target/arm: Restrict system register properties to system binary
>>    hw/arm/virt: Only require TCG || QTest to use TrustZone
>>    hw/arm/virt: Only require TCG || QTest to use virtualization extension
>>    hw/arm/virt: Rename cpu_post_init() -> post_cpus_gic_realized()
>>    hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
>>    tests/functional: Set sbsa-ref machine type in each test function
>>    tests/functional: Restrict nested Aarch64 Xen test to TCG
>>    tests/functional: Require TCG to run Aarch64 imx8mp-evk test
>>    tests/functional: Add hvf_available() helper
>>    tests/functional: Expand Aarch64 SMMU tests to run on HVF accelerator
> 
> Where I haven't picked up a patch it doesn't mean I'm
> rejecting it, just that I don't have time to think through
> the more complicated ones this week, and I wanted to at least
> take the easy patches to reduce the size of your patchset.

Thank you, appreciated!


