Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BBEF3093B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6S4-0004pq-QQ; Thu, 05 Mar 2026 06:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy6Rt-0004oP-50
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy6Rp-0006ov-0J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772708451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exsvnWhrosw4L5DNyjABIiyzOYZiVGdS6s+3Kw8NrEc=;
 b=eYrIp24UdO1R6B+Dk7cJNUJeh2Qrjaig36I0gY1oxV5Upf3BMtyS2O6qS5bCj/zO2S5HqA
 On3Ph1wbBImNy27hTKlDGW1kBxZ8mqVgU2oro+NFtHpaWoZd92XDvf/L6ihzE8f5S+WvGa
 aPCxdAMUV1INRU82VLzwvNoRVpB1l5Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-iginTUkEMcGMvdrwC30X6A-1; Thu,
 05 Mar 2026 06:00:47 -0500
X-MC-Unique: iginTUkEMcGMvdrwC30X6A-1
X-Mimecast-MFC-AGG-ID: iginTUkEMcGMvdrwC30X6A_1772708444
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDCE91800619; Thu,  5 Mar 2026 11:00:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 248771956095; Thu,  5 Mar 2026 11:00:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 849AA21E6A04; Thu, 05 Mar 2026 12:00:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>,  qemu-devel@nongnu.org,  Helge
 Deller <deller@gmx.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, Troy Lee <leetroy@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  qemu-arm@nongnu.org,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,  Joel
 Stanley <joel@jms.id.au>
Subject: Re: QOM parent type "sys-bus-device" vs. "device"
In-Reply-To: <CAFEAcA8CTLsKxJ8iza9T3bSafdgaM0dag2=KXqWLdMiXAHiGGQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 5 Mar 2026 09:30:49 +0000")
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
 <87ikbbixy5.fsf_-_@pond.sub.org>
 <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
 <87fr6eocfc.fsf@pond.sub.org>
 <CAFEAcA8CTLsKxJ8iza9T3bSafdgaM0dag2=KXqWLdMiXAHiGGQ@mail.gmail.com>
Date: Thu, 05 Mar 2026 12:00:40 +0100
Message-ID: <874imuo813.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 5 Mar 2026 at 09:25, Markus Armbruster <armbru@redhat.com> wrote:
>> > Disentangling reset is extremely painful -- I don't even know
>> > what it ought to be doing. Maybe propagating along the QOM tree?
>>
>> I think this would make more sense.  Unlike the qtree, the QOM
>> composition tree contains all devices, and reflects the actual
>> composition.  It's certainly closer to the real reset tree than the
>> qtree is.  Is it close enough?  I don't know.  If yes, there's our reset
>> tree.  If no, I guess we could still use it as a base, with manually
>> corrected reset lines where the QOM composition tree is off.

A walk to the farmers market jogged my memory: the QOM composition tree
is in fact off for user-created devices.  These go into
/machine/peripheral and /machine/peripheral-anon.

Most of them plug into a bus, and reset should flow through that bus,
not through their peripheral container.

A few don't, and I can't say how reset is supposed to work then.

Onboard device can also be connected via some bus.  For instance,
machine "pc" contains sysbus device "i440FX-pcihost", which provides a
PCI bus.  It also contains PCI device "PIIX3" (the south bridge)
connected via that PCI bus.

The QOM composition tree has "i440FX-pcihost" and its PCI bus in the
right place, and "PIIX3" in the orphanage:

    /machine (pc-i440fx-11.0-machine)
      /i440fx (i440FX-pcihost)
        /pci.0 (PCI)
      /unattached (container)
        /device[3] (PIIX3)
        /sysbus (System)

Say we fixed that like so

    /machine (pc-i440fx-11.0-machine)
      /i440fx (i440FX-pcihost)
        /pci.0 (PCI)
        /piix3 (PIIX3)

then reset flowing along the composition tree is still problematic: we
probably want to reset the PCI bus before the devices plugged into it.

So maybe reset should flow along the composition tree to buses, from bus
to devices plugged into it, from such a device again along the
composition tree, and so forth.

> Yes. We really don't want to add more boilerplate requirements
> to how you write "container" type devices like SoC objects.
> It's already bad enough that you have to have an instance_init
> that manually calls instance_init on all your subcomponents,
> and a realize that calls realize on all of them. If we add
> a requirement that you need to have reset methods for 3 phases
> that call reset on all your subcomponents, people are going to
> forget. We need the default to be "do the thing that's right
> almost every time", not "do the thing that's wrong".

Good interfaces make doing the right thing easier than doing the wrong
thing.  We clearly failed there.

> (And then of course there is the "how do we get there from
> here?" question :-))

Good question.  Next question?  SCNR!

I'm afraid I don't understand how reset works *now* well enough to come
up with a workable plan.

In other words, I don't have a clear idea of "here", and I fear we
together don't have a sufficiently clear idea of "there".

What can we do to improve on both?


