Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2750C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woyiT-0004u1-Bs; Wed, 29 Jul 2026 03:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1woyiR-0004tp-Pj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:28:35 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1woyiQ-00068I-0k
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:28:35 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f309d00f7e2f10e9352f5e8.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f30:9d00:f7e2:f10e:9352:f5e8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id BD2591FF19
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 09:28:48 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F20721E6920; Wed, 29 Jul 2026 09:28:23 +0200 (CEST)
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/54] qom/qdev: associate properties with QAPI schema
 types
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Sun, 10 May 2026 17:42:57 +0400")
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
Date: Wed, 29 Jul 2026 09:28:23 +0200
Message-ID: <878q6us19k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
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
Reply-to:  Markus Armbruster <armbru@redhat.com>
From:  Markus Armbruster via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I started writing this reply right when I saw the series, i.e. an
embarrassingly long time ago.  Then stuff happened, some of it good,
some bad, this review got crowded out, and my memory purged.

I sincerely apologize for the massive delay.

Naturally, this needs a rebase now.  But let me try to review it as is.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> This series connects QOM and qdev properties to the QAPI type system, so
> that management tools can discover the QAPI schema type of each object
> property.

Sounds lovely!

> Today, QOM properties carry a free-form "type" string ("bool", "uint32",
> "OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
> query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
> on naming conventions to figure out how to interpret property values.

Correct.

Before I dive into individual patches, let me try to work out what the
series does as a whole.

> This series adds:
>   - A new QAPITypeInfo struct that pairs a property with its QAPI schema
>     type name, enum lookup table, and list-element type.

Peeking at the code, I see that ObjectProperty gains a member @qapi_type
pointing to its QAPITypeInfo.

It is null when the ObjectProperty doesn't have a QAPI type.

If it's non-null, then ObjectProperty members @name and @type are
redundant with qapi_type.name and .type.

Correct?

Would "every ObjectProperty has a QAPI type" be a reasonable goal for
the future?

>
>   - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
>     instance for every schema-defined type, including the mapping
>     between internal C names and the schema name visible to clients.

Peeking at the code, I find:

* The type

    typedef struct QAPITypeInfo {
        const char *name;
        const char *schema_name;
        const QEnumLookup *lookup;
        const struct QAPITypeInfo *list;
    } QAPITypeInfo;

* A T_type_info for each QAPI type T, including built-in types.

* T_type_info member @name is T's QAPI name, i.e. "T".

* T_type_info member @schema_name is T's masked name used in
  query-qmp-schema output, null when T is elided there.

* T_type_info member @list points to TList_type_info when that exists,
  else it's null.

* T_type_info member @lookup points to T_lookup when T is an enum, else
  it's null.

Correct?

>   - A "qapi-type" field in the ObjectPropertyInfo and
>     ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
>     when present giving clients a cross-reference into query-qmp-schema
>     output.

To be precise: when ObjectPropertyInfo member @type is "T", then member
@qapi-type is T_type_info.qapi-type.  Correct?

If .qapi-type is non-null, you can use it to look up precise type
information via QAPI introspection, i.e. query-qmp-schema.

Correct?

Possible problem: query-qmp-schema covers only types that are actually
used in QMP.  But the above technique additionally wants QOM property
types.  I haven't checked what your series does about this, if anything.

ObjectPropertyInfo is only used with QMP command handlers.  It is
computed from ObjectProperty.

>   - Conversion of all PropertyInfo definitions from the old
>     .type/.enum_table strings to the new .qapi_type pointer.

The above is QOM, this is qdev.

Like ObjectProperty, PropertyInfo gains a member @qapi_type pointing to
its QAPITypeInfo.  Howver, this one cannot be null.

PropertyInfo members @type and @enum_table are dropped, because they are
redundant with qapi_type.type and .lookup.

Correct?

>   - Replacement of the generic qdev_prop_array with typed per-element
>     array PropertyInfos, removing the arrayinfo/arrayfieldsize
>     indirection from struct Property.

Before the series, an array-valued Property's @info member is
@qdev_prop_array.  @qdev_prop_array provides no information on the array
elements.  Instead, Property member @arrayinfo points to the
PropertyInfo for the elements, and @arrayfieldsize is the size of an
element.

Your series makes PropertyInfo array-capable: new members @element_info
and @element_size are the elements' PropertyInfo and size.  It then adds
a proper PropertyInfo for each such property, and drops
@qdev_prop_array.

Correct?

This could perhaps be spun out and merged separately to reduce the size
of future respins.

Not mentioned:

    - New QOM property creation functions for creating properties of
      QAPI type.  These take a QAPITypeInfo.

    - Convert some properties to use them.

>   - Removal of the deprecated PropertyInfo.type and .enum_table fields,
>     and of the old object_property_add_enum/add_tm APIs.
>
> Along the way, a few pre-existing type mismatches in property
> definitions are fixed, the "struct tm" RTC property is replaced with a
> proper QAPI StructTm type etc. Introducing more specific types or a
> "typedef" to QAPI could help provide better associated type informations
> than plain "str" in many cases, for example.

Examples?

> Comments welcome!
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

