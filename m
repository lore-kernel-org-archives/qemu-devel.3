Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD89C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHnb-0004v4-58; Fri, 07 Aug 2026 06:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsHnV-0004uj-Sb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsHnT-0007Zc-PM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786098446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMgX4oI0gDoopR64n3k5b7i7LZU5jWVZObuFgAka2HY=;
 b=ERVAhU/uSJoYdozgN+25APRcMVOddoV3Vn9NeWZo7ORFVcoJ6Cia5hJ0OltpZi/VVUwqg4
 mTa/lHSrT0aDEe+eMoNkiWSMPzOviIB0+lLRL/NGecJBFdssu+Y9HP3dG68x5bIFFHDGXe
 As/H672BL7EgFQb++ZNasrEPwarW+88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630--dbilrUFMq6VX2dQCECI1g-1; Fri,
 07 Aug 2026 06:27:25 -0400
X-MC-Unique: -dbilrUFMq6VX2dQCECI1g-1
X-Mimecast-MFC-AGG-ID: -dbilrUFMq6VX2dQCECI1g_1786098444
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5FED1956096; Fri,  7 Aug 2026 10:27:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 456C9180049F; Fri,  7 Aug 2026 10:27:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E98CD21E6920; Fri, 07 Aug 2026 12:27:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 09/53] qom/qmp: populate qapi-type in QMP handlers
In-Reply-To: <20260616-qom-qapi-v2-9-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:37:35 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-9-cc9396b9c18c@redhat.com>
Date: Fri, 07 Aug 2026 12:27:20 +0200
Message-ID: <878q6iql87.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

> Wire up the new qapi-type field in all four QMP handlers that return
> ObjectPropertyInfo or ObjectPropertyValue: qom-list, qom-list-get,
> device-list-properties, and qom-list-properties.
>
> When an ObjectProperty has a qapi_type set, the masked QAPI type name
> is copied into the response, allowing clients to cross-reference with
> query-qmp-schema.

Again, I'd mention that no property has it set just yet.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/qom-qmp-cmds.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 48b38d2b7f7..30af2cef53e 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -25,9 +25,22 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qemu/cutils.h"
> +#include "qapi/qapi-type-info.h"
>  #include "qom/object_interfaces.h"
>  #include "qom/qom-qobject.h"
>=20=20
> +static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
> +{
> +    ObjectPropertyInfo *info =3D g_new0(ObjectPropertyInfo, 1);
> +
> +    info->name =3D g_strdup(prop->name);
> +    info->type =3D g_strdup(prop->type);
> +    if (prop->qapi_type) {
> +        info->qapi_type =3D g_strdup(prop->qapi_type->schema_name);
> +    }
> +    return info;
> +}
> +
>  static Object *qom_resolve_path(const char *path, Error **errp)
>  {
>      bool ambiguous =3D false;
> @@ -58,12 +71,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path,=
 Error **errp)
>=20=20
>      object_property_iter_init(&iter, obj);
>      while ((prop =3D object_property_iter_next(&iter))) {
> -        ObjectPropertyInfo *value =3D g_new0(ObjectPropertyInfo, 1);
> -
> -        QAPI_LIST_PREPEND(props, value);
> -
> -        value->name =3D g_strdup(prop->name);
> -        value->type =3D g_strdup(prop->type);
> +        QAPI_LIST_PREPEND(props, qom_property_info(prop));

Non-idempotent macro arguments scare me.  This one works, because
QAPI_LIST_PREPEND() evaluates its second argument exactly once.  It even
spells it out in a contract.  Okay.

>      }
>=20=20
>      return props;
> @@ -78,6 +86,9 @@ static void qom_list_add_property_value(Object *obj, Ob=
jectProperty *prop,
>=20=20
>      item->name =3D g_strdup(prop->name);
>      item->type =3D g_strdup(prop->type);
> +    if (prop->qapi_type) {
> +        item->qapi_type =3D g_strdup(prop->qapi_type->schema_name);
> +    }
>      item->value =3D object_property_get_qobject(obj, prop->name, NULL);
>  }
>=20=20
> @@ -225,9 +236,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(co=
nst char *typename,
>              continue;
>          }
>=20=20
> -        info =3D g_new0(ObjectPropertyInfo, 1);
> -        info->name =3D g_strdup(prop->name);
> -        info->type =3D g_strdup(prop->type);
> +        info =3D qom_property_info(prop);
>          info->description =3D g_strdup(prop->description);
>          info->default_value =3D qobject_ref(prop->defval);
>=20=20
> @@ -268,11 +277,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(cons=
t char *typename,
>          object_property_iter_init(&iter, obj);
>      }
>      while ((prop =3D object_property_iter_next(&iter))) {
> -        ObjectPropertyInfo *info;
> +        ObjectPropertyInfo *info =3D qom_property_info(prop);
>=20=20
> -        info =3D g_malloc0(sizeof(*info));
> -        info->name =3D g_strdup(prop->name);
> -        info->type =3D g_strdup(prop->type);
>          info->description =3D g_strdup(prop->description);
>          info->default_value =3D qobject_ref(prop->defval);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


