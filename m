Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368BEE7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 12:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMRN4-0005A3-BB; Sat, 14 Dec 2024 07:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRN1-00053V-PZ
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:35:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRMz-0007Ai-Sl
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:35:43 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43618283dedso25430765e9.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 04:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734179740; x=1734784540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t33SrhvxXyQ0Y4ZpKdcRAMveJOzlzx6Tib9XNxjjuoA=;
 b=dicAh4fSo8XTtquljZ1GNa8Vd3vfX8jpV8Ue+VTg3oLSXZ1qUQ3MhwxAXGmKR1F0Zr
 3VEl2vidV/HwXg7n8iEgC93d1HvvBhfvSE1Xo+H91S7Y3Qcw59mqBcToLijIRCVxyCS0
 EpykD55qZFgg0pO/nuoW7O0ZRkNqtaoDKU/9DYlDGsu+p+c/uszpSKG/svkadIwjB8Eb
 FLHv8iDjubApjACJWxoDOEJeNm3PPXOyZvLzGPHDDClZnvl1HIQNbPOpDblDUwsk5NJm
 V2T5tl1+LYxStkeuXIrXCPBUNg/M5/SrQDr7lmuj2QiqoyeWWsIQAkBMBVuZkPw+8xaj
 qH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734179740; x=1734784540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t33SrhvxXyQ0Y4ZpKdcRAMveJOzlzx6Tib9XNxjjuoA=;
 b=EWCgIsVdQAI5Y2PIjDL6DWyxtzcgd1aa3E/RLLu6XoMGS6v1OfS5PdHdIJwTyDd7Pw
 RiUdaokvf/sSGHddr26r14Ah4/RVUFLo0AamE2X1NQyn6lB4UyXPGI+w1VsjMaCJrkH0
 3nTpLzLP5s6Ns1NVxljAKp3Edar0gAGRWD2mTSu7zhqJvynLZch8hKH6J6R5uC6XI/9z
 y45zhB4P96+SA40jmSqNrPSRiki/fP6atbPJ2jMvLDTB6bQAQ+Z8acIci677aeexxJqE
 kuX3M/QDAC1qMMXj2utdpEPpAUKtTdC999fzHEbJLF+jly+ar48EecN9FWvFaLb/aa4n
 1CrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2L+bUo9T9LgqbkETIi0E3YKIMbWx0wouMFWx+JuM9bbtK8mUw4YEFsJ5gOWG9Sqs0Wlw9yY8TzP/F@nongnu.org
X-Gm-Message-State: AOJu0YyOb/Tq5pgCQU+S67wWpZ+5MChI8Hq1dPKYQe/u3THKKLfhaDtG
 yYXhS8u/Kxy3F/sPmGm5j0+4nAEU7nBZnRblOfjROT7tVOH8+Kfry/mtkGxGZSE=
X-Gm-Gg: ASbGncuRYzHc7lMP07Y87EWo3+4crj7yRUcpkrZcLtbtmq10jw1gBSALMlODJhpC4fG
 zJgTzxpvldoZwtomG/0zqg5WYbYBDuGrpDuDg6m5sw7dYsymbd+WHJmzo2in8cJe1JqinGoDdSi
 xBRfx0IsIXaJkdji0nYiVBVqGU3ZQ75mjjkqVW57fgZPpzNJJByVjpheDMB4s3iBYZeRxDdKzOf
 LIm4IxGzCnTqn+GOM8AvllC2Gx+u0p+YBtL0w3mCVYO2QpOrRWiTtJ/kVcigC5OF4IEqb6q1PMW
 MNmhTZBOlRW+dl1JUkr43ARpFwQThaerhrHvGHibBUCUNg==
X-Google-Smtp-Source: AGHT+IEXfNe/cvoYHpQa23Jaj+40VZj4Q8/y2+0fCODzS1YMCJaeoEVDV+M6dmfA+jK2utNgQlZ+YA==
X-Received: by 2002:a05:600c:a14:b0:435:32e:8270 with SMTP id
 5b1f17b1804b1-4362aa3bcdcmr58490925e9.14.1734179739922; 
 Sat, 14 Dec 2024 04:35:39 -0800 (PST)
Received: from [192.168.224.213] (196.red-95-127-57.dynamicip.rima-tde.net.
 [95.127.57.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362571765dsm78886435e9.39.2024.12.14.04.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 04:35:38 -0800 (PST)
Message-ID: <ae5c9de4-67e5-4a37-a184-eb4017723725@linaro.org>
Date: Sat, 14 Dec 2024 13:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: contrib/plugins does not build on 32-bit host
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
 <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
 <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 14/12/24 06:29, Richard Henderson wrote:
> On 12/13/24 21:44, Pierrick Bouvier wrote:
>> Hi Richard,
>>
>> On 12/13/24 13:47, Richard Henderson wrote:
>>> Hi,
>>>
>>> Several of the recent contrib/plugins/ patches do not build on e.g. 
>>> arm32.
>>> All of the issues are related to casting between pointers and 
>>> uint64_t; there is a Werror
>>> generated for casting between pointers and integers of different sizes.
>>>
>>> I suspect all of the instances will need to use separate structures 
>>> to store uint64_t
>>> within the hash tables.  The hash values themselves can use 
>>> uintptr_t, as "hash" by
>>> definition loses data.
>>>
>>> The following is *not* a suggested patch, just touches every place 
>>> with an error to
>>> highlight all of the places.
>>>
>>
>> This is something I already tried to fix this way, but alas, casting 
>> values is not enough, we might lose information (in the case where 
>> guest is 64 bits). Some plugins need a refactoring to allocate data 
>> dynamically, instead of hiding it under a pointer.
>>
>> See this previous series:
>> https://patchew.org/QEMU/20240814233645.944327-1- 
>> pierrick.bouvier@linaro.org/
>>
>> Finally, we discussed it was not worth the effort, and Alex simply 
>> deactivated plugins by default for 32 bits platform, so it should not 
>> be built for arm 32 bits. If we really have someone that needs this 
>> usecase, we might make the effort, but for now, it does not seem worth 
>> the hassle.

This is:

commit cf2a78cbbb463d5716da9805c8fc5758937924d8
Author: Alex Bennée <alex.bennee@linaro.org>
Date:   Mon Sep 16 09:53:43 2024 +0100

     deprecation: don't enable TCG plugins by default on 32 bit hosts

     The existing plugins already liberally use host pointer stuffing for
     passing user data which will fail when doing 64 bit guests on 32 bit
     hosts. We should discourage this by officially deprecating support and
     adding another nail to the 32 bit host coffin.

...

+TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

...

-if test "$plugins" != "no"; then
+if test "$plugins" != "no" && test $host_bits -eq 64; then
    plugins=yes

> Hmm.  I didn't delete my 32-bit build tree, but it certainly re- 
> configured.  If plugins are supposed to be disabled, something may be 
> wrong there...
> 
> 
> r~
> 


