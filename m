Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A2DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBt1m-0003Q1-Co; Thu, 23 Oct 2025 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBt1k-0003Oc-8l
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBt1h-00025d-MR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761217115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8fa2CE+Mylb+viHJ8bcC4OUcIgcLkv1SlSJNgjVdLo=;
 b=VbqWCbCELwipWnha85FCEmqStE36XgI4vtltWlqT2S1nee24hhrc1Q8+tkHWBm6Gn86/Kq
 qkO0DwSZTxQ24vVRpCkIg0zVJKIpYVTGc+StSK5X9wFGlci4ZOR61dk2xqjKrmjRof7Yer
 Kg60bEgG/7uPiNVAQWE0aadogJjfjpo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-odTnX7PiP2qJZfT1D5Eg3Q-1; Thu,
 23 Oct 2025 06:58:32 -0400
X-MC-Unique: odTnX7PiP2qJZfT1D5Eg3Q-1
X-Mimecast-MFC-AGG-ID: odTnX7PiP2qJZfT1D5Eg3Q_1761217111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62969195609D; Thu, 23 Oct 2025 10:58:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABF4419540E2; Thu, 23 Oct 2025 10:58:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DFA7B21E6A27; Thu, 23 Oct 2025 12:58:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 11/32] qom: report & filter on security status in
 qom-list-types
In-Reply-To: <20250926140144.1998694-12-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 26 Sep 2025 15:01:22
 +0100")
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-12-berrange@redhat.com>
Date: Thu, 23 Oct 2025 12:58:27 +0200
Message-ID: <87a51h9964.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

> This adds:
>
>  * a new boolean 'secure' field to the type info returned by
>    qom-list-types, which will be set if the type provides a
>    security boundary
>
>  * a new boolean 'secure' parameter to the arguments of
>    qom-list-types, which can be used to filter types based
>    on their security status
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I was about to ask for this feature in reply to PATCH 2 when I found
this patch.  Consider moving it right after PATCH 2, or
forward-referencing it in PATCH 2's commit message.

> ---
>  qapi/qom.json      | 10 ++++++++--
>  qom/qom-qmp-cmds.c | 30 ++++++++++++++++++++++++------
>  2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 830cb2ffe7..3e5e7e6f6f 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -210,12 +210,15 @@
>  # @abstract: the type is abstract and can't be directly instantiated.
>  #     Omitted if false.  (since 2.10)
>  #
> +# @secure: the type provides a security boundary.
> +#     Omitted if false.  (since 10.2)

Please wrap like this:

   # @secure: the type provides a security boundary.  Omitted if false.
   #     (since 10.2)

> +#
>  # @parent: Name of parent type, if any (since 2.10)
>  #
>  # Since: 1.1
>  ##
>  { 'struct': 'ObjectTypeInfo',
> -  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
> +  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str', '*secu=
re': 'bool' } }

Long line.  I think it's time to put each member on its own line.

>=20=20
>  ##
>  # @qom-list-types:
> @@ -227,12 +230,15 @@
>  #
>  # @abstract: if true, include abstract types in the results
>  #
> +# @secure: if set, filter to only include types with matching security s=
tatus
> +#     (since 10.2)

Hmm.

                absent          false           true
    @abstract   only concrete   only concrete   all
    @secure     all             only insecure   only secure     (I think)

The difference is grating.  Any ideas?

If we decide to keep it as is, please wrap like this:

   # @secure: if set, filter to only include types with matching security
   #     status (since 10.2)

> +#
>  # Returns: a list of types, or an empty list if no results are found
>  #
>  # Since: 1.1
>  ##
>  { 'command': 'qom-list-types',
> -  'data': { '*implements': 'str', '*abstract': 'bool' },
> +  'data': { '*implements': 'str', '*abstract': 'bool', '*secure': 'bool'=
 },
>    'returns': [ 'ObjectTypeInfo' ],
>    'allow-preconfig': true }
>=20=20
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 57f1898cf6..9e221bb332 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -151,33 +151,51 @@ QObject *qmp_qom_get(const char *path, const char *=
property, Error **errp)
>      return object_property_get_qobject(obj, property, errp);
>  }
>=20=20
> -static void qom_list_types_tramp(ObjectClass *klass, void *data)
> +typedef struct {
> +    ObjectTypeInfoList *list;
> +    bool has_secure;
> +    bool secure;
> +} ObjectTypeInfoData;
> +
> +static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
>  {
> -    ObjectTypeInfoList **pret =3D data;
> +    ObjectTypeInfoData *data =3D opaque;
>      ObjectTypeInfo *info;
>      ObjectClass *parent =3D object_class_get_parent(klass);
>=20=20
> +    if (data->has_secure &&
> +        data->secure !=3D object_class_is_secure(klass)) {
> +        return;
> +    }
> +
>      info =3D g_malloc0(sizeof(*info));
>      info->name =3D g_strdup(object_class_get_name(klass));
>      info->has_abstract =3D info->abstract =3D object_class_is_abstract(k=
lass);
> +    info->has_secure =3D info->secure =3D object_class_is_secure(klass);
>      if (parent) {
>          info->parent =3D g_strdup(object_class_get_name(parent));
>      }
>=20=20
> -    QAPI_LIST_PREPEND(*pret, info);
> +    QAPI_LIST_PREPEND(data->list, info);
>  }
>=20=20
>  ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
>                                         bool has_abstract,
>                                         bool abstract,
> +                                       bool has_secure,
> +                                       bool secure,
>                                         Error **errp)
>  {
> -    ObjectTypeInfoList *ret =3D NULL;
> +    ObjectTypeInfoData data =3D {
> +        .list =3D NULL,
> +        .has_secure =3D has_secure,
> +        .secure =3D secure,
> +    };
>=20=20
>      module_load_qom_all();
> -    object_class_foreach(qom_list_types_tramp, implements, abstract, &re=
t);
> +    object_class_foreach(qom_list_types_tramp, implements, abstract, &da=
ta);
>=20=20
> -    return ret;
> +    return data.list;
>  }
>=20=20
>  ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,

This fuses a change of how the list value is built with the addition of
a new list element member.  I'd prefer them separate.


