Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770D9FD5313
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 09:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvtjR-0003vj-Oc; Fri, 27 Feb 2026 04:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvtjB-0003uV-Ve
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:01:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvtj9-00035B-Tk
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772182898;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/b5Ub97pJHWKXfPvQnL1/4xwuJeoPl9XL8Gin9aVA+g=;
 b=Z7zXUwQ/2x1T0FLYAnNfzxmWX9Jdpwld6OWIvAVCmnxsvnibnNkNJK3HF128HML+z8zLnu
 RgdRWx7dNaVcEiNhNLqefQ/UQw9OFGrUNobMF5EcrJ0mJiSb8SySG/ujaNYbY73tu3xVA7
 dAMsP+OqctOzr0CvfDBy+8hesazwyO0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-XweQjusNNGKs7WKwAb1ZgQ-1; Fri,
 27 Feb 2026 04:01:35 -0500
X-MC-Unique: XweQjusNNGKs7WKwAb1ZgQ-1
X-Mimecast-MFC-AGG-ID: XweQjusNNGKs7WKwAb1ZgQ_1772182894
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C46A8195605A; Fri, 27 Feb 2026 09:01:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.85])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01A131800671; Fri, 27 Feb 2026 09:01:28 +0000 (UTC)
Date: Fri, 27 Feb 2026 09:01:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 shannon.zhaosl@gmail.com, philmd@linaro.org, zhao1.liu@intel.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <aaFdZY5ESpQCJigY@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qced4xx.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 27, 2026 at 08:24:42AM +0100, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Wed, 25 Feb 2026 15:19:56 +0000
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> 
> >> Right, if there was a case where we were already using -device to
> >> create the watchdog, then I would suggest having a simple
> >> 'wadt=on|off' property as standard for any watchdog wanting that
> >> ACPI abstraction wrapper.
> >> 
> >> That could (hypothetically) be the case if we had chosen to add
> >> WADT suport backed by i6300esb, eg -device i6300esb,wadt=on|off
> >> 
> >> For cases built-in to the machine type, I'd suggest <type>-wadt=on|off
> >> 
> >> eg for Q35,  "-machine q35,itco-wadt=on|off"
> >> 
> >> for virt, '-machine virt,gwdt-wadt=on|off'
> >
> > CCin Markus since it touches QAPI stuff.
> >
> > For respin, I've went ahead with a bit more generic approach
> > (as a user, I wouldn't really care what kind of built-in watchdog board ships,
> > and having 1 property instead total instead of machine specific ones makes it
> > easier for mgmt layer to deal with).
> >
> > here is current idea:
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6411e68856..a0c6719b58 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1257,6 +1271,14 @@ static void machine_class_init(ObjectClass *oc, const void *data)
> >          NULL, NULL);
> >      object_class_property_set_description(oc, "memory",
> >          "Memory size configuration");
> > +
> > +    object_class_property_add_enum(oc, "watchdog", "WatchdogType",
> > +        &WatchdogType_lookup,
> > +        machine_get_watchdog, machine_set_watchdog);
> > +     object_class_property_set_description(oc, "watchdog",
> > +        "Use: auto (watchdog is configured according board defaults),"
> > +        " off (disabled), native (built-in watchdog), wdat (ACPI based watchdog)]. "
> > +        " Default: auto");
> >  }
> 
> Adds the property to abstract base type "machine", i.e. every machine
> has it.
> 
> Fundamentally assumes there is at most one onboard watchdog of interest.
> 
> I'm lacking context, please bear with me: who or what is going to set
> this property, and for what purpose?
> 
> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > index 92e84dfb14..7f5e10340f 100644
> > --- a/qapi/machine-common.json
> > +++ b/qapi/machine-common.json
> > @@ -9,6 +9,23 @@
> >  # Common machine types
> >  # ********************
> >  ##
> > +##
> > +# @WatchdogType:
> > +#
> > +# On board watchdog configuration.
> > +#
> > +# @auto: Watchdog is configured according to board defaults.
> 
> As far as I can tell, we don't document "boards" (machine types)
> anywhere, let alone "board defaults".  Not this patch's fault, of
> course.  The meaning of @auto remains unclear.
> 
> > +#
> > +# @off: Watchdog disabled (ARM).
> > +#
> > +# @native: Native watchdog (arm/virt: sbsa-gwdt, x86/q53: TCO)
> > +#
> > +# @wdat: ACPI WDAT watchdog.
> > +#
> > +# Since: 10.2
> 
> 11.0
> 
> > +##
> > +{ 'enum': 'WatchdogType',
> > +  'data': [ 'auto', 'off', 'native', 'wdat' ] }
> 
> What do managament applications need to know about onboard watchdog
> configuration?
> 
> Do they need to know what @auto means for the machine type at hand?
> 
> Do they ever need to pick a value?  Do they need to know which values
> work with the machine type then?

Libvirt generally wants to work with & express the exact hardware
and not rely on "auto" settings in QEMU.

So in terms of the built-in watchdog for Q35 we currently express
this explicitly via

    <watchdog model='itco' />

Adding "WADT" is not expressing a new piece of hardware, just a
configuration choice of the iTCO hardware. So from that POV in
libvirt I anticipate expressing it as

    <watchdog model='itco' wadt='yes|no'/>

IMHO, similar reasoning works at the QEMU level - WADT is not a
new type of watchdog hardware, just a config choice supported
with certain specific QEMU watchdogs. So I'd prefer something
closer to what I suggested in the mail that Igor replies to,
where we have a simple boolean flag to control use of WADT,
and other distinct properties if we need other controls on the
watchdog, instead of trying overload multiple distinct settings
into one enum.

For Arm we would similarly want to express the choice of
hardware directly as

   <watchdog model='gwdt'/>

regardless of whether the GWDT ends up being something we have to
add manually with -device, or something built-in to the machine.

> >> Q35 is easier as we rely on the guest quirks to disable direct
> >> access via both paths.
> >> 
> >> With GWDT we need to decide if gwdt-wadt=on should imply DTB
> >> disabled, or if we just expose both & rely on a guest quirk
> >> or worst case, need a separate property to toggle DTB too.
> >> 
> >> > I've used device property for x86 Q35 TCO watchdog and
> >> > then using -global to enable it as workaround in previous version.
> >> > Ugly but doable workaround. It puts a burden on users to learn how
> >> > to configure it for each support watchdog/board combo.
> >> > It's nightmare to discover/maintain though.
> 
> Our unsolved "how to configure onboard devices" problem bites again.
> 
> -global can be pressed into service when there's just once instance of
> the device type.  The drawbacks you describe are real.  I want to see
> less of it, not more.

IIRC, the only place we use -global with watchdogs today is to
set "-global ICH9-LPC.noreboot=off" which was merely to workaround
a historical QEMU bug which exposed a guest watchdog and then
inexplicably made it not work by having it ignore the guest
trigger event. Newer machine types fixed that broken default, but
libvirt keeps setting things explicitly since that's easier than
making machine version specific choices.

I'm not sure we need -global to support the WADT features, as that
seems like it can just a -machine property instead.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


