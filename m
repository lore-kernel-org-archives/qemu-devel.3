Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A0ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 15:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyXvK-0008QH-Ug; Tue, 16 Sep 2025 11:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyXvI-0008PM-QF
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 11:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyXvG-0005No-T2
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 11:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758037728;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctnshwC3wpTYBiIO3Yj4rpYsDrTe5MHK6ihIOrt3Pqg=;
 b=YZheJ282fWuFQg3/nzlTqIaYlhTHLq7ZAi5l8NT0PAog1tozcDhgQol+vjhyChl3wByrvD
 xSvspbncbk7gGqgqz6jMugyTS9maP75YVWvsnaVSJRVTItngB5Vo0alPU4mZ4xRBPpz8sU
 4J5e6flBRZCECfk5lYgKpCu0b17TPlE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-Fo6SZ8kSNIamRxU-FlH2SQ-1; Tue,
 16 Sep 2025 11:48:39 -0400
X-MC-Unique: Fo6SZ8kSNIamRxU-FlH2SQ-1
X-Mimecast-MFC-AGG-ID: Fo6SZ8kSNIamRxU-FlH2SQ_1758037718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 081C51800634; Tue, 16 Sep 2025 15:47:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC6F61955F23; Tue, 16 Sep 2025 15:47:51 +0000 (UTC)
Date: Tue, 16 Sep 2025 16:47:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH v5 06/13] util: drop qemu_socket_set_nonblock()
Message-ID: <aMmGpFB86YCXquxH@redhat.com>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-7-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916131403.368343-7-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 04:13:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Use common qemu_set_blocking() instead.
> 
> Note that pre-patch the behavior of Win32 and Linux realizations
> are inconsistent: we ignore failure for Win32, and assert success
> for Linux.
> 
> How do we convert the callers?
> 
> 1. Most of callers call qemu_socket_set_nonblock() on a
> freshly created socket fd, in conditions when we may simply
> report an error. Seems correct switching to error handling
> both for Windows (pre-patch error is ignored) and Linux
> (pre-patch we assert success). Anyway, we normally don't
> expect errors in these cases.
> 
> Still in tests let's use &error_abort for simplicity.
> 
> What are exclusions?
> 
> 2. hw/virtio/vhost-user.c - we are inside #ifdef CONFIG_LINUX,
> so no damage in switching to error handling from assertion.
> 
> 3. io/channel-socket.c: here we convert both old calls to
> qemu_socket_set_nonblock() and qemu_socket_set_block() to
> one new call. Pre-patch we assert success for Linux in
> qemu_socket_set_nonblock(), and ignore all other errors here.
> So, for Windows switch is a bit dangerous: we may get
> new errors or crashes(when error_abort is passed) in
> cases where we have silently ignored the error before
> (was it correct in all such cases, if they were?) Still,
> there is no other way to stricter API than take
> this risk.
> 
> 4. util/vhost-user-server - compiled only for Linux (see
> util/meson.build), so we are safe, switching from assertion to
> &error_abort.
> 
> Note: In qga/channel-posix.c we use g_warning(), where g_printerr()
> would actually be a better choice. Still let's for now follow
> common style of qga, where g_warning() is commonly used to print
> such messages, and no call to g_printerr(). Converting everything
> to use g_printerr() should better be another series.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  contrib/ivshmem-server/ivshmem-server.c |  9 ++++++++-
>  hw/hyperv/syndbg.c                      |  4 +++-
>  hw/virtio/vhost-user.c                  |  5 ++++-
>  include/qemu/sockets.h                  |  1 -
>  io/channel-socket.c                     |  7 +++----
>  net/dgram.c                             | 16 +++++++++++++---
>  net/l2tpv3.c                            |  5 +++--
>  net/socket.c                            | 20 ++++++++++++++++----
>  qga/channel-posix.c                     |  7 ++++++-
>  tests/unit/socket-helpers.c             |  4 +++-
>  tests/unit/test-crypto-tlssession.c     |  8 ++++----
>  util/oslib-posix.c                      |  7 -------
>  util/oslib-win32.c                      |  5 -----
>  util/vhost-user-server.c                |  6 ++++--
>  14 files changed, 67 insertions(+), 37 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


