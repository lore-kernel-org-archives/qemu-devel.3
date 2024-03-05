Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB57FC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 18:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhZh6-0006H7-Vk; Tue, 05 Mar 2024 13:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhZh5-0006Gv-AQ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 13:39:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhZgt-00054k-Ri
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 13:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709663943;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fSCTBvjmalNE1r1Jr9E/0oh8zfXA6FGzLBW6Kqx3n2k=;
 b=ONgPZFiA4FKtRP4Ze115n4cZgZiDPI2HPzze3XazdCi1AfmtrwsZWxtCXfnSFQPPWkp6Ul
 c58XQYbqXWiMUxiKB+R7MvGcwb7ipJfyTani0+3eXbBZL6mgpi3xGt8rBJLHs7jEkoA1qu
 HCDvI79gXESkTei8oDAJhhnKDEtHoRA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-OA8nSaODMYSx_ucl7EZTkQ-1; Tue,
 05 Mar 2024 13:38:59 -0500
X-MC-Unique: OA8nSaODMYSx_ucl7EZTkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87D6E1C05138;
 Tue,  5 Mar 2024 18:38:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCDBF10E4F;
 Tue,  5 Mar 2024 18:38:56 +0000 (UTC)
Date: Tue, 5 Mar 2024 18:38:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Subject: Re: [PATCH v2 7/7] qga/commands-posix: qmp_guest_set_user_password:
 use ga_run_command helper
Message-ID: <ZedmvqCQe4puhT3G@redhat.com>
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <20240301172858.665135-8-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301172858.665135-8-andrey.drobyshev@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 01, 2024 at 07:28:58PM +0200, Andrey Drobyshev wrote:
> There's no need to check for the existence of the "chpasswd", "pw"
> executables, as the exec() call will do that for us.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c | 96 ++++++--------------------------------------
>  1 file changed, 13 insertions(+), 83 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index f3f4a05e2d..f2e9496b80 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2144,14 +2144,8 @@ void qmp_guest_set_user_password(const char *username,
>                                   Error **errp)
>  {
>      Error *local_err = NULL;
> -    char *passwd_path = NULL;
> -    pid_t pid;
> -    int status;
> -    int datafd[2] = { -1, -1 };
> -    char *rawpasswddata = NULL;
> +    g_autofree char *rawpasswddata = NULL;
>      size_t rawpasswdlen;
> -    char *chpasswddata = NULL;
> -    size_t chpasswdlen;
>  
>      rawpasswddata = (char *)qbase64_decode(password, -1, &rawpasswdlen, errp);
>      if (!rawpasswddata) {
> @@ -2162,95 +2156,31 @@ void qmp_guest_set_user_password(const char *username,
>  
>      if (strchr(rawpasswddata, '\n')) {
>          error_setg(errp, "forbidden characters in raw password");
> -        goto out;
> +        return;
>      }
>  
>      if (strchr(username, '\n') ||
>          strchr(username, ':')) {
>          error_setg(errp, "forbidden characters in username");
> -        goto out;
> +        return;
>      }
>  
>  #ifdef __FreeBSD__
> -    chpasswddata = g_strdup(rawpasswddata);
> -    passwd_path = g_find_program_in_path("pw");
> +    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
> +    const char *crypt_flag = (crypted) ? "-H" : "-h";
> +    const char *argv[] = {"pw", "usermod", "-n", username,
> +                          crypt_flag, "0", NULL};
>  #else
> -    chpasswddata = g_strdup_printf("%s:%s\n", username, rawpasswddata);
> -    passwd_path = g_find_program_in_path("chpasswd");
> +    g_autofree char *chpasswddata = g_strdup_printf("%s:%s\n", username,
> +                                                    rawpasswddata);
> +    const char *crypt_flag = (crypted) ? "-e" : NULL;

Style nit-pick - no '(...)' around 'crypted' is needed here, or
the other place later in this method.

Yes, that was a pre-existing issue, but since you're refactoring
the code, might as well kill the redundant brackets.

> +    const char *argv[] = {"chpasswd", crypt_flag, NULL};
>  #endif
>  
> -    chpasswdlen = strlen(chpasswddata);
> -
> -    if (!passwd_path) {
> -        error_setg(errp, "cannot find 'passwd' program in PATH");
> -        goto out;
> -    }
> -
> -    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
> -        error_setg(errp, "cannot create pipe FDs");
> -        goto out;
> -    }
> -
> -    pid = fork();
> -    if (pid == 0) {
> -        close(datafd[1]);
> -        /* child */
> -        setsid();
> -        dup2(datafd[0], 0);
> -        reopen_fd_to_null(1);
> -        reopen_fd_to_null(2);
> -
> -#ifdef __FreeBSD__
> -        const char *h_arg;
> -        h_arg = (crypted) ? "-H" : "-h";
> -        execl(passwd_path, "pw", "usermod", "-n", username, h_arg, "0", NULL);
> -#else
> -        if (crypted) {
> -            execl(passwd_path, "chpasswd", "-e", NULL);
> -        } else {
> -            execl(passwd_path, "chpasswd", NULL);
> -        }
> -#endif
> -        _exit(EXIT_FAILURE);
> -    } else if (pid < 0) {
> -        error_setg_errno(errp, errno, "failed to create child process");
> -        goto out;
> -    }
> -    close(datafd[0]);
> -    datafd[0] = -1;
> -
> -    if (qemu_write_full(datafd[1], chpasswddata, chpasswdlen) != chpasswdlen) {
> -        error_setg_errno(errp, errno, "cannot write new account password");
> -        goto out;
> -    }
> -    close(datafd[1]);
> -    datafd[1] = -1;
> -
> -    ga_wait_child(pid, &status, &local_err);
> +    ga_run_command(argv, chpasswddata, "set user password", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        goto out;
> -    }
> -
> -    if (!WIFEXITED(status)) {
> -        error_setg(errp, "child process has terminated abnormally");
> -        goto out;
> -    }
> -
> -    if (WEXITSTATUS(status)) {
> -        error_setg(errp, "child process has failed to set user password");
> -        goto out;
> -    }
> -
> -out:
> -    g_free(chpasswddata);
> -    g_free(rawpasswddata);
> -    g_free(passwd_path);
> -    if (datafd[0] != -1) {
> -        close(datafd[0]);
> -    }
> -    if (datafd[1] != -1) {
> -        close(datafd[1]);
> +        return;
>      }
>  }
>  #else /* __linux__ || __FreeBSD__ */
> -- 
> 2.39.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


