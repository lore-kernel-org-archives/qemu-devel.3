Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D72C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 01:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjTsq-0002Dg-HM; Wed, 28 Aug 2024 21:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjTsm-0002D5-LF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 21:23:28 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjTsk-0003wS-1k
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 21:23:27 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5df9542f3d8so126802eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724894604; x=1725499404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E+WDp2D4nE6W9Nuwv43d2wVKCu8fmhkAHih+gzhvH08=;
 b=ZFlJvLMiV9i2yeXcbsubRLq3THkCzUBszwa1US8kyNraGOIdU4GzFPBOt3P3RTb57t
 iVCMqpCIN6WnXb5FAMapPHLKLc92vNIWi/0K0M2ERN1mQ0L4VoUYq4441d50fAKiOPrf
 lvFVwe9WHLRovHuxX8j2JH96+cH1b3Kpcp8OyURMkkt+sxLmxbjyg8iOmMh/8S7jzemn
 KG80mRI88VJx2N7NL/39my/TmIF9AZRKGUN1GaMC8ZmHDwCpTyVmF4Ve7DJ8oQ8b5laO
 cUFG5qlYHOxVCAN9a6TBYnUnW5Az0a/ePZ4VwSbmq9C8MOaRErjr+F3mnWtOAUqX2l2+
 hs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724894604; x=1725499404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E+WDp2D4nE6W9Nuwv43d2wVKCu8fmhkAHih+gzhvH08=;
 b=A1sqL7+OHA9JR/1wimtkrFje2URmHfF9tDmpf8Qz3kiNb9637gCw+Pu/zNb14BvR/E
 E59m+OzrXc36Quhroe3ds0/ZXxBkXyYSr4C/qVkWgklSQNktWduMRlGo0E2Dkk+qLQjn
 /ws9wHgSedgZ+Nny0UGjL66Xn7+B1c/C9mau9Wi+jgGkEmGuUy+F1tokoNYgmp6vAeAJ
 SQyPmJmwS8N1W7kgBx/Vw6WHXCaOQO0/eum8fp9m6SrRDx2287KrsA9jfYdHeEDCOXiq
 qdMH9utiLtjH9WLYVWr8HpNH377vfcWY0mTa/1VIj2Hgd5YKiyjg8uTr7JTjcbQ3X+kz
 64UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCKm4Nbi4DE8dyXob2QUoyOq0SegpRjNTjekJdkh2gVshtDXp7mBZncuvDnTRC+r+3fbbVMHuKTfPR@nongnu.org
X-Gm-Message-State: AOJu0YyG6ksfJbh8nvqUv0kuYTwMPRjCmVSrrjh5GT0bm6dosGRNc2W1
 n+kABpRMYBXejbnbn0AAhR08ksRT91db3LHiHVMLiijwYtiVIwi7LAbBmVUc02A=
X-Google-Smtp-Source: AGHT+IHPRWGxICm8ZbBPC/zrxsZ1zqoDH8fhEGyzbnTUQQDp63hljg2HWutcf9yq7V2377Aqpa0kwQ==
X-Received: by 2002:a05:6820:150f:b0:5c4:7b18:b8eb with SMTP id
 006d021491bc7-5df97eb0c15mr2012041eaf.2.1724894604243; 
 Wed, 28 Aug 2024 18:23:24 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dfa0552665sm27557eaf.37.2024.08.28.18.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 18:23:23 -0700 (PDT)
Message-ID: <93b34a5e-c6b0-495b-9ab4-d797e679c414@linaro.org>
Date: Thu, 29 Aug 2024 11:23:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: add openat2 support in linux-user
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
References: <20240828144227.32977-2-mvogt@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240828144227.32977-2-mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/29/24 00:42, Michael Vogt wrote:
> This commit adds support for the `openat2()` syscall in the
> `linux-user` userspace emulator.
> 
> It is implemented by extracting a new helper `maybe_do_fake_open()`
> out of the exiting `do_guest_openat()` and share that with the
> new `do_guest_openat2()`. Unfortunatly we cannot just make
> do_guest_openat2() a superset of do_guest_openat() because the
> openat2() syscall is stricter with the argument checking and
> will return an error for invalid flags or mode combinations (which
> open()/openat() will ignore).
> 
> Note that in this commit using openat2() for a "faked" file in
> /proc will ignore the "resolve" flags. This is not great but it
> seems similar to the exiting behavior when openat() is called
> with a dirfd to "/proc". Here too the fake file lookup may
> not catch the special file because "realpath()" is used to
> determine if the path is in /proc. Alternatively to ignoring
> we could simply fail with `-TARGET_ENOSYS` (or similar) if
> `resolve` flags are passed and we found something that looks
> like a file in /proc that needs faking.
> 
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> 
> Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
> ---
>   linux-user/qemu.h         |  4 +++
>   linux-user/syscall.c      | 73 ++++++++++++++++++++++++++++++++++++---
>   linux-user/syscall_defs.h |  7 ++++
>   meson.build               |  1 +
>   4 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 2e90a97175..47b6d7da88 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -164,6 +164,10 @@ struct TaskState {
>   abi_long do_brk(abi_ulong new_brk);
>   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
>                       int flags, mode_t mode, bool safe);
> +#ifdef HAVE_OPENAT2_H
> +int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *pathname,
> +                     struct target_open_how *how, bool safe);
> +#endif

Not needed.  The only reason do_guest_openat is declared here is for gdbstub/.

> +#ifdef HAVE_OPENAT2_H
> +#include <linux/openat2.h>
> +/* glibc has no header for SYS_openat2 so we need to get it via syscall.h */
> +#include <sys/syscall.h>
> +#endif

No need for sys/syscall.h, handled by safe_syscall4.

> +#ifdef HAVE_OPENAT2_H
> +int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *fname,
> +                     struct target_open_how *how, bool safe)

No need for safe argument, that is only used by gdbstub/.

> +{
> +    /*
> +     * Ideally we would pass "how->resolve" flags into this helper too but
> +     * the lookup for files that need faking is based on "realpath()" so
> +     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
> +     * be honored right now.
> +     */
> +    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, how->flags, how->mode,
> +                                safe);
> +    if (fd >= 0)
> +        return fd;
> +
> +    if (safe) {
> +        return safe_openat2(dirfd, fname, (struct open_how *)how,

This cast is an indication that you're doing something wrong.

> +#if defined(TARGET_NR_openat2) && defined(HAVE_OPENAT2_H)
> +    case TARGET_NR_openat2:
> +        {
> +            struct target_open_how how, *target_how;
> +            if (!(p = lock_user_string(arg2)))
> +                return -TARGET_EFAULT;

No assignment within if.

> +            if (!(lock_user_struct(VERIFY_READ, target_how, arg3, 1)))
> +                return -TARGET_EFAULT;
> +            how.flags = target_to_host_bitmask(target_how->flags,
> +                                               fcntl_flags_tbl);
> +            how.mode = tswap64(target_how->mode);
> +            how.resolve = tswap64(target_how->resolve);
> +            ret = get_errno(do_guest_openat2(cpu_env, arg1, p, &how, true));
> +            fd_trans_unregister(ret);
> +            unlock_user_struct(target_how, arg3, 0);
> +            unlock_user(p, arg2, 0);
> +            return ret;
> +        }
> +#endif

Move all of this code into the helper function for clarity.

Missing validation of small arg4 (EINVAL).
Missing validation of zeros for large arg4 (E2BIG).

The 'how' variable should be the host open_how structure.
Then you don't need the incorrect cast above.
Missing a zero of the structure, which in the future might contain extra fields.

Given linux/openat2.h appeared in linux 5.6, we might be coming to the point at which all 
supported host os must have it.  Otherwise, are you using anything besides struct open_how 
itself?  Perhaps we're better off always defining the structure locally, so that way it 
cannot expand on us with a mere upgrade of the system linux headers package?

> +/* from kernel's include/uapi/linux/openat2.h */
> +struct target_open_how {
> +    __u64 flags;
> +    __u64 mode;
> +    __u64 resolve;
> +};

Using host __u64 is always wrong for target structures.
Use "abi_*" types for target alignment requirements.


r~

