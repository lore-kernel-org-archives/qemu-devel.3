Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE79FEB7ECF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 12:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxlI3-0000uy-6B; Wed, 04 Mar 2026 07:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxlI1-0000uc-Av
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxlHz-0002La-Ac
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 07:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772627117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMXpkjpiUoQui+4FslcpcM+k6VSmSqXFAp5s3o7dmXA=;
 b=dhKPgw+ytvfklzA2t50LISD+uw+mLO7X+xaFOAf6N3YrklopJXX/IvELWEs9irOYR/F448
 fHFG2h7zYdOy8na6ERV1jC3j7VB1oFgn8pI6gVAhrQ88y4tBPSqYYj1vrNNraJx8+HZisc
 1CdXDrjJROnefDtNoxy9y1ePllj9Dzs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-SJ5kYy4RPEaeWTG5zteZoQ-1; Wed,
 04 Mar 2026 07:25:12 -0500
X-MC-Unique: SJ5kYy4RPEaeWTG5zteZoQ-1
X-Mimecast-MFC-AGG-ID: SJ5kYy4RPEaeWTG5zteZoQ_1772627111
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F6F31956096; Wed,  4 Mar 2026 12:25:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22D8A180075B; Wed,  4 Mar 2026 12:25:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81DAC21E692F; Wed, 04 Mar 2026 13:25:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>,  =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Steven Lee <steven_lee@aspeedtech.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Troy Lee
 <leetroy@gmail.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  qemu-arm@nongnu.org,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,  Peter
 Maydell <peter.maydell@linaro.org>,  Joel Stanley <joel@jms.id.au>
Subject: QOM parent type "sys-bus-device" vs. "device" (was: [PATCH v2
 12/13] hw/char/serial: Inherit from SysBusDevice)
In-Reply-To: <20260303222143.142741-13-shentey@gmail.com> (Bernhard Beschow's
 message of "Tue, 3 Mar 2026 23:21:42 +0100")
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
Date: Wed, 04 Mar 2026 13:25:06 +0100
Message-ID: <87ikbbixy5.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Bernhard Beschow <shentey@gmail.com> writes:

> SerialState currently inherits just from DeviceState and serial devices
> use SerialState as an "IP block". Since DeviceState doesn't have an API
> to provide MMIO regions or IRQs, all serial devices access attributes
> internal to SerialState directly. Fix this by having SerialState inherit
> from SysBusDevice.
>
> In addition, DeviceState doesn't participate in the reset framework
> while SysBusDevice does. This allows for implementing reset
> functionality more idiomatically.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

We might be at a crossroads here.

Paul Brook designed qdev around "a device plugs into some bus, and may
provide buses".  To make this work, he added a main system bus to serve
as root of a single tree.

The parent of a device in that tree is the bus it plugs into, and the
parent of a bus is the device that provides it, except for the main
system bus, which has no parent.  "info qtree" shows this tree.

Note a machine had just this one system bus back then.

The system bus isn't something hardware people would call a bus.

The qtree is a qdev thing.  It is *not* the QOM composition tree ("info
qom-tree /").

We actually abandoned "a device plugs into some bus" a long time ago.
Moe on that below.

Qdev was later rebased onto QOM, as follows.

A bus QOM type is a subtype of "bus".

A device QOM type is a subtype of "device".

If a device type has a @bus_type, then it plugs into a bus of that QOM
type.  Such a concrete device is commonly[*] not a direct subtype of
"device".  Instead, it's a subtype of the abstract device that plugs
into that bus type.  Example: "isa-serial" is a direct subtype of
"isa-device", and it inherits its bus type "ISA" from there.

If a device has no @bus_type, it doesn't plug into any bus.  It doesn't
show up in "info qtree" (it does in "info qom-tree", of course).
Example: "serial" is a direct subtype of "device".

This lets us build devices from components without having to make up
buses to connect them.  Example: "isa-serial" has a direct QOM child of
type "serial".  Good!

Except infrastructure useful to such bus-less devices lives in sysbus,
where bus-less devices can't access it.  This tempts us to make devices
sysbus devices just to be able to use the infrastructure, and to create
additional sysbuses.

We can elect to go down this path further: make more sysbus devices.
Create more sysbuses.  If this is the right path, then bus-less devices
were a mistake, and we should consider eliminating them.

Or we can pick the other branch: put the infrastructure where bus-less
devices can use it.  If this is the right path, then sysbus is
obsolescent.

Or we can elect to muddle on without giving it much thought.  Always an
option :)


[...]


[*] Are there any exceptions?  I don't know.


