Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9F2C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxZ7-0007F1-O5; Tue, 11 Jun 2024 05:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGxZ3-0007EM-CK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sGxZ1-0004Ma-Dj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718097190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJ4nMjzNjW74YyFSS9vJjosGVpy81l031GC9dsz0yl4=;
 b=WzL0QEsTuth0w+GRYXLJfmYqjPLk2tlUpvNfVHOA1ltz+FfJLdWSVDk/VAebYB+E8PfveP
 6uThghDU8FW4i3gnWpQcC0bO8kyXz+em78+iTPirJsXpxuLzBljU2n/ZIobRWM+nYq/EO+
 9GvuEmI03KVfRLxgYwChR1tBWn03Z+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-NsovCs2_O4CIoKF6eclrLg-1; Tue,
 11 Jun 2024 05:13:04 -0400
X-MC-Unique: NsovCs2_O4CIoKF6eclrLg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9596D19560B0; Tue, 11 Jun 2024 09:13:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E15061956087; Tue, 11 Jun 2024 09:13:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0CB621E681D; Tue, 11 Jun 2024 11:13:00 +0200 (CEST)
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
Date: Tue, 11 Jun 2024 11:13:00 +0200
Message-ID: <87a5jrlu5f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the commands on Windows.
>
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.

The commit message should mention that the value of "error" in the error
response changes from

    {"class": "GenericError, "desc": "this feature or command is not curren=
tly supported"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been foun=
d"}

> This fixes inconsistency where some commands are implemented
> as stubs, yet not added to the blockedrpc list.

Example?

> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.

Yes!

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
> @@ -1494,11 +1494,6 @@ out:
>      }
>  }
>=20=20
> -void qmp_guest_suspend_hybrid(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -}
> -
>  static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
>  {
>      IP_ADAPTER_ADDRESSES *adptr_addrs =3D NULL;
> @@ -1862,12 +1857,6 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Err=
or **errp)
>      return NULL;
>  }
>=20=20
> -int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **er=
rp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return -1;
> -}
> -
>  static gchar *
>  get_net_error_message(gint error)
>  {
> @@ -1969,46 +1958,15 @@ done:
>      g_free(rawpasswddata);
>  }
>=20=20
> -GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestMemoryBlockResponseList *
> -qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
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

Can you make @p const and drop the cast?

>=20=20
>          while (*p) {
>              blockedrpcs =3D g_list_append(blockedrpcs, g_strdup(*p++));
> @@ -2505,15 +2463,3 @@ char *qga_get_host_name(Error **errp)
>=20=20
>      return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
>  }
> -
> -GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> -
> -GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}

Reducing use of QERR_UNSUPPORTED is lovely.


[Schema patch snipped; it looks good to me...]


