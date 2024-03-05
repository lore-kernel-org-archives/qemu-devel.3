Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE971C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhZ3y-0007ok-V5; Tue, 05 Mar 2024 12:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhZ3y-0007oY-7K
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:58:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhZ3s-0006pa-Hp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709661523;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dAtFWPBhFfYwfDphly73YPCFKHZ2gjwQ4k2DUTMtLng=;
 b=fiAhX9YOkkAlrJAUg3x/1MkzpYPk7YkE3zf6xilErAQiQHAmro/EDEzmg8O24R4Y76MbIP
 ZXw4PSGmoXE6JWI8l172t7VLpnahVD3nNHQNk6R9nrPRNjXlEYD5Upg87H9ypdArwL/G+1
 NQSBjhn6Ff9zHuNyof9e6N0j8IYeztU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-q8zt0856NE2Ec6qdgW_aGw-1; Tue,
 05 Mar 2024 12:58:40 -0500
X-MC-Unique: q8zt0856NE2Ec6qdgW_aGw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9972B3C025BB;
 Tue,  5 Mar 2024 17:58:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 438D2492BDC;
 Tue,  5 Mar 2024 17:58:37 +0000 (UTC)
Date: Tue, 5 Mar 2024 17:58:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Subject: Re: [PATCH v2 2/7] qga: introduce ga_run_command() helper for guest
 cmd execution
Message-ID: <ZeddShrMTUFjMoNl@redhat.com>
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <20240301172858.665135-3-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301172858.665135-3-andrey.drobyshev@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 01, 2024 at 07:28:53PM +0200, Andrey Drobyshev wrote:
> When executing guest commands in *nix environment, we repeat the same
> fork/exec pattern multiple times.  Let's just separate it into a single
> helper which would also be able to feed input data into the launched
> process' stdin.  This way we can avoid code duplication.
> 
> To keep the history more bisectable, let's replace qmp commands
> implementations one by one.  Also add G_GNUC_UNUSED attribute to the
> helper and remove it in the next commit.
> 
> Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c | 140 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 8207c4c47e..781498418f 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -76,6 +76,146 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
>      g_assert(rpid == pid);
>  }
>  
> +static void ga_pipe_read_str(int fd[2], char **str, size_t *len)
> +{
> +    ssize_t n;
> +    char buf[1024];
> +    close(fd[1]);
> +    fd[1] = -1;
> +    while ((n = read(fd[0], buf, sizeof(buf))) != 0) {
> +        if (n < 0) {
> +            if (errno == EINTR) {
> +                continue;
> +            } else {
> +                break;

This is a fatal error condition....

> +            }
> +        }
> +        *str = g_realloc(*str, *len + n);
> +        memcpy(*str + *len, buf, n);
> +        *len += n;
> +    }
> +    close(fd[0]);
> +    fd[0] = -1;

....and yet as far as the caller is concerned we're not indicating
any sense of failure here. They're just being returned a partially
read data stream as if it were successful. IMHO this needs to be
reported properly.


Nothing in this method has NUL terminated 'str', so we are
relying on the caller *always* honouring 'len', but.....

> +}
> +
> +/*
> + * Helper to run command with input/output redirection,
> + * sending string to stdin and taking error message from
> + * stdout/err.
> + */
> +G_GNUC_UNUSED
> +static int ga_run_command(const char *argv[], const char *in_str,
> +                          const char *action, Error **errp)
> +{
> +    pid_t pid;
> +    int status;
> +    int retcode = -1;
> +    int infd[2] = { -1, -1 };
> +    int outfd[2] = { -1, -1 };
> +    char *str = NULL;
> +    size_t len = 0;
> +
> +    if ((in_str && !g_unix_open_pipe(infd, FD_CLOEXEC, NULL)) ||
> +        !g_unix_open_pipe(outfd, FD_CLOEXEC, NULL)) {
> +        error_setg(errp, "cannot create pipe FDs");
> +        goto out;
> +    }
> +
> +    pid = fork();
> +    if (pid == 0) {
> +        char *cherr = NULL;
> +
> +        setsid();
> +
> +        if (in_str) {
> +            /* Redirect stdin to infd. */
> +            close(infd[1]);
> +            dup2(infd[0], 0);
> +            close(infd[0]);
> +        } else {
> +            reopen_fd_to_null(0);
> +        }
> +
> +        /* Redirect stdout/stderr to outfd. */
> +        close(outfd[0]);
> +        dup2(outfd[1], 1);
> +        dup2(outfd[1], 2);
> +        close(outfd[1]);
> +
> +        execvp(argv[0], (char *const *)argv);
> +
> +        /* Write the cause of failed exec to pipe for the parent to read it. */
> +        cherr = g_strdup_printf("failed to exec '%s'", argv[0]);
> +        perror(cherr);
> +        g_free(cherr);
> +        _exit(EXIT_FAILURE);
> +    } else if (pid < 0) {
> +        error_setg_errno(errp, errno, "failed to create child process");
> +        goto out;
> +    }
> +
> +    if (in_str) {
> +        close(infd[0]);
> +        infd[0] = -1;
> +        if (qemu_write_full(infd[1], in_str, strlen(in_str)) !=
> +                strlen(in_str)) {
> +            error_setg_errno(errp, errno, "%s: cannot write to stdin pipe",
> +                             action);
> +            goto out;
> +        }
> +        close(infd[1]);
> +        infd[1] = -1;
> +    }
> +
> +    ga_pipe_read_str(outfd, &str, &len);
> +
> +    ga_wait_child(pid, &status, errp);
> +    if (*errp) {
> +        goto out;
> +    }
> +
> +    if (!WIFEXITED(status)) {
> +        if (len) {
> +            error_setg(errp, "child process has terminated abnormally: %s",
> +                       str);

...this is reading 'str' without honouring 'len', so is likely
an array out of bounds read.

> +        } else {
> +            error_setg(errp, "child process has terminated abnormally");
> +        }
> +        goto out;
> +    }
> +
> +    retcode = WEXITSTATUS(status);
> +
> +    if (WEXITSTATUS(status)) {
> +        if (len) {
> +            error_setg(errp, "child process has failed to %s: %s",
> +                       action, str);

Again, array out of bounds is likely

> +        } else {
> +            error_setg(errp, "child process has failed to %s: exit status %d",
> +                       action, WEXITSTATUS(status));
> +        }
> +        goto out;
> +    }
> +
> +out:
> +    g_free(str);
> +
> +    if (infd[0] != -1) {
> +        close(infd[0]);
> +    }
> +    if (infd[1] != -1) {
> +        close(infd[1]);
> +    }
> +    if (outfd[0] != -1) {
> +        close(outfd[0]);
> +    }
> +    if (outfd[1] != -1) {
> +        close(outfd[1]);
> +    }
> +
> +    return retcode;
> +}
> +
>  void qmp_guest_shutdown(const char *mode, Error **errp)
>  {
>      const char *shutdown_flag;
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


