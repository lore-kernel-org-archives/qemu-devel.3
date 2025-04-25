Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE70C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KGL-0006jN-Gn; Fri, 25 Apr 2025 10:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KGF-0006gf-LV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:42:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KGD-0006G3-Nd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:42:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so1674318f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745592155; x=1746196955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlA1P3UYiP5nqEUfWorUtHT++/4e9WdbRP9cK6FMuUk=;
 b=R+mVybW0rTUReWqf2P2WvigzUELjf5Sp+OTER0FnNcRVVpH/3OyZE04pAsQjhJxUrj
 lidMoUg2G1oz6AyurCGWULspbeZW+9zo0QxH3csDxh0lhCnkaOmqHzloQvnFB+kyLVMo
 2PYy0gTDxYG7xQYgpGDizqqlZlIdWeicnricI3GvJbjCQa75NT7+If4MK92CpHPQs/uU
 g5lDmVr8hBQ9AQgJeSBaUu0oQap/C8eRTZ27LcE8ZYAY6NPT5QUSzQkukfYp6qjkBgvR
 4g4bVF8M/IOlo3dhrfCBappzQhYYFboVRBQg+jP+X98rb0nStY3S5kEGmtnlElO/NmXT
 1jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745592155; x=1746196955;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WlA1P3UYiP5nqEUfWorUtHT++/4e9WdbRP9cK6FMuUk=;
 b=HQK5zS8OZSLcFRBv6UxB4diBUb+RxYTBz/AtmqzzT7e9KBk4ub2uaFVE+i/x/wrjBo
 L4ArD79xNjruEC2LbyuGyXjmWxkpR1k+MGYaxwX3hC6/oCGKXsckzu1Fj24iZIlZyJE0
 ndmPKxbhYUaSQTmifAIIoinRw7EbVZbyjsYVFf1XClFhC8D2uEGeK+4aYyjBfaec7PiX
 mCbdXZr7nQ4srb0DpYG8fIlOcWRf1Nl8pT3nqlPykuTxvrZfZpzjB5BJXprOcByCR5z9
 CaRupfvYqOIKT/Xha8qEBeq/FV65udYM4XIHA61Addy4Clq3lWZeZDkFLVGyC6WYEN4U
 ogOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaWE2f2Ai+enQGUH9SE3WyLV9j4fcfl8TV08204CIfqGAdEdKj63ADc205vD4XUM394LpsJluE3hTG@nongnu.org
X-Gm-Message-State: AOJu0YxeAHenka/PbxG+3jHlZXvYucbUmlgaiqJ01FraoBWJKP0wO/2E
 txqcbNuI3RAgyS/ISoNe4cGEw/aPw+hA0/ECSoehfIc6XZr5IBG4A2t4iwalWiU=
X-Gm-Gg: ASbGncuiOAY8lXyvpIi0D5E5z42tt3acnNiCi1YsJq0Rl9fJz/4gKo5WBcdw5SQSVMB
 tH+VaMgMWS/ss7DrcuLBpgpxtaAZ1N86Jw8JpT3dfa7L7/3vaozfPJ6TwO+4LMO8lLg0lLVXdlI
 IfGk5MHIbDHerXUjM6YklyjkIOy7f7uts4RQ8/ZaxZ4WMmtbTstE01tul/uZ/y88txgcG31kFK6
 PE7W1oaeY27s1nC6PzHhH8oM05yrThWvtDMfIxoznx4Z4tM9wYUrxN7WKBxKO+tQXU5PLTcn/A+
 Z7ihLD5ReXDTfEQShYmIbBuYGswWl6Px692rMV3EE3YyE6MkPUevn+7rUjnA6ASn4/0H29mgmd4
 PlZvmv+E/LmprsH2BR7M=
X-Google-Smtp-Source: AGHT+IFD+Tgcw+N2OZdydhTGME0xCuO5L6z7HZ4zFveTRLvgao2+spK6go/9aqM1WoC0+B+fZp2JUA==
X-Received: by 2002:a05:6000:40ce:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-3a074e3cfc1mr1917795f8f.29.1745592154971; 
 Fri, 25 Apr 2025 07:42:34 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbedc4sm2502026f8f.47.2025.04.25.07.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 07:42:34 -0700 (PDT)
Message-ID: <ca432cc8-31a6-4b22-81e7-4c620a9f199f@linaro.org>
Date: Fri, 25 Apr 2025 16:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 6/9] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
In-Reply-To: <20250317142819.900029-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi Peter,

On 17/3/25 15:28, Peter Maydell wrote:
> Currently we provide an AArch64 gdbstub for CPUs which are
> TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
> TYPE_ARM_CPU.  This mostly does the right thing, except in the
> corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
> which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
> and which to the guest is in AArch32 mode.
> 
> Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
> behaviour into TYPE_ARM_CPU we can change the condition we use for
> whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
> This will mean that we now correctly provide an AArch32 gdbstub for
> aarch64=off CPUs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index a14c269fa5a..a18d87fa28b 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1694,7 +1694,7 @@ void aarch64_add_sme_properties(Object *obj);
>   /* Return true if the gdbstub is presenting an AArch64 CPU */
>   static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
>   {
> -    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
> +    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);

Unfortunately this doesn't work well: while a Aarch64 CPU is of type
TYPE_AARCH64_CPU right after being instantiated (not yet QOM realized),
the features are only finalized during arm_cpu_instance_init():

static void arm_cpu_instance_init(Object *obj)
{
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);

     acc->info->initfn(obj);
     arm_cpu_post_init(obj);
}

void arm_cpu_post_init(Object *obj)
{
     ARMCPU *cpu = ARM_CPU(obj);

     /*
      * Some features imply others. Figure this out now, because we
      * are going to look at the feature bits in deciding which
      * properties to add.
      */
     arm_cpu_propagate_feature_implications(cpu);
     ...
}

The GDB feature checks are done earlier:

   object_init_with_type
    -> cpu_common_initfn
        -> gdb_init_cpu
           -> gdb_get_core_xml_file
              -> arm_gdb_get_core_xml_file
                 -> arm_gdbstub_is_aarch64

At this point the feature set is empty, triggering the
assertion in gdb_find_static_feature():

$ ./build/qemu-aarch64 build/tests/tcg/aarch64-linux-user/semihosting
**
ERROR:../../gdbstub/gdbstub.c:494:gdb_find_static_feature: code should 
not be reached
Bail out! ERROR:../../gdbstub/gdbstub.c:494:gdb_find_static_feature: 
code should not be reached
Aborted (core dumped)

I suppose gdb_init_cpu() needs more splitting work. For now I'll drop
this patches 5+ from my queue.

Regards,

Phil.

