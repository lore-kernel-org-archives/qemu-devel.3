Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11sk-0002ib-TB; Tue, 23 Sep 2025 08:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v11si-0002i8-VN
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v11sW-0005E6-0n
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758629531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNnMDmC5IJuwEeVAA46sq5fAhML7kbcvja4cFbP1fAc=;
 b=iya5MVvi3neBxMp7gnyOEhwcGp5sPNIi3/ZReDy0ZUurOMEeFAOO98KexiraygRnJyHOUp
 gtDMrco9r7fGGhbhjPj2flEzfzLP+B3+tWOvyjDQb88c0fjWlVhCOA6JyZmMZbPuau9zxU
 BzeXV7Xn/pAheYrFjOo/NZvRM+rK9mI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-1wXQJXNlNYu9WsTzSXO7cA-1; Tue,
 23 Sep 2025 08:12:08 -0400
X-MC-Unique: 1wXQJXNlNYu9WsTzSXO7cA-1
X-Mimecast-MFC-AGG-ID: 1wXQJXNlNYu9WsTzSXO7cA_1758629526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 339F218002C2; Tue, 23 Sep 2025 12:12:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C913000198; Tue, 23 Sep 2025 12:12:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C638B21E6A27; Tue, 23 Sep 2025 14:12:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 07/20] util: add API to fetch the current thread name
In-Reply-To: <20250910180357.320297-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 10 Sep 2025 19:03:44
 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-8-berrange@redhat.com>
Date: Tue, 23 Sep 2025 14:12:02 +0200
Message-ID: <877bxp9xm5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

> This will be used to include the thread name in error reports
> in a later patch. It returns a const string stored in a thread
> local to avoid memory allocation when it is called repeatedly
> in a single thread. This makes the assumption that the thread
> name is set at the very start of the thread, which is the case
> when using qemu_thread_create.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 7a734a7a09..e3789c20d1 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c

[...]

> @@ -412,3 +418,38 @@ bool qemu_thread_is_self(QemuThread *thread)
>  {
>      return GetCurrentThreadId() =3D=3D thread->tid;
>  }
> +
> +static __thread char namebuf[64];
> +
> +const char *qemu_thread_get_name(void)
> +{
> +    HRESULT hr;
> +    wchar_t *namew =3D NULL;
> +    g_autofree char *name =3D NULL;
> +
> +    if (namebuf[0] !=3D '\0') {
> +        return namebuf;
> +    }
> +
> +    if (!load_thread_description()) {
> +        goto error;
> +    }
> +
> +    hr =3D GetThreadDescriptionFunc(GetCurrentThread(), &namew);
> +    if (!SUCCEEDED(hr)) {
> +        goto error;
> +    }
> +
> +    name =3D g_utf16_to_utf8(namew, -1, NULL, NULL, NULL);
> +    LocalFree(namew);
> +    if (!name) {
> +        goto error;
> +    }
> +
> +    g_strlcpy(namebuf, name, G_N_ELEMENTS(namebuf));
> +    return namebuf;
> +
> + error:
> +    strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
> +    return namebuf;
> +}

../util/qemu-thread-win32.c: In function 'qemu_thread_get_name':
../util/qemu-thread-win32.c:453:5: error: implicit declaration of function =
'strlcpy'; did you mean 'strncpy'? [-Wimplicit-function-declaration]
  453 |     strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
      |     ^~~~~~~
      |     strncpy
../util/qemu-thread-win32.c:453:5: error: nested extern declaration of 'str=
lcpy' [-Werror=3Dnested-externs]


