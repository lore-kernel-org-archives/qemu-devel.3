Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D5C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoP2-0004qF-SJ; Wed, 21 Feb 2024 10:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoKf-0001tO-VR
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcmVm-0006YX-Jf
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708521584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGlZeqB037EddFj96Sihc4gPr+/6A279l76wrM6Fo48=;
 b=ZKQl0hlffONkeKHUyP9ZBTEopEzLSdhxTrVyG9lwlEGBuPa/leVUsO4eVr0QOuVSIlpb0T
 njwM2g81a+K5zH8gD79P8Xw2YH9XiJqz7B/VsXO/8ajvEUSwBLNw4+GujR2X9hoYtfogs6
 P3Y3TXsqXK0EXXJyG3zKBQqc9Uu+3n8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-iw-E4Y-YN0mea-6lGZUkrA-1; Wed,
 21 Feb 2024 08:19:40 -0500
X-MC-Unique: iw-E4Y-YN0mea-6lGZUkrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 972DE3811F22;
 Wed, 21 Feb 2024 13:19:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70D6E401A742;
 Wed, 21 Feb 2024 13:19:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2AD3A21E6740; Wed, 21 Feb 2024 14:19:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 4/5] util: strList unit tests
In-Reply-To: <1705099758-211963-5-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 12 Jan 2024 14:49:17 -0800")
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-5-git-send-email-steven.sistare@oracle.com>
Date: Wed, 21 Feb 2024 14:19:37 +0100
Message-ID: <87edd63qfq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/unit/meson.build    |  1 +
>  tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 tests/unit/test-strList.c
>
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 69f9c05..113d12e 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -35,6 +35,7 @@ tests =3D {
>    'test-rcu-simpleq': [],
>    'test-rcu-tailq': [],
>    'test-rcu-slist': [],
> +  'test-strList': [],
>    'test-qdist': [],
>    'test-qht': [],
>    'test-qtree': [],
> diff --git a/tests/unit/test-strList.c b/tests/unit/test-strList.c
> new file mode 100644
> index 0000000..49a1cfd
> --- /dev/null
> +++ b/tests/unit/test-strList.c
> @@ -0,0 +1,80 @@
> +/*
> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/strList.h"
> +
> +static strList *make_list(int length)
> +{
> +    strList *head =3D 0, *list, **prev =3D &head;
> +
> +    while (length--) {
> +        list =3D *prev =3D g_new0(strList, 1);
> +        list->value =3D g_strdup("aaa");
> +        prev =3D &list->next;
> +    }
> +    return head;
> +}
> +
> +static void test_length(void)
> +{
> +    strList *list;
> +    int i;
> +
> +    for (i =3D 0; i < 5; i++) {
> +        list =3D make_list(i);
> +        g_assert_cmpint(i, =3D=3D, QAPI_LIST_LENGTH(list));
> +        qapi_free_strList(list);
> +    }
> +}
> +
> +struct {
> +    const char *string;
> +    const char *delim;
> +    const char *args[5];
> +} list_data[] =3D {
> +    { 0, ",", { 0 } },
> +    { "", ",", { 0 } },
> +    { "a", ",", { "a", 0 } },
> +    { "a,b", ",", { "a", "b", 0 } },
> +    { "a,b,c", ",", { "a", "b", "c", 0 } },
> +    { "first last", " ", { "first", "last", 0 } },
> +    { "a:", ":", { "a", "", 0 } },
> +    { "a::b", ":", { "a", "", "b", 0 } },
> +    { ":", ":", { "", "", 0 } },
> +    { ":a", ":", { "", "a", 0 } },
> +    { "::a", ":", { "", "", "a", 0 } },
> +};

NULL instead of 0, please.

> +
> +static void test_strv(void)
> +{
> +    int i, j;
> +    const char **expect;
> +    strList *list;
> +    GStrv args;

I'd prefer char **argv;

> +
> +    for (i =3D 0; i < ARRAY_SIZE(list_data); i++) {
> +        expect =3D list_data[i].args;
> +        list =3D strList_from_string(list_data[i].string, list_data[i].d=
elim);
> +        args =3D strv_from_strList(list);
> +        qapi_free_strList(list);
> +        for (j =3D 0; expect[j] && args[j]; j++) {

Loop stops when either array element is null.  That's wrong, we need to
exhaust both arrays: || instead of &&.

> +            g_assert_cmpstr(expect[j], =3D=3D, args[j]);
> +        }
> +        g_assert_null(expect[j]);
> +        g_assert_null(args[j]);
> +        g_strfreev(args);
> +    }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/test-string/length", test_length);
> +    g_test_add_func("/test-string/strv", test_strv);
> +    return g_test_run();
> +}


