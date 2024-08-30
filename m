Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23846CA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 19:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk7It-0003I9-V6; Fri, 30 Aug 2024 15:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk7In-0003HN-Cv
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 15:28:57 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk7Il-0001QH-Hr
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 15:28:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF8CD1F7E8;
 Fri, 30 Aug 2024 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725046132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1F4wKwi7av5kijwG+KhCYCM9j8MZHP2C/kGpYu/YMM=;
 b=hk8VnfFvTNCFU+TsDxP3FcTLK8H+YVNFk457Sz9zZ5dHmZdPkkxURAkVJWSFmaW7qDrPW5
 rchJ/orh/n9/GTPk/ziXrzQpTTQB3fuKPGebKg2EHuyYJ9zcZ/o8buPI5okfBQ+FxpKG0j
 csR1IBULJex4wy7wcxWNwAdEtXvICZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725046132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1F4wKwi7av5kijwG+KhCYCM9j8MZHP2C/kGpYu/YMM=;
 b=H/ViIWBk544MTt+zwJXo/zj8lWYGjQtry0+KaWqhCpVAC3Sr7zjmZ19gb4UX3pAuULweJk
 elR4qbrIe1VhS/Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="L3/B+qnm";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Aqz2LsQ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725046131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1F4wKwi7av5kijwG+KhCYCM9j8MZHP2C/kGpYu/YMM=;
 b=L3/B+qnmsiLMkFJW7okKMmCs8e+38B1I/Rf5Lj4vhihi9tCpyhDUIcT+LfRMbFD2SNAI16
 PgQDF+Rk6iV7k6fCjjchtQ5xi6N30+PfipBuxksD8P4ZkJ+erOGUn4clkwN5NsNsAz1t0W
 IQDtOpCL+1/9v2ZJiDEFaaojVvGEFSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725046131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1F4wKwi7av5kijwG+KhCYCM9j8MZHP2C/kGpYu/YMM=;
 b=Aqz2LsQ6WV6xNzA2gM64ZiTFUgkxi5FBtKQlrbA7Hq/FKOXqNePlX1gq4gsXMNEq7jQnHr
 6QwuGo7bc/4/hXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DC67139D3;
 Fri, 30 Aug 2024 19:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id se4UBXMd0mb5PgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 30 Aug 2024 19:28:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
In-Reply-To: <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
Date: Fri, 30 Aug 2024 16:28:48 -0300
Message-ID: <87wmjxn72n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CF8CD1F7E8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> load_finish SaveVMHandler allows migration code to poll whether
> a device-specific asynchronous device state loading operation had finished.
>
> In order to avoid calling this handler needlessly the device is supposed
> to notify the migration code of its possible readiness via a call to
> qemu_loadvm_load_finish_ready_broadcast() while holding
> qemu_loadvm_load_finish_ready_lock.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/migration/register.h | 21 +++++++++++++++
>  migration/migration.c        |  6 +++++
>  migration/migration.h        |  3 +++
>  migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
>  migration/savevm.h           |  4 +++
>  5 files changed, 86 insertions(+)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 4a578f140713..44d8cf5192ae 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
>      int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
>                               Error **errp);
>  
> +    /**
> +     * @load_finish
> +     *
> +     * Poll whether all asynchronous device state loading had finished.
> +     * Not called on the load failure path.
> +     *
> +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> +     *
> +     * If this method signals "not ready" then it might not be called
> +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> +     * while holding qemu_loadvm_load_finish_ready_lock.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @is_finished: whether the loading had finished (output parameter)
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     * It's not an error that the loading still hasn't finished.
> +     */
> +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> +
>      /**
>       * @load_setup
>       *
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d57732..d61e7b055e07 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -259,6 +259,9 @@ void migration_object_init(void)
>  
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>  
> +    qemu_mutex_init(&current_incoming->load_finish_ready_mutex);
> +    qemu_cond_init(&current_incoming->load_finish_ready_cond);
> +
>      migration_object_check(current_migration, &error_fatal);
>  
>      ram_mig_init();
> @@ -410,6 +413,9 @@ void migration_incoming_state_destroy(void)
>          mis->postcopy_qemufile_dst = NULL;
>      }
>  
> +    qemu_mutex_destroy(&mis->load_finish_ready_mutex);
> +    qemu_cond_destroy(&mis->load_finish_ready_cond);
> +
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index 38aa1402d516..4e2443e6c8ec 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -230,6 +230,9 @@ struct MigrationIncomingState {
>  
>      /* Do exit on incoming migration failure */
>      bool exit_on_error;
> +
> +    QemuCond load_finish_ready_cond;
> +    QemuMutex load_finish_ready_mutex;

With these moved to MigrationState:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

