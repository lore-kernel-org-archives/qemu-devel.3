Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78EEC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgNy-0007Bw-8F; Tue, 30 Jul 2024 02:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYgNb-00075g-P2
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:30:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYgNV-0001iI-N7
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:30:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4280772333eso1360195e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 23:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722321031; x=1722925831;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P9oPavX/7z0a45UqgW4nUWYoF5leLFs/JBSTe1bL/VM=;
 b=ViPPicBPIoPso3GSUJFMb1ekNk6yDQuvVG4IElUHbzCsBMnRZ2R1XIb5JAjv7IqdR4
 2FRLjWLvBOpoNcsPDpIAbloB55rC+Waxqm29R7L0xkG09tY32aBkcs73ohnsU8xaOL8H
 1FgB3rpxSlCx8Gw2sKp6BFPbT6/rBsgAhQA+fHd5kgwCm9QieWMVi2l3IaQLSSaKy8It
 WZxT1Kcz5ddSndrq/mjY+aGslZdFqey/IHQOgQXAzMcsMTcCoDDknSFs8FoWV3pOKZPM
 uukCbwzKhFFJTbxSgZlHHjQ+FiCeZ3nhzdRme5zHNtxcodYFrR/sJ6QWinI/A6QKlFsB
 IC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722321031; x=1722925831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9oPavX/7z0a45UqgW4nUWYoF5leLFs/JBSTe1bL/VM=;
 b=TTwMPKRwB9m+u0Jke4Ctf8meToJa0bWPiQOiBdXTSevP+jWE4b2XdBY5AAzkKDqXbI
 HofG7jWeFXrWoqcAoDd1WtWR811goqlepVjR07O5ze8YakDEHovrTK6omhuCx55RBWb/
 Jl81aYFQUHbLgeSZvx7drtr7QZtO5OnwvzxqeqQf5gZHG/7baBANWlnj5Ul3q2AcsDcy
 stp2Sqmk1mRHGjUDQMUcLYKjPMJZpSuhY+T4auPYyO/b04gj4er8oweafEzX8i8oqB4H
 R3UBHTbNUjvvLwkP7QtwIMSFXy+KmsyYXM/kqToVxKojhBOI2bkDWZMnG1LSm7aKIIiq
 25eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWErARYkDXlszuqqLq1ckpj+m4aXQRcjewQafAvT2+uuAmzsDzZ/jjebw4JeF05x5zQ03kkQbSfpwmb@nongnu.org
X-Gm-Message-State: AOJu0YxEQyDcJm2UYZHDiaWCmnp42VuFufPjFluJriEjaLrCUfMg+T3Z
 O3MUs39ojY6mWUQToUZXUajXsIF1TcCiDiGDqT6+a6tdOmJs8+r397wxo5ckqnw=
X-Google-Smtp-Source: AGHT+IHZSwWgXZIdT9VxHuFerwwBE5BeOec/mpo2nJXGXRD8VmH+tTAwbGefA4qBjaQOf5cEsiPofw==
X-Received: by 2002:a05:600c:3c89:b0:425:6dfa:c005 with SMTP id
 5b1f17b1804b1-42805440493mr69844685e9.2.1722321030559; 
 Mon, 29 Jul 2024 23:30:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280574a8a2sm205292155e9.23.2024.07.29.23.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 23:30:30 -0700 (PDT)
Message-ID: <8accf142-32ff-4d97-9229-e63c8aa897e7@rivosinc.com>
Date: Tue, 30 Jul 2024 08:30:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] osdep: add a qemu_close_all_open_fd() helper
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
References: <20240726075502.4054284-1-cleger@rivosinc.com>
 <0914a034-260f-44ef-8d75-2dca9d5fcb24@linaro.org>
 <94b658a0-21c1-4cd0-8bc5-21c0c71b9cb8@rivosinc.com>
 <38387ea5-fb29-430f-a83a-917ca74b8357@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <38387ea5-fb29-430f-a83a-917ca74b8357@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32a.google.com
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



On 29/07/2024 23:32, Richard Henderson wrote:
> On 7/30/24 00:20, Clément Léger wrote:
>>
>>
>> On 29/07/2024 16:00, Philippe Mathieu-Daudé wrote:
>>> Hi Clément,
>>>
>>> On 26/7/24 09:54, Clément Léger wrote:
>>>> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
>>>> POSIX"), the maximum number of file descriptors that can be opened are
>>>> raised to nofile.rlim_max. On recent debian distro, this yield a
>>>> maximum
>>>> of 1073741816 file descriptors. Now, when forking to start
>>>> qemu-bridge-helper, this actually calls close() on the full possible
>>>> file
>>>> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
>>>> takes a considerable amount of time. In order to reduce that time,
>>>> factorize existing code to close all open files descriptors in a new
>>>> qemu_close_all_open_fd() function. This function uses various methods
>>>> to close all the open file descriptors ranging from the most efficient
>>>> one to the least one. It also accepts an ordered array of file
>>>> descriptors that should not be closed since this is required by the
>>>> callers that calls it after forking. Since this function is not used
>>>> for Win32, do not implement it to force an error at link time if used.
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>> v5:
>>>>    - Move qemu_close_all_open_fd() to oslib-posix.c since it does not
>>>>      compile on windows and is not even used on it.
>>>>    - v4:
>>>> https://lore.kernel.org/qemu-devel/20240717124534.1200735-1-cleger@rivosinc.com/
>>>>
>>>> v4:
>>>>    - Add a comment saying that qemu_close_all_open_fd() can take a NULL
>>>> skip
>>>>      array and nskip == 0
>>>>    - Added an assert in qemu_close_all_open_fd() to check for
>>>> skip/nskip
>>>>      parameters
>>>>    - Fix spurious tabs instead of spaces
>>>>    - Applied checkpatch
>>>>    - v3:
>>>> https://lore.kernel.org/qemu-devel/20240716144006.6571-1-cleger@rivosinc.com/
>>>>
>>>> v3:
>>>>    - Use STD*_FILENO defines instead of raw values
>>>>    - Fix indentation of close_all_fds_after_fork()
>>>>    - Check for nksip in fallback code
>>>>    - Check for path starting with a '.' in
>>>> qemu_close_all_open_fd_proc()
>>>>    - Use unsigned for cur_skip
>>>>    - Move ifdefs inside close_fds functions rather than redefining them
>>>>    - Remove uneeded 'if(nskip)' test
>>>>    - Add comments to close_range version
>>>>    - Reduce range of skip fd as we find them in
>>>>    - v2:
>>>> https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/
>>>>
>>>> v2:
>>>>    - Factorize async_teardown.c close_fds implementation as well as
>>>> tap.c ones
>>>>    - Apply checkpatch
>>>>    - v1:
>>>> https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
>>>>
>>>> ---
>>>>    include/qemu/osdep.h    |   9 +++
>>>>    net/tap.c               |  33 +++++-----
>>>>    system/async-teardown.c |  37 +-----------
>>>>    util/oslib-posix.c      | 131
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 160 insertions(+), 50 deletions(-)
>>>
>>> I'm getting this error on msys2, not sure if related:
>>>
>>> WARNING: Failed to terminate process: 1 error occurred:
>>>      * failed to attach the runner process to the console of its parent
>>> process: The handle is invalid.
>>>
>>> I find your patch hard to review. Do you mind splitting as trivial
>>> changes? Something like:
>>>
>>> - Expose close_all_open_fd() renamed as qemu_close_all_open_fd()
>>> - Rework qemu_close_all_open_fd()
>>> - Factor close_all_fds_after_fork() in net/tap.c
>>> - Use qemu_close_all_open_fd() in net/tap.c
>>
>> Yes sure, I'll do that.
> 
> If you're making updates, I think you should drop the linux ifdef for
> /proc/self/fd.  This is also present on Solaris.  Importantly, it'll
> compile on all POSIX systems, whether or not /proc is available.

Acked

Thanks,

Clément

> 
> 
> r~

