Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC287C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JZJ-0003s1-GC; Tue, 22 Apr 2025 15:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7JZF-0003mE-QZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:46:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7JZA-00086B-Vh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:46:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so6002044f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745351158; x=1745955958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6wnyA/AvZdrJ0wDMydpgqfIypuyrKtCj0zXgEBCLqvk=;
 b=D8F+gYzmTDeBGYIhsqkbZnB9GfV6cfbcrobBDa75V6CcN/hkUmQX+uqgVAvypmewSs
 PWHsboFWm1i9wO0CoCRpEXOO9xnNxBPzEIwnBVb9YD8kECDaBrk+llfGJl2sCi0Zi6xG
 Y/5rzrUD0XXnRt4ui1jxs3t+ZYM+OLCsnyKjTrqTlms9ZW1Ki2ldKSNh1ZGUincnr0Kb
 LxAq4v5VPPnqPSTKMfMZeskQy1vLqUuGTMM4866WRcCKjFVSGVPEBylviJQ8b4Hk/BhF
 uYl2631vqB8qtb8wK7pVlQwOGZJ3yam3V236cFupo8VeQ09VMES3Z6SijET6bN0MqfkY
 X14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745351158; x=1745955958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6wnyA/AvZdrJ0wDMydpgqfIypuyrKtCj0zXgEBCLqvk=;
 b=G8NQYcxutboe43JoLmQMDfON399Tez8Ul5MWFjGlqc/xmMJpjkq7FTP+hQct8DDL8d
 r0V961kcV/45rETYgf9TDUO23V66t/AqQvgMUO5DodpJKQMOdWnN1gDpVoo3DGEBMZQY
 kzutU9i6numCunuyMd2TdalgJzgKr5Gp+loEjk9O0HRDJ7d7fieW/3rciseu3r3XkWr9
 Rd79gNQO6hNWhik85xScNlfPtmVuSQoP62JvKBw5huOcOwn3VM7tuBtjFUw6FBry7R+C
 Z4KZu5OQBHnciAGg2PC42ep7uGbL59dzWwhgFkx0Yfxz0FEk8JDeRubRisMgQ8MX98Sn
 Lp8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL7pNh2gBjQqzbrJCJ7TIvHmHVk+buAE4MdKv7ncP4KPao5xPveizfkV+iao75KLmMiJrleD1IroWz@nongnu.org
X-Gm-Message-State: AOJu0Yz+K7igtoGWrH07MraqmIFwumi721oGWb8A4f7hDRQ6RxISj91d
 ZNBcgGYWdCccGSUfgjdRulI4vCf3Yg4YXmS4gMEfdiQ7zLCGOqFErJZs5HL8BJ0=
X-Gm-Gg: ASbGncsC31/ihXTpheLOO9T7bIYyF2U2P2VHHGYsA/EHWpXBlsZHMDl1Vj9OzmjiUw4
 MhQwB34+JsizC1776DWTbnH4RQeJWTOp43O77vkU+hLHnaOKiB25Zmz/eYPugoDMBreKs2WQ3gy
 Pzs8Lrl5qt49Zjb6buPv3z/YnQJhG+UleqOShdcq6wJnqzUDiMECw2AiDiwYeoDgYfuiI6Aogtl
 sSZZxii/EYpKdnA1Z2aoHNAX3mWL/eALFkBp2qw2xTbE3ApDYxGYxFOX9fE4Lmh9uU5xx1jcSV3
 c/zeMk+EyL/IHPUZb3wXCFpFds2X31LTTm2WI5QOnwcBpZQ93sPjJgUSbDprnEGjx7XX57NlGB6
 4ldnWe4ii
X-Google-Smtp-Source: AGHT+IFccIQ1zZD8QJSEUpJllu4KHhYAFEEA7mXo+6Gnl5AQuBy4Y8hV0rf+r6xU0wL25XLh58hL7w==
X-Received: by 2002:a5d:6d8b:0:b0:39e:faf8:feef with SMTP id
 ffacd0b85a97d-39efbb1a80amr14426401f8f.56.1745351158400; 
 Tue, 22 Apr 2025 12:45:58 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4cd0sm16616498f8f.90.2025.04.22.12.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 12:45:57 -0700 (PDT)
Message-ID: <94dabfd0-e104-432d-9793-2f44d361ddc9@linaro.org>
Date: Tue, 22 Apr 2025 21:45:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] buildsys: Disable 'unguarded-availability-new'
 warnings
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250422171955.11791-1-philmd@linaro.org>
 <7de6ad37-d62f-4e66-b660-034b69fb5938@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7de6ad37-d62f-4e66-b660-034b69fb5938@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 22/4/25 20:36, Pierrick Bouvier wrote:
> On 4/22/25 10:19, Philippe Mathieu-Daudé wrote:
>> When using Visual Studio Code (v1.99.3) and Apple clangd v17.0.0
>> I get:
>>
>>    In file included from ../../qapi/string-output-visitor.c:14:
>>    qemu/include/qemu/cutils.h:144:12: error: 'strchrnul' is only 
>> available on macOS 15.4 or newer [-Werror,-Wunguarded-availability-new]
>>      144 |     return strchrnul(s, c);
>>          |            ^~~~~~~~~
>>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/ 
>> _string.h:198:9: note: 'strchrnul' has been marked as being introduced 
>> in macOS 15.4 here, but the deployment target is macOS 15.0.0
>>      198 |         strchrnul(const char *__s, int __c);
>>          |         ^
>>    qemu/include/qemu/cutils.h:144:12: note: enclose 'strchrnul' in a 
>> __builtin_available check to silence this warning
>>      144 |     return strchrnul(s, c);
>>          |            ^~~~~~~~~
>>    1 error generated.
>>
>> Disable this -Wunguarded-availability-new warning as a
>> short term band-aid fix.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   meson.build | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 41f68d38069..539368f82b1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -735,6 +735,7 @@ warn_flags = [
>>     '-Wstrict-prototypes',
>>     '-Wtype-limits',
>>     '-Wundef',
>> +  '-Wunguarded-availability',
>>     '-Wvla',
>>     '-Wwrite-strings',
>> @@ -747,6 +748,7 @@ warn_flags = [
>>     '-Wno-string-plus-int',
>>     '-Wno-tautological-type-limit-compare',
>>     '-Wno-typedef-redefinition',
>> +  '-Wno-unguarded-availability-new',
>>   ]
>>   if host_os != 'darwin'
> 
> I solved it the same way locally, but didn't send a patch because I'm 
> not sure what happens if the code runs on MacOS < 15.4,

I'd expect meson to Do The Right Thing and not define HAVE_STRCHRNUL.

> and I don't have 
> such a machine available.
> 
> Is the symbol already there?
> Does it crash?
> I guess the warning is here for a good reason.
> 
> You can find a lot of issues open in various open source projects with 
> this warning (with various fixes) since this update was released.


