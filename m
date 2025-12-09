Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CFCD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzGf-0003FL-DC; Tue, 09 Dec 2025 10:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vSzGd-0003F5-TR
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:04:43 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vSzGc-0004Cv-Ca
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:04:43 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so48906865e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292680; x=1765897480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I/lM1rdLdAWi9Fw0qvsOBQKFw2cdbmGotk2rBwCS5cs=;
 b=ekM+BdOUnF0zAD2+F5XFoagjrN0/VVlDMsgbxiV/GEgqjYB3Mgzgo5nybfMm0LVj0Q
 iPiJYWTpcqBK52FqJ0SgsQ4BW9N1xpRrTOK+TPfih5rpIjFz4s1S5PwO++DOC2UnpeY8
 hgkOkNUc7AGqJwysG7fMAqwtE09ZIGJUMI0VJ+Yc2Y9X79sUZJ/uduxFrSt0s4OmNg49
 bzEDWeBkYmYHALCyIj5zhpSGzgWc2E+l5HGVn7E/XuCsog11b9xld8J78BcZVc5XOoM/
 PVgf5HOT5LW9Dtr/Xr7zjxsVgSQSndF7Ct01QM4eQ2KHf501VOn33cH+Ir1Vq4J1LzRr
 oxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292680; x=1765897480;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/lM1rdLdAWi9Fw0qvsOBQKFw2cdbmGotk2rBwCS5cs=;
 b=FTRWSrjNbQ43qclmF7lQ+u/7919pxqzEaoX951ZRtX1Rh6P6Ud/JhTvmxY/C2R3a9u
 /IgItHIPeIMd/vhTSF6TWMsdePTNaC0DsbIERD31PR7PnYbcIpc93Tdo1j4t4Q4u/jgW
 gYoVWWlsnmhAHws7KwL5q8thAtQ5g1YxkvEDmR4x1O5BHRJUdc/aHK8J2OYuw4Xo6YPg
 R7lDaa08SbQD5+tcL2XuCssc0j6e+619DQ8qACQT3zhqauubN0gstWRGyqgRzTM8/fiC
 znrNW9RJvhybn7cwZ5HrqQUmwr1LSaSw0yPN48RLa4paHorX1ZwOt9IzhKJXxnUrqJQS
 vToA==
X-Gm-Message-State: AOJu0YxRmcXvA/Gd+6SXie04Pd96TJwXa0b4/rwOhkRdZkPz2kSVWsPv
 5xAo2amDZoQZskEWFlV+ZzlmxHzRrPLAyjq9sSCb4AX38/L6cCG7w0WSu3q7TExFKhE+3z1864U
 Rtz5mXnU=
X-Gm-Gg: ASbGncsqX5QMn+CsvaYEoPMki/30lgZRddTznRzebLDjp7k1L5kGoHK0deFMX0iZUOQ
 509osEckQSC9P/gmzNapnzf1la9XS9NTvCtGbNtSdIVyWaZUvJQ/eSS/Vm8fkB32s0MNv618DZn
 OMPgeXu4CMwm8aWa57DjL5tCd1mYYTRWAbc+Nw4f1fmZ/YWjwqmtZcYmwMKUw5xOl0UtzNV3qG+
 MCmyAIoSUedMHXBDFzQk1rfSkdoMxV8ggEBktnd8aEALImhrnn6ZwoWzmGKBEP8oEikJuc8yZta
 Psn92mrXCXpzXAb0aTiJ1bg/pzdP3f18WAerll9reFF7GKo/8KZzA3+2ATCDv293E55NaAkaEha
 S0+f2ksL2UNnJmDK9yKwnyQzE6Q0A8tKk7A49WEGIbIIeJTOhFClbPJyDF5M2CcbZnlUFXC8QZR
 PAaXbEtRsLfsY8VqxA8IfJiNy/mjIafk7fYP9o1cnhnjx3ZJZNGDWaQOfj
X-Google-Smtp-Source: AGHT+IGYvBSBXV134XV61fcAEj3H2uDxTYBDAKBoCdzdYfodqbgDpzujwHkfhdymyUCWWX1eehSryg==
X-Received: by 2002:a05:600c:6748:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47939dfdc35mr120878845e9.15.1765292680164; 
 Tue, 09 Dec 2025 07:04:40 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:2e31:bfde:d946:d752?
 ([2a10:d582:31e:0:2e31:bfde:d946:d752])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d810c3esm40275215e9.13.2025.12.09.07.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:04:39 -0800 (PST)
Message-ID: <64beb7f0-5406-433a-9cca-f94c5f4164ff@linaro.org>
Date: Tue, 9 Dec 2025 15:04:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/arm: Allow writes to FNG1, FNG0, A2
To: qemu-devel@nongnu.org
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
 <20251204180617.1190660-3-jim.macarthur@linaro.org>
 <59cb24e2-699e-4511-84e5-ad5d3ee90b58@linaro.org>
Content-Language: en-US
Cc: richard.henderson@linaro.org
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <59cb24e2-699e-4511-84e5-ad5d3ee90b58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/5/25 15:30, Richard Henderson wrote:
> On 12/4/25 12:04, Jim MacArthur wrote:
>> @@ -6121,8 +6131,16 @@ static void tcr2_el2_write(CPUARMState *env, 
>> const ARMCPRegInfo *ri,
>>       if (cpu_isar_feature(aa64_mec, cpu)) {
>>           valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
>>       }
>> +    if (cpu_isar_feature(aa64_asid2, cpu)) {
>> +        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
>> +        require_flush = true;
>> +    }
>>       value &= valid_mask;
>>       raw_write(env, ri, value);
>> +
>> +    if (require_flush) {
>> +        tlb_flush(CPU(cpu));
>> +    }
>
> Just because A2 is valid doesn't mean the A2 bit changed.
>
> Compare, for instance, vmsa_ttbr_write, where we notice if the ASID 
> has changed before performing the flush.
>
> Note as well that we don't need to flush all tlbs.  In tcr2_el1_write 
> we know that we are only affecting the EL1&0 regime (alle1_tlbmask).  
> In tcr2_el2_write, we know that we are only affecting the EL2&0 regime 
> (see the E2H part of vae2_tlbmask).
>
>
> r~
>

Before I make a full patch series, can I check this looks correct?

In tcr2_el1_write:

     if (cpu_isar_feature(aa64_asid2, cpu)) {
         uint64_t asid_nonglobal_flags = TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
         valid_mask |= asid_nonglobal_flags;
         require_flush = ((raw_read(env, ri) ^ value) & 
asid_nonglobal_flags) != 0;
     }
     value &= valid_mask;
     raw_write(env, ri, value);

     if (require_flush) {
         tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));
     }

And then in tcr_el2_write, the same check but flushing by: 
ARMMMUIdxBit_E20_2 |ARMMMUIdxBit_E20_2_PAN | ARMMMUIdxBit_E20_2_GCS | 
ARMMMUIdxBit_E20_0 | ARMMMUIdxBit_E20_0_GCS, as used in 
vmsa_tcr_ttbr_el2_write. This could be factored out into a constant 
function like alle1_tlbmask.

Jim


