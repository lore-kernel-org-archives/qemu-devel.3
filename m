Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB95CA0ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 01:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjqmv-0003rh-LP; Thu, 29 Aug 2024 21:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjqmm-0003qr-3w
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 21:50:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjqmj-0000rS-ND
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 21:50:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d3c5f769d6so865637a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724982643; x=1725587443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsiPnoZUwtAC9MF6+foD6fQyvbYyfnwyKY00ReEe34k=;
 b=Q4L39psBkp6AVdIpfrhezRqMpRDMnnZH/U1UwxnEOJIYpknxVeS9YFXhYICjU7/Cmv
 rL4FwMtIC709bjFslw+qVpIpI7umzQ7M3qZRMFL30DLH8abv+5jYOVMIcCYpXpl7cCzE
 7qu6C7uGV85sdPnKXjoNhXsJ5RNdjgoEfJF0zISgYjzXBjoZEp+8JvTBihv2NwIUHL3z
 3u4x0k1uJ6iEtUJZudbHa1BJALaJ1OIbfqlZJWZ3n4pN/o/3tPpsSrOFbhjeQvV+a5hq
 615UQNwplOcyHY8cREMRoBDLep7uhzARDUeHyTjV0Fsy09wgECruQRNWaXiX+rBF1Q5Z
 bueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724982643; x=1725587443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsiPnoZUwtAC9MF6+foD6fQyvbYyfnwyKY00ReEe34k=;
 b=bagQZQvzXwiMxq+yQy2NGDgyBxlZ2GOl1AToop2ddnVvvn3aEN8bBmn30l9MZvGkYd
 I3gOIDTXsUYpukSOV3qRxd/0HsTQu1KFcbFNF2CxRrfi1S6gcgtVcSfL6DziBx3lJR4t
 UjKsaQ9/MOzV2ACDXgJhJ3KANEUYMO7RRd/fbXb6Eq4QQAZu+xd9ODlMrFjPhwn8xntT
 ty0nqSTxs7kGOW3dM/dbXgXSR+bkk8eP+lwp6Xaeko4mCwPI0+FZqMdnN5XY29VOWMhm
 p+x7NilZ7hvAXK4hNItTqm5QKoVBZu5Fp73ZShV8BWU1nJtawUnNpQvgzbXCjatMdmNH
 x3LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpn+bBCj6HnXeX0sGSCc0tEK2LVzmlR1PwV6SXwhQCJMNk2nu8yzcPgKJfQm5ySIV8lTxM9FWxXxJv@nongnu.org
X-Gm-Message-State: AOJu0Yw3oLPkQc1SFJczbnTTLzEtRO6nJd7Hgv/oK1d19fETjyxWfua6
 ntc76ancY84LE50GYEul8tRhg/XOlJW1RWZ4zWuhixh3n9E44w04u9H4m4RK4kk=
X-Google-Smtp-Source: AGHT+IH/ynA9qVQaAxPGrh73bpQ9EEEqcMY0OhZubbPX+ZJJvhainZn9ypX68tq5HAoxfTbALkxtYw==
X-Received: by 2002:a17:90a:d503:b0:2c9:e0d3:1100 with SMTP id
 98e67ed59e1d1-2d8561e17a0mr4722783a91.19.1724982642666; 
 Thu, 29 Aug 2024 18:50:42 -0700 (PDT)
Received: from ?IPV6:2001:8004:5100:1c02:ebfa:4ec3:db14:ac19?
 ([2001:8004:5100:1c02:ebfa:4ec3:db14:ac19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3b1csm4944740a91.54.2024.08.29.18.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 18:50:42 -0700 (PDT)
Message-ID: <6cfdb895-d13b-42d6-baad-1ee6022b786c@linaro.org>
Date: Fri, 30 Aug 2024 11:50:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] linux-user: add openat2 support in linux-user
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
References: <20240829144413.6942-2-mvogt@redhat.com>
 <20240829144413.6942-4-mvogt@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240829144413.6942-4-mvogt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/30/24 00:44, Michael Vogt wrote:
> +static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
> +                              const char *fname, int flags, mode_t mode,
> +                              bool safe, bool *use_returned_fd)
>   {
>       g_autofree char *proc_name = NULL;
>       const char *pathname;
> @@ -8362,6 +8371,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>   #endif
>           { NULL, NULL, NULL }
>       };
> +    *use_returned_fd = true;
>   
>       /* if this is a file from /proc/ filesystem, expand full name */
>       proc_name = realpath(fname, NULL);
> @@ -8418,12 +8428,87 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>           return fd;
>       }
>   
> +    *use_returned_fd = false;
> +    return -1;
> +}

Why is -1 insufficient for signalling "do not use"?


> +
> +int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
> +                    int flags, mode_t mode, bool safe)
> +{
> +    bool use_returned_fd;
> +    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, flags, mode, safe,
> +                                &use_returned_fd);
> +    if (use_returned_fd)
> +        return fd;

Braces are required.  Use scripts/checkpatch.pl.

> +#ifdef HAVE_OPENAT2_H
> +static int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *fname,
> +                            struct open_how *how)
> +{
> +    /*
> +     * Ideally we would pass "how->resolve" flags into this helper too but
> +     * the lookup for files that need faking is based on "realpath()" so
> +     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
> +     * be honored right now.
> +     */
> +    bool use_returned_fd;
> +    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, how->flags, how->mode,
> +                                true, &use_returned_fd);
> +    if (use_returned_fd)
> +        return fd;
> +
> +    return safe_openat2(dirfd, fname, how, sizeof(struct open_how));
> +}

I don't think this needs to be a separate function.
We did that for do_guest_openat for gdbstub.

> +
> +static int do_openat2(CPUArchState *cpu_env, abi_long arg1, abi_long arg2,
> +                      abi_long arg3, abi_long arg4)

You might as well name the arguments properly, and use abi_ptr/abi_ulong where it makes sense.

> +{
> +    struct open_how how = {0};
> +    struct target_open_how *target_how = NULL;
> +    int ret;
> +
> +    char *p = lock_user_string(arg2);
> +    if (!p) {
> +        ret = -TARGET_EFAULT;
> +        goto out;
> +    }
> +    if (!(lock_user_struct(VERIFY_READ, target_how, arg3, 1))) {
> +        ret = -TARGET_EFAULT;
> +        goto out;
> +    }
> +    size_t target_open_how_struct_size = arg4;
> +    if (target_open_how_struct_size < sizeof(struct target_open_how)) {
> +        ret = -TARGET_EINVAL;
> +        goto out;
> +    }

These checks should be in the same order as the kernel:

SYSCALL_DEFINE(openat2)
     usize < HOW_SIZE_VER0 -> EINVAL
     copy_struct_from_user(how) -> E2BIG

all come before examining the path argument.

> +    if (target_open_how_struct_size > sizeof(struct target_open_how)) {
> +        qemu_log_mask(LOG_UNIMP, "Unimplemented openat2 open_how size: %lu\n",
> +                      target_open_how_struct_size);
> +        ret = -TARGET_E2BIG;
> +        goto out;
>       }

 From copy_struct_from_user you're missing

         } else if (usize > ksize) {
                 int ret = check_zeroed_user(src + size, rest);
                 if (ret <= 0)
                         return ret ?: -E2BIG;

It's not just testing the size, it's reading the following bytes and checking for zeros.

It would be worth adding a helper function for this, matching the kernel.  I'm sure there 
are other places in linux-user that should be doing the same thing.


> +    how.flags = target_to_host_bitmask(target_how->flags, fcntl_flags_tbl);
> +    how.mode = tswap64(target_how->mode);
> +    how.resolve = tswap64(target_how->resolve);

With a linux-user copy_struct_from_user, I expect you'd swap in place:

     how.mode = tswap64(how.mode);

etc.


r~

