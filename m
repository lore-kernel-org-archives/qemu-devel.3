Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3192EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfw7-0003KH-Cz; Tue, 15 Jul 2025 09:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubfY0-0006OD-TT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:18:26 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubfXv-0007kC-2y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:18:16 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c09f8369cso1773679a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752585488; x=1753190288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/d+Utfggb6/1lXOJTvVcAllO9vbxhpDdkcm7MJrVpH4=;
 b=le5pCt6TFO2EXzCdUuh7zI3jTK5U1jJfcLDrSkC5VgGfY1iXtnnTtDZTpAc08pQhc5
 t4/RPgRRzzjqivIoQbfGuQv61PHAZ/GWW1NZMUDwDoCWk5B5PxXRGXL5alR92n2Gxjrw
 RicnIasoBDrjG2yVeqDCFXM4XSiJRxnxGSwO7dzYB8bWlK/8vw2FXLYuUIzaP4CUfgtE
 iZrnPs7luvxbln24rRvpqLIdcZ4OvMnCRV+64ma79hhM/ElYMm+TKGG6Prcuh+c5e/R0
 cCvubSrca6fYPIhNfIKN4k/QtIFqPVR5ZyaKzvVWnAMMCvBbQ7e5QfYY0A8r/hPAg+GX
 fm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752585488; x=1753190288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/d+Utfggb6/1lXOJTvVcAllO9vbxhpDdkcm7MJrVpH4=;
 b=dRls8Urmxc8y6AuWS55xE35CCKmtu5xTpYD1nsJIP2CypNv5l35RXnLrEXIZeMhFKP
 vXJGvXouXlWwZ4v+3jLfwxvzf/Gj4NdrzDcqGXWWEddrujQLwS2ip8025uLcTeuNaywR
 o+MXn7/wAstQ+9Xhz72v1EIk/6lJNyoUU4KbxZm0FVhv212nsIzgg4VPPnKXr6cqBhGL
 WL/qRau/iG8NG5a9oA99QDZ5jVt0mIAjw6d30DJhgV6aF2TZg2LLrO5YYBp+Yg9J8rfA
 AqilncEiIGYW/TV5X/LeTNFHp6UmT/CNtpo+GhAhBW/zePwpjLikqBiMsJolknL7ToaP
 KDGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV4W4nfhPl4ncl2IeI6jF0xNz1ZWlRuuOeykn1Cebql+5Qx3fzXA+U1vI2WsvwlveB5GFYFz+sxyUb@nongnu.org
X-Gm-Message-State: AOJu0YzdtK5WOIeEK8rQydjNuOXy292d8ODdLH0xtSqSRrd397ivBCKv
 T6WpU2Q2uAVZ+AHVZx9CeDo8/uQA2fI2fQrwmK6vly4SVDtgNLNRtJXirYMyJu+kdeA=
X-Gm-Gg: ASbGncskqz2EssTu5s441pdRFRtdlV3V6n4TQ9jgJX9oMTR1kDE1rJSgrMMT9YiQo59
 JMTYP/hoKlb4/QypxVjkIVNWZ7Tg6OmOcqWwrY53PxB0rBxTCShQU9vHEEZ/jhYreCKl3up5nJc
 wXLqsLn5xJnRgYqmkvrk2vLbpSEfnb7+IC9bmiLXnDeZb2/lSEUbNxuAA1RPnGVRebbNXabB8g2
 8F/Ysdq/aCNvAP0DKaEUqpN0P2WRsJI2sZxDHWLQJdvS8EfSNEjgx3od6PZaR4KiDQ/E4PABG/6
 GuL2yIZFagFZy1G/JzhXmQol7fJbriEFWCG8DKisvF1PaCmqFSVS7OPMEkBSIPuOv+9ZheQioOw
 9lEX/VwTvowqL/h7vMRXj+KMVsENYF2oh3OLgWzx4sNb73CtIJfkT+P5zxYS8gP6ZAKjLa0sqsp
 r4
X-Google-Smtp-Source: AGHT+IGnIJMVvDtktI8pajZ1NedlNGR9QnzEKz/PJlcJYkQmd/1P/sdKsPCR27prQDUgRz5uUrOk9Q==
X-Received: by 2002:a05:6830:2d87:b0:73b:1efa:5f5b with SMTP id
 46e09a7af769-73e59a47821mr1858890a34.28.1752585488001; 
 Tue, 15 Jul 2025 06:18:08 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b7482sm2149331a34.65.2025.07.15.06.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 06:18:07 -0700 (PDT)
Message-ID: <3bb37477-046c-4425-a96e-4dbef24c851e@linaro.org>
Date: Tue, 15 Jul 2025 07:18:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 6/7] accel/tcg: Implement get_[vcpu]_stats()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-7-philmd@linaro.org>
 <c741d3b1-6a6a-4702-a33b-2d5c7c2e3598@linaro.org>
 <9e199d53-9b7e-400a-9172-9986602cf6a7@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9e199d53-9b7e-400a-9172-9986602cf6a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 7/15/25 07:06, Philippe Mathieu-Daudé wrote:
> On 15/7/25 14:48, Richard Henderson wrote:
>> On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   accel/tcg/tcg-all.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>
>> Oh, this is what causes tcg-stats to be used by user-only binaries, is it?
> 
> Indeed, otherwise we'd have to use #ifdef'ry or stubs; and there is
> no good reason to not dump TCG stats on user emulation (except indeed
> this code path is currently unreachable there).

Ok, that's fine.  Let's avoid the ifdefs.

r~

> 
>>
>>>
>>> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
>>> index eaeb465dfd5..fc3f28e3532 100644
>>> --- a/accel/tcg/tcg-all.c
>>> +++ b/accel/tcg/tcg-all.c
>>> @@ -236,6 +236,11 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>>>       }
>>>   }
>>> +static void tcg_get_stats(AccelState *as, GString *buf)
>>> +{
>>> +    tcg_dump_stats(as, buf);
>>> +}
>>
>> Is this shim preparatory for something else?
> 
> No, I didn't realize during rebase this can be simplified.
> 
>> Otherwise...
>>
>>> +
>>>   static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>>>   {
>>>       AccelClass *ac = ACCEL_CLASS(oc);
>>> @@ -243,6 +248,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>>>       ac->init_machine = tcg_init_machine;
>>>       ac->cpu_common_realize = tcg_exec_realizefn;
>>>       ac->cpu_common_unrealize = tcg_exec_unrealizefn;
>>> +    ac->get_stats = tcg_get_stats;
>>
>> ... assign tcg_dump_stats directly?
>>
>>
>> r~
>>
>>>       ac->allowed = &tcg_allowed;
>>>       ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
>>
> 


