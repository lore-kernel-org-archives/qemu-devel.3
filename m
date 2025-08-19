Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0790CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKEZ-00071c-Ty; Tue, 19 Aug 2025 07:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKEX-00071D-J2
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKET-00054E-Gx
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755601823;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hn4un6hzf4nAQWWdr4A+yLaimhvI1zh9Siura+hxo4s=;
 b=a3lJJgkEuW5sardFGfcGIx2f4yshbeTU1l5gSafOFtpOz65Ld4OD9UgLn9Jc7pFeUuPCyj
 b2ygnYYYAIFRC1hYS7mzmSltSccYepavEgHm4el4i6U97g3Nbheoc+Zd4bwiCbj9/rcJ3b
 nRJfKOwe6bwyFGR+RToiOEIyef29BNE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-_ECtVvKANpa87mBRbX70ag-1; Tue,
 19 Aug 2025 07:10:22 -0400
X-MC-Unique: _ECtVvKANpa87mBRbX70ag-1
X-Mimecast-MFC-AGG-ID: _ECtVvKANpa87mBRbX70ag_1755601821
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EA591954209; Tue, 19 Aug 2025 11:10:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E489195419F; Tue, 19 Aug 2025 11:10:18 +0000 (UTC)
Date: Tue, 19 Aug 2025 12:10:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 06/12] net/slirp: Clean up error reporting
Message-ID: <aKRblxuJ-9_4jw0X@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808080823.2638861-7-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 08, 2025 at 10:08:17AM +0200, Markus Armbruster wrote:
> net_slirp_register_poll_sock() and net_slirp_unregister_poll_sock()
> report WSAEventSelect() failure with error_setg(&error_warn, ...).
> 
> I'm not familiar with liblirp, so I can't say whether the network

                       ^^^^^^^^^ 'libslirp'


> backend will work after such a failure.  If it doesn't, then this
> should be an error.  If it does, then why bother the user with a
> warning that isn't actionable, and likely confusing?
> 
> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
> ...)  are.  Replace by warn_report().
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> --->
  net/slirp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> diff --git a/net/slirp.c b/net/slirp.c
> index 9657e86a84..d75b09f16b 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -262,7 +262,8 @@ static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
>      if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
>                         FD_READ | FD_ACCEPT | FD_CLOSE |
>                         FD_CONNECT | FD_WRITE | FD_OOB) != 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
> +        warn_report("failed to WSAEventSelect(): %s",
> +                    g_win32_error_message(WSAGetLastError()));
>      }
>  #endif

IMHO this one ought to be considered fatal. If we can't select the
right events on the socket, then we're not going to have a good time
trying to poll on events. The libslirp callback API doesn't allow
us to return a success/failure code from this function, and IMHO it
is not appropriate to use error_fatal here because a fault with slirp
should not take down the whole of QEMU. So warn_report is the least
worst option I guess. At least it is a hint to the user that all is
not well - even if they can't action it, it might alert them if they
see network problems in their guest.


>  }
> @@ -271,7 +272,8 @@ static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
>  {
>  #ifdef WIN32
>      if (WSAEventSelect(fd, NULL, 0) != 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
> +        warn_report("failed to WSAEventSelect()",
> +                    g_win32_error_message(WSAGetLastError()));
>      }

This one is reasonable to treat as non-fatal, since once we've
unregistered the socket for polling

>  #endif
>  }
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


