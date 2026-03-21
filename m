Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A1B1094489
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ySx-0001cz-AT; Sat, 21 Mar 2026 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ySw-0001ca-8l
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:42:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ySs-0001q1-GZ
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 11:42:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso23131315e9.3
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774107732; x=1774712532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4n0xpnHYyCtYB7qxOzXV4IUeVHVaEKMq0frjrxJ2yI=;
 b=EXNESwvWJVY/QGejLV+EMzLq6LXiOqzWb1VYLzi6nHXuGCE/DVWzu+hmkn27WXDYaW
 TYSttuI7lZe6P8nKYQTI8hbE/e8mPbcEdWyZ6xeEKggioqrroBMTOs7l6NOZp/i2u3O+
 X70MzEuedWcJuNM4mGST3M+m2kujC66/kaxPlShvZgcRUlpsW0JB9NVDPW8dOnG+OafA
 7yQ0Eft/ViTY6gR8n6a3mmjBuFo5uy/rCgeU9WStHmN1jQSdhQ2C74oAWfmxZ/TptDYG
 XuURxs1sgcsPa9e28PNZtK4b5yCJ0XXexwiWfmsy3AdqkvmVGKGdqrV6s2AdsG9xotwF
 wTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774107732; x=1774712532;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4n0xpnHYyCtYB7qxOzXV4IUeVHVaEKMq0frjrxJ2yI=;
 b=eUklcqcR7blKO+3qjI17N21txAdpOjQY01B41gYXeWlWPCzw9v48hOE5V03LUiSWLN
 waChR3EodHOlX/9LS6o9rB0GBx7mmgiCJM3Zf0RCvaqkQKzJRncBE9mJkVfBqq9sKlve
 SI1vpD2BrEPCOl3WrtwU8nWA5b2AS1DAa6Z7yTYlVJwS9A7whUyD/Zj7Mavg2rwzinad
 E/kohFOXnvi40wN/65/0FlTYBU4snE0YULTQZP/vvyi4QzkAVK2oXgmn/p2Cdu+IqQPD
 /BkXEWxtW/V6Ga7UDiOsusTGw4FNcrV/pAdYEvZU2d2nvHJu3OJmTsjfjcWNReKtBeLu
 K54A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQukq9LTqxAecKyGRqvNH+K38MdgBRNaR+UWwS1PCzzLR1HT3KGj6/R4O6tj0Ya31fsDSsHoVPi+b@nongnu.org
X-Gm-Message-State: AOJu0YzOhcu2dJ6RKVsHgevnQbkNE+h0gtMLRNQUuUUzLIskoR41sPc+
 5d7rWrgFAXyyvbq79lZn1COByNa05oZAvWODInIwLiEpIa2j/DO/h36HC8BXkBIj38M=
X-Gm-Gg: ATEYQzz4irEczqNquy8Azubdq0KgYSjqeendpYfOgjyqsePgvHz85e0SE/ci/JU/TmQ
 ilONdQPPfai4jm4oX5cVuPsc9g/NQrW21NkQ3vjgw9JsmNhTPJfKMZkEgXTnpnX2i6OT5AvBX1r
 pN68yam+tMkmeq0uceCQoIPuVMk42RNR3eWZmfJcZm5mzp3JUtkH/zT2t5bWkHNyKnesS/zMnrv
 XO9eqxLbGOLDH4/sEEZKnvPk1iW8X8euycVTc9eE71tJSh1MhcOb6dXgGE5PuCdsW4FVUJA27VD
 WDsqPa+IJhJg49Lsg8+JsFduvjokNXwWBk4WWsbb1ij4bVB0/mGTDGHcKKNIBW8fAt+OFDc47lk
 YTo6P+J5yqRsdb5Qbj99h80prudZfWDSijsdkDhY3pcUBd4gBLOcDOQ9MJqhbON3YdzJoti3bYo
 VMRoGBltsTQoISfmxCXthkVCpOQTBwmS2tpenaO/SzebEEsDW6BuAupjS1uXvvswAMLg==
X-Received: by 2002:a05:600c:a112:b0:485:3ff1:d5c5 with SMTP id
 5b1f17b1804b1-486febb5904mr72884425e9.7.1774107732051; 
 Sat, 21 Mar 2026 08:42:12 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b1fe65sm204545555e9.5.2026.03.21.08.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2026 08:42:11 -0700 (PDT)
Message-ID: <8a696b3a-f55d-4c9b-ba0b-34c5391de28b@linaro.org>
Date: Sat, 21 Mar 2026 16:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/65] hw/core: Permit devices to define an array of link
 properties
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20260223170212.441276-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

(+Kevin / Markus / Mark for previous discussions)

On 23/2/26 18:01, Peter Maydell wrote:
> Currently we allow devices to define "link properties" with
> DEFINE_PROP_LINK(): these are a way to give a device a pointer to
> another QOM object.  (Under the hood this is done by handing it the
> canonical QOM path for the object.)
> 
> We also allow devices to define "array properties" with
> DEFINE_PROP_ARRAY(): these are a way to give a device a
> variable-length array of properties.
> 
> However, there is no way to define an array of link properties.  If
> you try to do it by passing qdev_prop_link as the arrayprop argument
> to DEFINE_PROP_ARRAY() you will get a crash because qdev_prop_link
> does not provide the .set and .get methods in its PropertyInfo
> struct.
> 
> This patch implements a new DEFINE_PROP_LINK_ARRAY(). In
> a device you can use it like this:
> 
> struct MyDevice {
>      ...
>      uint32_t num_cpus;
>      ARMCPU **cpus;
> }
> 
> and in your Property array:
>      DEFINE_PROP_LINK_ARRAY("cpus", MyDevice, num_cpus, cpus,
>                             TYPE_ARM_CPU, ARMCPU *),
> 
> The array property code will fill in s->num_cpus, allocate memory in
> s->cpus, and populate it with pointers.
> 
> On the device-creation side you set the property in the same way as
> the existing array properties, using the new qlist_append_link()
> function to append to the QList:
> 
>      QList *cpulist = qlist_new();
>      for (int i = 0; i < cpus; i++) {
>          qlist_append_link(cpulist, OBJECT(cpu[i]));
>      }
>      qdev_prop_set_array(mydev, "cpus", cpulist);
> 
> The implementation is mostly in the provision of the .set and
> .get methods to the qdev_prop_link PropertyInfo struct. The
> code of these methods parallels the code in
> object_set_link_property() and object_get_link_property().  We can't
> completely share the code with those functions because of differences
> in where we get the information like the target QOM type, but I have
> pulled out a new function object_resolve_and_typecheck() for the
> shared "given a QOM path and a type, give me the object or an error"
> code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I want this specifically for the GICv5 interrupt controller device
> I'm working on.  I'd like to be able to pass in links to the CPUs
> connected to the GIC, so that we don't have to have the code assume
> that it's connected to CPU numbers 0,1,2... the way the current
> GICv3 code does.
> 
> I think Phil also had a proposed series a while back that wanted
> to do something similar with one of the existing devices.

FTR previous discussions:

https://lore.kernel.org/qemu-devel/47615329-9ae4-f9e0-117d-f7d4300bfdf1@ilande.co.uk/
https://lore.kernel.org/qemu-devel/CAFEAcA9FT+QMyQSLCeLjd7tEfaoS9JazmkYWQE++s1AmF7Nfvw@mail.gmail.com/

> 
> I figured I'd post this early for review, though obviously it's a
> little unmotivated until I have my new GICv5 code into enough shape
> to submit. This is tested, but with my work-in-progress code.
> ---
>   hw/core/qdev-properties.c         | 78 +++++++++++++++++++++++++++++++
>   include/hw/core/qdev-properties.h | 40 ++++++++++++++++
>   include/qom/object.h              | 19 ++++++++
>   qom/object.c                      | 42 ++++++++++-------
>   4 files changed, 161 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ba8461e9a4..f8181b0d91 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -669,6 +669,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
>            * being inside the device struct.
>            */
>           .offset = (uintptr_t)elem - (uintptr_t)obj,
> +        .link_type = parent_prop->link_type,
>       };
>   }
>   
> @@ -950,6 +951,12 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
>       qobject_unref(values);
>   }
>   
> +void qlist_append_link(QList *qlist, Object *obj)
> +{
> +    g_autofree char *path = object_get_canonical_path(obj);
> +    qlist_append_str(qlist, path);
> +}
> +
>   static GPtrArray *global_props(void)
>   {
>       static GPtrArray *gp;
> @@ -1059,9 +1066,80 @@ static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
>                                             OBJ_PROP_LINK_STRONG);
>   }
>   
> +/*
> + * The logic in these get_link() and set_link() functions is similar
> + * to that used for single-element link properties in the
> + * object_get_link_property() and object_set_link_property() functions.
> + * The difference is largely in how we get the expected type of the
> + * link: for us it is in the Property struct, and for a single link
> + * property it is part of the property name on the object.
> + */
> +static void get_link(Object *obj, Visitor *v, const char *name, void *opaque,
> +                     Error **errp)
> +{
> +    const Property *prop = opaque;
> +    Object **targetp = object_field_prop_ptr(obj, prop);
> +    g_autofree char *path = NULL;
> +
> +    if (*targetp) {
> +        path = object_get_canonical_path(*targetp);
> +        visit_type_str(v, name, &path, errp);
> +    } else {
> +        path = g_strdup("");
> +        visit_type_str(v, name, &path, errp);
> +    }
> +}
> +
> +static void set_link(Object *obj, Visitor *v, const char *name, void *opaque,
> +                     Error **errp)
> +{
> +    const Property *prop = opaque;
> +    Object **targetp = object_field_prop_ptr(obj, prop);
> +    g_autofree char *path = NULL;
> +    Object *new_target, *old_target = *targetp;
> +
> +    ERRP_GUARD();
> +
> +    /* Get the path to the object we want to set the link to */
> +    if (!visit_type_str(v, name, &path, errp)) {
> +        return;
> +    }
> +
> +    /* Now get the pointer to the actual object */
> +    if (*path) {
> +        new_target = object_resolve_and_typecheck(path, prop->name,
> +                                                  prop->link_type, errp);
> +        if (!new_target) {
> +            return;
> +        }
> +    } else {
> +        new_target = NULL;
> +    }
> +
> +    /*
> +     * Our link properties are always OBJ_PROP_LINK_STRONG and
> +     * have the allow_set_link_before_realize check.
> +     */
> +    qdev_prop_allow_set_link_before_realize(obj, prop->name, new_target, errp);
> +    if (*errp) {
> +        return;
> +    }
> +
> +    *targetp = new_target;
> +    object_ref(new_target);
> +    object_unref(old_target);
> +}
> +
>   const PropertyInfo qdev_prop_link = {
>       .type = "link",
>       .create = create_link_property,
> +    /*
> +     * Since we have a create method, the get and set are used
> +     * only in get_prop_array() and set_prop_array() for the case
> +     * where we have an array of link properties.
> +     */
> +    .get = get_link,
> +    .set = set_link,
>   };
>   
>   void qdev_property_add_static(DeviceState *dev, const Property *prop)
> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> index d8745d4c65..936d06023a 100644
> --- a/include/hw/core/qdev-properties.h
> +++ b/include/hw/core/qdev-properties.h
> @@ -168,6 +168,31 @@ extern const PropertyInfo qdev_prop_link;
>       DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
>                   .link_type  = _type)
>   
> +/**
> + * DEFINE_PROP_LINK_ARRAY:
> + * @_name: name of the array
> + * @_state: name of the device state structure type
> + * @_field: uint32_t field in @_state to hold the array length
> + * @_arrayfield: field in @_state (of type '@_arraytype *') which
> + *               will point to the array
> + * @_linktype: QOM type name of the link type
> + * @_arraytype: C type of the array elements
> + *
> + * Define device properties for a variable-length array _name of links
> + * (i.e. this is the array version of DEFINE_PROP_LINK).
> + * The array is represented as a list of QStrings in the visitor interface,
> + * where each string is the QOM path of the object to be linked.
> + */
> +#define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
> +                               _linktype, _arraytype)                   \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
> +                .set_default = true,                                    \
> +                .defval.u = 0,                                          \
> +                .arrayinfo = &qdev_prop_link,                           \
> +                .arrayfieldsize = sizeof(_arraytype),                   \
> +                .arrayoffset = offsetof(_state, _arrayfield),           \
> +                .link_type = _linktype)
> +
>   #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
>       DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
>   #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
> @@ -219,6 +244,21 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
>   /* Takes ownership of @values */
>   void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
>   
> +/**
> + * qlist_append_link: Add a QOM object to a QList of link properties
> + * @qlist: list to append to
> + * @obj: object to append
> + *
> + * This is a helper function for constructing a QList to pass to
> + * qdev_prop_set_array() when the qdev property array is an array of link
> + * properties (i.e. one defined with DEFINE_PROP_LINK_ARRAY).
> + *
> + * The object is encoded into the list as a QString which is the
> + * canonical path of the object; this is the same encoding that
> + * object_set_link_property() and object_get_link_property() use.
> + */
> +void qlist_append_link(QList *qlist, Object *obj);
> +
>   void *object_field_prop_ptr(Object *obj, const Property *prop);
>   
>   void qdev_prop_register_global(GlobalProperty *prop);
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 26df6137b9..48fdbf353e 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1750,6 +1750,25 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
>                                               Object *val, Error **errp),
>                                 ObjectPropertyLinkFlags flags);
>   
> +
> +/**
> + * object_resolve_and_typecheck:
> + * @path: path to look up
> + * @name: name of property we are resolving for (used only in error messages)
> + * @target_type: QOM type we expect @path to resolve to
> + * @errp: error
> + *
> + * Look up the object at @path and return it. If it does not have
> + * the correct type @target_type, return NULL and set @errp.
> + *
> + * This is similar to object_resolve_path_type(), but it insists on
> + * a non-ambiguous path and it produces error messages that are specialised
> + * to the use case of setting a link property on an object.
> + */
> +Object *object_resolve_and_typecheck(const char *path,
> +                                     const char *name,
> +                                     const char *target_type, Error **errp);
> +
>   /**
>    * object_property_add_str:
>    * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index ff8ede8a32..90b8f3461e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1895,26 +1895,13 @@ static void object_get_link_property(Object *obj, Visitor *v,
>       }
>   }
>   
> -/*
> - * object_resolve_link:
> - *
> - * Lookup an object and ensure its type matches the link property type.  This
> - * is similar to object_resolve_path() except type verification against the
> - * link property is performed.
> - *
> - * Returns: The matched object or NULL on path lookup failures.
> - */
> -static Object *object_resolve_link(Object *obj, const char *name,
> -                                   const char *path, Error **errp)
> +Object *object_resolve_and_typecheck(const char *path,
> +                                     const char *name,
> +                                     const char *target_type, Error **errp)
>   {
> -    const char *type;
> -    char *target_type;
>       bool ambiguous = false;
>       Object *target;
>   
> -    /* Go from link<FOO> to FOO.  */
> -    type = object_property_get_type(obj, name, NULL);
> -    target_type = g_strndup(&type[5], strlen(type) - 6);
>       target = object_resolve_path_type(path, target_type, &ambiguous);
>   
>       if (ambiguous) {
> @@ -1931,11 +1918,30 @@ static Object *object_resolve_link(Object *obj, const char *name,
>           }
>           target = NULL;
>       }
> -    g_free(target_type);
> -
>       return target;
>   }
>   
> +/*
> + * object_resolve_link:
> + *
> + * Lookup an object and ensure its type matches the link property type.  This
> + * is similar to object_resolve_path() except type verification against the
> + * link property is performed.
> + *
> + * Returns: The matched object or NULL on path lookup failures.
> + */
> +static Object *object_resolve_link(Object *obj, const char *name,
> +                                   const char *path, Error **errp)
> +{
> +    const char *type;
> +    g_autofree char *target_type = NULL;
> +
> +    /* Go from link<FOO> to FOO.  */
> +    type = object_property_get_type(obj, name, NULL);
> +    target_type = g_strndup(&type[5], strlen(type) - 6);
> +    return object_resolve_and_typecheck(path, name, target_type, errp);
> +}
> +
>   static void object_set_link_property(Object *obj, Visitor *v,
>                                        const char *name, void *opaque,
>                                        Error **errp)

Nitpicking, I'd add object_resolve_and_typecheck() in a preliminary
patch. Otherwise patch LGTM!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


