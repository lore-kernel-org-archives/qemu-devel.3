Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD1EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 13:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH1yb-0002y6-VH; Tue, 11 Jun 2024 09:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sH1yb-0002xG-1A
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sH1yZ-0000Cf-FM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 09:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718114149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJyfgniAhZVKhhbthOgQXlleID2ouP3pT15ACeBfZdo=;
 b=Ym3W1hG3b39pI6J9n2OHEZtivgFDm0uLSfwxH/nC2iTO8XLDrmGjcIEUClv9NLslkg1MAm
 bsPy3/rbX6iJBrwAnKAxaj6M67aWPx0VzeUNvxmpK5gaRfThpN+WicwhaVFJCg7Bi7C3AM
 rPC4AzFKfVAH9FWViv6+5vbe3pTPM80=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-pFOElUAgMoyVKqNPl-Q-8A-1; Tue,
 11 Jun 2024 09:55:44 -0400
X-MC-Unique: pFOElUAgMoyVKqNPl-Q-8A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AC2519560B1; Tue, 11 Jun 2024 13:55:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 183511956048; Tue, 11 Jun 2024 13:55:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0250221E6682; Tue, 11 Jun 2024 15:55:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 08/20] qga: conditionalize schema for commands
 unsupported on Windows
In-Reply-To: <20240604134933.220112-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 4 Jun 2024 14:49:21
 +0100")
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-9-berrange@redhat.com>
Date: Tue, 11 Jun 2024 15:55:37 +0200
Message-ID: <87ed93k2hy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the commands on Windows.
>
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
>
> This fixes inconsistency where some commands are implemented
> as stubs, yet not added to the blockedrpc list.
>
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-win32.c | 56 +-------------------------------------------
>  qga/qapi-schema.json | 45 +++++++++++++++++++++++------------
>  2 files changed, 31 insertions(+), 70 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 9fe670d5b4..2533e4c748 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c

[...]

>  /* add unsupported commands to the list of blocked RPCs */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
> -    const char *list_unsupported[] =3D {
> -        "guest-suspend-hybrid",
> -        "guest-set-vcpus",
> -        "guest-get-memory-blocks", "guest-set-memory-blocks",
> -        "guest-get-memory-block-info",
> -        NULL};
> -    char **p =3D (char **)list_unsupported;
> -
> -    while (*p) {
> -        blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> -    }
> -
>      if (!vss_init(true)) {
>          g_debug("vss_init failed, vss commands are going to be disabled"=
);
>          const char *list[] =3D {
>              "guest-get-fsinfo", "guest-fsfreeze-status",
>              "guest-fsfreeze-freeze", "guest-fsfreeze-thaw", NULL};
> -        p =3D (char **)list;
> +        char **p =3D (char **)list;
>=20=20
>          while (*p) {
>              blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
           }
       }

       return blockedrpcs;
   }

Four commands get disabled when vss_init() fails, i.e. when qga-vss.dll
can't be loaded and initialized.

Three of the four commands do this first:

        if (!vss_initialized()) {
            error_setg(errp, QERR_UNSUPPORTED);
            return 0;
        }

The execption is qmp_guest_get_fsinfo().

vss_initialized() returns true between successful vss_init() and
vss_deinit().

Aside: we call vss_init() in three places.  Two of them init, call
something, then deinit.  Weird.  Moving on.

If these commands are meant to be only available when the DLL is, then
having them check vss_initialized() is useless.

Conversely, if the check isn't useless, then the "make it available
only" business is.

Opportunity for further cleanup?

[...]


