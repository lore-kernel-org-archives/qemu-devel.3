Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34082C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwYS-0007ao-AQ; Tue, 11 Jun 2024 04:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGwYQ-0007a4-Li
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGwYP-00007x-6P
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718093308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYWOEW5l52GMVars1TqifS6EtYD9LWzszaOM8oR+EBc=;
 b=R1Jqc510E7/8OiYi5WJzu6RVZE6T8pJE+vSFxHuErMeV1/DE+x5GZpfJ5mE3zGKddB1M3x
 V4L9J045JjtRzCnSvWf3Stfe2zYHCpqUKJYzTow2gHPvOibmjeen2nrd0hauIJlUKGk5GG
 MBurzghVLkjokQpdHedhF2Pbt16ln/E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-lxxl7jb1PciaS628H6EHvA-1; Tue,
 11 Jun 2024 04:08:24 -0400
X-MC-Unique: lxxl7jb1PciaS628H6EHvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3C6D1956094; Tue, 11 Jun 2024 08:08:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE0219560AB; Tue, 11 Jun 2024 08:08:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 62EEA21E6682; Tue, 11 Jun 2024 10:08:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 18/20] qga: add note about where to disable commands for
 a platform
In-Reply-To: <20240604134933.220112-19-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 4 Jun 2024 14:49:31
 +0100")
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-19-berrange@redhat.com>
Date: Tue, 11 Jun 2024 10:08:20 +0200
Message-ID: <87msnrlx57.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

> Any command that is known to be unimplemented on a given build target
> must be disabled using a QAPI schema conditional. Only use dynamidc

Suggest "should be disabled", for consistency with the comment below.

s/dynamidc/dynamic/

> disabling for commands that require a runtime feature check.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-posix.c | 8 +++++++-
>  qga/commands-win32.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index f4104f2760..8f09162562 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1136,7 +1136,13 @@ error:
>=20=20
>  #endif /* HAVE_GETIFADDRS */
>=20=20
> -/* add unsupported commands to the list of blocked RPCs */
> +/*
> + * Add commands that cannot be supported based on the results of
> + * dynamic check of the running OS installation.
> + *
> + * Commands that cannot be supported at all on a given platform
> + * should be disabled with a condition in the QAPI schema.
> + */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
>      return blockedrpcs;
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 2533e4c748..0198e37a96 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1958,7 +1958,13 @@ done:
>      g_free(rawpasswddata);
>  }
>=20=20
> -/* add unsupported commands to the list of blocked RPCs */
> +/*
> + * Add commands that cannot be supported based on the results of
> + * dynamic check of the running OS installation.
> + *
> + * Commands that cannot be supported at all on Wnidows

s/Wnidows/Windows/

> + * should be disabled with a condition in the QAPI schema.
> + */
>  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>  {
>      if (!vss_init(true)) {

Both functions will be unused after PATCH 20.  Remove them there, and
drop this patch?


