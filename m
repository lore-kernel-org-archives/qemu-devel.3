Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8113D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jnH-0005Cs-RH; Wed, 06 Nov 2024 12:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8jnG-0005Cj-8H
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:26:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8jnA-0002O0-TP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:26:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso595675e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730913962; x=1731518762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FeMphd33oUeVS3In4aDd1Vm7ZvrzrZ4BXrvYHWn65zk=;
 b=pRoOdA8aKhRbRZAcEMmlp4v2w43BC9aMx+Lqw6sU3Mm9w9CxDt1XqIZAQUuHYYxqjF
 bLtBTY5qpXCLbtQd9q5bSCTiH3vJo2QdzjaRDN0T10re20LY9goSxU6TzbjE86hDkCd5
 4g+UPgJ2dP0csEYukMOiaPM77CcGR1+D9E/AdGaZxF6J58kpHtYqquJXUddx0uTkOdNr
 4cmQYckzh+BgUJc9aaN7dTFJr1lJMeZooPdz4JCOQQ10YawlMOt3H7AUUZawzFREKcRR
 1M4TqKMw5SYydHvW9pHIZ7SboGYo4WckOQsOSAzElvnf2sXUmndrWBPwSz4Rsgnir7ft
 znxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730913962; x=1731518762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FeMphd33oUeVS3In4aDd1Vm7ZvrzrZ4BXrvYHWn65zk=;
 b=gBCLvrmrkuioWo+gIrUP8VZSTwYWhgxjCXA8XmTxfBTKmEOw+Z5EqBl9/tVCbfJbYj
 tsEqqNa/T6HUu1045Dxs+MEs0jXscwhWoP/sAR+YQqmGoQOf0nPLnYevAB93uV5C0i24
 tyh0JGcAvO+1Wzf8A9HVFc4lgWStM08T9mPiMkMl7nNagSYViaq2beANAsCAR0lhnPOb
 hmCxO/gpjEvxchMyUIt3E75u4JPpjCTYviz/OO8FWvQUVblnPxBilVobL7hv1hiIMT2i
 FTTTlq8QuUpYsXCGTPBP5mR+/2olMog+YUHlnCWa+t0dtNDNhkvz+zG7n13ICt/0Fu2d
 TnDQ==
X-Gm-Message-State: AOJu0YzfvJ2x2/2kAPsZOd6PsoIhMbXmyylBMGV6e44dH+9LNw8ex7Dr
 ul59sO2r1Kl8QSvWIdgDiY+YMUiVYDUAyR5H5qNuSwspn9igqB5BbtiALHX7NtY=
X-Google-Smtp-Source: AGHT+IF4flYdJlirNIY9JNHhMbQGThX1SSlsF/RtS+8qhkuQd1RtaZAuMBmcwXFTEH5rywhTJz9ocQ==
X-Received: by 2002:a5d:6c68:0:b0:374:af19:7992 with SMTP id
 ffacd0b85a97d-381c7a47487mr14708256f8f.7.1730913962407; 
 Wed, 06 Nov 2024 09:26:02 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6ae5dasm31606935e9.4.2024.11.06.09.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:26:01 -0800 (PST)
Message-ID: <e63cd5f6-8387-4c39-98e4-5e1c180934bc@linaro.org>
Date: Wed, 6 Nov 2024 17:25:59 +0000
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
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFUsyfLhPkSMrm50RAAvir2-WoRS4_jbtZf1WWR_WZvm=BOr6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/6/24 17:03, Noah Goldstein wrote:
> On Wed, Nov 6, 2024 at 3:38 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/5/24 23:54, Noah Goldstein wrote:
>>>>> You still need to handle is_proc_myself, for the guest binary.
>>>
>>> Would this by handled by basically do:
>>>
>>> ```
>>> if (is_proc_myself(p, "exe")) {
>>>           exe = exec_path;
>>>           if (through_qemu)
>>>               argp[argp_offset] = exec_path;
>>> }
>>> ```
>>> Or am I missing something?
>>
>> Something like that, yes.
>>
>>>>> I wonder if those two cases are related.  Do we need to also add an argument so that we
>>>>> can pass the executable to the next qemu via file descriptor?  I.e. execvat becomes
>>>>>
>>>>>        f = openat()
>>>>>        execv(qemu, "-execfd", f)
>>>>>
>>>>> and is_proc_myself uses execfd, which we already have open.
>>>
>>> How does passing a fd from one process to another work?
>> As long as the fd is not marked O_CLOEXEC, it stays open in the new process.  Providing
>> the number via command-line, or whatever, is sufficient for the new process to know what
>> is going on.
> 
> Err I guess I was thinking its a bit weird having an option that is
> only really applicable
> if qemu is a child process. I.e the `-execfd` argument is not usable
> from commandline.

qemu-foo -execfd 3 3< /some/file

Or perhaps opened via other tooling.

>> I now realize this is necessary for the AT_EMPTY_PATH flag, where we only have the file
>> descriptor.
> 
> We could also do something along the lines of:
> 
> ```
> fd = openat(dirfd, exe);
> char new_exe[PATH_MAX];
> char fd_path[PATH_MAX];
> sprintf(fd_path, "/proc/self/fd/%d", fd);
> readlink(fd_path, new_exe, PATH_MAX);

Reading the link doesn't always work.
Reading or passing the link means AT_SYMLINK_NOFOLLOW isn't honored.


r~

