Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B973606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ce/OOSuw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3tw-0002wo-Gs; Tue, 20 Oct 2026 03:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3tv-0002wf-DV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJ3tr-00022i-Ja
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 03:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792479880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9B7iChXg9WCw7wkpEc10Z1VuW3iqxaM31ohh3UoKN0=;
 b=Ce/OOSuw9PsEytNvCJNyx+YbBPmzT4B87LEf34x3yutO965cCjIFyKp8fiYa3LdXE/jPFT
 h1rYpu/azSaLweltyzxl7gsANJszq3J7WdPcQu0i0h/q5gM81W+e6Z0sqI4KZYDfvOV2iz
 UMJlxNHJYHeaaHnhpdg9WID21/ORUVc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-a0NyY90aNKmy6-ayFtjLLQ-1; Tue,
 20 Oct 2026 03:04:39 -0400
X-MC-Unique: a0NyY90aNKmy6-ayFtjLLQ-1
X-Mimecast-MFC-AGG-ID: a0NyY90aNKmy6-ayFtjLLQ_1792479878
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F04991800878; Tue, 20 Oct 2026 07:04:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EBA7195608B; Tue, 20 Oct 2026 07:04:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 367BE21E6A04; Tue, 20 Oct 2026 09:04:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com,
 michael.roth@amd.com,  pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com,  kkostiuk@redhat.com,  alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 00/65] qom/qdev: associate properties with QAPI
 schema types
In-Reply-To: <179247801289.2782576.15052785737534296172.b4-review@b4>
 (marcandre lureau's message of "Tue, 20 Oct 2026 10:33:32 +0400")
References: <20261019141929.1594337-1-armbru@redhat.com>
 <179247801289.2782576.15052785737534296172.b4-review@b4>
Date: Tue, 20 Oct 2026 09:04:35 +0200
Message-ID: <87o6corgxo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

marcandre.lureau@redhat.com writes:

>> I rewrote some QAPI infrastructure parts of Marc-Andr=C3=A9's v5.  Me
>> sending the result is easier, because it's already in my tree.
>> Marc-Andr=C3=A9's cover letter follows.
>>=20
>> This series connects QOM and qdev properties to the QAPI type system, so
>> that management tools can discover the QAPI schema type of each object
>> property.
>>=20
>> Today, QOM properties carry a free-form "type" string ("bool", "uint32",
>> "OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
>> query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
>> on naming conventions to figure out how to interpret property values.
>>=20
>> This series adds:
>>   - A new QAPITypeInfo struct that pairs a property with its QAPI schema
>>     type name, enum lookup table, and list-element type.
>>=20
>>   - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
>>     instance for every schema-defined type, including the mapping
>>     between internal C names and the schema name visible to clients.
>>=20
>>   - A "qapi-type" field in the ObjectPropertyInfo and
>>     ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
>>     when present giving clients a cross-reference into query-qmp-schema
>>     output.
>>=20
>>   - Conversion of all PropertyInfo definitions from the old
>>     .type/.enum_table strings to the new .qapi_type pointer.
>>=20
>>   - Replacement of the generic qdev_prop_array with typed per-element
>>     array PropertyInfos, removing the arrayinfo/arrayfieldsize
>>     indirection from struct Property.
>>=20
>>   - Removal of the deprecated PropertyInfo.type and .enum_table fields,
>>     and of the old object_property_add_enum/add_tm APIs.
>>=20
>> Along the way, a few pre-existing type mismatches in property
>> definitions are fixed, the "struct tm" RTC property is replaced with a
>> proper QAPI StructTm type etc. Introducing more specific types or a
>> "typedef" to QAPI could help provide better associated type informations
>> than plain "str" in many cases, for example.
>>=20
>> Changes in v6:
>> - Rebase, resolve a few conflicts
>> - Replace old PATCH 03-04 by new PATCH 01-06, adjust PATCH 09 [old
>>   PATCH 05]
>> - Fix temporary build breakage: convert PCSouthBridgeOption only when
>>   it gets QAPIfied [PATCH 62], delay removal of old interface until
>>   after that [PATCH 63].
>> - Clean up checkpatch long line warnings, except leave the ones in
>>   PATCH 38 for later
>
> Thanks a lot for the v6. I have added minor comments to some of my own pa=
tches.
> Would you like me to send a v7?

Yes, please!


