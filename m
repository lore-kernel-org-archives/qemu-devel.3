Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B86C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttCUd-0006M6-L1; Fri, 14 Mar 2025 17:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttCUa-0006La-N5
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:22:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttCUZ-0002Kt-53
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:22:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2255003f4c6so46026105ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741987372; x=1742592172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qbnwUoky6ea/p+KFmowYTCxEOUS8u1QCbtbE6im+jC0=;
 b=FZkmhqmLTzWm+B5zd/feJetSvLCaOMX+Hg2uAR1HUdhMWvsoVQlj6XcQIZNiEK5EKN
 Tw0SMf7MJrcm+QoVG6ww0vWri1eyEb59pb7QgneYghU3sainNiFLPC2yMMUW7oyozOc0
 2XhJ2fcSyeotuMMY0xEF7tZpRtv4Qn4qBj2kDhyXdjD5E/hDTHZlElkWgtu/TkDX0bLa
 06pbqgjBBK8RZM+FiQol0W0lOYNtAyadEnE1lWDqPTmJf0JNVrscfwyJBiXQ2RJadwdF
 1+7sCCPgemkk7zsZAXO7YtofwMHMr8OkmlErDkYAS8dZIJIb1dwJ3R+NQ3MbPa5+NsiL
 kFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741987372; x=1742592172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbnwUoky6ea/p+KFmowYTCxEOUS8u1QCbtbE6im+jC0=;
 b=i6I6remV/6GaKMKRMtScwmihn18u4ROh/+0V5strC3fcW3s1Jhj1ns/c8a6KRMs+TD
 kkz25JAuAUgN9E4QJUBFdrRDk/Z6E8WzNE4cv3+LczADLSr2rL4eJNc01Yhy16VYFu95
 JD26p53z+kTuKjQ/bcErMT4GBXz72rh/jhQdm4XTRadgGPcKYeC1guniG8ju2Ed89Vl0
 cK8FbXJnb6PUMhe76ttjo5UGeg+ksvF8RHq2PPof2XyLcdVbjR+eN28x8XijlsIIysrh
 EZcAA42gNaABZur+dmLt9Lne1o1IyT/ziSR1IJeZ/DoszUWOjgbsUcTFuF/4f7JMcm+1
 ZDjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/ZFTLNsYx0E8IBZt3FQ1vYiA/uNMumDehL45aQun0E+r0eAbqs0kecckLLU0XHbnfDXRyWHoH9Xf@nongnu.org
X-Gm-Message-State: AOJu0YyapYtyVutyJEJFVLRCSja5IHavMfJRaltpU6g6FNpZLFCQxlJV
 ZDrgC8E2Qd8Zf+6uWCLN4qVB5HIAtpeG4zvcUBpebShbDcSPJ7Q46kaLdsQ1y2Y=
X-Gm-Gg: ASbGncv/NE6HjkQSrDPiTq5WJSLuO6/n70AL5gcZoWrjzoDoxrCEYR06PAk/iIe5Scn
 RnBsSnnD+xhejxBByB/wAAJkpR9H56e7tg4Yqu9zQfzXli8nG0DdVTAlB+zn1GB0Xpitdt/rRmd
 t6SYtEJPL6CEvAmgWCQaAP9IN9pHGahdWB9JTrnHNlI74VWq1rZJvSeEp/0W3iFPbNt9HVxmeEq
 PUHDyGvx6RRpR5p7N2XSQvvy5++kgMfpx0BTvhZi7GXXm2skM02TF+6r3RuHIprCr2/mvoLT6MM
 X/RXOYGttZxk7YfTCUL9tU/2gT+S0EtHWbptJTOttr00dclKF318foDQ8CDsQnfrILX8BXkPscJ
 ZxslS6iRb8hKvskQscuo=
X-Google-Smtp-Source: AGHT+IEwPYPVzVfohqKUJECbuQkRQjNjHwbpYfwCgk7jF2j2vysJI5EGAhVLS711HYda880qFAk4MA==
X-Received: by 2002:a05:6a00:1950:b0:736:53bc:f1ab with SMTP id
 d2e1a72fcca58-737223b908dmr4634306b3a.12.1741987372544; 
 Fri, 14 Mar 2025 14:22:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371155117dsm3438550b3a.54.2025.03.14.14.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 14:22:52 -0700 (PDT)
Message-ID: <619aae66-50fe-41bc-a2cb-0ddfd867f619@linaro.org>
Date: Fri, 14 Mar 2025 14:22:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250314074107.992163-1-npiggin@gmail.com>
 <20250314074107.992163-3-npiggin@gmail.com>
 <b1bf1986-d034-471a-ab4d-3ee19f501940@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b1bf1986-d034-471a-ab4d-3ee19f501940@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/14/25 08:24, Philippe Mathieu-Daudé wrote:
> On 14/3/25 08:41, Nicholas Piggin wrote:
>> Debugger-driven invalid memory accesses are not guest errors, so should
>> not cause these error logs.
>>
>> Debuggers can access memory wildly, including access to addresses not
>> specified by the user (e.g., gdb it might try to walk the stack or load
>> target addresses to display disassembly). Failure is reported
>> synchronously by the GDB protcol so the user can be notified via the
>> debugger client.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   system/memory.c | 37 ++++++++++++++++++++++---------------
>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 4c829793a0a..960f66e8d7e 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -1412,18 +1412,23 @@ bool memory_region_access_valid(MemoryRegion *mr,
>>   {
> 
> Should we instead consider debug accesses as always valid? i.e.:
> 
>          if (attrs.debug) {
>              return true;
>          }

No.  You're likely to hit assertions in the device code.


r~

