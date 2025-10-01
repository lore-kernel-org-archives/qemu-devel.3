Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D63CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3xSi-0005sS-Ho; Wed, 01 Oct 2025 10:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3xSa-0005mo-1t
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:05:37 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3xSD-0007ol-WF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:05:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2806421A43;
 Wed,  1 Oct 2025 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759327509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WiBtuvpvmy+2ToMVrIk5e4jYvjKJH6WaImXexBkBWIk=;
 b=skwEIoZnqRCDaA7kPsqJb7Hzhp0iwby355XC8643BqBuPZq3OFFPqgcB8DxZx/+ZsObpRC
 vPWkY+kCIi0wnoL2b0+nfUP+DmMVd1PIM6v8Nq/pACYKV2W4uN0dhINxwK6FJdXBKcMty3
 iYVfl1bVUJ2jyeLYAgu6d19acuSNZos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759327509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WiBtuvpvmy+2ToMVrIk5e4jYvjKJH6WaImXexBkBWIk=;
 b=Sr8Shq9iagP2gwVwH75MURZDdZOSJvHgKWGXf3pe1H3q0LLKIUSLkF4vJqJE37vrBLTV8i
 9PHhe1IAAHwdPxDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759327509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WiBtuvpvmy+2ToMVrIk5e4jYvjKJH6WaImXexBkBWIk=;
 b=skwEIoZnqRCDaA7kPsqJb7Hzhp0iwby355XC8643BqBuPZq3OFFPqgcB8DxZx/+ZsObpRC
 vPWkY+kCIi0wnoL2b0+nfUP+DmMVd1PIM6v8Nq/pACYKV2W4uN0dhINxwK6FJdXBKcMty3
 iYVfl1bVUJ2jyeLYAgu6d19acuSNZos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759327509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WiBtuvpvmy+2ToMVrIk5e4jYvjKJH6WaImXexBkBWIk=;
 b=Sr8Shq9iagP2gwVwH75MURZDdZOSJvHgKWGXf3pe1H3q0LLKIUSLkF4vJqJE37vrBLTV8i
 9PHhe1IAAHwdPxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A096513A42;
 Wed,  1 Oct 2025 14:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gmA+GRQ13WglHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 14:05:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH] migration-test: fix migrate_args
In-Reply-To: <1759324985-369944-1-git-send-email-steven.sistare@oracle.com>
References: <1759324985-369944-1-git-send-email-steven.sistare@oracle.com>
Date: Wed, 01 Oct 2025 11:05:06 -0300
Message-ID: <874isid8fh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> migrate_args calls g_test_skip, but that does not end the test.
> It must also return an error code.  This fixes the queued patch
> "migration-test: migrate_args".
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/migration/framework.c | 9 ++++++---
>  tests/qtest/migration/framework.h | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 2dfb1ee..8044b2a 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -258,7 +258,7 @@ static char *test_shmem_path(void)
>      return g_strdup_printf("/dev/shm/qemu-%d", getpid());
>  }
>  
> -void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> +int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>  {
>      /* options for source and target */
>      g_autofree gchar *arch_opts = NULL;
> @@ -351,7 +351,7 @@ void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>      if (!qtest_has_machine(machine_alias)) {
>          g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
>          g_test_skip(msg);
> -        return;
> +        return -1;
>      }
>  
>      machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
> @@ -398,6 +398,7 @@ void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>  
>      *from = cmd_source;
>      *to = cmd_target;
> +    return 0;
>  }
>  
>  int migrate_start(QTestState **from, QTestState **to, const char *uri,
> @@ -419,7 +420,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>      bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
>      src_state.suspend_me = args->suspend_me;
>  
> -    migrate_args(&cmd_source, &cmd_target, uri, args);
> +    if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
> +        return -1;
> +    }
>  
>      if (!args->only_target) {
>          *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 51a8a7e..ad5ca57 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -227,7 +227,7 @@ void wait_for_serial(const char *side);
>  void migrate_prepare_for_dirty_mem(QTestState *from);
>  void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
>  
> -void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
> +int migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
>  int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                    MigrateStart *args);
>  void migrate_end(QTestState *from, QTestState *to, bool test_dest);

Thanks!

