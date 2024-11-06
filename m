Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64D5D44D41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8d1l-00055w-2r; Wed, 06 Nov 2024 05:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8d1i-0004xC-LT
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:12:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8d1f-0004Bf-Ss
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:12:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso55922715e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730887954; x=1731492754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3qE8rQuao7lnhN+cRNtlux0D4PWyrNP+SuujFo3WvSE=;
 b=XTUbtO8Cqwus2ufOK8B2Y9ydJP8YshBPKar3elD4CQGB81PT5vQjnRtXYd3m9FkhLu
 AXbQ+/1Sq1GWKtFL3FfsQM4/9xcOysVVA2d2M9WMSMqCcNF/GAHexNSOgk91Nr/UO28o
 cFe3urqO2alPiB2nCtjP1i0rcvEK/94+DP2ivtfORWwyZVS+2w9xu5YP0p6cvlx56NQI
 qnFgDH+32SdlFQB5koCNr40DnVuGxeEwwWrE2HsaGlGmzpYO1lWuqR5zU29W76wbMG9x
 qCVPUulffZX/oaVFabaN7rApC0YOyyF6X4JT46Cetw0uhWxZ8ipF6ZzUl/ehncRKb3yk
 RKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730887954; x=1731492754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qE8rQuao7lnhN+cRNtlux0D4PWyrNP+SuujFo3WvSE=;
 b=BXZuXaQLDHgP8nxR1npA2zZmkFxy/EDfHY2mOEpXhqq/rBV1kzpnd/LDlgLPaxxzX7
 226t9GL+U800lAXPGxs2+GgALzeJZb4JrNxnfyiLcS4aRgUb5Vi124Ypc4HqoDqI9Fse
 ctZ7NIqDZkY37aehT1Sc6GC7KAnj8VD0oeVndZ7jSOt9uIcz5wifzST82hHxVzfAVRpk
 kO0MV8vc7hY8BRIgDHmxXKGreR7KkviOPOV3qBYoSIJZ0K0wBxJnfokjzn3DQUdBZcGR
 iac/bkMg6MSZ0JaU2R2am5MTpJHXdbQRRcuqOWAUfPoWqNTCxp4xe/gu3Has8L6FPLbS
 hatg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEwXlU/9ajMBQz6K8d5tblwGdW+L1YpKY/aEFHaSXKFWuZGetcLk1TnU251y/TXR1ur/t6p0Fi0tzg@nongnu.org
X-Gm-Message-State: AOJu0Yze5aWisQBPaIl1i06PagewnTLQlHfeQG8y7bApcA57u/5Mq1i3
 Qykx8YgIOxH+bqkZ4MwrjkWeEGohEyPGn9VZ/I9NstjAF0aPqxm15xXpz9Qyrf48K7EOYaQbyU3
 eRRM=
X-Google-Smtp-Source: AGHT+IFZN5MrmIAVYEparsyYacIO83E/VYEVShcXoPAmwEbtatg+OWmnIbV0kUaMX9OyQZncRSM7Iw==
X-Received: by 2002:a05:600c:3b0e:b0:431:5f9e:3f76 with SMTP id
 5b1f17b1804b1-4327b6fd2b0mr191971725e9.16.1730887952047; 
 Wed, 06 Nov 2024 02:12:32 -0800 (PST)
Received: from [172.16.23.118] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6e70cesm16718075e9.35.2024.11.06.02.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 02:12:31 -0800 (PST)
Message-ID: <287d45b1-ce3c-4840-a685-ada84f57d32c@linaro.org>
Date: Wed, 6 Nov 2024 10:12:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix setreuid and setregid to use direct
 syscalls
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Riku Voipio <riku.voipio@linaro.org>, qemu-devel@nongnu.org
References: <Zyo2jMKqq8hG8Pkz@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Zyo2jMKqq8hG8Pkz@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/5/24 15:15, Helge Deller wrote:
> The commit fd6f7798ac30 ("linux-user: Use direct syscalls for setuid(),
> etc") added direct syscall wrappers for setuid(), setgid(), etc since the
> system calls have different semantics than the libc functions.
> 
> Add and use the corresponding wrappers for setreuid and setregid which
> were missed in that commit.
> 
> This fixes the build of the debian package of the uid_wrapper library
> (https://cwrap.org/uid_wrapper.html) when running linux-user.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 59b2080b98..0279f23576 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7233,12 +7233,24 @@ static inline int tswapid(int id)
>   #else
>   #define __NR_sys_setgroups __NR_setgroups
>   #endif
> +#ifdef __NR_sys_setreuid32
> +#define __NR_sys_setreuid __NR_setreuid32
> +#else
> +#define __NR_sys_setreuid __NR_setreuid
> +#endif
> +#ifdef __NR_sys_setregid32
> +#define __NR_sys_setregid __NR_setregid32
> +#else
> +#define __NR_sys_setregid __NR_setregid
> +#endif
>   
>   _syscall1(int, sys_setuid, uid_t, uid)
>   _syscall1(int, sys_setgid, gid_t, gid)
>   _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
>   _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
>   _syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
> +_syscall2(int, sys_setreuid, uid_t, ruid, uid_t, euid);
> +_syscall2(int, sys_setregid, gid_t, rgid, gid_t, egid);
>   
>   void syscall_init(void)
>   {
> @@ -11932,9 +11944,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           return get_errno(high2lowgid(getegid()));
>   #endif
>       case TARGET_NR_setreuid:
> -        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
> +        return get_errno(sys_setreuid(low2highuid(arg1), low2highuid(arg2)));
>       case TARGET_NR_setregid:
> -        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
> +        return get_errno(sys_setregid(low2highgid(arg1), low2highgid(arg2)));
>       case TARGET_NR_getgroups:
>           { /* the same code as for TARGET_NR_getgroups32 */
>               int gidsetsize = arg1;
> @@ -12264,11 +12276,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>   #endif
>   #ifdef TARGET_NR_setreuid32
>       case TARGET_NR_setreuid32:
> -        return get_errno(setreuid(arg1, arg2));
> +        return get_errno(sys_setreuid(arg1, arg2));
>   #endif
>   #ifdef TARGET_NR_setregid32
>       case TARGET_NR_setregid32:
> -        return get_errno(setregid(arg1, arg2));
> +        return get_errno(sys_setregid(arg1, arg2));
>   #endif
>   #ifdef TARGET_NR_getgroups32
>       case TARGET_NR_getgroups32:
> 

Queued, thanks.


r~

