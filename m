Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CBDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRFU-0001Bp-Db; Mon, 29 Jul 2024 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYRFR-0001B7-D2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:21:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYRFN-0004J0-1G
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:21:13 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d2357df99so54285b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722262867; x=1722867667;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=el/tjyLq93BoeSSvMNgAzWQN3+X5h196F75XbiH/mgk=;
 b=26DlpBtoW/ByMWSFls3Jr5ixLO56SO3ec2KfZVefDVCXZHu96wzQe0EddcmgG+OLXu
 S2hqCMrgoZQl9xG1SS0zYeaJJ8qEh+7wxhFZy9kGYIQL2pLbL43OPblaaN4qwDakXHBM
 Ln7TbUHMKqC7FwzBik14ZYqCzWSGdOi8L35LxUo+J+4NdD/nZW5z0HXi+fdsCN8nIph3
 jehlrMisNTNKQKwdJRW1VXNP8AC3DKGiz+TtxOlhaNAHTOgM5mXIWRcaDsES8gyrA9pK
 ftf/6ddGmZbxK/QuTW8jwGLq2ia6I8NjHLv0OncCyV1gO86TFO2ufmzR7hmNWN84DLbp
 oS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722262867; x=1722867667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=el/tjyLq93BoeSSvMNgAzWQN3+X5h196F75XbiH/mgk=;
 b=lWDMTUP9UyCnvlNZPiu4W+kXacnyHKx4nkvVdCBIUeClzEengmULmpydbnPY50EliP
 fWhxU+uC2e6oBiFCIo4R4xPBbqbkoPGz8DiHXH5Ce3dZWyRRLPYt+SFbwNJFFHcZfsVG
 2E8KHH0/MPPnknkEBEexDHA5l3FER5SuayTvKIpXssPkPMjka0aNE//D9ugIjtaIjXuZ
 EJO6rR99x9c5CXW80LtNxcJfoiRIrmc+APwXFZKyhVG6gXzry8RxXpCvUgAR7gKOZueH
 a97ZtGLeISF+K+PtVqtUPSEB04LpmmkbMC21uzO4pLG/ZYH9TeR4hOC4TbWtac1uK0Hp
 ANOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUT3BSirV8A1c89noYLyQp1TIHl1PylNkFcC5YIXzsBtUNarh58R8b09duJOXYdvgGftPAOXVGpr/7@nongnu.org
X-Gm-Message-State: AOJu0YyZwE5NP6vJ0znxuF6m3WkLFfSbC9GAUZM3GqQi4YSrj0uwYWAn
 N1wUXBSU6cERPlub0TF3PmmINmvrrrfjg6EoFUlYJYcocT8e5KYipTAa16gIaqg=
X-Google-Smtp-Source: AGHT+IG4pVXeb1sBzLcu3LOFbY1lXOUt6oEB3A51r7Vfp8okS2gR4qXh6b50ihtlUimwm8wzWWyxyg==
X-Received: by 2002:a05:6a00:9445:b0:70d:18e1:441c with SMTP id
 d2e1a72fcca58-70eac9ccfc0mr9146098b3a.2.1722262866848; 
 Mon, 29 Jul 2024 07:21:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead89e564sm6857025b3a.189.2024.07.29.07.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:21:06 -0700 (PDT)
Message-ID: <94b658a0-21c1-4cd0-8bc5-21c0c71b9cb8@rivosinc.com>
Date: Mon, 29 Jul 2024 16:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240726075502.4054284-1-cleger@rivosinc.com>
 <0914a034-260f-44ef-8d75-2dca9d5fcb24@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <0914a034-260f-44ef-8d75-2dca9d5fcb24@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=cleger@rivosinc.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 29/07/2024 16:00, Philippe Mathieu-Daudé wrote:
> Hi Clément,
> 
> On 26/7/24 09:54, Clément Léger wrote:
>> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
>> POSIX"), the maximum number of file descriptors that can be opened are
>> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
>> of 1073741816 file descriptors. Now, when forking to start
>> qemu-bridge-helper, this actually calls close() on the full possible file
>> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
>> takes a considerable amount of time. In order to reduce that time,
>> factorize existing code to close all open files descriptors in a new
>> qemu_close_all_open_fd() function. This function uses various methods
>> to close all the open file descriptors ranging from the most efficient
>> one to the least one. It also accepts an ordered array of file
>> descriptors that should not be closed since this is required by the
>> callers that calls it after forking. Since this function is not used
>> for Win32, do not implement it to force an error at link time if used.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v5:
>>   - Move qemu_close_all_open_fd() to oslib-posix.c since it does not
>>     compile on windows and is not even used on it.
>>   - v4:
>> https://lore.kernel.org/qemu-devel/20240717124534.1200735-1-cleger@rivosinc.com/
>>
>> v4:
>>   - Add a comment saying that qemu_close_all_open_fd() can take a NULL
>> skip
>>     array and nskip == 0
>>   - Added an assert in qemu_close_all_open_fd() to check for skip/nskip
>>     parameters
>>   - Fix spurious tabs instead of spaces
>>   - Applied checkpatch
>>   - v3:
>> https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/
>>
>> v3:
>>   - Use STD*_FILENO defines instead of raw values
>>   - Fix indentation of close_all_fds_after_fork()
>>   - Check for nksip in fallback code
>>   - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
>>   - Use unsigned for cur_skip
>>   - Move ifdefs inside close_fds functions rather than redefining them
>>   - Remove uneeded 'if(nskip)' test
>>   - Add comments to close_range version
>>   - Reduce range of skip fd as we find them in
>>   - v2:
>> https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/
>>
>> v2:
>>   - Factorize async_teardown.c close_fds implementation as well as
>> tap.c ones
>>   - Apply checkpatch
>>   - v1:
>> https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
>>
>> ---
>>   include/qemu/osdep.h    |   9 +++
>>   net/tap.c               |  33 +++++-----
>>   system/async-teardown.c |  37 +-----------
>>   util/oslib-posix.c      | 131 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 160 insertions(+), 50 deletions(-)
> 
> I'm getting this error on msys2, not sure if related:
> 
> WARNING: Failed to terminate process: 1 error occurred:
>     * failed to attach the runner process to the console of its parent
> process: The handle is invalid.
> 
> I find your patch hard to review. Do you mind splitting as trivial
> changes? Something like:
> 
> - Expose close_all_open_fd() renamed as qemu_close_all_open_fd()
> - Rework qemu_close_all_open_fd()
> - Factor close_all_fds_after_fork() in net/tap.c
> - Use qemu_close_all_open_fd() in net/tap.c

Yes sure, I'll do that.

Clément

> 
> Thanks,
> 
> Phil.

