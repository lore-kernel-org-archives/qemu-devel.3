Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E6E69EA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUqx-0002Li-Of; Tue, 03 Dec 2024 10:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tIUqw-0002ET-1V
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tIUqt-0008VA-MY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733239814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xaYPA7DcDMuXlCmvsU719ADlCP0A0MkVGrSKmfSjRc=;
 b=N+hCU51hhy5aOR4UFtqaOyGw7YXF+1dxOXrzUy0zXPK0YWkdVwZba0cWqFjImW4HpmZMo8
 E2sbuQSn+gSqaDsru5hIvTRfRv4OnM53ERN7yoVZGrbRzZsjwbzV1kwl9YbDHahb4bZmM/
 jnuYlu6WXozEWMYpyu7fb63T6sDV/rQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-e5VwTLGJNieacjW7qDF2AQ-1; Tue,
 03 Dec 2024 10:30:11 -0500
X-MC-Unique: e5VwTLGJNieacjW7qDF2AQ-1
X-Mimecast-MFC-AGG-ID: e5VwTLGJNieacjW7qDF2AQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5956C1944D43
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2024 15:30:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF9B119560A3
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2024 15:30:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FC1921E66CD; Tue,  3 Dec 2024 16:30:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v3 1/9] hw: eliminate qdev_try_new, isa_try_new &
 usb_try_new
In-Reply-To: <20241115172521.504102-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 15 Nov 2024 17:25:13
 +0000")
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-2-berrange@redhat.com>
Date: Tue, 03 Dec 2024 16:30:06 +0100
Message-ID: <87jzcgrdhd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> These functions all return NULL rather than asserting, if the requested
> type is not registered and also cannot be dynamically loaded.
>
> In several cases their usage is pointless, since the caller then just
> reports an error & exits anyway. Easier to just let qdev_new fail
> with &error_fatal.

Uh, this sounds as if you'd turn assertion failures by fatal errors,
which could be fine, but more than just "eliminate qdev_try_new...".

Turns out you aren't.  qdev_new(), isa_new() and usb_new() are all thin
wrappers around object_new(), which does not assert, but treats errors
as fatal:

    Object *object_new(const char *typename)
    {
        TypeImpl *ti =3D type_get_or_load_by_name(typename, &error_fatal);

        return object_new_with_type(ti);
    }

type_get_or_load_by_name() succeeds if

* type @typename is compiled into this binary, or

* exactly one module providing it is known to this binary, and loading
  it succeeds.

Put a pin into this for later.

Suggest something like

  The difference between qdev_try_new() and qdev_try() is that the
  former returns failure, while the latter treats it as fatal and
  terminates the process.  Same for isa_try_new() and usb_try_new().

A comment in hw/i2c/i2c.h mentions i2c_slave_try_new(), but it doesn't
exist, and never has.  Suggest to eliminate that, too.

> In other cases, the desired semantics are clearer to understand if the
> caller directly checks module_object_class_by_name(), before calling
> the regular qdev_new (or specialized equiv) function.

This tacitly assumes qdev_try_new() & friends fail exactly when
module_object_class_by_name() fails.  True, but not obvious at this
point.

It's true, because it also fails exactly when type_get_or_load_by_name()
returns null:

    ObjectClass *object_class_by_name(const char *typename)
    {
        TypeImpl *type =3D type_get_by_name_noload(typename);

        if (!type) {
            return NULL;
        }

        type_initialize(type);

        return type->class;
    }

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  hw/core/qdev.c              |  9 ---------
>  hw/i386/pc.c                | 22 ++++++++++------------
>  hw/isa/isa-bus.c            |  5 -----
>  hw/s390x/s390-pci-bus.c     |  6 +-----
>  hw/usb/bus.c                |  6 ++----
>  include/hw/isa/isa.h        |  1 -
>  include/hw/net/ne2000-isa.h | 16 ++++++----------
>  include/hw/qdev-core.h      | 12 ------------
>  include/hw/usb.h            |  5 -----
>  9 files changed, 19 insertions(+), 63 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 5f13111b77..960a704a96 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -149,15 +149,6 @@ DeviceState *qdev_new(const char *name)
>      return DEVICE(object_new(name));
>  }
>=20=20
> -DeviceState *qdev_try_new(const char *name)
> -{
> -    ObjectClass *oc =3D module_object_class_by_name(name);
> -    if (!oc) {
> -        return NULL;
> -    }
> -    return DEVICE(object_new_with_class(oc));
> -}
> -
>  static QTAILQ_HEAD(, DeviceListener) device_listeners
>      =3D QTAILQ_HEAD_INITIALIZER(device_listeners);
>=20=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f9147fecbd..d668970bee 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -596,9 +596,11 @@ static gboolean pc_init_ne2k_isa(ISABus *bus, NICInf=
o *nd, Error **errp)
>                     "maximum number of ISA NE2000 devices exceeded");
>          return false;
>      }
> -    isa_ne2000_init(bus, ne2000_io[nb_ne2k],
> -                    ne2000_irq[nb_ne2k], nd);
> -    nb_ne2k++;
> +    if (module_object_class_by_name(TYPE_ISA_NE2000)) {
> +        isa_ne2000_init(bus, ne2000_io[nb_ne2k],
> +                        ne2000_irq[nb_ne2k], nd);
> +        nb_ne2k++;
> +    }

This gave me pause until I saw the change to isa_ne2000_init() below.
There, you replace isa_try_new() by isa_new().  Before the patch,
isa_ne2000_init() can fail, afterwards it treats errors as fatal.  And
that's why you need to guard against failure here.

In other words, you lifted the guard out of isa_ne2000_init() into its
sole caller.  Fine, just less than obvious in review.

>      return true;
>  }
>=20=20
> @@ -1087,7 +1089,7 @@ static void pc_superio_init(ISABus *isa_bus, bool c=
reate_fdctrl,
>      int i;
>      DriveInfo *fd[MAX_FD];
>      qemu_irq *a20_line;
> -    ISADevice *i8042, *port92, *vmmouse;
> +    ISADevice *i8042, *port92, *vmmouse =3D NULL;
>=20=20
>      serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
>      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> @@ -1117,9 +1119,9 @@ static void pc_superio_init(ISABus *isa_bus, bool c=
reate_fdctrl,
>      i8042 =3D isa_create_simple(isa_bus, TYPE_I8042);
>      if (!no_vmport) {
>          isa_create_simple(isa_bus, TYPE_VMPORT);
> -        vmmouse =3D isa_try_new("vmmouse");
> -    } else {
> -        vmmouse =3D NULL;
> +        if (module_object_class_by_name("vmmouse")) {
> +            vmmouse =3D isa_new("vmmouse");
> +        }
>      }
>      if (vmmouse) {
>          object_property_set_link(OBJECT(vmmouse), TYPE_I8042, OBJECT(i80=
42),

This is now like

       vmmouse =3D NULL;
       if (...) {
           if (module_object_class_by_name("vmmouse")) {
               vmmouse =3D isa_new("vmmouse");
           }
       }
       if (vmmouse) {
           object_property_set_link(OBJECT(vmmouse), TYPE_I8042, OBJECT(i80=
42),
                                    &error_abort);
           isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
       }

We could straighten control flow like this:

       if (...) {
           if (module_object_class_by_name("vmmouse")) {
               vmmouse =3D isa_new("vmmouse");
               object_property_set_link(OBJECT(vmmouse), TYPE_I8042,
                                        OBJECT(i8042), &error_abort);
               isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
           }
       }

But there is a more fundamental issue.

pc_superio_init() creates onboard devices.

With CONFIG_MODULES off, it creates a "vmmouse" device exactly when the
type is compiled into this binary.  This makes the guest machine type
depend on build configuration.  I consider this questionable; I'd prefer
such things to be explicit in the C code.  But let's ignore this.

With modules, it creates the device when the type is compiled into this
binary, or is known to it and loadable.  Now the machine type
additionally depends on deployment (exactly one module providing it was
deployed, and it's from the same build, and ...), and on the host's
state (module loading succeeds).

Onboard devices are an integral, guest-visible part of the machine type.
Such parts can be optional and user-configurable.

Silently not creating a device due to intricacies of deployment we can
perhaps handwave away as user error, or more humorously, as a really
opaque way for the user to configure the guest.

Silently not creating it just because the machine is in a funny state,
say temporarily lacks the resources to load a DSO, is plainly wrong.

Not this patch's fault.  Doesn't make it less wrong :)

> @@ -1163,11 +1165,7 @@ void pc_basic_device_init(struct PCMachineState *p=
cms,
>      if (pcms->hpet_enabled) {
>          qemu_irq rtc_irq;
>=20=20
> -        hpet =3D qdev_try_new(TYPE_HPET);
> -        if (!hpet) {
> -            error_report("couldn't create HPET device");
> -            exit(1);
> -        }
> +        hpet =3D qdev_new(TYPE_HPET);

This replaces the error message "couldn't create HPET device" by one
provided by QOM.  These are:

* When the type is not known to this binary: "unknown type 'hpet'".

* When the type is known, but not compiled in, and the module can't be
  loaded for whatever reason: "could not load a module for type 'hpet':
  MORE", where MORE is the error message provided by module_load_qom().

Worth at least hinting at this in the commit message?

>          /*
>           * For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-*,
>           * use IRQ16~23, IRQ8 and IRQ2.  If the user has already set
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index f1e0f14007..8aaf44a3ef 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -158,11 +158,6 @@ ISADevice *isa_new(const char *name)
>      return ISA_DEVICE(qdev_new(name));
>  }
>=20=20
> -ISADevice *isa_try_new(const char *name)
> -{
> -    return ISA_DEVICE(qdev_try_new(name));
> -}
> -
>  ISADevice *isa_create_simple(ISABus *bus, const char *name)
>  {
>      ISADevice *dev;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 40b2567aa7..558f17d3ba 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -922,11 +922,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pci=
State *s,
>      Error *local_err =3D NULL;
>      DeviceState *dev;
>=20=20
> -    dev =3D qdev_try_new(TYPE_S390_PCI_DEVICE);
> -    if (!dev) {
> -        error_setg(errp, "zPCI device could not be created");
> -        return NULL;
> -    }
> +    dev =3D qdev_new(TYPE_S390_PCI_DEVICE);

Likewise.

>=20=20
>      if (!object_property_set_str(OBJECT(dev), "target", target, &local_e=
rr)) {
>          object_unparent(OBJECT(dev));
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index bfab2807d7..002f7737e4 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -394,7 +394,6 @@ void usb_claim_port(USBDevice *dev, Error **errp)
>  {
>      USBBus *bus =3D usb_bus_from_device(dev);
>      USBPort *port;
> -    USBDevice *hub;
>=20=20
>      assert(dev->port =3D=3D NULL);
>=20=20
> @@ -412,9 +411,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)
>      } else {
>          if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev=
)), "usb-hub") !=3D 0) {
>              /* Create a new hub and chain it on */
> -            hub =3D usb_try_new("usb-hub");
> -            if (hub) {
> -                usb_realize_and_unref(hub, bus, NULL);
> +            if (module_object_class_by_name("usb-hub")) {
> +                usb_realize_and_unref(usb_new("usb-hub"), bus, NULL);

Another instance of silent non-creation of an onboard device when
deployment is bad host is in a funny state.

>              }
>          }
>          if (bus->nfree =3D=3D 0) {
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 40d6224a4e..8475120849 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -81,7 +81,6 @@ IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
>   */
>  qemu_irq isa_bus_get_irq(ISABus *bus, unsigned irqnum);
>  ISADevice *isa_new(const char *name);
> -ISADevice *isa_try_new(const char *name);
>  bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
>  ISADevice *isa_create_simple(ISABus *bus, const char *name);
>=20=20
> diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
> index 73bae10ad1..aeb3e2bfd5 100644
> --- a/include/hw/net/ne2000-isa.h
> +++ b/include/hw/net/ne2000-isa.h
> @@ -20,17 +20,13 @@
>  static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
>                                           NICInfo *nd)
>  {
> -    ISADevice *d;
> +    ISADevice *d =3D isa_new(TYPE_ISA_NE2000);
> +    DeviceState *dev =3D DEVICE(d);
>=20=20
> -    d =3D isa_try_new(TYPE_ISA_NE2000);
> -    if (d) {
> -        DeviceState *dev =3D DEVICE(d);
> -
> -        qdev_prop_set_uint32(dev, "iobase", base);
> -        qdev_prop_set_uint32(dev, "irq",    irq);
> -        qdev_set_nic_properties(dev, nd);
> -        isa_realize_and_unref(d, bus, &error_fatal);
> -    }
> +    qdev_prop_set_uint32(dev, "iobase", base);
> +    qdev_prop_set_uint32(dev, "irq",    irq);
> +    qdev_set_nic_properties(dev, nd);
> +    isa_realize_and_unref(d, bus, &error_fatal);
>      return d;
>  }
>=20=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 5be9844412..020417d027 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -443,18 +443,6 @@ compat_props_add(GPtrArray *arr,
>   */
>  DeviceState *qdev_new(const char *name);
>=20=20
> -/**
> - * qdev_try_new: Try to create a device on the heap
> - * @name: device type to create
> - *
> - * This is like qdev_new(), except it returns %NULL when type @name
> - * does not exist, rather than asserting.
> - *
> - * Return: a derived DeviceState object with a reference count of 1 or
> - * NULL if type @name does not exist.
> - */
> -DeviceState *qdev_try_new(const char *name);
> -
>  /**
>   * qdev_is_realized() - check if device is realized
>   * @dev: The device to check.
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index d46d96779a..bb778cb844 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -584,11 +584,6 @@ static inline USBDevice *usb_new(const char *name)
>      return USB_DEVICE(qdev_new(name));
>  }
>=20=20
> -static inline USBDevice *usb_try_new(const char *name)
> -{
> -    return USB_DEVICE(qdev_try_new(name));
> -}
> -
>  static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Er=
ror **errp)
>  {
>      return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);

Maybe I'm having another scatter-brained day, but I found the patch
somewhat confusing in review.  Happy to suggest a possible split if
you're interested.


