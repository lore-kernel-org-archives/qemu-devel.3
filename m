Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B181C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 14:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7yu-00060h-Lv; Tue, 26 Mar 2024 10:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rp7yo-000605-0i
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rp7yk-0003oz-QO
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711464041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YmZdisNf4h193/qaMhzYQSQ8bTH12Y98KwsiI+ZLzg=;
 b=Mm3e1x8LnLUPPCusmGTKbDiECvlUFHRlWXx3ksx6nKgZ9i4LetzVP/zu2VnUBS/2IOAjsn
 3XfKYW2DwWCzAPLSIvSo40zNweFqHSUhX3Y4Pyh70zjZk0Gby7czn/Po+y/4CM18yzWMhy
 gT4+jZqV2Nusm6j6UZGpwYWMB14Hhxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-2ITojYG7NgKRb5fHi8lGUg-1; Tue, 26 Mar 2024 10:40:38 -0400
X-MC-Unique: 2ITojYG7NgKRb5fHi8lGUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DB0E101A523;
 Tue, 26 Mar 2024 14:40:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E644A40C6CB1;
 Tue, 26 Mar 2024 14:40:33 +0000 (UTC)
Date: Tue, 26 Mar 2024 09:40:12 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 04/11] vhost-user-server: don't abort if we
 can't set fd non-blocking
Message-ID: <img3eawf5augdcdnrw6i2bteobxo46wjibdfzugnfikgpi7xuk@2izhutalpmwg>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-5-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326133936.125332-5-sgarzare@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 02:39:29PM +0100, Stefano Garzarella wrote:
> In vhost-user-server we set all fd received from the other peer
> in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
> if we fail, it's not really a problem, because we don't use these
> fd with blocking operations, but only to map memory.
> 
> In these cases a failure is not bad, so let's just report a warning
> instead of panicking if we fail to set some fd in non-blocking mode.
> 
> This for example occurs in macOS where setting shm_open() fd
> non-blocking is failing (errno: 25).

What is errno 25 on MacOS?

> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  util/vhost-user-server.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> index 3bfb1ad3ec..064999f0b7 100644
> --- a/util/vhost-user-server.c
> +++ b/util/vhost-user-server.c
> @@ -66,7 +66,11 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
>  {
>      int i;
>      for (i = 0; i < vmsg->fd_num; i++) {
> -        qemu_socket_set_nonblock(vmsg->fds[i]);
> +        int ret = qemu_socket_try_set_nonblock(vmsg->fds[i]);
> +        if (ret) {

Should this be 'if (ret < 0)'?

> +            warn_report("Failed to set fd %d nonblock for request %d: %s",
> +                        vmsg->fds[i], vmsg->request, strerror(-ret));
> +        }

This now ignores all errors even on pre-existing fds where we NEED
non-blocking, rather than just the specific (expected) error we are
seeing on MacOS.  Should this code be a bit more precise about
checking that -ret == EXXX for the expected errno value we are
ignoring for the specific fds where non-blocking is not essential?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


