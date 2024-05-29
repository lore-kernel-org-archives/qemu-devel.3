Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 12:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCIpJ-0007Mu-LT; Wed, 29 May 2024 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sCIpE-0007JU-Mq
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:41 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sCIpA-0008PU-SE
 for qemu-devel@nongnu.org; Wed, 29 May 2024 08:54:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E53420549;
 Wed, 29 May 2024 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716987273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxnW1kTIL/kESlJLXbxMFxOOdBCLGBggie/ToXHz7gE=;
 b=JzXIjjpyuuvYQJDJvXTp48/C5FT6COqUvujtxc81NkS5WC7sNKtvVTrB02NgwPPGQJhuis
 czYNsZH9k5GuNDbOOa5wSTn4Rx+8e5noJZsXWsDJYWP904u0DqtI0fcn7vsysiU3DscIU9
 fK1FYi4rSviGKdau8X9SMK78idJCSPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716987273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxnW1kTIL/kESlJLXbxMFxOOdBCLGBggie/ToXHz7gE=;
 b=NiTx1XVD+38sGiSeLpUp68V1wrg35CDj9TNvZpHskWntVlSG5R8SDG6aDfYNrjLptrAw2x
 mZyoBcTdk9PMVCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716987273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxnW1kTIL/kESlJLXbxMFxOOdBCLGBggie/ToXHz7gE=;
 b=JzXIjjpyuuvYQJDJvXTp48/C5FT6COqUvujtxc81NkS5WC7sNKtvVTrB02NgwPPGQJhuis
 czYNsZH9k5GuNDbOOa5wSTn4Rx+8e5noJZsXWsDJYWP904u0DqtI0fcn7vsysiU3DscIU9
 fK1FYi4rSviGKdau8X9SMK78idJCSPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716987273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxnW1kTIL/kESlJLXbxMFxOOdBCLGBggie/ToXHz7gE=;
 b=NiTx1XVD+38sGiSeLpUp68V1wrg35CDj9TNvZpHskWntVlSG5R8SDG6aDfYNrjLptrAw2x
 mZyoBcTdk9PMVCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B85013A6B;
 Wed, 29 May 2024 12:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HHnqOIglV2YdPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 May 2024 12:54:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migrate-test: Add a postcopy memfile test
In-Reply-To: <20240529041322.701525-1-npiggin@gmail.com>
References: <20240529041322.701525-1-npiggin@gmail.com>
Date: Wed, 29 May 2024 09:54:30 -0300
Message-ID: <875xuwg4mx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

> Postcopy requires userfaultfd support, which requires tmpfs if a memory
> file is used.
>
> This adds back support for /dev/shm memory files, but adds preallocation
> to skip environments where that mount is limited in size.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> How about this? This goes on top of the reset of the patches
> (I'll re-send them all as a series if we can get to some agreement).
>
> This adds back the /dev/shm option with preallocation and adds a test
> case that requires tmpfs.

Peter has stronger opinions on this than I do. I'll leave it to him to
decide.

Just note that now we're making the CI less deterministic in relation to
the migration tests. When a test that uses shmem fails, we'll not be
able to consistently reproduce because the test might not even run
depending on what has consumed the shmem first.

Let's also take care that the other consumers of shmem (I think just
ivshmem-test) are able to cope with the migration-test taking all the
space, otherwise the CI will still break.

>
> Thanks,
> Nick
>
>  tests/qtest/migration-test.c | 63 +++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 86eace354e..7fd9bbdc18 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  
>  #include "libqtest.h"
>  #include "qapi/qmp/qdict.h"
> @@ -553,6 +554,7 @@ typedef struct {
>       */
>      bool hide_stderr;
>      bool use_memfile;
> +    bool use_uffd_memfile;
>      /* only launch the target process */
>      bool only_target;
>      /* Use dirty ring if true; dirty logging otherwise */
> @@ -739,7 +741,48 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          ignore_stderr = "";
>      }
>  
> -    if (args->use_memfile) {
> +    if (!qtest_has_machine(machine_alias)) {
> +        g_autofree char *msg = g_strdup_printf("machine %s not supported",
> +                                               machine_alias);
> +        g_test_skip(msg);
> +        return -1;
> +    }
> +
> +    if (args->use_uffd_memfile) {
> +#if defined(__NR_userfaultfd) && defined(__linux__)
> +        int fd;
> +        uint64_t size;
> +
> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> +            g_test_skip("/dev/shm does not exist or is not a directory");
> +            return -1;
> +        }
> +
> +        /*
> +         * Pre-create and allocate the file here, because /dev/shm/
> +         * is known to be limited in size in some places (e.g., Gitlab CI).
> +         */
> +        memfile_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
> +        fd = open(memfile_path, O_WRONLY | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR);
> +        if (fd == -1) {
> +            g_test_skip("/dev/shm file could not be created");
> +            return -1;
> +        }
> +
> +        g_assert(qemu_strtosz(memory_size, NULL, &size) == 0);
> +        size += 64*1024; /* QEMU may map a bit more memory for a guard page */
> +
> +        if (fallocate(fd, 0, 0, size) == -1) {
> +            unlink(memfile_path);
> +            perror("could not alloc"); exit(1);
> +            g_test_skip("Could not allocate machine memory in /dev/shm");
> +            return -1;
> +        }
> +        close(fd);
> +#else
> +        g_test_skip("userfaultfd is not supported");
> +#endif
> +    } else if (args->use_memfile) {
>          memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
>          memfile_opts = g_strdup_printf(
>              "-object memory-backend-file,id=mem0,size=%s"
> @@ -751,12 +794,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          kvm_opts = ",dirty-ring-size=4096";
>      }
>  
> -    if (!qtest_has_machine(machine_alias)) {
> -        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
> -        g_test_skip(msg);
> -        return -1;
> -    }
> -
>      machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>                                        QEMU_ENV_DST);
>  
> @@ -807,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       * Remove shmem file immediately to avoid memory leak in test failed case.
>       * It's valid because QEMU has already opened this file
>       */
> -    if (args->use_memfile) {
> +    if (args->use_memfile || args->use_uffd_memfile) {
>          unlink(memfile_path);
>      }
>  
> @@ -1275,6 +1312,15 @@ static void test_postcopy(void)
>      test_postcopy_common(&args);
>  }
>  
> +static void test_postcopy_memfile(void)
> +{
> +    MigrateCommon args = {
> +        .start.use_uffd_memfile = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  static void test_postcopy_suspend(void)
>  {
>      MigrateCommon args = {
> @@ -3441,6 +3487,7 @@ int main(int argc, char **argv)
>  
>      if (has_uffd) {
>          migration_test_add("/migration/postcopy/plain", test_postcopy);
> +        migration_test_add("/migration/postcopy/memfile", test_postcopy_memfile);
>          migration_test_add("/migration/postcopy/recovery/plain",
>                             test_postcopy_recovery);
>          migration_test_add("/migration/postcopy/preempt/plain",

