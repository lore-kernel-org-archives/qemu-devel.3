Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCD1C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDu-0005UI-NI; Tue, 08 Jul 2025 16:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDq0-0006Hv-9g
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:18:48 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZDpw-0007y7-Qq
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:18:43 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7d9e2f85b51so135794485a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002319; x=1752607119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BSCjWCQ3lstbi0ZSjiMsYNzLX5vOS9M39IJn1ihn56g=;
 b=jYuu5p7QKHg9aqA74SLvQSkoSiWuWa3NXKwyFcPLH3cPvfNIQIZPSkZIB2J710QB0n
 i1iq2fVPdCnSYOlXpoHd7u5Qv/JNnog4ckRiOmMw56PRtMNb2FgovD2AvDWFoSXpzrNb
 03xu7JdEuDPX2HDwt601eVkPus4VeX6T8z9Ib6KPprR5WB3Uz5IYw2zxWPwEOaW6CpMs
 cz3k7nYgbVuE2oCdDHdfqU8KsdpYuZ9g7K/CPHQwS4JlVwK1w4SPRIoGnmAErpiBE6CE
 mE6sTSVDyz8Vmdw2nW0GmzwiPVuQhxXjS9pMJVbVRZ7LqAJfgixP4b80uiSM2hTNwMrb
 y61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002319; x=1752607119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BSCjWCQ3lstbi0ZSjiMsYNzLX5vOS9M39IJn1ihn56g=;
 b=ptCSNf2r+LHbX9mYWsQaEX2rsgaenHGXwuXyBo6KWMVz8Cxc2eqw5jRK1KRotPZjeQ
 hTrr2Kmie4Aq4XPzoLP+LNRQ1P/v1+Xu3IkeYPYUGVcq4CpWtFGlzAGnwP7wJMQC20hl
 C2VCdvcG3xpw6EsEFb6q5OSGF7yt/AEfnKMMoj0dR81Pc//nhW8w3lg3F2aRkGyuC2Co
 1RKhL/BdWlUgEeMVXLIr4o28IGjk42tsbmrTEYBwWeWW74PFcP6j20efz3k6697eGQeC
 tSdQKuag6Eb+1FHLOVqGMkRlOsEu/w9zoLfxy3mExmiVc2VDiBkEpQqGuYG9GxuFsyrB
 KBOA==
X-Gm-Message-State: AOJu0Yxhi/Q8NDhAKEddgB0EpgvCTmbzmr2YiqolykM7GvRmzaOp0+Rg
 xmbb+r+0qtTqPv61Q1QOik3poW+tWuYhv48lTeBPhPVlOH4IN+d1lRepFo0Z3rgWcjMEoOGZSvJ
 QRsalGiE=
X-Gm-Gg: ASbGncvulaX9zdg6PVe7fBM3kj2dWPEZ07KUZWg/GcY7vxc2X1l5bFt4E/nzclKiuN1
 LXCIEEsHAySlgJTD0dHLMNjTQylSz3tTYHv6SkvWeoCVlbBU+wAEEYxQb0Z+spwA0rKlWt/BWUH
 4r9DtKuyyGKn6BTKzHG50h5t1N6vJH8eAfJakr4JMSwjz2ZO+/FaoMGDfBvz9HzNypdNweRyJ43
 WDJjggrX/3gThC4cD7jjZGsD/oIMB08ViTX+IuvgaWzae7GL+GlDedXzHsqRghL+EylPzyQtBFz
 DYGgkqFhKOihhKCedkgO1vvL2/TbSFWoHyvhf+Q5qzFJU386tWWGhYNIWt8+qMitpvUGmV318sN
 A52HyTJie
X-Google-Smtp-Source: AGHT+IGnx7vNPNXhsSPNERl4kCLWlLCEEZlFIkZ0Q3fv/qm/kJgxMysk+IDcIlMyfn9t3TGARummnA==
X-Received: by 2002:a05:620a:2942:b0:7d4:4c40:8e02 with SMTP id
 af79cd13be357-7db471203e7mr94642985a.23.1752002318934; 
 Tue, 08 Jul 2025 12:18:38 -0700 (PDT)
Received: from [192.168.0.102] ([189.110.24.38])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4cc7588sm80589376d6.2.2025.07.08.12.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 12:18:38 -0700 (PDT)
Message-ID: <09f3447b-4ca1-4eb9-9fb7-6e9fcdfc2857@linaro.org>
Date: Tue, 8 Jul 2025 16:18:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [WIP-for-10.1 v2 5/5] target/arm: Advertise FEAT_MEC in cpu max
To: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
 <20250704151431.1033520-6-gustavo.romero@linaro.org>
 <af3c8b1b-63e0-43bf-8d9a-6c6bf699fa97@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <af3c8b1b-63e0-43bf-8d9a-6c6bf699fa97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x72a.google.com
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

Hi Richard,

Thanks a lot for the reviews!

On 7/4/25 19:56, Richard Henderson wrote:
> On 7/4/25 09:14, Gustavo Romero wrote:
>> Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
>> first step to fully support FEAT_MEC.
>>
>> The FEAT_MEC is an extension to FEAT_RME that implements multiple
>> Memory Encryption Contexts (MEC) so the memory in a realm can be
>> encrypted and accessing it from the wrong encryption context is not
>> possible. An encryption context allow the selection of a memory
>> encryption engine.
>>
>> At this point, no real memory encryption or obfuscation is supported,
>> but software stacks that rely on FEAT_MEC to run should work properly,
>> except if they use the new cache management instructions, which will
>> be implement in a subsequent commit.
> 
> You really need to implement the new cache instruction before exposing this feature.  Like other cache instructions, the insn can be a nop.  All you need is the accessfn to trap when EL2 and !SS_Realm.

Got it. Thanks, I'm looking at it right now. I'm sending v3 addressing your
comments here and then in v4 I'll introduce the cache management insns.


>> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
>> index 611d7385d8..14f17febe2 100644
>> --- a/docs/system/arm/emulation.rst
>> +++ b/docs/system/arm/emulation.rst
>> @@ -89,6 +89,7 @@ the following architecture extensions:
>>   - FEAT_LSE (Large System Extensions)
>>   - FEAT_LSE2 (Large System Extensions v2)
>>   - FEAT_LVA (Large Virtual Address space)
>> +- FEAT_MEC (Memory Encryption Contexts)
> 
> We probably want to document that this is a stub implementation.

Where exactly? Maybe just below:

When a specific named CPU is being emulated, only those features which
are present in hardware for that CPU are emulated. (If a feature is
not in the list above then it is not supported, even if the real
hardware should have it.) The ``max`` CPU enables all features.

or ?

Can I use the term "stub implementation" in the docs?


>>   - FEAT_MixedEnd (Mixed-endian support)
>>   - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
>>   - FEAT_MOPS (Standardization of memory operations)
>> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
>> index e6a731472f..009618fd9c 100644
>> --- a/target/arm/cpu-features.h
>> +++ b/target/arm/cpu-features.h
>> @@ -603,6 +603,11 @@ static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
>>       return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
>>   }
>> +static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
>> +{
>> +    return FIELD_EX64(id->id_aa64mmfr3, ID_AA64MMFR3, MEC);
>> +}
> 
> This test (updated for master of course) needs to be in the first patch, because you're using it in the implementations of SCTLR2 and TCR2.  So patches 2 and 3 don't build alone at the moment.

I've moved it to the first FEAT_MEC patch, thanks.


Cheers,
Gustavo

> Alternately, implement SCTLR2 + TCR2 without *any* other features which would enable valid write bits, and then add the MEC code here.
> 
> 
> r~

