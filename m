Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82C0CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux58f-0001YS-7o; Fri, 12 Sep 2025 10:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux58D-0001LH-E4
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux588-0008CV-R0
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757688722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SivYwmxhcrWx6IMF7LiJ3BDNqurAEuyyG92OCez6+A=;
 b=hincPQ1QJMA2BuaZuVoRy4rO+SnBoklXURrOLZPWxAuOnp1o8bO4Q+rgeAqhE9Vi9Tv+uO
 iowm8gYwy+0sMzk3KnJecXclwEXEnbvC696/3EnxXcFFw/DrREDXCBWhqUi+RWGno07/FH
 dfoYFKEdKV4NpJj1wb1T6ezw2eFTS3M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Gt4KitLpP9W5ca0Lj9MWuQ-1; Fri,
 12 Sep 2025 10:51:59 -0400
X-MC-Unique: Gt4KitLpP9W5ca0Lj9MWuQ-1
X-Mimecast-MFC-AGG-ID: Gt4KitLpP9W5ca0Lj9MWuQ_1757688718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EB9A1800451; Fri, 12 Sep 2025 14:51:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7DB6300021A; Fri, 12 Sep 2025 14:51:53 +0000 (UTC)
Date: Fri, 12 Sep 2025 15:51:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
Message-ID: <aMQzhtn14Q4wZ-79@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
 <aMFIhJp-GfOhv3AV@redhat.com>
 <2bfafcf7-7051-4c14-a580-fb33895a0a1a@yandex-team.ru>
 <aMHAQkYQ1kK4_yD_@redhat.com>
 <719b1b6e-524e-4993-9977-cbceaff2a776@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719b1b6e-524e-4993-9977-cbceaff2a776@yandex-team.ru>
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

On Wed, Sep 10, 2025 at 09:52:40PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 10.09.25 21:15, Daniel P. Berrangé wrote:
> > On Wed, Sep 10, 2025 at 08:55:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 10.09.25 12:44, Daniel P. Berrangé wrote:
> > > > > @@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
> > > > >            g_warning("error converting fd to gsocket: %s", strerror(errno));
> > > > >            goto out;
> > > > >        }
> > > > > -    qemu_socket_set_nonblock(client_fd);
> > > > > +    if (!qemu_set_blocking(client_fd, false, &err)) {
> > > > > +        g_warning("errer: %s", error_get_pretty(err));
> > > > s/errer/error/
> > > > 
> > > > 
> > > > This is a pre-existing problem, but none of this code should be using
> > > > g_warning. g_printerr() should have been used for printing error
> > > > messages. I'm not expecting you to fix that, just an observation.
> > > 
> > > 
> > > Why not g_error()? I see some g_warnings in qga code a correct "warnings", not "errors".. And if we use sometimes g_warning, the g_error is more correct pair for it.
> > > 
> > > Or we don't want any of g_error / g_warning in QEMU code?
> > 
> > g_error will call abort() after printing the message, which will
> > prevent graceful cleanup and result in a core file, so is not
> > very desirable to use.
> 
> Oh, right, I was stupid)
> 
> > 
> > g_warning will also turn into g_error if G_DEBUG=fatal-warnings
> > is set.
> > 
> > We really just want a plain message printed on the console with
> > no side effects, and g_printerr gives us that.
> > 
> > 
> 
> Still, it's strange for me, that we just not use error_reprot()/warn_report() everywhere.

Those would be viable alternatives too. Basically anything is better
than 'g_warning' for this scenario :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


