Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D2C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4F6A-0004Ek-W5; Wed, 09 Sep 2026 06:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4F69-0004Af-If
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4F67-0005M6-OZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788948005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlVZnfzZZF6mVWZTgem0c7rwpPcXXMpJswdinmmKeGc=;
 b=gXEDe8w+24znA3fc7QVdN0GQw8CMef0jUsICZna0BdqVzvLe1Yx809i/Hcj54hBKRwybh5
 A/5+48ScOArnhubUuaJxfyTLJ0w2wEQuGrtV6x8GQ2/doPMhJbaSbjfQDcpN2AGGGHa9w1
 AAYhLIjXbv1tXrkjEAXS4fLrr4uY1Vk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-yvIiyrc-PYyPx6U1tXulmw-1; Wed,
 09 Sep 2026 06:00:01 -0400
X-MC-Unique: yvIiyrc-PYyPx6U1tXulmw-1
X-Mimecast-MFC-AGG-ID: yvIiyrc-PYyPx6U1tXulmw_1788948000
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 336271955F1C; Wed,  9 Sep 2026 10:00:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C96B218004D4; Wed,  9 Sep 2026 09:59:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EB5421E6A04; Wed, 09 Sep 2026 11:59:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v4 01/75] qapi: add QAPITypeInfo struct definition
In-Reply-To: <20260904-qom-qapi-v4-1-a985f168e938@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 04 Sep 2026 23:57:44 +0400")
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-1-a985f168e938@redhat.com>
Date: Wed, 09 Sep 2026 11:59:57 +0200
Message-ID: <87v78en3s2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> The fields are populated in following commits.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
> new file mode 100644
> index 000000000000..97eb1d7bf490
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
> + * @masked_name: Name of the type in the QAPI introspection schema, assi=
gned by
> + *        scripts/qapi code generator (e.g. "368").
> + *        NULL for implicit types.

I believe the last sentence is inaccurate.  I can't see any QAPITypeInfo
for implicit types, nor can I see any where .masked_name is null.

We discussed this in review of v2.  You asked whether I think it should
be mandatory, but I neglected to answer (my apologies), so you didn't
change anything for now.  Fair.

If we really want to permit null, we need a more accurate comment.  If
we don't, we can simply drop the sentence.

I guess the remaining motivation to permit null here comes from QOM
introspection [PATCH 08].  There, you add optional member @qapi-type to
ObjectPropertyInfo, documented to be absent if the type does not occur
in the output of query-qmp-schema.

@qapi-type is optional so we can QAPIfy QOM properties one by one.
Three cases:

1. Not QAPIfied: the property's ObjectPropertyInfo has no QAPITypeInfo
   (member .qapi_type is null).  @qapi-type is absent.

2. Fully QAPIfied: it has a QAPITypeInfo, and its .masked_name is
   non-null.  @qapi-type is .masked_name.

3. Badly QAPIfied: it has a QAPITypeInfo, but it's useless: .masked_name
   is null.  @qapi-type is absent.

The code to compute @qapi-type is written the obvious way, and the
obvious way just works for all three cases.  Regardless, I don't think
case 3 has a right to exist :)  Why would we bother to tack a
QAPITypeInfo to ObjectPropertyInfo when it's useless?

The only reason I can imagine is QAPIfication in two steps where the
first one tacks on the QAPITypeInfo, and the second one adds its
.masked_name.  We go to case 2 via case 3.  But why would we do step one
without step 2?  And if we do both, why not swap their order?

Am I missing something?

> + * @lookup: QEnumLookup for this type, or NULL for non-enum types.
> + *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
> + *        all rely on it.
> + * @list: The list-type counterpart, or NULL if none exists.
> + *        str_type_info.list points to strList_type_info.  qdev array
> + *        properties follow this to find the list type for their element.
> + */
> +typedef struct QAPITypeInfo {
> +    const char *name;
> +    const char *masked_name;
> +    const QEnumLookup *lookup;
> +    const struct QAPITypeInfo *list;
> +} QAPITypeInfo;
> +
> +#endif /* QAPI_TYPE_INFO_H */


