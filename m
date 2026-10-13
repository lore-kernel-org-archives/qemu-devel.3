Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0412CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXUM-0003Y7-3f; Tue, 13 Oct 2026 04:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXTD-0003Jy-Dc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGXT9-0003Iv-GN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791878560;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XSHqxJBkNztMd7EGTXRmz227EB5F3r9OF7knGdKidnM=;
 b=RCzsmzLLjV+8eEUxi+9cx0pBtt7oF6/UPJw9ix2uiN8WdN+qq7J2yM8Ir1E5bAwcpYkjzC
 VUaiFLgcAlB81RdsGTtEt12ByUzb7X9pi411hkMDGFoiD2ReO4H9DqKr/7SA+LoIRj9rmu
 alykoYKiaaCACaSznMOrIFbVOgCTFG4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-ZQ1isKXfPA2dL_3s6MKFow-1; Tue,
 13 Oct 2026 08:02:38 +0000
X-MC-Unique: ZQ1isKXfPA2dL_3s6MKFow-1
X-Mimecast-MFC-AGG-ID: ZQ1isKXfPA2dL_3s6MKFow_1791878557
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6882D184AE4A; Tue, 13 Oct 2026 08:02:36 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8C4E1956095; Tue, 13 Oct 2026 08:02:32 +0000 (UTC)
Date: Tue, 13 Oct 2026 09:02:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Subject: Re: [PATCH not-so-trivial v2] treewide: use qemu_dup() instead of
 dup()
Message-ID: <as3lliIKDs6aTRnS@redhat.com>
References: <20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Oct 13, 2026 at 12:01:58AM +0200, Filip Hejsek wrote:
> Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
> 
> The following dup() instances were left unchanged:
> 
>     FILE                     REASON
>     util/osdep.c             implementation of qemu_dup
>     migration/cpr-exec.c     fd is intentionally kept across exec

IMHO that should use qemu_dup() too, and then explicitly
clear the O_CLOEXEC flag so intended behaviour is clear.
Right now it looks like a mistaken failure to use qemu_dup.

>     {linux,bsd}-user/*       guest syscalls

That's fine

>     tests/*                  left for future work

Why not fix them now ? There are only a few uses which look suitable
to change.

> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
> For each call I replaced, I checked how the resulting fd is used
> afterwards. In summary:
> 
> hw/virtio/virtio.c:
>     the fd is passed to memory_region_init_ram_from_fd, used for mmaping
> 
> io/channel-file.c:
>     the fd is passed to qio_channel_file_new_fd, used for reading/writing
> 
> qemu-nbd.c:
>     the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO
> 
> system/vl.c:
>     no change in behavior, the code was already setting the cloexec flag
> 
> ui/dmabuf.c:
>     the function is called by qemu_spice_gl_update, which passes the fds
>     to SPICE server
> 
> These uses shouldn't require keeping the fd open across exec.
> 
> Changes in v2:
> - Replace the use in qemu-nbd.c too
> - Changed commit message
> - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
> ---
>  hw/virtio/virtio.c | 2 +-
>  io/channel-file.c  | 2 +-
>  qemu-nbd.c         | 2 +-
>  system/vl.c        | 9 +--------
>  ui/dmabuf.c        | 2 +-
>  5 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index c9f9e5b511..70779fbd56 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3204,7 +3204,7 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
>          return NULL;
>      }
>  
> -    fd = dup(fd);
> +    fd = qemu_dup(fd);
>      if (fd < 0) {
>          error_report("Failed to duplicate fd: %s", strerror(errno));
>          return NULL;
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 5cef75a67c..3f707e80c9 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -48,7 +48,7 @@ qio_channel_file_new_fd(int fd)
>  QIOChannelFile *
>  qio_channel_file_new_dupfd(int fd, Error **errp)
>  {
> -    int newfd = dup(fd);
> +    int newfd = qemu_dup(fd);
>  
>      if (newfd < 0) {
>          error_setg_errno(errp, errno, "Could not dup FD %d", fd);
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index ed5895861b..db1a70b008 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -975,7 +975,7 @@ int main(int argc, char **argv)
>  
>              /* Remember parent's stderr if we will be restoring it. */
>              if (opts.verbose /* fork_process is set */) {
> -                opts.old_stderr = dup(STDERR_FILENO);
> +                opts.old_stderr = qemu_dup(STDERR_FILENO);
>                  if (opts.old_stderr < 0) {
>                      error_report("Could not dup original stderr: %s",
>                                   strerror(errno));
> diff --git a/system/vl.c b/system/vl.c
> index 468a9fc247..9381e3d7f7 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -614,14 +614,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
>          return -1;
>      }
>  
> -#ifdef F_DUPFD_CLOEXEC
> -    dupfd = fcntl(fd, F_DUPFD_CLOEXEC, 0);
> -#else
> -    dupfd = dup(fd);
> -    if (dupfd != -1) {
> -        qemu_set_cloexec(dupfd);
> -    }
> -#endif
> +    dupfd = qemu_dup(fd);
>      if (dupfd == -1) {
>          error_setg_errno(errp, errno, "error duplicating fd");
>          return -1;
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> index 497f82cc61..6d5dffdf84 100644
> --- a/ui/dmabuf.c
> +++ b/ui/dmabuf.c
> @@ -95,7 +95,7 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
>      assert(nfds >= dmabuf->num_planes);
>  
>      for (i = 0; i < dmabuf->num_planes; i++) {
> -        fds[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
> +        fds[i] = dmabuf->fd[i] >= 0 ? qemu_dup(dmabuf->fd[i]) : -1;
>      }
>  }
>  
> 
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20261012-use-qemu-dup-38628dbac3ee
> 
> Best regards,
> --  
> Filip Hejsek <filip.hejsek@gmail.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


