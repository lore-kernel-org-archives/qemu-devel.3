Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD56C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcocz-0008Hs-U5; Wed, 21 Feb 2024 10:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcob0-0002md-NX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcmQh-0005fr-Bc
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708521270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJAEW1CVsEUDJ8NvEH259oewIERAgHAVG1IR1MjnwxY=;
 b=Wt9fytlJJBeuJWn56k3XKZpwDEl/4McMYqxX+xKP4/djZ9oGSRjGWYLSC6eY9YfyhFr807
 h5PeGXuC1dR9IZh0YfugATBvSX6ftBx2ZmcqcQ1Trsv6rVVRmvtliDwfvpQcw2nHgaKv+m
 aCqPIWmA936PUrEFgqlDhpkU6vLbSi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-qs-FrTo_Mg2zOmSuj8oc0A-1; Wed, 21 Feb 2024 08:14:24 -0500
X-MC-Unique: qs-FrTo_Mg2zOmSuj8oc0A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2FFF86306E;
 Wed, 21 Feb 2024 13:14:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 850B6492BDA;
 Wed, 21 Feb 2024 13:14:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61EC721E6740; Wed, 21 Feb 2024 14:14:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 3/5] util: strv_from_strList
In-Reply-To: <1705099758-211963-4-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 12 Jan 2024 14:49:16 -0800")
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-4-git-send-email-steven.sistare@oracle.com>
Date: Wed, 21 Feb 2024 14:14:21 +0100
Message-ID: <87le7e3qoi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
>  include/qemu/strList.h |  6 ++++++
>  util/strList.c         | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/include/qemu/strList.h b/include/qemu/strList.h
> index 010237f..4b86aa6 100644
> --- a/include/qemu/strList.h
> +++ b/include/qemu/strList.h
> @@ -21,4 +21,10 @@
>   */
>  strList *strList_from_string(const char *in, const char *delim);
>=20=20
> +/*
> + * Produce and return a NULL-terminated array of strings from @args.
> + * The result is g_malloc'd and all strings are g_strdup'd.
> + */
> +GStrv strv_from_strList(const strList *args);
> +
>  #endif
> diff --git a/util/strList.c b/util/strList.c
> index 7991de3..bad4187 100644
> --- a/util/strList.c
> +++ b/util/strList.c
> @@ -22,3 +22,17 @@ strList *strList_from_string(const char *str, const ch=
ar *delim)
>=20=20
>      return res;
>  }
> +
> +GStrv strv_from_strList(const strList *args)

Suggest to name the argument @list.

> +{
> +    const strList *arg;

Suggest to name this @tail.

> +    int i =3D 0;
> +    GStrv argv =3D g_new(char *, QAPI_LIST_LENGTH(args) + 1);
> +
> +    for (arg =3D args; arg !=3D NULL; arg =3D arg->next) {
> +        argv[i++] =3D g_strdup(arg->value);
> +    }
> +    argv[i] =3D NULL;
> +
> +    return argv;
> +}

Can we use char ** instread of GStrv?  I'd find that clearer.  For what
it's worth, GLib documentation of functions like g_strsplit() doesn't
use the GStrv typedef, either.


