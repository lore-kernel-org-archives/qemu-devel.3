Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BD9E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEc4-0007bK-GL; Thu, 05 Dec 2024 11:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJEc1-0007Wz-Oi
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:21:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJEbz-0008IM-Ev
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733415714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSATqpI0wCvYxB2iHiAsr/2mzBka+v1sKXeGo/CoabM=;
 b=OaoCVRtVZI/KZ9xEup27ICrIvBJsGfKa5IfR+vZEFU+bigJth+PjekUV35i5cifoUk3Oie
 Say6jgkqqB2Q7m4dOrkuj1rYFvVG1hUQzczt6yUCNj+ZQUX3XM9moaMWHxtK3CX4YOdNjQ
 4lDVsjCWTorVfYU0Zm6zRVgvBiZWYd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-sfMzNjNoP_OuW6Sl2URCsA-1; Thu,
 05 Dec 2024 11:21:53 -0500
X-MC-Unique: sfMzNjNoP_OuW6Sl2URCsA-1
X-Mimecast-MFC-AGG-ID: sfMzNjNoP_OuW6Sl2URCsA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D5D11955F39
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2024 16:21:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C487430001A1; Thu,  5 Dec 2024 16:21:50 +0000 (UTC)
Date: Thu, 5 Dec 2024 16:21:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 1/9] hw: eliminate qdev_try_new, isa_try_new &
 usb_try_new
Message-ID: <Z1HTG0apfYGbexUM@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
 <20241115172521.504102-2-berrange@redhat.com>
 <87jzcgrdhd.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzcgrdhd.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 03, 2024 at 04:30:06PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > These functions all return NULL rather than asserting, if the requested
> > type is not registered and also cannot be dynamically loaded.
> >
> > In several cases their usage is pointless, since the caller then just
> > reports an error & exits anyway. Easier to just let qdev_new fail
> > with &error_fatal.
> 
> Uh, this sounds as if you'd turn assertion failures by fatal errors,
> which could be fine, but more than just "eliminate qdev_try_new...".
> 
> Turns out you aren't.  qdev_new(), isa_new() and usb_new() are all thin
> wrappers around object_new(), which does not assert, but treats errors
> as fatal:
> 
>     Object *object_new(const char *typename)
>     {
>         TypeImpl *ti = type_get_or_load_by_name(typename, &error_fatal);
> 
>         return object_new_with_type(ti);
>     }
> 
> type_get_or_load_by_name() succeeds if
> 
> * type @typename is compiled into this binary, or
> 
> * exactly one module providing it is known to this binary, and loading
>   it succeeds.
> 
> Put a pin into this for later.
> 
> Suggest something like
> 
>   The difference between qdev_try_new() and qdev_try() is that the
>   former returns failure, while the latter treats it as fatal and
>   terminates the process.  Same for isa_try_new() and usb_try_new().
> 
> A comment in hw/i2c/i2c.h mentions i2c_slave_try_new(), but it doesn't
> exist, and never has.  Suggest to eliminate that, too.
> 
> > In other cases, the desired semantics are clearer to understand if the
> > caller directly checks module_object_class_by_name(), before calling
> > the regular qdev_new (or specialized equiv) function.
> 
> This tacitly assumes qdev_try_new() & friends fail exactly when
> module_object_class_by_name() fails.  True, but not obvious at this
> point.
> 
> It's true, because it also fails exactly when type_get_or_load_by_name()
> returns null:
> 
>     ObjectClass *object_class_by_name(const char *typename)
>     {
>         TypeImpl *type = type_get_by_name_noload(typename);
> 
>         if (!type) {
>             return NULL;
>         }
> 
>         type_initialize(type);
> 
>         return type->class;
>     }
> 


> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f9147fecbd..d668970bee 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -596,9 +596,11 @@ static gboolean pc_init_ne2k_isa(ISABus *bus, NICInfo *nd, Error **errp)
> >                     "maximum number of ISA NE2000 devices exceeded");
> >          return false;
> >      }
> > -    isa_ne2000_init(bus, ne2000_io[nb_ne2k],
> > -                    ne2000_irq[nb_ne2k], nd);
> > -    nb_ne2k++;
> > +    if (module_object_class_by_name(TYPE_ISA_NE2000)) {
> > +        isa_ne2000_init(bus, ne2000_io[nb_ne2k],
> > +                        ne2000_irq[nb_ne2k], nd);
> > +        nb_ne2k++;
> > +    }
> 
> This gave me pause until I saw the change to isa_ne2000_init() below.
> There, you replace isa_try_new() by isa_new().  Before the patch,
> isa_ne2000_init() can fail, afterwards it treats errors as fatal.  And
> that's why you need to guard against failure here.
> 
> In other words, you lifted the guard out of isa_ne2000_init() into its
> sole caller.  Fine, just less than obvious in review.

Yeah, actually this is a pre-existing bug I should fix in a
preceeding patch.  isa_ne2000_init can fail today, but we
don't check the return value, and unconditionally do
"nb_ne2k++". So nb_ne2k is wrong if isa_ne2000_init ever
fails. Not sure if this has any bad functional effect,
but conceptually it is clearly a bug.

> 
> >      return true;
> >  }
> >  
> > @@ -1087,7 +1089,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
> >      int i;
> >      DriveInfo *fd[MAX_FD];
> >      qemu_irq *a20_line;
> > -    ISADevice *i8042, *port92, *vmmouse;
> > +    ISADevice *i8042, *port92, *vmmouse = NULL;
> >  
> >      serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
> >      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> > @@ -1117,9 +1119,9 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
> >      i8042 = isa_create_simple(isa_bus, TYPE_I8042);
> >      if (!no_vmport) {
> >          isa_create_simple(isa_bus, TYPE_VMPORT);
> > -        vmmouse = isa_try_new("vmmouse");
> > -    } else {
> > -        vmmouse = NULL;
> > +        if (module_object_class_by_name("vmmouse")) {
> > +            vmmouse = isa_new("vmmouse");
> > +        }
> >      }
> >      if (vmmouse) {
> >          object_property_set_link(OBJECT(vmmouse), TYPE_I8042, OBJECT(i8042),
> 
> This is now like
> 
>        vmmouse = NULL;
>        if (...) {
>            if (module_object_class_by_name("vmmouse")) {
>                vmmouse = isa_new("vmmouse");
>            }
>        }
>        if (vmmouse) {
>            object_property_set_link(OBJECT(vmmouse), TYPE_I8042, OBJECT(i8042),
>                                     &error_abort);
>            isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
>        }
> 
> We could straighten control flow like this:
> 
>        if (...) {
>            if (module_object_class_by_name("vmmouse")) {
>                vmmouse = isa_new("vmmouse");
>                object_property_set_link(OBJECT(vmmouse), TYPE_I8042,
>                                         OBJECT(i8042), &error_abort);
>                isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
>            }
>        }
> 
> But there is a more fundamental issue.
> 
> pc_superio_init() creates onboard devices.
> 
> With CONFIG_MODULES off, it creates a "vmmouse" device exactly when the
> type is compiled into this binary.  This makes the guest machine type
> depend on build configuration.  I consider this questionable; I'd prefer
> such things to be explicit in the C code.  But let's ignore this.

Yeah, I had the same horrified realization that we'd made machine ABI
vary based on installed pkgs :-( Not sure how to get us out of that
mess easily.

> Silently not creating it just because the machine is in a funny state,
> say temporarily lacks the resources to load a DSO, is plainly wrong.
> 
> Not this patch's fault.  Doesn't make it less wrong :)

Agreed, we definitely need to distinguish "module not installed",
from all other types of failure to load a module.

> > @@ -1163,11 +1165,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
> >      if (pcms->hpet_enabled) {
> >          qemu_irq rtc_irq;
> >  
> > -        hpet = qdev_try_new(TYPE_HPET);
> > -        if (!hpet) {
> > -            error_report("couldn't create HPET device");
> > -            exit(1);
> > -        }
> > +        hpet = qdev_new(TYPE_HPET);
> 
> This replaces the error message "couldn't create HPET device" by one
> provided by QOM.  These are:
> 
> * When the type is not known to this binary: "unknown type 'hpet'".
> 
> * When the type is known, but not compiled in, and the module can't be
>   loaded for whatever reason: "could not load a module for type 'hpet':
>   MORE", where MORE is the error message provided by module_load_qom().
> 
> Worth at least hinting at this in the commit message?

Sure.




> > diff --git a/include/hw/usb.h b/include/hw/usb.h
> > index d46d96779a..bb778cb844 100644
> > --- a/include/hw/usb.h
> > +++ b/include/hw/usb.h
> > @@ -584,11 +584,6 @@ static inline USBDevice *usb_new(const char *name)
> >      return USB_DEVICE(qdev_new(name));
> >  }
> >  
> > -static inline USBDevice *usb_try_new(const char *name)
> > -{
> > -    return USB_DEVICE(qdev_try_new(name));
> > -}
> > -
> >  static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
> >  {
> >      return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
> 
> Maybe I'm having another scatter-brained day, but I found the patch
> somewhat confusing in review.  Happy to suggest a possible split if
> you're interested.

I can have another think about changing it. Mostly I was just working
backwards when creating this, by deleting the methods I wanted to
remove and the patching up the build failures, so there wasn't much
thought put into the split of this one.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


