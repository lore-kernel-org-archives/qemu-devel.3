Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CAC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSIm-0000bE-AZ; Thu, 13 Aug 2026 06:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuSIk-0000aW-Ck
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuSIh-0008PZ-Hm
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786615478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP7HbvyvjrO+6yJGINL2eoGYq/lWWxabI7Z/Bc7olFg=;
 b=jPC4q2R1xPm3cReZylD0jnyumKtRWJgT98X8XhU4wqgYShyz7nsxGLIeGqkOG7hpIl9ptc
 rrx169nmT7AVWSr/gp9ASre0o3BxE3wWJu0ouOPIkjoxRkihIiK24TOt7K7dy5ICKMy4RP
 eMFywTixLSs5PIHz03g5satIa2iB7fA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Cfuw9CNuPIyijEpjKk3R8w-1; Thu, 13 Aug 2026 06:04:36 -0400
X-MC-Unique: Cfuw9CNuPIyijEpjKk3R8w-1
X-Mimecast-MFC-AGG-ID: Cfuw9CNuPIyijEpjKk3R8w_1786615475
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbee5bab340so2251992a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615475; cv=none;
 d=google.com; s=arc-20260327;
 b=LZdhNfRcjI7+zxSNgfYrHfhH3Wn2m+Zz705cJF4HsYqWhbK5MLm1XDn5v1ImF5jHYM
 w0KA5JHX4NdS0H2XpHuFe8vFXkn/NNhd4tEzerGh/HQlIDZ7QX0vDnz3gNpo5LLALJHH
 zG4gnei/YLlERutC1v5X3adjLAXk+mxDVHlMt4kRpjLtunwyhcrJr+yjHKxGWD0xB9Tu
 4YsZE4+WMT4D/xigCBc7sZ5IN336xwCAQ+b24y1B8jWtcb2QMTeVIEKu58FucpI6672u
 gRZanVdM2OKjFsjI1hw+mmXRUxKQ/d5xQC3gD/uv04t7DJ223s5ibB0bNkjFhvWdzm5N
 loig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zP7HbvyvjrO+6yJGINL2eoGYq/lWWxabI7Z/Bc7olFg=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=IkxkzwTeOD135sdropHBX9Nsd2GwltKOW7+BecTGbjZRCoI70fK93JOq3q5TO80ykQ
 igGIdciQF6++IVpF3Ap1H9hX7CnvgxwI01tX6jEWwIQ83qYxM9dHZnqTORM5gMAioZ+l
 1vNpP+xROc7we5mCnld198lyzyX6Fc/PqGSznXabaaPbz+IUEGvnDi71hAmyRnGCCgeW
 BUfGYKDz0fS8h5fEh3WRPcjA2QuFtx46i6KUVXgFnIXvHv/BMqAF5SZYG5yV9lMOb9DO
 8gRUxYqJ8RGWiMQ/yDJXtftt+iGs+30d3HuIofdDx1VGUMcl1fGeI/ixO0N2WpTQ5rTk
 uY+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786615475; x=1787220275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zP7HbvyvjrO+6yJGINL2eoGYq/lWWxabI7Z/Bc7olFg=;
 b=jV3HHkl0WpcuPLjSkaXk9HAKHL7aS9dmQ7vGcUvBj0O4RLpK7iM26hT0wVLtAtveBc
 qEDofMe+xBo5NQktTocthzB9gh4vOePVECo4ijpaJfrNmtYlmWdpsnvQO9W4PfRblsNB
 kN8qgR2piTGP91np3RaOawLqEAh5uUcJn5GzSrn+ZPKr2Xwmt6qUOFskjswIIDjTaN9f
 od2XdXVrQDIPyvBC9ExaTYUiDVU0OHtgJCsUcKPHozSUXToGpF3nJcf+kYl9Y0rcHvEX
 qbyWNaS5ki0+FnRhC6SJjy0SC527DQHkCYlamLBlQAM8SsOGcWdPR0y31mJCZO0pm6nt
 GCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786615475; x=1787220275;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zP7HbvyvjrO+6yJGINL2eoGYq/lWWxabI7Z/Bc7olFg=;
 b=PVwieprzA1pGo687Sdj2Sv77OwHEsEVhnw0lP1Tdzx11fTT8Oox0CrfjibtFKvFZNd
 dyKb94GpWnwKGcy41rFXHaFvLL95FsL9f6j6Mb5qSALwmHdqI755+a9I/q9CtEc36ML2
 ckaeif7sB8U4pzNNrhxxemf/ofjgUg5P9/4SgNN4SIAa35cyPPZd7u9R1fo4TVg1qinw
 ENVjPK/y56uy2C8w2I+h7pLrVo4dNWQ+73jtZGZxG9RqsHlUQ0KGf51yYyeyR5WluDEk
 zJr+8MzAyE6eh8SCw5C9g9lqzE4vmhG0OTwL9hNaigr5BXi09jvkHxDPokG8372xnI+n
 YSMg==
X-Gm-Message-State: AOJu0YzxLBQBKc7fbDh6LIOzNg92u2UCUu2GCk1nzvUU/v5Zd1pYUMr2
 ItGZP9SeUB2rQdAJvpVG7fMIsAc2CBRhLNsalRsdwWKh9+HUPMo4004P20BpCWiql84WsTFE9IQ
 DOCRgobE/6iRAFGnm1woN1ANHLGj8opFbhlqmdRo0CtNym4dMHdiiJVAlTEY1WEaNgKYbdpgjcj
 p6oE23/DKH1M982nXcCXy6FGWJJTqw2Xg=
X-Gm-Gg: AR+sD117+Z3UXbTRwZmJrQQkTF1tlf/Rckfym5TReLOVSlRbh/2ikEl9ipOMAJ2Smv1
 xCkhyVFh6RpezcXJzk/EH5KEwFfx0a1EGBkAScprAq/8SqlKOZFT1Nb41RztuM4CGlh2UU2Xh0M
 HQoBotbi1euj96gGqRLuWtOO60UGE0fWmxgxlYT/nGpQxTHk5v3lxgjkgcGZ9++TColjlgNLp/c
 8nYVu3RAgC/X90uh/B2yiuQH+bAnmxzw44giAhoC068LrFBxlCR8Bidm3NHlg9mxLAQIBzu03mY
 pA==
X-Received: by 2002:a05:6a21:1786:b0:3c3:719d:dfe2 with SMTP id
 adf61e73a8af0-3cc55543bccmr7275855637.36.1786615475110; 
 Thu, 13 Aug 2026 03:04:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:1786:b0:3c3:719d:dfe2 with SMTP id
 adf61e73a8af0-3cc55543bccmr7275771637.36.1786615474493; Thu, 13 Aug 2026
 03:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-10-cc9396b9c18c@redhat.com>
 <87o6fep313.fsf@pond.sub.org>
In-Reply-To: <87o6fep313.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 14:04:22 +0400
X-Gm-Features: AUfX_my3qVpMx9wtmUNIGE93p0d6sUKX8gQqXDgaQ9yHSO0A2NIbJLramqxMa8c
Message-ID: <CAMxuvayi0yrruLMxHvSfyv4H27Xg9PamM5-YQjxf4yF7LRehkg@mail.gmail.com>
Subject: Re: [PATCH v2 10/53] qom: add QAPI-aware property registration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Fri, Aug 7, 2026 at 3:46=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add object{_class}_property_add_qapi_enum(), and
> > object_{_class}_property_add_qapi() functions. Set the qapi_type pointe=
r
> > on the resulting ObjectProperty.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The patch appars to do two things: general QAPI-aware property add, and
> special enum property add.  Would it make sense to split it?
>

sure

> > ---
> >  include/qom/object.h | 105 +++++++++++++++++++++++++++++++++++++++++
> >  qom/object.c         | 131 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 232 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index d96a9afe21d..ebfdbff9a94 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1223,6 +1223,15 @@ void object_property_set_default_bool(ObjectProp=
erty *prop, bool value);
> >   */
> >  void object_property_set_default_str(ObjectProperty *prop, const char =
*value);
> >
> > +/**
> > + * object_property_set_default_enum:
> > + * @prop: the property to set
> > + * @value: the value to be written to the property
> > + *
> > + * Set the property default value.
> > + */
> > +void object_property_set_default_enum(ObjectProperty *prop, int value)=
;
> > +
>
> This addition isn't mentioned in the commit message, unlike the others.
> So the patch actually does three things.
>
> Peeking ahead to find users...  there's just one, in PATCH 12.  It
> replaces object_property_set_default_str() there.
>
> >  /**
> >   * object_property_set_default_list:
> >   * @prop: the property to set
> > @@ -1915,6 +1924,102 @@ ObjectProperty *object_class_property_add_enum(=
ObjectClass *klass,
> >                                      int (*get)(Object *, Error **),
> >                                      void (*set)(Object *, int, Error *=
*));
> >
> > +/**
> > + * struct QapiEnumProp - Descriptor for a QOM property backed by a QAP=
I enum type
> > + *
> > + * Binds a QOM object property to a QAPI enum, providing automatic
> > + * string<->int conversion through QAPI visitors and optional
> > + * default-value initialization during object instance init.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> > + *
> > + * @name: property name exposed on the QOM object
> > + * @description: human-readable description (shown in ``-device help``=
, etc.)
> > + * @default_value: initial enum value applied via @set during instance=
 init,
> > + *                 or -1 (the QAPI_ENUM_PROP default) to skip initiali=
zation
> > + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> > + *             (provides the string<->int lookup table)
> > + * @get: getter that returns the current enum value as int, or -1 on e=
rror
> > + * @set: setter that receives the enum value as int; %NULL for read-on=
ly props
> > + */
> > +typedef struct QapiEnumProp {
> > +    const char *name;
> > +    const char *description;
> > +    const int default_value;
> > +    const QAPITypeInfo *qapi_type;
> > +    int (*get)(Object *, Error **);
> > +    void (*set)(Object *, int, Error **);
> > +} QapiEnumProp;
> > +
> > +#define QAPI_ENUM_PROP(...) ({                                        =
   \
> > +    static const QapiEnumProp _prop =3D {                             =
     \
> > +        .default_value =3D -1, __VA_ARGS__                            =
     \
> > +    };                                                                =
   \
> > +    &_prop; })
> > +
> > +/**
> > + * object_property_add_qapi_enum:
> > + * @obj: the object to add a property to
> > + * @prop: property descriptor
> > + *
> > + * Add an enum property with QAPI type association.
> > + *
> > + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> > + * inline. If .default_value is not set, the property is not initializ=
ed
> > + * (default_value is -1). Otherwise, the setter is called with
> > + * default_value during object instance init.
> > + *
> > + * Example::
> > + *
> > + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> > + *       .name =3D "policy",
> > + *       .description =3D "Set the NUMA policy",
> > + *       .default_value =3D HOST_MEM_POLICY_DEFAULT,
> > + *       .qapi_type =3D &HostMemPolicy_type_info,
> > + *       .get =3D my_get_policy,
> > + *       .set =3D my_set_policy,
> > + *   ));
>
> I'm not sure the macro is a good idea.  Could we use a simple compound
> literal instead?

A plain compound literal has automatic storage.. the macro just eases
this. You can always open code if it helps.

>
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> > +
> > +ObjectProperty *
> > +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnum=
Prop *prop);
>
> Observation, not pointing out flaws in your work: I still have to write
> a .get and a .set in order to define a property, and most of these are
> 100% stupid.  I wish I could simply specify "read/write this member" and
> be done, like in qdev.
>
> Are there enum properties whose type is *not* a QAPI enum type?  Hmm we
> do have enum-like string properties, e.g. "boot-mode" in
> hw/arm/xilinx_zynq.c, and "riscv-aia" in target/riscv/kvm/kvm-cpu.c.
> Not a fan.
>
> Should only these functions be used to define enum properties going
> forward?  If yes, the _qapi part in their name is redundant (but might
> be desirable for consistency, I don't know).
>
> > +
> > +/**
> > + * object_property_add_qapi:
> > + * @obj: the object to add a property to
> > + * @name: the name of the property
> > + * @qapi_type: QAPI type info descriptor
> > + * @get: the getter or %NULL if the property is write-only.
>
> Either end all your descriptions with punctuation, or none.

fixed

>
> > + * @set: the setter or %NULL if the property is read-only
> > + * @release: called when the property is removed from the object
> > + * @opaque: opaque pointer for get/set/release
> > + *
> > + * Add a property with a QAPI type association. The property type name
> > + * is derived from @qapi_type->name.
> > + *
> > + * Returns: The newly added property on success, or %NULL on failure.
> > + */
> > +ObjectProperty *
> > +object_property_add_qapi(Object *obj, const char *name,
> > +                         const QAPITypeInfo *qapi_type,
> > +                         ObjectPropertyAccessor *get,
> > +                         ObjectPropertyAccessor *set,
> > +                         ObjectPropertyRelease *release,
> > +                         void *opaque);
>
> This is like object_property_add() with char *type replaced by
> QAPITypeInfo *qapi_type.  Good.
>
> Not so good: the argument descriptions in the function comment differ.
> Let's pick the best one, and use it everywhere.

fixed

>
> > +
> > +ObjectProperty *
> > +object_class_property_add_qapi(ObjectClass *klass,
> > +                               const char *name,
> > +                               const QAPITypeInfo *qapi_type,
> > +                               ObjectPropertyAccessor *get,
> > +                               ObjectPropertyAccessor *set,
> > +                               ObjectPropertyRelease *release,
> > +                               void *opaque);
>
> Likewise, except there's no function comment.  Can't fault your patch
> for that; the existing class property functions lack comments, too.  I
> do fault the code before your series, though: we have pairs of functions
> where we want people to use one, and document only the other.  Perhaps
> we could figure out how to transmit mild electric shocks via the
> keyboard to further deter the use of the better one?
>
> Do we want people to use QAPI-aware functions like these to define
> properties whenever possible?  I figure we do.  What about telling
> people in the comments?
>
> Function to add properties always come in pairs, one for properties tied
> to the class, and one for properties tied to the object.  Most users of
> the latter should use the former instead.  Questions for the QOM
> maintainers:
>
> 1. Is it time to stop requiring the latter?
>    object_property_add_qapi_enum() remains unused at the end of the
>    series...
>
> 2. Should the preferred one at least have a shorter name than the other
>    one?

There is certainly room for future improvements, I don't try to
address everything at once :)

>
> > +
> >  /**
> >   * object_property_add_tm:
> >   * @obj: the object to add a property to
>
> Just skimming the remainder for now.
>
> > diff --git a/qom/object.c b/qom/object.c
> > index a085e78557f..e5e2f09a0a2 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -24,6 +24,7 @@
> >  #include "qapi/forward-visitor.h"
> >  #include "qapi/qapi-builtin-visit.h"
> >  #include "qobject/qdict.h"
> > +#include "qapi/qapi-type-info.h"
> >  #include "qobject/qjson.h"
> >  #include "qemu/id.h"
> >  #include "qapi/qmp/qerror.h"
> > @@ -1717,6 +1718,15 @@ void object_property_set_default_str(ObjectPrope=
rty *prop, const char *value)
> >      object_property_set_default(prop, QOBJECT(qstring_from_str(value))=
);
> >  }
> >
> > +void object_property_set_default_enum(ObjectProperty *prop, int value)
> > +{
> > +    assert(prop && prop->qapi_type && prop->qapi_type->lookup);
> > +
> > +    object_property_set_default(prop, QOBJECT(qstring_from_str(
> > +        qapi_enum_lookup(prop->qapi_type->lookup, value)
> > +    )));
> > +}
> > +
> >  void object_property_set_default_list(ObjectProperty *prop)
> >  {
> >      object_property_set_default(prop, QOBJECT(qlist_new()));
> > @@ -1775,7 +1785,6 @@ int object_property_get_enum(Object *obj, const c=
har *name,
> >      char *str;
> >      int ret;
> >      ObjectProperty *prop =3D object_property_find_err(obj, name, errp)=
;
> > -    EnumProperty *enumprop;
> >
> >      if (prop =3D=3D NULL) {
> >          return -1;
> > @@ -1788,14 +1797,17 @@ int object_property_get_enum(Object *obj, const=
 char *name,
> >          return -1;
> >      }
> >
> > -    enumprop =3D prop->opaque;
> > -
> >      str =3D object_property_get_str(obj, name, errp);
> >      if (!str) {
> >          return -1;
> >      }
> >
> > -    ret =3D qapi_enum_parse(enumprop->lookup, str, -1, errp);
> > +    if (prop->qapi_type) {
> > +        ret =3D qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp=
);
> > +    } else {
> > +        EnumProperty *enumprop =3D prop->opaque;
> > +        ret =3D qapi_enum_parse(enumprop->lookup, str, -1, errp);
> > +    }
> >      g_free(str);
> >
> >      return ret;
> > @@ -2598,6 +2610,117 @@ object_class_property_add_enum(ObjectClass *kla=
ss, const char *name,
> >                                       prop);
> >  }
> >
> > +static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
> > +                          void *opaque, Error **errp)
> > +{
> > +    const QapiEnumProp *prop =3D opaque;
> > +    int value;
> > +    Error *err =3D NULL;
> > +
> > +    value =3D prop->get(obj, &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +
> > +    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
> > +}
> > +
> > +static void set_qapi_enum(Object *obj, Visitor *v, const char *name,
> > +                          void *opaque, Error **errp)
> > +{
> > +    const QapiEnumProp *prop =3D opaque;
> > +    int value;
> > +
> > +    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, err=
p)) {
> > +        return;
> > +    }
> > +    prop->set(obj, value, errp);
> > +}
> > +
> > +static void init_qapi_enum(Object *obj, ObjectProperty *prop)
> > +{
> > +    const QapiEnumProp *e =3D prop->opaque;
> > +
> > +    if (e->set && e->default_value >=3D 0) {
> > +        e->set(obj, e->default_value, &error_abort);
> > +    }
> > +}
> > +
> > +ObjectProperty *
> > +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *e)
> > +{
> > +    ObjectProperty *prop;
> > +
> > +    assert(e && e->qapi_type && e->qapi_type->lookup);
> > +
> > +    prop =3D object_property_add(obj, e->name, e->qapi_type->name,
> > +                               e->get ? get_qapi_enum : NULL,
> > +                               e->set ? set_qapi_enum : NULL,
> > +                               NULL,
> > +                               (void *)e);
> > +    prop->qapi_type =3D e->qapi_type;
>
> Shouldn't this wrap around object_property_add_qapi()?

ok

>
> > +    prop->description =3D g_strdup(e->description);
> > +    if (e->default_value >=3D 0) {
> > +        prop->init =3D init_qapi_enum;
> > +    }
> > +
> > +    return prop;
> > +}
> > +
> > +ObjectProperty *
> > +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnum=
Prop *e)
> > +{
> > +    ObjectProperty *prop;
> > +
> > +    assert(e && e->qapi_type && e->qapi_type->lookup);
> > +
> > +    prop =3D object_class_property_add(klass, e->name, e->qapi_type->n=
ame,
> > +                                     e->get ? get_qapi_enum : NULL,
> > +                                     e->set ? set_qapi_enum : NULL,
> > +                                     NULL,
> > +                                     (void *)e);
> > +    prop->qapi_type =3D e->qapi_type;
>
> Shouldn't this wrap around object_class_property_add_qapi()?
>
> > +    prop->description =3D g_strdup(e->description);
> > +    if (e->default_value >=3D 0) {
> > +        prop->init =3D init_qapi_enum;
> > +    }
> > +
> > +    return prop;
> > +}
> > +
> > +ObjectProperty *
> > +object_property_add_qapi(Object *obj, const char *name,
> > +                         const QAPITypeInfo *qapi_type,
> > +                         ObjectPropertyAccessor *get,
> > +                         ObjectPropertyAccessor *set,
> > +                         ObjectPropertyRelease *release,
> > +                         void *opaque)
> > +{
> > +    ObjectProperty *prop;
> > +
> > +    prop =3D object_property_add(obj, name, qapi_type->name,
> > +                               get, set, release, opaque);
> > +    prop->qapi_type =3D qapi_type;
> > +    return prop;
> > +}
> > +
> > +ObjectProperty *
> > +object_class_property_add_qapi(ObjectClass *klass, const char *name,
> > +                               const QAPITypeInfo *qapi_type,
> > +                               ObjectPropertyAccessor *get,
> > +                               ObjectPropertyAccessor *set,
> > +                               ObjectPropertyRelease *release,
> > +                               void *opaque)
> > +{
> > +    ObjectProperty *prop;
> > +
> > +    prop =3D object_class_property_add(klass, name, qapi_type->name,
> > +                                     get, set, release, opaque);
> > +    prop->qapi_type =3D qapi_type;
> > +    return prop;
> > +}
> > +
> >  typedef struct TMProperty {
> >      void (*get)(Object *, struct tm *, Error **);
> >  } TMProperty;
>


