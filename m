Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AACCCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xInFn-0002zn-To; Mon, 19 Oct 2026 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xInFP-0002xS-Td
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xInFM-0007dl-3V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792415860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bobr8pkYvHIvnv1T1Ivc8RBekFZ6kz2prStkDciHrKg=;
 b=BbtbqRYMYPF+Uu7XTAht0QKXHu4FknsnKpZk+NuvAAYe4I1CSe3uOf7Sry0+bR404/hirb
 KoADCPva70jv2DXNptF/51yt3oqto3iYjJ4PfHXMSJHU2HLmH0WoUUjgGAfB+K59u30jUz
 WcMLTyJcIM/hPZcT7ketz1x97bhiI0s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-tMyu__v-MAybHPLzNUHzKQ-1; Mon,
 19 Oct 2026 13:17:38 +0000
X-MC-Unique: tMyu__v-MAybHPLzNUHzKQ-1
X-Mimecast-MFC-AGG-ID: tMyu__v-MAybHPLzNUHzKQ_1792415857
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12A181954B19; Mon, 19 Oct 2026 13:17:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83BC81800480; Mon, 19 Oct 2026 13:17:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A35F21E6A04; Mon, 19 Oct 2026 15:17:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 55/62] qdev: introduce typed array PropertyInfos
In-Reply-To: <20260911-qom-qapi-v5-55-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:35:29 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-55-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 15:17:34 +0200
Message-ID: <874iehzv69.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

> Add element_info and element_size fields to PropertyInfo, and extend
> qdev_prop_qapi_type() to derive QAPI types for array properties via
> element_info->qapi_type->list.
>
> Add typed list PropertyInfo definitions that replace the generic
> qdev_prop_array. Each typed list PropertyInfo knows its element type
> at compile time through the element_info and element_size fields,
> which allows the QAPI type to be derived automatically.
>
> Infrastructure changes:
> - Add prop_array_info() and prop_array_elem_size() helpers that
>   prefer the new element_info/element_size fields with fallback to
>   the old arrayinfo/arrayfieldsize fields for compatibility
> - Make get_prop_array, set_prop_array, release_prop_array, and
>   default_prop_array non-static so they can be used by
>   DEFINE_PROP_ARRAY_INFO in other translation units
> - Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h
>
> The array of links needs special care for its "full type name" to follow
> the "link<TYPE>List" pattern used by link properties ("link<TYPE>").
>
> The old qdev_prop_array and DEFINE_PROP_ARRAY macro are preserved
> for compatibility; they will be replaced in the next patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-prop-internal.h             |  18 ++++++
>  hw/core/qdev-properties-system.c         |   5 ++
>  hw/core/qdev-properties.c                | 103 ++++++++++++++++++++++++-=
------
>  include/hw/core/qdev-properties-system.h |   2 +
>  include/hw/core/qdev-properties.h        |   8 +++
>  5 files changed, 115 insertions(+), 21 deletions(-)
>
> diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
> index c190b7b88cf4..b9d9812346d1 100644
> --- a/hw/core/qdev-prop-internal.h
> +++ b/hw/core/qdev-prop-internal.h
> @@ -27,4 +27,22 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, =
const char *name,
>  void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp);
>=20=20
> +void get_prop_array(Object *obj, Visitor *v, const char *name,
> +                    void *opaque, Error **errp);
> +void set_prop_array(Object *obj, Visitor *v, const char *name,
> +                    void *opaque, Error **errp);
> +void release_prop_array(Object *obj, const char *name, void *opaque);
> +void default_prop_array(ObjectProperty *op, const Property *prop);
> +
> +/* .qapi_type is derived from element_info->qapi_type->list by qdev_prop=
_qapi_type() */

scripts/checkpatch.pl warns

    WARNING: line over 80 characters

Perhaps

   /*
    * Note: .qapi_type is derived from element_info->qapi_type->list by
    * qdev_prop_qapi_type()
    */

> +#define DEFINE_PROP_ARRAY_INFO(_elem_prop_info, _elem_type) \
> +    {                                                       \
> +        .element_info =3D &(_elem_prop_info),                 \
> +        .element_size =3D sizeof(_elem_type),                 \
> +        .get =3D get_prop_array,                              \
> +        .set =3D set_prop_array,                              \
> +        .release =3D release_prop_array,                      \
> +        .set_default_value =3D default_prop_array,            \
> +    }
> +
>  #endif

[...]

> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index c2980c36afa2..a9ca8e4a03db 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c

[...]

> @@ -860,6 +882,38 @@ const PropertyInfo qdev_prop_array =3D {
>      .set_default_value =3D default_prop_array,
>  };
>=20=20
> +const PropertyInfo qdev_prop_uint8_list =3D
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t);
> +const PropertyInfo qdev_prop_uint16_list =3D
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t);
> +const PropertyInfo qdev_prop_uint32_list =3D
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t);
> +const PropertyInfo qdev_prop_uint64_list =3D
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t);
> +const PropertyInfo qdev_prop_string_list =3D
> +    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *);
> +
> +static ObjectProperty *create_link_list_property(ObjectClass *oc,
> +                                                  const char *name,
> +                                                  const Property *prop)
> +{
> +    g_autofree char *full_type =3D g_strdup_printf("link<%s>List", prop-=
>link_type);

scripts/checkpatch.pl warns

    WARNING: line over 80 characters

Easy enough to avoid.

> +
> +    return object_class_property_add(oc, name, full_type,
> +                                     get_prop_array, set_prop_array,
> +                                     release_prop_array, (Property *)pro=
p);
> +}

[...]


