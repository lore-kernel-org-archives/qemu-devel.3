Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzE9J-0003NG-Kr; Wed, 26 Aug 2026 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzE9H-0003M9-HX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzE9E-0008OJ-FW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787752715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGSMqPirovRWgdQ0oFfKUiuJ+At6CWwjiH05iSoC2wU=;
 b=Bn1TkASI3+XfYspxQGqoaa+kLcm2o4VJwV8qjhYtbq18j1uCNMWgy2YD0JX+pgg9ev9ko7
 ozRZzt2U9acMyJeDja89ib8BH5hs8vc2AmDfqTl7sWMeqWA8TFGhTXK1QmxW7LVHs7h//4
 dsKF/p3CdYkRwFY/oia04y0/UJF7smI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-xpfV9gnrOqWuIUIfOY08Pg-1; Wed,
 26 Aug 2026 09:58:32 -0400
X-MC-Unique: xpfV9gnrOqWuIUIfOY08Pg-1
X-Mimecast-MFC-AGG-ID: xpfV9gnrOqWuIUIfOY08Pg_1787752705
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA81193530A; Wed, 26 Aug 2026 13:58:23 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD7A81955F43; Wed, 26 Aug 2026 13:58:11 +0000 (UTC)
Date: Wed, 26 Aug 2026 14:58:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
Message-ID: <ao7w8AC9SSlc9108@redhat.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <392d0652-2d06-4889-8b67-c199e59bd314@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <392d0652-2d06-4889-8b67-c199e59bd314@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 26, 2026 at 02:40:46PM +0100, Mark Cave-Ayland wrote:
> On 26/08/2026 13:32, Daniel P. Berrangé wrote:
> 
> > On Sun, Aug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:
> > 
> > snip,
> > 
> > ..to comment just on the end result for now..
> > 
> > Specifically
> > 
> >   * -nodefaults should become the default
> >   * All CLI args should be processed in order from
> >     the command line, so we eliminate the nonsense
> >     where we process some -object, then -chardev,
> >     then more -object through hand crafted deps
> > 
> >   * No default machine type
> 
> I would even go as far as to suggest that we should make modules mandatory
> for qemu-system, so that devices can be loaded upon demand during machine
> construction to help keep the size down.

I think it is worth considering whether modules could be mandatory
unconditionally for everything. We don't need to block on this
decision though.

> I'll leave whether that is through dependency tracking or via an explicit
> load directive for someone else to decide :)
> >   * Drop all legacy syntax so we only have a single
> >     QAPI based way of configuring.
> >     eg drop -hda, -hdb, -cdrom, -drive, etc
> >        only keeping -blockdev
> >     eg drop -mon, -monitor, -qmp, etc only
> >        keeping -object
> 
> The only problem with this is that I often get a lot of complaints that QEMU
> command lines are complicated from retro folks who just want to run their
> favourite old games. Why would they want to come up with a long-winded
> -drive command line when they can just use -hda instead?

-blockdev isn't as hard as it appears - we make it harder than it ought
to be by not documenting it well and carrying on using -hda/-drive in
examples so users have little good guidance. Then when people go beyond
the needs that -hda can service, they have an worse experiance as a
result.

Having many different ways to do the same thing and not getting rid of
enough outdated/obsoleted stuff is what has always created confusion
for QEMU.

Also why it is -hda when it is created a SCSI disk (sda), or a VirtIO
disk (xda) or a SSD (mmcblk0), or the guest is calling it C:\ :-)

Yes, -hda is simple, but it is also nonsensical historical cruft.


All the various "convenience" args are also something that could be
provided by a higher level launcher script that translates to the
canonical syntax, even if they're not in qemu-system itself.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


