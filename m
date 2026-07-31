Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C530CC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wple2-0007sp-Q9; Fri, 31 Jul 2026 07:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wpldu-0007sB-49
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wplds-0007z1-D8
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785498186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxuW/2r0U4Qe74Ikieml7ZXpyhkAlEPUGiAW1W1vJ54=;
 b=gQOE4+NLNELDIP6fdxxgQW47gM9HsaNdIswJB5HCS0n85zFyIxfyO5yYuVz2TTVcNCTz96
 0P/VMD6NYPKingCR2ws3ntHVe/E14wjLF8cOdgNN65FJwow7SI4Z+3RK0dFRl5FI8idhOG
 /EXEsnZRW9dfeGjSKUp4WG2aqI+kNVE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-jdphRHFEP1CvaRDFpPCKug-1; Fri,
 31 Jul 2026 07:43:05 -0400
X-MC-Unique: jdphRHFEP1CvaRDFpPCKug-1
X-Mimecast-MFC-AGG-ID: jdphRHFEP1CvaRDFpPCKug_1785498184
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7D31956089; Fri, 31 Jul 2026 11:43:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3254219560AB; Fri, 31 Jul 2026 11:43:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B873421E6920; Fri, 31 Jul 2026 13:43:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 01/53] qapi: add QAPITypeInfo struct definition
In-Reply-To: <20260616-qom-qapi-v2-1-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:37:27 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-1-cc9396b9c18c@redhat.com>
Date: Fri, 31 Jul 2026 13:43:00 +0200
Message-ID: <87mrv78jwb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

> Introduce a minimal struct that pairs a QAPI type's internal name with
> its "masked" introspection name. Generated constants of this type will
> let QOM property registration carry a reliable reference to the QAPI
> schema and possibly other associated data.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
> new file mode 100644
> index 00000000000..a7a470af731
> --- /dev/null
> +++ b/include/qapi/qapi-type-info.h
> @@ -0,0 +1,32 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QAPI_TYPE_INFO_H
> +#define QAPI_TYPE_INFO_H
> +
> +#include "qapi/util.h"
> +
> +/**
> + * QAPITypeInfo - QAPI type metadata
> + *
> + * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
> + *        QOM uses this as the property type string.
> + * @schema_name: Name of the type in the QAPI introspection schema, assi=
gned by
> + *        scripts/qapi/introspect.py (e.g. "368"). NULL for builtin type=
s not
> + *        individually present in the schema.

"Schema" is ambiguous here: there's the QAPI schema
(e.g. qapi/qapi-schema.json and its sub-modules), and the SchemaInfo
returned by query-qmp-schema.  Could well lead to confusion.

What about @masked_name?

> + * @lookup: QEnumLookup for this type, or NULL for non-enum types.
> + *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
> + *        all rely on it.

Not yet.  Either mention that in the commit message, or add the member
later, when the comment is correct.

> + * @list: The list-type counterpart, or NULL if none exists.
> + *        str_type_info.list points to strList_type_info.  qdev array
> + *        properties follow this to find the list type for their element.

Likewise.

> + */
> +typedef struct QAPITypeInfo {
> +    const char *name;
> +    const char *schema_name;
> +    const QEnumLookup *lookup;
> +    const struct QAPITypeInfo *list;
> +} QAPITypeInfo;
> +
> +#endif /* QAPI_TYPE_INFO_H */

This is somewhat related to SchemaInfo, which is also meta-data about
QAPI types (and also commands and events).

SchemaInfo only has the masked name[*].  It has a reference from array
type to element type instead of the other way round.  Everything else in
QAPITypeInfo is also in SchemaInfo, I believe.

So far, QEMU uses SchemaInfo only around qmp_query_qmp_schema().
qmp_query_qmp_schema() a SchemaInfoList on the fly from something else,
and the QMP core (it's only caller) then converts it via QObject to a
string reply.

Now I need to digress into history a bit.

The value of query-qmp-schema is fixed at compile time.  My initial
version simply generated the fixed reply as string.  Efficient, because
it doesn't build a (bulky!) QObject reply.  Also a bit hacky.

This got in the way of QAPI 'if' conditionals, so commit 7d0f982b
switched to a pointer-less variation of the QObject that can be
generated as data more easily: QLitObject[].  query-qmp-schema converts
this to QObject every time it runs.  The QLitObject[] would be awkward
to use for anything else.

End of digression.

I wonder whether it could make sense to have a single repository of QAPI
type meta data, usable both for query-qmp-schema and for your QOM work.
Something QOM could use about as easily as QAPITypeInfo, and
query-qmp-schema could convert to its reply.

At this time, this is an idea phrased as a question.  Is it a good idea?
I'm not sure.  Even if it is, I'm not sure it should be implemented
right away.  I'm just sharing the idea.


[*] The QAPI generator has an option to make it have only the unmasked
names.  Occasionally convenient when messing around.


