Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E073C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypQH-0001Sn-4A; Tue, 25 Aug 2026 07:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wypQF-0001S8-E5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wypQD-0007rm-Nw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xt7svKkxBYzoSM6JneoVpTjWZ1O7QHW2QkqUyWVEvFk=;
 b=fPY+Yl9tPogRtEpSeLKJZdvP7XU12now+lgGyQMFtU4vr5IET/8lK7WGoPgJBBdVeZ8J1V
 BTVCYooWGHwmgvSkKlDC1mzR0RQPw1/6TtaOJQVIWjoNnbGF+AzBW0sSL07aZlP4/5YKHJ
 BVfBrSisjQjCUyn5cINAx25/9ZcxILY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-IU1hmIayMIy9AwiD-giJWQ-1; Tue,
 25 Aug 2026 07:34:27 -0400
X-MC-Unique: IU1hmIayMIy9AwiD-giJWQ-1
X-Mimecast-MFC-AGG-ID: IU1hmIayMIy9AwiD-giJWQ_1787657666
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4D0419560AD; Tue, 25 Aug 2026 11:34:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 442E518005B3; Tue, 25 Aug 2026 11:34:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE83521E6920; Tue, 25 Aug 2026 13:34:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v3 01/74] qapi: add QAPITypeInfo struct definition
In-Reply-To: <CAMxuvaw+_7GD5x36g0zxR+zA1pVDcK1j9dT499qa=_D1=UgPMQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 21 Aug 2026
 19:33:43 +0400")
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-1-24b8bbbe3d86@redhat.com>
 <87cxvbzj4n.fsf@pond.sub.org>
 <CAMxuvaw+_7GD5x36g0zxR+zA1pVDcK1j9dT499qa=_D1=UgPMQ@mail.gmail.com>
Date: Tue, 25 Aug 2026 13:34:22 +0200
Message-ID: <87y0dul9hd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Hi
>
> On Fri, Aug 21, 2026 at 5:41=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Introduce a minimal struct that pairs a QAPI type's internal name with
>> > its "masked" introspection name. Generated constants of this type will
>> > let QOM property registration carry a reliable reference to the QAPI
>> > schema and possibly other associated data.
>> >
>> > The fields are populated in following commits.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
>> >  1 file changed, 32 insertions(+)
>> >
>> > diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-in=
fo.h
>> > new file mode 100644
>> > index 000000000000..97eb1d7bf490
>> > --- /dev/null
>> > +++ b/include/qapi/qapi-type-info.h
>> > @@ -0,0 +1,32 @@
>> > +/*
>> > + * SPDX-License-Identifier: GPL-2.0-or-later
>> > + */
>> > +
>> > +#ifndef QAPI_TYPE_INFO_H
>> > +#define QAPI_TYPE_INFO_H
>> > +
>> > +#include "qapi/util.h"
>> > +
>> > +/**
>> > + * QAPITypeInfo - QAPI type metadata
>> > + *
>> > + * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
>> > + *        QOM uses this as the property type string.
>> > + * @masked_name: Name of the type in the QAPI introspection schema, a=
ssigned by
>> > + *        scripts/qapi code generator (e.g. "368").
>>
>> Suggest 'Name of the type in output of query-qmp-schema (e.g. "368")'.
>>
>
> ok
>
>> > + *        NULL for implicit types.
>>
>> Can this happen?  I can't see any QAPITypeInfo with null @masked_name at
>> the end of the series.
>
> It's still optional, but it's true that at the end of the series it
> should be set for all generated type infos. Let's just say "or NULL if
> unavailable" ?

I can't find a QAPITypeInfo without @masked_name at any point in the
series.

Either it cannot happen.  Then the comment shouldn't suggest it can.

Or it can happen, but doesn't with the current schema.  Then I'd like to
have know how it could happen.  Any ideas?

[...]


