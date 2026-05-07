Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592A0CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL0yC-0002SH-Mr; Thu, 07 May 2026 11:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL0y3-0002Rv-Af
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:48:57 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL0y1-0002n7-1z
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:48:51 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-65890a6ca20so1053741d50.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168927; cv=none;
 d=google.com; s=arc-20240605;
 b=IdJwqc6S4G0aaUm/w3cV3+im9JaVC86NGZuS6yq76Nlbpga2Fus9uqu2bJTuVxyFk2
 wclglPhmaXZRCxoJdnwbGGbSP5+0yBSgusaCHBaZPyFkUBXuYuojkOi2oeg24ACg4YkV
 Dccd352TKxaCsBYEsN3Eq84cyE8QPr3GnV2wgFMwkc/GcVhmGJAxxSydINLvH/uxqr/V
 WJl76GjQvi/X4xtDwcYqkzj3UYGX/8kI4MpEAjiSkw2qtA+x9uF25sOoUH5Wu2DJzkZE
 3ayRYyPC/x6cUzVj6ld7+5sT5xOfYngHFY34zH0+BRr5pqbW1bEO42JlneaxEAzHTHY+
 qXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y9rJ2SsWHQ1XKMw+WlNYtefjusOS6q6H0gbOFFsDlm0=;
 fh=HWJ1fnnvXaPPyXeasJRfYDJB1INk2GetGWF0RmO6+0U=;
 b=ZQLAHTy8r++CS4ySoJgHJABCPrnoH1PuCE4Ta6YNcj0ai+HZcjerGuKw0b4oC3Rl3z
 pvLybYHuLG/5e9LgxzfGtMmj2lVgTWu9ZdSRIR21u6PG+50R4l3LDKPTpU+98Ai1e4ey
 uEdxlQF+mlkM9e3+3MXVix/o0UV8kLzn5DUvgkX+xkRaKcB1oZ+DuU1moRVR9eHrFmox
 N+fIfIMDUYMrp+UQpmnMfUZcFUThVigsiAAVHIWl5H+85UtzGvkvo03TsIPozJzoVYMx
 ZGRDCzWgsiWw8wMgMaS4tImLuLvWwtQELBdg37Qjikn6j3E/Lq9mByOhqDN8TdS6MH22
 PSGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778168927; x=1778773727; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9rJ2SsWHQ1XKMw+WlNYtefjusOS6q6H0gbOFFsDlm0=;
 b=uUlZmMewUa+hjMtjwfJqYst8C7+2MBGV4k4xytNQUH8aecmKbdJQvBNGH27vDHlF7g
 17xHyKpMi7D8zMocPXgFeAl5gtWLaVzvYGY2FGozB9sB0/jX65EwOTpFZ0QDndjoj1L7
 KS4x5QCiCalRjl3JuwuxEqKX1f97SLBYsNEoa4xg/j9SjkymJkLTW6bRihGL6rhkfGOZ
 cwzAmdcNtQsDkK8lMZB9dsHKSU3EsqZISikA23uH89wQ1tAPDowXCVhU1gOgF+FRcSjs
 RpflG04M++CE8dqtfqzx4n+PKWN5j6IdKr3r9NDm05/JB3NL+xOLigbJSPaP70hhoo5E
 i3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168927; x=1778773727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9rJ2SsWHQ1XKMw+WlNYtefjusOS6q6H0gbOFFsDlm0=;
 b=djm1wViGIrVCpU+f2ERRtvF27bxnPLtZqZT3u90FOY1vZgA5tD8wUZJhXQ5yN88Kfx
 4MmJJ+YeewKpwmn23yWxxINgjkjVNuiY6c6EBiCxW+ntCGLWlifMnpdxh6ZfO8CANXyY
 VdeJ54dkym3H/6lPPjAEENcOHMkx4qPD2Q3vkpwOHHJnLDzVdnYRYAaEttV2BXtxhiHT
 IDyL5tak76RcEMocAe9DN9GJ9yaCqnKlpTZFBBUgEydjmuCucoOefBFWKQpUguNdPsk1
 u68iqzSvsnRJP4hhSjnmxUcvgY86dotRwG3lTq2ZQSco9Yp+2VYVaskLJDz01WFfmFo6
 bdCA==
X-Gm-Message-State: AOJu0YzIbqHclfRq29CSr1jPvCs06i4Q4ZX6aqkezSi1Vfn4GK/Ukhaz
 FcdNg0S2Jhw6QXDLm+9xoxSs+Cpqg1BvV7yRuDyZ7D4XV/kr8t4L/Ias9tgNT4E3Kn81EO6xz91
 6GOFB6fZrbteTM6OlYtpp8a2LVCMwOjmwhft/0vNHpA==
X-Gm-Gg: Acq92OGaHLCBa5eQ6YKqrQ8MJ/p61SucbISofLdIm9XF1u9px1ZRE0QCsf5D1XRlwkT
 xVPjo343/IZa6eTVE763w82Ao4n6hBOpsleSCyqqOr3X6j1GvfsXUOEJiF33zDVC+ug7qMjRsey
 z0xVW473VZVzd0Rx6YaeIT5chLvYcMCfnczCR+X2CxGQwv7GxuDIecOiJ+g3ajEBF0wg1tYsuUX
 1FvrpwFVa12d4Pnzqjb27qx6LL3rTJBRHKs79CW5+PL5tsC00K+8nw+cGMJ5zNDW+tK8vGy0YQC
 Uwhrrqx/iyQcTnuN2pdEaSzQzbOK25cPSfrKCJt5OQqlN1oUNlYq+VjmrhFN81X2tgUhAyKhpof
 6Q9+eb7BQuq8x
X-Received: by 2002:a05:690e:d0b:b0:651:bb21:e7fb with SMTP id
 956f58d0204a3-65c79ee651cmr9445413d50.54.1778168927382; Thu, 07 May 2026
 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-linux-user-bug-v1-1-25831e9bc22e@bsdimp.com>
In-Reply-To: <20260507-linux-user-bug-v1-1-25831e9bc22e@bsdimp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 16:48:35 +0100
X-Gm-Features: AVHnY4KOSrmSoEPvJvFhzUkZ2N3PRjV4Uz9vmWleYULhXcaC0o3OqwYNl-_3oOs
Message-ID: <CAFEAcA-ro3NjfPUj2A5odFCJOtdL5MV_V1bq5zuiPwyTFWo7Xg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix a memory leak when pthread_create fails
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 7 May 2026 at 16:20, Warner Losh <imp@bsdimp.com> wrote:
>
> Fix one of the TODO items when creating a new thread: release the copied
> cpu and free the task state.
>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Free the new task state and drop references to copied cpu structure when
> pthread_create failes.
> ---
>  linux-user/syscall.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d3d9fffb54..7b2e32bcf5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7005,7 +7005,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>          cpu->random_seed = qemu_guest_random_seed_thread_part1();
>
>          ret = pthread_create(&info.thread, &attr, clone_func, &info);
> -        /* TODO: Free new CPU state if thread creation failed.  */
>
>          sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
>          pthread_attr_destroy(&attr);
> @@ -7014,7 +7013,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>              pthread_cond_wait(&info.cond, &info.mutex);
>              ret = info.tid;
>          } else {
> -            ret = -1;
> +            ret = -host_to_target_errno(ret);

This is an unrelated bugfix to the one in the commit message.

I found do_fork()'s error handling confusing (the comment at
the top doesn't exactly clarify either), but I think it is:
 * might return a negative target errno value
 * might return -1 with "errno" set to a host errno
 * might succeed and return 0
 * might succeed and return some other not-minus-1 value

The callers all do
   return get_errno(do_fork(....));
which handles these cases.

It might be less confusing overall if we simplified this to:
 * returns negative target errno value on failure
 * otherwise success, returning value the guest expects
and dropped the get_errno() at the callsites. The only
cases that don't already follow one of those two options are
the "pthread_create() failed" one (which is buggy currently
since pthread_create() doesn't set errno) and the "fork()
failed" one (which relies on the "return -1 and caller fishes
error out of errno" handling).

> +            object_unparent(OBJECT(new_cpu));
> +            object_unref(OBJECT(new_cpu));
> +            g_free(ts);

For TARGET_AARCH64, the gcs_new_stack() call we did before
attempting the pthread_create() maps memory into the target
address space, which needs to be undone. Compare the bit in
TARGET_NR_exit handling which does:

#ifdef TARGET_AARCH64
            if (ts->gcs_base) {
                target_munmap(ts->gcs_base, ts->gcs_size);
            }
#endif

We could maybe share code between the NR_exit "free stuff
for this TaskState" and this error-exit path, though it's
a bit awkward so I'm 50:50 on that.

>          }
>          pthread_mutex_unlock(&info.mutex);
>          pthread_cond_destroy(&info.cond);

thanks
-- PMM

