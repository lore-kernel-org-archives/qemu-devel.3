Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCD2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfBUX-0006s2-Pu; Thu, 02 Jul 2026 03:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfBUV-0006rb-O4
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 03:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfBUT-0001De-FU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 03:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782975937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KGoKWZjSP39lf55sBvvfsvr7sK43N3NfM6M31TYElg=;
 b=TWalJNR0bXbNdaORsg8o2w5O0wJuY8WLFYXVoDIGRFKkM6qxGaYE4DM4R8c4Gj/5ISKMu2
 Wa81KtLzqrvhSabjBGwp5uV4S3wNnTsmc0OhtxdmKYRyEiM5cF8IY2fcwjlGVR/3mYR4ZZ
 vgAk2e5/cKVa6z5VkaShQ0IecJRfWFM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-zIwRYsetPo2C17YE8GUuDw-1; Thu,
 02 Jul 2026 03:05:34 -0400
X-MC-Unique: zIwRYsetPo2C17YE8GUuDw-1
X-Mimecast-MFC-AGG-ID: zIwRYsetPo2C17YE8GUuDw_1782975932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C621955D79; Thu,  2 Jul 2026 07:05:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15423001449; Thu,  2 Jul 2026 07:05:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39CE421E6920; Thu, 02 Jul 2026 09:05:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Emmanuel Blot <eblot@meta.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Steven
 Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,  William de Abreu
 Pinho <williampinho@meta.com>,  qemu-arm@nongnu.org,  Corey Minyard
 <cminyard@mvista.com>
Subject: Re: [PATCH v3 3/5] hw/i2c: parent slaves created with
 i2c_slave_create_simple
In-Reply-To: <03dbf5a7-68c7-4cdd-895d-178088421f9b@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 1 Jul 2026 14:39:27 +0200")
References: <20260627-i2c-adc128d818-anacapa-v3-0-cfb94270a980@meta.com>
 <20260627-i2c-adc128d818-anacapa-v3-3-cfb94270a980@meta.com>
 <dc92984a-5c25-419e-b4ad-f5b79efbaeea@oss.qualcomm.com>
 <03dbf5a7-68c7-4cdd-895d-178088421f9b@kaod.org>
Date: Thu, 02 Jul 2026 09:05:26 +0200
Message-ID: <87fr213m89.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 7/1/26 08:29, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 28/6/26 02:45, Emmanuel Blot wrote:
>>> Slaves created with i2c_slave_create_simple() were left unparented and
>>> showed up under /machine/unattached with no stable QOM path. Add each
>>> slave as a QOM child of its bus, named after its I2C address, so it has
>>> a deterministic and addressable QOM path.
>>
>> +Markus
>>
>> Personally I never liked the idea of having buses being parents
>> of the devices attached to them,=20
>
> What was the problem ?
>
>> but maybe it is simpler this way.
>
> It is much simpler for functional tests when looking for board
> devices which don't have ids.

A QOM object must be the child of exactly one parent.  This defines the
QOM composition tree.  The link from parent to child is a property of
the parent, and therefore has a name that is unique within its parent.
An object's canonical QOM path is these names on the path from root to
object in the QOM composition tree separated by '/'.

For devices:

* If a device is plugged in with -device / device_add, and it has an ID,
  we make it a child of /machine/peripheral/ with name ID.  If it
  doesn't have an ID, we make it a child of /machine/peripheral-anon/
  with name device[N], where N counts up from zero.  The canonical QOM
  path /machine/peripheral/ID is stable.  The canonical QOM path
  /machine/peripheral-anon/device[N] isn't: it depends on the number of
  devices already there.

* If a device is part of another device, it should be its child.  The
  child's canonical QOM path is the parent's plus '/CHILD-NAME'.  Stable
  as long as the parent's path and the child name are.

* "Should" because we have a lot of code that fails to pick the parent.
  When such a device gets realized, we make it a child of
  /machine/unattached/ orphanage with name device[N], where N counts up
  from zero.  The canonical QOM path /machine/unattached/device[N]
  depends on the number of children already in the orphanage, which
  makes it unstable.

  Letting code get away with not picking a parent was a mistake.  I
  guess it "saved" us some thinking about what's part of what when
  converting existing devices to QOM.  In other words, it enabled sloppy
  hardware modeling.  We've been "saving" thinking ever since.

  I want /machine/unattached/ to be empty.  If an onboard device isn't
  part of another device, put it into /machine/ with a sensible name.

  Whether a device plugged into a bus is part of the device providing
  the bus is a hardware modeling question.

Now to the patch in question.  I understand it makes
i2c_slave_create_simple() pick a parent.  Many machines and devices use
that.  I examined its effect for machine anacapa-bmc with v5 of this
series using "info qom-tree".

The patch moves a bunch of devices from /machine/unattached to

    /machine/soc/i2c/bus[0]/aspeed.i2c.bus.0/0x70 (pca9546)
    /machine/soc/i2c/bus[0]/aspeed.i2c.bus.0/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[1]/aspeed.i2c.bus.1/0x70 (pca9546)
    /machine/soc/i2c/bus[1]/aspeed.i2c.bus.1/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[2]/aspeed.i2c.bus.2/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[3]/aspeed.i2c.bus.3/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[4]/aspeed.i2c.bus.4/0x70 (pca9548)
    /machine/soc/i2c/bus[4]/aspeed.i2c.bus.4/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[5]/aspeed.i2c.bus.5/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[6]/aspeed.i2c.bus.6/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[7]/aspeed.i2c.bus.7/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72 (pca9546)
    /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x22 (pca9552)
    /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x24 (pca9552)
    /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.1/0x22 (pca9552)
    /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.1/0x24 (pca9552)
    /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[9]/aspeed.i2c.bus.9/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[10]/aspeed.i2c.bus.10/0x71 (pca9548)
    /machine/soc/i2c/bus[10]/aspeed.i2c.bus.10/0x71/i2c.5/0x22 (pca9552)
    /machine/soc/i2c/bus[10]/aspeed.i2c.bus.10/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[11]/aspeed.i2c.bus.11/0x71 (pca9548)
    /machine/soc/i2c/bus[11]/aspeed.i2c.bus.11/0x71/i2c.5/0x22 (pca9552)
    /machine/soc/i2c/bus[11]/aspeed.i2c.bus.11/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[12]/aspeed.i2c.bus.12/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[13]/aspeed.i2c.bus.13/0x70 (pca9548)
    /machine/soc/i2c/bus[13]/aspeed.i2c.bus.13/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[14]/aspeed.i2c.bus.14/0xff (aspeed.i2c.slave)
    /machine/soc/i2c/bus[15]/aspeed.i2c.bus.15/0xff (aspeed.i2c.slave)

Is this a reasonable way to model the hardware?  I can't tell; I don't
know the hardware.  But it sure feels less unreasonable than the
/unattached/ crap!

[...]


