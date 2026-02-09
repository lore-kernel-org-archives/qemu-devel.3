Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D950EE78D45
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMwa-0006rq-Fw; Mon, 09 Feb 2026 03:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpMwY-0006ra-0V
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpMwW-0001EQ-0M
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770626906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4tJ7VHU0pH3HGK5kAFiigHlUOCPbfmrJCTP/PvMv+Q=;
 b=c10YyOFGfIIJRC+nAH9C+1sF+USaVFCP5EIQR6AjE/Ez0oQihBZiXv6DLuhefDEeS2QwQO
 MCrRHh8dJ6wliZmaVHe+vXZ+lied1dJJcy2RFpU3sHFnq2uAfC4qAQXjvsdJUyV0C+NANt
 weFaDI9k4ugt4VBK7Y/RHTBQ1RAZAd0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-qfLRHldQNX6v4tuaZ4NisQ-1; Mon, 09 Feb 2026 03:48:25 -0500
X-MC-Unique: qfLRHldQNX6v4tuaZ4NisQ-1
X-Mimecast-MFC-AGG-ID: qfLRHldQNX6v4tuaZ4NisQ_1770626904
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4376761037bso1128926f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770626904; x=1771231704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q4tJ7VHU0pH3HGK5kAFiigHlUOCPbfmrJCTP/PvMv+Q=;
 b=Hl6pnqkqee1Wg9g/qrVwENHA0DBFviKzPzMQhZEPfAMl0J4HoBd44i8TIXZGy44+uj
 mUUZzFgZE6e6CmIRDm6Qy4joxdiHQQ28HmOc4HoNOv2QXstyjqE5A5LaISd3HuLbmP6c
 2U9ikXQeHe2ufAjpIpwIUiszm9BfParjNdhbT/12LndhbEQcCPhiPud08KSfVWDVBZsl
 OUjlucdaWN2va8ICtUNZH7mjIsPw6KC/L9uBt+5R62zYX480qNvOqht8iwYrAKglMeMn
 RiTm72Fm6C86ikfhYYICFwAPhK6Goq1MhBBS0amwDkr6u49TgG2Xeed+f/APkytigxOQ
 FePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770626904; x=1771231704;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4tJ7VHU0pH3HGK5kAFiigHlUOCPbfmrJCTP/PvMv+Q=;
 b=CDjqFy9rMi0/1zEscUyai5G2aprDnwSDsW5GpiWE5AjRZTJeN8pydVytWvwmlmMTqF
 kjnYxiRPWu87jTv5fd83iPo6eX48nEs9PzcR2EFT90VJRPlmVyv/GydShtHrv96Svw5Y
 wuuQ5Tca0kIEOxsKHmWxRigC51pTwDTiG5hpnlfPFfp7WaaR3zfjOobYdNSK3b3ky35G
 ZDOCaB3yxTmWmpQyoHIZIcrXNT0/3buOSwPPx/cgmjJkknoPVyhwoOWzGa0KCIgqmMxd
 6cYG4+dX4OnnsFixj7snGGhUEZeyGdrAx51j0c1ihQligUgLZ2P+i5ivkM4JtRse7t9V
 rHqA==
X-Gm-Message-State: AOJu0YyTxQU7OCQfVzn+NIv7vvuBRDX1byIQyI8UF/mXCY8II13QnzT6
 Uy1/2iGK1NRuVTvXO/q5wxmXsBBJrENf76u1ktPi98zuB+hxBZVV5A3qNBTLzZ8m9iDRo8tdo87
 f4hrAwMrITuxRIFQMCR5euH2aDoeHMGbxc1jhVJ/iYQS9yjXkSadwt6BU
X-Gm-Gg: AZuq6aKd9VSpBFWJOHbPbZPP4rBuMHbs/UP3k0+zhwl73GyKcBFvWeMYtZYOs0J1tbg
 rBaUKNNcWceL4kyvO3O9kpZ72FMOncjfXZ8LJB+xGFsGwNrNs9Jls2rz5vFjG4vV06HeP4Doixh
 Mjs/gahjn1pDr8LLDaXAZT10nAG9lNwB2PoJkzG7Y/g6Tk8QAujc2ALtzIrEEv3qQWC/EuKm8Si
 fb1x9rPaRHBUgINch+OcQUWBYgv37/XSDZRhAASwb0hEj0Par3s8AeeyrnxDQU9vNVS/iG8dbLG
 P6CbZCpCZRR8/imXHXQlq1Jn/TbxjHc7gcQsyk7bet7SamfHwCivfwJ7827NhjyLrD/LB4PUigA
 9ymvCz2LOGwK0ABVDlIatb5qhtKMDsExTdmVDVLn0+ZUsr85aZGRclvjiGAzZFvf5aPPS045GzG
 i6A/2ExrAB5y7krw==
X-Received: by 2002:a05:6000:288b:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-436209c9865mr21377516f8f.22.1770626903892; 
 Mon, 09 Feb 2026 00:48:23 -0800 (PST)
X-Received: by 2002:a05:6000:288b:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-436209c9865mr21377482f8f.22.1770626903377; 
 Mon, 09 Feb 2026 00:48:23 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc1bsm26166550f8f.28.2026.02.09.00.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 00:48:22 -0800 (PST)
Message-ID: <ac50822f-393f-4057-9d7d-aa4e1595d528@redhat.com>
Date: Mon, 9 Feb 2026 09:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
To: Ewan Hai <ewanhai-oc@zhaoxin.com>, zhao1.liu@intel.com
Cc: qemu-devel@nongnu.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
 <b3632083-f8ff-4127-a488-05a2c7acf1ad@redhat.com>
 <65edadda-9e8e-4673-947a-13fc4b1a25ef@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <65edadda-9e8e-4673-947a-13fc4b1a25ef@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 2/9/26 09:15, Ewan Hai wrote:
> On 2/7/26 9:44 PM, Paolo Bonzini wrote:
>>
>>
>> On 1/9/26 03:10, Ewan Hai wrote:
>>> Update the comment for FEAT_C000_0001_EDX in YongFeng CPU model to
>>> accurately list the missing features instead of the generic TODO message.
>>>
>>> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
>>> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
>>> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
>>> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
>>>
>>> We previously tried to upstream all these extra feature bits in one patch
>>> (https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
>>> but the maintainer rejected it because there was no in-tree code using these
>>> features yet. So our current plan is to add the CPUID bits together with real
>>> kernel users step by step, Once full or partial in-tree implementations of
>>> these features are merged, we will update these definitions accordingly and
>>> potentially introduce corresponding support in QEMU.
>>
>> KVM now has a mechanism for introducing feature bits separately from the
>> kernel.  Feel free to resumit using that mechanism, then we can include
>> them from the beginning in Shinjidadao.
>>
>> Thanks,
>>
>> Paolo
> 
> Hi Paolo,
> 
> Thanks for pointing out that KVM has a mechanism for introducing feature bits
> independently from the kernel.
> 
> Before I start working on the patches, I'd like to clarify a few things:
> 
> 1. Which specific mechanism are you referring to?
>     a) The kvm_only_cpuid_leafs enum + kvm_cpu_cap_init_kvm_defined()?
>     b) Or some other approach, given that CPUID_C000_0001_EDX is already
>        a kernel-defined leaf (word 5)?

You can just add X86_FEATURE_* in arch/x86/kvm/reverse_cpuid.h.  For 
example:

/* Intel-defined sub-features, CPUID level 0x00000007:1 (EDX) */
#define X86_FEATURE_AVX_VNNI_INT8       KVM_X86_FEATURE(CPUID_7_1_EDX, 4)
#define X86_FEATURE_AVX_NE_CONVERT      KVM_X86_FEATURE(CPUID_7_1_EDX, 5)
#define X86_FEATURE_AMX_COMPLEX         KVM_X86_FEATURE(CPUID_7_1_EDX, 8)
#define X86_FEATURE_AVX_VNNI_INT16      KVM_X86_FEATURE(CPUID_7_1_EDX, 10)
#define X86_FEATURE_PREFETCHITI         KVM_X86_FEATURE(CPUID_7_1_EDX, 14)
#define X86_FEATURE_AVX10               KVM_X86_FEATURE(CPUID_7_1_EDX, 19)


Paolo

> 2. Should this independent introduction be limited to CPUID_C000_0001_EDX only
> For other feature words, I assume they still need to be handled on a
> case-by-case basis depending on their semantics and QEMU support status, correct?
> 
> For context: I want to add SM2/SM3/SM4/RNG2/PHE2/RSA etc. bits to
> 0xC0000001.EDX, but these features don't have in-tree kernel users yet.
> 
> Thanks,
> Ewan
> 
>>> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
>>> ---
>>>    target/i386/cpu.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 34e3e66344..10603eeb31 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6958,8 +6958,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>>                CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
>>>            .features[FEAT_8000_0007_EDX] = CPUID_APM_INVTSC,
>>>            /*
>>> -         * TODO: When the Linux kernel introduces other existing definitions
>>> -         * for this leaf, remember to update the definitions here.
>>> +         * missing: SM2/SM2_EN, CCS/CCS_EN, PARALLAX/PARALLAX_EN,
>>> +         * TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, RSA/RSA_EN
>>>             */
>>>            .features[FEAT_C000_0001_EDX] =
>>>                CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
>>
> 
> 
> 


