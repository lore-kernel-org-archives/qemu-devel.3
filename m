Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFA8C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77r1-0006Mo-Bi; Thu, 17 Sep 2026 04:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x77qx-0006MV-H3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x77qv-0005Ai-9a
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789635138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pGnNlStZhclyUqon3aauMX4d5xvI6gGgXjjo6S3NefA=;
 b=LFPmLuqixnfk5sLv7z35kd/ce2xTWp2iA6WimCp2Js6TwSkVW9MTTExpqbo87DacBuyPsl
 hBpNGOUTbQWOTUXmq4x+j1JgIzMnKb3JYUzWYutOu9aXMV2sVd6HE4haMs8wz2KhdTnQUm
 hZ/8YJo8OeW1Iga2+fOKrnX/iv+oID0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-2wxXGHCvO3ibzsikS1vVgA-1; Thu, 17 Sep 2026 04:52:16 -0400
X-MC-Unique: 2wxXGHCvO3ibzsikS1vVgA-1
X-Mimecast-MFC-AGG-ID: 2wxXGHCvO3ibzsikS1vVgA_1789635135
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so1376113a91.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789635135; cv=none;
 d=google.com; s=arc-20260327;
 b=FMR3jAQ5sDeFhezeJVk6dWfoPGCXQTlH4P/Y/y6USqkEELFDnJZRgjXoSpKCne8BwR
 mhzfXJQvuc8V/oysETTsFAmRifIpCIjryGdBbbOVPyibAwXgJvSMQ/smr59K4QUNKcY1
 pBIQGonboVI3U/LElvBIqpKC1lYLTi7QCQRoYezXauHTzDBgsdPbrFxECHkM1+OvDOsi
 ex5+oon7KxpbM2sMgyaVNTTCOvWj6w/oRYqpWzyQDvtgBTJYolHknIGh48cxsipeh34B
 KoBo/ua5HjhkgZPgMpA3qocz0YmKrDNkBVM9v2BQS/NJ24928d3lbBgu0cAIPvKSLg+B
 o6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pGnNlStZhclyUqon3aauMX4d5xvI6gGgXjjo6S3NefA=;
 fh=kF+43uo+0K40hgebi1jzUT5Rpq37No6WTlAwk0IXo5A=;
 b=hyyJoClaTRP8UV0zyexuw4Qh0deks7LEkQvMVvO/YKYKjSOjH6s11SCUZ2OgeR6Da5
 s9M0BdxOuyBuPlJ36z9ci2IyA6om5ywHugQlzRb0F6AVNYzUqUkmnGcPSwXfr1Jh/Gvo
 K2YQvj1K4iMm7frqLgx4UycgGoDXp+NCgJ2Ln9+d3Vlrk5R9lPlzI9qLithlb1uUTUjL
 O83Wj6E4DV/T2Q+uzc9DI8Kxtg3lEWGdO9OK2zHxpSK4sKQ9CwK79rqIUgRK5eHMy+XG
 JtJMqB2Cuuoep9ThCbSWlPjjBRHD2PpZzh556Nd6ZVzFDiGNyNNS3kvDdnneqfgH5M8G
 W5TA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789635135; x=1790239935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pGnNlStZhclyUqon3aauMX4d5xvI6gGgXjjo6S3NefA=;
 b=pEz3lVQc+TBP7d0ijsELrloYzGjlNsDigZRnUew340nOfrpFqWi4Xj8cu99PoYmbrR
 NwTUaq0EsJ13+cFZ+m/nDWWs5qKhS9vnTIxlQnmEM5UY0PCnb4C0SvkyRKBtedbKr0yG
 dlY9H9TVQunb0I7+3sjN5MdIkml1i7XHWrENvsjovx0N5/VIgEu0aBooKLr96pSjdnz3
 lB+pTeq0yYbF16y7X5x9Oi8AmJ+Uqu7+KHGgFUN/JNMxgXmNXLqiJtCCNJAlg4sk94f3
 PfW4GF+qCtw+mT9DSb6La8yliqe9jHiRMiixOixJbVXSZGTmUnGuqZWfrR/+NX041rCB
 INXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789635135; x=1790239935;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pGnNlStZhclyUqon3aauMX4d5xvI6gGgXjjo6S3NefA=;
 b=TBpnsdnHeEaEDgJvFqxA8ajRSTGO0V6K+aw3Ewboec2r/deLctjP/pRQG84RahMwLY
 yYxNy6xKiRfGMsb6PFXle0QhXicNWGHhGQYQEzrSrlhLbI58kb6b43tCU4TtPmCltIWR
 vvQ1QHHeuKF8eFhdqON8ifNY2I3vmRAltVTl/wGQ6MpMxBRF34JCJ1Ma7emcHcVSru7y
 5FFQ4JENgQf0ang2nqnyYXvY7v0arfqJhLh5BlY9Nyiw0UVERIEYYesSSEtMhgKd0QJ6
 L9w2T0paccjOYWW6WYMp+FxNpJBqHkLz2JrVuzkaVKWOXUS+Z3G5G6zVg2FKcuLmr/YV
 tmlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByKy2ERsbwbSSeqL76Dy/VRpZkYmeik/Hy2w6GhjkYtiPVNwsaXpxck1NbrxlTZktSI7Jcnsp1uEtMm@nongnu.org
X-Gm-Message-State: AFuF++lgp+WESMC6cvRdG+QdOKmu/7vRN21xK5HWeAPcuw5dbcbEHNZd
 s1MtuO75G6k7D6USnFJxaxYdi09MdpNKmIXH4b4/SXcw093e1HPBK9WEQD5wBH4m8g5xJ3DL0B3
 HsQ9ccIfwIrqJorvs58udeuRkBjqUwVtpER+ZLkgJuX0QusH7aYRTZkFjk/N9o1ik/hUJ1NqaZR
 OtfTv7DiOnvUGPvq45Ag85tasV9LrHdCo=
X-Gm-Gg: AYBFou14qgp2T4W+tkyu+//WvdDjS9SD8J09D3GHFbLrz/n0nWsId0tbRvFO818lq6x
 So8TJ5eIj+1AtaHhwBUfrN94pSS7xhzkWLpE2scPkGZ75lJ0a0NHzTHSWt0LSe5pj5U4az+34Au
 DpO7bxvKxXFvDuUjx/YtSAAaUZc71KDmSMgXbVtLS8L67HFq8T2TQg91r4/429Cmwq4yJQtdn7W
 t/9XifPaZGZbK9ijem1GUGtuxZEnMlT7jVw4wzIE+QsD2TdXLWnQx8JKR4kohM3lHBiAZ6P3Meu
 3Q==
X-Received: by 2002:a17:90b:314c:b0:39d:f4fd:8075 with SMTP id
 98e67ed59e1d1-39e1e4e3559mr12292927a91.19.1789635135030; 
 Thu, 17 Sep 2026 01:52:15 -0700 (PDT)
X-Received: by 2002:a17:90b:314c:b0:39d:f4fd:8075 with SMTP id
 98e67ed59e1d1-39e1e4e3559mr12292890a91.19.1789635134504; Thu, 17 Sep 2026
 01:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
 <20260902144207.2553037-3-mark.caveayland@nutanix.com>
In-Reply-To: <20260902144207.2553037-3-mark.caveayland@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Sep 2026 12:52:02 +0400
X-Gm-Features: AcwNN1X8E6BMcwJ7prDSnboRUgZwDfZMJZOdicB1u_o1NW0qtXSUhjnaZ0w7khg
Message-ID: <CAMxuvaxoQXZz3AhM9wnRuM7hRn8LD4hMT0ONaV-vRtz5Jy0big@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] qom/object.c: introduce
 object_class_property_add_alias()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 mtosatti@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Sep 2, 2026 at 6:42=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This is eventually intended to be a replacement for object_property_add_a=
lias()
> which uses an object property instead of a class property.
>
> With the advent of class properties, it is possible that QOM may attempt =
to
> set or retrieve the value of an unset alias property. Update the existing
> property_get_alias() and property_set_alias() functions to use the null v=
isitor
> if the alias target has not been set, and property_resolve_alias() to ret=
urn
> NULL for the same case.
>
> This ensures that unset class alias properties accessed e.g. via the moni=
tor do
> not cause QEMU to crash.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/qom/object.h |  25 +++++++++++
>  qom/object.c         | 100 +++++++++++++++++++++++++++++++++++++------
>  2 files changed, 113 insertions(+), 12 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e24f0a2b2d..96c76975ef 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_add_u=
int64_ptr(ObjectClass *klass,
>                                            const uint64_t *v,
>                                            ObjectPropertyFlags flags);
>
> +typedef enum {
> +    /* private */
> +    OBJ_PROP_ALIAS_CLASS =3D 0x1,
> +} ObjectPropertyAliasFlags;
> +
>  /**
>   * object_property_add_alias:
>   * @obj: the object to add a property to
> @@ -2283,6 +2288,26 @@ ObjectProperty *object_class_static_property_add_u=
int64_ptr(ObjectClass *klass,
>  ObjectProperty *object_property_add_alias(Object *obj, const char *name,
>                                 Object *target_obj, const char *target_na=
me);
>
> +/**
> + * object_class_property_add_alias:
> + * @klass: the object class to add a property to
> + * @name: the name of the property
> + * @offset: the offset from the object instance where the object alias i=
s
> + *   stored
> + * @target_type: QOM type we expect the alias to resolve to
> + * @target_name: the name of the property on the forwarded object
> + *
> + * Add an alias for a property on an object.  This function will add a p=
roperty
> + * of the same type as the forwarded property.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.

actually, it assert() on error and never returns NULL.

> + */
> +ObjectProperty *
> +object_class_property_add_alias(ObjectClass *klass, const char *name,
> +                                ptrdiff_t offset,
> +                                const char *target_type,
> +                                const char *target_name);
> +
>  /**
>   * object_property_add_const_link:
>   * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index a904f53ed6..9a05e189ea 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -34,6 +34,7 @@
>  #include "qom/qom-qobject.h"
>  #include "qobject/qbool.h"
>  #include "qobject/qlist.h"
> +#include "qobject/qnull.h"
>  #include "qobject/qnum.h"
>  #include "qobject/qstring.h"
>  #include "qemu/error-report.h"
> @@ -3039,14 +3040,22 @@ object_class_static_property_add_uint64_ptr(Objec=
tClass *klass,
>  }
>
>  typedef struct {
> -    Object *target_obj;
> +    union {
> +        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
> +        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
> +    };
>      char *target_name;
> +    ObjectPropertyAliasFlags flags;
>  } AliasProperty;
>
>  static Object **
> -object_alias_get_targetp(Object *obj, AliasProperty *lprop)
> +object_alias_get_targetp(Object *obj, AliasProperty *aprop)
>  {
> -    return &lprop->target_obj;
> +    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
> +        return (void *)obj + aprop->offset;
> +    } else {
> +        return &aprop->target_obj;
> +    }
>  }
>
>  static void property_get_alias(Object *obj, Visitor *v, const char *name=
,
> @@ -3054,10 +3063,18 @@ static void property_get_alias(Object *obj, Visit=
or *v, const char *name,
>  {
>      AliasProperty *prop =3D opaque;
>      Object **target_obj =3D object_alias_get_targetp(obj, prop);
> -    Visitor *alias_v =3D visitor_forward_field(v, prop->target_name, nam=
e);
>
> -    object_property_get(*target_obj, prop->target_name, alias_v, errp);
> -    visit_free(alias_v);
> +    if (*target_obj) {
> +        Visitor *alias_v =3D visitor_forward_field(v, prop->target_name,=
 name);
> +
> +        object_property_get(*target_obj, prop->target_name, alias_v, err=
p);
> +        visit_free(alias_v);
> +    } else {
> +        QNull *null =3D NULL;
> +
> +        visit_type_null(v, NULL, &null, errp);
> +        qnull_unref(null);
> +    };

extra ;

>  }
>
>  static void property_set_alias(Object *obj, Visitor *v, const char *name=
,
> @@ -3065,10 +3082,18 @@ static void property_set_alias(Object *obj, Visit=
or *v, const char *name,
>  {
>      AliasProperty *prop =3D opaque;
>      Object **target_obj =3D object_alias_get_targetp(obj, prop);
> -    Visitor *alias_v =3D visitor_forward_field(v, prop->target_name, nam=
e);
>
> -    object_property_set(*target_obj, prop->target_name, alias_v, errp);
> -    visit_free(alias_v);
> +    if (*target_obj) {
> +        Visitor *alias_v =3D visitor_forward_field(v, prop->target_name,=
 name);
> +
> +        object_property_set(*target_obj, prop->target_name, alias_v, err=
p);
> +        visit_free(alias_v);
> +    } else {
> +        QNull *null =3D NULL;
> +
> +        visit_type_null(v, NULL, &null, errp);
> +        qnull_unref(null);

Why not return an error?

> +    }
>  }
>
>  static Object *property_resolve_alias(Object *obj, void *opaque,
> @@ -3077,15 +3102,21 @@ static Object *property_resolve_alias(Object *obj=
, void *opaque,
>      AliasProperty *prop =3D opaque;
>      Object **target_obj =3D object_alias_get_targetp(obj, prop);
>
> -    return object_resolve_path_component(*target_obj, prop->target_name)=
;
> +    if (*target_obj) {
> +        return object_resolve_path_component(*target_obj, prop->target_n=
ame);
> +    } else {
> +        return NULL;
> +    }
>  }
>
>  static void property_release_alias(Object *obj, const char *name, void *=
opaque)
>  {
>      AliasProperty *prop =3D opaque;
>
> -    g_free(prop->target_name);
> -    g_free(prop);
> +    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
> +        g_free(prop->target_name);
> +        g_free(prop);
> +    }
>  }
>
>  ObjectProperty *
> @@ -3110,6 +3141,7 @@ object_property_add_alias(Object *obj, const char *=
name,
>      prop =3D g_malloc(sizeof(*prop));
>      prop->target_obj =3D target_obj;
>      prop->target_name =3D g_strdup(target_name);
> +    prop->flags =3D 0;
>
>      op =3D object_property_add(obj, name, prop_type,
>                               property_get_alias,
> @@ -3126,6 +3158,50 @@ object_property_add_alias(Object *obj, const char =
*name,
>      return op;
>  }
>
> +ObjectProperty *
> +object_class_property_add_alias(ObjectClass *klass, const char *name,
> +                                ptrdiff_t offset,
> +                                const char *target_type,
> +                                const char *target_name)
> +{
> +    AliasProperty *prop;
> +    ObjectProperty *op;
> +    ObjectProperty *target_prop;
> +    ObjectClass *target_class;
> +    g_autofree char *prop_type =3D NULL;
> +
> +    target_class =3D object_class_by_name(target_type);
> +    assert(target_class);
> +    target_prop =3D object_class_property_find(target_class, target_name=
);
> +    assert(target_prop);
> +
> +    if (object_property_is_child(target_prop)) {
> +        prop_type =3D g_strdup_printf("link%s",
> +                                    target_prop->type + strlen("child"))=
;
> +    } else {
> +        prop_type =3D g_strdup(target_prop->type);
> +    }
> +
> +    prop =3D g_malloc(sizeof(*prop));
> +    prop->offset =3D offset;
> +    prop->target_name =3D g_strdup(target_name);
> +    prop->flags =3D OBJ_PROP_ALIAS_CLASS;
> +
> +    op =3D object_class_property_add(klass, name, prop_type,
> +                                   property_get_alias,
> +                                   property_set_alias,
> +                                   property_release_alias,
> +                                   prop);
> +    op->resolve =3D property_resolve_alias;
> +    if (target_prop->defval) {
> +        op->defval =3D qobject_ref(target_prop->defval);
> +    }
> +
> +    object_class_property_set_description(klass, op->name,
> +                                          target_prop->description);
> +    return op;
> +}
> +
>  void object_property_set_description(Object *obj, const char *name,
>                                       const char *description)
>  {
> --
> 2.43.0
>


