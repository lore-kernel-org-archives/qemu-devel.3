Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4589FD0E3F3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43bs-0005Al-83; Thu, 24 Oct 2024 15:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t43bi-0005AC-0r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:34:54 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t43be-0006hG-IF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:34:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B959D1F787;
 Thu, 24 Oct 2024 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729798488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5fFYRQAYtIhnGGHF8K5qNteNi/a/teNfac/F/xGxfA=;
 b=C5Ww95CfT7ymBEJttV/qOHBc40+vpNSfIV3eu3I6GH5xOz6P2nW6GfUiFse7FY62gPBeO9
 oBzVZJDv31GBqkQdm2hOChlF+AJNIu2HZFAZAhCcC5DdH0LIkZlgn63pvO1kV1KYsJGilx
 Caf6K4PmD6eWC3OreZUpRq8iiKsz0QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729798488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5fFYRQAYtIhnGGHF8K5qNteNi/a/teNfac/F/xGxfA=;
 b=Vy2D5jX23is2mIXR0MueNP0xjW6IBeWzNrcNVhAgOjcy1Nu8weiNsmj1PhIGYM8S1KXUiy
 AEMht2HkimrkzhAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729798488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5fFYRQAYtIhnGGHF8K5qNteNi/a/teNfac/F/xGxfA=;
 b=C5Ww95CfT7ymBEJttV/qOHBc40+vpNSfIV3eu3I6GH5xOz6P2nW6GfUiFse7FY62gPBeO9
 oBzVZJDv31GBqkQdm2hOChlF+AJNIu2HZFAZAhCcC5DdH0LIkZlgn63pvO1kV1KYsJGilx
 Caf6K4PmD6eWC3OreZUpRq8iiKsz0QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729798488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5fFYRQAYtIhnGGHF8K5qNteNi/a/teNfac/F/xGxfA=;
 b=Vy2D5jX23is2mIXR0MueNP0xjW6IBeWzNrcNVhAgOjcy1Nu8weiNsmj1PhIGYM8S1KXUiy
 AEMht2HkimrkzhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F37501368E;
 Thu, 24 Oct 2024 19:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oU/eLFehGmeuDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 24 Oct 2024 19:34:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Igor Mammedov <imammedo@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David
 Alan Gilbert" <dave@treblig.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] migration: Reset current_migration properly
In-Reply-To: <20241024165627.1372621-5-peterx@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-5-peterx@redhat.com>
Date: Thu, 24 Oct 2024 16:34:44 -0300
Message-ID: <875xphfg6j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
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

> current_migration is never reset, even if the migration object is freed
> already.  It means anyone references that can trigger UAF and it'll be hard
> to debug.
>
> Properly clear the pointer now, so far the only way to do is via
> finalize() as we know there's only one instance of it, meanwhile QEMU won't
> know who holds the refcount, so it can't reset the variable manually but
> only in finalize().
>
> To make it more readable, also initialize the variable in the
> instance_init() so it's very well paired at least.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 1b5285af95..74812ca785 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -233,9 +233,11 @@ static int migration_stop_vm(MigrationState *s, RunState state)
>  
>  void migration_object_init(void)
>  {
> -    /* This can only be called once. */
> -    assert(!current_migration);
> -    current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
> +    /* This creates the singleton migration object */
> +    object_new(TYPE_MIGRATION);
> +
> +    /* This should be set now when initialize the singleton object */
> +    assert(current_migration);
>  
>      /*
>       * Init the migrate incoming object as well no matter whether
> @@ -3886,12 +3888,27 @@ static void migration_instance_finalize(Object *obj)
>      qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
>      qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
>      error_free(ms->error);
> +
> +    /*
> +     * We know we only have one intance of migration, and when reaching

instance

> +     * here it means migration object is gone.  Clear the global reference
> +     * to reflect that.

Not really gone at this point. The free only happens when this function
returns.

> +     */
> +    current_migration = NULL;
>  }
>  
>  static void migration_instance_init(Object *obj)
>  {
>      MigrationState *ms = MIGRATION_OBJ(obj);
>  
> +    /*
> +     * There can only be one migration object globally. Keep a record of
> +     * the pointer in current_migration, which will be reset after the
> +     * object finalize().
> +     */
> +    assert(!current_migration);
> +    current_migration = ms;
> +
>      ms->state = MIGRATION_STATUS_NONE;
>      ms->mbps = -1;
>      ms->pages_per_second = -1;

