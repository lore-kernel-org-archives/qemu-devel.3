Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B579CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6zt-0007mX-73; Fri, 12 Sep 2025 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux6zi-0007QN-C6
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux6zf-0000EP-4E
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 12:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757695885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmAsHjULGLQJBdHfodyBxFSKZ6/V5ppyuSPWZvJGAgc=;
 b=IIi0D2WmLAhXJXjSRhXuVRivwNsMKlsGJfdpAEUmTxqxXpQfWLsoZCIyK/14nD7h14pvZB
 DAu8A1DUYIvjdPEOluN18ctH8hS+xaj66qwdmzcKvOmws/yEUZc+InR+GDYdBwW/DYvknN
 yeJsmwE4S9d7tiLiHd4IlL/oxQxVggc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-u28FXBgoOIWlCsp_hmaSKQ-1; Fri,
 12 Sep 2025 12:51:22 -0400
X-MC-Unique: u28FXBgoOIWlCsp_hmaSKQ-1
X-Mimecast-MFC-AGG-ID: u28FXBgoOIWlCsp_hmaSKQ_1757695881
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0398B180057F; Fri, 12 Sep 2025 16:51:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 092FD30002CA; Fri, 12 Sep 2025 16:51:17 +0000 (UTC)
Date: Fri, 12 Sep 2025 17:51:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH v2 3/8] util: add qemu_set_blocking() function
Message-ID: <aMRPgVbdZWaG8PXS@redhat.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911092007.1370002-4-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 11, 2025 at 12:20:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> In generic code we have qio_channel_set_blocking(), which takes
> bool parameter, and qemu_file_set_blocking(), which as well takes
> bool parameter.
> 
> At lower fd-layer we have a mess of functions:
> 
> - enough direct calls to Unix-specific g_unix_set_fd_nonblocking()
> (of course, all calls are out of Windows-compatible code), which
> is glib specific with GError, which we can't use, and have to
> handle error-reporting by hand after the call.
> 
> and several platform-agnostic qemu_* helpers:
> 
> - qemu_socket_set_nonblock(), which asserts success for posix (still,
>   in most cases we can handle the error in better way) and ignores
>   error for win32 realization
> 
> - qemu_socket_try_set_nonblock(), providing and error, but not errp,
> so we have to handle it after the call
> 
> - qemu_socket_set_block(), which simply ignores an error
> 
> Note, that *_socket_* word in original API, which we are going
> to substitute was intended, because Windows support these operations
> only for sockets. What leads to solution of dropping it again?
> 
> 1. Having a QEMU-native wrapper with errp parameter
> for g_unix_set_fd_nonblocking() for non-socket fds worth doing,
> at least to unify error handling.
> 
> 2. So, if try to keep _socket_ vs _file_ words, we'll have two
> actually duplicated functions for Linux, which actually will
> be executed successfully on any (good enough) fds, and nothing
> prevent using them improperly except for the name. That doesn't
> look good.
> 
> 3. Naming helped us in the world where we crash on errors or
> ignore them. Now, with errp parameter, callers are intended to
> proper error checking. And for places where we really OK with
> crash-on-error semantics (like tests), we have an explicit
> &error_abort.
> 
> So, this commit starts a series, which will effectively revert
> commit ff5927baa7ffb9 "util: rename qemu_*block() socket functions"
> (which in turn was reverting f9e8cacc5557e43
> "oslib-posix: rename socket_set_nonblock() to qemu_set_nonblock()",
> so that's a long story).
> Now we don't simply rename, instead we provide the new API and
> update all the callers.
> 
> This commit only introduces a new fd-layer wrapper. Next commits
> will replace old API calls with it, and finally remove old API.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/qemu/osdep.h |  1 +
>  util/oslib-posix.c   | 15 +++++++++++++++
>  util/oslib-win32.c   | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


