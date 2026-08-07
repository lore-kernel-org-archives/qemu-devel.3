Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7650BC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJ1Y-0001QD-Fo; Fri, 07 Aug 2026 07:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsJ1S-0001L4-4c
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsJ1P-000506-EG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786103152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rf1qmAY7SD25sgp2d9x5itNz7mNDi5rhw1qSMbseZEg=;
 b=Q+TaOfkXKD8gXZiY114jMlnsOC+h0RSvCnR/1FDS0LpUiakQyd44cM669RzUbExKBHwH8O
 rUGaJlTmoFtpfxstQRmwLWAnnB+Yn82eNcbBFe2DVUM1CaS2ArqB5hrGWHFky74Seex4/u
 msZr3+3eN9XzTrb5dRfPfpOwujvZMx4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-NIbM9XzfOLKFRcJZy2dU2Q-1; Fri,
 07 Aug 2026 07:45:49 -0400
X-MC-Unique: NIbM9XzfOLKFRcJZy2dU2Q-1
X-Mimecast-MFC-AGG-ID: NIbM9XzfOLKFRcJZy2dU2Q_1786103148
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C637D19560AA; Fri,  7 Aug 2026 11:45:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E61621800347; Fri,  7 Aug 2026 11:45:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E3CB21E6920; Fri, 07 Aug 2026 13:45:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 10/53] qom: add QAPI-aware property registration
In-Reply-To: <20260616-qom-qapi-v2-10-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:37:36 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-10-cc9396b9c18c@redhat.com>
Date: Fri, 07 Aug 2026 13:45:44 +0200
Message-ID: <87o6fep313.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add object{_class}_property_add_qapi_enum(), and
> object_{_class}_property_add_qapi() functions. Set the qapi_type pointer
> on the resulting ObjectProperty.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The patch appars to do two things: general QAPI-aware property add, and
special enum property add.  Would it make sense to split it?

> ---
>  include/qom/object.h | 105 +++++++++++++++++++++++++++++++++++++++++
>  qom/object.c         | 131 +++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 232 insertions(+), 4 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index d96a9afe21d..ebfdbff9a94 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1223,6 +1223,15 @@ void object_property_set_default_bool(ObjectProper=
ty *prop, bool value);
>   */
>  void object_property_set_default_str(ObjectProperty *prop, const char *v=
alue);
>=20=20
> +/**
> + * object_property_set_default_enum:
> + * @prop: the property to set
> + * @value: the value to be written to the property
> + *
> + * Set the property default value.
> + */
> +void object_property_set_default_enum(ObjectProperty *prop, int value);
> +

This addition isn't mentioned in the commit message, unlike the others.
So the patch actually does three things.

Peeking ahead to find users...  there's just one, in PATCH 12.  It
replaces object_property_set_default_str() there.

>  /**
>   * object_property_set_default_list:
>   * @prop: the property to set
> @@ -1915,6 +1924,102 @@ ObjectProperty *object_class_property_add_enum(Ob=
jectClass *klass,
>                                      int (*get)(Object *, Error **),
>                                      void (*set)(Object *, int, Error **)=
);
>=20=20
> +/**
> + * struct QapiEnumProp - Descriptor for a QOM property backed by a QAPI =
enum type
> + *
> + * Binds a QOM object property to a QAPI enum, providing automatic
> + * string<->int conversion through QAPI visitors and optional
> + * default-value initialization during object instance init.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> + *
> + * @name: property name exposed on the QOM object
> + * @description: human-readable description (shown in ``-device help``, =
etc.)
> + * @default_value: initial enum value applied via @set during instance i=
nit,
> + *                 or -1 (the QAPI_ENUM_PROP default) to skip initializa=
tion
> + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> + *             (provides the string<->int lookup table)
> + * @get: getter that returns the current enum value as int, or -1 on err=
or
> + * @set: setter that receives the enum value as int; %NULL for read-only=
 props
> + */
> +typedef struct QapiEnumProp {
> +    const char *name;
> +    const char *description;
> +    const int default_value;
> +    const QAPITypeInfo *qapi_type;
> +    int (*get)(Object *, Error **);
> +    void (*set)(Object *, int, Error **);
> +} QapiEnumProp;
> +
> +#define QAPI_ENUM_PROP(...) ({                                          =
 \
> +    static const QapiEnumProp _prop =3D {                               =
   \
> +        .default_value =3D -1, __VA_ARGS__                              =
   \
> +    };                                                                  =
 \
> +    &_prop; })
> +
> +/**
> + * object_property_add_qapi_enum:
> + * @obj: the object to add a property to
> + * @prop: property descriptor
> + *
> + * Add an enum property with QAPI type association.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> + * inline. If .default_value is not set, the property is not initialized
> + * (default_value is -1). Otherwise, the setter is called with
> + * default_value during object instance init.
> + *
> + * Example::
> + *
> + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> + *       .name =3D "policy",
> + *       .description =3D "Set the NUMA policy",
> + *       .default_value =3D HOST_MEM_POLICY_DEFAULT,
> + *       .qapi_type =3D &HostMemPolicy_type_info,
> + *       .get =3D my_get_policy,
> + *       .set =3D my_set_policy,
> + *   ));

I'm not sure the macro is a good idea.  Could we use a simple compound
literal instead?

> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> +
> +ObjectProperty *
> +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumPr=
op *prop);

Observation, not pointing out flaws in your work: I still have to write
a .get and a .set in order to define a property, and most of these are
100% stupid.  I wish I could simply specify "read/write this member" and
be done, like in qdev.

Are there enum properties whose type is *not* a QAPI enum type?  Hmm we
do have enum-like string properties, e.g. "boot-mode" in
hw/arm/xilinx_zynq.c, and "riscv-aia" in target/riscv/kvm/kvm-cpu.c.
Not a fan.

Should only these functions be used to define enum properties going
forward?  If yes, the _qapi part in their name is redundant (but might
be desirable for consistency, I don't know).

> +
> +/**
> + * object_property_add_qapi:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @qapi_type: QAPI type info descriptor
> + * @get: the getter or %NULL if the property is write-only.

Either end all your descriptions with punctuation, or none.

> + * @set: the setter or %NULL if the property is read-only
> + * @release: called when the property is removed from the object
> + * @opaque: opaque pointer for get/set/release
> + *
> + * Add a property with a QAPI type association. The property type name
> + * is derived from @qapi_type->name.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_qapi(Object *obj, const char *name,
> +                         const QAPITypeInfo *qapi_type,
> +                         ObjectPropertyAccessor *get,
> +                         ObjectPropertyAccessor *set,
> +                         ObjectPropertyRelease *release,
> +                         void *opaque);

This is like object_property_add() with char *type replaced by
QAPITypeInfo *qapi_type.  Good.

Not so good: the argument descriptions in the function comment differ.
Let's pick the best one, and use it everywhere.

> +
> +ObjectProperty *
> +object_class_property_add_qapi(ObjectClass *klass,
> +                               const char *name,
> +                               const QAPITypeInfo *qapi_type,
> +                               ObjectPropertyAccessor *get,
> +                               ObjectPropertyAccessor *set,
> +                               ObjectPropertyRelease *release,
> +                               void *opaque);

Likewise, except there's no function comment.  Can't fault your patch
for that; the existing class property functions lack comments, too.  I
do fault the code before your series, though: we have pairs of functions
where we want people to use one, and document only the other.  Perhaps
we could figure out how to transmit mild electric shocks via the
keyboard to further deter the use of the better one?

Do we want people to use QAPI-aware functions like these to define
properties whenever possible?  I figure we do.  What about telling
people in the comments?

Function to add properties always come in pairs, one for properties tied
to the class, and one for properties tied to the object.  Most users of
the latter should use the former instead.  Questions for the QOM
maintainers:

1. Is it time to stop requiring the latter?
   object_property_add_qapi_enum() remains unused at the end of the
   series...

2. Should the preferred one at least have a shorter name than the other
   one?

> +
>  /**
>   * object_property_add_tm:
>   * @obj: the object to add a property to

Just skimming the remainder for now.

> diff --git a/qom/object.c b/qom/object.c
> index a085e78557f..e5e2f09a0a2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -24,6 +24,7 @@
>  #include "qapi/forward-visitor.h"
>  #include "qapi/qapi-builtin-visit.h"
>  #include "qobject/qdict.h"
> +#include "qapi/qapi-type-info.h"
>  #include "qobject/qjson.h"
>  #include "qemu/id.h"
>  #include "qapi/qmp/qerror.h"
> @@ -1717,6 +1718,15 @@ void object_property_set_default_str(ObjectPropert=
y *prop, const char *value)
>      object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
>  }
>=20=20
> +void object_property_set_default_enum(ObjectProperty *prop, int value)
> +{
> +    assert(prop && prop->qapi_type && prop->qapi_type->lookup);
> +
> +    object_property_set_default(prop, QOBJECT(qstring_from_str(
> +        qapi_enum_lookup(prop->qapi_type->lookup, value)
> +    )));
> +}
> +
>  void object_property_set_default_list(ObjectProperty *prop)
>  {
>      object_property_set_default(prop, QOBJECT(qlist_new()));
> @@ -1775,7 +1785,6 @@ int object_property_get_enum(Object *obj, const cha=
r *name,
>      char *str;
>      int ret;
>      ObjectProperty *prop =3D object_property_find_err(obj, name, errp);
> -    EnumProperty *enumprop;
>=20=20
>      if (prop =3D=3D NULL) {
>          return -1;
> @@ -1788,14 +1797,17 @@ int object_property_get_enum(Object *obj, const c=
har *name,
>          return -1;
>      }
>=20=20
> -    enumprop =3D prop->opaque;
> -
>      str =3D object_property_get_str(obj, name, errp);
>      if (!str) {
>          return -1;
>      }
>=20=20
> -    ret =3D qapi_enum_parse(enumprop->lookup, str, -1, errp);
> +    if (prop->qapi_type) {
> +        ret =3D qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
> +    } else {
> +        EnumProperty *enumprop =3D prop->opaque;
> +        ret =3D qapi_enum_parse(enumprop->lookup, str, -1, errp);
> +    }
>      g_free(str);
>=20=20
>      return ret;
> @@ -2598,6 +2610,117 @@ object_class_property_add_enum(ObjectClass *klass=
, const char *name,
>                                       prop);
>  }
>=20=20
> +static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const QapiEnumProp *prop =3D opaque;
> +    int value;
> +    Error *err =3D NULL;
> +
> +    value =3D prop->get(obj, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
> +}
> +
> +static void set_qapi_enum(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const QapiEnumProp *prop =3D opaque;
> +    int value;
> +
> +    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp)=
) {
> +        return;
> +    }
> +    prop->set(obj, value, errp);
> +}
> +
> +static void init_qapi_enum(Object *obj, ObjectProperty *prop)
> +{
> +    const QapiEnumProp *e =3D prop->opaque;
> +
> +    if (e->set && e->default_value >=3D 0) {
> +        e->set(obj, e->default_value, &error_abort);
> +    }
> +}
> +
> +ObjectProperty *
> +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *e)
> +{
> +    ObjectProperty *prop;
> +
> +    assert(e && e->qapi_type && e->qapi_type->lookup);
> +
> +    prop =3D object_property_add(obj, e->name, e->qapi_type->name,
> +                               e->get ? get_qapi_enum : NULL,
> +                               e->set ? set_qapi_enum : NULL,
> +                               NULL,
> +                               (void *)e);
> +    prop->qapi_type =3D e->qapi_type;

Shouldn't this wrap around object_property_add_qapi()?

> +    prop->description =3D g_strdup(e->description);
> +    if (e->default_value >=3D 0) {
> +        prop->init =3D init_qapi_enum;
> +    }
> +
> +    return prop;
> +}
> +
> +ObjectProperty *
> +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumPr=
op *e)
> +{
> +    ObjectProperty *prop;
> +
> +    assert(e && e->qapi_type && e->qapi_type->lookup);
> +
> +    prop =3D object_class_property_add(klass, e->name, e->qapi_type->nam=
e,
> +                                     e->get ? get_qapi_enum : NULL,
> +                                     e->set ? set_qapi_enum : NULL,
> +                                     NULL,
> +                                     (void *)e);
> +    prop->qapi_type =3D e->qapi_type;

Shouldn't this wrap around object_class_property_add_qapi()?

> +    prop->description =3D g_strdup(e->description);
> +    if (e->default_value >=3D 0) {
> +        prop->init =3D init_qapi_enum;
> +    }
> +
> +    return prop;
> +}
> +
> +ObjectProperty *
> +object_property_add_qapi(Object *obj, const char *name,
> +                         const QAPITypeInfo *qapi_type,
> +                         ObjectPropertyAccessor *get,
> +                         ObjectPropertyAccessor *set,
> +                         ObjectPropertyRelease *release,
> +                         void *opaque)
> +{
> +    ObjectProperty *prop;
> +
> +    prop =3D object_property_add(obj, name, qapi_type->name,
> +                               get, set, release, opaque);
> +    prop->qapi_type =3D qapi_type;
> +    return prop;
> +}
> +
> +ObjectProperty *
> +object_class_property_add_qapi(ObjectClass *klass, const char *name,
> +                               const QAPITypeInfo *qapi_type,
> +                               ObjectPropertyAccessor *get,
> +                               ObjectPropertyAccessor *set,
> +                               ObjectPropertyRelease *release,
> +                               void *opaque)
> +{
> +    ObjectProperty *prop;
> +
> +    prop =3D object_class_property_add(klass, name, qapi_type->name,
> +                                     get, set, release, opaque);
> +    prop->qapi_type =3D qapi_type;
> +    return prop;
> +}
> +
>  typedef struct TMProperty {
>      void (*get)(Object *, struct tm *, Error **);
>  } TMProperty;


