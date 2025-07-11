Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DECC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaF5g-0001UA-CY; Fri, 11 Jul 2025 10:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaEqi-0004G6-EG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaEqd-0003PH-Ss
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752244534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUkGjbaxVsbvPQsgz276snRgwCE5oM4+6BMtuVeSGVM=;
 b=KQH8PMplERBgURqh6uifEgYpDt/QH/LLGLfBtQUzEaMGgCTpqk1p+j6hzaRc2b2sEUU//s
 sOScvxRtA+e3LecB9aWLF4hrJ/7EMLnW8wGMHmScvY1qOlUC8VxPSFavfvsx6ib+Zqe2Db
 FMrQa4zUSf4+OnO7FvgQ4n3G5XqhO4A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-iQiKVl1uPEmgA59LDaq6cg-1; Fri,
 11 Jul 2025 10:35:31 -0400
X-MC-Unique: iQiKVl1uPEmgA59LDaq6cg-1
X-Mimecast-MFC-AGG-ID: iQiKVl1uPEmgA59LDaq6cg_1752244530
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EB6B19560B2; Fri, 11 Jul 2025 14:35:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A0DA19560A3; Fri, 11 Jul 2025 14:35:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AEE2B21E6A27; Fri, 11 Jul 2025 16:35:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>
Subject: Re: [PATCH V4 1/3] qom: qom-list-get
In-Reply-To: <1752164694-215567-2-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 10 Jul 2025 09:24:52 -0700")
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-2-git-send-email-steven.sistare@oracle.com>
Date: Fri, 11 Jul 2025 16:35:26 +0200
Message-ID: <87bjpqx0b5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Define the qom-list-get command, which fetches all the properties and
> values for a list of paths.  This is faster than qom-list plus qom-get,
> especially when fetching a large subset of the QOM tree.  Some managers
> do so when starting a new VM, and this cost can be a substantial fraction
> of start-up time.

You give such nice rationale in your cover letter...  What about this:

  Using qom-list and qom-get to get all the nodes and property values in
  a QOM tree can take multiple seconds because it requires 1000's of
  individual QOM requests.  Some managers fetch the entire tree or a
  large subset of it when starting a new VM, and this cost is a
  substantial fraction of start up time.

  Define the qom-list-get command, which fetches all the properties and
  values for a list of paths.  This can be much faster than qom-list
  plus qom-get.  When getting an entire QOM tree, I measured a 10x
  speedup in elapsed time.

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I think you missed

  Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

> ---
>  qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++=
++
>  qom/qom-qmp-cmds.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index b133b06..49214d2 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -46,6 +46,34 @@
>              '*default-value': 'any' } }
>=20=20
>  ##
> +# @ObjectPropertyValue:
> +#
> +# @name: the name of the property.
> +#
> +# @type: the type of the property, as described in @ObjectPropertyInfo.

`ObjectPropertyInfo`

See John Snow's "[PATCH 00/18] QAPI: add cross-references to qapi docs"
rewrites things so they become links in generated HTML.

> +#
> +# @value: the value of the property.  Absent when the property cannot
> +#     be read.
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'ObjectPropertyValue',
> +  'data': { 'name': 'str',
> +            'type': 'str',
> +            '*value': 'any' } }
> +
> +##
> +# @ObjectPropertiesValues:
> +#
> +# @properties: a list of properties.
> +#
> +# Since 10.1
> +##
> +{ 'struct': 'ObjectPropertiesValues',
> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
> +
> +
> +##
>  # @qom-list:
>  #
>  # This command will list any properties of a object given a path in
> @@ -126,6 +154,28 @@
>    'allow-preconfig': true }
>=20=20
>  ##
> +# @qom-list-get:
> +#
> +# List properties and their values for each object path in the input
> +# list.
> +#
> +# @paths: The absolute or partial path for each object, as described
> +#     in `qom-get`.
> +#
> +# Errors:
> +#     - If any path is not valid or is ambiguous
> +#
> +# Returns: A list where each element is the result for the
> +#     corresponding element of @paths.
> +#
> +# Since 10.1
> +##
> +{ 'command': 'qom-list-get',
> +  'data': { 'paths': [ 'str' ] },
> +  'returns': [ 'ObjectPropertiesValues' ],
> +  'allow-preconfig': true }
> +
> +##
>  # @qom-set:
>  #
>  # This command will set a property from a object model path.
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 293755f..57f1898 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -69,6 +69,59 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path,=
 Error **errp)
>      return props;
>  }
>=20=20
> +static void qom_list_add_property_value(Object *obj, ObjectProperty *pro=
p,
> +                                        ObjectPropertyValueList **props)
> +{
> +    ObjectPropertyValue *item =3D g_new0(ObjectPropertyValue, 1);
> +
> +    QAPI_LIST_PREPEND(*props, item);
> +
> +    item->name =3D g_strdup(prop->name);
> +    item->type =3D g_strdup(prop->type);
> +    item->value =3D object_property_get_qobject(obj, prop->name, NULL);
> +}
> +
> +static ObjectPropertyValueList *qom_get_property_value_list(const char *=
path,
> +                                                            Error **errp)
> +{
> +    Object *obj;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +    ObjectPropertyValueList *props =3D NULL;
> +
> +    obj =3D qom_resolve_path(path, errp);
> +    if (obj =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    object_property_iter_init(&iter, obj);
> +    while ((prop =3D object_property_iter_next(&iter))) {
> +        qom_list_add_property_value(obj, prop, &props);
> +    }
> +
> +    return props;
> +}
> +
> +ObjectPropertiesValuesList *qmp_qom_list_get(strList *paths, Error **err=
p)
> +{
> +    ObjectPropertiesValuesList *head =3D NULL, **tail =3D &head;
> +    strList *path;
> +
> +    for (path =3D paths; path; path =3D path->next) {
> +        ObjectPropertiesValues *item =3D g_new0(ObjectPropertiesValues, =
1);
> +
> +        QAPI_LIST_APPEND(tail, item);
> +
> +        item->properties =3D qom_get_property_value_list(path->value, er=
rp);
> +        if (!item->properties) {
> +            qapi_free_ObjectPropertiesValuesList(head);
> +            return NULL;
> +        }
> +    }
> +
> +    return head;
> +}
> +
>  void qmp_qom_set(const char *path, const char *property, QObject *value,
>                   Error **errp)
>  {

Reviewed-by: Markus Armbruster <armbru@redhat.com>


