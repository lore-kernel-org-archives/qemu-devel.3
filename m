Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60208C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiR3-0003nB-A4; Tue, 18 Mar 2025 21:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuiR1-0003lN-70
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:41:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuiQy-0002LI-SH
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:41:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223fd89d036so126381795ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742348487; x=1742953287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZuSnWAMdl/GsH5qLj1Qduy+VEy21B8hbPR+FnX+Lf0=;
 b=ozDkiVU2MFOm9vegRLGUUVMiPob5ofbY+HnGQrVyrtDIACbCCoS4SmebKJnk2qnZoz
 NyPacPIkSsvexTdGXiKwrEVxcZsbA6qARVyh5ZswQNK3CaGBtdmwfBf4wYCTg8oOK/P1
 /Ls61n7jcXXm3+78VnbeJuB/nAFOOSP/SkxH/LBNXINR56kGbR/4WYJhyE7hDw2GUI8D
 yrHKctu8UZj07DPMNRW8R30tCHjnOV6Szkc1c5NMMOPzUGwkMHSh5SMM4Q5Q+qElx0Yx
 82DOgAzf27PXw45DRiToYI5ZCp6dD7AXCyvJ0Gj3yi0dmqgYKHyUXjCe3k05CpaRBC0s
 T2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348487; x=1742953287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZuSnWAMdl/GsH5qLj1Qduy+VEy21B8hbPR+FnX+Lf0=;
 b=QqJyRmh7fKrtXXwLQxeEP+VfQJ6a5eHgwyZTuArVmjy/uzTkretq2EDVMuWhpOfc+M
 n4Mpx1qA7R5ZV4tvEkWhPJFZJDqVH4RugW9ZmanVtd8yMrz+8QGfDRVvefuva9j01jWO
 JabVyyb8EnsJHAh6kY6YNFR2r7evAmdqB6XWezbl5Cmw/YBtDRO34ibV3ejG8qdF8m5f
 KMi8rGNwZ6grT3Alr9HBgW6syIHFBYUmwJn/XjSVQWsYt7c8YqNNFXVsBLqq7xJ5A10A
 NjXz9yQom2EmKqsbQwZS/PJ30b4Ap3O8yhAe6jSPAJrF5dt/NEqTDs93wJus6oIUARzU
 p7CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdRfZB9BCzU0Y/aPpuOd7i7dXzQtjOIZc8tChyKrtOwcjGuUExamyz/x0q2M5GY+RwPWdx+wmw3CV7@nongnu.org
X-Gm-Message-State: AOJu0Yza+BMWxr6UCdtNW/SmN1hYl4OGKs+e7x1orzw8io4F6Z871Qf7
 MCk4OwDtC5I34iBggDCiaOJWy+NaOyyx+SrJ6iKh95smc1M8n8Y2lq8og2/9Io4=
X-Gm-Gg: ASbGncsmqoaTi+u7Yr3ZBPEHbcpCOwBhiCNC0bGQRMBGH8+EJmFlfAQaxoBQthp5wYg
 nEeYNS0axWt9HVfVLOoof6PDvi7OgXx0rHJ6nDUxnPg7bGbJq4EUNdqNk/NthOYgHnMkdneYzpu
 o8hTX3zxUgiy8O4kPk//HW5TxQzAHtav+K8s5alG2OESMBH21rg/oCrE37rDrbCebjsUAgauqph
 kBxceARhQ2PI9EeUL/yDT+Pp7qUc3EDmmezqq3xtggULfHznKhJbj8xqwNwMqOZNSa3/dO4c/PV
 u+CmK1yzY1twsKLYxB9Ua0j2nmAPl2IFwCP235h/uKNUTXai5/pHfjTGfiRRKngLuTcXwGa2s7i
 c7DVPZJ81fjepfqRb2mc=
X-Google-Smtp-Source: AGHT+IG5Uu18R7gtEbdCUyyfi4OwVs1UoH5yrEYlVCbcOPE0G54/zehGCGBbYWCb167Xh5KEuXI/sw==
X-Received: by 2002:a17:903:228f:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-22649cbf86cmr9590845ad.50.1742348487007; 
 Tue, 18 Mar 2025 18:41:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbfe22sm102245005ad.206.2025.03.18.18.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:41:26 -0700 (PDT)
Message-ID: <16c05b26-ab38-4834-b2bf-c8e30798baed@linaro.org>
Date: Tue, 18 Mar 2025 18:41:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/42] include/exec: Protect icount_enabled from
 poisoned symbols
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-39-richard.henderson@linaro.org>
 <81230881-d918-4cf7-bf35-03e54e5e88d8@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <81230881-d918-4cf7-bf35-03e54e5e88d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/18/25 17:42, Pierrick Bouvier wrote:
> On 3/18/25 14:32, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/icount.h | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/icount.h b/include/exec/icount.h
>> index 4964987ae4..7a26b40084 100644
>> --- a/include/exec/icount.h
>> +++ b/include/exec/icount.h
>> @@ -22,13 +22,21 @@ typedef enum {
>>       ICOUNT_ADAPTATIVE,
>>   } ICountMode;
>> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>> +#ifdef CONFIG_TCG
>>   extern ICountMode use_icount;
>>   #define icount_enabled() (use_icount)
>>   #else
>>   #define icount_enabled() ICOUNT_DISABLED
>>   #endif
>> +/* Protect the CONFIG_USER_ONLY test vs poisoning. */
>> +#if defined(COMPILING_PER_TARGET) || defined(COMPILING_SYSTEM_VS_USER)
>> +# ifdef CONFIG_USER_ONLY
>> +#  undef  icount_enabled
>> +#  define icount_enabled() ICOUNT_DISABLED
>> +# endif
>> +#endif
>> +
>>   /*
>>    * Update the icount with the executed instructions. Called by
>>    * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
> 
> I understand the shortcut taken here, but I'm not sure we want to start having specifics 
> for COMPILING_SYSTEM_VS_USER, out of the poison file.
> 
> In this case, we can change icount_enabled() to a function, implement it in accel/tcg/ 
> icount-common.c (which is system only), and add a stub for user mode in accel/tcg/icount- 
> user.c (or common-user/icount.c), returning ICOUNT_DISABLED, or 0, more simply.

(1) If I were to do anything it would not be adding a function, but
     making use_icount a universal variable.

(2) There are a few uses where if (!icount_enabled()) needs to
     evaluate to false for user-mode, so that dead code elimination happens.
     Otherwise we then have to introduce extra stubs, etc, etc, etc.


r~

