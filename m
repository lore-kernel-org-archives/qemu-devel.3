Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7718606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AWDF3M9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPK3v-0001lf-1N; Fri, 06 Nov 2026 08:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPK3p-0001kw-SM
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPK3n-0001AY-UN
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793971969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Yg5qxT50mFvQuB+7RqERgQTZwLWvw2ZTIKXoVg9Adcw=;
 b=AWDF3M9vc6tXnRxxosKM6BSr8eJ0tLmIK96EmtAhC9SCWYqMuX2IYeGRT4L7U2gbqWnZ7D
 uDrNJx6d6yGjawpMA69dltQxbVRK0cZuMI8UooM7+Ik4LBBAPYrrSuQZV7AnQ/f+E9yt7Q
 T3d1pbbeRoZaoJu1cft+z/Dentixl7k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-RmxBu9htN8CQOjw7ZCeBvg-1; Fri,
 06 Nov 2026 08:32:47 -0500
X-MC-Unique: RmxBu9htN8CQOjw7ZCeBvg-1
X-Mimecast-MFC-AGG-ID: RmxBu9htN8CQOjw7ZCeBvg_1793971966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB2F6180048E; Fri,  6 Nov 2026 13:32:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23BF2195608C; Fri,  6 Nov 2026 13:32:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FEDD21E6A04; Fri, 06 Nov 2026 14:32:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <alex@csgraf.de>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Property names of certain bus children vary
Date: Fri, 06 Nov 2026 14:32:43 +0100
Message-ID: <87tsludr0k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Due to the dynamic nature of QOM, an object's properties can vary:
additional properties can show up if I create it in a certain way.

Nevertheless, I expect property names to be stable, i.e. a certain kind
of object's property gets the same name no matter how (and how often) I
create the object.  Reasonable, isn't it?

It's not true.  I can see certain property names change every time I
create an object.  Even introspecting the object *type* suffices to
change them.

Reproducer:

    $ ../qemu/bld/qemu-system-ppc64 -S -nodefaults -display none -qmp-pretty stdio
    [...]
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {
        "return": {
        }
    }
    {"execute": "qom-list-properties", "arguments": {"typename": "macio-ide"}}
    {
        "return": [
            [...]
            {
                "name": "ide.0",
                "type": "child<IDE>",
                "qapi-type": "str"
            },
            [...]
        ]
    }
    {"execute": "qom-list-properties", "arguments": {"typename": "macio-ide"}}
    {
        "return": [
            [...]
            {
                "name": "ide.1",
                "type": "child<IDE>",
                "qapi-type": "str"
            },
            [...]
        ]
    }
    {"execute": "qom-list-properties", "arguments": {"typename": "macio-ide"}}
    {
        "return": [
            [...]
            {
                "name": "ide.2",
                "type": "child<IDE>",
                "qapi-type": "str"
            },
            [...]
        ]
    }

I elided all properties but the "IDE" child.  The elided properties are
the same each time.

The "IDE" child has a different name each time: "ide.0", "ide.1",
"ide.2".  WTF?

Due to the way QOM is designed, qom-list-properties creates a throwaway
object for concrete types:

    ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
                                                 Error **errp)
    {
        ObjectClass *klass;
        Object *obj = NULL;
        ObjectProperty *prop;
        ObjectPropertyIterator iter;
        ObjectPropertyInfoList *prop_list = NULL;

        klass = module_object_class_by_name(typename);
        if (klass == NULL) {
            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                      "Class '%s' not found", typename);
            return NULL;
        }

        if (!object_class_dynamic_cast(klass, TYPE_OBJECT)) {
            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
                       "a QOM type");
            return NULL;
        }

        if (object_class_is_abstract(klass)) {
            object_class_property_iter_init(&iter, klass);
        } else {
--->        obj = object_new(typename);
            object_property_iter_init(&iter, obj);
        }
        while ((prop = object_property_iter_next(&iter))) {
            QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
        }

        object_unref(obj);

        return prop_list;
    }

The chameleon property then gets created here:

    static void qbus_init_internal(BusState *bus, DeviceState *parent,
                                   const char *name)
    {
        const char *typename = object_get_typename(OBJECT(bus));
        BusClass *bc;
        int i, bus_id;

        bus->parent = parent;

        if (name) {
            bus->name = g_strdup(name);
        } else if (bus->parent && bus->parent->id) {
            /* parent device has id -> use it plus parent-bus-id for bus name */
            bus_id = bus->parent->num_child_bus;
            bus->name = g_strdup_printf("%s.%d", bus->parent->id, bus_id);
        } else {
            /* no id -> use lowercase bus type plus global bus-id for bus name */
            bc = BUS_GET_CLASS(bus);
--->        bus_id = bc->automatic_ids++;
--->        bus->name = g_strdup_printf("%s.%d", typename, bus_id);
            for (i = 0; bus->name[i]; i++) {
                bus->name[i] = qemu_tolower(bus->name[i]);
            }
        }

        if (bus->parent) {
            QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
            bus->parent->num_child_bus++;
--->        object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus));
            object_unref(OBJECT(bus));
        } else {
            /* The only bus without a parent is the main system bus */
            assert(bus == sysbus_get_default());
        }
    }

Called like this:

    #0  qbus_init_internal (bus=0x555557525340, parent=0x555557524ef0, name=0x0)
        at ../hw/core/bus.c:105
    #1  0x0000555555af35ac in qbus_init
        (bus=0x555557525340, size=<optimized out>, typename=<optimized out>, parent=<optimized out>, name=<optimized out>) at ../hw/core/bus.c:162
    #2  0x0000555555768cbf in ide_bus_init
        (idebus=idebus@entry=0x555557525340, idebus_size=idebus_size@entry=2304, dev=<optimized out>, bus_id=bus_id@entry=0, max_units=max_units@entry=2)
        at ../hw/ide/ide-bus.c:59
    #3  0x0000555555773ae2 in macio_ide_initfn (obj=0x555557524ef0)
        at ../hw/ide/macio.c:448
    #4  0x0000555555afcdb4 in object_init_with_type
        (obj=0x555557524ef0, ti=0x555556abb620) at ../qom/object.c:430
    #5  object_initialize_with_type
        (obj=0x555557524ef0, size=<optimized out>, type=0x555556abb620)
        at ../qom/object.c:512
    #6  0x0000555555afd14f in object_new_with_type (type=0x555556abb620)
        at ../qom/object.c:710
    #7  0x0000555555bffd86 in qmp_qom_list_properties
        (typename=0x5555573bb650 "macio-ide", errp=0x555557524ef0, 
        errp@entry=0x7fffffffd8e0) at ../qom/qom-qmp-cmds.c:290

So, every time we create a "macio" object, its TYPE_IDE_BUS child gets
another name.  This is... undesirable.

I've seen it for other bus types as well.  It happens when we call
qbus_init() or qbus_new() with a null @name argument.

BusClass member @automatic_ids goes back to

commit 61de36761b565a4138d8ad7ec75489ab28fe84b6
Author: Alexander Graf <agraf@csgraf.de>
Date:   Thu Feb 6 16:08:15 2014 +0100

    qdev: Keep global allocation counter per bus
    
    When we have 2 separate qdev devices that both create a qbus of the
    same type without specifying a bus name or device name, we end up
    with two buses of the same name, such as ide.0 on the Mac machines:
    
      dev: macio-ide, id ""
        bus: ide.0
          type IDE
      dev: macio-ide, id ""
        bus: ide.0
          type IDE
    
    If we now spawn a device that connects to a ide.0 the last created
    bus gets the device, with the first created bus inaccessible to the
    command line.
    
    After some discussion on IRC we concluded that the best quick fix way
    forward for this is to make automated bus-class type based allocation
    count a global counter. That's what this patch implements. With this
    we instead get
    
      dev: macio-ide, id ""
        bus: ide.1
          type IDE
      dev: macio-ide, id ""
        bus: ide.0
          type IDE
    
    on the example mentioned above.
    
    This also means that if you did -device ...,bus=ide.0 you got a device
    on the first bus (the last created one) before this patch and get that
    device on the second one (the first created one) now.  Breaks
    migration unless you change bus=ide.0 to bus=ide.1 on the destination.
    
    This is intended and makes the bus enumeration work as expected.
    
    As per review request follows a list of otherwise affected boards and
    the reasoning for the conclusion that they are ok:
    
       target      machine         bus id              times
       ------      -------         ------              -----
    
       aarch64     n800            i2c-bus.0           2
       aarch64     n810            i2c-bus.0           2
       arm         n800            i2c-bus.0           2
       arm         n810            i2c-bus.0           2
    
    -> Devices are only created explicitly on one of the two buses, using
       s->mpu->i2c[0], so no change to the guest.
    
       aarch64     vexpress-a15    virtio-mmio-bus.0   4
       aarch64     vexpress-a9     virtio-mmio-bus.0   4
       aarch64     virt            virtio-mmio-bus.0   32
       arm         vexpress-a15    virtio-mmio-bus.0   4
       arm         vexpress-a9     virtio-mmio-bus.0   4
       arm         virt            virtio-mmio-bus.0   32
    
    -> Makes -device bus= work for all virtio-mmio buses.  Breaks
       migration.  Workaround for migration from old to new: specify
       virtio-mmio-bus.4 or .32 respectively rather than .0 on the
       destination.
    
       aarch64     xilinx-zynq-a9  usb-bus.0           2
       arm         xilinx-zynq-a9  usb-bus.0           2
       mips64el    fulong2e        usb-bus.0           2
    
    -> Normal USB operation not affected. Migration driver needs command
       line to use the other bus.
    
       i386        isapc           ide.0               2
       x86_64      isapc           ide.0               2
       mips        mips            ide.0               2
       mips64      mips            ide.0               2
       mips64el    mips            ide.0               2
       mipsel      mips            ide.0               2
       ppc         g3beige         ide.0               2
       ppc         mac99           ide.0               2
       ppc         prep            ide.0               2
       ppc64       g3beige         ide.0               2
       ppc64       mac99           ide.0               2
       ppc64       prep            ide.0               2
    
    -> Makes -device bus= work for all IDE buses.  Breaks migration.
       Workaround for migration from old to new: specify ide.1 rather than
       ide.0 on the destination.
    
    Signed-off-by: Alexander Graf <agraf@suse.de>
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Andreas Faerber <afaerber@suse.de>
    Signed-off-by: Alexander Graf <agraf@suse.de>


