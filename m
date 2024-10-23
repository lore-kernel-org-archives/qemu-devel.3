Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FC7CFA478
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3iwW-0003A6-Kd; Wed, 23 Oct 2024 17:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3iwV-00039t-TP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:30:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3iwR-0007yv-C0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:30:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20e6981ca77so1838975ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729719054; x=1730323854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7SUzEd/ydNz4alr1dGxzqjamOGOLZayKNOj7UKibqI=;
 b=OvbZR6BkxESf5Z1+AthxxWOfOaCKyMBIwnXT41jln20/AYC7GzW5cic5PrbLXYPnBP
 HM4Vr5RqJDLiOjXrICrts9dLQ3Wc13vjZem7jQIDg1nUMOXai2IgcF9CT6AM0FUnyU9d
 acZqa2VyWT8UzNyxxc/17mrGmyKqPesQjwmHKfQ8ksF4ODUA5gBlU/WtojCpiqVKqPzG
 JXANyHug+zVil3Y0RXGCUebQSXF4CdY5yNFQ0ERQnrkohaF+nQADsbzu3fhTfU/SpB7I
 0EXc+epCu8krx12L7c5VBbq89uhETrTUs7Q8pHflo+2Ei5ewpSjaJFsfmcRdF+MzSWTI
 uZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729719054; x=1730323854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7SUzEd/ydNz4alr1dGxzqjamOGOLZayKNOj7UKibqI=;
 b=NPHjYBeZ7KhX92HS+mEKjWRCujfEPsiAuWFsfphzrhR0sdFYsexpk22YXjMBR60U75
 /lC7d4V9ACoS1tlCW2trcpzd7LWmBL1o3GgsqF7bQiTar83AaOlBJdPi3/B6tfKk+JI+
 MldXxaE+33iDpsfsJU9RhFNNJB2WF9GJp2kgYF5oGXWwQrDGWSnR1SKDbczoXD5zdzd5
 c3/vDUz98GZ0Xw/SUh5YJBA+0Gf+HekAocM3QAQvnot5u0M/355aAuLCoBk3oDpIj6lg
 cDor1cJcgYZyZ8CNLq8xfzLgoW9rCgKanonAwcY9bPEn6d/u4xnBbmOVeUafyrZo+OBW
 5Kbg==
X-Gm-Message-State: AOJu0YzpmMqPersyF8rmbi7FHdVL/fOO7py7zlYh4nOs3v1wcR+JVYGC
 gKmHr4GigeJ1z13O+UxTiZfBAG4cw0EyjJpgRhHpjqtk5aD67RHeoV3WS6u6TWg=
X-Google-Smtp-Source: AGHT+IE+gLc7zI3kkHZvSUNZEZ3gOmgOS5vERMyAjKlfEd5vfpBbSsq0vScd3j+qi6F4TmdmJlQ59A==
X-Received: by 2002:a17:903:1d2:b0:20b:bac2:88f3 with SMTP id
 d9443c01a7336-20fab2da50amr56007535ad.53.1729719053640; 
 Wed, 23 Oct 2024 14:30:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef0ad34sm61853995ad.68.2024.10.23.14.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 14:30:53 -0700 (PDT)
Message-ID: <2816a9e4-1cb0-476d-b0b1-8040086f0d3a@linaro.org>
Date: Wed, 23 Oct 2024 14:30:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-win32: fix format-truncation warning
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20241023183009.1041419-1-pierrick.bouvier@linaro.org>
 <875xpilhu6.fsf@draig.linaro.org>
 <0ec19690-760a-4726-baa9-6073c193dc3c@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0ec19690-760a-4726-baa9-6073c193dc3c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 10/23/24 13:15, Pierrick Bouvier wrote:
> On 10/23/24 12:50, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>
>>> Simply increase destination buffer size so truncation can't happen.
>>>
>>> "cc" "-m64" "-Ilibcommon.a.p" "-Isubprojects/dtc/libfdt"
>>> "-I../subprojects/dtc/libfdt"
>>> "-ID:/a/_temp/msys64/mingw64/include/pixman-1"
>>> "-ID:/a/_temp/msys64/mingw64/include/glib-2.0"
>>> "-ID:/a/_temp/msys64/mingw64/lib/glib-2.0/include"
>>> "-ID:/a/_temp/msys64/mingw64/include/ncursesw"
>>> "-fdiagnostics-color=auto" "-Wall" "-Winvalid-pch" "-Werror"
>>> "-std=gnu11" "-O2" "-g" "-fstack-protector-strong" "-Wempty-body"
>>> "-Wendif-labels" "-Wexpansion-to-defined" "-Wformat-security"
>>> "-Wformat-y2k" "-Wignored-qualifiers" "-Wimplicit-fallthrough=2"
>>> "-Winit-self" "-Wmissing-format-attribute" "-Wmissing-prototypes"
>>> "-Wnested-externs" "-Wold-style-declaration" "-Wold-style-definition"
>>> "-Wredundant-decls" "-Wshadow=local" "-Wstrict-prototypes"
>>> "-Wtype-limits" "-Wundef" "-Wvla" "-Wwrite-strings"
>>> "-Wno-missing-include-dirs" "-Wno-psabi" "-Wno-shift-negative-value"
>>> "-iquote" "." "-iquote" "D:/a/qemu/qemu" "-iquote"
>>> "D:/a/qemu/qemu/include" "-iquote"
>>> "D:/a/qemu/qemu/host/include/x86_64" "-iquote"
>>> "D:/a/qemu/qemu/host/include/generic" "-iq
>>> ../net/tap-win32.c: In function 'tap_win32_open':
>>> ../net/tap-win32.c:343:19: error: '%s' directive output may be truncated writing up to 
>>> 255 bytes into a region of size 176 [-Werror=format-truncation=]
>>>    343 |              "%s\\%s\\Connection",
>>>        |                   ^~
>>>    344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>>>        |                                       ~~~~~~~~~
>>> In function 'get_device_guid',
>>>      inlined from 'tap_win32_open' at ../net/tap-win32.c:616:10:
>>> ../net/tap-win32.c:341:9: note: 'snprintf' output between 92 and 347
>>> bytes into a destination of size 256
>>
>> Is the compiler min/max maxing what UCS-16 or UTF-8 might pack into that string?
>>>
> 
> Yes, enum_name (used to compose final string) is already sized 256, so result *may* be 
> bigger. I'm not sure it would happen in the real world though.

There are several patches for this, most recently:

https://lore.kernel.org/qemu-devel/20241008202842.4478-1-shentey@gmail.com/


r~

