Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55227CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ53D-0005QJ-6N; Mon, 15 Jun 2026 07:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ52q-0005Oh-4V
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ52j-0004It-0Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781521188;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8wwHLqbzfSNkH92AfQaFNRBH8xT61SWI7BQvKQSf4ck=;
 b=ayWCFy1mKW4aJR2Xxp0+rvR52kk8jrepNfXiVjYIbkS3stotR6tVTTaGruOanvQ+JZPH2D
 r2qSEVSlLGeS5ZQZE+N3YVPI3yIN1fKwq5/iv5SHSiIUcvDjYBCfutcHcvvrUlT5hwvE9M
 gKnTLK+qsyGOpUssRi5QYdw2grOTO2U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-Hi0JbGCcOKu-nca26aI3rw-1; Mon,
 15 Jun 2026 06:59:39 -0400
X-MC-Unique: Hi0JbGCcOKu-nca26aI3rw-1
X-Mimecast-MFC-AGG-ID: Hi0JbGCcOKu-nca26aI3rw_1781521178
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F4BD1800378; Mon, 15 Jun 2026 10:59:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.222])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 566EA1955BD4; Mon, 15 Jun 2026 10:59:33 +0000 (UTC)
Date: Mon, 15 Jun 2026 11:59:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
Message-ID: <ai_bEg7Qo_6kQ2Zq@redhat.com>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 15, 2026 at 01:11:07PM +0900, Akihiko Odaki wrote:
> One concrete case is qemu-xhci: XHCIPciState embeds XHCIState as a
> child object, and the embedded XHCIState owns the MemoryRegion used for
> PCI BAR 0. When memory core references that region, memory_region_ref()
> references the embedded XHCIState owner, but that does not keep the
> containing XHCIPciState storage alive across runtime unplug.

Taking this example and looking at the patch,

Immediately after XHCIPciState is allocated, we'll have the
following XHCIPciState QOM state:

   free == object_free
   storage == <undefined>
   ref == 1
   storage_ref == 1   <up-ref from XHCIState>

Meanwhile XHCIState is embedded and so after construction it
has

   free == <undefined>
   storage == ptr<XHCIPciState>
   ref == 1
   storage_ref == UINT32_MAX


The simple scenario, no 3rd party refs on XHCIState, then we
have a flow that looks like this:

  object_unref(XHCIPciState)
   => ref == 0
       => object_finalize(XHCIPciState)
           => object_unref(XHCIState)
	       => ref == 0
	       => object_storage_unref(XHCIState)
	            => obj = obj.storage
	            => XHCIPciState.storage_ref--
	            => XHCIPciState.storage_ref == 0
                    => object_free(XHCIPciState)
       => Remainder of ...object_finalize(XHCIPciState) is
          using free'd mem now...

This doesn't seem to work AFAICS ?

Now lets consider something took a reference on XHCIState
first.

  object_ref(XHCIState)
  object_unref(XHCIPciState)
   => ref == 0
       => object_finalize(XHCIPciState)
           => object_unref(XHCIState)
	       => ref == 1
       => object_storage_unref(XHCIPciState)
          => storage_ref--
          => storage_ref == 0
              => object_free(XHCIPciState)

  object_unref(XHCIState)
   => ref == 0
   => object_storage_unref(XHCIPciState)
      => storage_ref == -1

Again this doesn't seem to actually work as billed ?


For the sake of argument though, lets say this storage_ref
was handled correctly such that we delay free'ing the
XHCIPciState memory  until *both*  XHCIPciState and
XHCIState have hit ref == 0, and both their finalize
methods are completed.

I'm still not convinced this would actually be safe.

This patch is delaying the free'ing of the memory that
XHCIState is embedded in, but is the embedded XHCIState
still functional enough when its parent and all sibling
objects will have been finalized already ? That is not
obviously ok to me. The "XHCIPciState" will have been
finalized, but all its fields are mostly pointing to
data that has been deinitialized. Can we really assume
there are no dependencies between the embedded objects ?


Conceptually it feels like finalization of XHCIPciState
ought to be an all-or-nothing affair, rather than
finalizing XHCIPciState and some of its embedded children
but arbtirarily keeping other children alive. I'm not
sure how to arrange that though - its essentially a need
for a circular reference, but then how/when do you break
it.

> diff --git a/include/qom/object.h b/include/qom/object.h
> index c4dcf65dcf7f..b5d656e3758c 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -155,8 +155,12 @@ struct Object
>  {
>      /* private: */
>      ObjectClass *class;
> -    ObjectFree *free;
> +    union {
> +        ObjectFree *free;
> +        Object *storage;
> +    };
>      GHashTable *properties;
> +    uint32_t storage_ref;
>      uint32_t ref;
>      Object *parent;
>  };
> @@ -613,7 +617,7 @@ struct InterfaceClass
>   * @klass: The class to instantiate.
>   *
>   * This function will initialize a new object using heap allocated memory.
> - * The returned object has a reference count of 1, and will be freed when
> + * The returned object has a reference count of 1, and will be finalized when
>   * the last reference is dropped.
>   *
>   * Returns: The newly allocated and instantiated object.
> @@ -625,7 +629,7 @@ Object *object_new_with_class(ObjectClass *klass);
>   * @typename: The name of the type of the object to instantiate.
>   *
>   * This function will initialize a new object using heap allocated memory.
> - * The returned object has a reference count of 1, and will be freed when
> + * The returned object has a reference count of 1, and will be finalized when
>   * the last reference is dropped.
>   *
>   * Returns: The newly allocated and instantiated object.
> @@ -641,7 +645,7 @@ Object *object_new(const char *typename);
>   * @...: list of property names and values
>   *
>   * This function will initialize a new object using heap allocated memory.
> - * The returned object has a reference count of 1, and will be freed when
> + * The returned object has a reference count of 1, and will be finalized when
>   * the last reference is dropped.
>   *
>   * The @id parameter will be used when registering the object as a
> @@ -1120,8 +1124,8 @@ GSList *object_class_get_list_sorted(const char *implements_type,
>   * object_ref:
>   * @obj: the object
>   *
> - * Increase the reference count of a object.  A object cannot be freed as long
> - * as a reference remains.
> + * Increase the reference count of a object.  A object cannot be finalized as
> + * long as a reference remains.
>   * Returns: @obj
>   */
>  Object *object_ref(void *obj);
> @@ -1130,11 +1134,30 @@ Object *object_ref(void *obj);
>   * object_unref:
>   * @obj: the object
>   *
> - * Decrease the reference count of a object.  A object cannot be freed as long
> - * as a reference remains.
> + * Decrease the reference count of a object.  A object cannot be finalized as
> + * long as a reference remains.
>   */
>  void object_unref(void *obj);
>  
> +/**
> + * object_storage_ref:
> + * @obj: the object
> + *
> + * Increase the reference count of a object's storage.  A object cannot be
> + * freed as long as its storage is referenced.
> + * Returns: the object that provides the storage
> + */
> +Object *object_storage_ref(void *obj);
> +
> +/**
> + * object_storage_unref:
> + * @obj: the object
> + *
> + * Decrease the reference count of a object's storage.  A object cannot be
> + * freed as long as its storage is referenced.
> + */
> +void object_storage_unref(void *obj);
> +
>  /**
>   * object_property_try_add:
>   * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index 761eff1337e6..0a2c7ce9710d 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -487,7 +487,8 @@ static void object_class_property_init_all(Object *obj)
>      }
>  }
>  
> -static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type)
> +static void object_initialize_with_type(Object *obj, size_t size,
> +                                        TypeImpl *type, Object *storage)
>  {
>      type_initialize(type);
>  
> @@ -496,6 +497,10 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
>      g_assert(size >= type->instance_size);
>  
>      memset(obj, 0, type->instance_size);
> +    if (storage) {
> +        obj->storage_ref = UINT32_MAX;
> +        obj->storage = object_storage_ref(storage);
> +    }
>      obj->class = type->class;
>      object_class_property_init_all(obj);
>      obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
> @@ -508,7 +513,7 @@ void object_initialize(void *data, size_t size, const char *typename)
>  {
>      TypeImpl *type = type_get_or_load_by_name(typename, &error_fatal);
>  
> -    object_initialize_with_type(data, size, type);
> +    object_initialize_with_type(data, size, type, NULL);
>  }
>  
>  bool object_initialize_child_with_props(Object *parentobj,
> @@ -531,14 +536,15 @@ bool object_initialize_child_with_props(Object *parentobj,
>  bool object_initialize_child_with_propsv(Object *parentobj,
>                                           const char *propname,
>                                           void *childobj, size_t size,
> -                                         const char *type,
> +                                         const char *typename,
>                                           Error **errp, va_list vargs)
>  {
> +    TypeImpl *type = type_get_or_load_by_name(typename, &error_fatal);
>      bool ok = false;
>      Object *obj;
>      UserCreatable *uc;
>  
> -    object_initialize(childobj, size, type);
> +    object_initialize_with_type(childobj, size, type, parentobj);
>      obj = OBJECT(childobj);
>  
>      if (!object_set_propv(obj, vargs, errp)) {
> @@ -667,9 +673,7 @@ static void object_finalize(void *data)
>      object_deinit(obj, ti);
>  
>      g_assert(obj->parent == NULL);
> -    if (obj->free) {
> -        obj->free(obj);
> -    }
> +    object_storage_unref(obj);
>  }
>  
>  /* Find the minimum alignment guaranteed by the system malloc. */
> @@ -708,7 +712,7 @@ static Object *object_new_with_type(Type type)
>          obj_free = qemu_vfree;
>      }
>  
> -    object_initialize_with_type(obj, size, type);
> +    object_initialize_with_type(obj, size, type, NULL);
>      obj->free = obj_free;
>  
>      trace_object_new(obj, obj->class->type->name);
> @@ -1334,6 +1338,46 @@ void object_unref(void *objptr)
>      }
>  }
>  
> +Object *object_storage_ref(void *objptr)
> +{
> +    Object *obj = OBJECT(objptr);
> +    uint32_t ref;
> +
> +    if (!obj) {
> +        return NULL;
> +    }
> +
> +    while (qatomic_read(&obj->storage_ref) == UINT32_MAX) {
> +        obj = obj->storage;
> +    }
> +
> +    ref = qatomic_fetch_inc(&obj->storage_ref);
> +    /* Assert waaay before the integer overflows */
> +    g_assert(ref < INT_MAX);
> +    return obj;
> +}
> +
> +void object_storage_unref(void *objptr)
> +{
> +    Object *obj = OBJECT(objptr);
> +    uint32_t ref;
> +
> +    if (!obj) {
> +        return;
> +    }
> +
> +    while (qatomic_read(&obj->storage_ref) == UINT32_MAX) {
> +        obj = obj->storage;
> +    }
> +
> +    ref = qatomic_fetch_dec(&obj->storage_ref);
> +    g_assert(ref < INT_MAX);
> +
> +    if (ref == 0 && obj->free) {
> +        obj->free(obj);
> +    }
> +}
> +
>  ObjectProperty *
>  object_property_try_add(Object *obj, const char *name, const char *type,
>                          ObjectPropertyAccessor *get,
> diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
> index cc00ddcfc988..34f7fff64083 100644
> --- a/rust/qom/src/qom.rs
> +++ b/rust/qom/src/qom.rs
> @@ -809,8 +809,8 @@ impl<T: ObjectType> Owned<T> {
>      /// # Safety
>      ///
>      /// The caller must indeed own a reference to the QOM object.
> -    /// The object must not be embedded in another unless the outer
> -    /// object is guaranteed to have a longer lifetime.
> +    /// The object's implementation must guarantee functionality as long as it
> +    /// is referenced.
>      ///
>      /// A raw pointer obtained via [`Owned::into_raw()`] can always be passed
>      /// back to `from_raw()` (assuming the original `Owned` was valid!),
> @@ -836,8 +836,8 @@ pub fn into_raw(src: Owned<T>) -> *mut T {
>      ///
>      /// # Safety
>      ///
> -    /// The object must not be embedded in another, unless the outer
> -    /// object is guaranteed to have a longer lifetime.
> +    /// The object's implementation must guarantee functionality as long as it
> +    /// is referenced.
>      pub unsafe fn from(obj: &T) -> Self {
>          unsafe {
>              object_ref(obj.as_object_mut_ptr().cast::<c_void>());
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


