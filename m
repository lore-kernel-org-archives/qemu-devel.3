Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2153EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFLW-0002Vu-Rq; Mon, 17 Jun 2024 12:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJFLU-0002VQ-JV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:36:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJFLS-0005yN-Qq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:36:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57c83100cb4so5223705a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718642196; x=1719246996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBicE4E4b0eSNLFo6o6WpeU+gDrB/l3voZ/i9pSyB4o=;
 b=ndw4nq82OcOKpVskDEdIGK/YNGORiwyVYfUz/EUTzL++MwmmuDyrw1fSqI882Ljp9O
 S4a5SxzZY/Qvu6e0ZjwjTyUs0jqF/xZko4P+TtnkU7GUxGGuq+XIfB7AXDzHiKG3Cvr3
 biXuul+OrpD6ACxbkHv3RnMIHDoZv/eiocv+yx5L3SieKVRnwZCyaAtqD29PqIhPRODk
 WPO6C3Yu1rgiUmxh4fGhdoTsgkZR/YOgV73HbZe8dLf1r7QtPKksBNTD0rPZ2ol6DbSH
 EUYMziYJ+8k1UW6J0zeOz054Eo9MObozxJ+zNoa9EBU8/fSaqrRTM+10Wmr+/zeMdxUI
 DbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718642196; x=1719246996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBicE4E4b0eSNLFo6o6WpeU+gDrB/l3voZ/i9pSyB4o=;
 b=nsCj7haSoHKiXOljsZVaN2klZ7ye9S9k0Y19Wa5/sNleYryXIK3sRuwTebvwaYOtPi
 dnUraXbqg8ptWfuqasFNhODKOkNIRbJvhZ6snXPDO0+MXMBXlVmFyVQ20f2jK4rulBNY
 B//1HlYeTGtoiPlLJraP1zbFY4GJLT7K812TzVQTPwqLbJ2a9N4ZKUR3cGc+jNMeyyZ5
 +8b4uUDu2xyltve/fP3rjG7NMMt5jGzmSPv8Jmjqn5A2vjzHToPhA5SA+7fkj8TkkdR6
 A2lOkvyrJZ82kEVvHO8x/dhjhsZxmTjXv8UKIanXHeTCFEi5WsiXkeTx+BAvlTrIkXWD
 NA0A==
X-Gm-Message-State: AOJu0YxA+r4iOs9Kvhfc8Oj4f4u3rRGICE7z3m3Vwt0X/QGXGza/hiyQ
 7T4PkLaRs4Jroc6T5Snmkwp42cNjqKY6zlyXySXXOM6ZboF6YvUbCCq3oIPtR5BRRWqm/I0RDMn
 EJet8xLhkAUtAh1ARBustTZw7yAYbkNSv3i++UA==
X-Google-Smtp-Source: AGHT+IE0ntajvDuWuxHA2WzYmgTUQlZLXDHzk2jF9DLhNvCuQpWCpELBP63YyXlTH+5NT3cahHI8V5JvS8Ym2wfAR8k=
X-Received: by 2002:a50:d718:0:b0:57c:8bdc:fddf with SMTP id
 4fb4d7f45d1cf-57cbd6a6e9cmr5872159a12.20.1718642196362; Mon, 17 Jun 2024
 09:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240617162520.4045016-1-cleger@rivosinc.com>
In-Reply-To: <20240617162520.4045016-1-cleger@rivosinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2024 17:36:24 +0100
Message-ID: <CAFEAcA9v3UAbO7RpHQ0gP=adrHmKGPToJj3UdW_Nmd4T9bfO7w@mail.gmail.com>
Subject: Re: [PATCH] tap: use close_range() when forking scripts and helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 17 Jun 2024 at 17:25, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>=
 wrote:
>
> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
> POSIX"), the maximum number of file descriptors that can be opened are
> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
> of 1073741816 file descriptors. Now, when forking to start
> qemu-bridge-helper, this actually calls close() on the full possible file
> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
> takes a considerable amount of time. Use close_range() which only
> requires to be called twice and factorize it in a separate function for
> both call sites.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  net/tap.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 51f7aec39d..6f5bf06bb5 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -385,6 +385,17 @@ static TAPState *net_tap_fd_init(NetClientState *pee=
r,
>      return s;
>  }
>
> +static void fork_close_all_fds_except(int fd)
> +{
> +    int open_max =3D sysconf(_SC_OPEN_MAX);
> +
> +    if (fd > 3)
> +        close_range(3, fd - 1, 0);
> +
> +    if (fd < open_max)
> +        close_range(fd + 1, open_max, 0);
> +}

We can't rely on close_range() being available, I think --
this should be ifdeffed with CONFIG_CLOSE_RANGE, with a
fallback if it's not there.

Also, QEMU coding style requires braces on all if() statements,
even single-line ones.

thanks
-- PMM

