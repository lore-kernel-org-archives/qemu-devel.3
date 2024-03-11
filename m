Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje8r-0004wI-JU; Mon, 11 Mar 2024 07:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rje8p-0004ij-4q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:48:27 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rje8m-000264-PG
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:48:26 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d4141c4438so64561491fa.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710157703; x=1710762503; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBqGNf+bBx7XYh4GB5fKEG70EIlghYcS7YS6Awpxjfw=;
 b=YaCQSPHU/485LaSNSVSlWZOaCQY8DBN5Kpx33FWz/e9w2rXwCDJFA0Ya6Ys7BVCooT
 8sMeKrOawgbSkorxj7INKJJ9IIExAznJJ83sYks9pLsAmBQg/iCxoDssH109Wo6fDbpG
 dIWTn5W2vSUqTPzLvQmYu7XF2kq0+fOBjJy2XI7Z7WvqQlpzLMMbjRFtU60SqH4eJSuN
 FuuSDPxROC9A0c4Lf+Qp7gCbDBQ5VTkUUI6apC8Ut1+eN4VgDDhd2+gcSL9GGJrFLi/r
 l7Uk1nLeBwFdG6x4z3hMqCizl7gLfkWsx0Z1CtJrUif8uzWRulq/mq7Ac+ZhdI9rAU7F
 dQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157703; x=1710762503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBqGNf+bBx7XYh4GB5fKEG70EIlghYcS7YS6Awpxjfw=;
 b=uPTM3+apt28tml089yVVpTFKkpgiuvAKfidlik13rAhH1bSsbqdc7Lh4mLNQRHcF7B
 SyJ4jRN+hKtEj7Lbb3uORHu7lzQ+VyFrphWiJqB1poo+429bjyPzF5YRxpgd9yNfsHgM
 u1c1Ujc0OxuzYWPalDXR2Zi/3aX6B2M8tu+lxW98bKZKXcsa/dUOTlfjbdJaKMYwrj3I
 uAWGKKMobkWZSak2kLgsBMca1VKEvjbZwhVh1R+HHE0t+eblzopKmm8k0CHZKdlJkFEB
 SQylPg3EKvI6AXoGZomSwSkDQcwsh7+vx9EIek4s1g32oVhAAJ1G119Ib3Uh/bQ2v0mU
 OT0Q==
X-Gm-Message-State: AOJu0YyW11oQOPLI8zWsjluis/Hxj/BKzTSZNQMKJpnN6/zWjnyVhqbt
 hHIWfJF7ybJvGic2rTRZu34jJnIPCZjKxU8Ef0/aLpnyLk2VxOqYbrAxK3QMy6n65w8+LoCOQLr
 GG9Tid8iaq2as6KYBlSeOFtFtnaaWBoQxWb63xQ==
X-Google-Smtp-Source: AGHT+IG+eA73UPZzlXaOWjQs5SGdRvK86R7GVY+hpu9wHO09zFe1RxBhvkPyGI5ATZ/Z0N9iIckW6zRI/9F0GX3/lOE=
X-Received: by 2002:a05:651c:1986:b0:2d2:3c88:cd57 with SMTP id
 bx6-20020a05651c198600b002d23c88cd57mr4683427ljb.32.1710157702573; Mon, 11
 Mar 2024 04:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
 <20240306144041.3787188-13-alex.bennee@linaro.org>
In-Reply-To: <20240306144041.3787188-13-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2024 11:48:11 +0000
Message-ID: <CAFEAcA_EVa1zRVZPFq1_U3ye7eReR315ZeUmbG7wnyBy5nnDoQ@mail.gmail.com>
Subject: Re: [PULL 12/29] gdbstub: Implement follow-fork-mode child
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Wed, 6 Mar 2024 at 14:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Currently it's not possible to use gdbstub for debugging linux-user
> code that runs in a forked child, which is normally done using the `set
> follow-fork-mode child` GDB command. Purely on the protocol level, the
> missing piece is the fork-events feature.
>
> However, a deeper problem is supporting $Hg switching between different
> processes - right now it can do only threads. Implementing this for the
> general case would be quite complicated, but, fortunately, for the
> follow-fork-mode case there are a few factors that greatly simplify
> things: fork() happens in the exclusive section, there are only two
> processes involved, and before one of them is resumed, the second one
> is detached.
>
> This makes it possible to implement a simplified scheme: the parent and
> the child share the gdbserver socket, it's used only by one of them at
> any given time, which is coordinated through a separate socketpair. The
> processes can read from the gdbserver socket only one byte at a time,
> which is not great for performance, but, fortunately, the
> follow-fork-mode handling involves only a few messages.
>
> Advertise the fork-events support, and remember whether GDB has it
> as well. Implement the state machine that is initialized on fork(),
> decides the current owner of the gdbserver socket, and is terminated
> when one of the two processes is detached. The logic for the parent and
> the child is the same, only the initial state is different.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20240219141628.246823-12-iii@linux.ibm.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20240305121005.3528075-13-alex.bennee@linaro.org>
>
Hi; Coverity points out an issue with this code (CID 1539966):


> @@ -376,23 +447,160 @@ static void disable_gdbstub(CPUState *thread_cpu)
>
>  void gdbserver_fork_end(CPUState *cpu, pid_t pid)
>  {



> +    gdbserver_state.state =3D RS_IDLE;
> +    gdbserver_state.allow_stop_reply =3D false;
> +    gdbserver_user_state.running_state =3D 0;
> +    for (;;) {
> +        switch (gdbserver_user_state.fork_state) {
> +        case GDB_FORK_ENABLED:
> +            if (gdbserver_user_state.running_state) {
> +                return;
> +            }
> +            QEMU_FALLTHROUGH;
> +        case GDB_FORK_ACTIVE:
> +            if (read(gdbserver_user_state.fd, &b, 1) !=3D 1) {
> +                goto fail;
> +            }
> +            gdb_read_byte(b);
> +            break;
> +        case GDB_FORK_DEACTIVATING:
> +            b =3D GDB_FORK_ACTIVATE;
> +            if (write(fd, &b, 1) !=3D 1) {
> +                goto fail;
> +            }
> +            gdbserver_user_state.fork_state =3D GDB_FORK_INACTIVE;
> +            break;
> +        case GDB_FORK_INACTIVE:
> +            if (read(fd, &b, 1) !=3D 1) {
> +                goto fail;
> +            }
> +            switch (b) {
> +            case GDB_FORK_ACTIVATE:
> +                gdbserver_user_state.fork_state =3D GDB_FORK_ACTIVE;
> +                break;
> +            case GDB_FORK_ENABLE:
> +                close(fd);
> +                gdbserver_user_state.fork_state =3D GDB_FORK_ENABLED;
> +                break;

In this branch of the switch we close(fd), and then break...

> +            case GDB_FORK_DISABLE:
> +                gdbserver_user_state.fork_state =3D GDB_FORK_DISABLED;
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +            break;

...and break again, so we leave the for() loop...

> +        case GDB_FORK_ENABLING:
> +            b =3D GDB_FORK_DISABLE;
> +            if (write(fd, &b, 1) !=3D 1) {
> +                goto fail;
> +            }
> +            close(fd);
> +            gdbserver_user_state.fork_state =3D GDB_FORK_ENABLED;
> +            break;
> +        case GDB_FORK_DISABLING:
> +            b =3D GDB_FORK_ENABLE;
> +            if (write(fd, &b, 1) !=3D 1) {
> +                goto fail;
> +            }
> +            gdbserver_user_state.fork_state =3D GDB_FORK_DISABLED;
> +            break;
> +        case GDB_FORK_DISABLED:
> +            close(fd);
> +            disable_gdbstub(cpu);
> +            return;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }

...but at the end of the for loop we will fall into this code:

> +
> +fail:
> +    close(fd);

...which tries to close(fd) again, which isn't valid.

> +    if (pid =3D=3D 0) {
> +        disable_gdbstub(cpu);
> +    }
>  }

thanks
-- PMM

