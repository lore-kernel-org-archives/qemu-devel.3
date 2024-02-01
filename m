Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A5C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRsU-0004lA-It; Thu, 01 Feb 2024 02:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rVRsS-0004kx-Ao
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:52:52 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rVRsO-0006fy-V8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706773969; x=1738309969;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=L3BXz2JhVe2eUQAHxyzzTb5VjzUOuA6TY9RkGBZ6SXM=;
 b=VRXBamKfmKLeIipgL5CR26VikQ3bC0NV4EJIKVgJ7stM6Q3M0Az3nwRw
 4cam5RMAoxWCTOYdWEpPrZ2UwAzwXMtRkSifX2Hj96ZfxzR2rFtUvhhVO
 Gpf5st0bEfdl47jABDxuUW4arO/pelTdtPMvTcO6lz696emgNslTIk3NC
 0f2wgkWHnS5ZMaj0Dv46RVohOw2DELVUAi9x0679Avq2T8fO4C3eOIG2u
 +Hhj2GcldCj/ufQMw6WrgVxWfeI/vd5sXFbBkrBMaEVW69GeePZG8PWQ9
 jQdj+KhZQs2e3DI3t9kf+q1dM93EbFXWDnpGmFu3Syt71TT7C9huMl3Pn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10467426"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="10467426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822856838"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="822856838"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 31 Jan 2024 23:52:34 -0800
Date: Thu, 1 Feb 2024 16:06:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Warner Losh <imp@bsdimp.com>,
 Luc Michel <luc@lmichel.fr>, Bernhard Beschow <shentey@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Mark Burton <mburton@qti.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jim Shu <jim.shu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: Dynamic & heterogeneous machines, initial configuration: problems
Message-ID: <ZbtQ7dWHum2Z1SZj@intel.com>
References: <87o7d1i7ky.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7d1i7ky.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Markus,

On Wed, Jan 31, 2024 at 09:14:21PM +0100, Markus Armbruster wrote:
> Date: Wed, 31 Jan 2024 21:14:21 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Dynamic & heterogeneous machines, initial configuration: problems
> 
> This memo is the fruit of discussions with Philippe Mathieu-Daudé.
> Its errors are mine.
> 
> QEMU defines machines statically in C code.  We've long wished we could
> define them dynamically in some suitable DSL.  This is what we call
> "dynamic machines".
> 
> There's a need for machines that contain more than one target's CPUs.
> This is what we call "heterogeneous machines".  They require a single
> binary capable of any of the targets involved.
> 
> There's substantial overlap with a seemingly unrelated problem:
> machine-friendly initial configuration.
> 
> To keep the memo's length in check (sort of), it focuses on (known)
> problems.
> 
> 
> = Problem 1: Initial configuration =
> 
> Previously discussed in
> 
>     Subject: Redesign of QEMU startup & initial configuration
>     Date: Thu, 02 Dec 2021 07:57:38 +0100
>     Message-ID: <87lf13cx3x.fsf@dusky.pond.sub.org>
> 
> 
> == What users want for initial configuration ==
> 
> 1. QMP only
> 
>    Management applications need to use QMP for monitoring anyway.  They
>    may want to use it for initial configuration, too.  Libvirt does.
> 
>    They still need to bootstrap a QMP monitor, and for that, CLI is fine
>    as long as it's simple and stable.
> 
> 2. CLI and configuration files
> 
>    Human users want a CLI and configuration files.
> 
>    CLI is good for quick tweaks, and to explore.
> 
>    For more permanent, non-trivial configuration, configuration files
>    are more suitable, because they are easier to read, edit, and
>    document than long command lines.
> 
> 
> == What we have for initial configuration ==
> 
> Half of 1. and half of 2., satisfying nobody's needs.
> 
> Management applications need to do a lot of non-trivial initial
> configuration with the CLI.
> 
> Human users struggle with inconsistent syntax, insufficiently expressive
> configuration files, and huge command lines.
> 
> 
> = Problem 2: Defining machines =
> 
> This is how I understand the problem.  Please correct me where I'm off.
> 
> 
> == How we'd like to build machines ==
> 
> We want to build machines declaratively, by configuring devices and
> their connections.
> 
> We want to build composite devices the same way.
> 
> The non-composite devices are provided by the QEMU binary.
> 
> Users want to build machines as variations of canned machine types
> shipped with QEMU.  Some users may want to build their own machines from
> scratch.
> 
> To enable all this, machine configuration needs to be composable and
> dynamic.
> 
> Composable means configuration can be assembled from components,
> recursively.
> 
> Dynamic means it can be done during qemu-system-FOO initial
> configuration.
> 
> 
> == What we have for defining machines ==
> 
> A QEMU binary provides a fixed set of device types, some of them
> composite, and a fixed set of machine types.
> 
> Machines are QOM objects: instance of a concrete subtype of "machine".
> 
> Devices are usually QOM objects: instance of a concrete subtype of
> "device".  Exceptions remain in old code nobody can be bothered to
> update.
> 
> Both machine types and composite devices are built from devices
> by code, i.e. imperatively, not declaratively.
> 
> The code can be parameterized.  For QOM objects, parameters should be
> QOM properties, but machine type code additionally uses global old-style
> configuration such as -drive and -serial.
> 
> Code may create default backends for convenience.  Machine type code may
> also create backends to honor global old-style configuration.  Only some
> backends are QOM objects.
> 
> Machine types split their code between object creation (QOM methods
> .instance_init() and .instance_post_init()) and machine initialization
> (MachineClass method .init()).  However, basically everything is done in
> the latter.
> 
> QOM device types split their code between object creation and device
> realization (qdev method .realize()).  The actual split varies widely
> between devices.  Developers are commonly unsure what to put where.
> 
> After machine type code is done, the resulting machine can still be
> adjusted with device cold plug and unplug: -device, device_add,
> device_del.  Only works for a subset of the devices.
> 
> Related, but out of scope here: hot plug and unplug.
> 
> 
> = Common sub-problem: qemu-system initial startup =
> 
> QAPI/QMP is our most capable, flexible, and mature configuration
> interface.  We need to offer machine-friendly initial configuration via
> QMP, and we'd very much like to have a QAPI-based CLI and configuration
> files (see "What users want for initial configuration" above).
> 
> Dynamic machine configuration happens during initial startup.  This
> makes it part of the larger initial configuration problem.  We want an
> integrated solution for the larger configuration problem that includes
> machine configuration.
> 
> Traditionally, QMP becomes available quite late, long after machine
> initialization.  This precludes use of QMP for most parts of initial
> configuration, including dynamic machine configuration.
> 
> To enable a bit of machine configuration via QMP, experimental CLI
> option -preconfig delays part of initial startup including machine
> initialization by moving it into QMP command x-exit-preconfig.  Only
> selected commands (the ones marked 'allow-preconfig': true) are
> available before x-exit-preconfig.
> 
> To enable arbitrary configuration via QMP, we need to make it available
> before we complete configuring anything.
> 
> QMP is a concrete transport for an abstract interface.  Configuration
> files could be another transport.  CLI, too.
> 
> 
> = Problem 3: Loadable modules =
> 
> QOM wasn't designed for loadable modules.  Support for them was grafted
> on, and there are serious deficiencies.
> 
> Building a loadable module results in a DSO.  Additionally, module
> meta-data necessary to load it is compiled into the executables that can
> load modules.  Actually loading a module can fail, e.g. when the module
> was not deployed.
> 
> Loadable modules are designed to be transparent, i.e. users don't need
> to know whether a module is compiled in or loadable.
> 
> QOM types don't exist until the module is initialized.  Compiled-in
> modules are initialized early in startup.  Loadable modules are
> initialized on load.
> 
> QMP command qom-list-types returns all QOM types.  To be able to find
> them all, it needs to load all modules.  Modules that cannot be found
> (or have dependencies that cannot be found) are silently ignored.  Any
> other loading errors are reported to stderr with error_report_err(),
> which is inappropriate.  In either case, the types provided by the
> unloadable modules are not returned by the command.
> 
> We have two functions to look up an object class by name:
> object_class_by_name() and module_object_class_by_name().  The latter
> attempts to load a module when the type doesn't exist.  Again, modules
> that cannot be found are silently ignored, and other loading errors are
> reported with error_report_err(), which is inappropriate in certain
> contexts.
> 
> When to use which of the two functions is unclear.  Existing usage may
> well be wrong.
> 
> The QOM functions to create objects in-place (object_initialize(), ...)
> or on the heap (object_new(), ...) cannot fail.  This is just fine in
> QOM's original design.  It is not fine when a loadable module fails to
> load.  Since the functions can't fail, they exit(1) then.
> 
> This means things like a hot plugging a device provided by a loadable
> module can crash a VM immediately.
> 
> Attempting to load all modules beforehand with qom-list-types does not
> protect against this: we try to load again, fail again, and exit(1).
> 
> 
> = Problem 4: The /machine/unattached/ orphanage =
> 
> Is it okay for a QOM object to have no parent?
> 
> An object without a parent is not part of the composition tree; it has
> no canonical path, and object_get_canonical_path() returns null.
> 
> Such objects can behave in wonky ways.  For instance,
> object_property_set_link() treats a target object without a parent as
> null.  If a linked object somehow loses its parent,
> object_property_get_link() will return null even though the underlying C
> pointer still points to the poor orphan.
> 
> This strongly suggests QOM was designed with the assumption that objects
> always have a parent, except during initialization (before they are
> connected to anything) and finalization (when no longer connected to
> anything).  object_property_try_add_child()'s contract seems to confirm
> this:
> 
>  * Child properties form the composition tree.  All objects need to be a child
>  * of another object.  Objects can only be a child of one object.
> 
> Some functions to create objects take the new object's parent as a
> parameter.  Example: object_new_with_props(), object_new_with_propv(),
> clock_new(), ...
> 
> Others set a fixed parent.  For instance, we always add character
> backends to "/chardevs/", objects created with object-add in
> "/objects/", devices created with device_add in "/machine/peripheral/"
> (with ID) or "/machine/peripheral-anon/" (without ID), ...
> 
> There are also functions that don't set a parent: object_new(),
> object_new_with_class(), qdev_new(), qdev_try_new(), ...  Setting a
> parent is the callers job then.  Invites misuse.  I'm aware of one
> instance: @current_migration remains without a parent forever.
> 
> Not all callers care to set a parent themselves.  Instead, they rely on
> the "/machine/unattached/" orphanage:
> 
> * qdev_connect_gpio_out_named() needs the input pin to have a parent.
>   If it lacks one, it gets added to "/machine/unattached/" with a
>   made-up name.
> 
> * device_set_realized() ensures realized devices have a parent by adding
>   devices lacking one to "/machine/unattached/" with a made-up name.
> 
> * portio_list_add() adds a memory region.  If the caller doesn't specify
>   the parent, "/machine/unattached/" is assumed.
> 
> * memory_region_init() adds a memory region, and may set the parent.  If
>   the caller requests setting a parent without specifying one,
>   "/machine/unattached/" is assumed.
> 
> * qemu_create_machine() adds the main system bus to
>   "/machine/unattached/".
> 
> Except for the last one, the child names depend on execution order.  For
> instance, device_set_realized() uses "device[N]", where N counts up from
> zero.
> 
> These brittle, made-up names are visible in QMP QOM introspection.
> Whether that's a stable interface is unclear.  Better not.
> 
> We don't rely on these names in C.  We follow pointers instead.
> 
> When we replace C code by configuration, we switch from pointers to
> names.  Brittle names become a problem.
> 
> 
> = Problem 5: QOM lacks a clear life cycle =
> 
> QOM doesn't define a clear life cycle.
> 
> It has an implicit one:
> 
>     created ---------+
>        |             |
>        v             |
>     parented <--+    |
>        |        |    |
>        v        |    |
>     unparented -+    |
>        |             |
>        v             |
>     destroyed <------+
> 
> I'm not aware of code that goes from "unparented" back to "parented".
> 
> Since the object becomes visible in the QOM graph at add to parent time,
> object configuration (by setting properties) should probably be finished
> then.
> 
> Some subtypes define their own life cycle.
> 
> Devices (subtypes of TYPE_DEVICE) go
> 
>     created ---------+
>        |             |
>        v             |
>     realized <--+    |
>        |        |    |
>        v        |    |
>     unrealized -+    |
>        |             |
>        v             |
>     destroyed <------+
> 
> I'm pretty sure we don't actually go from "unrealized" back to
> "realized".
> 
> The device is to be configured (by setting properties) in state created.
> 
> The transition to realized can fail.  When it does, we go to destroyed
> immediately.
> 
> If the device has no QOM parent when we try to realize, we make one up
> (see problem 4).  Unrealize automatically removes from parent.  So the
> actual cycle is like
> 
>     created ------+
>        |          |
>        v          |
>     parented      |
>        |          |
>        v          |
>     realized      |
>        |          |
>        v          |
>     unrealized    |
>        |          |
>        v          |
>     unparented    |
>        |          |
>     destroyed <---+
> 
> We way want to refine the life cycle further, e.g. to include reset.
> 
> User-createable objects (objects that have interface
> TYPE_USER_CREATABLE) go
> 
>     created -----+
>        |         |
>        v         |
>     completed    |
>        |         |
>        v         |
>     destroyed <--+
> 
> The object is to be configured (by setting properties) in state created.
> 
> The transition to complete can fail.  When it does, we go to destroyed
> immediately.
> 
> The actual life cycle is
> 
>     created ------+
>        |          |
>        v          |
>     parented      |
>        |          |
>        v          |
>     completed     |
>        |          |
>        v          |
>     unparented    |
>        |          |
>        v          |
>     destroy <-----+
> 
> Somewhat related: machine init done notifiers let arbitrary code
> (including object initialization register a callback to be run when
> machine initialization completes.
> 
> Ideally, a composite object's components go through the life cycle
> together.  First, create all the components and assign parents.  This
> also creates all the properties.  Then configure the object by setting
> property values.  Finally, complete / realize all components.
> 
> However, when the number or type of components depend on property
> values, creation has to be delayed, possibly even until complete /
> realize.  This complicates their configuration.  
> 
> Note that a machine is a (big) composite object.
> 
> For dynamic configuration, we likely want one useful life cycle for
> everything, not one for devices, one for user-creatable objects, and a
> not so useful one for everything else.
> 
> "Everything" will have to be more than what is available with -device
> and -object now.
> 
> 
> = Problem 6: QOM's object configuration interface =
> 
> QOM objects are configured by setting properties.
> 
> Properties have other uses, such as telemetry, control, and internal
> versioning.  Properties are mostly undocumented, and their intended
> purpose is commonly unclear.
> 
> Properties are added dynamically by C code.  In particular, setting a
> property can add or delete properties.  This makes the configuration
> interface dynamic.  Properties may need to be set in a certain order.
> Such ordering constraints don't play well with declarative
> configuration.
> 
> QOM type introspection can only report initial properties.  To find an
> object's current properties, you need to introspect the object, not its
> type.
> 
> The type information available via QOM introspection is mostly
> undocumented, and much weaker than in QAPI/QMP introspection.
> 
> These introspection deficiencies can get in the way of more
> sophisticated use of the interface.  Whether this affects declarative
> machine specification is unclear.
> 
> Kevin Wolf proposed to move the configuration interface into the QAPI
> schema, to make it compile-time static, introspectable, and to force us
> to document it properly.
> 
> RFC patches:
> 
>     Subject: [RFC PATCH 00/12] QOM/QAPI integration part 1
>     Date: Wed, 3 Nov 2021 18:29:50 +0100
>     Message-Id: <20211103173002.209906-1-kwolf@redhat.com>
> 
> 
> = Problem 7: Design of the machine specification DSL =
> 
> We want to specify machines and machine components in a declarative DSL.
> 
> From an abstract point of view, a machine or component is merely a graph
> of QOM objects connected by child and link edges.  Objects and child
> edges form the composition tree.
> 
> Such a composite object can be specified by listing its component
> objects with their properties.  Special child and link properties
> specify the edges.  All we need so far is a way to specify an object and
> its properties, where special property values refer to other objects,
> say by QOM path.
> 
> A composite object has in turn properties.  It could for instance expose
> a property of one of its components.  It could also apply a scale
> factor, or some other computation.  It could connect a single own
> property to multiple component properties.  How can we specify all this?
> 
> For practical machine specification, we need more than just the ability
> to specify objects.  The C code uses loops to create multiple similar
> objects, and functions to build abstractions such as composite objects
> or complex connections.  How can we address the same needs in a
> declarative DSL?
> 
> Complication: life cycle management (see problem 5).  We need to manage
> a state transition from "object created, but not ready for use" to
> "object configured and ready for use".  In what order do the objects
> change state?
> 
> Moreover, we have quite a few graphs in QEMU:
> 
> * QOM composition tree
> * Memory tree
> * qdev tree(s) (legacy)
> * irq graph
> * reset wiring (tree or graph?)
> * more?
> 
> Not all of them are modelled in QOM, I fear.  How do we plan to deal
> with that?

Maybe and the graph for CPU topology.

CPU topology is not just an abstraction of the purely virtual topology
hierarchy, but also has a direct impact on how we should organize
heterogeneous cores and caches in a machine.

Since the heterogeneous machine I'm dealing with directly is the Intel
client CPUs (Alder Lake, Rapor Lake and Meteor Lake), with the same
target but very different performance/power efficiency cores. And though
the P core and E core for Intel hybrid CPU have the nearly identical
ISAs, they still have some difficience, e.g., their PMUs have different
events.

Therefore, I think this case should also be included in the
heterogeneous machine category, right?

About the CPU topology graph, I also posted some RFCs:
* The first try: [RFC 00/52] Introduce hybrid CPU topology
https://lore.kernel.org/qemu-devel/20230213095035.158240-1-zhao1.liu@linux.intel.com/

* The second try: [RFC 00/41] qom-topo: Abstract Everything about CPU
  Topology:
https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.liu@linux.intel.com/

Unfortunately, however, no feedback was received on the second attempt.
I'd hope to be educated in the right direction as well. So hopefully
when discussing heterogeneous machines, the Intel hybrid CPU case
especially hybrid topology scenarios can also be taken into
consideration, which is the heterogeneous scenario we are trying to push
in virtualization.

Thanks,
Zhao

> 
> 
> = Problem 8: Singletons =
> 
> When the same global symbol is defined in multiple targets, we can't
> link the targets into a single binary.  For instance, we declare
> kvm_arch_init() in include/sysemu/kvm.h, and define it in each target
> that supports KVM.  This is a problem, but it's one the linker reliably
> flags for us.
> 
> When a global symbol defined in target-independent code is used by
> multiple targets, the linker gives us a single global shared by all
> targets.  This sharing may or may not work.
> 
> Consider macro @first_cpu retrieves the first CPU from global variable
> @cpus_queue.  Target code commonly QOM-casts this CPUState pointer to
> the target CPU state pointer.  Works fine as long as the machine uses a
> single target CPU class, even if the binary contains many of them.
> However, a heterogeneous machine has more than one target CPU class.
> 
> Some QOM objects are singletons.  For instance, TYPE_ISA_BUS is due to
> its use of global @isabus, and TYPE_I8259 is due to its use of globals
> @isa_pic and @slave_pic.  isa_bus_new() catches attemnpts to create more
> than one instance.  i8259_init() does not.  Instead, it overwrites the
> globals.
> 
> External interfaces also contain singletons.  Consider -machine
> kernel=FNAME.  Fine until we have a heterogeneous machine running more
> than one kernel simultaneously.
> 

