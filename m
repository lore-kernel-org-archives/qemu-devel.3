Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DB9CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0jS-0003j1-Po; Fri, 12 Sep 2025 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux0jQ-0003fN-WE
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux0jJ-0002Un-RT
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757671806;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UReYHOAkzoHpQtGeGSdr0cEulBvUQbkY/8Z8y5KPB9o=;
 b=ayJw73o+quAfFG+jK7wz9T+rec9VrlRHD14KtkZSJ70iJ/dbg9QX1uVqIonZ2Rb0sbtTV4
 ULAqDdqC8vJbR7nUucPWBofvfT9ZGSCBXrEAjlDmMwZiP98jqNnXO8BUEbX16vRCinntyb
 z101HJeMzned4wnMF+S0rOvTCq3WBPw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-xR7NyC_gNFqCyNwkVXDgqA-1; Fri,
 12 Sep 2025 06:10:03 -0400
X-MC-Unique: xR7NyC_gNFqCyNwkVXDgqA-1
X-Mimecast-MFC-AGG-ID: xR7NyC_gNFqCyNwkVXDgqA_1757671802
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 411111955EA8; Fri, 12 Sep 2025 10:10:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CE3519560B1; Fri, 12 Sep 2025 10:10:00 +0000 (UTC)
Date: Fri, 12 Sep 2025 11:09:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 06/12] net/slirp: Clean up error reporting
Message-ID: <aMPxdD-HcLXR5qCn@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-7-armbru@redhat.com>
 <aKRblxuJ-9_4jw0X@redhat.com> <87348vzwdw.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87348vzwdw.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 01:40:59PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Aug 08, 2025 at 10:08:17AM +0200, Markus Armbruster wrote:
> >> net_slirp_register_poll_sock() and net_slirp_unregister_poll_sock()
> >> report WSAEventSelect() failure with error_setg(&error_warn, ...).
> >> 
> >> I'm not familiar with liblirp, so I can't say whether the network
> >
> >                        ^^^^^^^^^ 'libslirp'
> 
> Will fix, thanks!
> 
> >> backend will work after such a failure.  If it doesn't, then this
> >> should be an error.  If it does, then why bother the user with a
> >> warning that isn't actionable, and likely confusing?
> >> 
> >> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
> >> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
> >> ...)  are.  Replace by warn_report().
> >> 
> >> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  net/slirp.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> >> diff --git a/net/slirp.c b/net/slirp.c
> >> index 9657e86a84..d75b09f16b 100644
> >> --- a/net/slirp.c
> >> +++ b/net/slirp.c
> >> @@ -262,7 +262,8 @@ static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
> >>      if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
> >>                         FD_READ | FD_ACCEPT | FD_CLOSE |
> >>                         FD_CONNECT | FD_WRITE | FD_OOB) != 0) {
> >> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
> >> +        warn_report("failed to WSAEventSelect(): %s",
> >> +                    g_win32_error_message(WSAGetLastError()));
> >>      }
> >>  #endif
> >
> > IMHO this one ought to be considered fatal. If we can't select the
> > right events on the socket, then we're not going to have a good time
> > trying to poll on events. The libslirp callback API doesn't allow
> > us to return a success/failure code from this function, and IMHO it
> > is not appropriate to use error_fatal here because a fault with slirp
> > should not take down the whole of QEMU. So warn_report is the least
> > worst option I guess. At least it is a hint to the user that all is
> > not well - even if they can't action it, it might alert them if they
> > see network problems in their guest.
> 
> So, we'd make this an error if we could.  But we can't: the function is
> a callback that cannot fail, and outright exit(1) is too harsh.
> 
> That leaves silence or warning.  Warning is less bad.
> 
> Correct?

Yes.

> >> @@ -271,7 +272,8 @@ static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
> >>  {
> >>  #ifdef WIN32
> >>      if (WSAEventSelect(fd, NULL, 0) != 0) {
> >> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
> >> +        warn_report("failed to WSAEventSelect()",
> >> +                    g_win32_error_message(WSAGetLastError()));
> >>      }
> >
> > This one is reasonable to treat as non-fatal, since once we've
> > unregistered the socket for polling
> 
> Whether clearing the event associated with the socket can fail is
> unclear.  Whether it should be treated as an error is also unclear.
> 
> If yes, then same argument as for net_slirp_register_poll_sock() above.

If the callback allowed returning an error, we probably would return
an error, but then I'm confident slirp would do nothing more than
print a warning and continue to close the file handle as normal. It
doesn't make sense to turn file descriptor cleanup into fatal error.

> 
> If no, silence or warning.  Warning is less bad.
> 
> Correct?

Yes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


