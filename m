Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2493C83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFNP-0008Rl-02; Fri, 11 Jul 2025 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaFGk-0003Fv-8C
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaFGg-0000fI-Ai
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752246148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvtpdOCroKXnzG4A3oakMm59S6pUVMcPIHwx7O2Yu+k=;
 b=Lyafq56UZQ8T6bpiVDKgWkW4BRWh22hc7RzLopvUnTam5kZexoGNnnpXBEC4X2hV2pj2aU
 zSogc9+vjAVYVcaoucUf3ZHVWgtl6FyC2kPZHL9+fUDV8MVzNJ1m3R7X8FBc1m9I2OfS5d
 2fEe/G526uqMqsIJfM4o9s2PFCMe2ho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-EX7TvIJ0PqiZIMr7pSaLgg-1; Fri,
 11 Jul 2025 11:02:25 -0400
X-MC-Unique: EX7TvIJ0PqiZIMr7pSaLgg-1
X-Mimecast-MFC-AGG-ID: EX7TvIJ0PqiZIMr7pSaLgg_1752246144
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86E96195608C; Fri, 11 Jul 2025 15:02:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA77F19560A3; Fri, 11 Jul 2025 15:02:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EC2B21E6A27; Fri, 11 Jul 2025 17:02:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>
Subject: Re: [PATCH V4 3/3] tests/qtest/qom-test: unit test for qom-list-getv
In-Reply-To: <1752164694-215567-4-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 10 Jul 2025 09:24:54 -0700")
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-4-git-send-email-steven.sistare@oracle.com>
Date: Fri, 11 Jul 2025 17:02:20 +0200
Message-ID: <87qzymvkhv.fsf@pond.sub.org>
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

> Add a unit test for qom-list-getv.

qom-list-get here and in subject.  Could scratch this line, subject
suffices.

>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/qom-test.c | 116 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index 27d70bc..4ade1c7 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -11,11 +11,119 @@
>=20=20
>  #include "qobject/qdict.h"
>  #include "qobject/qlist.h"
> +#include "qobject/qstring.h"
>  #include "qemu/cutils.h"
>  #include "libqtest.h"
>=20=20
> +#define RAM_NAME "node0"
> +#define RAM_SIZE 65536
> +
>  static int verbosity_level;
>=20=20
> +/*
> + * Verify that the /object/RAM_NAME 'size' property is RAM_SIZE.
> + */
> +static void test_list_get_value(QTestState *qts)
> +{
> +    QDict *args =3D qdict_new();
> +    g_autoptr(QDict) response =3D NULL;
> +    g_autoptr(QList) paths =3D qlist_new();
> +    QListEntry *entry, *prop_entry;
> +    const char *prop_name;
> +    QList *properties, *return_list;
> +    QDict *obj;
> +
> +    qlist_append_str(paths, "/objects/" RAM_NAME);
> +    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));

Could probably avoid copying @paths.  Good enough.

> +    response =3D qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
> +                              "  'arguments': %p }", args);
> +    g_assert(response);
> +    g_assert(qdict_haskey(response, "return"));
> +    return_list =3D qobject_to(QList, qdict_get(response, "return"));
> +
> +    entry =3D QTAILQ_FIRST(&return_list->head);
> +    obj =3D qobject_to(QDict, qlist_entry_obj(entry));
> +    g_assert(qdict_haskey(obj, "properties"));
> +    properties =3D qobject_to(QList, qdict_get(obj, "properties"));
> +
> +    QLIST_FOREACH_ENTRY(properties, prop_entry) {
> +        QDict *prop =3D qobject_to(QDict, qlist_entry_obj(prop_entry));
> +
> +        g_assert(qdict_haskey(prop, "name"));
> +        g_assert(qdict_haskey(prop, "value"));
> +
> +        prop_name =3D qdict_get_str(prop, "name");
> +        if (!strcmp(prop_name, "type")) {
> +            g_assert_cmpstr(qdict_get_str(prop, "value"), =3D=3D,
> +                            "memory-backend-ram");
> +
> +        } else if (!strcmp(prop_name, "size")) {
> +            g_assert_cmpint(qdict_get_int(prop, "value"), =3D=3D, RAM_SI=
ZE);
> +        }
> +    }
> +}
> +
> +static void test_list_get(QTestState *qts, QList *paths)
> +{
> +    QListEntry *entry, *prop_entry, *path_entry;
> +    g_autoptr(QDict) response =3D NULL;
> +    QDict *args =3D qdict_new();
> +    QDict *prop;
> +    QList *return_list;
> +
> +    if (verbosity_level >=3D 2) {
> +        g_test_message("Obtaining properties for paths:");
> +        QLIST_FOREACH_ENTRY(paths, path_entry) {
> +            QString *qstr =3D qobject_to(QString, qlist_entry_obj(path_e=
ntry));
> +            g_test_message("  %s", qstring_get_str(qstr));
> +        }
> +    }
> +
> +    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
> +    response =3D qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
> +                              "  'arguments': %p }", args);
> +    g_assert(response);
> +    g_assert(qdict_haskey(response, "return"));
> +    return_list =3D qobject_to(QList, qdict_get(response, "return"));
> +    g_assert(!qlist_empty(return_list));
> +
> +    path_entry =3D QTAILQ_FIRST(&paths->head);
> +    QLIST_FOREACH_ENTRY(return_list, entry) {
> +        QDict *obj =3D qobject_to(QDict, qlist_entry_obj(entry));
> +        g_assert(qdict_haskey(obj, "properties"));
> +        QList *properties =3D qobject_to(QList, qdict_get(obj, "properti=
es"));
> +        bool has_child =3D false;
> +
> +        QLIST_FOREACH_ENTRY(properties, prop_entry) {
> +            prop =3D qobject_to(QDict, qlist_entry_obj(prop_entry));
> +            g_assert(qdict_haskey(prop, "name"));
> +            g_assert(qdict_haskey(prop, "type"));
> +            has_child |=3D strstart(qdict_get_str(prop, "type"), "child<=
", NULL);
> +        }
> +
> +        if (has_child) {
> +            /* build a list of child paths */
> +            QString *qstr =3D qobject_to(QString, qlist_entry_obj(path_e=
ntry));
> +            const char *path =3D qstring_get_str(qstr);
> +            g_autoptr(QList) child_paths =3D qlist_new();
> +
> +            QLIST_FOREACH_ENTRY(properties, prop_entry) {
> +                prop =3D qobject_to(QDict, qlist_entry_obj(prop_entry));
> +                if (strstart(qdict_get_str(prop, "type"), "child<", NULL=
)) {
> +                    g_autofree char *child_path =3D g_strdup_printf(
> +                        "%s/%s", path, qdict_get_str(prop, "name"));
> +                    qlist_append_str(child_paths, child_path);
> +                }
> +            }
> +
> +            /* fetch props for all children with one qom-list-get call */
> +            test_list_get(qts, child_paths);
> +        }
> +
> +        path_entry =3D QTAILQ_NEXT(path_entry, next);
> +    }
> +}
> +
>  static void test_properties(QTestState *qts, const char *path, bool recu=
rse)
>  {
>      char *child_path;
> @@ -85,8 +193,10 @@ static void test_machine(gconstpointer data)
>      const char *machine =3D data;
>      QDict *response;
>      QTestState *qts;
> +    g_autoptr(QList) paths =3D qlist_new();
>=20=20
> -    qts =3D qtest_initf("-machine %s", machine);
> +    qts =3D qtest_initf("-machine %s -object memory-backend-ram,id=3D%s,=
size=3D%d",
> +                      machine, RAM_NAME, RAM_SIZE);
>=20=20
>      if (g_test_slow()) {
>          /* Make sure we can get the machine class properties: */
> @@ -101,6 +211,10 @@ static void test_machine(gconstpointer data)
>=20=20
>      test_properties(qts, "/machine", true);
>=20=20
> +    qlist_append_str(paths, "/machine");
> +    test_list_get(qts, paths);
> +    test_list_get_value(qts);
> +
>      response =3D qtest_qmp(qts, "{ 'execute': 'quit' }");
>      g_assert(qdict_haskey(response, "return"));
>      qobject_unref(response);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


