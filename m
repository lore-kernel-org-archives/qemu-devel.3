Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DDDFED3C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGku-0008SX-7W; Fri, 24 Apr 2026 09:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGGks-0008SP-Io
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:39:38 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGGkq-0005EB-Tz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:39:38 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7991db3dc98so87393437b3.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777037975; cv=none;
 d=google.com; s=arc-20240605;
 b=Dum2ZZqOIkcIVI4xHFRO0B+k3mjOZvilShkZ/rl+RVPwHinWK4+Q8ywcvuanXUVVDq
 g3gvEpoWaZxktS8OiS3X7/mg2GS/cmypofRV3HAvVhj1GzuXeaTuij7vkdHkTkBtNI0l
 9bJ0Zf4lwLLxX5UOWscRUnz+D7jzqdYWaoNLwSbS35bidZ6oDSckcHNZ6YIrfekFaugN
 oJeIpm/yCpyKytMVq8OXGPK2GcTztOEhbGWP3fudJ7GoBJPfpDFk+SC7lwBluw0rxbOl
 yu4ymskqe1BpHd0PCWh/YC5E7ldTJk0pH2bxc+bob5t08ZBPod3sBDaZ86o62UXcv17e
 XBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ekbPNVgaMNbPOpJ4VxNU8p+zLsXRMHuJ7BqGzI6plbM=;
 fh=twdMwO8HtYA0tKWE7ZrcLTTV93JyaLUwFo/XJNgsMPI=;
 b=Q3jfDR37J62qvHUmrBeUFuvIvZWyYkWnxVtisf2IMvEZNx4loGvcvEliYSlKz+KQUU
 RkmyWobbTxJebyv3wjFjaQ6PRRLGfFR/I+txsjvCIlC8nzwkoMl5yF6Nl8DbsXqHZucI
 ZQqOMDfkquFht+4v48fAdKilx+3YtflBtPAkO5HGvOn6x9gI0w2OinlD3EkijylT0dJN
 sc8xYrUJ2DySSTC2DCU+d4mq0snNYoBnKLyHPj00jgugIRCiBxVD52xhUp2LscSxPaHf
 tMqEWD5sqHEJvXgRx0wvJe5tguOpOo5Pe66rh+zYLd0zw1wmaWANB04qGhdV6NcK1i4U
 ieVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777037975; x=1777642775; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ekbPNVgaMNbPOpJ4VxNU8p+zLsXRMHuJ7BqGzI6plbM=;
 b=ZB0KZQjEPbMm4uKMYogyik05Q8BnM89esqOAsxtCUH81QX2XdwsaQwiqb0+oP1oECY
 R82A157iORfIhYplJRhjGqAfG45CfQbow6MQfolba4dK4Y4RfZQ9Xc+UbA9QtyaLb7gO
 PsToQGxQ0sG3WLbKzo0NilncdBnQtuwGpHeC6noXZziNiB3jbU7AJYfLwNr1x3/6UV/4
 1VvmCiI1zdiO7BexXT6WGZQAbVDBpUOjVzGMuxTfKJ3NVgZ9SqqMG7fKdE4wpcsz2Dix
 1ZETj+KRNumDQqUWAnwKsGtST/R1KyvAJ8g38Hcuks5lh3u8tVrXBt80hozUaEK3/2zj
 6lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777037975; x=1777642775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekbPNVgaMNbPOpJ4VxNU8p+zLsXRMHuJ7BqGzI6plbM=;
 b=elutGlJWidswu0cwqPTJmlWOUsz6VJ6Ip2q4MMpgSaVkwLDJquK8azO5UxnXtzbJgc
 91cyIbmCeDBuZobgGRD0U+MLEfxLGh3FI3MahpC+VIyJvbDmEZX6QdhlwQpm35UxkE4f
 zCltsfMp+q1hBpQhJgTYjq/uXmW7oqJzabNO+4Zmtl+QjAP2ur2XwdZjnXXrCvekY9BJ
 zI3kOHDgwJdPhc19Oud0a9qetQQK2V7RBxeLkF45ZDJasoae9yOfO09jGktVsxF7j7vt
 1T4EHC9T4TTOCELcWu0k8IaG9GExUlKLB4JfkXq0dC/yNYLosI/isJc0No0ElOTw6y4c
 /ICg==
X-Gm-Message-State: AOJu0YzEqXETG1x5N+JOXUSsfnlUTtMcQS1wHxJq84IzqKIEqm6Y1ARP
 P4JFTDpoeAlXehLG0esuxP9Fn3xPIocE9Dhi/WJtjd/Fia6Ajj1mjvuOhUA1J94yQqRp0EGCdnc
 LQObSO8VUse6DRbFYAdH2aBsX8qhtBi/bTAElqGE3gw==
X-Gm-Gg: AeBDietatiCVqB7Q5l0hbCTfrKPWZPT/lDXKs3HLuhzJLtCih0bMtls8bE3IEGyr5kH
 fKVAlUzI4Q5m8fHVUIM8PB7nzq4muophpnzDR7yT8LEtsGzF42mPONDYqX4RJ1HxRURrHWWxeMw
 ldwZCre97z97PI/XFxfzmHvWxGEqngwiDF46xNHsWSixzoSP1M8gYNqpHvir6Ggxv4BCn29wRL0
 zJKlTq5c/2hmG6bUbHF25aeAuSJubon4b1muIaRvNqpPnYCO3Q21WmaQ0DH99JHEx/Q/orM2c+x
 NNLlVdn8E3fTGENRHJMiMukujy6V6NzvP8v0lz5VUa/c5rcuuM1SIYzImVVryXPa3XYC9rNt0rA
 yjw==
X-Received: by 2002:a05:690e:15c8:b0:64e:e380:c841 with SMTP id
 956f58d0204a3-65310a5f662mr21087934d50.50.1777037974833; Fri, 24 Apr 2026
 06:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260424132824.27733-1-deller@kernel.org>
In-Reply-To: <20260424132824.27733-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 14:39:22 +0100
X-Gm-Features: AQROBzANEpHJyXAZ4stC0FAQiCxmf5jeMYEPReJBUkZMOHaYYZMSF8YznxLfn2k
Message-ID: <CAFEAcA-CwZZrSVHE5qPSGw0gCM_0Nh6e5X5-W_EDSSkv62LAyQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix CLONE_PARENT_SETTID when using fork-like
 clone
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 24 Apr 2026 at 14:28, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The CLONE_PARENT_SETTID option requires the implementation to store the
> child thread ID at the location pointed to by parent_tid in the parent's
> memory.
>
> Fix our implementation and move the code from the client side (where
> fork returned 0), to the parent side and store the return value from the
> fork call (which is the client TID) in the parent_tid pointer.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3340
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d0390e04b4..910a4da0a6 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7050,8 +7050,6 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>                 the child process gets its own copy of the lock.  */
>              if (flags & CLONE_CHILD_SETTID)
>                  put_user_u32(sys_gettid(), child_tidptr);
> -            if (flags & CLONE_PARENT_SETTID)
> -                put_user_u32(sys_gettid(), parent_tidptr);
>              ts = get_task_state(cpu);
>              if (flags & CLONE_SETTLS)
>                  cpu_set_tls (env, newtls);
> @@ -7059,6 +7057,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>                  ts->child_tidptr = child_tidptr;
>          } else {
>              cpu_clone_regs_parent(env, flags);
> +            if (flags & CLONE_PARENT_SETTID)
> +                put_user_u32(ret, parent_tidptr);
>              if (flags & CLONE_PIDFD) {
>                  int pid_fd = 0;

The clone(2) manpage says that CLONE_PARENT_SETTID stores the
*child* thread ID -- shouldn't we be storing child_tidptr here ?

thanks
-- PMM

