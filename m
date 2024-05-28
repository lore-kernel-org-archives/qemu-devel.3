Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6AEC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxF1-0003ml-Nb; Tue, 28 May 2024 09:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sBxF0-0003mX-9Y; Tue, 28 May 2024 09:51:50 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sBxEy-0004QQ-1h; Tue, 28 May 2024 09:51:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 987FA201D1;
 Tue, 28 May 2024 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716904304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nrj52OarBBqq6zH+2XLLQOEHMXAWNUVKr5N+9skRiU=;
 b=vGIdWqt6lOUvh5Lt46+r3VDIbf+zfrp401EBFdVXfijP2/gjWTS04NpC1aX+0L7BQ8p4hq
 WXr5XzpTTqkEZHavzu+tdcxzj442VF3s6xgqPjz5VD3FHWJYK/GMsb8+bwirh+xaYgp1BU
 LfbJi3Sdb8sGDG7jPO75LcrG46u8bZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716904304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nrj52OarBBqq6zH+2XLLQOEHMXAWNUVKr5N+9skRiU=;
 b=ppgfmvNmjWPxcsVc7zKgjZzwpn79rVVjcibI4AYjfhaEg2CdBdMKKKYr0q2Z+IcMls3nsH
 gO3Q/hZ8bpq8wZBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vGIdWqt6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ppgfmvNm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716904304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nrj52OarBBqq6zH+2XLLQOEHMXAWNUVKr5N+9skRiU=;
 b=vGIdWqt6lOUvh5Lt46+r3VDIbf+zfrp401EBFdVXfijP2/gjWTS04NpC1aX+0L7BQ8p4hq
 WXr5XzpTTqkEZHavzu+tdcxzj442VF3s6xgqPjz5VD3FHWJYK/GMsb8+bwirh+xaYgp1BU
 LfbJi3Sdb8sGDG7jPO75LcrG46u8bZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716904304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nrj52OarBBqq6zH+2XLLQOEHMXAWNUVKr5N+9skRiU=;
 b=ppgfmvNmjWPxcsVc7zKgjZzwpn79rVVjcibI4AYjfhaEg2CdBdMKKKYr0q2Z+IcMls3nsH
 gO3Q/hZ8bpq8wZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BBAD13A8A;
 Tue, 28 May 2024 13:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AguONG/hVWa4EQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 May 2024 13:51:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migrate-test: Use regular file file for
 shared-memory tests
In-Reply-To: <20240528042758.621589-1-npiggin@gmail.com>
References: <20240528042758.621589-1-npiggin@gmail.com>
Date: Tue, 28 May 2024 10:51:41 -0300
Message-ID: <87r0dmf3iq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,nongnu.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 987FA201D1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nicholas Piggin <npiggin@gmail.com> writes:

> There is no need to use /dev/shm for file-backed memory devices, and
> it is too small to be usable in gitlab CI. Switch to using a regular
> file in /tmp/ which will usually have more space available.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Am I missing something? AFAIKS there is not even any point using
> /dev/shm aka tmpfs anyway, there is not much special about it as a
> filesystem. This applies on top of the series just sent, and passes
> gitlab CI qtests including aarch64.

/dev/shm however will be mounted on tmpfs while /tmp may not. I don't
know if this has any implication to this test. Probably not.

>
> Thanks,
> Nick
>
>  tests/qtest/migration-test.c | 41 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 28 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 45830eb213..86eace354e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -552,7 +552,7 @@ typedef struct {
>       * unconditionally, because it means the user would like to be verbose.
>       */
>      bool hide_stderr;
> -    bool use_shmem;
> +    bool use_memfile;
>      /* only launch the target process */
>      bool only_target;
>      /* Use dirty ring if true; dirty logging otherwise */
> @@ -672,29 +672,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      g_autofree gchar *cmd_source = NULL;
>      g_autofree gchar *cmd_target = NULL;
>      const gchar *ignore_stderr;
> -    g_autofree char *shmem_opts = NULL;
> -    g_autofree char *shmem_path = NULL;
> +    g_autofree char *memfile_opts = NULL;
> +    g_autofree char *memfile_path = NULL;
>      const char *kvm_opts = NULL;
>      const char *arch = qtest_get_arch();
>      const char *memory_size;
>      const char *machine_alias, *machine_opts = "";
>      g_autofree char *machine = NULL;
>  
> -    if (args->use_shmem) {
> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> -            g_test_skip("/dev/shm is not supported");
> -            return -1;
> -        }
> -        if (getenv("GITLAB_CI")) {
> -            /*
> -             * Gitlab runners are limited to 64MB shm size. See:
> -             * https://lore.kernel.org/all/87ttq5fvh7.fsf@suse.de/
> -             */
> -            g_test_skip("/dev/shm is not supported in Gitlab CI environment");
> -            return -1;
> -        }
> -    }
> -
>      dst_state = (QTestMigrationState) { };
>      src_state = (QTestMigrationState) { };
>      bootfile_create(tmpfs, args->suspend_me);
> @@ -754,12 +739,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          ignore_stderr = "";
>      }
>  
> -    if (args->use_shmem) {
> -        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> -        shmem_opts = g_strdup_printf(
> +    if (args->use_memfile) {
> +        memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());

The variable tmpfs already contains the leading slash. Strictly speaking
we don't need the pid because 'tmpfs' is unique for each migration-test
run. If you use a fixed string such as qemu-mem, you can then clean it
up at test_migrate_end() along with the others.

> +        memfile_opts = g_strdup_printf(
>              "-object memory-backend-file,id=mem0,size=%s"
>              ",mem-path=%s,share=on -numa node,memdev=mem0",
> -            memory_size, shmem_path);
> +            memory_size, memfile_path);
>      }
>  
>      if (args->use_dirty_ring) {
> @@ -788,7 +773,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   memory_size, tmpfs,
>                                   arch_opts ? arch_opts : "",
>                                   arch_source ? arch_source : "",
> -                                 shmem_opts ? shmem_opts : "",
> +                                 memfile_opts ? memfile_opts : "",
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr);
>      if (!args->only_target) {
> @@ -810,7 +795,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   memory_size, tmpfs, uri,
>                                   arch_opts ? arch_opts : "",
>                                   arch_target ? arch_target : "",
> -                                 shmem_opts ? shmem_opts : "",
> +                                 memfile_opts ? memfile_opts : "",
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
>      *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
> @@ -822,8 +807,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       * Remove shmem file immediately to avoid memory leak in test failed case.
>       * It's valid because QEMU has already opened this file
>       */

I'm not sure what memory leak this referred to. When a test fails
anywhere outside test_migrate_end(), the /tmp/migration-test-XXXX
directory will stay behind with all the files used during the test. We
probably don't need the special case for this one file.

$ ls /tmp/migration-test-*/
/tmp/migration-test-GFO6N2/:
tlscredsx5090

/tmp/migration-test-QH2MO2/:
bootsect  dest_serial  src_serial

> -    if (args->use_shmem) {
> -        unlink(shmem_path);
> +    if (args->use_memfile) {
> +        unlink(memfile_path);
>      }
>  
>      return 0;
> @@ -1875,7 +1860,7 @@ static void test_ignore_shared(void)
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
>      MigrateStart args = {
> -        .use_shmem = true,
> +        .use_memfile = true,
>      };
>  
>      if (test_migrate_start(&from, &to, uri, &args)) {
> @@ -2033,7 +2018,7 @@ static void test_mode_reboot(void)
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
>      MigrateCommon args = {
> -        .start.use_shmem = true,
> +        .start.use_memfile = true,
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .start_hook = test_mode_reboot_start

