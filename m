Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B5CD4F50
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJSta-0006iY-EG; Thu, 13 Nov 2025 03:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJStY-0006hh-J5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vJStV-0006K9-Hl
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763023287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/xor/j1C75Ti7HgrzEfrHDsZIdtT47ryrd5xXnJIIM=;
 b=bIAchkPaWDeTHctln/4pXiO8/bPEdkYJNxd8J1N/U1yeU4jmzI78v7zcd9cA7Bs+amqnV1
 QxR1nWlYJHA2Lqt+xM8M1wJwcLeF8oyhJCB1r9+8jTMYEk5Rh4iUPoTZQ3wwjKndf3XC6Q
 fbNGLyqvFcNrgXkD5RCFPmFyL7AUc88=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-Fk4vs3L3Ot62neHai_WYKw-1; Thu,
 13 Nov 2025 03:41:25 -0500
X-MC-Unique: Fk4vs3L3Ot62neHai_WYKw-1
X-Mimecast-MFC-AGG-ID: Fk4vs3L3Ot62neHai_WYKw_1763023284
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A7EE18D95C7; Thu, 13 Nov 2025 08:41:24 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.162])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7808B180057A; Thu, 13 Nov 2025 08:41:22 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:41:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 0/5] block/vvfat: introduce "size" option
Message-ID: <aRWZr7tjdqKPlCjh@redhat.com>
References: <20250903075721.77623-1-chigot@adacore.com>
 <20251112123844.GA14264@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112123844.GA14264@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.11.2025 um 13:38 hat Richard W.M. Jones geschrieben:
> On Wed, Sep 03, 2025 at 09:57:16AM +0200, Clément Chigot wrote:
> > The main goal of this series is to introduce a new option "size" within
> > the vvfat backend (patch 5). It allows more control over SD cards' size.
> > The value for "Number of Heads" and "Sectors per track" are based on SD
> > specifications Part 2.
> > 
> > This series also includes minor patches:
> >  - patch 1 introduces another option to remove the Master Boot Record
> >    (this is mandatory for QNX)
> >  - patch 2-4 are minor improvements easing the introducing of "size"
> >    option
> > 
> > This was tested on with a aarch64-linux kernel taken from
> > functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> > workaround, not included here (the SD bus must be associated to the EMMC2
> > port instead of through GPIOs).
> > 
> > Clément Chigot (5):
> >   vvfat: introduce no-mbr option
> >   vvfat: move fat_type check prior to size setup
> >   vvfat: add a define for SECTOR_SIZE
> >   vvfat: move size parameters within driver structure
> >   vvfat: add support for "size" options
> > 
> >  block/vvfat.c | 279 ++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 213 insertions(+), 66 deletions(-)
> 
> (Thanks Markus for bringing this thread up)
> 
> I just wanted to say that a long time ago I wrote an nbdkit plugin
> that was intended as a more sane replacement for vfat.

What does it do differently from vvfat? For the read-only part, I
thought that vvfat wasn't too bad. Write support is where all the bugs
are hiding. But if you have good input, maybe vvfat could be improved.

> Since then several more nbdkit plugins have been added.  They support
> arbitrary sizes already.  The first one is the most direct replacement
> for vvfat (although it doesn't support writes to the backing
> directory, because that feature is insane).

The scenario we discussed here was explicitly read-write.

Kevin


