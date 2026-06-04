Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091E2CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV3eg-0001SX-Lp; Thu, 04 Jun 2026 04:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wV3ed-0001SI-NR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 04:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wV3eb-0004Ka-4a
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780562535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1gfaD7DbozLWnbaTEs6WDiPT5A1mfIDfcAbuf+pVIrY=;
 b=i0zqooE4+SQIDTfuPP0dlLcCcmFCsi1mWibpc3JW602V0LVjVW7DcFeGhFU+lViTrtGLfI
 PNGqCKlNYOtZSCMsZzvrdNTEJV9xdG4LB0mnIJLcPbk4rgZAnmKdKjKeR6IMGMNjuawqtc
 YyaW+UyAq1+M3pF0vV04pRkr59uAPxk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-75PW4EYbPramaudeIAudjw-1; Thu,
 04 Jun 2026 04:42:11 -0400
X-MC-Unique: 75PW4EYbPramaudeIAudjw-1
X-Mimecast-MFC-AGG-ID: 75PW4EYbPramaudeIAudjw_1780562530
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C6D9195608D; Thu,  4 Jun 2026 08:42:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6296195608E; Thu,  4 Jun 2026 08:42:08 +0000 (UTC)
Date: Thu, 4 Jun 2026 09:42:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io/channel-socket: move cmsg memset into fd-passing
 branches
Message-ID: <aiE6XZrUOCqJ1wdk@redhat.com>
References: <20260529021324.52124-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529021324.52124-1-guobin@linux.alibaba.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 29, 2026 at 10:13:24AM +0800, Bin Guo wrote:
> In qio_channel_socket_readv() and qio_channel_socket_writev(), the
> control message buffer is unconditionally zeroed on every call, even
> when no file descriptors are being transferred.  The memset touches
> CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS) bytes -- typically 80 bytes
> on x86-64 -- on every I/O operation.

Did you have a real world scenario where this creates an I/O
performance problem, or is this just a optimization to address
a theoretical concern ?

> Move the memset into the conditional branches that actually set up
> msg_control, so the common fast path (no fd passing) avoids the
> unnecessary zeroing.  Also narrow the scope of fdsize and cmsg in
> writev() to the branch that uses them.
> 
> No functional change for paths that transfer file descriptors.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  io/channel-socket.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 3053b35ad8..d19c73cacc 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -562,11 +562,10 @@ static ssize_t qio_channel_socket_readv(QIOChannel *ioc,
>      char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)];

QEMU builds with -ftrivial-auto-var-init=zero always set so this
control variable will always be zero-initialized by the compiler
making the following memset() pointless/redundant.

AFAICT, the compiler optimization will identify this and remove
the memset() call entirely.  IOW, I don't believe the change
proposed in your patch will have any effect.

If we want to be explicit about this then we should just do

  char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)] = {};

and remove the memset() from our code entirely.

>      int sflags = 0;
>  
> -    memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
> -
>      msg.msg_iov = (struct iovec *)iov;
>      msg.msg_iovlen = niov;
>      if (fds && nfds) {
> +        memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>          msg.msg_control = control;
>          msg.msg_controllen = sizeof(control);
>  #ifdef MSG_CMSG_CLOEXEC
> @@ -622,20 +621,19 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>      ssize_t ret;
>      struct msghdr msg = { NULL, };
>      char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)];
> -    size_t fdsize = sizeof(int) * nfds;
> -    struct cmsghdr *cmsg;
>      int sflags = 0;
>  #ifdef QEMU_MSG_ZEROCOPY
>      bool blocking = sioc->blocking;
>      bool zerocopy_flushed_once = false;
>  #endif
>  
> -    memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
> -
>      msg.msg_iov = (struct iovec *)iov;
>      msg.msg_iovlen = niov;
>  
>      if (nfds) {
> +        size_t fdsize = sizeof(int) * nfds;
> +        struct cmsghdr *cmsg;
> +
>          if (nfds > SOCKET_MAX_FDS) {
>              error_setg_errno(errp, EINVAL,
>                               "Only %d FDs can be sent, got %zu",
> @@ -643,6 +641,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>              return -1;
>          }
>  
> +        memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>          msg.msg_control = control;
>          msg.msg_controllen = CMSG_SPACE(sizeof(int) * nfds);
>  
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


