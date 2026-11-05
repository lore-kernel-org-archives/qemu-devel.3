Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB1606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9ISK6Zt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOs14-0004jz-8T; Thu, 05 Nov 2026 02:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOs11-0004dj-Bm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOs0z-0005cH-Ls
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793864162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPB75kdywQINqRTAb94Zek3TfQf5c9qiSaA1dHv30BY=;
 b=I9ISK6ZtCkbbJm9YhHha00J37dqouTMVDLTGNROAc8r1RSzAzQvecMr/A2u8s+eyc23Og5
 6/B2mU1YgZYN7qNxtaGBhiRIeHjhqBG4n2ywTHe4KYu9xHtZ2SLENjp496SwlPWrh9WSpU
 RFEZCYeEjQeJhsRTA3Kw73CNaUZWgXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-H_Bpqs7dNoKjFirh6uBwnw-1; Thu,
 05 Nov 2026 02:36:01 -0500
X-MC-Unique: H_Bpqs7dNoKjFirh6uBwnw-1
X-Mimecast-MFC-AGG-ID: H_Bpqs7dNoKjFirh6uBwnw_1793864160
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A239F1956065
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 07:36:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 602421956089
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 07:36:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAA9821E6A04; Thu, 05 Nov 2026 08:35:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com,
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH 1/2] qdev: Convert array properties to QAPI-aware
 registration
In-Reply-To: <87cxsjepw6.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 05 Nov 2026 07:47:05 +0100")
References: <20261104083816.1120306-1-armbru@redhat.com>
 <20261104083816.1120306-2-armbru@redhat.com>
 <179378802492.1846855.7084872407822363552.b4-review@b4>
 <87cxsjepw6.fsf@pond.sub.org>
Date: Thu, 05 Nov 2026 08:35:57 +0100
Message-ID: <877birenmq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> marcandre.lureau@redhat.com writes:
>
>>> Add element_info and element_size fields to PropertyInfo.
>>>=20
>>> Add typed array PropertyInfo definitions. Each one knows its element
>>> type at compile time through the new element_info and element_size
>>> fields of PropertyInfo.
>>>=20
>>> Update DEFINE_PROP_ARRAY() to use them instead of the generic
>>> qdev_prop_array.
>>>=20
>>> Use PropertyInfo fields element_info and element_size instead of
>>> Property fields arrayinfo and arrayfieldsize.  Remove arrayinfo and
>>> arrayfieldsize.
>>>=20
>>> Infrastructure changes:
>>> - Make get_prop_array, set_prop_array, release_prop_array, and
>>>   default_prop_array non-static so they can be used by
>>>   DEFINE_PROP_ARRAY_INFO in other translation units
>>> - Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h
>>>=20
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Message-ID: <20261104083816.1120306-2-armbru@redhat.com>
>
> [...]
>
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index e2ea8945956c..7a7d4f9d7910 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>
> [...]
>
>>> @@ -854,18 +860,24 @@ out_obj:
>>>      }
>>>  }
>>>=20=20
>>> -static void default_prop_array(ObjectProperty *op, const Property *pro=
p)
>>> +void default_prop_array(ObjectProperty *op, const Property *prop)
>>>  {
>>>      object_property_set_default_list(op);
>>>  }
>>>=20=20
>>> -const PropertyInfo qdev_prop_array =3D {
>>> -    .type =3D "list",
>>> -    .get =3D get_prop_array,
>>> -    .set =3D set_prop_array,
>>> -    .release =3D release_prop_array,
>>> -    .set_default_value =3D default_prop_array,
>>> -};
>>> +const PropertyInfo qdev_prop_uint8_array =3D
>>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t, &uint8List_type_i=
nfo);
>>> +const PropertyInfo qdev_prop_uint16_array =3D
>>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t, &uint16List_typ=
e_info);
>>> +const PropertyInfo qdev_prop_uint32_array =3D
>>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t, &uint32List_typ=
e_info);
>>> +const PropertyInfo qdev_prop_uint64_array =3D
>>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t, &uint64List_typ=
e_info);
>>> +const PropertyInfo qdev_prop_string_array =3D
>>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *, &strList_type_inf=
o);
>>> +
>>> +const PropertyInfo qdev_prop_link_array =3D
>>> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_link, void *, NULL);
>>
>> It could use &strList_type_info, since qdev_prop_link uses
>> &str_type_info and serialize as object-path strings.
>
> Point.

qdev_prop_link's .qapi_type =3D &str_type_info is actually useless.

qdev_prop_link has .create =3D create_link_property, and
create_link_property() doesn't use prop->qapi_type.  It wraps around
object_class_property_add_link(), which passes null @qapi_type to
object_class_property_add().

I'll post a patch to make link and child property creation use
&str_type_info.

Once we have that, this patch can use &strList_type_info for
qdev_prop_link_array.


