Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ABFC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 18:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhZcp-0005Jh-Ov; Tue, 05 Mar 2024 13:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhZco-0005JS-U4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 13:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhZcg-0004Sj-V6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 13:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709663681;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D0QrxwvoAKs63fdSD6fYZhZ18lLwWzwAnrbKhnUUI5w=;
 b=Nmt/Nd1PJezYYLCbLomTsejYvgE++mYLve6Eav0JyyjJU6bzyloXfmkRctnlGz96+zxuFf
 LK6nPAWhhwEFpld3OSm6GtptklwLfJtejuF2L4k7iVaZfsTSIEHkoDva3CmtI64r8d0rZI
 VRlpJ9eZ2eQzQY9uGZnwSNz+nkpV62A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-nCmb1AthPeSLYp_3SuX07A-1; Tue,
 05 Mar 2024 13:34:37 -0500
X-MC-Unique: nCmb1AthPeSLYp_3SuX07A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D23EB380009D;
 Tue,  5 Mar 2024 18:34:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 711FA37F6;
 Tue,  5 Mar 2024 18:34:34 +0000 (UTC)
Date: Tue, 5 Mar 2024 18:34:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Subject: Re: [PATCH v2 6/7] qga/commands-posix: use ga_run_command helper
 when suspending via sysfs
Message-ID: <Zedlt4vI2gHri8s5@redhat.com>
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <20240301172858.665135-7-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301172858.665135-7-andrey.drobyshev@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 01, 2024 at 07:28:57PM +0200, Andrey Drobyshev wrote:
> We replace the direct call to open() with a "sh -c 'echo ...'" call, so
> that it becomes an executable command.

Introduced an indirection via the shell is a significant step
backwards IMHO.

> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c | 36 ++++--------------------------------
>  1 file changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dd2a7ad2e6..f3f4a05e2d 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1921,49 +1921,21 @@ static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>      Error *local_err = NULL;
>      const char *sysfile_strs[3] = {"disk", "mem", NULL};
>      const char *sysfile_str = sysfile_strs[mode];
> -    pid_t pid;
> -    int status;
>  
>      if (!sysfile_str) {
>          error_setg(errp, "unknown guest suspend mode");
>          return;
>      }
>  
> -    pid = fork();
> -    if (!pid) {
> -        /* child */
> -        int fd;
> -
> -        setsid();
> -        reopen_fd_to_null(0);
> -        reopen_fd_to_null(1);
> -        reopen_fd_to_null(2);
> -
> -        fd = open(LINUX_SYS_STATE_FILE, O_WRONLY);
> -        if (fd < 0) {
> -            _exit(EXIT_FAILURE);
> -        }
> -
> -        if (write(fd, sysfile_str, strlen(sysfile_str)) < 0) {
> -            _exit(EXIT_FAILURE);
> -        }
> -
> -        _exit(EXIT_SUCCESS);


This pre-existing code is strange to me.  Why do we need to fork a
new process in order to write to /sys/power/state ?

Looking at the original commit

  commit 11d0f1255bd5651f628280dc96c4ce9d63ae9236
  Author: Luiz Capitulino <lcapitulino@redhat.com>
  Date:   Tue Feb 28 11:03:03 2012 -0300

    qemu-ga: add guest-suspend-disk
    

The code made a little more sense, as after fork() it first
tried to execve  'pm-utils', and then had the sysfs codepath
as a fallback. IOW having the sysfs code after fork() was a
much easier code structure.

This was all changed in

  commit 246d76eba1944d7e59affb288ec27d7fcfb5d256
  Author: Daniel Henrique Barboza <danielhb413@gmail.com>
  Date:   Thu Jun 21 07:21:50 2018 -0300

    qga: guest_suspend: decoupling pm-utils and sys logic


so the pm-utils logic runs in a separate forked child
from the sysfs logic.

AFAICT, that should have made it completely redundant to
fork a process to access /sys/power/state.

Does anyone know of a reason to keep the fork() here ? Of
not we should just be calling 'g_file_set_contents' without
fork

> -    } else if (pid < 0) {
> -        error_setg_errno(errp, errno, "failed to create child process");
> -        return;
> -    }
> +    g_autofree char *echo_cmd = g_strdup_printf(
> +        "echo %s > " LINUX_SYS_STATE_FILE, sysfile_str);
> +    const char *argv[] = {"sh", "-c", echo_cmd, NULL};
>  
> -    ga_wait_child(pid, &status, &local_err);
> +    ga_run_command(argv, NULL, "suspend", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> -
> -    if (WEXITSTATUS(status)) {
> -        error_setg(errp, "child process has failed to suspend");
> -    }
> -
>  }
>  
>  static void guest_suspend(SuspendMode mode, Error **errp)
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


