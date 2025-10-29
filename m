Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2649FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8hH-0004YZ-GC; Wed, 29 Oct 2025 12:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE8gj-0004Rf-Tu
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 12:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE8gZ-0005La-DE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 12:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761753965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ACs8zAVT28fsXNdYag46SkGD7kgjAcjkUqyUE11gB2Q=;
 b=UZ/edaAwV0L/OJ1uM7LAX/ZVcJV1fsBKkgp3DiHDyX+nXuAd6p/yZ0hjrb1fbYgqb5MJXC
 Xt7UySdUj/77tsXYFRBnArdS9RiSDm1acJ1CGicyaFRwID+UuupEVBg49aMW87u46mzi4z
 ceAl7npMnM+rC2RfmE93PdmnK3r2vmU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-USktdEV8NIaVtaI_EnD6dw-1; Wed,
 29 Oct 2025 12:05:59 -0400
X-MC-Unique: USktdEV8NIaVtaI_EnD6dw-1
X-Mimecast-MFC-AGG-ID: USktdEV8NIaVtaI_EnD6dw_1761753957
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 782AA18F91AA; Wed, 29 Oct 2025 16:05:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 806911800353; Wed, 29 Oct 2025 16:05:35 +0000 (UTC)
Date: Wed, 29 Oct 2025 17:05:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>,
 qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 2/5] vvfat: move fat_type check prior to size setup
Message-ID: <aQI7TCjx395U0P4k@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-3-chigot@adacore.com>
 <aPp2eRW7gQfv4hT7@redhat.com>
 <CAJ307Eg_YngaeBukZjpr81iGJCm+ycwZHj_aPuxU_8tuSC9MPw@mail.gmail.com>
 <7f81bcff-9262-b092-42b4-f7e19b302f97@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f81bcff-9262-b092-42b4-f7e19b302f97@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 29.10.2025 um 14:58 hat BALATON Zoltan geschrieben:
> On Wed, 29 Oct 2025, Clément Chigot wrote:
> > On Thu, Oct 23, 2025 at 8:40 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > 
> > > Am 03.09.2025 um 09:57 hat Clément Chigot geschrieben:
> > > > This allows to handle the default FAT size in a single place and make the
> > > > following part taking care only about size parameters. It will be later
> > > > moved away in a specific function.
> > > > 
> > > > Setting a floppy disk of 1MB is no longer possible as it was a side
> > > > effect of passing "fat-type=12". To be precise there were three cases:
> > > >  - fat-type undefined (aka default): a fat12 2MB disk
> > > >  - fat-type=16: a fat16 2Mb disk
> > > >  - fat-type=12: a fat12 1Mb disk
> > > 
> > > That's quite a strange interface!
> > > 
> > > If we're touching it anyway, I would change it to make the more common
> > > format (1.44 MB) the default for FAT12 and make the 2.88 MB FAT12 floppy
> > > temporarily unavailable and later require an explicit size. This way
> > > both sizes would still be available using the fat-type.
> > 
> > I'm a bit hesitant to change the default behavior as people might be
> > using it without clear knowledge of it. True, "floppy" is probably not
> > a widely used feature but still.
> > Do QEMU have some specific guidelines when changing such default
> > behavior ? Adding a warning ? Or just a comment in the changelog would
> > be enough ?
> 
> https://www.qemu.org/docs/master/about/deprecated.html
> 
> Usually you'd add a warning and list it in the docs as deprecated then can
> make the change after it was deperecated for two releases.

We're not removing any functionality, just changing the default. So I
don't think the deprecation period applies.

In general, our stance is that we can change defaults whenever we want
to, and if you don't want to be surprised by changing defaults, you need
to specify the option explicitly. What's a bit strange about the vvfat
interface is that the default actually represents a configuration that
can't even be expressed explicitly at the moment.

So it is a special case in a way, but given that this is vvfat, which is
known to be unstable, not widely used outside of the occasional manual
use and not supported by libvirt, I'm willing to just make the change.

Kevin


