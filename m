Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42927C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GbV-0002D0-De; Wed, 09 Sep 2026 07:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4GbU-0002Cs-0z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4GbR-0004YA-Th
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788953792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJrcWKTJ7s7JFPM1zwCHjQsySI9aXH4P8aoeyahpxHo=;
 b=VZbF+Nj08zZKCWgu/MeqGlZE3MM52n2jPdPfpH1qYPBmclg/egcXpOrzB+Nu54fnhdHKys
 tHxgi2los1nilf5YX4bbl4E1Zh6z7auSOZgVzAwkKzI29dc5otwVYBGRm6AykaJ+4dIVun
 lMjUDiQ5RLy4TmZy+yx9raPnN0AIZG0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-PIrQqQhIPmy8BcCiz1rxPA-1; Wed, 09 Sep 2026 07:36:29 -0400
X-MC-Unique: PIrQqQhIPmy8BcCiz1rxPA-1
X-Mimecast-MFC-AGG-ID: PIrQqQhIPmy8BcCiz1rxPA_1788953788
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4922b7c31so1955086a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 04:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788953788; cv=none;
 d=google.com; s=arc-20260327;
 b=emQrDQK/j6JJG9fFqL7xniISSCeVBV9zofBSn4WJtTGXhI2RNhRG8t7ayVNyvnb+7G
 xUPnvwPZuwGmrYselTieiEQK/wINf0RceJJHFVZt12bs4uhnxkK8Oo69K/T8nhBMVYwV
 EwAUsIL7V7Dg+rehSPJTS4DQ4eFJn1ea6sc+4AQ5diooioEcSZyqPaE+UC0d26jVB9Hj
 YkSpuZlqSXZWKdVIEJ1JSB9MT8YDMTZQpwkZeJN9qV1BxwwZT2h+JMIWanJsIA+xVNm8
 03as7R+GFz6p5m1RBXDlPwkhu4jVJicOF+hi9zYqTj/vJcIUFwjxaU4t1VQMHPSh5sFi
 GKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJrcWKTJ7s7JFPM1zwCHjQsySI9aXH4P8aoeyahpxHo=;
 fh=MSgXJWkfX6drgHhltmY4z9M9KmIuQLD56TEjfqsrTC8=;
 b=PRdRyNsmOrCHP8uDIxWPz1GXXHsqa9M+d6ExbZpn/3H91rzJwh4xZ07jJ8MG85XxvV
 VXIJU9Gkjo+PTWN0NR9wCogLnLlyqy4RRjtImlm4N+cwsFSDFDtgW3RjifLKBhBX1q7g
 EkbC2fCRimmVw0uGiVgad1YXIIf7C1cY/HtGtXXmhprmxFqXbAHvJaVc0EbU545XJN3L
 ms51DTK3sJXoCwGb1iu/0c72qtlJIYFteuiuqDg2Cg4+//T872JZF6OCyOEvW+ysqaNg
 S34V1SvJxhubMRp63E1QccrCDULKlcj5si/Tw5Za1ZsWB9fhyUkii/2fe9/V05YiifWu
 sIaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788953788; x=1789558588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vJrcWKTJ7s7JFPM1zwCHjQsySI9aXH4P8aoeyahpxHo=;
 b=S2A7rb5bpoPiaqSLeHRwLc0wANDg2YgQCKQzt9+G9T2mgYtAwhCyKP0xnJXdiUgMiI
 GsViAeLxsqhb7MoKYSUyCVoFHczyPU8+Xmrb9NuF9yvCKeRYV9MceQsShoNM/XvA8RpZ
 EZgbx/lZPRDcDBkwu2ZfN3yZsdEAAPTlTM9z69VsmKYoO+eYHihJOdqH6bmgz2GtjaUR
 fnh9TkB4mKSDS+7clge7JsbFVhXfzH6xWnqQ94Q1ARw+sDP5HB+nPkWVv6ObwnYnhro6
 NIiodNjph/mJbcLBJTIW3yvGC2leTkWgSgH4a/ROwd1ODfJdq3DlhtQQp1wcd6MUr80v
 VboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788953788; x=1789558588;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vJrcWKTJ7s7JFPM1zwCHjQsySI9aXH4P8aoeyahpxHo=;
 b=bvj5VvXwckZuwmqhb2DmOJWM8JzHvEWauh/Gt84DW/oqIPbSxJRYbTIJEduuOaJedx
 +ANHZVTKqRK9wOiInoVD3YLKcl+96NQYiIhww2ls0ffpx7lKCzDvRlaL/GIhL/Lsvk/X
 2UIMWHYIGn9pmbm1oNYW/FetW4ZkWv0+Jk29fkhHPtD/7r3DXzLmEekc+VHKykxgTQE6
 UIDy14MtQx+klCC+5+7Ez9RapkGxUGfMXMB3yBsUI9eSKyZvJHA3UbKWwp2BIBBRapUa
 qUF68m/aYFAfOdTouLEUfzjtMINC7p5MzCWu9HetNUxwHxfzYOAEe/iipZvCc4tU3obz
 R/tQ==
X-Gm-Message-State: AFuF++nE0r/3BwV986ek1NOfvF3Kw3d6BEWX+bGpektyhE6K0fVtm6tq
 mPR7mGpWaS1+p2wcUt5tqvpIy9uHfqhq5ifdqrRwAMhd6A8Y57JpsjoIB6JRorLMJ0TR8DZN2Wx
 Sh/GavvgHIoq9EEUWI7ZJliYohDT2J6F2bwq/xFIP7+xqRHDfXihsmTfS5o3aL7xxRGgNot+33n
 Lwd4B8Hinbw+7kRT8fVFATIbw8srNpoXs=
X-Gm-Gg: AYBFou0OsT4xh4S9Ei+NjVA9q37JRBRN/+FvkLPmszZVc35qnAoy5RemrehynaILFaB
 oP398XiBouUR1wwsCue6JQAQ2FGBs4/51E5F8RviZ+hduqd6WPbEMeJDgVOT82mDSdLeSzCOLmu
 wj1zZ/GzuYjO2wCgHlxDwN8YxY+ZEVcOBuovmAvDCZKy+Kd5x4Li92ZC/OISOpb+NrHqX87d/Mw
 NLF197vnLx1I+XAjFnXGBSpcS+rZ6S8BUfBSyUa5/yAjE0oFxHG97w1ss2VVOP7miVgNKXUnJsC
 4w==
X-Received: by 2002:a17:90b:5485:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39d70c2f16emr336044a91.24.1788953788285; 
 Wed, 09 Sep 2026 04:36:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5485:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39d70c2f16emr335959a91.24.1788953787750; Wed, 09 Sep 2026
 04:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-1-a985f168e938@redhat.com> <87v78en3s2.fsf@pond.sub.org>
In-Reply-To: <87v78en3s2.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 9 Sep 2026 15:36:16 +0400
X-Gm-Features: AcwNN1WsKG8coBuyTaVQqSSB-vqPKJAtPZOiT1pRbIAwqAZm_XPip7g7YRUi6O0
Message-ID: <CAMxuvayxNe1E4RRDZEhw6jbPqUMUPfbtia5gUtG8JUNU652Jbg@mail.gmail.com>
Subject: Re: [PATCH v4 01/75] qapi: add QAPITypeInfo struct definition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
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

On Wed, Sep 9, 2026 at 2:00=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Introduce a minimal struct that pairs a QAPI type's internal name with
> > its "masked" introspection name. Generated constants of this type will
> > let QOM property registration carry a reliable reference to the QAPI
> > schema and possibly other associated data.
> >
> > The fields are populated in following commits.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-inf=
o.h
> > new file mode 100644
> > index 000000000000..97eb1d7bf490
> > --- /dev/null
> > +++ b/include/qapi/qapi-type-info.h
> > @@ -0,0 +1,32 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef QAPI_TYPE_INFO_H
> > +#define QAPI_TYPE_INFO_H
> > +
> > +#include "qapi/util.h"
> > +
> > +/**
> > + * QAPITypeInfo - QAPI type metadata
> > + *
> > + * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
> > + *        QOM uses this as the property type string.
> > + * @masked_name: Name of the type in the QAPI introspection schema, as=
signed by
> > + *        scripts/qapi code generator (e.g. "368").
> > + *        NULL for implicit types.
>
> I believe the last sentence is inaccurate.  I can't see any QAPITypeInfo
> for implicit types, nor can I see any where .masked_name is null.

Only QType, but since it has no use we can drop it from generation for now.

>
> We discussed this in review of v2.  You asked whether I think it should
> be mandatory, but I neglected to answer (my apologies), so you didn't
> change anything for now.  Fair.
>
> If we really want to permit null, we need a more accurate comment.  If
> we don't, we can simply drop the sentence.
>
> I guess the remaining motivation to permit null here comes from QOM
> introspection [PATCH 08].  There, you add optional member @qapi-type to
> ObjectPropertyInfo, documented to be absent if the type does not occur
> in the output of query-qmp-schema.
>
> @qapi-type is optional so we can QAPIfy QOM properties one by one.
> Three cases:
>
> 1. Not QAPIfied: the property's ObjectPropertyInfo has no QAPITypeInfo
>    (member .qapi_type is null).  @qapi-type is absent.
>
> 2. Fully QAPIfied: it has a QAPITypeInfo, and its .masked_name is
>    non-null.  @qapi-type is .masked_name.
>
> 3. Badly QAPIfied: it has a QAPITypeInfo, but it's useless: .masked_name
>    is null.  @qapi-type is absent.
>
> The code to compute @qapi-type is written the obvious way, and the
> obvious way just works for all three cases.  Regardless, I don't think
> case 3 has a right to exist :)  Why would we bother to tack a
> QAPITypeInfo to ObjectPropertyInfo when it's useless?

ok, let's make masked_name mandatory

> The only reason I can imagine is QAPIfication in two steps where the
> first one tacks on the QAPITypeInfo, and the second one adds its
> .masked_name.  We go to case 2 via case 3.  But why would we do step one
> without step 2?  And if we do both, why not swap their order?
>
> Am I missing something?

No, any other review in the series before I send a new revision? :)
thanks

>
> > + * @lookup: QEnumLookup for this type, or NULL for non-enum types.
> > + *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
> > + *        all rely on it.
> > + * @list: The list-type counterpart, or NULL if none exists.
> > + *        str_type_info.list points to strList_type_info.  qdev array
> > + *        properties follow this to find the list type for their eleme=
nt.
> > + */
> > +typedef struct QAPITypeInfo {
> > +    const char *name;
> > +    const char *masked_name;
> > +    const QEnumLookup *lookup;
> > +    const struct QAPITypeInfo *list;
> > +} QAPITypeInfo;
> > +
> > +#endif /* QAPI_TYPE_INFO_H */
>


