Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1F8C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRFu-0007Ln-JJ; Fri, 21 Aug 2026 11:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wxRFs-00073J-U5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wxRFq-0000TF-Cm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787326440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPf9G3nzo9wrCtpdGUazYn4aORoFrlw5QPyTooEM5R8=;
 b=jT/3S1MuptmRSl1o9jHmAG0kNVmKQpZAHYHpHzc3dC0IqyDmi6jqZgmi2oQFDQtNtF83e6
 JyIiAQqhI3/YbzjQrs+JNmfA92p9Tx3dBRuegEjAMnJd3+2dFDQvTdjEpbUp2qCCceja8V
 lKxeMncmSHklahnNQOQCqUHF+QOc7GM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-BR9pjZFrNdOZtSsrWgSxnw-1; Fri, 21 Aug 2026 11:33:57 -0400
X-MC-Unique: BR9pjZFrNdOZtSsrWgSxnw-1
X-Mimecast-MFC-AGG-ID: BR9pjZFrNdOZtSsrWgSxnw_1787326436
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso1127716a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 08:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787326436; cv=none;
 d=google.com; s=arc-20260327;
 b=h9YNF9nBRgsVIAbTr8FeJXlLlv4+npLZN0Kb55/WwNy/PAQP1z0/AAcQLgzSLOICft
 L/28f9oR0LziUwFcOuop2ARTULqEo0J1umhbyyXOy/kGBZ0VTG4vyh3ZX1dWJfNz0rUn
 hPZDiL19BeSZjDJeBkRDCwDn4jJYQgEMuGiIDeCUVCwo0FpiuELqjM9GF4iCnExYzdtJ
 tQ5RBRI9qCRLKUgJZqBn1iG/V1EJelSAPbTZqkfOSjrQoX8ha1VxvFSnKwGNmuXyFjjG
 QWGHrcC6+0nywm/JDccCjbotuIcvDl4TX+ucx0x3AF/gq+oE0yA77PN7VJz6oUqgiITd
 F+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NPf9G3nzo9wrCtpdGUazYn4aORoFrlw5QPyTooEM5R8=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=qWUAFW37Ho5xEDPJalCHD3WQtUOOS4eOxyopFyzrqojO991X4pmXjC/E1l+8qionf/
 QbcIiLUwd6oIV3LgLijk9gA28Z60VJ8ax/PHExg9Byo9A6UUNWDTGxzTuPLuvU6v2dCM
 3OzBz6OvFPsN3Dvb8QQsRBXJJvxa6Li9IE8ucWsnViUOXOz/MSvfvghv2gnu0ZSV4VM5
 kvRz1bNeT/HHTImFyswqq6TDE1PZ8z490ckkdV3UhHo0Rhii1uXwQ/rcC6XANyk9wZuy
 9CYWjxih0ToJkta02oE6sIrQ0IugywJ54tJh2xvhL5j6am0yuc6dZkYgaLXIefk0Gvuz
 zVmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787326436; x=1787931236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NPf9G3nzo9wrCtpdGUazYn4aORoFrlw5QPyTooEM5R8=;
 b=EhV+BKSkg90N/7Z5rOQEj/oWMtV4wqbgtYB4cFRZn6ok5pLkeXY0inkE1UhRaIY01N
 EW4uXb6GQMx3pXt6Q5A0QvFIe1ky9Gzx6b0rFw9oGF7Q7ZY+1ENAW4wiJB5LFA3QbxSd
 ixUaGGg55q38WIfoBZ9jeHi/BJRp8kmdg0vZGbtH5E/dPuYNlB/qWuwuoTPAS6i3XRUL
 yphDOMOfXcXj7zFbmSdfyedvk+mq9T7kjFdjrQqgSQb8VLmX7JSSOjCLQcF06VyjQ78u
 UGtztItYX9IhrCyA4hGR/BSapHL1dZjR1LZwEd29vFOwH2hWl753ZvNFRsnFeJf0U8AZ
 1rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787326436; x=1787931236;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NPf9G3nzo9wrCtpdGUazYn4aORoFrlw5QPyTooEM5R8=;
 b=OOsq4nesojf8hhC0m3VK0mnW1m+5nZWT0NR9mTRNCwfjPfBmT/o5gsBxWluFu8b3Xd
 77nq9Yf1uHLSeSxuhU8CzEh9VJK/iVKTSSkrNPHiLgXid7XFRm09TPlK/uNxkh8lFsFg
 xiEk210JNudSuJtT08euQZjtoqUHsS600R52lmwSqfCnWWXqrkjUGFLNNzmaPqWQWN82
 +W3vo5sey5m+zjDQnLswo5eyUMz4B/7iQevLy9Oel22/ll/5cjFYiDy9yrwH1b+/N1eC
 +wRX9vrx/XiZA9qZlgUXXIC7+ZzgFn9XsU5dXEgBMhfEVrm9u/4CJ0abYV1iZmLfG7dn
 uExQ==
X-Gm-Message-State: AOJu0YytPl9hbo9KMxvzJJFm4oYBQ2KhLmsEyrk4oaLIg9vZP2kg6PeX
 C6f+rTRApmWej2EBkqI1S+DeqLggKH+R733GoPU4PaaPVEcwAD1YnCHx7VQGKJhKP+yCwFMjEpl
 SVzJUqUi+9LNsjPenBsHAH4tMncOuEEPshbuFhH3lsJkb2jGPfcH/g9WhJDRwNftbmrlfQu9+MI
 RIWwNcRyZL0dCbzDWDg2JygUuWPLIbjMw=
X-Gm-Gg: AR+sD12NUnUdYV3J2VThuOeHen3p0hGk3TXiiYErWGP7kBP5iT4JHi7ifO0pw4XIHwl
 o/JaGLpEXS2eFxcZrDw1Qz2QKKIluDY2GIr+YqhQ21NapTVilKKtxu9BToNQHFKE57FRrCl7O1Y
 8hqZi0ozColFqkmxbew5IHlp5m1oy0uMmw6PKCD4tFbD9ApKJIVO+4XStOy1yZovqmXjo9XCMC7
 8JbRxCQO5AEw7+BarYrGlF4hSs2t3F7iSDK2wy1b4QaNJq8KvlxrUzlwrP/yUA/Diq7Q6b6hGId
 PA==
X-Received: by 2002:a05:6a21:1f87:b0:3cc:9288:99aa with SMTP id
 adf61e73a8af0-3cd2f9e978dmr15542872637.0.1787326436394; 
 Fri, 21 Aug 2026 08:33:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f87:b0:3cc:9288:99aa with SMTP id
 adf61e73a8af0-3cd2f9e978dmr15542711637.0.1787326435733; Fri, 21 Aug 2026
 08:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-1-24b8bbbe3d86@redhat.com> <87cxvbzj4n.fsf@pond.sub.org>
In-Reply-To: <87cxvbzj4n.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Aug 2026 19:33:43 +0400
X-Gm-Features: AcwNN1WV-5tDhsXBTxQkcYdHCdTuT7u1gO3S9n5Vb6ag2BtvYdiaMabCBAwwj98
Message-ID: <CAMxuvaw+_7GD5x36g0zxR+zA1pVDcK1j9dT499qa=_D1=UgPMQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/74] qapi: add QAPITypeInfo struct definition
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
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Fri, Aug 21, 2026 at 5:41=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
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
>
> Suggest 'Name of the type in output of query-qmp-schema (e.g. "368")'.
>

ok

> > + *        NULL for implicit types.
>
> Can this happen?  I can't see any QAPITypeInfo with null @masked_name at
> the end of the series.

It's still optional, but it's true that at the end of the series it
should be set for all generated type infos. Let's just say "or NULL if
unavailable" ?

>
> > + * @lookup: QEnumLookup for this type, or NULL for non-enum types.
>
> Maybe ', null unless it's an enum type'.

ok

>
> > + *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
> > + *        all rely on it.
>
> "It" is ambiguous: is it the @lookup pointer or the struct it points to?
> The latter is correct.
>
> Is the sentence useful?
>

Let's drop it

thanks

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


