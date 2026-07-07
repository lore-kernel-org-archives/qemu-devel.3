Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205E8C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAKd-00041e-85; Tue, 07 Jul 2026 14:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whAKT-0003tI-Rq
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whAKS-0006FT-6T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2caf228a910so27570445ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783448131; x=1784052931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n6ZnUu7p43qhppjSI5TV78JCU7uRyyoM+0DlhftBQVo=;
 b=JNHuMfJPUQuev/sFQIY55yI2fJ1wORYYA48kbbNehcRu8jUwMmmnzqlaSJyOouWeh+
 8hiLxfCzsCOBG8SM20UczYI2+0lGmce7A5uAhXb6gGvVkoR2fBx6aV1VUGQKwz5INS30
 a8IWJtRJ53smBjTRnee5Hm7ACZ2ZZvmDML0FQzdpugN10HqGi0bYHVok0Y/62DfPUto9
 Bshsn0hwU6Fs1sewXVw+HcQAsLEzDb5v0lyVtG9/v/KAjCNCxqhJ5VGtZlghEVepeI9c
 o6x6XCVVLmCFIu4Zcwhl5XrPrBcoQuzy0D91665Djj98oNpsJPis6DUDxS2ZTn/KoscS
 0AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448131; x=1784052931;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6ZnUu7p43qhppjSI5TV78JCU7uRyyoM+0DlhftBQVo=;
 b=XbLupBePGTrvcK0gSAnRMj9lYBXv1j4697nN7rJ+Nd5fMmC/kg0eXaRkea0z4HoduN
 MaObGy2WucZ9hsUygM9nenCvqTAEjDWE37LX+YpJifY9++YDOJpD07m/wO71kZCm5BbQ
 E7B9Wysh4pTcrbZJPoUK74t0uRlgtrb3CNqdqabhLgyp7P7b15Y0W7KYv1ASUH/zvqqb
 MbANXzwfr08lEXynlfOliAEZzR2HoSwQFCqERGmqpRB1mx7dBwuakgrLR4haaMiknoaw
 /hjE8sKvunr9kRShYPWXXGpT5aVvMTHpYTulCvYjbRixqrHD2xY1Xjze/x0eFcyGmAIY
 o7mA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6kGRn9mzmDscwxRDcXTWSDKNtU7XhsmQKvz/y/B8ujSziAkjHXrQZzERxP46dk2HGA+DN4JJZysyt@nongnu.org
X-Gm-Message-State: AOJu0YxmpbQhDx3odd83AsOL8OSZ1nzYEpIADcqelqo0KXj36flXw8jg
 lVD1v3A/kJNOqdE7f0+rEHtIFwIkdUdq1jI1xUK7j+zTm8x/1ttEf/9DNMjl0w4J5+E=
X-Gm-Gg: AfdE7clbCWiiEMlR+yGk06I7nSacOxS0zN9Gwpr+EZHpOMuCEvl2Xx+SagDgG+/zm2o
 K+GSTkJMshqTGEM1OJyQuU+zrh1DF2Bk9AhE1aQyX+YUms/9pU29+3VzaN3ATR3SqbGdoQsXOiv
 Ws7SH590Kxibv1r5KDoCAB2scexdRAh6AcGgD4y6oIPGlZHsiC5RDmaFUVHICLQGT6F45D+Dfgj
 ZnWVb6MwRJL+MpaPl2rsSMSmIl10oT+m6Y8Em/dMx7oSJcRP1NnpqjLuA0OoSoNOwW+6QjCetJx
 X/evxbeB83JSjScW1ph+6+pIQOQeZXMf9PpshaR3jYzH0hePjir66xFU7CAOh533k0GwwtkwOri
 TqkNz+wN+WkCmWScLaoyhCjQypHMTPOp8pCTozycKxvvNiP4e1y94+hrwuBb2q1/XYmxYLxr5ym
 C+SBmDLqBrBtlt7gWxNCMI0JRFOdBJa32yF4hEGULPwB+vbfKndj+0kD0=
X-Received: by 2002:a17:902:e88d:b0:2cc:9179:325 with SMTP id
 d9443c01a7336-2ccbe720304mr58776705ad.13.1783448129843; 
 Tue, 07 Jul 2026 11:15:29 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc42sm16111515ad.63.2026.07.07.11.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:15:29 -0700 (PDT)
Message-ID: <4ad532fd-8f64-4a1e-a369-4edb00bef599@linaro.org>
Date: Tue, 7 Jul 2026 11:15:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/x86_64: declare MO_ATOM_WITHIN16 host atomicity
 support
From: Richard Henderson <richard.henderson@linaro.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: daniel.barboza@oss.qualcomm.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260707122819.114105-1-andrew.jones@oss.qualcomm.com>
 <38651779-9181-4f22-93cc-23fc508ac9ce@linaro.org>
Content-Language: en-US
In-Reply-To: <38651779-9181-4f22-93cc-23fc508ac9ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/7/26 10:46, Richard Henderson wrote:
> On 7/7/26 05:28, Andrew Jones wrote:
>> Just like aarch64's prepare_host_addr(), x86_64 should use
>> MO_ATOM_WITHIN16 for the memop when it's capable. Unlike aarch64,
>> which needs to check a CPU feature, x86 has been capable since P6
>> family processors and newer (see Intel SDM Vol. 3 §11.1.1).
>>
>> Since a 16-byte aligned region always fits within a 16-byte multiple
>> sized cache line (x86_64 implementations always have cache lines of
>> at least 64 bytes), then this enables riscv cpu models with Zama16b
>> to use the fast path, just as cpu models without Zama16b do.
>>
>> Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> ---
>>   tcg/x86_64/tcg-target.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
>> index 92251f832738..99b6559eed88 100644
>> --- a/tcg/x86_64/tcg-target.c.inc
>> +++ b/tcg/x86_64/tcg-target.c.inc
>> @@ -1934,7 +1934,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, 
>> HostAddress *h,
>>           *h = x86_guest_base;
>>       }
>>       h->base = addr;
>> -    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
>> +    h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_WITHIN16, s_bits == MO_128);
>>       a_mask = (1 << h->aa.align) - 1;
>>       if (tcg_use_softmmu) {
> 
> You should update both uses of atom_and_align_for_opc.
> 
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll update this myself and queue for today's PR.

r~

