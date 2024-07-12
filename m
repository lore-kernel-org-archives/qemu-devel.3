Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C22C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHx0-0004MX-8T; Fri, 12 Jul 2024 11:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSHwy-0004H7-Gd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSHwu-0002TP-4j
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720797158;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0aOKVAoYy8kjDiARTBIq5mEyQmP9bjRtjmF9kr+1Aw=;
 b=cBCsPdiv2DJcVIEMx5SncIgQ9/pIx3uMOj2BA6NK5w8lw2QmnidefBVFU3adgrrKPr+9MV
 pqKzmvbyGw90omp6jcuvNuIdGCZC/ToYT+eTMmIy5OWTRGsfU6may3nQvoZWrw7Xhx9Tnz
 q7+pj+rtkIoHucWS594uZ3fm2fqJmCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-qvQqgkQQPhKlmc9_jEyWHw-1; Fri,
 12 Jul 2024 11:12:36 -0400
X-MC-Unique: qvQqgkQQPhKlmc9_jEyWHw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05381196E096; Fri, 12 Jul 2024 15:12:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC83E3000181; Fri, 12 Jul 2024 15:12:31 +0000 (UTC)
Date: Fri, 12 Jul 2024 16:12:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] osdep: add a qemu_close_all_open_fd() helper
Message-ID: <ZpFH3E78ly_CP2fF@redhat.com>
References: <20240618111704.63092-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240618111704.63092-1-cleger@rivosinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 18, 2024 at 01:17:03PM +0200, Clément Léger wrote:
> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
> POSIX"), the maximum number of file descriptors that can be opened are
> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
> of 1073741816 file descriptors. Now, when forking to start
> qemu-bridge-helper, this actually calls close() on the full possible file
> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
> takes a considerable amount of time. In order to reduce that time,
> factorize existing code to close all open files descriptors in a new
> qemu_close_all_open_fd() function. This function uses various methods
> to close all the open file descriptors ranging from the most efficient
> one to the least one. It also accepts an ordered array of file
> descriptors that should not be closed since this is required by the
> callers that calls it after forking.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ----
> 
> v2:
>  - Factorize async_teardown.c close_fds implementation as well as tap.c ones
>  - Apply checkpatch
>  - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/
> 
> ---
>  include/qemu/osdep.h    |   8 +++
>  net/tap.c               |  31 ++++++-----
>  system/async-teardown.c |  37 +------------
>  util/osdep.c            | 115 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 141 insertions(+), 50 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index f61edcfdc2..9369a97d3d 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -755,6 +755,14 @@ static inline void qemu_reset_optind(void)
>  
>  int qemu_fdatasync(int fd);
>  
> +/**
> + * Close all open file descriptors except the ones supplied in the @skip array
> + *
> + * @skip: ordered array of distinct file descriptors that should not be closed
> + * @nskip: number of entries in the @skip array.
> + */
> +void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
> +
>  /**
>   * Sync changes made to the memory mapped file back to the backing
>   * storage. For POSIX compliant systems this will fallback
> diff --git a/net/tap.c b/net/tap.c
> index 51f7aec39d..6fc3939078 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -385,6 +385,21 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>      return s;
>  }
>  
> +static void close_all_fds_after_fork(int excluded_fd)
> +{
> +        const int skip_fd[] = {0, 1, 2, 3, excluded_fd};
> +        unsigned int nskip = ARRAY_SIZE(skip_fd);
> +
> +        /*
> +         * skip_fd must be an ordered array of distinct fds, exclude
> +         * excluded_fd if already included in the [0 - 3] range
> +         */
> +        if (excluded_fd <= 3) {
> +            nskip--;
> +        }
> +        qemu_close_all_open_fd(skip_fd, nskip);
> +}

This is slightly over-indented - 4 space is QEMU normal style.

> diff --git a/util/osdep.c b/util/osdep.c
> index 5d23bbfbec..f3710710e3 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -625,3 +625,118 @@ int qemu_fdatasync(int fd)
>      return fsync(fd);
>  #endif
>  }
> +
> +#ifdef CONFIG_LINUX
> +static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
> +{
> +    struct dirent *de;
> +    int fd, dfd;
> +    bool close_fd;
> +    DIR *dir;
> +    int i;
> +
> +    dir = opendir("/proc/self/fd");
> +    if (!dir) {
> +        /* If /proc is not mounted, there is nothing that can be done. */
> +        return false;
> +    }
> +    /* Avoid closing the directory. */
> +    dfd = dirfd(dir);
> +
> +    for (de = readdir(dir); de; de = readdir(dir)) {

Don't we need

   if (de->d_name[0] == '.') {
       continue;
   }

otherwise atoi will fail and we'll try to close(0) multiple
times.

> +        fd = atoi(de->d_name);
> +        close_fd = true;
> +        if (fd == dfd) {
> +            close_fd = false;
> +        } else {
> +            for (i = 0; i < nskip; i++) {
> +                if (fd == skip[i]) {
> +                    close_fd = false;
> +                    break;
> +                }
> +            }
> +        }
> +        if (close_fd) {
> +            close(fd);
> +        }
> +    }
> +    closedir(dir);
> +
> +    return true;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


