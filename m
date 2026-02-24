Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FFAE9B247
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vup1b-0006dk-9F; Tue, 24 Feb 2026 04:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vup1Y-0006cR-Vc
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vup1W-0001PU-3t
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771926484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AatdaBbCZ51TpX1j1LPggVOV5aWdn5Wqa1k1Z9G0LLs=;
 b=XRo8+9RWGjyBa/xiHGpRKw3BIJ4t8fc3mzarxoLlTkTUImTzVPbew2FoFm3D6p2eQnORRF
 aHkTCYupfr7Xril4Ro9orxRWTmTmIy9RtVyi3Q5/lfVy4fSYoCg7MOlyOXscgT7a9xhthI
 /4ku8i6A+s7vkPV14OxVJ35kqpRQxXU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-ZFPCS03jOS2X1lTzL82Ygg-1; Tue,
 24 Feb 2026 04:48:00 -0500
X-MC-Unique: ZFPCS03jOS2X1lTzL82Ygg-1
X-Mimecast-MFC-AGG-ID: ZFPCS03jOS2X1lTzL82Ygg_1771926479
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F3F1800613; Tue, 24 Feb 2026 09:47:59 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC6811954B11; Tue, 24 Feb 2026 09:47:34 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:47:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to
 /machine/unattached if they have a bus
Message-ID: <aZ1zsoyKcD1ChK--@redhat.com>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874ind5da6.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 09:49:05AM +0100, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > From: Thomas Huth <thuth@redhat.com>
> >
> > We still have a lot of devices that end up in /machine/unattached in
> > case the caller forgot to use object_property_add_child() to add it
> > to a proper location in the QOM tree.
> 
> This is QOM papering over sloppy modeling.  Predictably, it has enabled
> us to remain sloppy slobs.
> 
> I think the decision to paper over sloppiness to get QOM off the ground
> quickly was defensible back then.  It's a lot less defensible now that
> QOM has been off the ground for more than a decade.
> 
> I believe people are by and large unaware of the need to add children.
> This risks further accumulation of technical debt.

IMHO, it is slightly more subtle - people believe they are already
adding children.

Consider this code.

    port92 = isa_create_simple(isa_bus, TYPE_PORT92);

my reading of that is that I'm creating a "port92" device that is a
child of "isa_bus". Why would I need to tell QEMU that it is a child
for a second time ?

If I trace calls through isa_create_simple I get to a call to:

   qdev_realize_and_unref(dev, parent, errp);

and once I again I'm left wondering why I would need to tell
QEMU 'dev' is a child of 'parent' a second time.

Of course I know the answer. We need to give a name for the
child and it isn't trivial to "do the right thing" to invent
an automatic name.

Still, overall I'm inclined to largely blame our API designs for
not guiding people into doing the right thing.


Picking another random unattached set of objects "smbus-eeprom"
I again find they've being created with qdev_realize_and_unref.

Pick another unattached device 'i8259_init_chip', and again
we end up calling into qdev_realize_and_unref()


It feels like qdev_realize_and_unref() is a common point of
blame in unattached devices. IMHO it ought to be taking a
"const char *name" parameter.

There are 104 calls to qdev_realize_and_unref(), but it is in
the call path of many more wrapped calls.

A big-ish job to convert them all, so perhaps we need to add
a parallel

   qdev_realize_and_unref_child(...)

with the new 'name' parameter, and incrementally convert stuff,
though ideally a conversion that doesn't last "forever" like
so many of our conversion tasks.

> To really put a stop to it, we'd have to mark the existing misuses, then
> warn or crash on umarked misuse.

While marking / warning / crashing helps surface problems, I think
that fixing the API designs to guide developers at compile time is
more important.

> None of the above is an objection to your patch.

I guess even with the patch applied we can still identify broken
code by looking for any child with an "x-" property name.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


