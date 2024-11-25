Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E61D58D64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFbo6-0006bW-Oa; Mon, 25 Nov 2024 11:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFbo4-0006b6-J9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:19:24 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFbo2-0001mo-2X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:19:24 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7250844b0ecso1173912b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732551560; x=1733156360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q7+Kv2CH+VtFubwcMDktmyRtFwfU0RZ/N7Z0ALqa0rk=;
 b=pkRD4TVPsX+UANhqKQgByBT+gcstvJARpsiRphI0U6YA5zEmoIWcW9jdMts4605qK6
 oNrfW+mgAKXClut3JJS8KMqsr59H0gbxzfvIi3VtfI8KgSoL73wsCAeR+HfrttBNdS2F
 fd4UyXEiWbKWGBCCci+EnFcn7ScTA+xJdEzvqj/YwNlLkCXDIHeMPaLBgKfCJyO/yX7u
 9AOm31nMD/eZsRUONNhmzdc0ffTo6ySo0hHeMdV6wxzS5EihM/SqSBifl6lIrOArFB6y
 0HyDUck8CIBHt6pqxHQlEiGf8MZSKZhDlgzevnOb+Mt6u9ztXoUvfTrihb4+wJqhT4Qo
 8L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732551560; x=1733156360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7+Kv2CH+VtFubwcMDktmyRtFwfU0RZ/N7Z0ALqa0rk=;
 b=QKIGQMmwBok/QCT+/vJ1Hnn+sxNEqZhAEK6RajTnOcTPezjszgmnAcwK1cFxZrBxu1
 4DufzLScvFUwikhQ1UwMOnRFyACOLOY4GURy2GR2EYULEf3T00OO2H8GmbFFKbQiq+1C
 rt1hyfYBnVxxWuOUZeh1jfj+k4JdmMv2bv6LF4s3wQdmsu8unSPLc+HTe2EBg8yS8/pQ
 2qtCN9CSUql/6iRqIkp3qBlSswDxx+Bds4R5naYaIS79K4GouJyrylZTPl+efiZK7dTE
 w+bJ+ehJwKlZuNX+P4g83swnMSr84Rq2Qo9SMtJqwtc2kooLps9MR9BOIqjflOH0jbWn
 sxjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCGYmCFymhQoVK0RreNmzEGw2N+Z945cBjXJZIpfWvdAs4gLhvoMcBY4xOutBP3doIW30y2pbJEl+P@nongnu.org
X-Gm-Message-State: AOJu0YxP+55qAmQjmoUGpUAxKVd/I32+IcTN/X3qEx8Dk/XEkUWt+F0V
 9qSb3sgjWpp4Cm8qhpqHuZtezksoQpeAaIQOaclPYOuw2K3lsAq/KBvRTqQnBgtpadZAUUqa01J
 LpjI=
X-Gm-Gg: ASbGncuRwAnZV2vKum8aeexH3a6QdgIIfRqaDwPWpiKPuJgq+kIvlmmyRacUaqYoi06
 8LFo6yyLqWLOV8F2yiIgpgN1sCMUVNiuKmvlmYvyedeCWwDdTISQ5vTKPvjiYyYmPOXztqusqDO
 hTm4GZ0MHi2Z9dmec6FOeuttr65xNzW7a3j1/ZVKAIdYwulM6nDkKf+CWwj9T/s76queTBwyGB7
 1Uec2UrCCJoZBuXRWYRHBm1YtWTLRjsu1lrVXJko8ZuWXLhd/ieXcU05TFoXlLxO1RhE8wIOnEB
 +xuPK+YRiiy+JYhdV/Scxw==
X-Google-Smtp-Source: AGHT+IFInkC4B6etn68KSMZR8cIXSOPCPUaKBHq5bZAMIKI7hves7WckLun09EnX+6XsCs6bNfci1w==
X-Received: by 2002:a05:6a00:3ccc:b0:71e:2a0:b0b8 with SMTP id
 d2e1a72fcca58-724df3c82e6mr16361434b3a.1.1732551559978; 
 Mon, 25 Nov 2024 08:19:19 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcbfc0857sm6846927a12.10.2024.11.25.08.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 08:19:19 -0800 (PST)
Message-ID: <3c5272ea-0e10-43cb-8390-a633ad43fd0c@linaro.org>
Date: Mon, 25 Nov 2024 08:19:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <77e47a71-a426-4bdb-bbad-24e6f99c498c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <77e47a71-a426-4bdb-bbad-24e6f99c498c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/25/24 06:04, Richard Henderson wrote:
> On 11/23/24 18:21, Pierrick Bouvier wrote:
>> After thinking about it, a simple, exhaustive and reliable way to find this type
>> information is the debug (dwarf) info.
>> By compiling qemu binaries with --enable-debug, and extracting info using llvm-dwarfdump
>> plus a custom filter [4], we can obtain a text representation of all structures QEMU uses.
> 
> It appears you are re-creating libabigail's abidiff tool.
> 
> https://sourceware.org/libabigail/manual/abidiff.html
> 
> 
> r~

Thanks for mentioning it.

To make sure we don't miss anything, I made sure to run that using 
windows binaries.
So, except if I missed something on how to use those tools, this 
excludes support for abidiff and pahole which are ELF centric.
Thus the idea to simply to dump full dwarf info included in COFF and 
compare the result.

