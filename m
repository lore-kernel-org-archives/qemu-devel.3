Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE365E9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqq1-0006qg-CK; Tue, 24 Feb 2026 06:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vuqpt-0006pH-Un
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vuqpm-00089F-Uu
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771933447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tv3ytRddpuYVLd2blk+GXObgU0PUqMXtF+i/oYqMznI=;
 b=W8Z+idPAMVCYs/ur87VilJWIK8pY4jpWzTn9ysbshalGnbhUxTduURluPtOV/oqGAqDvTb
 rY/jdXa52xsISEq7yBoVTDi9I+KTzwx2Yd9qR/CtqBlozwAgWWnU6Sd8S00rQMs9Xd5wci
 SpNazAvME3GQQq2Spuq3sHA7i+DKz8w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-RjKZlvf2PY251lm9Z1Ry_w-1; Tue,
 24 Feb 2026 06:44:03 -0500
X-MC-Unique: RjKZlvf2PY251lm9Z1Ry_w-1
X-Mimecast-MFC-AGG-ID: RjKZlvf2PY251lm9Z1Ry_w_1771933443
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7FE11955F2A; Tue, 24 Feb 2026 11:44:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 156E31800673; Tue, 24 Feb 2026 11:44:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CD3621E692D; Tue, 24 Feb 2026 12:43:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to
 /machine/unattached if they have a bus
In-Reply-To: <aZ1zsoyKcD1ChK--@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 24 Feb 2026 09:47:30 +0000")
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
Date: Tue, 24 Feb 2026 12:43:59 +0100
Message-ID: <87ms0y2wow.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Feb 19, 2026 at 09:49:05AM +0100, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>> > From: Thomas Huth <thuth@redhat.com>
>> >
>> > We still have a lot of devices that end up in /machine/unattached in
>> > case the caller forgot to use object_property_add_child() to add it
>> > to a proper location in the QOM tree.
>>=20
>> This is QOM papering over sloppy modeling.  Predictably, it has enabled
>> us to remain sloppy slobs.
>>=20
>> I think the decision to paper over sloppiness to get QOM off the ground
>> quickly was defensible back then.  It's a lot less defensible now that
>> QOM has been off the ground for more than a decade.
>>=20
>> I believe people are by and large unaware of the need to add children.
>> This risks further accumulation of technical debt.
>
> IMHO, it is slightly more subtle - people believe they are already
> adding children.
>
> Consider this code.
>
>     port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
>
> my reading of that is that I'm creating a "port92" device that is a
> child of "isa_bus". Why would I need to tell QEMU that it is a child
> for a second time ?
>
> If I trace calls through isa_create_simple I get to a call to:
>
>    qdev_realize_and_unref(dev, parent, errp);

Actually

    qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp)

in isa_realize_and_unref().

> and once I again I'm left wondering why I would need to tell
> QEMU 'dev' is a child of 'parent' a second time.

Beware of confusion around "parent" here.

qdev_realize_and_unref() takes a qdev and optionally a qbus (a
DeviceState * and a BusState *).  qdev_realize() plugs the qdev into the
qbus with qdev_set_parent_bus() if the qbus is non-null.

The qdev concept "parent bus" is distinct from the QOM concept "parent
in the composition tree".  Evidence: the QOM parent of a qdev created
with -device is either "/machine/peripheral" or
"/machine/peripheral-anon".  Its parent qbus is something else.

"info qtree" shows the tree of qdevs and qbuses rooted at the main
system bus.

"info qom-tree <root>" shows the QOM composition tree rooted at <root>
(default "/machine").

> Of course I know the answer. We need to give a name for the
> child and it isn't trivial to "do the right thing" to invent
> an automatic name.

At least not in the general case.

> Still, overall I'm inclined to largely blame our API designs for
> not guiding people into doing the right thing.

Indeed!

> Picking another random unattached set of objects "smbus-eeprom"
> I again find they've being created with qdev_realize_and_unref.
>
> Pick another unattached device 'i8259_init_chip', and again
> we end up calling into qdev_realize_and_unref()
>
>
> It feels like qdev_realize_and_unref() is a common point of
> blame in unattached devices. IMHO it ought to be taking a
> "const char *name" parameter.

The problem are onboard devices without QOM composition tree parents.

Onboard devices need to be realized with qdev_realize().  Often called
via qdev_realize_and_unref().

Currently, we use that chokepoint to make devices without QOM parents
children of /machine/unattached.  That's bad.

Thomas's RFC PATCH changes this for devices that plug into a qbus: make
them children of the qbus (which is a QOM object) instead, with a
made-up name.  This may or may not be the parent we'd pick manually.

I'm curious: are there devices that plug into a qbus with a QOM parent
other than that qbus?

You propose to require callers to pass a name.

I think passing a name makes intent explicit: the qbus is the parent we
want.

> There are 104 calls to qdev_realize_and_unref(), but it is in
> the call path of many more wrapped calls.
>
> A big-ish job to convert them all, so perhaps we need to add
> a parallel
>
>    qdev_realize_and_unref_child(...)
>
> with the new 'name' parameter, and incrementally convert stuff,
> though ideally a conversion that doesn't last "forever" like
> so many of our conversion tasks.

There's just one way to get a feel for how big a job this is: try it.

>> To really put a stop to it, we'd have to mark the existing misuses, then
>> warn or crash on umarked misuse.
>
> While marking / warning / crashing helps surface problems, I think
> that fixing the API designs to guide developers at compile time is
> more important.

It's more helpful, so if we can pull it off...

>> None of the above is an objection to your patch.
>
> I guess even with the patch applied we can still identify broken
> code by looking for any child with an "x-" property name.

Yes.


