Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EECAC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuPMT-0000eV-JW; Thu, 13 Aug 2026 02:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuPMP-0000e9-TD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wuPMO-0006Xl-1T
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786604175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dAWPZHvgbmCS2S1X3+ocYiL8FTFOsjHgTnEh82+wKE=;
 b=KEL66MO0wEuJ/uHlCisHxsokW1n6IAVoQ1G7sb5QwHgU5ulwQr6PMXor4lYtMygi8RKd3R
 WfRiPtL9GWh/zimppgRR9xGpZdN/d7FjRM2B4PTNKTy6ejDp9kJ5VpWmmAaSiad1SDbsyB
 qB/iT2HAdnIRe+2waVrC5/4uk17+vnA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-vnXxOiuVPJqipMF_J1w88w-1; Thu, 13 Aug 2026 02:55:58 -0400
X-MC-Unique: vnXxOiuVPJqipMF_J1w88w-1
X-Mimecast-MFC-AGG-ID: vnXxOiuVPJqipMF_J1w88w_1786604157
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848860def2cso514145b3a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 23:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786604157; cv=none;
 d=google.com; s=arc-20260327;
 b=hHS4i0w5y86z2m4jfNZHOTvsFa4HRpZ+azm2ItVCaT72dqnq106yLZTwGliWH6tCXd
 zXEdy4UXj6R8j+tk+WlhbfGfX1a72VGT/VJJgwf5S7wyWN4zfFIV8NN7OZKUagXmy2bJ
 LN2rkVlllnYU0eUDaMofHhQ6YoyN6zYotxvNThuJuGvGZ2rCMCCNHlGDVH0s6r+c4PL/
 SHFgjy1JUi7HKzuvuQ5F9wJy6+UwHS1OjK9Pw8MRtPqk8vuYpoYBu3J7jH1V2LvnKcpF
 nJukQlOb5P92iqIznWTTgDBU1UMHSq4LiN6a/+bvixyfJaFSDFNMabN+yPiA8CeIt1hf
 Ieog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8dAWPZHvgbmCS2S1X3+ocYiL8FTFOsjHgTnEh82+wKE=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=nKN74yKMqx3l2wE+kj2GsFVTbQs/ID0hHR0DDHXQW1N99A9JPdwD3F8wddPOA/UNv8
 RITYYoVKXzj7vx3gnBrznwTfWScoPrUFa1MKibXqZ/BL8wLzrqpaWs742vxmrBwU2rHA
 PZf30k5djFtdnlLtVrIV+sr/q/rzvFroYtNddnJlZj5OpChmyQayz+W0Tm0LWUVNhcdY
 wsS7jP7EEhbO2TKJcwN58Pm2+u9alxkSjgSlRCGYKg5EjFohDpfslcEUWmW52fOa7BEw
 h+Mtsy5zTdPoV2d8J7DkePbO8ERPo3duy1TiqjKulI/voDyDMW5kG6RwYb3oSWCWxmoW
 DIxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786604157; x=1787208957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8dAWPZHvgbmCS2S1X3+ocYiL8FTFOsjHgTnEh82+wKE=;
 b=DEYD5V2R0vJ1Hm4nhd906fYSOpYXybhUdxG1fGMK+XVHV1ZlW0iWdgh8/y13otDnL3
 cBoNvfDk+p9VKlTTv2TFISdzqswCpruuUT6tSixJijt4SqQskaU5MtunjQSGZw9Mb+zs
 4QpMtnx50n7n46fXnpEMJz26FUP2dLRUEQiYt2bhvm2K881tcP1kcR3zn/qcAPzJDTtp
 //m5XGZ0tTUmL2nun/kIyBRJVZtF9ALSLP+cAvOSshUbsaaRemDc+DDMouN2WKIHqzYU
 nOsEv+AGlxKqoeOprWYYNanMz04yLmuTyupCMPpQdQeMrm6lt8Wk7nYztK8BmizNDpJp
 zCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604157; x=1787208957;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8dAWPZHvgbmCS2S1X3+ocYiL8FTFOsjHgTnEh82+wKE=;
 b=G1k3+rfe725cIG3cxDjozmb62mzkORuzrlQ9+9QkzqF1lPllhtMliycNYwdIgVcXk5
 4m5jC/cKU3qU9nJ0IpW8bN11FELrOTPW0UZ8QvT13xkh9lDG0TSlz5lgtnEs8V6L1nsL
 RwgRJu3QwcpYeT3nvCKIO9RiEeclDxz7YLFcCFJE0QzRJUiKkD57kj5rxuhnlxI1Oxrr
 33LX/9fJwVlpd8V14Y5L1s0KKZtvcDT1znnsDvzDWYVfeJntQRB/SAVxmdQY6RkxDNDo
 gAOWQ/MDSBAlavjxYdjlGHoXhwEeGwI8l59dv5o6A16G/lnMa9UvJ89MII1cpyydXR4J
 Q2eg==
X-Gm-Message-State: AOJu0Yyn1TEogtsl5mnSyUzz3TDzROKAeW+WYTqOScarE1Ak6WFF8arl
 bxiR2MrpGZXa7dr9ZnUtdJpY2lhDSh7aE2/e4iYC5ziyS4dVh5qscdtDtx/U7u1U+1sUNC0IU7Z
 DhBTulAu3Lw6rX/HKfwz4VaQCEfXxCd/uDwTkXoivpU47CnIwVgMfM3+fghOGyNZw57Ve2KvwzH
 fe8TYjE0cn04JxmTd5h+Uj1C6NgyNefqY=
X-Gm-Gg: AR+sD12ZqnKvU74yuP352TFbDkU6caleB1pv0SMhGrDdQ3KczxsP6FU1JgguYo5IL1A
 s8oZiOR6XVmtEANTRT3E7ceQq5/NXcPw1jHNZHEoK6NodfnZyFjGhu5M+4hsipdTSkM7Z7diyz5
 KNPmipOCYmBJxX5GCk1pqti+Fczp2dbK40umkl73lhHMUFCT82RLV110Vq56rfEb0+0Yedu6Dq/
 nU4pMRSap3r3AktSvZtgsAjPjsclaT0oFFfej8lEwV9pAR0oUriMWUjTi6qRYCfl4ks277v+p3a
 XA==
X-Received: by 2002:a05:6a00:6c8e:b0:847:83bd:6671 with SMTP id
 d2e1a72fcca58-84fc6e286e4mr4094249b3a.19.1786604157085; 
 Wed, 12 Aug 2026 23:55:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c8e:b0:847:83bd:6671 with SMTP id
 d2e1a72fcca58-84fc6e286e4mr4094189b3a.19.1786604156513; Wed, 12 Aug 2026
 23:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-1-cc9396b9c18c@redhat.com> <87mrv78jwb.fsf@pond.sub.org>
In-Reply-To: <87mrv78jwb.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Aug 2026 10:55:45 +0400
X-Gm-Features: AUfX_mwZ0sy5qfDtgHilGyvbgeHRn6od5jPRmF1rwvNeqAIfSHZYYP2ip0kmTeo
Message-ID: <CAMxuvax5Bnz7fK9DE+jWBfYg2ZX=YYA4W-j9gzU4gJmRTQVToQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/53] qapi: add QAPITypeInfo struct definition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

giHi

On Fri, Jul 31, 2026 at 3:43=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Introduce a minimal struct that pairs a QAPI type's internal name with
> > its "masked" introspection name. Generated constants of this type will
> > let QOM property registration carry a reliable reference to the QAPI
> > schema and possibly other associated data.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-inf=
o.h
> > new file mode 100644
> > index 00000000000..a7a470af731
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
> > + * @schema_name: Name of the type in the QAPI introspection schema, as=
signed by
> > + *        scripts/qapi/introspect.py (e.g. "368"). NULL for builtin ty=
pes not
> > + *        individually present in the schema.
>
> "Schema" is ambiguous here: there's the QAPI schema
> (e.g. qapi/qapi-schema.json and its sub-modules), and the SchemaInfo
> returned by query-qmp-schema.  Could well lead to confusion.
>
> What about @masked_name?

works for me

>
> > + * @lookup: QEnumLookup for this type, or NULL for non-enum types.
> > + *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
> > + *        all rely on it.
>
> Not yet.  Either mention that in the commit message, or add the member
> later, when the comment is correct.
>
> > + * @list: The list-type counterpart, or NULL if none exists.
> > + *        str_type_info.list points to strList_type_info.  qdev array
> > + *        properties follow this to find the list type for their eleme=
nt.
>
> Likewise.

ok

>
> > + */
> > +typedef struct QAPITypeInfo {
> > +    const char *name;
> > +    const char *schema_name;
> > +    const QEnumLookup *lookup;
> > +    const struct QAPITypeInfo *list;
> > +} QAPITypeInfo;
> > +
> > +#endif /* QAPI_TYPE_INFO_H */
>
> This is somewhat related to SchemaInfo, which is also meta-data about
> QAPI types (and also commands and events).
>
> SchemaInfo only has the masked name[*].  It has a reference from array
> type to element type instead of the other way round.  Everything else in
> QAPITypeInfo is also in SchemaInfo, I believe.
>
> So far, QEMU uses SchemaInfo only around qmp_query_qmp_schema().
> qmp_query_qmp_schema() a SchemaInfoList on the fly from something else,
> and the QMP core (it's only caller) then converts it via QObject to a
> string reply.
>
> Now I need to digress into history a bit.
>
> The value of query-qmp-schema is fixed at compile time.  My initial
> version simply generated the fixed reply as string.  Efficient, because
> it doesn't build a (bulky!) QObject reply.  Also a bit hacky.
>
> This got in the way of QAPI 'if' conditionals, so commit 7d0f982b
> switched to a pointer-less variation of the QObject that can be
> generated as data more easily: QLitObject[].  query-qmp-schema converts
> this to QObject every time it runs.  The QLitObject[] would be awkward
> to use for anything else.
>
> End of digression.
>
> I wonder whether it could make sense to have a single repository of QAPI
> type meta data, usable both for query-qmp-schema and for your QOM work.
> Something QOM could use about as easily as QAPITypeInfo, and
> query-qmp-schema could convert to its reply.
>
> At this time, this is an idea phrased as a question.  Is it a good idea?
> I'm not sure.  Even if it is, I'm not sure it should be implemented
> right away.  I'm just sharing the idea.

I am not sure what you mean by "a single repository of QAPI type
metadata". Whatever it is, I don't think it is required for this
series. If you mean that we could generate one big structure holding
all QAPI metadata, that sounds challenging and it's not clear to me
what the benefit would be, beside a bit of memory saving.


