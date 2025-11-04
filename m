Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A7BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGnv-00025F-7r; Tue, 04 Nov 2025 08:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vGGnr-00024R-E2
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vGGnn-00055e-OH
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762261820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0NlBOm1T8Hfdsw/aIBdJGE3Ec1MX6AjeHJd4fMcoWUc=;
 b=NKYTnE0Kj1eXWSBojIlT3N35KEsNkXZudInMOil628mfc6PdnkkzjV9TmRQp+9afQFK0WU
 +N8RCEzSSTY8EPseZV/SSI0O1+nOs1a39fLQJhf+2YgczbRxhz8pR73Fx1TVNgHM81AnoD
 Xp/5FfiwMPE32hnipflkDtH0SYAtlXE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-M8G2XoNnNiKg7seb7eNUkg-1; Tue,
 04 Nov 2025 08:10:18 -0500
X-MC-Unique: M8G2XoNnNiKg7seb7eNUkg-1
X-Mimecast-MFC-AGG-ID: M8G2XoNnNiKg7seb7eNUkg_1762261817
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A42F19560A5; Tue,  4 Nov 2025 13:10:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D16F4180045B; Tue,  4 Nov 2025 13:10:15 +0000 (UTC)
Date: Tue, 4 Nov 2025 13:10:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH 4/8] qio: Factor out helpers qio_net_listener_[un]watch
Message-ID: <aQn7NF8bVZ3TO3Zo@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
 <20251103202849.3687643-14-eblake@redhat.com>
 <aQnzjtDgSakaTgPi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQnzjtDgSakaTgPi@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 04, 2025 at 01:37:34PM +0100, Kevin Wolf wrote:
> Am 03.11.2025 um 21:10 hat Eric Blake geschrieben:
> > The code had three similar repetitions of an iteration over one or all
> > of nsiocs to set up a GSource, and likewise for teardown.  Since an
> > upcoming patch wants to tweak whether GSource or AioContext is used,
> > its better to consolidate that into one helper function for fewer
> > places to edit later.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >  io/net-listener.c | 109 +++++++++++++++++++---------------------------
> >  1 file changed, 45 insertions(+), 64 deletions(-)
> 
> > @@ -145,15 +174,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
> >                                             GDestroyNotify notify,
> >                                             GMainContext *context)
> >  {
> > -    size_t i;
> > -
> >      if (listener->io_func == func && listener->io_data == data) {
> >          return;
> >      }
> > 
> > -    if (listener->io_func) {
> > -        trace_qio_net_listener_watch_disabled(listener, "set_client_func");
> > -    }
> > +    qio_net_listener_unwatch(listener, "set_client_func");
> >      if (listener->io_notify) {
> >          listener->io_notify(listener->io_data);
> >      }
> 
> This changes the order between the io_notify() call and the unwatch. Is
> this intentional? If so, maybe mention it in the commit message and why
> it's safe.

At least conceptually I think this ordering is better, and I don't think
there should be any functional consequences from the change.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


