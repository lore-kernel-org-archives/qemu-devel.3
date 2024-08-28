Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0253AC54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjI6n-0008E9-4L; Wed, 28 Aug 2024 08:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjI6l-0008Cw-Bp
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjI6j-0004m0-AZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724849344;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXr66m8jBNsSGXQJKi0J1t9v2nb3kkzqh4XO2iHMzcs=;
 b=Jf+KPBEfLUypTHMlapWFRvadLlU+C2rOx1y/DcHmpdeZ2qujCPktMMrRV4Xrm1N0WQYXv/
 BlodaxqjgnlaxLh4vuC39zW4M0x95g9yjcNkCzvF5fiTcoz0mlO5iUfUxhUMe6VkRp5HRk
 vyyekNHIbi7bDZE1XO/6cgPHR7iH2rI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-a0HQOUxHMBSI9nPLX9ohLA-1; Wed,
 28 Aug 2024 08:49:02 -0400
X-MC-Unique: a0HQOUxHMBSI9nPLX9ohLA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C38251918164; Wed, 28 Aug 2024 12:49:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B452619560AA; Wed, 28 Aug 2024 12:48:58 +0000 (UTC)
Date: Wed, 28 Aug 2024 13:48:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Subject: Re: [PULL 3/6] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
Message-ID: <Zs8ctyVxQz3iLDmM@redhat.com>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
 <20240805003130.1421051-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805003130.1421051-5-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is already merged, but I have two comments - one improvement
and one bug which we should probably fix before release.

On Mon, Aug 05, 2024 at 10:31:26AM +1000, Richard Henderson wrote:
> From: Clément Léger <cleger@rivosinc.com>
> 
> In order to make it cleaner, split qemu_close_all_open_fd() logic into
> multiple subfunctions (close with close_range(), with /proc/self/fd and
> fallback).
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20240802145423.3232974-3-cleger@rivosinc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/oslib-posix.c | 50 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 1e867efa47..9b79fc7cff 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -808,27 +808,16 @@ int qemu_msync(void *addr, size_t length, int fd)
>      return msync(addr, length, MS_SYNC);
>  }
>  
> -/*
> - * Close all open file descriptors.
> - */
> -void qemu_close_all_open_fd(void)
> +static bool qemu_close_all_open_fd_proc(void)
>  {
>      struct dirent *de;
>      int fd, dfd;
>      DIR *dir;
>  
> -#ifdef CONFIG_CLOSE_RANGE
> -    int r = close_range(0, ~0U, 0);
> -    if (!r) {
> -        /* Success, no need to try other ways. */
> -        return;
> -    }
> -#endif
> -
>      dir = opendir("/proc/self/fd");

IIUC from previous threads this is valid on Linux and on Solaris.

On FreeBSD & macOS, you need /dev/fd though.

>      if (!dir) {
>          /* If /proc is not mounted, there is nothing that can be done. */
> -        return;
> +        return false;
>      }
>      /* Avoid closing the directory. */
>      dfd = dirfd(dir);
> @@ -840,4 +829,39 @@ void qemu_close_all_open_fd(void)
>          }
>      }
>      closedir(dir);
> +
> +    return true;
> +}
> +
> +static bool qemu_close_all_open_fd_close_range(void)
> +{
> +#ifdef CONFIG_CLOSE_RANGE
> +    int r = close_range(0, ~0U, 0);
> +    if (!r) {
> +        /* Success, no need to try other ways. */
> +        return true;
> +    }
> +#endif
> +    return false;
> +}
> +
> +static void qemu_close_all_open_fd_fallback(void)
> +{
> +    int open_max = sysconf(_SC_OPEN_MAX), i;
> +
> +    /* Fallback */
> +    for (i = 0; i < open_max; i++) {
> +        close(i);
> +    }

I'm told that sysconf(_SC_OPEN_MAX) returns -1 on some versions of
macOS. "Luckily" since we assigned to 'int' rather than 'unsigned int'
this will result in us not closing any FDs in this fallback path,
rather than trying to close several billion FDs (an effective hang).

If _SC_OPEN_MAX returns -1, we should fallback to the OPEN_MAX
constant on macOS (see commit de448e0f26e710e9d2b7fc91393c40ac24b75847
which tackled a similar issue wrt getrlimit), and fallback to perhaps
a hardcoded 1024 on non-macOS.


> +}
> +
> +/*
> + * Close all open file descriptors.
> + */
> +void qemu_close_all_open_fd(void)
> +{
> +    if (!qemu_close_all_open_fd_close_range() &&
> +        !qemu_close_all_open_fd_proc()) {
> +        qemu_close_all_open_fd_fallback();
> +    }
>  }
> -- 
> 2.43.0
> 
> 

With regards,
Daniel

[1] https://github.com/open-mpi/ompi/issues/10358
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


