Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5A4C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrwxr-00058f-V7; Thu, 06 Aug 2026 08:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wrwxq-00058X-G6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 08:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wrwxn-0002ng-Sz
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 08:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786018361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTOdZ3Rv90Wpre0tzyszSWlpCyECiPX4mVvrMk4VfJs=;
 b=KIwyDM4iEKjG3/KTN3Ravo0mpyFd3O04YYrPHE/xK/SgO9oW2YKnkvPGC6k8eXIW2cqwfX
 73E1FhrpGfbXBib/EK91wzT3foqpBN8kLQYakAl1IwSccJwXBxHjQcUJgBUMHoHE/wxFYw
 j4iJyXsj2y+tG+5rdUOq41pso6wc4Ho=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-GMKqypubOH6Yqxb28ZSppg-1; Thu, 06 Aug 2026 08:12:40 -0400
X-MC-Unique: GMKqypubOH6Yqxb28ZSppg-1
X-Mimecast-MFC-AGG-ID: GMKqypubOH6Yqxb28ZSppg_1786018359
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbe62e01567so1900725a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 05:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786018359; cv=none;
 d=google.com; s=arc-20260327;
 b=EOtXhNpLsXJky72VagS7EByT/bYn1y/l3e1sKn4NrDV5wfIvtFgBTDahghArnIgI5W
 W0FZ3+P8X9IFgDRGan/MMRilZgPyVvHyWWkYzecu4dpBH3Pn2S+HNjdSkdvazmwQvNjj
 FeoBYmnFMkaOcKG96Cb9igSQqZHmE3CWeOI752JmBo/Pr/1JZBMPFhsv93+fKOTKRHWE
 QzVWdCu61b3ONE1SptvU5b5kBVeoBmfjTlaijL8bhuDIA5tfAS+nOhJAw7JoXqS5mdM8
 P+6L67zrmR6CBAs5tpXZBTDSQQrX8vuz47+FM/IEFaUejvmkL3+MPRRRhwHzH9zW1cum
 CTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qTOdZ3Rv90Wpre0tzyszSWlpCyECiPX4mVvrMk4VfJs=;
 fh=N/a53auyBSlPhxW2d+MisueiZnXKQaZ12bFcdwnD2SY=;
 b=E+OqKHRrYrSEOO/op57YK1B0kfDgTRYgyT4dorW3AJDKAORQbNJeqEJCUFElCkgPuw
 HbtbM4kduNDKB32T0/MMaK0bFAX6Msl/3K1kspMlTKZOJmm7ULI4zCeJyYAyWV6RMqHd
 ti/dCcQ87/3wCwq9q3g7RmZTOh9nDcWxU4ILV84+Xu++xHGgMJH1JNeJg+tLRzfVWw82
 MXDZxEcVuDohrq60D7Oeug/E/Uluw3m72VxpSmX1IN89sGU9rGIYjZUiK/o/3SCg39HX
 ICduiMHBCo6Uu3QwLuwbdIfVW4jlZXzerMAa6SfKMhbyL9INuCRoYTiVEQJQwsBzund+
 Zsvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786018359; x=1786623159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qTOdZ3Rv90Wpre0tzyszSWlpCyECiPX4mVvrMk4VfJs=;
 b=szQeqfZEJmXy1qzl76oP95loEdHaIvKrtYhSxQJTYCoit/0aLJczQSizyiMvYCBeEb
 atHOjE18Ec0wEZDF+ANs5xfW9wIRD1q4tPbVF2axCXxbeVVti7GwlxQ1GB9U55tBuwQi
 xC7/VTHVj7DWApM6n22uT9NTAJPwh/92SvSiY6c4FZtwflEYD8/JvAHL1AKuMC93rhGP
 wJ89ZS2vx7PUjwmD2YPgTnTplKW9gs9HX90de/3mBxDivUiCIPrsBvJZzJ/dGFP/LDdg
 P7m1674nzzGAbTxPdgJv76sLj9Izw18U2TVr8gUw6eJE7OfgzQzOTwkru6u0zjos1KD8
 l0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786018359; x=1786623159;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qTOdZ3Rv90Wpre0tzyszSWlpCyECiPX4mVvrMk4VfJs=;
 b=CJhmwCCBJE8gW6jYY+Pk/+Z6J3gHY9ERpScBdkjs0+Lr51kAEW4Gy1jMbvOnhThVu8
 YzmEiEjZ1IX3gXlfqy/7h5whmK5QWDibe1KfO8kH8WxLXk+LiLrrD8rZ3OEOgOf/ffbB
 MwaKi1yp0NefQwocNDAe9oSTHMtBZtLus29dAQKfzYngX2Kz4OZweASgS6rvorZX0Z/h
 9BMPs9o3sDbn0HntYSJFfWxdt5qj2WFNIV48pbdQLmLkv+YNXfD8o3OtOxPHlWQ5tXHw
 L8BxhBqsOGTcn4qmsc0XdDzBEfVl//JFwKuRfAI3ntNzJTYCMmwhOP1S1t5SDZVk6peo
 mJzw==
X-Gm-Message-State: AOJu0YwpRfD2kemdQZWEk59Gw9PHOe9S575omnqQWKeBRBRqydY6fUuC
 C0UfW4rYVuQTh36R481yR/euIZMLUefHT8ydGH3IIDM6l0fdrQsHGHVOJzmtEzqakb/1rrMIhCe
 Z4Zi3gRAu/HUfsALiQTJ7t0lCyO1NK0ywlVR1Y7aK7XimPuUW1tD42UzZeSFVARhb6vzdLixqxj
 2DajEmjxLtP7UhqM29oE5BKtpTeDoOyGE=
X-Gm-Gg: AR+sD12Ri7NHmERzudwob3WOy4y6nMJpS6RTNiq9Yd2NVFzb1MmnPnY2auQ+utW5fSG
 gYYi181xu8CRRObVdNBBLZDojBkwhr/6F0DsMPTNvYe5qB7qtYcbZivechWhXI41hemIDMFiDrK
 hOqmoWb1E+Ci6o1RCChiGwl5QMPVpngyAmy25jVtK/lgm5sVT2IS4SPzDlKQf62x1WOZu1UGIWY
 lAXM1LN1G49x6WtJX9EUb6b84xTYy1Vy3xc7alYtRAyxyKTH7JsME36IC/lMT/efiI1tli+oSzc
 ig==
X-Received: by 2002:a05:6a00:a116:b0:847:439b:ae30 with SMTP id
 d2e1a72fcca58-84f2e04b336mr15287509b3a.20.1786018359043; 
 Thu, 06 Aug 2026 05:12:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:a116:b0:847:439b:ae30 with SMTP id
 d2e1a72fcca58-84f2e04b336mr15287421b3a.20.1786018358391; Thu, 06 Aug 2026
 05:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-2-cc9396b9c18c@redhat.com> <87v79nvatq.fsf@pond.sub.org>
In-Reply-To: <87v79nvatq.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 6 Aug 2026 16:12:26 +0400
X-Gm-Features: AUfX_myuxfiCPXM0_7yQMWg8raozu-R75AtucWdoOmQGMaIpr1KLMlxik6uFdJI
Message-ID: <CAMxuvaxeC3auTDQPaS=pxj3v2BOJypdsyFFe3v1iA-EERt0itA@mail.gmail.com>
Subject: Re: [PATCH v2 02/53] qapi/introspect: expose the type name map
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

On Thu, Aug 6, 2026 at 1:48=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Preserve the internal-to-masked name map computed during introspection
> > visitation and return it from gen_introspect(). The type-infos generato=
r
> > will consume this map to produce per-type QAPITypeInfo constants with
> > correct masked names.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/introspect.py | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> > index 7e28de2279a..d3d3de481f4 100644
> > --- a/scripts/qapi/introspect.py
> > +++ b/scripts/qapi/introspect.py
> > @@ -178,6 +178,7 @@ def __init__(self, prefix: str, unmask: bool):
> >          self._trees: List[Annotated[SchemaInfo]] =3D []
> >          self._used_types: List[QAPISchemaType] =3D []
> >          self._name_map: Dict[str, str] =3D {}
> > +        self._final_name_map: Dict[str, str] =3D {}
> >          self._genc.add(mcgen('''
> >  #include "qemu/osdep.h"
> >  #include "%(prefix)sqapi-introspect.h"
> > @@ -208,8 +209,17 @@ def visit_end(self) -> None:
> >          self._schema =3D None
> >          self._trees =3D []
> >          self._used_types =3D []
> > +        self._final_name_map =3D dict(self._name_map)
> >          self._name_map =3D {}
> >
> > +    def name_map(self) -> Dict[str, str]:
> > +        """Return the QAPI-name-to-schema-name map.
> > +
> > +        Must be called after visit() has completed; the map is
> > +        populated during visit_end().
> > +        """
> > +        return self._final_name_map
>
> Can you explain why ._final_name_map is useful?

We clear the map in visit_end(), so this is just keeping a copy of the
resulting map. But we could clear the map instead at visit_begin().
Sounds good?

>
> > +
> >      def visit_needed(self, entity: QAPISchemaEntity) -> bool:
> >          # Ignore types on first pass; visit_end() will pick up used ty=
pes
> >          return not isinstance(entity, QAPISchemaType)
> > @@ -387,7 +397,8 @@ def visit_event(self, name: str, info: Optional[QAP=
ISourceInfo],
> >
> >
> >  def gen_introspect(schema: QAPISchema, output_dir: str, prefix: str,
> > -                   opt_unmask: bool) -> None:
> > +                   opt_unmask: bool) -> Dict[str, str]:
> >      vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
> >      schema.visit(vis)
> >      vis.write(output_dir)
> > +    return vis.name_map()
>
> Returning QAPISchemaGenIntrospectVisitor's existing map through
> gen_introspect() works.
>
> Taking a step back...  QAPISchemaGenIntrospectVisitor computes the set
> of types that are actually used in QMP, and a map from type name to
> masked type name.  Back when I wrote the class, nothing else was
> interested in either of these two things, so keeping them within their
> only user made sense.
>
> Now you want masked type names for QAPISchemaGenTypeInfoVisitor.  And
> the doc generator could use the set of types used in QMP to trim the QMP
> reference manual.  Are these things still in the right place?
>
> If no: we can move them to a better place before or after this series.
> Before would be less churn in master, but more in your tree.  So perhaps
> you'd rather have it done afterwards.

Yes, it makes sense to have a common analysis visitor.


