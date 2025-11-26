Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F71CD11193
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 19:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOLB6-0004kj-Ft; Wed, 26 Nov 2025 14:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vOLAk-0004hy-Ob
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 14:27:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vOLAj-000489-7S
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 14:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764185244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfdHw6osTT0BaUP9o9b9He3D/uTLUvXEroWP8+YkA/4=;
 b=Q2U+vDmtBlJnIUKCCQ2z8cQt2sJofyDM/n3LWCHH78k2SKT+mtBUMfzhN0gd+0dox4Go8/
 FAZSRy606dpswIM/SpAi+DjvUhbqXlrqwcoTSDgAiLFql9bsr+e1JvTufrJ/x0j3FOpU2L
 pMxXdi21WWn2/zth9zRcOFBSH1YGlL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-kD_6EkmoM4Gr0JjMn-exQQ-1; Wed,
 26 Nov 2025 14:27:20 -0500
X-MC-Unique: kD_6EkmoM4Gr0JjMn-exQQ-1
X-Mimecast-MFC-AGG-ID: kD_6EkmoM4Gr0JjMn-exQQ_1764185239
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45F56195609E; Wed, 26 Nov 2025 19:27:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB2E3180035F; Wed, 26 Nov 2025 19:27:15 +0000 (UTC)
Date: Wed, 26 Nov 2025 20:27:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
Message-ID: <aSdUfZsqipQ4gacW@redhat.com>
References: <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org> <aRH_2gcYOH31UB38@redhat.com>
 <87ecq5f201.fsf@pond.sub.org>
 <CAJ307EjFMrXOmQMF5YckQ6hMGdFGtdYdAH3fWShcvwEXAtBrrw@mail.gmail.com>
 <87c7d0d6-8f8f-b6f2-3c81-0b0572dbad2c@eik.bme.hu>
 <CAJ307Eg74VNkYvewc5bnhafD+ccXzALmvS400Gz++8Mx5gcKkQ@mail.gmail.com>
 <CAJ307EjdoHZjSYCt7TKSLo=hqDS7y_azUBYsQszh3cAKG3jU-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ307EjdoHZjSYCt7TKSLo=hqDS7y_azUBYsQszh3cAKG3jU-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 26.11.2025 um 10:59 hat Clément Chigot geschrieben:
> On Fri, Nov 14, 2025 at 2:47 PM Clément Chigot <chigot@adacore.com> wrote:
> > On Fri, Nov 14, 2025 at 2:25 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > > On Fri, 14 Nov 2025, Clément Chigot wrote:
> > > > 1. "mbr" vs "partitioned".
> > > > I do think "partitioned" is clearer, a bit more casual friendly. "mbr"
> > > > requires knowledge about FAT format, while what's a partition should
> > > > be known by a wider audience.
> > > > Side note, in V3, I'll remove the "unpartitioned" keyword to simply
> > > > replace it by "partitoned=false" (I wasn't aware such an obvious
> > > > possibility was working...). So we might even call it
> > > > "partition/partitions=true|false".

As I said, either one works for me.

> > > > 2. The default value. Should it be "false" for @floppy ?
> > > > IMO, having a default value independent of other arguments is always
> > > > better. Hence, I'll push for keeping "partitioned=true" as the
> > > > default, and having users forcing "partitioned=false" for floppy (an
> > > > error being raised otherwise). As we'll probably change the default
> > > > behavior with floppy anyway (cf patch 2), I don't think it will hurt a
> > > > lot to make users passing a new flag.

I'm very much in favour of defaulting to partitioned for hard disks and
unpartitioned for floppies. This is not only the option that stays most
compatible with what we have in existing QEMU versions, but also the
most intuitive setting.

With the change to the default behaviour with floppy, we were forced to
pick between options that all meant changing the default, so I proposed
taking the most intuitive default there, too: I'm relatively sure that
when you mention floppy, most people will think of 1.44 MB first.

> > > 2. Having different defaults for floppy or disk would keep existing
> > > command lines working. Otherwise why not make partitioned=false the
> > > default and let users who need it set explicitly. That would also
> > > work for most cases without having to type out this option.

Slightly better than an unconditional partitioned=true default and
getting partitioned floppies, which is most definitely unexpected. But
it's still not usually the thing the user will want with hard disks, so
as I said above, I prefer the conditional default here.

Kevin


