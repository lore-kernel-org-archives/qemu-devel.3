Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77A7CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXv5-000824-No; Wed, 22 Oct 2025 08:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXup-00081G-Ns
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:26:08 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXuj-0007vO-OS
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:26:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35AFF1F38A;
 Wed, 22 Oct 2025 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761135951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MzvX21+jzwyVxWQagC5iEPYZpdUjqGEhYDX9XCmya4I=;
 b=OXfSy1XxbKqadYvHl1TF2YM9ZpBM2aQqvlSOHiIx9YQBTb9YYIpGNNmwTaK1C+nI92RIAe
 wzGen/A03Henu24CAY5evdwzQHhzG/Q70YCgm/bgtcB3TMEM49/i2EQtH9sWnhiHmVNtSv
 wwWTGZr6UC1vypQ+dtPIdol3bL9cNcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761135951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MzvX21+jzwyVxWQagC5iEPYZpdUjqGEhYDX9XCmya4I=;
 b=Pdr63z+qOwivECx1l419/jUgrzB2KqPJyLsG4bpdQQsTynTIZwPRfNo0RXykMcrgO2fTfb
 boppD/ZBThCQLYAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761135947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MzvX21+jzwyVxWQagC5iEPYZpdUjqGEhYDX9XCmya4I=;
 b=ll8RDRkFZGTA2VP6oKTS+dsfbCto/k+hxWILeBf9/FYYtKtkUnunZT3PLzhysGAtmJ79zp
 vPjJiHWIYrrte1eCOc6Q2sAmBy3s0nRMJ5+HiSShj12Pg1DG0YiHVhr6z0V0i01Cea+gip
 wYV3IFfBE+LhO81iflw7lEL9YgtBuhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761135947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MzvX21+jzwyVxWQagC5iEPYZpdUjqGEhYDX9XCmya4I=;
 b=B0GQ62/o0QJZaLz6GcqIU99wMR3LLLPvF8iGvDJc5sKQo1b2KPNfANJs1kezf0pwTQcQXE
 KEWr9hSKf5Wk4KAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5F2313A29;
 Wed, 22 Oct 2025 12:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GhpbGUrN+GjiKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Oct 2025 12:25:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon
 <armenon@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 1/4] migration: Fix error leak in
 postcopy_ram_listen_thread()
In-Reply-To: <20251021220407.2662288-2-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
 <20251021220407.2662288-2-peterx@redhat.com>
Date: Wed, 22 Oct 2025 09:25:43 -0300
Message-ID: <87cy6ft96g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> As reported and analyzed by Peter:
>
> https://lore.kernel.org/r/CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com
>
> Fix it by freeing the error.  When at it, always reset the local_err
> pointer in both paths.
>
> Cc: Arun Menon <armenon@redhat.com>
> Resolves: Coverity CID 1641390
> Fixes: 94272d9b45 ("migration: Capture error in postcopy_ram_listen_thread()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index aafa40d779..232cae090b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2136,17 +2136,18 @@ static void *postcopy_ram_listen_thread(void *opaque)
>          if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
>              !migrate_postcopy_ram() && migrate_dirty_bitmaps())
>          {
> -            error_report("%s: loadvm failed during postcopy: %d. All states "
> +            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
>                           "are migrated except dirty bitmaps. Some dirty "
>                           "bitmaps may be lost, and present migrated dirty "
>                           "bitmaps are correctly migrated and valid.",
> -                         __func__, load_res);
> +                         __func__, load_res, error_get_pretty(local_err));
> +            g_clear_pointer(&local_err, error_free);
>              load_res = 0; /* prevent further exit() */
>          } else {
>              error_prepend(&local_err,
>                            "loadvm failed during postcopy: %d: ", load_res);
>              migrate_set_error(migr, local_err);
> -            error_report_err(local_err);
> +            g_clear_pointer(&local_err, error_report_err);
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                             MIGRATION_STATUS_FAILED);
>          }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

