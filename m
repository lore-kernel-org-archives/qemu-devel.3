Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5070C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAmN-0007sV-Ip; Wed, 26 Aug 2026 06:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzAmL-0007rv-L1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzAmK-00014S-1Z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787739763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaCyjDjL7gtM7gDEpKad364sbvCNHXOPg1aXffn38ME=;
 b=dG1hPRnd7HUcCEA6PgyeQrpVHq6Cza7qMWqnV3v24Psd6iSgXexd894ldLeZFW/G0/1/k9
 lmrMqbVmoCl+djX0pn0Lua2XVelUGi55Z2eQ5/VIZ3djOa211iW5LUb9HMQiGkxFfq1owh
 m7OwY3TIg2S5M2O04L8iJhTl0gYWR68=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-pWyRlI18OEC8CW7qJ1z5Qg-1; Wed, 26 Aug 2026 06:22:39 -0400
X-MC-Unique: pWyRlI18OEC8CW7qJ1z5Qg-1
X-Mimecast-MFC-AGG-ID: pWyRlI18OEC8CW7qJ1z5Qg_1787739759
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1c5810451so786119a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787739759; cv=none;
 d=google.com; s=arc-20260327;
 b=Kv7CrrIYxubjdaKo++MTlbomZMCc+NFQGdksAWEzMQTicMqL1i3DHd6qwhOurHoVHj
 tn3JdRnt8aZwGuXqU0Ah/mH3HAKGZQVSWEpHGvA9+WwDiWheibc7tNnqbkdtlX7BN++j
 wjVgjXkJPmBN62SXQUSDVAuzH8dGjuc7DuFV6RF+//zBBS3NE5PZ5vSkMJVCbIMVHfLu
 XqYfyY707tixf04Sqs8rGwEnif5bV7+7nbdN+Z/vqTeYfGbP/ti6ZGwet94rtKp/xWvF
 alNU2hDE//qCharc8XFxxyo3NkPiHkoKvQ5DHQbvkh3RwwLq6TmYPq+0AQwqE1eV5LEW
 Vkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XaCyjDjL7gtM7gDEpKad364sbvCNHXOPg1aXffn38ME=;
 fh=J9nwq/f/jn3wpHLRy+MvJWjA3+qyBHrTLBVB329Nuq8=;
 b=FWSFPH1RbnGRkH77kZAN8XtSP+ulhb0BO7vx3pVBH1s6xejlwQJRYxKQk6n0ovhOw2
 r0wwpkMIArHs5j2yVJ9q6CKQ/ep1kWvXq/dp77dOYTJ9nfag08j+pHt8pulDZxPN0w/s
 OnTlP9FZ5ZjJiPtfU/+9aS5o1tdZTHyNX3XWB8iu3jvUyF2KrpgfaJt2K6CNMXuHNrdm
 kmHVl/9X+iYJ09I4vInlUe313s+wdIvKvVSwh7QzYlCqF+ePkqXtOWxXInoHCCEsTbkx
 dCHBZJTaRgsYUplfj/E8agraWGUWwrHes2MJHT69EZfBCpJMWO86HCYLJjMc49CKvY17
 uvBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787739759; x=1788344559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XaCyjDjL7gtM7gDEpKad364sbvCNHXOPg1aXffn38ME=;
 b=C9per7w7Ma5MF4+e1f+M0FL5EUcKQ7SnEeOptxjZ45Dfo70BZfWpSqOmmriQiN8UzG
 AFSoIvsXHLtlbztonEkGS54dZc8y4iA6jI79NK6mtRg3DHeZV7lgQonG2Jip+eEDlcjZ
 i3JjmRyfVCRzkFK23NRUTboDpUeArM5FUUlqtFdizr7yvNSr7RihZrKu1Oh0UfanMam3
 3BDb5v53u9lMzsPQaZWMTK3Yx7BMTOrPJQVF9b4nLKUhZS9FXvqpEvfGp7pNvYQLXPX4
 ZfJiGYgprS8oV+0IXiHQqd9gmjdTB/+bNql0P/9QP5WLx8e1AkD5K7+Ph9pgq8QFkM2C
 WLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787739759; x=1788344559;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XaCyjDjL7gtM7gDEpKad364sbvCNHXOPg1aXffn38ME=;
 b=r9RaCeGzXQk4At1WBYQWNfpoS4JBheZFl2GlYAWXnswI1Nvqm+CTTF6Fw/14mXB64B
 t1VWf/EfhsM0TYVfjgzR7psHDSRXEgU/Y8WPF+M1D+jYuevVaWysyR/IFWkQ/5LNT0TN
 vlyarZPKo24FjBb1VQJlom7XX+Np2vbEGGxB0Ifqh/S0uAhyhXppr+4MIDdOGVPOyosX
 aGJgRkrSyVcwPLfpRxL97PEX2bdlVZpdFhQ/5U7neiBuB6K/ueJemiz/DWks5+39oKQa
 9rFr23Ci7RH7Yp77cVSf/NiTtZZMOQzwonZlwigVK7ArkD6oTNC7c4cbn6ul5vv5Aof4
 188w==
X-Gm-Message-State: AFuF++nl5aBrAFNYmoPIRSUj8nSto0l11ZjDgpurZmRPkSWVy3b0sqK1
 rv4PuFFmbcXBKQ7rg/FEflcK1lb7+ErVCLphNe8kQcv6Z24z8GJrj0xWQnDtdJJh1+k8w60W8Qv
 ak+8OxqreI65BTL3+qnrpM58wlnDpLkuhgFs0D1ZwrgRczmcj6pNkpeL5r9sL0NgBRQrFv1j15q
 u39x8242KW+GhZAvhzSleI3ZFTAp9TiI0=
X-Gm-Gg: AR+sD11R8urar24im6vaXAutMYyDcoMskiJWkguUgVejt7KGrbrfX+4RQvXt/PRduMs
 gWIOl+Zv2i9/i6d6Kd0vH7mfeyhWeepCBP7GNLvW1lhe70lWvC+pLyksDgSt1QDBi+TXHVYtPWt
 smBBshFYQli5fxhBGLC+OQiviNLiOKEHAyEyOKjFw2dKh8saInRoUiSS+52iqKeM0SLvp+SwUIL
 YGWDpslQSoAexYpdIYo9LC1jKT4kqMKFCa2SqKi6pt3yGJF09+EHsKrnKeCHlG1iCeu/1v38a62
 sg==
X-Received: by 2002:a05:6a21:730e:b0:3cc:92d9:80cb with SMTP id
 adf61e73a8af0-3cf83c17b2bmr11756702637.12.1787739758612; 
 Wed, 26 Aug 2026 03:22:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:730e:b0:3cc:92d9:80cb with SMTP id
 adf61e73a8af0-3cf83c17b2bmr11756615637.12.1787739758141; Wed, 26 Aug 2026
 03:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-11-24b8bbbe3d86@redhat.com>
 <4a10c40f-7949-46d5-9457-e38a0e18ae40@nutanix.com>
In-Reply-To: <4a10c40f-7949-46d5-9457-e38a0e18ae40@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 14:22:26 +0400
X-Gm-Features: AcwNN1V8a7KMybrZZ0Ka3hhvX14d2rUV2Ro0lOBgdmGSORtMZuaFcxTfDhbE26A
Message-ID: <CAMxuvax3RKHiE_vPvkyeM3z4zj2pkzrFJ50mPWB3zHDqsMQYqA@mail.gmail.com>
Subject: Re: [PATCH v3 11/74] qom: add object_{class_}property_add_qapi
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

On Tue, Aug 25, 2026 at 6:56=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 18/08/2026 12:10, Marc-Andr=C3=A9 Lureau wrote:
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
> >   qom/object.c         | 32 ++++++++++++++++++++++++++++++++
> >   2 files changed, 68 insertions(+)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 271d736956da..9684db935d23 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1990,6 +1990,42 @@ ObjectProperty *object_class_property_add_enum(O=
bjectClass *klass,
> >                                       int (*get)(Object *, Error **),
> >                                       void (*set)(Object *, int, Error =
**));
> >
> > +/**
> > + * object_property_add_qapi:
> > + * @obj: the object to add a property to
> > + * @name: the name of the property
> > + * @qapi_type: QAPI type info descriptor
> > + * @get: The getter to be called to read a property.  If this is NULL,=
 then
> > + *   the property cannot be read.
> > + * @set: the setter to be called to write a property.  If this is NULL=
,
> > + *   then the property cannot be written.
> > + * @release: called when the property is removed from the object.  Thi=
s is
> > + *   meant to allow a property to free its opaque upon object
> > + *   destruction.  This may be NULL.
> > + * @opaque: an opaque pointer to pass to the callbacks for the propert=
y
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
> Don't forget to duplicate the same doc comments for
> object_class_property_add_qapi() below, otherwise
> object_class_property_add_qapi() doesn't get included in our
> auto-generated documentation (see commit 478542dd83 ("qom/object.h: add
> missing documentation for object_class_* property functions").

ok


>
> > +ObjectProperty *
> > +object_class_property_add_qapi(ObjectClass *klass,
> > +                               const char *name,
> > +                               const QAPITypeInfo *qapi_type,
> > +                               ObjectPropertyAccessor *get,
> > +                               ObjectPropertyAccessor *set,
> > +                               ObjectPropertyRelease *release,
> > +                               void *opaque);
> > +
> >   /**
> >    * object_property_add_tm:
> >    * @obj: the object to add a property to
> > diff --git a/qom/object.c b/qom/object.c
> > index 93d44a9444ca..1bfb6b933339 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -2595,6 +2595,38 @@ object_class_property_add_enum(ObjectClass *klas=
s, const char *name,
> >                                        prop);
> >   }
> >
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
> >   typedef struct TMProperty {
> >       void (*get)(Object *, struct tm *, Error **);
> >   } TMProperty;
> >
>
>
> ATB,
>
> Mark.
>


