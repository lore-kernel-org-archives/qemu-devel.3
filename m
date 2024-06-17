Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9193C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFOw-00044m-7p; Mon, 17 Jun 2024 12:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJFOn-00044D-Ba
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJFOl-0006KV-L6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718642403;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68yhaLWk4hWAgeJm/xA8eTKxA7oWV9yEcuUHYr1Fk4w=;
 b=DBJzK9ZiGyTwihzvWRc2EsO4UKUj8hgJDbbPXVg1U4MIijpDUsHwUp70vPK2jbSvxEf5P/
 LpQ7xfq7WkUkDKJyVFLGd+veAK1jJa029GDg9XqjoW3fNYoKJU8IzxjkXdsDEoZLV6oKhE
 YTTxJVfDcbF2ai6+jAa4YAHZjfd3KHA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-q9sVLDSBMKCLe5-oLloRFg-1; Mon,
 17 Jun 2024 12:39:57 -0400
X-MC-Unique: q9sVLDSBMKCLe5-oLloRFg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0682E19560B7; Mon, 17 Jun 2024 16:39:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBD2319560AE; Mon, 17 Jun 2024 16:39:54 +0000 (UTC)
Date: Mon, 17 Jun 2024 17:39:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tap: use close_range() when forking scripts and helper
Message-ID: <ZnBm1_BMKZQgJMZD@redhat.com>
References: <20240617162520.4045016-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617162520.4045016-1-cleger@rivosinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 17, 2024 at 06:25:18PM +0200, Clément Léger wrote:
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
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  net/tap.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index 51f7aec39d..6f5bf06bb5 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -385,6 +385,17 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>      return s;
>  }
>  
> +static void fork_close_all_fds_except(int fd)
> +{
> +    int open_max = sysconf(_SC_OPEN_MAX);
> +
> +    if (fd > 3)
> +        close_range(3, fd - 1, 0);
> +
> +    if (fd < open_max)
> +        close_range(fd + 1, open_max, 0);
> +}

We can't assume that 'close_range' exists on all platforms/versions that
QEMU targets.

In system/async-teardown.c there is close_all_open_fd() that has a fallback
path to iterating over /proc, which gives good fallback for Linux. That
code doesn't have to deal with non-Linux though.

I'd suggest that util/osdep.c needs to have a 'close_all_open_fd()' method
that accepts an array of FDs to skip closing of, rather than assuming we
always skip STDIO + 1 extra FD. eg

  int close_all_open_fd(int *skip, int nskip);

Could either declare that 'skip' must be sorted, or we can explicitly
run qsort() on it.

Try native close_range first. If unavailable, then on Linux try /proc,
otherwise the simple for() loop.

Then use this common helper from both tap.c and asynct-teardown.c

> +
>  static void launch_script(const char *setup_script, const char *ifname,
>                            int fd, Error **errp)
>  {
> @@ -400,13 +411,8 @@ static void launch_script(const char *setup_script, const char *ifname,
>          return;
>      }
>      if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
> +        fork_close_all_fds_except(fd);
>  
> -        for (i = 3; i < open_max; i++) {
> -            if (i != fd) {
> -                close(i);
> -            }
> -        }
>          parg = args;
>          *parg++ = (char *)setup_script;
>          *parg++ = (char *)ifname;
> @@ -490,16 +496,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
>          return -1;
>      }
>      if (pid == 0) {
> -        int open_max = sysconf(_SC_OPEN_MAX), i;
>          char *fd_buf = NULL;
>          char *br_buf = NULL;
>          char *helper_cmd = NULL;
>  
> -        for (i = 3; i < open_max; i++) {
> -            if (i != sv[1]) {
> -                close(i);
> -            }
> -        }
> +        fork_close_all_fds_except(sv[1]);
>  
>          fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
>  
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


