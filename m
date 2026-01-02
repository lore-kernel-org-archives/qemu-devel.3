Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34039FA372F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 12:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbdvF-0005tB-5W; Fri, 02 Jan 2026 07:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbdv2-0005lZ-HU
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 07:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbduz-0008Eu-O8
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 07:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767355567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9VVsM2kR1Tdg4Q9bX0R3/95PjIZcPh3A+gObY5fDrc=;
 b=CM5Zzsk1nqil5h+60ERLSCC0acytFpHLQ9DUvLdJ7/jGCSfV7yPg+T0eztRKqo0r/N3gG1
 Eny9KKJFO4AvDsDRhzayaJm9eYpQji3ZnXStkP0tT9+4jHeAMK0VKexiDuz9sBobCQJuQX
 uXB0aUO3Hq6yuMsvrtKcRpchBdL8424=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-m-o8FUC-NGuq1hQm-w5Y4Q-1; Fri, 02 Jan 2026 07:06:06 -0500
X-MC-Unique: m-o8FUC-NGuq1hQm-w5Y4Q-1
X-Mimecast-MFC-AGG-ID: m-o8FUC-NGuq1hQm-w5Y4Q_1767355565
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a49cso70867765e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 04:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767355565; x=1767960365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A9VVsM2kR1Tdg4Q9bX0R3/95PjIZcPh3A+gObY5fDrc=;
 b=L2f8v2EgZ2OMntTU6wDvEoZxZyYwuYA3lTMlq8xlX+B/kRUWSlj7vYbMwdLOFODm/U
 U9A6ERKguad0tRmCUNmgOI5tmIPHHF7mvu6KwhXxKlQFnt6V1cwzdUUEAsr28PgiTRmb
 pEtNA/Hp0wstdSEdMYdrebIHf9KM0x1UOhRiTTqR095CjCYR3TDnGGOJJpsxanSGY62W
 4VMOH1mZNNphrzQHC6JMPqeTx6j5h3z9npA1uFO+WnsI7PFC/vVT/i8Yuutu7xcATNvH
 Y/3uxJPxWJWUHmfPO9gzE9RUsrykiq8vqm1wF0PFN9qoSm6vlKfHlSElqP+BQiKol1Tt
 QmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767355565; x=1767960365;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A9VVsM2kR1Tdg4Q9bX0R3/95PjIZcPh3A+gObY5fDrc=;
 b=Ct4CBIc6vPOdx2E9W/sBBkJrm1vYadySY4hr6ioErS34zswwFvBx5IajfN/YWBiqbj
 QFXxTUk52wscXgTxC1svTfpmqQi/Xli89CeXUwdn/1MQO0q/kLrbl25p4kBL7OjEj97b
 T0nJz/EtDxLYB4TRxHN9H+W63ZmkQtq0gtvgp1F4mMFYe8CgZrnTpgBIv7LC32pZKoDM
 Zo+oZmkRnwiGGgsRuI/MsONV85HJtzLiY8Wxapbv9hDZjFnHAhbGrE8QSgSurwPIG+mS
 5uRxxsyp/lWW0TGjycyTLPRwS4Bzc8bNECqUlZrF9SVrHDXqlPpvRLB/aWyRh36R5gf/
 FhXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOZIA/jpcWWjJXsrZ6111TWMiCOtxLX2OVdyTwUWhojhDYTRNvn/w2GZ9CrNEULqN4uk1BzfAEq19Q@nongnu.org
X-Gm-Message-State: AOJu0YxLYorwPrGj/fuqTB8SgY3dTCgEnqF6O3FfBJxVJaHJYZQ0QL6A
 N5jQkiEFl6RIyWQJFz8JG+R4K1HqN8kTVDSU3rKIt5FoqPaFqG7r7o3rWERD8sPcbM3ADmSlhg4
 otX6RpfbJ0FUe7/mcMiZ7uO1xbQXRrTQC/+DhTvxgTa7hzLz/2Ywrix+H
X-Gm-Gg: AY/fxX40piIt/W5oUcKBS24ad1v8EwcbgbfNLqv6BOABr5HrQlawTvU6G/a+qHs1JcW
 rGO2g7abm+oT2T/MPKgaOKy6aKddc+tREk9kgqEsrHGudS5XItH5zO1Hu3yi8Hujo6/G0Xbzy9Z
 WzNId7P7oOMqT9pBkSPvrtk4aC0n8nn10f2vDy9sFuo6nDJC6LOgwsXwxZ4S9pNnJ50G/2yyn4J
 FMK4qWTzWRZx7Aiok72rfx+6wxGMJCJK45Jch5nwRK/HXnxdoxOJjgc6D62lzO4zVmXsIr2pRrf
 mkP4W1GTa+58VeOePsfEtET6aJCIFP4aEIHW6LT6va6ma2oQgspdi9MJV+IvF5YxaRKtgGBWXcl
 +EoGJJx5LvWBLrLvHHDZ9ig==
X-Received: by 2002:a05:600c:1389:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-47d403e4fd0mr297876575e9.10.1767355564887; 
 Fri, 02 Jan 2026 04:06:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS8FH1pH0ZPJjikV9PCNSrFngLPHTCkncFX8oe+7uDSL7phRgXS8OK5/5TVO4ZyY6V8NFb2w==
X-Received: by 2002:a05:600c:1389:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-47d403e4fd0mr297876045e9.10.1767355564350; 
 Fri, 02 Jan 2026 04:06:04 -0800 (PST)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2724fe8sm938814075e9.1.2026.01.02.04.06.03
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 02 Jan 2026 04:06:03 -0800 (PST)
Date: Fri, 2 Jan 2026 13:06:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?Q?Berrang?=
 =?UTF-8?Q?=C3=A9?=" <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, BALATON
 Zoltan <balaton@eik.bme.hu>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, devel@lists.libvirt.org
Subject: Re: [RFC 02/10] qom: Add basic object property deprecation hint
 support
Message-ID: <20260102130601.0697deeb@imammedo-mac>
In-Reply-To: <20251202170502.3228625-3-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-3-zhao1.liu@intel.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  3 Dec 2025 01:04:54 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Now the common (but a bit fragmented) way to mark a property deprecated
> is to add the warning in its accssors.
> 
> But this is pretty inconvenient for such qdev properties, which are
> defined via DEFINE_PROP_* macros in the Property array. For qdev
> properties, their accessors are provided by pre-defined PropertyInfo, so
> that it's possible to modify PropertyInfo for a single "deprecated"
> property.
> 
> Then it's necessary to introduce property flags to mark some properties
> as deprecated, and to check the property flags when set the property,
> thereby to print a deprecation warning.
> 
> This not only benefits traditional qdev properties but also helps the
> deprecation of generic objects.
> 
> Note, internal attempt (except the compat case) should not trigger the
> deprecation warning but external user should see the deprecation
> information. Whether to perform deprecation checks based on property
> flags is controlled by the newly added "check" argument in
> object_property_try_add_full().

I'd split deprecation warning out for this patch,
i.e. make this one "add per object instance flags",
and take care of deprecation stuff on top,

Also, API likely would need set/get/clear calls to operate on object flags.

> 
> In subsequent work, the "check" option will be enabled for specific
> external property setting paths.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  include/qom/object.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  qom/object.c         | 72 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 130 insertions(+), 14 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 3f807a03f5aa..8f4c2f44d835 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -86,6 +86,12 @@ typedef void (ObjectPropertyRelease)(Object *obj,
>   */
>  typedef void (ObjectPropertyInit)(Object *obj, ObjectProperty *prop);
>  
> +typedef enum ObjectPropertyFlags {
> +    OBJECT_PROPERTY_NO_FLAGS     =                             0,
> +    OBJECT_PROPERTY_DEPRECATED   =                        1 << 0,

maybe use BIT() instead of manual shift?

addidtionally given you are going to distinguish external vs internal,
perhaps add flags 'default' and 'user set',
I think the both could be used to cleanup cpu flags handling where we rely on
setting/checking  magic numbers to figure out where value comes from.


> +    OBJECT_PROPERTY_FULL_FLAGS   =    OBJECT_PROPERTY_DEPRECATED,
> +} ObjectPropertyFlags;
> +
>  struct ObjectProperty
>  {
>      char *name;
> @@ -98,6 +104,7 @@ struct ObjectProperty
>      ObjectPropertyInit *init;
>      void *opaque;
>      QObject *defval;
> +    uint8_t flags;
>  };
>  
>  /**
> @@ -1090,6 +1097,41 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>                                          ObjectPropertyRelease *release,
>                                          void *opaque, Error **errp);
>  
> +/**
> + * object_property_try_add_full:

what's the reason for adding _full flavour over just modifying existing API?

> + *
> + * Same as object_property_try_add() with more arguments (@flags).
> + *
> + * @obj: the object to add a property to
> + * @name: the name of the property.  This can contain any character except for
> + *  a forward slash.  In general, you should use hyphens '-' instead of
> + *  underscores '_' when naming properties.
> + * @type: the type name of the property.  This namespace is pretty loosely
> + *   defined.  Sub namespaces are constructed by using a prefix and then
> + *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
> + *   'link' namespace would be 'link<virtio-net-pci>'.
> + * @get: The getter to be called to read a property.  If this is NULL, then
> + *   the property cannot be read.
> + * @set: the setter to be called to write a property.  If this is NULL,
> + *   then the property cannot be written.
> + * @release: called when the property is removed from the object.  This is
> + *   meant to allow a property to free its opaque upon object
> + *   destruction.  This may be NULL.
> + * @flags: the flags to control property uses.
> + * @opaque: an opaque pointer to pass to the callbacks for the property
> + * @errp: pointer to error object
> + *
> + * Returns: The #ObjectProperty; this can be used to set the @resolve
> + * callback for child and link properties.
> + */
> +ObjectProperty *object_property_try_add_full(Object *obj, const char *name,
> +                                             const char *type,
> +                                             ObjectPropertyAccessor *get,
> +                                             ObjectPropertyAccessor *set,
> +                                             ObjectPropertyRelease *release,
> +                                             ObjectPropertyFlags flags,
> +                                             void *opaque, Error **errp);
> +
>  /**
>   * object_property_add:
>   * Same as object_property_try_add() with @errp hardcoded to
> @@ -1128,6 +1170,15 @@ ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
>                                            ObjectPropertyRelease *release,
>                                            void *opaque);
>  
> +ObjectProperty *object_class_property_add_full(ObjectClass *klass,
> +                                               const char *name,
> +                                               const char *type,
> +                                               ObjectPropertyAccessor *get,
> +                                               ObjectPropertyAccessor *set,
> +                                               ObjectPropertyRelease *release,
> +                                               ObjectPropertyFlags flags,
> +                                               void *opaque);
> +
>  /**
>   * object_property_set_default_bool:
>   * @prop: the property to set
> @@ -1469,6 +1520,27 @@ int object_property_get_enum(Object *obj, const char *name,
>  bool object_property_set(Object *obj, const char *name, Visitor *v,
>                           Error **errp);
>  
> +/**
> + * object_property_set_full:
> + *
> + * Same as object_property_set() with extra check over property flags
> + * (ObjectPropertyFlags) if @check is true.
> + *
> + * @obj: the object
> + * @name: the name of the property
> + * @v: the visitor that will be used to write the property value.  This should
> + *   be an Input visitor and the data will be first read with @name as the
> + *   name and then written as the property value.
> + * @check: whether to check if the property can be set over property flags.
> + * @errp: returns an error if this function fails
> + *
> + * Writes a property to a object.
> + *
> + * Returns: %true on success, %false on failure.
> + */
> +bool object_property_set_full(Object *obj, const char *name,
> +                              Visitor *v, bool check, Error **errp);
> +
>  /**
>   * object_property_parse:
>   * @obj: the object
> diff --git a/qom/object.c b/qom/object.c
> index 85d31bb64b36..184afc6730dd 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1234,15 +1234,17 @@ void object_unref(void *objptr)
>  }
>  
>  ObjectProperty *
> -object_property_try_add(Object *obj, const char *name, const char *type,
> -                        ObjectPropertyAccessor *get,
> -                        ObjectPropertyAccessor *set,
> -                        ObjectPropertyRelease *release,
> -                        void *opaque, Error **errp)
> +object_property_try_add_full(Object *obj, const char *name, const char *type,
> +                             ObjectPropertyAccessor *get,
> +                             ObjectPropertyAccessor *set,
> +                             ObjectPropertyRelease *release,
> +                             ObjectPropertyFlags flags, void *opaque, Error **errp)
>  {
>      ObjectProperty *prop;
>      size_t name_len = strlen(name);
>  
> +    assert(!flags || !(flags & ~(OBJECT_PROPERTY_FULL_FLAGS)));
> +
>      if (name_len >= 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
>          int i;
>          ObjectProperty *ret = NULL;
> @@ -1279,11 +1281,24 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>      prop->set = set;
>      prop->release = release;
>      prop->opaque = opaque;
> +    prop->flags = flags;
>  
>      g_hash_table_insert(obj->properties, prop->name, prop);
>      return prop;
>  }
>  
> +ObjectProperty *
> +object_property_try_add(Object *obj, const char *name, const char *type,
> +                        ObjectPropertyAccessor *get,
> +                        ObjectPropertyAccessor *set,
> +                        ObjectPropertyRelease *release,
> +                        void *opaque, Error **errp)
> +{
> +    return object_property_try_add_full(obj, name, type, get, set, release,
> +                                        OBJECT_PROPERTY_NO_FLAGS, opaque,
> +                                        errp);
> +}
> +
>  ObjectProperty *
>  object_property_add(Object *obj, const char *name, const char *type,
>                      ObjectPropertyAccessor *get,
> @@ -1296,17 +1311,19 @@ object_property_add(Object *obj, const char *name, const char *type,
>  }
>  
>  ObjectProperty *
> -object_class_property_add(ObjectClass *klass,
> -                          const char *name,
> -                          const char *type,
> -                          ObjectPropertyAccessor *get,
> -                          ObjectPropertyAccessor *set,
> -                          ObjectPropertyRelease *release,
> -                          void *opaque)
> +object_class_property_add_full(ObjectClass *klass,
> +                               const char *name,
> +                               const char *type,
> +                               ObjectPropertyAccessor *get,
> +                               ObjectPropertyAccessor *set,
> +                               ObjectPropertyRelease *release,
> +                               ObjectPropertyFlags flags,
> +                               void *opaque)
>  {
>      ObjectProperty *prop;
>  
>      assert(!object_class_property_find(klass, name));
> +    assert(!flags || !(flags & ~(OBJECT_PROPERTY_FULL_FLAGS)));
>  
>      prop = g_malloc0(sizeof(*prop));
>  
> @@ -1317,12 +1334,27 @@ object_class_property_add(ObjectClass *klass,
>      prop->set = set;
>      prop->release = release;
>      prop->opaque = opaque;
> +    prop->flags = flags;
>  
>      g_hash_table_insert(klass->properties, prop->name, prop);
>  
>      return prop;
>  }
>  
> +ObjectProperty *
> +object_class_property_add(ObjectClass *klass,
> +                          const char *name,
> +                          const char *type,
> +                          ObjectPropertyAccessor *get,
> +                          ObjectPropertyAccessor *set,
> +                          ObjectPropertyRelease *release,
> +                          void *opaque)
> +{
> +    return object_class_property_add_full(klass, name, type, get, set,
> +                                          release, OBJECT_PROPERTY_NO_FLAGS,
> +                                          opaque);
> +}
> +
>  ObjectProperty *object_property_find(Object *obj, const char *name)
>  {
>      ObjectProperty *prop;
> @@ -1432,8 +1464,8 @@ bool object_property_get(Object *obj, const char *name, Visitor *v,
>      return !err;
>  }
>  
> -bool object_property_set(Object *obj, const char *name, Visitor *v,
> -                         Error **errp)
> +bool object_property_set_full(Object *obj, const char *name,
> +                              Visitor *v, bool check, Error **errp)
>  {
>      ERRP_GUARD();
>      ObjectProperty *prop = object_property_find_err(obj, name, errp);
> @@ -1447,10 +1479,22 @@ bool object_property_set(Object *obj, const char *name, Visitor *v,
>                     object_get_typename(obj), name);
>          return false;
>      }
> +
> +    if (check && prop->flags & OBJECT_PROPERTY_DEPRECATED) {
> +        warn_report("Property '%s.%s' has been deprecated. "
> +                    "Please do not use it.", object_get_typename(obj), name);
> +    }
> +
>      prop->set(obj, v, name, prop->opaque, errp);
>      return !*errp;
>  }
>  
> +bool object_property_set(Object *obj, const char *name, Visitor *v,
> +                         Error **errp)
> +{
> +    return object_property_set_full(obj, name, v, false, errp);
> +}
> +
>  bool object_property_set_str(Object *obj, const char *name,
>                               const char *value, Error **errp)
>  {


