Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED03FD7F87
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuvj-0007kJ-5h; Fri, 27 Feb 2026 05:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvuvh-0007kB-Hj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:18:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvuvf-0001zh-Lq
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772187518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P77OTxmSw3RVq02mWscBMfZ0CfLsVv9FPYW4YnWmyoA=;
 b=A98au/FgzE5QQ5UpQguThAQrKc9jwCz7/PfenwrjQGpcGN7TO0MPyvhmXJXtqCResiReEi
 4doXOPhoQgjnWJ81UlVSid2yH33y3sPFQ6rMeVCTWu7K7K1Sfd0x2tocNY/KCrXkStfucw
 fGduktd1MF/BC7r3E2GRGWc5ST5b1BI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-7HEkyegCMNi4CWX-g49now-1; Fri,
 27 Feb 2026 05:18:34 -0500
X-MC-Unique: 7HEkyegCMNi4CWX-g49now-1
X-Mimecast-MFC-AGG-ID: 7HEkyegCMNi4CWX-g49now_1772187513
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26B83195609F; Fri, 27 Feb 2026 10:18:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.85])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE0871800348; Fri, 27 Feb 2026 10:18:28 +0000 (UTC)
Date: Fri, 27 Feb 2026 10:18:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 shannon.zhaosl@gmail.com, philmd@linaro.org, zhao1.liu@intel.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <aaFvcWnmE7dOiK-o@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <aaFdZY5ESpQCJigY@redhat.com> <20260227110125.1d46e695@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227110125.1d46e695@imammedo>
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

On Fri, Feb 27, 2026 at 11:01:25AM +0100, Igor Mammedov wrote:
> On Fri, 27 Feb 2026 09:01:25 +0000
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Fri, Feb 27, 2026 at 08:24:42AM +0100, Markus Armbruster wrote:
> > > Igor Mammedov <imammedo@redhat.com> writes:
> > >   
> > > > On Wed, 25 Feb 2026 15:19:56 +0000
> > > > Daniel P. Berrangé <berrange@redhat.com> wrote:  
> > > >> 
> > > >> Right, if there was a case where we were already using -device to
> > > >> create the watchdog, then I would suggest having a simple
> > > >> 'wadt=on|off' property as standard for any watchdog wanting that
> > > >> ACPI abstraction wrapper.
> > > >> 
> > > >> That could (hypothetically) be the case if we had chosen to add
> > > >> WADT suport backed by i6300esb, eg -device i6300esb,wadt=on|off
> > > >> 
> > > >> For cases built-in to the machine type, I'd suggest <type>-wadt=on|off
> > > >> 
> > > >> eg for Q35,  "-machine q35,itco-wadt=on|off"
> > > >> 
> > > >> for virt, '-machine virt,gwdt-wadt=on|off'  
> > > >
> > > > CCin Markus since it touches QAPI stuff.
> > > >
> > > > For respin, I've went ahead with a bit more generic approach
> > > > (as a user, I wouldn't really care what kind of built-in watchdog board ships,
> > > > and having 1 property instead total instead of machine specific ones makes it
> > > > easier for mgmt layer to deal with).
> > > >
> > > > here is current idea:
> > > >
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index 6411e68856..a0c6719b58 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -1257,6 +1271,14 @@ static void machine_class_init(ObjectClass *oc, const void *data)
> > > >          NULL, NULL);
> > > >      object_class_property_set_description(oc, "memory",
> > > >          "Memory size configuration");
> > > > +
> > > > +    object_class_property_add_enum(oc, "watchdog", "WatchdogType",
> > > > +        &WatchdogType_lookup,
> > > > +        machine_get_watchdog, machine_set_watchdog);
> > > > +     object_class_property_set_description(oc, "watchdog",
> > > > +        "Use: auto (watchdog is configured according board defaults),"
> > > > +        " off (disabled), native (built-in watchdog), wdat (ACPI based watchdog)]. "
> > > > +        " Default: auto");
> > > >  }  
> > > 
> > > Adds the property to abstract base type "machine", i.e. every machine
> > > has it.
> > > 
> > > Fundamentally assumes there is at most one onboard watchdog of interest.
> > > 
> > > I'm lacking context, please bear with me: who or what is going to set
> > > this property, and for what purpose?
> > >   
> > > > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > > > index 92e84dfb14..7f5e10340f 100644
> > > > --- a/qapi/machine-common.json
> > > > +++ b/qapi/machine-common.json
> > > > @@ -9,6 +9,23 @@
> > > >  # Common machine types
> > > >  # ********************
> > > >  ##
> > > > +##
> > > > +# @WatchdogType:
> > > > +#
> > > > +# On board watchdog configuration.
> > > > +#
> > > > +# @auto: Watchdog is configured according to board defaults.  
> > > 
> > > As far as I can tell, we don't document "boards" (machine types)
> > > anywhere, let alone "board defaults".  Not this patch's fault, of
> > > course.  The meaning of @auto remains unclear.
> > >   
> > > > +#
> > > > +# @off: Watchdog disabled (ARM).
> > > > +#
> > > > +# @native: Native watchdog (arm/virt: sbsa-gwdt, x86/q53: TCO)
> > > > +#
> > > > +# @wdat: ACPI WDAT watchdog.
> > > > +#
> > > > +# Since: 10.2  
> > > 
> > > 11.0
> > >   
> > > > +##
> > > > +{ 'enum': 'WatchdogType',
> > > > +  'data': [ 'auto', 'off', 'native', 'wdat' ] }  
> > > 
> > > What do managament applications need to know about onboard watchdog
> > > configuration?
> > > 
> > > Do they need to know what @auto means for the machine type at hand?
> > > 
> > > Do they ever need to pick a value?  Do they need to know which values
> > > work with the machine type then?  
> > 
> > Libvirt generally wants to work with & express the exact hardware
> > and not rely on "auto" settings in QEMU.
> > 
> > So in terms of the built-in watchdog for Q35 we currently express
> > this explicitly via
> > 
> >     <watchdog model='itco' />
> 
> not specifying above libvirt doesn't make itco go away on qemu side,
> it's still there regardless of above.

That is fine. Libvirt will synthesize a <watchdog> device to
represent & track the built-in default hardware, if the mgmt
app did not specify it explicitly.



> > Adding "WADT" is not expressing a new piece of hardware, just a
> > configuration choice of the iTCO hardware. So from that POV in
> > libvirt I anticipate expressing it as
> > 
> >     <watchdog model='itco' wadt='yes|no'/>
> >
> > IMHO, similar reasoning works at the QEMU level - WADT is not a
> > new type of watchdog hardware, just a config choice supported
> > with certain specific QEMU watchdogs. So I'd prefer something
> > closer to what I suggested in the mail that Igor replies to,
> > where we have a simple boolean flag to control use of WADT,
> > and other distinct properties if we need other controls on the
> > watchdog, instead of trying overload multiple distinct settings
> > into one enum.
> > 
> > For Arm we would similarly want to express the choice of
> > hardware directly as
> > 
> >    <watchdog model='gwdt'/>
> for gwdt it's more than just adding extra ACPI table,
> with wdat knob, watchdog entry in GTDT table should be disabled
> and gwdt itself should be wired to use different freq
> (in the end it's different hw that happens to use the same registers/
> protocol).

That doesn't really sound that different to me.  If enabling WADT
implies disabling GTDT that's ok, likewise if Peter wants DT to be
available in parallel that's ok too. We can cope with modelling
either approach in libvirt

> if we make it built-in, we would need in addition to virt.wadt alias
> also have virt.watchdog=[on|off] to manage creation. 



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


