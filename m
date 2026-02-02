Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7558E7DEE8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuVL-00071H-Cz; Mon, 02 Feb 2026 09:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmuVI-00070u-7X
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:02:12 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vmuVG-0000J5-Bu
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:02:11 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97E613E763;
 Mon,  2 Feb 2026 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770040924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3TZULktiNUI6Wej2hs4LLJwf5VuE661JbfkF0K8aps=;
 b=vuB9MhQ5qom8CdtRQ4IUncnr8jYY7olC4CDNQKdpQcZ84HnLsM4ctQghKqg4b2u5cAwZJh
 ig4vmYmIbh2knLvI872fKT/zPlX5PuSKA+bKKfMt0yhDCfp3fPKFR2X8t9ygGqfFl7IPv5
 /gbpy3VhtJpmbSWe6c3cMyWZ9JthJt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770040924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3TZULktiNUI6Wej2hs4LLJwf5VuE661JbfkF0K8aps=;
 b=uPiaKXoslWHumNiAUs7+Bmlubu3dO9Zm0gij9hv6A2bSCmzSLWB1CSTxEVyb6rw29zYniU
 Xt6cpzJC2VCYekDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WpTmTV05;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=29AAsxts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770040919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3TZULktiNUI6Wej2hs4LLJwf5VuE661JbfkF0K8aps=;
 b=WpTmTV05IbLJp4hpFrckBNTZe6hYNm1UHLFLJruRJxkuAdG2edPJaZ52oUCThgn2tMJKe8
 Lpjf3eRziP9arz05GLfnS/KE+V2dw/7CDTNW3VUZvgLbEPOexPmsaeF83iBs6oeII8GXpz
 llNXCIFl+ltAR0IPPexJpam6yCg+Fq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770040919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3TZULktiNUI6Wej2hs4LLJwf5VuE661JbfkF0K8aps=;
 b=29AAsxtsMohabktRlpLA8Wmbps6TA9HLYajPhHucpt5lR06v0iOskkDgBHpyz0MU7dQRux
 ArBwK1ZkzSQxQYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 033BC3EA62;
 Mon,  2 Feb 2026 14:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ilOELVaugGkaPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Feb 2026 14:01:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>, =?utf-8?Q?Daniel_P=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan
 <hamza.khan@nutanix.com>, Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt
 <johunt@akamai.com>, Max Tottenham <mtottenh@akamai.com>, Ben Chaney
 <bchaney@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v4 2/8] migration: cpr setup notifier
In-Reply-To: <20260128-cpr-tap-v4-2-48e334d4216b@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <20260128-cpr-tap-v4-2-48e334d4216b@akamai.com>
Date: Mon, 02 Feb 2026 11:01:55 -0300
Message-ID: <87tsvzs0q4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWELVE(0.00)[19]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 97E613E763
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Ben Chaney <bchaney@akamai.com> writes:

> From: Steve Sistare <steven.sistare@oracle.com>
>
> Call MIG_EVENT_PRECOPY_SETUP earlier, before CPR starts.  An early notifier
> is needed for resetting vhost devices, as explained in the next patch.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
>  migration/migration.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index f36e59d9e8..191a34f667 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2306,7 +2306,14 @@ void qmp_migrate(const char *uri, bool has_channels,
>          stopped = true;
>      }
>  
> +    /* Notify before starting migration thread, and before starting cpr */
> +    if (!resume_requested &&
> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
> +        goto out;
> +    }

Probably better at the end of migrate_init() or along with the state
change to SETUP.

Also note that this will emit the event even before connections have
been established. I didn't spot any issues with that.

> +
>      if (!cpr_state_save(cpr_channel, &local_err)) {
> +        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);

Due to changes on master, this now needs to go into
migration_connect_error_propagate() so that all paths that saw
MIG_EVENT_PRECOPY_SETUP also see MIG_EVENT_PRECOPY_FAILED.

  migrate_prepare() -> MIG_EVENT_PRECOPY_SETUP
    migration_connect_error_propagate() -> MIG_EVENT_PRECOPY_FAILED
    migration_iteration_finish() -> MIG_EVENT_PRECOPY_FAILED
  migration_cleanup() -> MIG_EVENT_PRECOPY_DONE

And due to changes queued [0], migration_cleanup() no longer emits the
FAILED event, so migration_connect_error_propagate() needs to send the
event for both FAILED and CANCELLING states, you can use the
migration_has_failed() helper.
https://lore.kernel.org/r/20260126213614.3815900-1-peterx@redhat.com

The special case at migrate_cancel() will also need
MIG_EVENT_PRECOPY_FAILED before resuming the VM.

>          goto out;
>      }
>  
> @@ -4097,11 +4104,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      } else {
>          /* This is a fresh new migration */
>          rate_limit = migrate_max_bandwidth();
> -
> -        /* Notify before starting migration thread */
> -        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
> -            goto fail;
> -        }
>      }
>  
>      migration_rate_set(rate_limit);

