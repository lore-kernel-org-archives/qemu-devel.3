Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7A1C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 12:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxFY-0001YC-PY; Fri, 16 Feb 2024 07:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1raxFW-0001Xy-CL
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 07:23:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1raxFT-0000Yw-0D
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 07:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708086201;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHkkyC5jCd13dFGIl36nRTDyrMsy+KfvlViOq9kxDYE=;
 b=ARvt2bJC0fWC+4lXy7YgYETto1dWMEggENrX8yQ8yOOi1/mp6JTvHvxN1tNdLL0OE84jm9
 CMlr+vHOX5HwYjZszxAEYTjpsKleTKOfrCedsvZPpZc7jJJdNaSdgGlWX6BOY28MPTxFSU
 OojE4rmHZMP1ldFaznexQY9D++crPOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-49sX8uGwOeGBkOEQ3G9Qig-1; Fri, 16 Feb 2024 07:23:17 -0500
X-MC-Unique: 49sX8uGwOeGBkOEQ3G9Qig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9394688D543;
 Fri, 16 Feb 2024 12:23:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF184111F6;
 Fri, 16 Feb 2024 12:23:16 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:23:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [RFC PATCH] include/qom/object.h: New
 OBJECT_DEFINE_SIMPLE_TYPE{,_WITH_INTEFACES} macros
Message-ID: <Zc9Tsm8WNOkeixQc@redhat.com>
References: <20240212174925.1504899-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212174925.1504899-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 12, 2024 at 05:49:25PM +0000, Peter Maydell wrote:
> We have an OBJECT_DEFINE_TYPE_EXTENDED macro, plus several variations
> on it, which emits the boilerplate for the TypeInfo and ensures it is
> registered with the type system.  However, all the existing macros
> insist that the type being defined has its own FooClass struct, so
> they aren't useful for the common case of a simple leaf class which
> doesn't have any new methods or any other need for its own class
> struct (that is, for the kind of type that OBJECT_DECLARE_SIMPLE_TYPE
> declares).
> 
> Pull the actual implementation of OBJECT_DEFINE_TYPE_EXTENDED out
> into a new DO_OBJECT_DEFINE_TYPE_EXTENDED which parameterizes the
> value we use for the class_size field.  This lets us add a new
> OBJECT_DEFINE_SIMPLE_TYPE which does the same job as the various
> existing OBJECT_DEFINE_*_TYPE_* family macros for this kind of simple
> type, and the variant OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES for
> when the type will implement some interfaces.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've marked this RFC largely because this patch doesn't include
> any uses of the new macros. I wanted them for a series I'm currently
> working on, but I wanted to send this out early so it could have an
> extended review period and a bit more visibility than if I stuck
> it inside an 8 patch series about some other topic. (In fact, this
> is the second time I looked at the OBJECT_DEFINE_* macros and found
> they weren't suitable for the common case kind of type. The first
> time around I went back to writing the type out the old fashioned
> way, but this time I figured I'd try improving the macros.)

The macros were intended to simplify QOM boilerplate. So given that
they're not currently addressing a common use case of no-Class objects,
it makes sense to extend the macros as you suggest here.

>  docs/devel/qom.rst   |  34 +++++++++++--
>  include/qom/object.h | 114 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 117 insertions(+), 31 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 9918fac7f21..0889ca949c1 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -348,12 +348,14 @@ used. This does the same as OBJECT_DECLARE_SIMPLE_TYPE(), but without
>  the 'struct MyDeviceClass' definition.
>  
>  To implement the type, the OBJECT_DEFINE macro family is available.
> -In the simple case the OBJECT_DEFINE_TYPE macro is suitable:
> +For the simplest case of a leaf class which doesn't need any of its
> +own virtual functions (i.e. which was declared with OBJECT_DECLARE_SIMPLE_TYPE)
> +the OBJECT_DEFINE_SIMPLE_TYPE macro is suitable:
>  
>  .. code-block:: c
>     :caption: Defining a simple type
>  
> -   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> +   OBJECT_DEFINE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
>  
>  This is equivalent to the following:
>  
> @@ -370,7 +372,6 @@ This is equivalent to the following:
>         .instance_size = sizeof(MyDevice),
>         .instance_init = my_device_init,
>         .instance_finalize = my_device_finalize,
> -       .class_size = sizeof(MyDeviceClass),
>         .class_init = my_device_class_init,
>     };
>  
> @@ -385,13 +386,36 @@ This is sufficient to get the type registered with the type
>  system, and the three standard methods now need to be implemented
>  along with any other logic required for the type.
>  
> +If the class needs its own virtual methods, or has some other
> +per-class state it needs to store in its own class struct,
> +then you can use the OBJECT_DEFINE_TYPE macro. This does the
> +same thing as OBJECT_DEFINE_SIMPLE_TYPE, but it also sets the
> +class_size of the type to the size of the class struct.
> +
> +.. code-block:: c
> +   :caption: Defining a type which needs a class struct
> +
> +   OBJECT_DEFINE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
> +
>  If the type needs to implement one or more interfaces, then the
> -OBJECT_DEFINE_TYPE_WITH_INTERFACES() macro can be used instead.
> -This accepts an array of interface type names.
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES() and
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES() macros can be used instead.
> +These accept an array of interface type names. The difference between
> +them is that the former is for simple leaf classes that don't need
> +a class struct, and the latter is for when you will be defining
> +a class struct.
>  
>  .. code-block:: c
>     :caption: Defining a simple type implementing interfaces
>  
> +   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(MyDevice, my_device,
> +                                             MY_DEVICE, DEVICE,
> +                                             { TYPE_USER_CREATABLE },
> +                                             { NULL })
> +
> +.. code-block:: c
> +   :caption: Defining a type implementing interfaces
> +
>     OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
>                                        MY_DEVICE, DEVICE,
>                                        { TYPE_USER_CREATABLE },
> diff --git a/include/qom/object.h b/include/qom/object.h
> index afccd24ca7a..f52ab216cdd 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -258,6 +258,51 @@ struct Object
>      DECLARE_INSTANCE_CHECKER(InstanceType, MODULE_OBJ_NAME, TYPE_##MODULE_OBJ_NAME)
>  
>  
> +/**
> + * DO_OBJECT_DEFINE_TYPE_EXTENDED:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + * @ABSTRACT: boolean flag to indicate whether the object can be instantiated
> + * @CLASS_SIZE: size of the type's class
> + * @...: list of initializers for "InterfaceInfo" to declare implemented interfaces
> + *
> + * This is the base macro used to implement all the OBJECT_DEFINE_*
> + * macros. It should never be used directly in a source file.
> + */
> +#define DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                       MODULE_OBJ_NAME, \
> +                                       PARENT_MODULE_OBJ_NAME, \
> +                                       ABSTRACT, CLASS_SIZE, ...) \
> +    static void \
> +    module_obj_name##_finalize(Object *obj); \
> +    static void \
> +    module_obj_name##_class_init(ObjectClass *oc, void *data); \
> +    static void \
> +    module_obj_name##_init(Object *obj); \
> +    \
> +    static const TypeInfo module_obj_name##_info = { \
> +        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
> +        .name = TYPE_##MODULE_OBJ_NAME, \
> +        .instance_size = sizeof(ModuleObjName), \
> +        .instance_align = __alignof__(ModuleObjName), \
> +        .instance_init = module_obj_name##_init, \
> +        .instance_finalize = module_obj_name##_finalize, \
> +        .class_size = CLASS_SIZE, \
> +        .class_init = module_obj_name##_class_init, \
> +        .abstract = ABSTRACT, \
> +        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
> +    }; \
> +    \
> +    static void \
> +    module_obj_name##_register_types(void) \
> +    { \
> +        type_register_static(&module_obj_name##_info); \
> +    } \
> +    type_init(module_obj_name##_register_types);
> +
>  /**
>   * OBJECT_DEFINE_TYPE_EXTENDED:
>   * @ModuleObjName: the object name with initial caps
> @@ -284,32 +329,10 @@ struct Object
>  #define OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
>                                      MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
>                                      ABSTRACT, ...) \
> -    static void \
> -    module_obj_name##_finalize(Object *obj); \
> -    static void \
> -    module_obj_name##_class_init(ObjectClass *oc, void *data); \
> -    static void \
> -    module_obj_name##_init(Object *obj); \
> -    \
> -    static const TypeInfo module_obj_name##_info = { \
> -        .parent = TYPE_##PARENT_MODULE_OBJ_NAME, \
> -        .name = TYPE_##MODULE_OBJ_NAME, \
> -        .instance_size = sizeof(ModuleObjName), \
> -        .instance_align = __alignof__(ModuleObjName), \
> -        .instance_init = module_obj_name##_init, \
> -        .instance_finalize = module_obj_name##_finalize, \
> -        .class_size = sizeof(ModuleObjName##Class), \
> -        .class_init = module_obj_name##_class_init, \
> -        .abstract = ABSTRACT, \
> -        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
> -    }; \
> -    \
> -    static void \
> -    module_obj_name##_register_types(void) \
> -    { \
> -        type_register_static(&module_obj_name##_info); \
> -    } \
> -    type_init(module_obj_name##_register_types);
> +    DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                   MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
> +                                   ABSTRACT, sizeof(ModuleObjName##Class), \
> +                                   __VA_ARGS__)
>  
>  /**
>   * OBJECT_DEFINE_TYPE:
> @@ -368,6 +391,45 @@ struct Object
>                                  MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
>                                  true, { NULL })
>  
> +/**
> + * OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + *
> + * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
> + * the case of a non-abstract type, with interfaces, and with no requirement
> + * for a class struct.
> + */
> +#define OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, \
> +                                                  module_obj_name, \
> +                                                  MODULE_OBJ_NAME, \
> +                                                  PARENT_MODULE_OBJ_NAME, ...) \
> +    DO_OBJECT_DEFINE_TYPE_EXTENDED(ModuleObjName, module_obj_name, \
> +                                   MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, \
> +                                   false, 0, __VA_ARGS__)
> +
> +/**
> + * OBJECT_DEFINE_SIMPLE_TYPE:
> + * @ModuleObjName: the object name with initial caps
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + * @PARENT_MODULE_OBJ_NAME: the parent object name in uppercase with underscore
> + *                          separators
> + *
> + * This is a variant of OBJECT_DEFINE_TYPE_EXTENDED, which is suitable for
> + * the common case of a non-abstract type, without any interfaces, and with
> + * no requirement for a class struct. If you declared your type with
> + * OBJECT_DECLARE_SIMPLE_TYPE then this is probably the right choice for
> + * defining it.
> + */
> +#define OBJECT_DEFINE_SIMPLE_TYPE(ModuleObjName, module_obj_name, \
> +                                  MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME) \
> +    OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ModuleObjName, module_obj_name, \
> +        MODULE_OBJ_NAME, PARENT_MODULE_OBJ_NAME, { NULL })
> +
>  /**
>   * struct TypeInfo:
>   * @name: The name of the type.
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


