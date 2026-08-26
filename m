Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5599C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAmR-0007so-31; Wed, 26 Aug 2026 06:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzAmQ-0007sf-2g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzAmO-00017b-CL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787739767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wJsDi3X9DBEqKZ+FhHD3UvMyqpseJ55yyJu0U9TaCA=;
 b=Un7883KB0Kk2a+60NX40O0nieOaGrD3wDsAguVBpQsHapia1nOTRVGy0kU4voIg5yntIUx
 tQHW219mWa0cHAhhc3JW7yetgF0/L/dbvIKt7sx/V5FGQvLpHmyZJr3i7nAagLTnaWEAbY
 WxbFgCViQg9XFCTBVFPd+IsISuHwIs8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-uo0RMaJkNUigfWn6boy70w-1; Wed, 26 Aug 2026 06:22:45 -0400
X-MC-Unique: uo0RMaJkNUigfWn6boy70w-1
X-Mimecast-MFC-AGG-ID: uo0RMaJkNUigfWn6boy70w_1787739764
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1c62f0d60so832017a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787739764; cv=none;
 d=google.com; s=arc-20260327;
 b=BrBbrVqXGRGNs8GDDtMPtCpjt7uoEmxDTjCIgSrEiUn0hXfrruuSqgMDXWeXns6Qba
 o0PvbPDqWcGjgEg02OpyZTrGzwe8TJkF8yzP9MnThRoVgvQyWK88azji6rG+UxKNRXhq
 4enfEXyQ6e0IMNQbmOa14nMv8VNqCixiPDObKn3PkRmeEv6f2Y8/ZKGsKIm20wqZ2EzG
 ns5SDnGUmoX7BGxd0eECM/td4qtWf7J6CZRKzEGPvI/y6LxmYgl1zSrmB5tijS3v9ufZ
 2pdViZBUvXA35ArhFbwG+Q4UA/PQBbknFQq11TiGZAphaKIr+ZPuu+4qgopE6c68JVqV
 jtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+wJsDi3X9DBEqKZ+FhHD3UvMyqpseJ55yyJu0U9TaCA=;
 fh=J9nwq/f/jn3wpHLRy+MvJWjA3+qyBHrTLBVB329Nuq8=;
 b=L1WxClrn5iRyXYpHabEjucGx2jL/Ieb+PTOypWA0P65SH4TeFfYxj1Kdc87Tf0zppB
 pJ2XTFfHnvk1/OFdlvLQF0FR7ix9PcXHeuVDC5ldJMQhw86cCRjgSLUeVwEgajNs9HC5
 i6LIL7hqXt6aLVI4TMgu/BjLpGbSrqsUlhDgdb7YXiakrmXmbpJo5VNpKropjg3MJOfZ
 PEfsRX7YyX31tNIy4bLNF2qT8IqxXr3tcg4b0ZCsfKFGt1/nqU+1MOOyIaOY/BjOzh31
 Ccqw188vcLoKunvt14utL1cyk7hc7oZ74x1NXMrsR8FngYm7FK2Ul8J0qxf/q1Fkcfyb
 Lovg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787739764; x=1788344564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+wJsDi3X9DBEqKZ+FhHD3UvMyqpseJ55yyJu0U9TaCA=;
 b=iWUGr0kQOEoCk6cQdmOb2ayyctfzHGjoj7M2kBk7aSqsJr/TSMBh8OBa5s8cvUh9Hc
 V6Z/5jpEmlzfq4DtvNCliuErsrrX7zIok/dVdTlz/gQKnkw69nXlIDBPwnEt+jETVfCE
 8jQcGwsuZ3uBttoU6C+FvCSVDh8UQmPPXP6NQHe7I7DfLCGyZ7539PGSxbndVers2wIA
 ertOTetw+0zMFl956c6MgKlK71fHyF1p0qYozGpsY0T9w4tAWhhttj1BMc1mCyLrOUV0
 YgNPCfDMUveD+cIzFpAcAJIyhUtllfgoWTBySjfU4fKMIPUMMeGpalL+ljch1IbitMGD
 CWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787739764; x=1788344564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+wJsDi3X9DBEqKZ+FhHD3UvMyqpseJ55yyJu0U9TaCA=;
 b=U6Kf8dsg01rvk7EZfApoXLDGPJ1QneEJOmvv0Lb5Jp/pjvr65gjrY8MIA/J5KtheNQ
 QYHhJmUGvCP7aVryC9p5i/pZJuBdu2hghTZoIPLP+T1cPJaZuu/zfVsRKdS83PIWys15
 wyKRZ48BAaV9/Hr108HwOQDmPz4Fcf68LkVrsQz2A8JaRaUDc7cYNPuoHAaE+YgiB/RJ
 dzX1L0QA/2KvOos3DtAD5B1+nu8oapsa5ZULTJQyjS5Vw147JR42ijquGorhG55OVhFz
 ZFpwNtcU8oFGC1FUU93PxS7z2zfriwXMgnTjYaqizgqegbndXyS/23iE+y054iwbaMZV
 kY9Q==
X-Gm-Message-State: AFuF++m6j7F69Aa2wb+bD8QSFu7gYHsI63+ufvBvnFx0X8zaPAJ0vxNu
 v691YECFyipwQnJ/p3Ki1OJNKbgE7depsWjnJkNPaFshluC5jEghrWWtbF0h8FVsG4ekXlFx4tR
 hg1Jp5k/k71KrKlmON9PpXMgd4Uy3N/wXZFfZtPZ2Dfqi9V9E0+XnKvQU6Xj5bxAxFHvrqvO+p5
 r9i9adWYf1PDUaZCPor9sCHEPYn/ZJtr8=
X-Gm-Gg: AR+sD13z5/3Gful4WsOuZNFc8LVbeobnE2tSSzohrU4IIUYVseUcfbXbhYwKbZcj8nT
 ihMFpwNcs5W6tZGblT8lf0s/7XnJrX49yiONIkGTKp26taJcRqEbQ5lP5ny9IIvXkzZXMOh2spR
 PaVqrQ9s1zDteq5EZ3EIaWKei5YLjKwM8vzFnUDjGCHo07H4Y7riH8aiy3OQ6gB62+L5jyWm4tq
 kHBqpqfijdCQcE74gl+xZlcTOC6eXESF1Db9p7WcYz3SRJ9Pm+I2CxRjreYvFgEamdEx6zsSUeI
 ag==
X-Received: by 2002:a05:6a21:7108:b0:3cc:ec12:a788 with SMTP id
 adf61e73a8af0-3cf7586e4c2mr11538327637.4.1787739764416; 
 Wed, 26 Aug 2026 03:22:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:7108:b0:3cc:ec12:a788 with SMTP id
 adf61e73a8af0-3cf7586e4c2mr11538204637.4.1787739763919; Wed, 26 Aug 2026
 03:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-9-24b8bbbe3d86@redhat.com>
 <19eda5fb-1cd6-48c3-bd7e-c121708d8cec@nutanix.com>
In-Reply-To: <19eda5fb-1cd6-48c3-bd7e-c121708d8cec@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 14:22:31 +0400
X-Gm-Features: AcwNN1VH5-4bKdg3za2y7ieRBwaNDyDP3x3KLomJ75jDN-_3uKIYUQhpRQqC5vA
Message-ID: <CAMxuvaxMsz+toKCyarLLQzcsS5xvksmYwYumObTZqfz9_P03Ug@mail.gmail.com>
Subject: Re: [PATCH v3 09/74] qom/qmp: populate qapi-type in QMP handlers
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 25, 2026 at 6:51=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 18/08/2026 12:10, Marc-Andr=C3=A9 Lureau wrote:
>
> > Wire up the new qapi-type field in all four QMP handlers that return
> > ObjectPropertyInfo or ObjectPropertyValue: qom-list, qom-list-get,
> > device-list-properties, and qom-list-properties.
> >
> > When an ObjectProperty has a qapi_type set, the masked QAPI type name
> > is copied into the response, allowing clients to cross-reference with
> > query-qmp-schema.
> >
> > No property has it yet, the following changes will populate it.
> >
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   qom/qom-qmp-cmds.c | 32 +++++++++++++++++++-------------
> >   1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > index 330895361d47..f9e6d4371cc5 100644
> > --- a/qom/qom-qmp-cmds.c
> > +++ b/qom/qom-qmp-cmds.c
> > @@ -25,9 +25,22 @@
> >   #include "qapi/qobject-input-visitor.h"
> >   #include "qapi/qobject-output-visitor.h"
> >   #include "qemu/cutils.h"
> > +#include "qapi/qapi-type-info.h"
> >   #include "qom/object_interfaces.h"
> >   #include "qom/qom-qobject.h"
> >
> > +static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
> > +{
> > +    ObjectPropertyInfo *info =3D g_new0(ObjectPropertyInfo, 1);
> > +
> > +    info->name =3D g_strdup(prop->name);
> > +    info->type =3D g_strdup(prop->type);
> > +    if (prop->qapi_type) {
> > +        info->qapi_type =3D g_strdup(prop->qapi_type->masked_name);
> > +    }
> > +    return info;
> > +}
>
> Any reason not to add info->description here? It seems to be set the
> same way in both cases below.

Indeed, we could factor this in the same function. The description &
default_value are not used by qmp_qom_list(), but this is harmless.
I'll add some patches.


>
> > +
> >   static Object *qom_resolve_path(const char *path, Error **errp)
> >   {
> >       bool ambiguous =3D false;
> > @@ -58,12 +71,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *pat=
h, Error **errp)
> >
> >       object_property_iter_init(&iter, obj);
> >       while ((prop =3D object_property_iter_next(&iter))) {
> > -        ObjectPropertyInfo *value =3D g_new0(ObjectPropertyInfo, 1);
> > -
> > -        QAPI_LIST_PREPEND(props, value);
> > -
> > -        value->name =3D g_strdup(prop->name);
> > -        value->type =3D g_strdup(prop->type);
> > +        QAPI_LIST_PREPEND(props, qom_property_info(prop));
> >       }
> >
> >       return props;
> > @@ -78,6 +86,9 @@ static void qom_list_add_property_value(Object *obj, =
ObjectProperty *prop,
> >
> >       item->name =3D g_strdup(prop->name);
> >       item->type =3D g_strdup(prop->type);
> > +    if (prop->qapi_type) {
> > +        item->qapi_type =3D g_strdup(prop->qapi_type->masked_name);
> > +    }
> >       item->value =3D object_property_get_qobject(obj, prop->name, NULL=
);
> >   }
> >
> > @@ -218,9 +229,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(=
const char *typename,
> >               continue;
> >           }
> >
> > -        info =3D g_new0(ObjectPropertyInfo, 1);
> > -        info->name =3D g_strdup(prop->name);
> > -        info->type =3D g_strdup(prop->type);
> > +        info =3D qom_property_info(prop);
> >           info->description =3D g_strdup(prop->description);
> >           info->default_value =3D qobject_ref(prop->defval);
> >
> > @@ -261,11 +270,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(co=
nst char *typename,
> >           object_property_iter_init(&iter, obj);
> >       }
> >       while ((prop =3D object_property_iter_next(&iter))) {
> > -        ObjectPropertyInfo *info;
> > +        ObjectPropertyInfo *info =3D qom_property_info(prop);
> >
> > -        info =3D g_malloc0(sizeof(*info));
> > -        info->name =3D g_strdup(prop->name);
> > -        info->type =3D g_strdup(prop->type);
> >           info->description =3D g_strdup(prop->description);
> >           info->default_value =3D qobject_ref(prop->defval);
>
> ATB,
>
> Mark.
>


