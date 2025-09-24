Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E048CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1VZh-0005Cr-21; Wed, 24 Sep 2025 15:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1VZe-0005CL-Fb
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1VZP-0005wg-Eb
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758743665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c1JunloZ3jU1QwtQz4GgxfySL9jssXXb45ORgEUGA6o=;
 b=OopmLnyMo9EFZoEgny2XwuOZr053rT9xAvuL8vf8BRoiJmYKBR0uD566YFawmjkWPeRa67
 tqdCz3L/Ym5JDzdrTHZOY3v/vYGQi726ZOjtK2dOtP7174lUuDURa+ShDQxThEeFA3TJu8
 ws6Z9upeY1ADZlcwNABbvsMzpbOgYhM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-oYujTV1JMoSjZz95gHuY3w-1; Wed,
 24 Sep 2025 15:54:21 -0400
X-MC-Unique: oYujTV1JMoSjZz95gHuY3w-1
X-Mimecast-MFC-AGG-ID: oYujTV1JMoSjZz95gHuY3w_1758743660
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2ED819560AB; Wed, 24 Sep 2025 19:54:19 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7CC19560BA; Wed, 24 Sep 2025 19:54:18 +0000 (UTC)
Date: Wed, 24 Sep 2025 14:54:15 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/3] Socket Activation: stash $LISTEN_FDNAMES
Message-ID: <3jswoyxlmxjwnwt654rv7gkv3wkjnftza2fxb5fc7a5lvfvwnu@jqa4tjbovlws>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250629040723.1696325-1-dkg@fifthhorseman.net>
 <20250629040723.1696325-2-dkg@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629040723.1696325-2-dkg@fifthhorseman.net>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, Jun 29, 2025 at 12:03:59AM -0400, Daniel Kahn Gillmor wrote:
> By recording a copy of LISTEN_FDNAMES, we make it possible to learn
> mappings from file descriptor labels (e.g., as set by
> FileDescriptorName= in systemd.socket(5)).
> 

Just now noticing that this hasn't been reviewed yet...

In general, it's okay to ping the list after a week or so if you feel
like your patch has been overlooked.

> This also makes it possible to invoke check_socket_activation() more
> than once and have it return the same value each time.
> 
> This is one step toward addressing
> https://gitlab.com/qemu-project/qemu/-/issues/3011
> 
> Since we can't count on the buffer returned from getenv
> persisting (getenv is documented as non-re-entrant), we need to keep a
> copy of it around in case multiple subsystems want to interrogate it.

getenv()'s result is non-reliable IF the application is calling
setenv()/putenv() to be changing the environment.  But if you treat
the environment as a read-only block of memory, then the getenv()
result has a lifetime equivalent to the entire process.  And a quick
grep:

$ git grep '\b[sp][eu]tenv('
tests/tcg/multiarch/linux/linux-sigrtminmax.c:        setenv("QEMU_RTSIG_MAP", rt_sigmap, 0);
util/envlist.c: * than putenv(3).

shows that we aren't generally modifying qemu's environ.  Okay, there
ARE a few calls to unsetenv() in util/systemd.c, but that's the file
you're modifying, and before this patch it was already using getenv()
without worrying about copying its results.  We _do_ need to modify
the environment after reading it, at which point, you might be right
that calling getenv(), then unsetenv(), then relying on the former
pointer may be unsafe; but if this is the only file manipulating the
environment we have quite a bit of control over safety aspects, and
may still be able to design something that doesn't have to copy
getenv() results.

> 
> This proposed implementation uses a static buffer, and breaks socket
> activation with a visible error_report if LISTEN_FDNAMES is too large.
> Another approach would be to g_strdup the value returned by getenv,
> which would have failure modes on heap exhaustion, and would introduce
> a memory leak as there's no clear opportunity to g_free the copy.

A single g_strdup at process startup is not a memory leak, even if it
doesn't get explicitly freed, if you can't trigger it more than once.
An inability to g_free the copy is not fatal, as long as you are not
repeatedly duplicating the string each time a different caller wants
to also check what you already learned from getenv() on the first
caller.


> 
> Signed-off-by: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
> ---
>  util/systemd.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)

> 
> diff --git a/util/systemd.c b/util/systemd.c
> index ced518f771..1eca2bd69f 100644
> --- a/util/systemd.c
> +++ b/util/systemd.c
> @@ -16,37 +16,62 @@
>  #include "qemu/error-report.h"
>  
>  #ifndef _WIN32
> +static char fdnames[256];

Does systemd guarantee this particular size?  Should it be a #define?

> +
>  unsigned int check_socket_activation(void)
>  {
> +    static unsigned int nr_fds = -1;
>      const char *s;
>      unsigned long pid;
> -    unsigned long nr_fds;
> +    unsigned long nr_fdsl;
>      unsigned int i;
>      int fd;
>      int f;
>      int err;
>  
> +    if (nr_fds != -1) {
> +        return nr_fds;
> +    }
>      s = getenv("LISTEN_PID");
>      if (s == NULL) {
> +        nr_fds = 0;
>          return 0;
>      }
>      err = qemu_strtoul(s, NULL, 10, &pid);
>      if (err) {
> +        nr_fds = 0;
>          return 0;
>      }
>      if (pid != getpid()) {
> +        nr_fds = 0;
>          return 0;
>      }
>  
>      s = getenv("LISTEN_FDS");
>      if (s == NULL) {
> +        nr_fds = 0;
>          return 0;
>      }
> -    err = qemu_strtoul(s, NULL, 10, &nr_fds);
> +    err = qemu_strtoul(s, NULL, 10, &nr_fdsl);
>      if (err) {
> +        nr_fds = 0;
>          return 0;
>      }
> -    assert(nr_fds <= UINT_MAX);
> +    assert(nr_fdsl <= UINT_MAX);

I can put a value in the environment for LISTEN_FDS that will trip
this assertion, on a 64-bit platform.  While an early exit due to
garbage in the environment is okay, it should probably be cleaner than
by an assertion failure.

> +    nr_fds = (unsigned int) nr_fdsl;
> +    s = getenv("LISTEN_FDNAMES");
> +    if (s != NULL) {
> +        size_t fdnames_len = strlen(s);
> +        if (fdnames_len + 1 > sizeof(fdnames)) {
> +            error_report("LISTEN_FDNAMES is larger than %ldu bytes, "
> +                         "ignoring socket activation.",

error_report() should not use trailing '.'.  A g_strdup'd buffer won't
suffer from this arbitrary length limitation.

> +                         sizeof(fdnames));
> +            nr_fds = 0;
> +            return 0;
> +        } else {
> +            memcpy(fdnames, s, fdnames_len + 1);
> +        }
> +    }
>  
>      /* So these are not passed to any child processes we might start. */
>      unsetenv("LISTEN_FDS");
> @@ -69,7 +94,7 @@ unsigned int check_socket_activation(void)
>          }
>      }
>  
> -    return (unsigned int) nr_fds;
> +    return nr_fds;
>  }
>  
>  #else /* !_WIN32 */
> -- 
> 2.47.2
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


