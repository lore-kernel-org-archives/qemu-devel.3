Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB2C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuVI-00027S-U2; Wed, 01 Jul 2026 08:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weuVG-00021m-BL
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weuVE-0001C9-LW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782910639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNHIKQU9n6qJA4g0l0GaoYd5b9tsL6XtWW/x9BFbEXM=;
 b=V5ex4n1ApKnkChj9EPQigZajMVUlDpn4g5sq0QAAJaBA1xiZPLK8YP2MikT3/x1WAZEcMq
 HO/Ul2XjIGiX5k//h2QKBinZorkEy9xdIcZU90LlcJmfQi4FQ+Oe5HnyZQrOD1BrK7BonK
 Vbxteveqdv9EKQ2fqK4dU15+hqluEYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-U6PPiywVOIS3vR1IecreYA-1; Wed,
 01 Jul 2026 08:57:16 -0400
X-MC-Unique: U6PPiywVOIS3vR1IecreYA-1
X-Mimecast-MFC-AGG-ID: U6PPiywVOIS3vR1IecreYA_1782910635
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE2601933FA4; Wed,  1 Jul 2026 12:57:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AD923000C29; Wed,  1 Jul 2026 12:57:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1082121E6920; Wed, 01 Jul 2026 14:57:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian
 Brauner <brauner@kernel.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 30/35] qom: add method for getting the "id" of a QOM
 object
In-Reply-To: <20260624173752.2928717-31-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 18:37:46
 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-31-berrange@redhat.com>
Date: Wed, 01 Jul 2026 14:57:11 +0200
Message-ID: <87bjcq6f6g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'user_creatable_del' method doesn't want the 'Object *', but
> instead the "id" of the object to be deleted. While most of its
> work could be done with the "Object *" alone, purging the QemuOpts
> values needs the "id".
>
> The "id" is not recorded against an Object though, it is indirectly
> stored as a property linking the parent and child objects together.
> Add an accessor that can fetch this property name.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qom/object.h | 10 ++++++++++
>  qom/object.c         | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fc..216d2a30f6 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1759,6 +1759,16 @@ ObjectProperty *object_property_try_add_child(Obje=
ct *obj, const char *name,
>  ObjectProperty *object_property_add_child(Object *obj, const char *name,
>                                            Object *child);
>=20=20
> +/**
> + * object_property_get_child_name:
> + * @obj: the object that owns the property
> + * @child: the object referenced by the child property
> + *
> + * Return the property name against which @child is registered
> + * with @obj, or NULL if @obj is not a parent of @child.
> + */
> +char *object_property_get_child_name(Object *obj, Object *child);
> +
>  typedef enum {
>      /* Unref the link pointer when the property is deleted */
>      OBJ_PROP_LINK_STRONG =3D 0x1,
> diff --git a/qom/object.c b/qom/object.c
> index f79b2cf361..66bbd1488b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1952,6 +1952,23 @@ object_property_add_child(Object *obj, const char =
*name,
>      return object_property_try_add_child(obj, name, child, &error_abort);
>  }
>=20=20
> +char *object_property_get_child_name(Object *obj, Object *child)
> +{
> +    ObjectProperty *prop;
> +    GHashTableIter iter;
> +    gpointer key, value;
> +
> +    g_hash_table_iter_init(&iter, obj->properties);
> +    while (g_hash_table_iter_next(&iter, &key, &value)) {
> +        prop =3D value;
> +        if (object_property_is_child(prop) && prop->opaque =3D=3D child)=
 {
> +            return g_strdup(prop->name);
> +        }
> +    }
> +    return NULL;
> +}

Isn't this a slight variation of object_get_canonical_path_component()?

> +
> +
>  void object_property_allow_set_link(const Object *obj, const char *name,
>                                      Object *val, Error **errp)
>  {


