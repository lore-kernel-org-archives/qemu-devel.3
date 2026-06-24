Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AF3CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPV6-00022r-Di; Wed, 24 Jun 2026 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcPV2-00022b-Lf
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:26:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wcPV1-00055B-19
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:26:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11F986DB17;
 Wed, 24 Jun 2026 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782314805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rreAsGiUGIR9EX2+HGXCOgeF+rh0mjH7AmI70H99RY8=;
 b=ZGjHHkdAKyznIQjxHtlxjJ3qpusQvKWVZs2tS5DV5u1aBBmLUBhrCM+wXi3EZE7Sij3J1o
 D6btT0e7R3MSYx6ZwbX9JJxiBEM5GEPtIgpuHm3XF7Urb4V6saGB8rOiG7NnKUAF7KOWep
 YtjRPCZh5LwC0U6qFgqMq515NdF2qZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782314805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rreAsGiUGIR9EX2+HGXCOgeF+rh0mjH7AmI70H99RY8=;
 b=ZsI+oMC134NMz/BbrSkPOIQCdjJ3vtzhsVuw9/DFpSISaHR3GqxPxjnE2xVWAQGtPUh0nN
 nZFwasRlP/l206Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782314805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rreAsGiUGIR9EX2+HGXCOgeF+rh0mjH7AmI70H99RY8=;
 b=ZGjHHkdAKyznIQjxHtlxjJ3qpusQvKWVZs2tS5DV5u1aBBmLUBhrCM+wXi3EZE7Sij3J1o
 D6btT0e7R3MSYx6ZwbX9JJxiBEM5GEPtIgpuHm3XF7Urb4V6saGB8rOiG7NnKUAF7KOWep
 YtjRPCZh5LwC0U6qFgqMq515NdF2qZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782314805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rreAsGiUGIR9EX2+HGXCOgeF+rh0mjH7AmI70H99RY8=;
 b=ZsI+oMC134NMz/BbrSkPOIQCdjJ3vtzhsVuw9/DFpSISaHR3GqxPxjnE2xVWAQGtPUh0nN
 nZFwasRlP/l206Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4F40779A8;
 Wed, 24 Jun 2026 15:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nZxKHTT3O2oCfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 24 Jun 2026 15:26:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peterx@redhat.com, maciej.szmigiero@oracle.com,
 mark.kanda@oracle.com, bchaney@akamai.com
Subject: Re: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
In-Reply-To: <20260621072646.517545-1-dongli.zhang@oracle.com>
References: <20260621072646.517545-1-dongli.zhang@oracle.com>
Date: Wed, 24 Jun 2026 12:26:42 -0300
Message-ID: <87v7b8neml.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dongli Zhang <dongli.zhang@oracle.com> writes:

> Currently the cpr-transfer source QEMU instance cannot be driven entirely
> via HMP.  The source must use QMP in order to specify both the
> main migration channel and the CPR channel.
>
> Extend the HMP migrate command with an optional CPR channel URI. When the
> migration mode is cpr-transfer, HMP uses this URI to build a
> CPR MigrationChannel in addition to the main migration channel. The new
> argument is rejected unless the migration mode is cpr-transfer, so existing
> HMP migrate usage is unchanged.
>
> For example, source QEMU HMP commands can be something like below. The
> "unix:/tmp/cpr.sock" is for CPR URI.
>
> (qemu) migrate_set_parameter mode cpr-transfer
> (qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hmp-commands.hx                | 11 +++++++----
>  migration/migration-hmp-cmds.c | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7ae2468a3d..021e51b142 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -928,16 +928,17 @@ ERST
>  
>      {
>          .name       = "migrate",
> -        .args_type  = "detach:-d,resume:-r,uri:s",
> -        .params     = "[-d] [-r] uri",
> +        .args_type  = "detach:-d,resume:-r,uri:s,uri-cpr:s?",
> +        .params     = "[-d] [-r] uri [uri-cpr]",
>          .help       = "migrate to URI (using -d to not wait for completion)"
> -		      "\n\t\t\t -r to resume a paused postcopy migration",
> +		      "\n\t\t\t -r to resume a paused postcopy migration"
> +		      "\n\t\t\t uri-cpr specifies CPR URI for cpr-transfer mode",
>          .cmd        = hmp_migrate,
>      },
>  
>  
>  SRST
> -``migrate [-d] [-r]`` *uri*
> +``migrate [-d] [-r]`` *uri* [*uri-cpr*]
>    Migrate the VM to *uri*.
>  
>    ``-d``
> @@ -945,6 +946,8 @@ SRST
>      query an ongoing migration process, use "info migrate".
>    ``-r``
>      Resume a paused postcopy migration.
> +  ``uri-cpr``
> +    Specify CPR URI for cpr-transfer mode. It must be a UNIX domain socket.
>  ERST
>  
>      {
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 8b385f560e..42ca652bb3 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -836,9 +836,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool detach = qdict_get_try_bool(qdict, "detach", false);
>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
> +    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
>      Error *err = NULL;
>      g_autoptr(MigrationChannelList) caps = NULL;
>      g_autoptr(MigrationChannel) channel = NULL;
> +    g_autoptr(MigrationChannel) channel_cpr = NULL;
>  
>      if (!migrate_uri_parse(uri, &channel, &err)) {
>          hmp_handle_error(mon, err);
> @@ -846,6 +848,22 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> +    if (uri_cpr) {
> +        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> +            error_setg(&err, "uri-cpr requires cpr-transfer mode");

Most users probably won't know what an uri-cpr is. Maybe: "a second uri
can only be used in cpr-transfer mode".

> +            hmp_handle_error(mon, err);
> +            return;
> +        }
> +
> +        if (!migrate_uri_parse(uri_cpr, &channel_cpr, &err)) {
> +            hmp_handle_error(mon, err);
> +            return;
> +        }
> +
> +        channel_cpr->channel_type = MIGRATION_CHANNEL_TYPE_CPR;
> +        QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel_cpr));
> +    }
> +
>      qmp_migrate(NULL, true, caps, true, resume, &err);
>      if (hmp_handle_error(mon, err)) {
>          return;

