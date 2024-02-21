Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A3EC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoNv-0000jY-UP; Wed, 21 Feb 2024 10:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoKp-0001hh-Gc
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcmet-0007zX-4t
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708522148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CW3dvocXjydBQWBtZlsGFlO9RdT8KstgMzvafnJJ+r4=;
 b=HMv6YVVtd1oTKiuM6J5GrQcUqZp0/nvM8lR7t/r7ug0xq87b6SWmPCDUTNiKInXrul8Ifk
 ZqAi4l7GtsOBrB6rTWi1p69bCOY7n3J17bx/wQkcMxJIBaqUP1EcxUnC8qH9WY6B9beF6p
 wGUgmYfrnu9SgoVcY3ifrDc+DaKU9j4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-G5O782JfMByJP71v3iS84g-1; Wed,
 21 Feb 2024 08:29:06 -0500
X-MC-Unique: G5O782JfMByJP71v3iS84g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0588A2820B78;
 Wed, 21 Feb 2024 13:29:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D44F610800;
 Wed, 21 Feb 2024 13:29:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D58D621E66D5; Wed, 21 Feb 2024 14:29:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 2/5] qapi: QAPI_LIST_LENGTH
In-Reply-To: <1705099758-211963-3-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 12 Jan 2024 14:49:15 -0800")
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-3-git-send-email-steven.sistare@oracle.com>
Date: Wed, 21 Feb 2024 14:29:04 +0100
Message-ID: <877ciy3pzz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
>  include/qapi/util.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index 81a2b13..e1b8b1d 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -56,4 +56,17 @@ int parse_qapi_name(const char *name, bool complete);
>      (tail) =3D &(*(tail))->next; \
>  } while (0)
>=20=20
> +/*
> + * For any GenericList @list, return its length.
> + */
> +#define QAPI_LIST_LENGTH(list) \
> +    ({ \
> +        int len =3D 0; \

size_t

> +        typeof(list) elem; \

Name this @tail, please.

> +        for (elem =3D list; elem !=3D NULL; elem =3D elem->next) { \
> +            len++; \
> +        } \
> +        len; \
> +    })
> +
>  #endif

This is a macro instead of a function so users don't have to cast their
FooList * to GenericList *.

The only user outside tests is strv_from_strList().  I'd be tempted to
open-code it there and call it a day.  Or do you have more users in
mind?

If we keep the macro, please align the backslashes like this:

   #define QAPI_LIST_LENGTH(list)                                  \
       ({                                                          \
           int len =3D 0;                                            \
           typeof(list) elem;                                      \
           for (elem =3D list; elem !=3D NULL; elem =3D elem->next) {    \
               len++;                                              \
           }                                                       \
           len;                                                    \
       })


