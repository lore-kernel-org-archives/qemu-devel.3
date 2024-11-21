Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D544E64002
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 18:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEBX0-0000R1-16; Thu, 21 Nov 2024 13:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEBWy-0000Pw-RT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEBWv-0003QU-Sh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732212227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voKOFuuSe4kVVNDvzE4zcOkzQFmCC8UkE0e0u6FGJjs=;
 b=LI6QfUB63UpUWxZUUp07mAD3KmnPzRVzUiLlL4sMwi1HOWFPg/UEzFVBxa5yRAsXUAFoAs
 i5TFcDewOzUf/HidMZYAKqaVxUjeCjiOeKmWgMB1FuD44YG95AeikQLRYbPMpJsuvBy32P
 ERvqASrnq0cgXG3VqtKCbYSozRv2vI0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-T03RWiI7OcWT7MJzCriYDA-1; Thu, 21 Nov 2024 13:03:44 -0500
X-MC-Unique: T03RWiI7OcWT7MJzCriYDA-1
X-Mimecast-MFC-AGG-ID: T03RWiI7OcWT7MJzCriYDA
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-71a99fcee54so1078052a34.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 10:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732212224; x=1732817024;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=voKOFuuSe4kVVNDvzE4zcOkzQFmCC8UkE0e0u6FGJjs=;
 b=gBuG6dEsOtZaBgykuL27NpsorVJcuIn7t7bIxXRt/FHNvJx22FMKC/X0PrHPVZCqSM
 +kRGnNT8JPvusgxeOkon8hEEsHR3rXAoPCT/HBVGG6j3Yyz12m1P9XsBYoX7Q4SR6yy2
 RsDLaD4d7GVe2Tno9f8kXPn57T0XZgt90r6EYEeKB4drKSdHEN8RbBOpaAlPvMwfrGwX
 c18RWqdtB/IOT/wOL7ivU1+i0QRDHtGdZ9t6akLfTtt+B3rtjfOZE8DiSdyaANvb1ZUw
 KerCvmEQB1C9+8tCXiUDSIWPAijBzMjcSm1exsvLfI2o9V6HyXSzmiDeh9FCsdJWIYh7
 IVkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoCpjRHGRnCMIcetTsTpzNR/ak/3erl/ihrAKBiruekN3hFv8qykSHh+3L0uwQKKgxhG64QmNTMP1x@nongnu.org
X-Gm-Message-State: AOJu0YzEkOhLPuSYWdA9qejHJOitnwTTDebDH2LBD+xhh+GXk7wg7YJk
 FDEKonGTCYVDX2VpF4sCh9DRtaOCWNkBuo+dmHiz+SEo1zMjcPIboicRq3DqeaOY20WkdSpGcyz
 3GfEZtEk/P0qwFmRGVpLl5TPIkdAdZ9mRNjBCzNhG8N2wwmACJwVF
X-Gm-Gg: ASbGncvJ9sxmyvYIg2Mb/U/86j6F5wfcF8HcZWMh6gFeAJVMkavZeX9UcQYz3Oll6f8
 JkyiNy6zaOyIz41sIjMY0OLPGLuSEWM9MTUtrsOJ2x8vTf5FSR1bNR3UyzRq0zy/4XZvovx1whB
 Qe5pzc2dxaADFOTTcLK2wtnZwbZy4zO9YWSqCF7nD4fEXAZmjtxjG7dRM4fT9g3l6UMKFT2XW1U
 QTBXP3pegvKNEYVxx51MJ6wVNDT6tYiLBlgkMgqomu8EikHY70TUer6nmq5DZChB5iLCYruDO9I
 R4d5SGVfRac=
X-Received: by 2002:a05:6830:6a97:b0:710:ea11:3d34 with SMTP id
 46e09a7af769-71ab3190062mr9555646a34.12.1732212223652; 
 Thu, 21 Nov 2024 10:03:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZJ+cVPIckmKzvO4OH4h5wNriPPe46k1YdHEEb5huk6aDYYSnLBNYAtYcfu4Vwq+JyoQ7s2g==
X-Received: by 2002:a05:6830:6a97:b0:710:ea11:3d34 with SMTP id
 46e09a7af769-71ab3190062mr9555606a34.12.1732212223199; 
 Thu, 21 Nov 2024 10:03:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe4f8ecsm73555173.67.2024.11.21.10.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 10:03:42 -0800 (PST)
Date: Thu, 21 Nov 2024 13:03:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
Message-ID: <Zz91_IoN0e5E0v2k@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com>
 <Zz8LwhXsa6ail5qo@redhat.com>
 <64d02784-adde-459a-a019-10cdca93734f@linaro.org>
 <Zz9rDA_xlgweZzeP@x1n>
 <c68b260a-b4ee-48ec-9f5c-3c72a58f424b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c68b260a-b4ee-48ec-9f5c-3c72a58f424b@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 21, 2024 at 06:29:06PM +0100, Philippe Mathieu-Daudé wrote:
> On 21/11/24 18:17, Peter Xu wrote:
> > On Thu, Nov 21, 2024 at 02:01:45PM +0100, Philippe Mathieu-Daudé wrote:
> > > On 21/11/24 11:30, Daniel P. Berrangé wrote:
> > > > On Wed, Nov 20, 2024 at 04:57:01PM -0500, Peter Xu wrote:
> > > > > Always explicitly create QEMU system containers upfront.
> > > > > 
> > > > > Root containers will be created when trying to fetch the root object the
> > > > > 1st time.  Machine sub-containers will be created only until machine is
> > > > > being initialized.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >    hw/core/machine.c | 19 ++++++++++++++++---
> > > > >    qom/object.c      | 16 +++++++++++++++-
> > > > >    2 files changed, 31 insertions(+), 4 deletions(-)
> > > > 
> > > > 
> > > > > diff --git a/qom/object.c b/qom/object.c
> > > > > index 214d6eb4c1..810e6f2bd9 100644
> > > > > --- a/qom/object.c
> > > > > +++ b/qom/object.c
> > > > > @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
> > > > >        return prop->type;
> > > > >    }
> > > > > +static Object *object_root_initialize(void)
> > > > > +{
> > > > > +    Object *root = object_new(TYPE_CONTAINER);
> > > > > +
> > > > > +    /*
> > > > > +     * Create all QEMU system containers.  "machine" and its sub-containers
> > > > > +     * are only created when machine initializes (qemu_create_machine()).
> > > > > +     */
> > > > > +    container_create(root, "chardevs");
> > > > > +    container_create(root, "objects");
> > > > 
> > > > This is where I would expect 'backend' to have been created
> > > > rather than ui/console.c, though you could potentially make
> > > > a case to create it from the machine function, snice console
> > > > stuff can't be used outside of the machine context, while
> > > > chardevs/objects can be used in qemu-img/qemu-nbd, etc
> > 
> > Would it hurt if we do it altogether here even if it won't be used in
> > qemu-img/qemu-nbd?
> > 
> > IMHO we should either make it simple (assuming empty containers won't hurt
> > there..), or we should just leave "backend" to ui/ code, so we don't assume
> > which binary is using the ui code: whoever uses it will create the container.
> > 
> > > 
> > > What about creating "backend" container in qemu_create_machine()?
> > 
> > I remember I started with that but it didn't work.  IIRC that's because
> > machine_initfn() (or somewhere around the init code) requires the
> > containers to present, hence it's too late even if we create the containers
> > right after this line:
> > 
> >      current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
> 
> So qemu_create_machine_containers() really belongs to qemu_create_machine()
> =)

Frankly, I don't immediately get this line..

But when I was trying again just to check my memory, I can't see anything
crash anymore, moving things over.

So while I'll test some more, I can switch to that if I cannot reproduce
any issue with it.  That's:

===8<===

diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed613ec4cb..a72c001c3d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1193,27 +1193,11 @@ static void machine_class_base_init(ObjectClass *oc, void *data)
     }
 }
 
-static const char *const machine_containers[] = {
-    "unattached",
-    "peripheral",
-    "peripheral-anon"
-};
-
-static void qemu_create_machine_containers(Object *machine)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
-        object_property_add_new_container(machine, machine_containers[i]);
-    }
-}
-
 static void machine_initfn(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
 
-    qemu_create_machine_containers(obj);
     ms->dump_guest_core = true;
     ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
     ms->enable_graphics = true;
diff --git a/system/vl.c b/system/vl.c
index 822f7ff656..cdc0b6e10c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2112,6 +2112,21 @@ static void parse_memory_options(void)
     loc_pop(&loc);
 }
 
+static const char *const machine_containers[] = {
+    "unattached",
+    "peripheral",
+    "peripheral-anon"
+};
+
+static void qemu_create_machine_containers(Object *machine)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
+        object_property_add_new_container(machine, machine_containers[i]);
+    }
+}
+
 static void qemu_create_machine(QDict *qdict)
 {
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
@@ -2120,6 +2135,7 @@ static void qemu_create_machine(QDict *qdict)
     current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
+    qemu_create_machine_containers(OBJECT(current_machine));
     object_property_add_child(machine_get_container("unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
 

-- 
Peter Xu


