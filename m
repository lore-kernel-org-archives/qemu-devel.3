Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B510CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIiPo-0002Ds-TI; Mon, 19 Oct 2026 04:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIiPm-0002D0-JY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIiPk-0004Hf-VB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792397292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=UjyJDH6BTJsZCZau57DPDRriLCF4dCv1k6udjsKA9vU=;
 b=BUdX4nwLnvWFv0daUbSEWzDKpZOieVlIKgKHuOiWw4YdZdlltp1J0MVHaF6aOwzrJpI5km
 ztxw1HcuXnO3UPnuONkLRc6NSFu71uOpYgrOr4GZ/xX+HT6QwINKd0MpLDNwPfLrvbuuPi
 myv2BBsGXVWJNMUm+bSbSNqx9s0WoyU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-Fr1abY1AO-GsyidKSFwnQg-1; Mon,
 19 Oct 2026 08:08:02 +0000
X-MC-Unique: Fr1abY1AO-GsyidKSFwnQg-1
X-Mimecast-MFC-AGG-ID: Fr1abY1AO-GsyidKSFwnQg_1792397281
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51C2B1955EA9; Mon, 19 Oct 2026 08:08:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4E6B41B; Mon, 19 Oct 2026 08:08:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5339B21E6A04; Mon, 19 Oct 2026 10:07:58 +0200 (CEST)
Resent-To: michael.roth@amd.com, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 19 Oct 2026 10:07:58 +0200
Resent-Message-ID: <87zewa15b5.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 13/62] qom: add object_{class_}property_add_qapi_enum
In-Reply-To: <20260911-qom-qapi-v5-13-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:34:47 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-13-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 09:39:55 +0200
Message-ID: <87o6cq2l6c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qom/object.h | 73 ++++++++++++++++++++++++++++++++++++++++++
>  qom/object.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 157 insertions(+), 5 deletions(-)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 083fe646c390..c9a5fe4934d0 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1993,6 +1993,79 @@ ObjectProperty *object_class_property_add_enum(Obj=
ectClass *klass,
>                                      int (*get)(Object *, Error **),
>                                      void (*set)(Object *, int, Error **)=
);
>=20=20
> +/**
> + * struct QapiEnumProp - Descriptor for a QOM property backed by a QAPI =
enum type

Elsewhere in this file, we use

   /**
    * struct SomeName:

and

   /**
    * typedef SomeName:

When to use struct and when to use typedef?

None of them have a description.  In other files, I see

   /**
    * struct SomeName: a description

and

   /**
    * struct SomeName - a description

Colon or dash?

If the answer is "whatever you like", then I'd recommend colon for local
consistency.

scripts/checkpatch.pl gripes

    WARNING: line over 80 characters

> + *
> + * Binds a QOM object property to a QAPI enum, providing automatic
> + * string<->int conversion through QAPI visitors and optional
> + * default-value initialization during object instance init.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> + *
> + * @name: property name exposed on the QOM object
> + * @description: human-readable description (shown in ``-device help``, =
etc.)
> + * @default_value: initial enum value applied via @set during instance i=
nit,
> + *                 or -1 (the QAPI_ENUM_PROP default) to skip initializa=
tion
> + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> + *             (provides the string<->int lookup table)
> + * @get: getter that returns the current enum value as int, or -1 on err=
or
> + * @set: setter that receives the enum value as int; %NULL for read-only=
 props
> + */
> +typedef struct QapiEnumProp {
> +    const char *name;
> +    const char *description;
> +    const int default_value;
> +    const QAPITypeInfo *qapi_type;
> +    int (*get)(Object *, Error **);
> +    void (*set)(Object *, int, Error **);
> +} QapiEnumProp;
> +
> +#define QAPI_ENUM_PROP(...) ({                                          =
 \
> +    static const QapiEnumProp _prop =3D {                               =
   \
> +        .default_value =3D -1, __VA_ARGS__                              =
   \
> +    };                                                                  =
 \
> +    &_prop; })
> +
> +/**
> + * object_property_add_qapi_enum:
> + * @obj: the object to add a property to
> + * @prop: property descriptor
> + *
> + * Add an enum property with QAPI type association.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);
> +
> +/**
> + * object_class_property_add_qapi_enum:
> + * @klass: the class object to add a property to
> + * @prop: property descriptor
> + *
> + * Add an enum property with QAPI type association.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> + * inline. If .default_value is not set, the property is not initialized
> + * (default_value is -1). Otherwise, the setter is called with
> + * default_value during object instance init.
> + *
> + * Example::
> + *
> + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> + *       .name =3D "policy",
> + *       .description =3D "Set the NUMA policy",
> + *       .default_value =3D HOST_MEM_POLICY_DEFAULT,
> + *       .qapi_type =3D &HostMemPolicy_type_info,
> + *       .get =3D my_get_policy,
> + *       .set =3D my_set_policy,
> + *   ));
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumPr=
op *prop);

Another

    WARNING: line over 80 characters

> +
>  /**
>   * object_property_add_qapi:
>   * @obj: the object to add a property to

[...]


