Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F96CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rH0-00027s-Mm; Thu, 09 Oct 2025 10:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6rGs-000202-KM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6rGc-0007k7-WE
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760018709;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKL/za2JCNGYH5cIY//kQbtqZ/K37f5NJTv9iiZ3p+s=;
 b=TQGm5bZ/NicbsEIRBfTsNO56lOuK5vWNez5h9+OKMn85zowFf4Tm8p+Yhtrfa/Gxw7pGWi
 A8uBLrATGGW5cCxPhv1ygyijR2rFqcg0wwqMwlNVo0OHYFhhw7TcknoNC3oGUwZsx61JsF
 1Cp2zoCky0KGnOCBdz8JsYkD48UOfZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-azyx2RxiNOis8K22MOsyqQ-1; Thu,
 09 Oct 2025 10:05:05 -0400
X-MC-Unique: azyx2RxiNOis8K22MOsyqQ-1
X-Mimecast-MFC-AGG-ID: azyx2RxiNOis8K22MOsyqQ_1760018701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BECB31800359; Thu,  9 Oct 2025 14:03:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B317F1800447; Thu,  9 Oct 2025 14:03:19 +0000 (UTC)
Date: Thu, 9 Oct 2025 15:03:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, salil.mehta@opnsrc.net,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, gustavo.romero@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, gankulkarni@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com,
 devel@lists.libvirt.org
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
Message-ID: <aOfAokkxo_-AfBPM@redhat.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org> <20251009145125.6583a24a@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009145125.6583a24a@fedora>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 09, 2025 at 02:51:25PM +0200, Igor Mammedov via Devel wrote:
> On Thu, 09 Oct 2025 10:55:40 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
> > salil.mehta@opnsrc.net writes:
> > 
> > > From: Salil Mehta <salil.mehta@huawei.com>
> > >
> > > This patch adds a "device_set" interface for modifying properties of devices
> > > that already exist in the guest topology. Unlike 'device_add'/'device_del'
> > > (hot-plug), 'device_set' does not create or destroy devices. It is intended
> > > for guest-visible hot-add semantics where hardware is provisioned at boot but
> > > logically enabled/disabled later via administrative policy.
> > >
> > > Compared to the existing 'qom-set' command, which is less intuitive and works
> > > only with object IDs, device_set provides a more device-oriented interface.
> > > It can be invoked at the QEMU prompt using natural device arguments, and the
> > > new '-deviceset' CLI option allows properties to be set at boot time, similar
> > > to how '-device' specifies device creation.  
> > 
> > Why can't we use -device?
> 
> that's was my concern/suggestion in reply to cover letter
> (as a place to put high level review and what can be done for the next revision)
> 
> (PS: It looks like I'm having email receiving issues (i.e. not getting from
> mail list my own emails that it bonces to me, so threading is all broken on
> my side and I'm might miss replies). But on positive side it looks like my
> replies reach the list and CCed just fine)
> 
> 
> > > While the initial implementation focuses on "admin-state" changes (e.g.,
> > > enable/disable a CPU already described by ACPI/DT), the interface is designed
> > > to be generic. In future, it could be used for other per-device set/unset
> > > style controls — beyond administrative power-states — provided the target
> > > device explicitly allows such changes. This enables fine-grained runtime
> > > control of device properties.  
> > 
> > Beware, designing a generic interface can be harder, sometimes much
> > harder, than designing a specialized one.
> > 
> > device_add and qom-set are generic, and they have issues:
> > 
> > * device_add effectively bypasses QAPI by using 'gen': false.
> > 
> >   This bypasses QAPI's enforcement of documentation.  Property
> >   documentation is separate and poor.
> > 
> >   It also defeats introspection with query-qmp-schema.  You need to
> >   resort to other means instead, say QOM introspection (which is a bag
> >   of design flaws on its own), then map from QOM to qdev.
> > 
> > * device_add lets you specify any qdev property, even properties that
> >   are intended only for use by C code.
> > 
> >   This results in accidental external interfaces.
> > 
> >   We tend to name properties like "x-prop" to discourage external use,
> >   but I wouldn't bet my own money on us getting that always right.
> >   Moreover, there's beauties like "x-origin".
> > 
> > * qom-set & friends effectively bypass QAPI by using type 'any'.
> > 
> >   Again, the bypass results in poor documentation and a defeat of
> >   query-qmp-schema.
> > 
> > * qom-set lets you mess with any QOM property with a setter callback.
> > 
> >   Again, accidental external interfaces: most of these properties are
> >   not meant for use with qom-set.  For some, qom-set works, for some it
> >   silently does nothing, and for some it crashes.  A lot more dangerous
> >   than device_add.
> > 
> >   The "x-" convention can't help here: some properties are intended for
> >   external use with object-add, but not with qom-set.
> > 
> > We should avoid such issues in new interfaces.
> > 
> > We'll examine how this applies to device_set when I review the QAPI
> > schema.
> > 
> > > Key pieces:
> > >   * QMP: qmp_device_set() to update an existing device. The device can be
> > >     located by "id" or via driver+property match using a DeviceListener
> > >     callback (qdev_find_device()).
> > >   * HMP: "device_set" command with tab-completion. Errors are surfaced via
> > >     hmp_handle_error().
> > >   * CLI: "-deviceset" option for setting startup/admin properties at boot,
> > >     including a JSON form. Options are parsed into qemu_deviceset_opts and
> > >     applied after device creation.
> > >   * Docs/help: HMP help text and qemu-options.hx additions explain usage and
> > >     explicitly note that no hot-plug occurs.
> > >   * Safety: disallowed during live migration (migration_is_idle() check).
> > >
> > > Semantics:
> > >   * Operates on an existing DeviceState; no enumeration/new device appears.
> > >   * Complements device_add/device_del by providing state mutation only.
> > >   * Backward compatible: no behavior change unless "device_set"/"-deviceset"
> > >     is used.
> > >
> > > Examples:
> > >   HMP:
> > >     (qemu) device_set host-arm-cpu,core-id=3,admin-state=enable
> > >
> > >   CLI (at boot):
> > >     -smp cpus=4,maxcpus=4 \
> > >     -deviceset host-arm-cpu,core-id=2,admin-state=disable
> > >
> > >   QMP (JSON form):
> > >     { "execute": "device_set",
> > >       "arguments": {
> > >         "driver": "host-arm-cpu",
> > >         "core-id": 1,
> > >         "admin-state": "disable"
> > >       }
> > >     }  
> > 
> > {"error": {"class": "CommandNotFound", "desc": "The command device_set has not been found"}}
> > 
> > Clue below.
> > 
> > > NOTE: The qdev_enable()/qdev_disable() hooks for acting on admin-state will be
> > > added in subsequent patches. Device classes must explicitly support any
> > > property they want to expose through device_set.
> > >
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > ---
> > >  hmp-commands.hx         |  30 +++++++++
> > >  hw/arm/virt.c           |  86 +++++++++++++++++++++++++
> > >  hw/core/cpu-common.c    |  12 ++++
> > >  hw/core/qdev.c          |  21 ++++++
> > >  include/hw/arm/virt.h   |   1 +
> > >  include/hw/core/cpu.h   |  11 ++++
> > >  include/hw/qdev-core.h  |  22 +++++++
> > >  include/monitor/hmp.h   |   2 +
> > >  include/monitor/qdev.h  |  30 +++++++++
> > >  include/system/system.h |   1 +
> > >  qemu-options.hx         |  51 +++++++++++++--
> > >  system/qdev-monitor.c   | 139 +++++++++++++++++++++++++++++++++++++++-
> > >  system/vl.c             |  39 +++++++++++
> > >  13 files changed, 440 insertions(+), 5 deletions(-)  
> > 
> > Clue: no update to the QAPI schema, i.e. the QMP command does not exist.

On that point...

No new pure HMP commands please.  We consider implementation of the
QMP command to be the mandatory first step in any patch series. Any
HMP command must follow and must be implemented by calling the QMP
command handler.


> > > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > > index d0e4f35a30..18056cf21d 100644
> > > --- a/hmp-commands.hx
> > > +++ b/hmp-commands.hx
> > > @@ -707,6 +707,36 @@ SRST
> > >    or a QOM object path.
> > >  ERST
> > >  
> > > +{
> > > +    .name       = "device_set",
> > > +    .args_type  = "device:O",
> > > +    .params     = "driver[,prop=value][,...]",
> > > +    .help       = "set/unset existing device property",
> > > +    .cmd        = hmp_device_set,
> > > +    .command_completion = device_set_completion,
> > > +},
> > > +
> > > +SRST
> > > +``device_set`` *driver[,prop=value][,...]*
> > > +  Change the administrative power state of an existing device.
> > > +
> > > +  This command enables or disables a known device (e.g., CPU) using the
> > > +  "device_set" interface. It does not hotplug or add a new device.
> > > +
> > > +  Depending on platform support (e.g., PSCI or ACPI), this may trigger
> > > +  corresponding operational changes — such as powering down a CPU or
> > > +  transitioning it to active use.
> > > +
> > > +  Administrative state:
> > > +    * *enabled*  — Allows the guest to use the device (e.g., CPU_ON)
> > > +    * *disabled* — Prevents guest use; device is powered off (e.g., CPU_OFF)
> > > +
> > > +  Note: The device must already exist (be declared during machine creation).
> > > +
> > > +  Example:
> > > +      (qemu) device_set host-arm-cpu,core-id=3,admin-state=disabled
> > > +ERST  
> > 
> > How exactly is the device selected?  You provide a clue above: 'can be
> > located by "id" or via driver+property match'.
> > 
> > I assume by "id" is just like device_del, i.e. by qdev ID or QOM path.
> > 
> > By "driver+property match" is not obvious.  Which of the arguments are
> > for matching, and which are for setting?
> > 
> > If "id" is specified, is there any matching?
> > 
> > The matching feature complicates this interface quite a bit.  I doubt
> > it's worth the complexity.  If you think it is, please split it off into
> > a separate patch.
> 
> It's likely /me who to blame for asking to invent generic
> device-set QMP command.
> I see another application (beside ARM CPU power-on/off) for it,
> PCI devices to simulate powering on/off them at runtime without
> actually removing device.
> 
> wrt command,
> I'd use only 'id' with it to identify target device
> (i.e. no template matching nor QMP path either).
> To enforce rule, what user hasn't named explicitly by providing 'id'
> isn't meant to be accessed/manged by user later on. 
> 
> potentially we can invent specialized power_set/get command as
> an alternative if it makes design easier.
> But then we would be spawning similar commands for other things,
> where as device-set would cover it all. But then I might be
> over-complicating things by suggesting a generic approach.

The generic set/get design feels convenient because you don't
need to create new commands, but it has significant downsides
both for QEMU and the users of QEMU.

From a QEMU POV the main burden is that we loose understanding
of how users of QEMU are consuming our interface / functionality
at a conceptual level and at the low level. This in turns means
we either struggle to offer a stable API, or our hands are tied
behind our back for future changes.

Consumers of QEMU are similarly exposed to the raw low level
details which has many downsides

 * If QEMU ever changes impl, but retains the conceptual
   functionality, apps are broken.
 * If a given feature is more complex than a single property,
   apps will be invoking a whole set of commands to set many
   props to achieve a given task.
 * If certain sequences of prop changes are needed, apps
   have no guidance on the ordering dependancies - which
   might even change between QEMU versions
 * If setting one prop fails, apps may need to manually
   rollback previous prop changes they made
 * The schema is unable to describe what functionality is
   now available since device properties are invisible.
 * If two devices expose the same functionality, but via
   different properties, apps have inconsistent interfaces

I'm highly sceptical that exposing 'device_set' is a good
idea.

> > Next question.  Is there a way for management applications to detect
> > whether a certain device supports device_set for a certain property?
> 
> is there some kind of QMP command to check what does a device support,
> or at least what properties it supports? Can we piggy-back on that?

Note, querying whether a device supports a property is conceptually
quite different from querying whether QEMU supports a given operation,
because it requires apps to first connect the dots between the low
level property change, and the conceptual effect the want to produce.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


