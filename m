Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF20AC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbpo-0004CQ-1t; Tue, 01 Apr 2025 09:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzbpk-0004C5-QH
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:39:17 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzbph-00062x-Kv
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:39:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3feb3f54339so4022025b6e.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743514752; x=1744119552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPERHJFUFyleu0dAP1JdT3S6nuEczWRq36KVnIeLPyE=;
 b=P/o9ZCPFFMAl2xhPozJqUpROo7lBmhoXnUtNLrCUox0nnUsIYUpmgNwQdTp5PJl2LH
 kr8Mk0PQUpsCjxLHD39k3bTMJ9dAbni4YQUYzQiq2b8Czdq9nwqe+uqcXn1z8z1JLrx0
 kTgE32GRLD40aATzyRHMBsEPh1/hxZO/JTaZ263dCrkrSvAopGM3dVdHutsWfcg+nUlj
 VlfR4OnJSdj2+iqntI69qEA+GUFgE77X631t/6B29XI6hBKrdG3V0pLqTm8w8EITPGp8
 VZcwR698vH4w06mIZlErLhm1T3wQxuwWda9St+9XSvX/roZr2zWuZXPaUc1qoD6K4l7y
 iFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514752; x=1744119552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPERHJFUFyleu0dAP1JdT3S6nuEczWRq36KVnIeLPyE=;
 b=oDROmLyNLwcwl/HWbuKrW904DaF+Nb1nT2/+ZPbWMAMh+s/NhCvrZVPwpVmJHnxA8E
 t9D6xzkN18xye0WxazpZrlk2+pgXkjOGOQjnz7c1UI3TfRuJUfEUmewEgFtJITdk98Ac
 IvV0d90QE0rbFz+BtMoAOa7+wOiBaWtissuOKzIBSljZ/IuyGyWViipEK709kXeO0hkp
 Nn6izEs4xhLpEyodgODI3uXcWKG7ElkKwp+0k+uFOMqAeduF0coiJG3QXdovm3QN7ktp
 khCSd7K1bEn+ZnHwnMu8a5zzLxPyCjejorc7MACGDNzvQTQeYWqtBJZ3xe71h6SqAdip
 AVIQ==
X-Gm-Message-State: AOJu0YydZ78+rEFVHPmjhee9mfqdXAPWMVP3vrrM5reGjmFSd8K7Ht6s
 NRkLU6eot3b7kPM8yZicNSfNDE+oF1WEosDzvYiRBOC4Bbg8XCwBI9wXD6lWF9s=
X-Gm-Gg: ASbGncsgsgTzMzwO8hTTheuvYxqPV4YzbU/DBuxkyHUyzz+ZNAMXy0e4BYtV65Gt/Uc
 K8Fm02PMayGzDEFVyDXX0lmhB9tjUurDrRCca0mDZhODWwZHdjBJxHjoHIaH1KkA1PoY864soc1
 TJljjTsXxub+tGxaCXGvqobPQe7QViKS0bs6sDHbxHYo0edGsOl52NJhkeKT8lapHWtUiyquLRo
 TBJSgOoL5qgBPMPAZQlpW+yFp5rk2l1d6B2vyIHwvf62fiA5k8A8CeUVCifgKFPBbYDg9pUKPxF
 n01HIzCFR6rUk6kTI7eqOxR4PPdHuqhFlOqRMFad65ssLb9Qj13a/MMbHimDjTG2GXHcdbj7NA3
 N3YNgso4x1SbPp9PrUDRkeOHl4KE0Anzw
X-Google-Smtp-Source: AGHT+IGb1IPP9W+ybDYldBSZJ1A+5GYn9RlN0gTwjqL1S5Izwr1yGJzsX2k8a9abAg1r3PXfxPrTwA==
X-Received: by 2002:a05:6808:168a:b0:3f7:d16c:e283 with SMTP id
 5614622812f47-3ff0f50fa36mr7279768b6e.11.1743514751913; 
 Tue, 01 Apr 2025 06:39:11 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05279bb3sm1952762b6e.31.2025.04.01.06.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 06:39:11 -0700 (PDT)
Message-ID: <b17663bc-40c3-4501-be88-065363138038@linaro.org>
Date: Tue, 1 Apr 2025 08:39:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
 <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 3/31/25 20:15, Huacai Chen wrote:
>>   #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>>   #endif
>>   #endif
>> -#ifdef CONFIG_USER_ONLY
>>   #define TARGET_PAGE_BITS 12
>> -#else
>> -#define TARGET_PAGE_BITS_VARY
>> -#define TARGET_PAGE_BITS_MIN 12
>> -#endif
> I'm a bit confused about TARGET_PAGE_BITS and other macros.
> 
> In my opinion, if we define TARGET_PAGE_BITS as 12, that means we only
> support 4K pages. And if we define TARGET_PAGE_BITS_VARY and
> TARGET_PAGE_BITS_MIN as 12, that means we support the minimum page as
> 4K, but we also support larger pages.
> 
> Am I wrong?
Yes.

TARGET_PAGE_BITS is a minimum value that is used by the memory subsystem for managing ram 
and i/o.  If variable, via TARGET_PAGE_BITS_VARY, this is set very early in qemu startup 
and cannot be changed.

The page size for the mips cpu, like many others, may be changed at runtime.  The page 
size used at that point is reported to softmmu during tlb_fill.

The value of TARGET_PAGE_BITS must be the minimum supported by the cpu.

For Arm, the minimum for armv6 was 1k, then armv7 dropped support for tiny pages so the 
minimum is 4k.  At runtime, armv8 supports page sizes of 4k, 16k, and 64k.

For MIPS, ignoring those cpus which support 1k pages, the minimum is 4k.


r~

