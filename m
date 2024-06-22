Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49200C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKwLO-0001Tj-9m; Sat, 22 Jun 2024 04:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKwLM-0001TR-7e
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 04:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sKwLK-0007yF-4v
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 04:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719045807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4lTfiCcQyOrr28PSw6N5S9PH3x0Ac5guoym7NFzIKCA=;
 b=PJgKNVBh3zRlwi6ngudTYsZKAv2lfxZY0AcbE7fQ0TymhO2MgwNOoXh5HVQ/EcZad+vhxa
 zX00PgrKv3p5uOw/4OGmexmHCnbgnJpjE3EH2pToPhMrvIxDE+wvPHiiUQy4Qz9ZZl33qP
 K4PVPp1/cFLIpjGwjenejE6gNilnyKI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-EX-rp4EdPiq2Vgmg0nUZWA-1; Sat,
 22 Jun 2024 04:43:20 -0400
X-MC-Unique: EX-rp4EdPiq2Vgmg0nUZWA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6FB19560AE; Sat, 22 Jun 2024 08:43:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0322C19560AE; Sat, 22 Jun 2024 08:43:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6C3721E6757; Sat, 22 Jun 2024 10:43:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Patrick Leis <venture@google.com>
Cc: Corey Minyard <cminyard@mvista.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Titus Rwantare <titusr@google.com>,  QEMU
 Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: standardizing i2c device ids
In-Reply-To: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
 (Patrick Leis's message of "Thu, 20 Jun 2024 15:03:59 -0700")
References: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
Date: Sat, 22 Jun 2024 10:43:15 +0200
Message-ID: <87ed8pxt98.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Patrick Leis <venture@google.com> writes:

> Corey and Peter,
>
> My team builds lots of configurations for Qemu boards, and one pain point
> has been that the qom path for a device depends on the device insertion
> order, child[0], child[1] and the like.

Yes.

Discussed in my "Dynamic & heterogeneous machines, initial
configuration: problems" memo, under "Problem 4: The
/machine/unattached/ orphanage".

Copy of the "Problem 4" part appended for your your convenience.  Full
memo archived at
https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

>                                          I noticed that the qdev paths for
> devices also exist by their device id property.  By default, this ends up
> being the device type name.

Which kind of devices?

There are onboard devices and user-created devices.

A user-created device's QOM path is "/machine/peripheral/ID" when it was
created with a qdev ID, and "/machine/peripheral-anon/device[N]" (where
N counts up from zero) when it was created without a qdev ID.  N depends
on creation order, which is under the user's control.  Users can and
should avoid relying on their order by supplying an ID.

An onboard device's QOM path is chosen by board code.  For instance, q35
puts the mch device at "/machine/q35/mch".  However, if the board code
neglects to put the device anywhere, the system puts it at
"/machine/unattached/device[N]" (where N counts up from zero).  N
depends on creation order.

N can change at the drop of a hat.  Whether "device[N]" is a stable
interface is unclear.  It would clearly be a bad one.

If (part of) your problem is "/machine/peripheral-anon/device[N]",
supply IDs to bypass it.

If (part of) your problem is "/machine/unattached/device[N]", all I can
offer is the proper solution: fix the board code to put the device in
its proper place instead of abandoning it to the "/machine/unattached/"
orphanage.

>                              I was wondering if it made sense to override
> this with the device type plus the smbus address?  I did something similar
> with the i2c mux device, to resolve part of this issue.

I doubt it.

Questions?



= Problem 4: The /machine/unattached/ orphanage =

Is it okay for a QOM object to have no parent?

An object without a parent is not part of the composition tree; it has
no canonical path, and object_get_canonical_path() returns null.

Such objects can behave in wonky ways.  For instance,
object_property_set_link() treats a target object without a parent as
null.  If a linked object somehow loses its parent,
object_property_get_link() will return null even though the underlying C
pointer still points to the poor orphan.

This strongly suggests QOM was designed with the assumption that objects
always have a parent, except during initialization (before they are
connected to anything) and finalization (when no longer connected to
anything).  object_property_try_add_child()'s contract seems to confirm
this:

 * Child properties form the composition tree.  All objects need to be a child
 * of another object.  Objects can only be a child of one object.

Some functions to create objects take the new object's parent as a
parameter.  Example: object_new_with_props(), object_new_with_propv(),
clock_new(), ...

Others set a fixed parent.  For instance, we always add character
backends to "/chardevs/", objects created with object-add in
"/objects/", devices created with device_add in "/machine/peripheral/"
(with ID) or "/machine/peripheral-anon/" (without ID), ...

There are also functions that don't set a parent: object_new(),
object_new_with_class(), qdev_new(), qdev_try_new(), ...  Setting a
parent is the callers job then.  Invites misuse.  I'm aware of one
instance: @current_migration remains without a parent forever.

Not all callers care to set a parent themselves.  Instead, they rely on
the "/machine/unattached/" orphanage:

* qdev_connect_gpio_out_named() needs the input pin to have a parent.
  If it lacks one, it gets added to "/machine/unattached/" with a
  made-up name.

* device_set_realized() ensures realized devices have a parent by adding
  devices lacking one to "/machine/unattached/" with a made-up name.

* portio_list_add() adds a memory region.  If the caller doesn't specify
  the parent, "/machine/unattached/" is assumed.

* memory_region_init() adds a memory region, and may set the parent.  If
  the caller requests setting a parent without specifying one,
  "/machine/unattached/" is assumed.

* qemu_create_machine() adds the main system bus to
  "/machine/unattached/".

Except for the last one, the child names depend on execution order.  For
instance, device_set_realized() uses "device[N]", where N counts up from
zero.

These brittle, made-up names are visible in QMP QOM introspection.
Whether that's a stable interface is unclear.  Better not.

We don't rely on these names in C.  We follow pointers instead.

When we replace C code by configuration, we switch from pointers to
names.  Brittle names become a problem.


