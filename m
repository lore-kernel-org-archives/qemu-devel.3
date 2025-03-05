Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2731C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdgS-0000L2-Mj; Tue, 04 Mar 2025 20:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdgD-0008Qr-W9
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:36:14 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdgC-0002PQ-03
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:36:13 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390edaee0cfso3638426f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741138570; x=1741743370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HAe64rY8mxyYwJ2ZVZxPcDZoLAScy5ryafSdW49O8kc=;
 b=VNTxqMLJFGMNjPk1bCfUfCDN2WN1n/3y4y3IAhV4MDPnIf+hNwY4P//CXpH836smTo
 K0ywxG+onMfEA45Fuqlprl2xNBmcuw10OkR8FrTgMDoNsz9UFFGfUJzQwgwwqOGAhE4T
 UwjktWlxLL84MwZCuqRkJDEXJC5EOwR1DSmusZX/BtFQmt7/1qw5HorIgIR4dlZDZ7de
 BF3nkr5oR5/K6rh7FKtsV/lwS9PhqZjorigI9dMCeEiTNpamorNucNhxJZBkakDcP5pK
 2y7N2zvPTljYoEAIJwU5A/MBMd31NV777zewQfr9xPBGH0JNajx7Je76NgXG/p1uH4pg
 Hz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741138570; x=1741743370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HAe64rY8mxyYwJ2ZVZxPcDZoLAScy5ryafSdW49O8kc=;
 b=CZDIig2dFIO64J8zVTfvagXKhc+44rfzldjZRIGhQSilun7MJ1BQR7JM4kFCVLAyww
 qEm0EuAKV3fD+EadJDJIyQMVM4irJGl6bgh+uEN/G0XotcR3kYUdgP0w+tjJLKcCi5HE
 qeMUi7RD+CEe23iJVpDz80FSJ10gDkcGSRoGeTUASen8mYLUNUZg4ZW8EF+SWsRrpGpO
 HP1JhsNZAKgjjTlt6wxuidqdJoK4+jHkJnxP+cFAe9rSx0+XKMpVxUqWd3ShFsOi+iMs
 mtCLbZW68Vs4I3SLYO04MzG5jFCd5j0vxQyAms/11Pc8z4QRa92qf4QmC9yXLW2zSh6L
 IWzQ==
X-Gm-Message-State: AOJu0YxCC2Z4NKSYEsV6IFaYI0+fVG97cR/enwqPHZhp/tPhWarvKoIv
 quqsXry+iIdrk2Tw52lpT0ZlQ6Zn9vrD4FAjBX+UxgZ8GAuWdGd3j5UPm8cYhaY=
X-Gm-Gg: ASbGncsoRfQejUz193QKrcal0bC96BSIF4of/pTHJVPdp0ZCMa2OKAZJVxp+WD7/vUp
 c49Zt3Frqlo471Q5s5IpfJ9jqLQ/8Rh/x7g8NkS880bDQ7RFbVdq3FvzUYXoFlyEN+cppQeWIlq
 I8e0fac4sTxXXNOxd10L3anTsiVEAaKE0x5VUqZ2RJtWWkQgDkLOIRLrLpR8v1turDInMXDb/ON
 apoY55REBBqNSfaQweB7rEgZg9qxDGb0QXrqfviL7UR4Bh0o+T3Lv0MLMreh4rW3vYwBZKYGcPF
 qLSvmdfxKkQYUa8+6Lqvj83ZlzLmR0QheXWADUAodwS5vrgrhcxWJu+1olWs14vJDBmJbE09O/m
 wAJ9TpJuLBW+G
X-Google-Smtp-Source: AGHT+IEUQFgwkvdJ2PX/3pDegTBZ/Jyx+d8coetDL47fxXXfwdwd4UwT7puLQjv5KAEaKu3PD6NNqw==
X-Received: by 2002:a5d:6da2:0:b0:390:ff25:79c8 with SMTP id
 ffacd0b85a97d-3911f7359cdmr608425f8f.20.1741138569994; 
 Tue, 04 Mar 2025 17:36:09 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844892sm19427104f8f.64.2025.03.04.17.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:36:09 -0800 (PST)
Message-ID: <19ec9924-5011-4bae-945a-2442f518865a@linaro.org>
Date: Wed, 5 Mar 2025 02:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/11] qemu: Introduce qemu_arch_name() helper
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-11-philmd@linaro.org>
 <774c4a7a-c8e0-8bb2-0e40-a34886fcc7ed@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <774c4a7a-c8e0-8bb2-0e40-a34886fcc7ed@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/3/25 02:32, BALATON Zoltan wrote:
> On Wed, 5 Mar 2025, Philippe Mathieu-Daudé wrote:
>> Introduce a generic helper to get the target name of a QemuArchBit.
>> (This will be used for single / heterogeneous binaries).
>> Use it in target_name(), removing the last use of the TARGET_NAME
>> definition.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/qemu/arch_info.h |  2 ++
>> arch_info-target.c       | 34 +++++++++++++++++++++++++++++++++-
>> 2 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/arch_info.h b/include/qemu/arch_info.h
>> index 613dc2037db..7e3192f590f 100644
>> --- a/include/qemu/arch_info.h
>> +++ b/include/qemu/arch_info.h
>> @@ -46,6 +46,8 @@ typedef enum QemuArchBit {
>> #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
>> #define QEMU_ARCH_ALL           -1
>>
>> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit);
>> +
>> const char *target_name(void);
>>
>> bool qemu_arch_available(unsigned qemu_arch_mask);
>> diff --git a/arch_info-target.c b/arch_info-target.c
>> index 61007415b30..9b19fe8d56d 100644
>> --- a/arch_info-target.c
>> +++ b/arch_info-target.c
>> @@ -24,9 +24,41 @@
>> #include "qemu/osdep.h"
>> #include "qemu/arch_info.h"
>>
>> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit)
>> +{
>> +    static const char *legacy_target_names[] = {
>> +        [QEMU_ARCH_ALPHA] = "alpha",
>> +        [QEMU_ARCH_BIT_ARM] = TARGET_LONG_BITS == 32 ? "arm" : 
>> "aarch64",
>> +        [QEMU_ARCH_BIT_AVR] = "avr",
>> +        [QEMU_ARCH_BIT_HEXAGON] = "hexagon",
>> +        [QEMU_ARCH_BIT_HPPA] = "hppa",
>> +        [QEMU_ARCH_BIT_I386] = TARGET_LONG_BITS == 32 ? "i386" : 
>> "x86_64",
>> +        [QEMU_ARCH_BIT_LOONGARCH] = "loongarch64",
>> +        [QEMU_ARCH_BIT_M68K] = "m68k",
>> +        [QEMU_ARCH_BIT_MICROBLAZE] = TARGET_BIG_ENDIAN ? "microblaze"
>> +                                                       : "microblazeel",
>> +        [QEMU_ARCH_BIT_MIPS] = TARGET_BIG_ENDIAN
>> +                             ? (TARGET_LONG_BITS == 32 ? "mips" : 
>> "mips64")
>> +                             : (TARGET_LONG_BITS == 32 ? "mipsel" : 
>> "mips64el"),
>> +        [QEMU_ARCH_BIT_OPENRISC] = "or1k",
>> +        [QEMU_ARCH_BIT_PPC] = TARGET_LONG_BITS == 32 ? "ppc" : "ppc64",
>> +        [QEMU_ARCH_BIT_RISCV] = TARGET_LONG_BITS == 32 ? "riscv32" : 
>> "riscv64",
>> +        [QEMU_ARCH_BIT_RX] = "rx",
>> +        [QEMU_ARCH_BIT_S390X] = "s390x",
>> +        [QEMU_ARCH_BIT_SH4] = TARGET_BIG_ENDIAN ? "sh4eb" : "sh4",
>> +        [QEMU_ARCH_BIT_SPARC] = TARGET_LONG_BITS == 32 ? "sparc" : 
>> "sparc64",
>> +        [QEMU_ARCH_BIT_TRICORE] = "tricore",
>> +        [QEMU_ARCH_BIT_XTENSA] = TARGET_BIG_ENDIAN ? "xtensaeb" : 
>> "xtensa",
>> +    };
>> +
>> +    assert(qemu_arch_bit < ARRAY_SIZE(legacy_target_names));
>> +    assert(legacy_target_names[qemu_arch_bit]);
>> +    return legacy_target_names[qemu_arch_bit];
>> +}
>> +
>> const char *target_name(void)
>> {
>> -    return TARGET_NAME;
>> +    return qemu_arch_name(QEMU_ARCH_BIT);
>> }
> 
> Why two functions that do the same? Do you plan to remove target_name 
> later or it should just do what the new function does?

target_name() is a no-op for current binaries, where one binary include
a single target.

The "single binary" will include multiple targets. We plan to symlink it
to the previous binaries and use argv[0] to mimic previous behavior.

