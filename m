Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5917D5AE79
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8z27-0003Hi-2z; Thu, 07 Nov 2024 04:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8z25-0003HZ-My
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:42:30 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8z23-0002Q9-VS
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:42:29 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f0f9ee49so669723e87.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730972545; x=1731577345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ThMRTQ/XPqy+vSyXSmpkie3xVOcQ6Acy87XnLwDvPFQ=;
 b=uRqYhWEjaza0bm8iWRmnm1vtTuQisnxza6kah91SERkklPGq1wHI9yfKfiJ7t+xeC1
 xwhBLplnwYd8dP0QlU/RiTpcyHdahrTID0hgn3tW2H0r5LFdMmU4N53xk7GiPMiHXuZM
 6aGXX68e3hidMa1aCe8BqIaoluvAMMDKHHF1EtzbgEdw2lHmBJnsZYfJj9nb0GtMzqwU
 QHSTD6YAGeQPx55EMr+ZsRBvg8ACyRKxCqoObwi3Ofv4s6kuFBXynzadWDgeUh5ygC8E
 l3S2bvoAI0mrI0X8CBOwXxpA5Z3AVv7+I/SrkRVgvXdEvKLpPcPYLqiegS84Errxb4Ne
 hwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972545; x=1731577345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ThMRTQ/XPqy+vSyXSmpkie3xVOcQ6Acy87XnLwDvPFQ=;
 b=CnaMkDnwyx3DULVWzmZQVqB1CkX1xJS7g3chyfBepPbZF5Eb0Y1lNUtz4Uan26zxEK
 HXAZv3xJLoAPtUpgISmPRTmcQ6zaxyuHavxN0/HCQManJ1OSvTQW7gkJIOVtsa9zoiv3
 FuWaWD50w+PCHqe8GxePnkMcXWJLt1Q1XATvTi3bL/XFJasIF74yeF7jJUBZM6HGS2N1
 TJnq7C3j4rBwJCnGAvnQSWMIBVbQL6KevPRVq4D5R6dv6hzQIwDH0TnrsiCKUErUN9kk
 bCS8ut+bpmwV/qAzxYKzScnxDTpuSK2EDYeCQie+RRI29nSlnyzF/JJzcM8lXJFcmSzH
 HO6g==
X-Gm-Message-State: AOJu0YyqRRXLYx2xAfMtKOEz5kJFCiGMb52bVqKr+bsnzibiTCBejS9D
 P8IJ84hCGPRse2OCSWmGI2dpZM3Soyuye51IsMghZBLd6rYrN/MdLxTieaYziEo=
X-Google-Smtp-Source: AGHT+IFM6E5E0Hy9mDc4SQFlg52LztduH7+Xo4eTJbH+ezrX6g0rGTZfw5JIJnRaufV1Y0OsSVntvQ==
X-Received: by 2002:a05:6512:2311:b0:539:edbe:ac86 with SMTP id
 2adb3069b0e04-53b348b7e1dmr23000230e87.10.1730972545347; 
 Thu, 07 Nov 2024 01:42:25 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05305a4sm17254015e9.5.2024.11.07.01.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 01:42:24 -0800 (PST)
Message-ID: <5d8ecf29-aed5-4e3e-9b4c-f3b5e5bcdef8@linaro.org>
Date: Thu, 7 Nov 2024 09:42:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: qemu-devel@nongnu.org, iii@linux.ibm.com, laurent@vivier.eu
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
 <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
 <CAFUsyfKkmSid=LVTbG+WHZA_=MAGdf+TU5vGtNE1GGx8WDheOQ@mail.gmail.com>
 <CAFUsyfKfM-X_qGN4Dy8DhES7zRi66s6yVZ3+_KmNM4f2GhBG+Q@mail.gmail.com>
 <f21fe153-6239-4c93-bf60-994976a9dbea@linaro.org>
 <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
 <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
 <CAFUsyf+8sJLX+qqzPEj1E1QPQpoP4n56uU5U9aksq8JEx_52gA@mail.gmail.com>
 <CAFUsyf+xVXamR+5gtu62vFXjYScrJu0Arvhk62QXYa359UCHsg@mail.gmail.com>
 <d23ea679-9c21-44da-86cf-ae97d0214b86@linaro.org>
 <CAFUsyfL=QfvtMb6TiWVa2cEyeYQobh_3zfYpnPEb7bq6FH1k1A@mail.gmail.com>
 <CAFUsyf+OjfFVJ80ZwL8SovH80nTA4qpNyr2Nh7uUW90jZifSGQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFUsyf+OjfFVJ80ZwL8SovH80nTA4qpNyr2Nh7uUW90jZifSGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

On 11/6/24 23:49, Noah Goldstein wrote:
> On Wed, Nov 6, 2024 at 3:30 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>>
>> On Wed, Nov 6, 2024 at 3:10 PM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 11/6/24 18:13, Noah Goldstein wrote:
>>>> Question about impl regarding handling of `-execfd` with/without a program name.
>>>>
>>>> 1) `-execfd` + program name ie: `qemu -execfd <some_fd> ls -a`.
>>>> 2) `-execfd` without program name i.e: `qemu -execfd <some_fd> -a`.
>>>>
>>>> Do you want to allow both of these? If you want to allow (1), what should
>>>> we use for `argv[0]`/`exec_path`. The program pass ("ls") or
>>>> `readlink(<some_fd>)`?
>>>
>>> The canonical response is, examine the kernel source.
>>> We're not implementing this in a vacuum, you're replicating execveat(2).
>>>
>>> I suspect the answer is (1), to be compared with
>>>
>>>       syscall(__NR_execveat, some_fd, "", &["ls", "-a"], env, AT_EMPTY_PATH);
>>
>> Err, I think the reference for '-execfd' is `fexecve`:
>> https://man7.org/linux/man-pages/man3/fexecve.3.html
>>
>> Which doesn't take a path. So I guess we just interpret the "ls" as
>> argv[0] but not
>> as "exec_path".
> 
> One more point, what should the behavior be if we have
> AT_EXECFD from binfmt-misc?

You mean precedence of AT_EXECFD vs the command-line option?

Arbitrary, since it would be a usage error to have both.  You'd have to do something silly 
with the binfmt-misc rule for that to happen.

Perhaps

static int execfd = -1;
// option processing
// main

     if (execfd < 0) {
         errno = 0;
         execfd = qemu_getauxval(AT_EXECFD);
         if (errno != 0) {
             execfd = open(...);
         }
     }

just because that's a simple change to what's currently present.


r~

