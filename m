Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDF3D1171E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4FNm-0006o9-Ms; Fri, 25 Oct 2024 04:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t4FNk-0006nt-OK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t4FNi-00014W-BF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729843752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DXFpGnr1iPie8+k/5NbVJ9fd5XbCtbLFN39vE+LyodQ=;
 b=UqIZgzMjdMx1tcjdJwfrNnkC0PYBcHzmQx5w9p08/y2Vb8zoE11gWB3k510mFRb8JDYtdj
 7dsHNwluCnqhbR+XlHU7I41btwFZP0nYeau8kwYcXDYHUC5FzxO22l0H1FSvssHqIMHE1J
 U4RU8zEx/EZE/y/0Wsxe70CGhWr6KkI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-N38NtGb-NRa8PtmlO2iEUg-1; Fri,
 25 Oct 2024 04:08:04 -0400
X-MC-Unique: N38NtGb-NRa8PtmlO2iEUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60CE91956089; Fri, 25 Oct 2024 08:08:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 711791956088; Fri, 25 Oct 2024 08:08:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A56921E6A28; Fri, 25 Oct 2024 10:07:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Igor Mammedov
 <imammedo@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
In-Reply-To: <20241024165627.1372621-2-peterx@redhat.com> (Peter Xu's message
 of "Thu, 24 Oct 2024 12:56:24 -0400")
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
Date: Fri, 25 Oct 2024 10:07:59 +0200
Message-ID: <87plnoli5c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

Peter Xu <peterx@redhat.com> writes:

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
>  qom/object.c                    |  3 +++
>  qom/object_interfaces.c         | 24 +++++++++++++++++
>  qom/qom-qmp-cmds.c              | 22 ++++++++++++---
>  system/qdev-monitor.c           |  7 +++++
>  5 files changed, 100 insertions(+), 3 deletions(-)
>
> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> index 02b11a7ef0..9b2cc0e554 100644
> --- a/include/qom/object_interfaces.h
> +++ b/include/qom/object_interfaces.h
> @@ -177,4 +177,51 @@ bool user_creatable_del(const char *id, Error **errp);
>   */
>  void user_creatable_cleanup(void);
>  
> +#define TYPE_SINGLETON "singleton"
> +
> +typedef struct SingletonClass SingletonClass;
> +DECLARE_CLASS_CHECKERS(SingletonClass, SINGLETON, TYPE_SINGLETON)
> +
> +/**
> + * SingletonClass:
> + *
> + * @parent_class: the base class
> + * @get_instance: fetch the singleton instance if it is created,
> + *                NULL otherwise.
> + *
> + * Singleton class describes the type of object classes that can only
> + * provide one instance for the whole lifecycle of QEMU.  It will fail the
> + * operation if one attemps to create more than one instance.
> + *
> + * One can fetch the single object using class's get_instance() callback if
> + * it was created before.  This can be useful for operations like QMP
> + * qom-list-properties, where dynamically creating an object might not be
> + * feasible.
> + */
> +struct SingletonClass {
> +    /* <private> */
> +    InterfaceClass parent_class;
> +    /* <public> */
> +    Object *(*get_instance)(Error **errp);
> +};
> +
> +/**
> + * object_class_is_singleton:
> + *
> + * @class: the class to detect singleton
> + *
> + * Returns: true if it's a singleton class, false otherwise.
> + */
> +bool object_class_is_singleton(ObjectClass *class);
> +
> +/**
> + * singleton_get_instance:
> + *
> + * @class: the class to fetch singleton instance
> + *
> + * Returns: the object* if the class is a singleton class and the singleton
> + *          object is created, NULL otherwise.
> + */
> +Object *singleton_get_instance(ObjectClass *class);

A non-null return value can become dangling when the object gets
destroyed.  This could conceivably happen in another thread.

The obviously safe interface would take a reference the caller must
unref when done.

> +
>  #endif
> diff --git a/qom/object.c b/qom/object.c
> index 11424cf471..ded299ae1a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -553,6 +553,9 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
>      g_assert(type->abstract == false);
>      g_assert(size >= type->instance_size);
>  
> +    /* Singleton class can only create one object */
> +    g_assert(!singleton_get_instance(type->class));
> +
>      memset(obj, 0, type->instance_size);
>      obj->class = type->class;
>      object_ref(obj);
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index e0833c8bfe..6766060d0a 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
>      object_unparent(object_get_objects_root());
>  }
>  
> +bool object_class_is_singleton(ObjectClass *class)
> +{
> +    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
> +}
> +
> +Object *singleton_get_instance(ObjectClass *class)
> +{
> +    SingletonClass *singleton =
> +        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
> +
> +    if (!singleton) {
> +        return NULL;
> +    }
> +
> +    return singleton->get_instance(&error_abort);
> +}
> +
>  static void register_types(void)
>  {
>      static const TypeInfo uc_interface_info = {
> @@ -362,7 +379,14 @@ static void register_types(void)
>          .class_size = sizeof(UserCreatableClass),
>      };
>  
> +    static const TypeInfo singleton_interface_info = {
> +        .name          = TYPE_SINGLETON,
> +        .parent        = TYPE_INTERFACE,
> +        .class_size = sizeof(SingletonClass),
> +    };
> +
>      type_register_static(&uc_interface_info);
> +    type_register_static(&singleton_interface_info);
>  }
>  
>  type_init(register_types)
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index e91a235347..ecc1cf781c 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>      ObjectProperty *prop;
>      ObjectPropertyIterator iter;
>      ObjectPropertyInfoList *prop_list = NULL;
> +    bool create;
>  
>      klass = module_object_class_by_name(typename);
>      if (klass == NULL) {
> @@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>          return NULL;
>      }
>  
> -    obj = object_new(typename);
> +    /* Avoid creating multiple instances if the class is a singleton */
> +    create = !object_class_is_singleton(klass) ||
> +        !singleton_get_instance(klass);
> +
> +    if (create) {
> +        obj = object_new(typename);

If the class is not a singleton or else if no instance exists, we create
a temporary instance.

> +    } else {
> +        obj = singleton_get_instance(klass);

If the class is a singleton and the instance exists, we use that
instead.

Any properties the instance has created dynamically after object_new()
are visible to introspection.  This is not the case when we create a
temporary instance.  Such subtle differences are problematic.  If we
decide we're okay with this one, we need to document it.

> +    }
>  
>      object_property_iter_init(&iter, obj);
>      while ((prop = object_property_iter_next(&iter))) {
> @@ -172,7 +181,9 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
>          QAPI_LIST_PREPEND(prop_list, info);
>      }
>  
> -    object_unref(obj);
> +    if (create) {
> +        object_unref(obj);
> +    }
>  
>      return prop_list;
>  }
> @@ -199,7 +210,12 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
>          return NULL;
>      }
>  
> -    if (object_class_is_abstract(klass)) {
> +    /*
> +     * Abstract classes are not for instantiations, meanwhile avoid
> +     * creating temporary singleton objects because it can cause conflicts
> +     * if there's already one created.
> +     */
> +    if (object_class_is_abstract(klass) || object_class_is_singleton(klass)) {
>          object_class_property_iter_init(&iter, klass);
>      } else {
>          obj = object_new(typename);

If the class is a singleton, we treat it as if it was abstract.  Its
instance properties, if any, are not visible in qom-list-properties.
This is a defect.  If you make an existing class with instance
properties a singleton, the defect is a regression.

> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 44994ea0e1..1310f35c9f 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -36,6 +36,7 @@
>  #include "qemu/option.h"
>  #include "qemu/qemu-print.h"
>  #include "qemu/option_int.h"
> +#include "qom/object_interfaces.h"
>  #include "sysemu/block-backend.h"
>  #include "migration/misc.h"
>  #include "qemu/cutils.h"
> @@ -643,6 +644,12 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>          return NULL;
>      }
>  
> +    if (singleton_get_instance(OBJECT_CLASS(dc))) {
> +        error_setg(errp, "Class '%s' only supports one instance",
> +                   driver);
> +        return NULL;
> +    }
> +
>      /* find bus */
>      path = qdict_get_try_str(opts, "bus");
>      if (path != NULL) {


