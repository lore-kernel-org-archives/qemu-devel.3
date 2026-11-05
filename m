Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9802606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hoJanf5S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrFo-0005er-L6; Thu, 05 Nov 2026 01:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOrFi-0005bK-Dd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOrFg-0000Aa-LC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793861230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/Q8PcJ01imYtQloXR5ozOrXDRL7auTbAMgJdpihcS8=;
 b=hoJanf5S5VUdClsDdZWvWg54Iu3RrZEOuLV1GlqxxArs17nNHfwX7E0XSdrLQhJxnhpdLF
 N0TH+rmboYb7epFMMSvuybPHHJmNsxyjQzB39+4doL7Wo8WX2DA4cUYhnDj5ISegLTQy2p
 p7c5DXxRKQ6et5JXS8ho+VHV/I1WJvo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-g-qqUt3COkeLZ5mETHe7eg-1; Thu,
 05 Nov 2026 01:47:09 -0500
X-MC-Unique: g-qqUt3COkeLZ5mETHe7eg-1
X-Mimecast-MFC-AGG-ID: g-qqUt3COkeLZ5mETHe7eg_1793861228
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32DD1195606E
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 06:47:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E63D939208
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 06:47:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5651D21E6A04; Thu, 05 Nov 2026 07:47:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 pbonzini@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH 1/2] qdev: Convert array properties to QAPI-aware
 registration
In-Reply-To: <179378802492.1846855.7084872407822363552.b4-review@b4>
 (marcandre lureau's message of "Wed, 04 Nov 2026 14:27:04 +0400")
References: <20261104083816.1120306-1-armbru@redhat.com>
 <20261104083816.1120306-2-armbru@redhat.com>
 <179378802492.1846855.7084872407822363552.b4-review@b4>
Date: Thu, 05 Nov 2026 07:47:05 +0100
Message-ID: <87cxsjepw6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

marcandre.lureau@redhat.com writes:

>> Add element_info and element_size fields to PropertyInfo.
>>=20
>> Add typed array PropertyInfo definitions. Each one knows its element
>> type at compile time through the new element_info and element_size
>> fields of PropertyInfo.
>>=20
>> Update DEFINE_PROP_ARRAY() to use them instead of the generic
>> qdev_prop_array.
>>=20
>> Use PropertyInfo fields element_info and element_size instead of
>> Property fields arrayinfo and arrayfieldsize.  Remove arrayinfo and
>> arrayfieldsize.
>>=20
>> Infrastructure changes:
>> - Make get_prop_array, set_prop_array, release_prop_array, and
>>   default_prop_array non-static so they can be used by
>>   DEFINE_PROP_ARRAY_INFO in other translation units
>> - Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Message-ID: <20261104083816.1120306-2-armbru@redhat.com>

[...]

>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index e2ea8945956c..7a7d4f9d7910 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c

[...]

>> @@ -854,18 +860,24 @@ out_obj:
>>      }
>>  }
>>=20=20
>> -static void default_prop_array(ObjectProperty *op, const Property *prop)
>> +void default_prop_array(ObjectProperty *op, const Property *prop)
>>  {
>>      object_property_set_default_list(op);
>>  }
>>=20=20
>> -const PropertyInfo qdev_prop_array =3D {
>> -    .type =3D "list",
>> -    .get =3D get_prop_array,
>> -    .set =3D set_prop_array,
>> -    .release =3D release_prop_array,
>> -    .set_default_value =3D default_prop_array,
>> -};
>> +const PropertyInfo qdev_prop_uint8_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t, &uint8List_type_in=
fo);
>> +const PropertyInfo qdev_prop_uint16_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t, &uint16List_type=
_info);
>> +const PropertyInfo qdev_prop_uint32_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t, &uint32List_type=
_info);
>> +const PropertyInfo qdev_prop_uint64_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t, &uint64List_type=
_info);
>> +const PropertyInfo qdev_prop_string_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *, &strList_type_info=
);
>> +
>> +const PropertyInfo qdev_prop_link_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_link, void *, NULL);
>
> It could use &strList_type_info, since qdev_prop_link uses
> &str_type_info and serialize as object-path strings.

Point.

>>  /* --- public helpers --- */
>>=20=20
>> diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
>> index 3197bd853dab..652f158223c0 100644
>> --- a/hw/display/apple-gfx.h
>> +++ b/hw/display/apple-gfx.h
>> @@ -69,6 +69,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_=
physical,
>>                                         MemoryRegion **mapping_in_region=
);
>>=20=20
>>  extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
>> +extern const PropertyInfo qdev_prop_apple_gfx_display_mode_array;
>>=20=20
>>  #endif
>>=20=20
>> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>> index 4db80f0b107e..f800f84aa2b5 100644
>> --- a/hw/display/apple-gfx.m
>> +++ b/hw/display/apple-gfx.m
>> @@ -16,6 +16,7 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/log.h"
>>  #include "qapi/qapi-builtin-type-infos.h"
>> +#include "hw/core/qdev-prop-internal.h"
>>  #include "qapi/visitor.h"
>>  #include "qapi/error.h"
>>  #include "qemu/aio-wait.h"
>> @@ -880,3 +881,8 @@ static void apple_gfx_set_display_mode(Object *obj, =
Visitor *v,
>>      .get   =3D apple_gfx_get_display_mode,
>>      .set   =3D apple_gfx_set_display_mode,
>>  };
>> +
>> +const PropertyInfo qdev_prop_apple_gfx_display_mode_array =3D
>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_apple_gfx_display_mode,
>> +			   AppleGFXDisplayMode,
>> +			   &strList_type_info);
>
> indented with tabs

Oops.

Thank you!


