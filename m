Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D19C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdnM-0003zp-RC; Tue, 19 Mar 2024 14:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmdnI-0003zS-QO
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmdnB-0007Ok-00
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710871347;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmYCQ9k4fNsyxQYNhV2s9IWffrO3e8BfxyQmwKCj6v0=;
 b=jQ+E7XR3BNPHkN4hGYozwXBb3PomFOTwBZbHDWnZu01CD96bHSFTvA9Lf8ccZhU5GBjRu/
 dsVlCEHimwwyZ2RXvp4jK3yk4TvJ1grnf2t5vbwzpZi2rDeP3BfylLcC3lvxDhDFqrUQlt
 U4ONFZfv6CgigOEvU/mJPeyPE43XcrQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-yyOkum5HNkeNg2gv8XI_Vw-1; Tue,
 19 Mar 2024 14:02:16 -0400
X-MC-Unique: yyOkum5HNkeNg2gv8XI_Vw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 241203C0D7C5;
 Tue, 19 Mar 2024 18:02:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC103492BC8;
 Tue, 19 Mar 2024 18:02:14 +0000 (UTC)
Date: Tue, 19 Mar 2024 18:02:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Subject: Re: [PATCH v3 6/7] qga/commands-posix: don't do fork()/exec() when
 suspending via sysfs
Message-ID: <ZfnTIbXiGrVhTlQQ@redhat.com>
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
 <20240315122946.39168-7-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315122946.39168-7-andrey.drobyshev@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Fri, Mar 15, 2024 at 02:29:45PM +0200, Andrey Drobyshev wrote:
> Since commit 246d76eba ("qga: guest_suspend: decoupling pm-utils and sys
> logic") pm-utils logic is running in a separate child from the sysfs
> logic.  Now when suspending via sysfs we don't really need to do that in
> a separate process as we only need to perform one write to /sys/power/state.
> 
> Let's just use g_file_set_contents() to simplify things here.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c | 41 +++++------------------------------------
>  1 file changed, 5 insertions(+), 36 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 610d225d30..e0ea377f65 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1928,52 +1928,21 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
>  
>  static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>  {
> -    Error *local_err = NULL;
> +    GError *local_gerr = NULL;
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
> -    } else if (pid < 0) {
> -        error_setg_errno(errp, errno, "failed to create child process");
> -        return;
> -    }
> -
> -    ga_wait_child(pid, &status, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
> +                             -1, &local_gerr)) {
> +        error_setg(errp, "suspend: cannot write to '%s': %s",
> +                   LINUX_SYS_STATE_FILE, local_gerr->message);

You need to declare with "g_autoptr(GError) local_gerr = NULL" to
avoid a leak here.

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

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


