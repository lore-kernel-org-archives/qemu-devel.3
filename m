Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA85606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CBaX7RC7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYDM-0004qr-BM; Wed, 04 Nov 2026 05:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOYDK-0004qY-Ex
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xOYDH-0006ZY-Fn
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 05:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793788042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jpn3AwUU0btSO5K7YghQB/hvFnfZeeBwyDO9YvMQTZo=;
 b=CBaX7RC7hOrJzZXdhxiLBzqstfhqvFa9k7nIqs+UawL80UtdAWBVlJm4cmjuSUABgNpql8
 WggaxeSOz4g6Y7dxiRYNourlxwM+Brq/k2vz61cEokM8A6t9SWQ4RpfXdz0vsO4d4MkfXM
 s+1WA1K7ynBr13+Lzdp0ovaRjgcijmo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-bQcWz3eBN1CnEfi44n-tOA-1; Wed,
 04 Nov 2026 05:27:15 -0500
X-MC-Unique: bQcWz3eBN1CnEfi44n-tOA-1
X-Mimecast-MFC-AGG-ID: bQcWz3eBN1CnEfi44n-tOA_1793788031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD4431956053
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2026 10:27:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7B9618004E9; Wed,  4 Nov 2026 10:27:09 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] qdev: Convert array properties to QAPI-aware
 registration
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261104083816.1120306-2-armbru@redhat.com>
References: <20261104083816.1120306-1-armbru@redhat.com>
 <20261104083816.1120306-2-armbru@redhat.com>
Date: Wed, 04 Nov 2026 14:27:04 +0400
Message-Id: <179378802492.1846855.7084872407822363552.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12535;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J/YLyMmj0FRWHDC1DR15kXgt9Kn+GdLnK60vxmEJ2w8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6wh6jGGcWJCPmbH8zfIvRXxfzLC2gXjVzmeel
 dNFoIbeNiqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCausIegAKCRDa6OEJdZac
 5e7ED/42AVT5Yl1WGr4OTVKxu1XpAJqOSHAWnyqxHm2PFcDHDVVCzM05pEzuhrY0PcGZAZ6tCZT
 u1SAZOETmlNOmtaoNG6mLk2lHIBWdH444t1H2AT2rKPDSLtrXTH1BqRgyioxXpIHtLwD5VKpliU
 VZre4vJgRDtRIA3lCu9APuVqSHNA5JUz4hagsV9WoVh/3JUn0PHVx//KZjfAprJDGgPZh6OUzIx
 FACrgdxPKf+rRsg5B4UGABYYe05vDhgWcsqKQPsVK9tTINe8fxyjbe03NE7clLsjp1kA/fsYElT
 gyC1/SbYwpEv+FpVOXJ/Nyhv7Er1dmMfha+Whrm5uENhxBdRFbVZzlAtYvEz8YiKZxZkYI2dQ7P
 6CnK5VEYqOgknt7MpvD1G/dDVbCoIunRep5H5BQDfEnbzB2jpurC8/TNb4YGfdYLyrMw7a9fQK+
 Spio7v3kzjZ1j04bbR0RRmYWM/vjcXGcgDVhtpsyCpAIkZ9hAQUt+OfzvDEaA+zY6VWSeTaMxY+
 qNTgsrvCU9d15i9myojgX2Lziz0GoGLeYn8MwpsgFmAW7XBtnq3J7Rr68TRnCuOjkxRhloBj5aQ
 LHnKxZUN7jKeHtVdi+LkQHos5g4KhuKN76a5k2oIiX/JSPZoO51mZ52ziDs98VDpzdSZ/I4zHGH
 2DSEY0WyqbXf8UA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add element_info and element_size fields to PropertyInfo.
> 
> Add typed array PropertyInfo definitions. Each one knows its element
> type at compile time through the new element_info and element_size
> fields of PropertyInfo.
> 
> Update DEFINE_PROP_ARRAY() to use them instead of the generic
> qdev_prop_array.
> 
> Use PropertyInfo fields element_info and element_size instead of
> Property fields arrayinfo and arrayfieldsize.  Remove arrayinfo and
> arrayfieldsize.
> 
> Infrastructure changes:
> - Make get_prop_array, set_prop_array, release_prop_array, and
>   default_prop_array non-static so they can be used by
>   DEFINE_PROP_ARRAY_INFO in other translation units
> - Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20261104083816.1120306-2-armbru@redhat.com>
> ---
>  hw/core/qdev-prop-internal.h             | 19 +++++++
>  hw/display/apple-gfx.h                   |  1 +
>  include/hw/core/qdev-properties-system.h |  2 +
>  include/hw/core/qdev-properties.h        | 23 +++++----
>  hw/core/qdev-properties-system.c         |  6 +++
>  hw/core/qdev-properties.c                | 64 ++++++++++++++----------
>  hw/display/apple-gfx.m                   |  6 +++
>  7 files changed, 85 insertions(+), 36 deletions(-)
>
> diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
> index d7b77844fe0b..4f89964c8fc8 100644
> --- a/hw/core/qdev-prop-internal.h
> +++ b/hw/core/qdev-prop-internal.h
> @@ -25,4 +25,23 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
>  void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp);
>  
> +void get_prop_array(Object *obj, Visitor *v, const char *name,
> +                    void *opaque, Error **errp);
> +void set_prop_array(Object *obj, Visitor *v, const char *name,
> +                    void *opaque, Error **errp);
> +void release_prop_array(Object *obj, const char *name, void *opaque);
> +void default_prop_array(ObjectProperty *op, const Property *prop);
> +
> +#define DEFINE_PROP_ARRAY_INFO(_prop_info, _c_type, _type_info) \
> +    {                                                           \
> +        .type = "list",                                         \
> +        .qapi_type = (_type_info),                              \
> +        .element_info = &(_prop_info),                          \
> +        .element_size = sizeof(_c_type),                        \
> +        .get = get_prop_array,                                  \
> +        .set = set_prop_array,                                  \
> +        .release = release_prop_array,                          \
> +        .set_default_value = default_prop_array,                \
> +    }
> +
>  #endif
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 4d605c205615..923afa5cf354 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -489,6 +489,8 @@ const PropertyInfo qdev_prop_netdev = {
>      .set   = set_netdev,
>  };
>  
> +const PropertyInfo qdev_prop_netdev_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_netdev, NICPeers, &strList_type_info);
>  
>  /* --- audiodev --- */
>  static void get_audiodev(Object *obj, Visitor *v, const char* name,
> @@ -840,6 +842,10 @@ const PropertyInfo qdev_prop_reserved_region = {
>      .set   = set_reserved_region,
>  };
>  
> +const PropertyInfo qdev_prop_reserved_region_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_reserved_region, ReservedRegion,
> +                           &strList_type_info);
> +
>  /* --- pci address --- */
>  
>  /*
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index e2ea8945956c..7a7d4f9d7910 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -681,7 +681,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
>                                  const char *name, char *elem)
>  {
>      return (Property) {
> -        .info = parent_prop->arrayinfo,
> +        .info = parent_prop->info->element_info,
>          .name = name,
>          /*
>           * This ugly piece of pointer arithmetic sets up the offset so
> @@ -699,19 +699,21 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
>   * underlying element's property release hook for each element and free the
>   * property array.
>   */
> -static void release_prop_array(Object *obj, const char *name, void *opaque)
> +void release_prop_array(Object *obj, const char *name, void *opaque)
>  {
>      const Property *prop = opaque;
>      uint32_t *alenptr = object_field_prop_ptr(obj, prop);
>      void **arrayptr = (void *)obj + prop->arrayoffset;
>      char *elem = *arrayptr;
>      int i;
> +    const PropertyInfo *elem_info = prop->info->element_info;
> +    size_t elem_size = prop->info->element_size;
>  
> -    if (prop->arrayinfo->release) {
> +    if (elem_info->release) {
>          for (i = 0; i < *alenptr; i++) {
>              Property elem_prop = array_elem_prop(obj, prop, name, elem);
> -            prop->arrayinfo->release(obj, NULL, &elem_prop);
> -            elem += prop->arrayfieldsize;
> +            elem_info->release(obj, NULL, &elem_prop);
> +            elem += elem_size;
>          }
>      }
>  
> @@ -725,8 +727,8 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
>   * (a pointer to which is stored in the additional field described by
>   * prop->arrayoffset).
>   */
> -static void set_prop_array(Object *obj, Visitor *v, const char *name,
> -                           void *opaque, Error **errp)
> +void set_prop_array(Object *obj, Visitor *v, const char *name,
> +                    void *opaque, Error **errp)
>  {
>      ERRP_GUARD();
>      const Property *prop = opaque;
> @@ -734,6 +736,8 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
>      void **arrayptr = (void *)obj + prop->arrayoffset;
>      ArrayElementList *list, *elem, *next;
>      const size_t size = sizeof(*list);
> +    const PropertyInfo *elem_info = prop->info->element_info;
> +    size_t elem_size = prop->info->element_size;
>      char *elemptr;
>      bool ok = true;
>  
> @@ -752,9 +756,9 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
>      while (elem) {
>          Property elem_prop;
>  
> -        elem->value = g_malloc0(prop->arrayfieldsize);
> +        elem->value = g_malloc0(elem_size);
>          elem_prop = array_elem_prop(obj, prop, name, elem->value);
> -        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);
> +        elem_info->set(obj, v, NULL, &elem_prop, errp);
>          if (*errp) {
>              ok = false;
>              goto out_obj;
> @@ -776,8 +780,8 @@ out_obj:
>          for (elem = list; elem; elem = next) {
>              Property elem_prop = array_elem_prop(obj, prop, name,
>                                                   elem->value);
> -            if (prop->arrayinfo->release) {
> -                prop->arrayinfo->release(obj, NULL, &elem_prop);
> +            if (elem_info->release) {
> +                elem_info->release(obj, NULL, &elem_prop);
>              }
>              next = elem->next;
>              g_free(elem->value);
> @@ -790,19 +794,19 @@ out_obj:
>       * Now that we know how big the array has to be, move the data over to a
>       * linear array and free the temporary list.
>       */
> -    *arrayptr = g_malloc_n(*alenptr, prop->arrayfieldsize);
> +    *arrayptr = g_malloc_n(*alenptr, elem_size);
>      elemptr = *arrayptr;
>      for (elem = list; elem; elem = next) {
> -        memcpy(elemptr, elem->value, prop->arrayfieldsize);
> -        elemptr += prop->arrayfieldsize;
> +        memcpy(elemptr, elem->value, elem_size);
> +        elemptr += elem_size;
>          next = elem->next;
>          g_free(elem->value);
>          g_free(elem);
>      }
>  }
>  
> -static void get_prop_array(Object *obj, Visitor *v, const char *name,
> -                           void *opaque, Error **errp)
> +void get_prop_array(Object *obj, Visitor *v, const char *name,
> +                    void *opaque, Error **errp)
>  {
>      ERRP_GUARD();
>      const Property *prop = opaque;
> @@ -812,6 +816,8 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
>      ArrayElementList *list = NULL, *elem;
>      ArrayElementList **tail = &list;
>      const size_t size = sizeof(*list);
> +    const PropertyInfo *elem_info = prop->info->element_info;
> +    size_t elem_size = prop->info->element_size;
>      int i;
>      bool ok;
>  
> @@ -819,7 +825,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
>      for (i = 0; i < *alenptr; i++) {
>          elem = g_new0(ArrayElementList, 1);
>          elem->value = elemptr;
> -        elemptr += prop->arrayfieldsize;
> +        elemptr += elem_size;
>  
>          *tail = elem;
>          tail = &elem->next;
> @@ -832,7 +838,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
>      elem = list;
>      while (elem) {
>          Property elem_prop = array_elem_prop(obj, prop, name, elem->value);
> -        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
> +        elem_info->get(obj, v, NULL, &elem_prop, errp);
>          if (*errp) {
>              goto out_obj;
>          }
> @@ -854,18 +860,24 @@ out_obj:
>      }
>  }
>  
> -static void default_prop_array(ObjectProperty *op, const Property *prop)
> +void default_prop_array(ObjectProperty *op, const Property *prop)
>  {
>      object_property_set_default_list(op);
>  }
>  
> -const PropertyInfo qdev_prop_array = {
> -    .type = "list",
> -    .get = get_prop_array,
> -    .set = set_prop_array,
> -    .release = release_prop_array,
> -    .set_default_value = default_prop_array,
> -};
> +const PropertyInfo qdev_prop_uint8_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t, &uint8List_type_info);
> +const PropertyInfo qdev_prop_uint16_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t, &uint16List_type_info);
> +const PropertyInfo qdev_prop_uint32_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t, &uint32List_type_info);
> +const PropertyInfo qdev_prop_uint64_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t, &uint64List_type_info);
> +const PropertyInfo qdev_prop_string_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *, &strList_type_info);
> +
> +const PropertyInfo qdev_prop_link_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_link, void *, NULL);

It could use &strList_type_info, since qdev_prop_link uses
&str_type_info and serialize as object-path strings.

>  
>  /* --- public helpers --- */
>  
> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
> index 3197bd853dab..652f158223c0 100644
> --- a/hw/display/apple-gfx.h
> +++ b/hw/display/apple-gfx.h
> @@ -69,6 +69,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
>                                         MemoryRegion **mapping_in_region);
>  
>  extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
> +extern const PropertyInfo qdev_prop_apple_gfx_display_mode_array;
>  
>  #endif
>  
> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> index 4db80f0b107e..f800f84aa2b5 100644
> --- a/hw/display/apple-gfx.m
> +++ b/hw/display/apple-gfx.m
> @@ -16,6 +16,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qapi/qapi-builtin-type-infos.h"
> +#include "hw/core/qdev-prop-internal.h"
>  #include "qapi/visitor.h"
>  #include "qapi/error.h"
>  #include "qemu/aio-wait.h"
> @@ -880,3 +881,8 @@ static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
>      .get   = apple_gfx_get_display_mode,
>      .set   = apple_gfx_set_display_mode,
>  };
> +
> +const PropertyInfo qdev_prop_apple_gfx_display_mode_array =
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_apple_gfx_display_mode,
> +			   AppleGFXDisplayMode,
> +			   &strList_type_info);

indented with tabs

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


