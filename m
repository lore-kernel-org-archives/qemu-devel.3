Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F961E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyg9-0002X3-CK; Mon, 06 Jan 2025 20:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tUyg6-0002Wa-Kv
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tUyg4-00042w-1s
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736214398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdMIpd8egTPh+oUTiogNI3D+WYwnOhQGJPl79VSuKsw=;
 b=gWOjqT3cBcGUeZxwRB7Mj0JQqvTcZQ2laFljIYEq9evZ2TUjG6pCeSXMCopd9hjbkMlyGQ
 T7S2pQhA3MEqjR70TwSZJ21TtCpdiVrBQOVt/jJ89z+mCTzgRGZIerE8jMCM7VCKeH7k21
 XIec38hvXmHZcUOpK5XdfzyeNHHSKs0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-C1mqPmilOiKr1Gptw3kV8A-1; Mon, 06 Jan 2025 20:46:37 -0500
X-MC-Unique: C1mqPmilOiKr1Gptw3kV8A-1
X-Mimecast-MFC-AGG-ID: C1mqPmilOiKr1Gptw3kV8A
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d3f55f8f3aso17112169a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 17:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736214395; x=1736819195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdMIpd8egTPh+oUTiogNI3D+WYwnOhQGJPl79VSuKsw=;
 b=Dx5MRwXP8aqXHCa6MX6O4BHKoXFtfnPAYUCDfkuJkJErxeSG2PPSPYMdyiQXonw+0u
 wI5kjmfEl6p22azY5xTndYZAlFiM1KP+XuXIZHxoP2ZAHEtZ+wBTDIr7Fau7t1Yo8GOV
 sfSD2+9cDwPu+t8m5Xo8kint0BgydPP3RkJ3qHLNP3yPXLhhz/+BRa+HX1IPQ+PZF6Ma
 JWU7uAOLOcJo6u0s/AP/rwuR5pszMpHipbWZOIeh+A5l0qqeBok5M/UsxMRDkbG7shoO
 AundXTHzul+CSnCkC5lB2+TcfNTOtVemMZR+gqJNM3a2WlGNVcOdAfBCSR8ak385diU3
 vlKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPhDAjiqV+xjn+hB9kDR5XCW2j8CWAsrD/oKV//a66YVR1LG++eqcRiiE8dbH1zLAx+aFa09HfFDKj@nongnu.org
X-Gm-Message-State: AOJu0YzZnPuypdSCd9QEdfyR+rYe7GVhS+4TPFvHftCaB5MfPELe1V7P
 qNUK4HnVJoNGRLixyG/HXpk9bIKauARP7Puqv3LKnrqXqVn0nhpgAITyLhNFlhu/t7beuCYnWrh
 RQ7VGHLcWpR8s3lbuOzEMbDOGqmqs3qTZwz5EamqmEp9ZoZRg1T3wRn2ZE1VOu79TRYRr3bat2O
 RcBw8yJIYwDQ3o62g245eRxMtAI6GpSoKgVq6IvA==
X-Gm-Gg: ASbGncuw/jqB6ku9ryljq3Ib6jyXYAnJ6F2n18cA+mJnVEmUH1Dj9G0JKKpBBi1nN3o
 3JiuH/IP9dJm549gsA4jGBpO6e5YTq45kvqkF36Lv8NnZdw==
X-Received: by 2002:a05:6402:5241:b0:5d2:7199:ae6 with SMTP id
 4fb4d7f45d1cf-5d81dd9c794mr50503093a12.9.1736214394940; 
 Mon, 06 Jan 2025 17:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfnUZmPe0tqyxAKZ8kelnhsNUJnCd7KT394M+rsxRfvWpaf2YLFvIO58N/qdo7QTrhZ0G/NdyJZA2NU1tOH7w=
X-Received: by 2002:a05:6402:5241:b0:5d2:7199:ae6 with SMTP id
 4fb4d7f45d1cf-5d81dd9c794mr50503087a12.9.1736214394559; Mon, 06 Jan 2025
 17:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20250104-glib-v2-0-12013f3e5782@daynix.com>
 <20250104-glib-v2-2-12013f3e5782@daynix.com>
In-Reply-To: <20250104-glib-v2-2-12013f3e5782@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 7 Jan 2025 09:45:57 +0800
X-Gm-Features: AbW1kvaXJgt4u1OQQHYB8rVdaLyac5DTs9FUVW58a26sDaoAfuHsfZYgyfDRzd0
Message-ID: <CAPpAL=xQq4LTi306hCPw=ATKE48E=H+r=jyA_PLMmH_vOmG39Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tap: Use g_spawn_sync() and
 g_spawn_check_wait_status()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Jan 4, 2025 at 4:05=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> g_spawn_sync() gives an informative message if it fails to execute
> the script instead of reporting exiting status 1.
>
> g_spawn_check_wait_status() also gives an message easier to understand
> than the raw value returned by waitpid().
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  net/tap.c | 169 ++++++++++++++++++++++++--------------------------------=
------
>  1 file changed, 66 insertions(+), 103 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index ae1c7e398321..392a024f8ed9 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -385,56 +385,30 @@ static TAPState *net_tap_fd_init(NetClientState *pe=
er,
>      return s;
>  }
>
> -static void close_all_fds_after_fork(int excluded_fd)
> +static void unset_cloexec(gpointer data)
>  {
> -    const int skip_fd[] =3D {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
> -                           excluded_fd};
> -    unsigned int nskip =3D ARRAY_SIZE(skip_fd);
> -
> -    /*
> -     * skip_fd must be an ordered array of distinct fds, exclude
> -     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FIL=
ENO]
> -     * range
> -     */
> -    if (excluded_fd <=3D STDERR_FILENO) {
> -        nskip--;
> -    }
> -
> -    qemu_close_all_open_fd(skip_fd, nskip);
> +    g_assert(!fcntl(GPOINTER_TO_INT(data), F_SETFD, 0));
>  }
>
>  static void launch_script(const char *setup_script, const char *ifname,
>                            int fd, Error **errp)
>  {
> -    int pid, status;
> -    char *args[3];
> -    char **parg;
> +    gint status;
> +    gchar *argv[] =3D { (gchar *)setup_script, (gchar *)ifname, NULL };
> +    g_autoptr(GError) error =3D NULL;
>
>      /* try to launch network script */
> -    pid =3D fork();
> -    if (pid < 0) {
> -        error_setg_errno(errp, errno, "could not launch network script %=
s",
> -                         setup_script);
> +    if (!g_spawn_sync(NULL, argv, NULL, G_SPAWN_CHILD_INHERITS_STDIN,
> +                      unset_cloexec, GINT_TO_POINTER(fd),
> +                      NULL, NULL, &status, &error)) {
> +        error_setg(errp, "could not launch network script %s: %s",
> +                   setup_script, error->message);
>          return;
>      }
> -    if (pid =3D=3D 0) {
> -        close_all_fds_after_fork(fd);
> -        parg =3D args;
> -        *parg++ =3D (char *)setup_script;
> -        *parg++ =3D (char *)ifname;
> -        *parg =3D NULL;
> -        execv(setup_script, args);
> -        _exit(1);
> -    } else {
> -        while (waitpid(pid, &status, 0) !=3D pid) {
> -            /* loop */
> -        }
>
> -        if (WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0) {
> -            return;
> -        }
> -        error_setg(errp, "network script %s failed with status %d",
> -                   setup_script, status);
> +    if (!g_spawn_check_wait_status(status, &error)) {
> +        error_setg(errp, "network script %s failed: %s",
> +                   setup_script, error->message);
>      }
>  }
>
> @@ -477,6 +451,12 @@ static int net_bridge_run_helper(const char *helper,=
 const char *bridge,
>  {
>      sigset_t oldmask, mask;
>      g_autofree char *default_helper =3D NULL;
> +    g_autofree char *fd_buf =3D NULL;
> +    g_autofree char *br_buf =3D NULL;
> +    g_autofree char *helper_cmd =3D NULL;
> +    g_autoptr(GError) error =3D NULL;
> +    int fd;
> +    int saved_errno;
>      int pid, status;
>      char *args[5];
>      char **parg;
> @@ -495,82 +475,65 @@ static int net_bridge_run_helper(const char *helper=
, const char *bridge,
>          return -1;
>      }
>
> -    /* try to launch bridge helper */
> -    pid =3D fork();
> -    if (pid < 0) {
> -        error_setg_errno(errp, errno, "Can't fork bridge helper");
> -        return -1;
> -    }
> -    if (pid =3D=3D 0) {
> -        char *fd_buf =3D NULL;
> -        char *br_buf =3D NULL;
> -        char *helper_cmd =3D NULL;
> -
> -        close_all_fds_after_fork(sv[1]);
> -        fd_buf =3D g_strdup_printf("%s%d", "--fd=3D", sv[1]);
> +    fd_buf =3D g_strdup_printf("%s%d", "--fd=3D", sv[1]);
>
> -        if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
> -            /* assume helper is a command */
> +    if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
> +        /* assume helper is a command */
>
> -            if (strstr(helper, "--br=3D") =3D=3D NULL) {
> -                br_buf =3D g_strdup_printf("%s%s", "--br=3D", bridge);
> -            }
> -
> -            helper_cmd =3D g_strdup_printf("%s %s %s %s", helper,
> -                            "--use-vnet", fd_buf, br_buf ? br_buf : "");
> -
> -            parg =3D args;
> -            *parg++ =3D (char *)"sh";
> -            *parg++ =3D (char *)"-c";
> -            *parg++ =3D helper_cmd;
> -            *parg++ =3D NULL;
> +        if (strstr(helper, "--br=3D") =3D=3D NULL) {
> +            br_buf =3D g_strdup_printf("%s%s", "--br=3D", bridge);
> +        }
>
> -            execv("/bin/sh", args);
> -            g_free(helper_cmd);
> -        } else {
> -            /* assume helper is just the executable path name */
> +        helper_cmd =3D g_strdup_printf("%s %s %s %s", helper,
> +                        "--use-vnet", fd_buf, br_buf ? br_buf : "");
>
> -            br_buf =3D g_strdup_printf("%s%s", "--br=3D", bridge);
> +        parg =3D args;
> +        *parg++ =3D (char *)"sh";
> +        *parg++ =3D (char *)"-c";
> +        *parg++ =3D helper_cmd;
> +        *parg++ =3D NULL;
> +    } else {
> +        /* assume helper is just the executable path name */
>
> -            parg =3D args;
> -            *parg++ =3D (char *)helper;
> -            *parg++ =3D (char *)"--use-vnet";
> -            *parg++ =3D fd_buf;
> -            *parg++ =3D br_buf;
> -            *parg++ =3D NULL;
> +        br_buf =3D g_strdup_printf("%s%s", "--br=3D", bridge);
>
> -            execv(helper, args);
> -        }
> -        g_free(fd_buf);
> -        g_free(br_buf);
> -        _exit(1);
> +        parg =3D args;
> +        *parg++ =3D (char *)helper;
> +        *parg++ =3D (char *)"--use-vnet";
> +        *parg++ =3D fd_buf;
> +        *parg++ =3D br_buf;
> +        *parg++ =3D NULL;
> +    }
>
> -    } else {
> -        int fd;
> -        int saved_errno;
> +    /* try to launch bridge helper */
> +    if (!g_spawn_async(NULL, args, NULL,
> +                       G_SPAWN_DO_NOT_REAP_CHILD | G_SPAWN_CHILD_INHERIT=
S_STDIN,
> +                       unset_cloexec, GINT_TO_POINTER(sv[1]), &pid, &err=
or)) {
> +        error_setg(errp, "could not launch bridge helper: %s", error->me=
ssage);
> +        return -1;
> +    }
>
> -        close(sv[1]);
> +    close(sv[1]);
>
> -        fd =3D RETRY_ON_EINTR(recv_fd(sv[0]));
> -        saved_errno =3D errno;
> +    fd =3D RETRY_ON_EINTR(recv_fd(sv[0]));
> +    saved_errno =3D errno;
>
> -        close(sv[0]);
> +    close(sv[0]);
>
> -        while (waitpid(pid, &status, 0) !=3D pid) {
> -            /* loop */
> -        }
> -        sigprocmask(SIG_SETMASK, &oldmask, NULL);
> -        if (fd < 0) {
> -            error_setg_errno(errp, saved_errno,
> -                             "failed to recv file descriptor");
> -            return -1;
> -        }
> -        if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0) {
> -            error_setg(errp, "bridge helper failed");
> -            return -1;
> -        }
> -        return fd;
> +    while (waitpid(pid, &status, 0) !=3D pid) {
> +        /* loop */
>      }
> +    sigprocmask(SIG_SETMASK, &oldmask, NULL);
> +    if (fd < 0) {
> +        error_setg_errno(errp, saved_errno,
> +                            "failed to recv file descriptor");
> +        return -1;
> +    }
> +    if (!g_spawn_check_wait_status(status, &error)) {
> +        error_setg(errp, "bridge helper failed: %s", error->message);
> +        return -1;
> +    }
> +    return fd;
>  }
>
>  int net_init_bridge(const Netdev *netdev, const char *name,
>
> --
> 2.47.1
>
>


