Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC044CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 11:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFWa-0001av-CG; Tue, 04 Nov 2025 06:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vGFWZ-0001aZ-DZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vGFWX-0005Dx-Ot
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 06:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762256908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y33RQK4PxXYEUupzVXKQ9q6yHJC8VLgotoz3rU1+dx4=;
 b=gBxyFXFAOeBfcBCaVIKTiruoP/qN4+iJ46EkYtt7YrT4m8Qce1ofm4ne8Ux1HFDGswtn4m
 W4EDzD0W6WPeA0LChtwlU0shL97StzlMqU27PGt44/UwjWbtNDS3zxKOoO0lf40yOxb/l0
 jzLOQYzgnGvdHO/AlB3gABfEHljKMQM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-mUyAUewJNuOgFBto3lcLVw-1; Tue,
 04 Nov 2025 06:48:23 -0500
X-MC-Unique: mUyAUewJNuOgFBto3lcLVw-1
X-Mimecast-MFC-AGG-ID: mUyAUewJNuOgFBto3lcLVw_1762256902
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D9F81955DD9; Tue,  4 Nov 2025 11:48:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2791219540DA; Tue,  4 Nov 2025 11:48:17 +0000 (UTC)
Date: Tue, 4 Nov 2025 11:48:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 raphael@enfabrica.net, armbru@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH v6 0/7] chardev: postpone connect
Message-ID: <aQnn_n0AuBjl4qQ_@redhat.com>
References: <20251104101715.76691-1-vsementsov@yandex-team.ru>
 <CAMxuvazmJ+0fUDae-W4ZFFKAgtZLBFrxtZCrTT8sgBCmNirW2g@mail.gmail.com>
 <aQnmW2NskQtEfsGe@redhat.com>
 <966c338b-8302-4583-be9b-bb683ce3f3c5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <966c338b-8302-4583-be9b-bb683ce3f3c5@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 04, 2025 at 02:44:49PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 04.11.25 14:41, Daniel P. Berrangé wrote:
> > On Tue, Nov 04, 2025 at 03:35:17PM +0400, Marc-André Lureau wrote:
> > > Hi Vladimir
> > > 
> > > On Tue, Nov 4, 2025 at 2:17 PM Vladimir Sementsov-Ogievskiy <
> > > vsementsov@yandex-team.ru> wrote:
> > > 
> > > > Hi all!
> > > > 
> > > > That's a preparation for backend-transfer migration of
> > > > vhost-user-blk, and introduced DEFINE_PROP_CHR_NO_CONNECT()
> > > > is unused now.
> > > > 
> > > > v3 of "vhost-user-blk: live-backend local migration" is coming
> > > > soon, and will be based on this series (and will use
> > > > DEFINE_PROP_CHR_NO_CONNECT of course).
> > > > 
> > > > changes in v6:
> > > > 05: move connect() call into "if (s)"
> > > > 07: - drop assertion
> > > >      - improve doc comment, to cover @s==NULL relations with @connect
> > > >      - add r-b by Marc-André
> > > > 
> > > > Vladimir Sementsov-Ogievskiy (7):
> > > >    chardev/char-socket: simplify reconnect-ms handling
> > > >    chardev/char: split chardev_init_common() out of qemu_char_open()
> > > >    chardev/char: qemu_char_open(): add return value
> > > >    chardev/char: move filename and be_opened handling to qemu_char_open()
> > > >    chardev/char: introduce .init() + .connect() initialization interface
> > > >    chardev/char-socket: move to .init + .connect api
> > > >    chardev: introduce DEFINE_PROP_CHR_NO_CONNECT
> > > > 
> > > 
> > > Do you need this series in 10.2? We are at soft-freeze today, this is
> > > closer to a feature than a simple refactoring, we may just wait for the
> > > next dev phase.
> > 
> > Back in v2, I had a request to convert the other chardev backends
> > to the new model too, as IMHO it is undesirable to introduce the
> > technical debt by only touching 1 backend:
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg03272.html
> > 
> 
> Right. I remember it, and have a draft converting series. It turned out to be more than expected,
> about 24 commits, and personally I'm not sure, that it worth doing.. I'll send an RFC too look at.

Yep, I'd be interested to see what it looks like, even if it is not
finished / not functional.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


