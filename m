Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2837C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZ83-0005Iz-UJ; Thu, 27 Aug 2026 08:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzZ81-0005IY-NX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzZ7z-0003K5-3v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787833361;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnKJMYJ3ecPLEA6Ef3k3bZH+Ub3y2rQTLbc+p5thlQ4=;
 b=SzbPrhgcndD5oCpF5sqLdUD3MTe7QUaI3gH3/MMlcuA6xBZTC8iVsFRCGmwqBXHS4b4q+u
 5GhyFGSsc5z79yC82sbZvDi/WifhTxJFjE8M0EStLR622/3FACH4gu8W/p+ULCQoBRoBpw
 MPT9ba5ZfN8rPqQVxXTaxYEoWyWmwWM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-w_PHatOTMTOZlf9LMEfYTg-1; Thu,
 27 Aug 2026 08:22:36 -0400
X-MC-Unique: w_PHatOTMTOZlf9LMEfYTg-1
X-Mimecast-MFC-AGG-ID: w_PHatOTMTOZlf9LMEfYTg_1787833354
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECAB319344EC; Thu, 27 Aug 2026 12:22:33 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCD441955F05; Thu, 27 Aug 2026 12:22:30 +0000 (UTC)
Date: Thu, 27 Aug 2026 13:22:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
Message-ID: <apAsA2gg58ctdtwL@redhat.com>
References: <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
 <anyCswBYBZWeMt3I@redhat.com>
 <e40e5a75-cb20-4608-b628-f363068a36ba@oss.qualcomm.com>
 <b0930315-f3b6-4fcd-82ca-11028856c343@oss.qualcomm.com>
 <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 26, 2026 at 04:07:22PM -0700, Richard Henderson wrote:
> On 8/21/26 16:53, Pierrick Bouvier wrote:
> > > > > > > > > Based on this, I'm much more in favor or 1. The fact availability
> > > > > > > > > information is in the same location than type definition is the biggest
> > > > > > > > > advantage for me.
> > > > > > > > > 
> > > > > > > > > On example given above, this would give something like this:
> > > > > > > > > static const TypeInfo emulated_card_info = {
> > > > > > > > >       .name          = TYPE_EMULATED_CCID,
> > > > > > > > >       .parent        = TYPE_CCID_CARD,
> > > > > > > > >       .instance_size = sizeof(EmulatedState),
> > > > > > > > >       .class_init    = emulated_class_initfn,
> > > > > > > > >       .is_available  = target_config_X,
> > > > > > > > > };
> > > > > > > > > 
> > > > > > > > > Would that work for you?
> > > > > > > > > Do you have a 3rd way to offer to solve the problem we have?
> > > > > > > > In the case of user creatable objects, we represented a classes'
> > > > > > > > conditional availablity in QAPI schema. For example:
> > > > > > > > 
> > > > > > > >    { 'struct': 'InputLinuxProperties',
> > > > > > > >      'data': { 'evdev': 'str',
> > > > > > > >                '*grab_all': 'bool',
> > > > > > > >                '*repeat': 'bool',
> > > > > > > >                '*grab-toggle': 'GrabToggleKeys' },
> > > > > > > >      'if': 'CONFIG_LINUX' }
> > > > > > > > 
> > > > > > > > Now this isn't quite a match for what we want, as QAPI schema is
> > > > > > > > common to all targets and used to control the code generator to
> > > > > > > > turn off output. Thus the permitted CONFIG_xxx are only those in
> > > > > > > > config-host.mak, not any from $TARGET-softmmu-config-devices.mak
> > > > > > > > 
> > > > > > > > The other scenario in QAPI is the concept of features:
> > > > > > > > 
> > > > > > > > { 'struct': 'SevCommonProperties',
> > > > > > > >    'data': { '*sev-device': 'str',
> > > > > > > >              '*cbitpos': 'uint32',
> > > > > > > >              'reduced-phys-bits': 'uint32',
> > > > > > > >              '*kernel-hashes': 'bool' },
> > > > > > > >    'features': ['confidential-guest-reset']}
> > > > > > > > 
> > > > > > > > where again we just have a list of named strings. Features are fully
> > > > > > > > dynamic, and crucially they are introspectable so applications can
> > > > > > > > query at runtime what is available.
> > > > > > > > 
> > > > > > > > The introspection concept is something that is highly likely to be
> > > > > > > > relevant to our use cases here. If we have a single binary with all
> > > > > > > > types, it would be very valuable to be able to query it once to
> > > > > > > > discover everything in one go, instead of havnig to query it over
> > > > > > > > and over again for each target. That implies the application doing
> > > > > > > > the query needs to be told about per-target usage restrictions on
> > > > > > > > types it is querying.
> 
> Having read through Pierrick's v2, I'm not a fan of inventing a new
> enumeration, creating a switch, calling exactly the functions we could have
> registered directly.
> 
> I think the misunderstanding here, Dan, is that the filter is for the
> non-heterogeneous '-target foo' case.  In the target-foo case, the
> introspection is not highly likely, because we don't have it now.  The only
> point is to have, at the end of registration, exactly the same set of
> classes as we have now.

That's not what this code gives us though.  At the end of registration
we have the union of all classes from all targets - qom-list-type lists
everything. Instead when querying classes, the consumers have to apply
filtering which IMHO is too late.

My suggestion was to take an approach that filters at the time of
registration, so we never register classes that are irrelevant for
the target and thus don't need filtering by consumers.

Having looked at Yonggang's add-on series though that actually
introduces 'qemu-system', I think we should not do filtering at
all, neither at registration or by consumers.

The filtering is only needed if we want 'qemu-system -target aarch64'
to be a perfect match for 'qemu-system-aarch64'. I think that is a
mistaken goal, and is creating uneccessary work.

Instead declare that 'qemu-system' always reports everything that
was built into it and avoid having to create this filtering logic
entirely.

> The introspection case is perhaps probable in the heterogeneous case, where
> the filtering will not apply.  In the heterogeneous case we just register
> *everything* and let the magic runtime defined machine pick and choose. 
> Thus incorporating the filter into the introspection is pointless.  That
> said, I *suspect* there will be very little in the way of introspection at
> all -- I suspect that users will simply create their machine description,
> attempt to instantiate, and error out if there are missing classes.

Introspection remains important, but I do now agree that filtering is
pointless - both for introspection and more generally.

  "qemu-system --machine help"

should list *everything* for all targets that are built in to it
without filtering too.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


