Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA99CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xInCc-0001x9-67; Mon, 19 Oct 2026 09:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xInCV-0001vq-7O
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xInCT-0007Bf-KD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792415686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IH7gFs//57w6geKln45P7/yUam2hpwR3qEEtKlXnHRQ=;
 b=R+Hu6sOHpOdHa6OPIBkl5x84O2cJxsdzs0CTTbE5iYZ6G+P/i3y3OiNnTkZu2xOw96gq1Q
 eG3bQ0NC4UMwtbwrvUfy0UsQit6J3kQekzO5Nqj1qf5D3NDCrt5nYTVR8HUIFcUblwljO5
 nUBuBVJaKb+jdKUrUpLX9qlrYwbcYnc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-aHMTewoYNvS1XdB9PagH3Q-1; Mon,
 19 Oct 2026 13:14:41 +0000
X-MC-Unique: aHMTewoYNvS1XdB9PagH3Q-1
X-Mimecast-MFC-AGG-ID: aHMTewoYNvS1XdB9PagH3Q_1792415679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A421118011EB; Mon, 19 Oct 2026 13:14:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40ECB30000E3; Mon, 19 Oct 2026 13:14:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDC4421E6A04; Mon, 19 Oct 2026 15:14:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 48/62] qdev: add qapi_type field to PropertyInfo with
 fallback registration
In-Reply-To: <20260911-qom-qapi-v5-48-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:35:22 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-48-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 15:14:34 +0200
Message-ID: <878q3tzvb9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

> Add a qapi_type field to PropertyInfo to prepare for the transition
> from string-based type metadata to QAPI type-info.
>
> Add a qdev_prop_qapi_type() helper that resolves the QAPI type for a
> property from .qapi_type. It will be later extended to cope with array
> types.
>
> Update qdev_property_add_static() and qdev_class_add_property() to
> prefer object_property_add_qapi() when a QAPI type is available, falling
> back to the old object_property_add() for unconverted properties.
>
> Update the shared enum accessor functions to prefer .qapi_type->lookup
> over .enum_table via a new qdev_propinfo_enum_lookup() helper.
>
> No PropertyInfo definitions are changed, all .qapi_type fields
> default to NULL, so the fallback paths are always taken. This patch
> is no-op for now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-properties.c         | 67 +++++++++++++++++++++++++++++----=
------
>  include/hw/core/qdev-properties.h |  1 +
>  2 files changed, 52 insertions(+), 16 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 34d7b26a7303..b3d5abd5053c 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c

[...]

> @@ -114,14 +123,14 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v=
, const char *name,
>      const Property *prop =3D opaque;
>      int *ptr =3D object_field_prop_ptr(obj, prop);
>=20=20
> -    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
> +    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info),=
 errp);
>  }
>=20=20
>  void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
>                                            const Property *prop)
>  {
>      object_property_set_default_str(op,
> -        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
> +        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), prop->de=
fval.i));

scripts/checkpatch.pl warns

    WARNING: line over 80 characters

Easy enough to avoid.

>  }
>=20=20
>  /* Bit */

[...]


