Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E000FD3764
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 15:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGXs-0005jH-NK; Wed, 25 Feb 2026 10:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvGXo-0005j2-IY
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvGXm-0001Yf-VA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772032278;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aNS7viuxZLyLSMYl7cQhDZMqcgZMhcQb1s5QPzXwrnU=;
 b=YDpM9s+It8lhCRvq2xg7VP3ljUDu87tB/SVWhbj5rMRuE25EVHzM+RVCN7UA3FRc5EReVg
 Viva7D8OoP259SmnKDepDjIMB8cdsdFR7PmwtKJCcklSrTjYVkLmHqOZZCNbztHwXsilKJ
 M9tzGPg3ZF5/+KMXPpjdM5jBkxoLXc4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ui0QQ09_OAqKlwPFTrA6sg-1; Wed,
 25 Feb 2026 10:11:13 -0500
X-MC-Unique: ui0QQ09_OAqKlwPFTrA6sg-1
X-Mimecast-MFC-AGG-ID: ui0QQ09_OAqKlwPFTrA6sg_1772032271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 533B31956063; Wed, 25 Feb 2026 15:11:11 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5067119560A2; Wed, 25 Feb 2026 15:11:07 +0000 (UTC)
Date: Wed, 25 Feb 2026 15:11:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 shannon.zhaosl@gmail.com, philmd@linaro.org, zhao1.liu@intel.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <aZ8RByaj4h6i2OXt@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo>
 <CAFEAcA-qaSRM9MJDk2nhDQKWoP7odcou2DXff-fuYPNEE=g6vg@mail.gmail.com>
 <20260219155538.6e0b5a4f@imammedo>
 <CAFEAcA_v4Y5NEiYZsTyQPt=orc8gxGJ_PWu55T_0mAt+iY4OQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_v4Y5NEiYZsTyQPt=orc8gxGJ_PWu55T_0mAt+iY4OQA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On Thu, Feb 19, 2026 at 04:04:37PM +0000, Peter Maydell wrote:
> On Thu, 19 Feb 2026 at 14:55, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Thu, 19 Feb 2026 13:00:13 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > > On Thu, 19 Feb 2026 at 12:17, Igor Mammedov <imammedo@redhat.com> wrote:
> > > >
> > > > On Wed, 18 Feb 2026 19:08:36 +0000
> > > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > > > Please can you also add support for exposing this device
> > > > > in the device tree ?
> > > >
> > > > It's possible,
> > > > but we probably should not enable it if acpi variant was requested,
> > > > to avoid confusion on guest side.
> > >
> > > Why? Almost every other device on this board we advertise
> > > via DTB for device tree guests and via ACPI for ACPI guests.
> 
> > If we expose both guest may try to load both drivers causing conflict or misbehavior.
> 
> Huh? A guest will do one of:
>  1 read the ACPI tables, and load the driver based on the ACPI data
>  2 read the DTB, and load the driver based on the DTB
> 
> Nothing tries to read both at once, or it would get totally
> confused.
> 
> > I can try and see what arm kernel would do in presence if both
> > but that's not the point.
> 
> We know already that this works fine, because almost every
> piece of hardware in the virt board is described in both
> the dtb and the ACPI tables.

The watchdog is different though as the ACPI WDAT table is not
describing the underlying piece of hardware. Instead it is
describing an interface for controlling watchdog functionality,
such that the guest does not have any awareness of what the
underlying physical impl is.

This feels like a pretty awful characteristic of the ACPI WDAT
design, as it forces guests to do hacks like the quirk added to
iTCO :-(

If such hacks aren't possible then it forces the even worse
behaviour of QEMU mgmt apps needing to decide between multiple
different watchdog configs depending on what they know about
guest OS support :-(

Bit of a no-win scenario.

> > One should consider plain GWDT whatchdog as a different device
> > when compared to WDAT one.
> > The later one is basically an synthetic watchdog with it's own driver.
> > From guest pov they are different devices (using the same registers/irqs).
> 
> But there is only one piece of hardware here, right?

QEMU knows that, but the guest OS does not. It cloud be one piece of
hardware in which case only 1 exposed device can be activated, or it
could be two distinct pieces of hardware both of which can be used
independently.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


