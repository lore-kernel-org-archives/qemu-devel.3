Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40FFC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 15:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3GdI-0006Xm-Cs; Fri, 11 Apr 2025 11:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3GdF-0006VE-OI
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 11:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3GdD-00057J-99
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 11:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744386563;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMq5xXT/9pKn/hJyOlzTaZTjwqEj659pZeGb2MrcDIY=;
 b=QVTu229uLESnt0pKCJemjDjrYZjcJJlC8kSAc2gsGT6AT9mKh2RDzWIfhUAnHAsZfHrkdU
 r5dkF+G5aNuBSRQPy8PtM9qeHu+3D98uSMMz65INsyV7WMN2tvl6HsLxtT+s8LnIjTrPbr
 ilmcWzFeSvAHsFv3R6d1aXqnd/qqgBI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-Zsnu3_D-Oo-ILTyBqBHX6w-1; Fri,
 11 Apr 2025 11:49:21 -0400
X-MC-Unique: Zsnu3_D-Oo-ILTyBqBHX6w-1
X-Mimecast-MFC-AGG-ID: Zsnu3_D-Oo-ILTyBqBHX6w_1744386560
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 820771954B38; Fri, 11 Apr 2025 15:49:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF77919560AD; Fri, 11 Apr 2025 15:49:16 +0000 (UTC)
Date: Fri, 11 Apr 2025 16:49:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 5/5] utils/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Message-ID: <Z_k5-ShXToaRUAUO@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
 <20250408112508.1638722-6-jmarcin@redhat.com>
 <Z_kfFTiGkK0dC73f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_kfFTiGkK0dC73f@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 11, 2025 at 02:54:29PM +0100, Daniel P. Berrangé wrote:
> On Tue, Apr 08, 2025 at 01:25:04PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > With the default TCP stack configuration, it could be even 2 hours
> > before the connection times out due to the other side not being
> > reachable. However, in some cases, the application needs to be aware of
> > a connection issue much sooner.
> > 
> > This is the case, for example, for postcopy live migration. If there is
> > no traffic from the migration destination guest (server-side) to the
> > migration source guest (client-side), the destination keeps waiting for
> > pages indefinitely and does not switch to the postcopy-paused state.
> > This can happen, for example, if the destination QEMU instance is
> > started with the '-S' command line option and the machine is not started
> > yet, or if the machine is idle and produces no new page faults for
> > not-yet-migrated pages.
> > 
> > This patch introduces new inet socket parameters that control count,
> > idle period, and interval of TCP keep-alive packets before the
> > connection is considered broken. These parameters are available on
> > systems where the respective TCP socket options are defined
> > (TCP_KEEPCNT, TCP_KEEPIDLE, TCP_KEEPINTVL).
> > 
> > The default value for all is 0, which means the system configuration is
> > used.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  meson.build         |  6 ++++
> >  qapi/sockets.json   | 15 ++++++++
> >  util/qemu-sockets.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 109 insertions(+)
> > 
> > diff --git a/meson.build b/meson.build
> > index 41f68d3806..680f47cf42 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2734,6 +2734,12 @@ if linux_io_uring.found()
> >    config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
> >                         cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
> >  endif
> > +config_host_data.set('HAVE_TCP_KEEPCNT',
> > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCN'T))
> > +config_host_data.set('HAVE_TCP_KEEPIDLE',
> > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE'))
> > +config_host_data.set('HAVE_TCP_KEEPINTVL',
> > +                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPINTVL'))
> 
> What platforms are you aware of that do NOT have these
> settings available ? I'm wondering if we can just assume
> they always exist.

macOS appears to have these, except that 'TCP_KEEPIDLE' is under a
differnt name 'TCP_KEEPALIVE':

  https://github.com/apple/darwin-xnu/blob/xnu-4570.1.46/bsd/man/man4/tcp.4#L172

Likewise I see them available in mingw for Wndows builds, with both
names

$ grep -r TCP_KEEP /usr/i686-w64-mingw32/sys-root/mingw/include/
/usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPALIVE 3
/usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPCNT 16
/usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPIDLE TCP_KEEPALIVE
/usr/i686-w64-mingw32/sys-root/mingw/include/ws2ipdef.h:#define TCP_KEEPINTVL 17

but your patch wouldn't enable it because it checks netinet/tcp.h

AFAICT, the only platform that matters to QEMU that seems to miss this
is OpenBSD 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


