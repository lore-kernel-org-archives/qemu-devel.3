Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F0C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLWc-0003UD-5B; Thu, 16 Jul 2026 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkLWa-0003U4-Mi
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkLWY-0000Pz-JO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784206149;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwLeM5+03QtfPvVWw6KXZwP7xfh3PtR19ZXoXYMEX8I=;
 b=CvKQr7znau4ucJAk5l3LISikZ7d7Xgl/LdNYFMv/W6DJmlHdpuT5ftprOIeL790wqRy8k0
 +qaHiawwZCEOPPsaBGyu+6QGu7EkD+DasO7xc7M9GHha8XGrpV3+qSS1+zyrJqgHRbqNJV
 yIqEdsTnECc0R5BB/G7F2n1iZU1HGE8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-y6OdHZf_NqWFwUz87XhG4g-1; Thu,
 16 Jul 2026 08:49:08 -0400
X-MC-Unique: y6OdHZf_NqWFwUz87XhG4g-1
X-Mimecast-MFC-AGG-ID: y6OdHZf_NqWFwUz87XhG4g_1784206147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F9B5195608E; Thu, 16 Jul 2026 12:49:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9579E1956042; Thu, 16 Jul 2026 12:49:02 +0000 (UTC)
Date: Thu, 16 Jul 2026 13:48:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 06/17] monitor: refactor monitor_data_init() to pass ID
Message-ID: <aljTO75kKel2fVLx@redhat.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-7-zhangckid@gmail.com>
 <aj5_T__4oqt41IWv@redhat.com>
 <CAK3tnvLTwLdWm2ZHcLhHRsncHZVvEgW_B14Ua4ZS9EX6BE1Erw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3tnvLTwLdWm2ZHcLhHRsncHZVvEgW_B14Ua4ZS9EX6BE1Erw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 29, 2026 at 04:31:56PM +0800, Zhang Chen wrote:
> On Fri, Jun 26, 2026 at 9:32 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 03:08:40PM +0800, Zhang Chen wrote:
> > > Anonymous monitors (e.g., '-monitor stdio' or GDB stub) leave their 'id'
> > > field as NULL. To allow downstream subsystems (like iothread tracking) to
> > > identify these instances later, the initialization paths must propagate
> > > the context.
> > >
> > > Refactor monitor_data_init() to accept the 'id' parameters, and
> > > update all internal QMP/HMP paths to pass these identifiers.
> > >
> > > For anonymous monitors, 'mon->id' remains NULL at this stage to avoid
> > > namespace pollution, setting up infrastructure for subsequent patches.
> > >
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > ---
> > >  chardev/char.c             | 2 +-
> > >  gdbstub/system.c           | 3 ++-
> > >  include/monitor/monitor.h  | 5 +++--
> > >  monitor/hmp.c              | 5 +++--
> > >  monitor/monitor-internal.h | 4 +++-
> > >  monitor/monitor.c          | 9 ++++++---
> > >  monitor/qmp-cmds.c         | 2 +-
> > >  monitor/qmp.c              | 5 +++--
> > >  stubs/monitor-internal.c   | 3 ++-
> > >  9 files changed, 24 insertions(+), 14 deletions(-)
> >
> > This patch will significantly conflict with my series that
> > creates QOM objects for the monitors. They will all be
> > guaranteed to have an "id" at that point though, which
> > addresses the problem you're trying to solve IIUC.
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg06427.html
> >
> 
> Thank you for your updates.
> As Markus's help, we already know your series for create
> QOM for the monitors. So this series V7 based on the assumption of
> your patch merged. But for the comments:
> "Feels like this patch should not be merged as is."
> https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04214.html
> 
> I have to fix it by myself.
> I'm very happy this series based on your series, I can conveniently make
> the monitor as a regular QOM object like others in this series.
> If you think that OK, I will rebase my series on your QOM for monitor patches
> in next version.

FYI, my monitor hotplug series is merged, so you can simply
rebase your work onto current git HEAD.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


