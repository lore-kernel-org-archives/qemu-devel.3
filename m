Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78FD637CE
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 22:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBLhz-0002k1-1y; Wed, 13 Nov 2024 17:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBLhw-0002jl-A2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:19:28 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBLhu-0003na-Is
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:19:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1D18211B2;
 Wed, 13 Nov 2024 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731536362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5Fl+OfhuhvR66RMK0J9j+qvcjCP6HzcTIv01gfanpQ=;
 b=l9lJXnv0A4vkRN5JadyrWDP8eJCGtkO5o/JR/uLzlI/Z0c7piS+RU/nRewdrXLvKKq2bJ5
 ci/GAWs/K5wIDSyDfgyAe+0miONM856f1wCMHNJ1JTdR5qk/dko+xGipNmT709sI0kkRry
 XbHcSjz/5MHSxPgYIfDa3tsSFLOWJ2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731536362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5Fl+OfhuhvR66RMK0J9j+qvcjCP6HzcTIv01gfanpQ=;
 b=ojfHwf/oSMr+mNG9BSxUhXsfUi6tPYFQ1g5DZIyqiADTSTK33eorGJ2sSEa5PpmX5XAjWQ
 +pwB1o+dJ+1WMtDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731536361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5Fl+OfhuhvR66RMK0J9j+qvcjCP6HzcTIv01gfanpQ=;
 b=eoiWGZM8SEmgRf3U8fmSjz+0GA9s5W6ZKSX6lhOzFzdhOd+UbueI4bPnLafwOKmQwU+SZU
 JmuVF+WM2vmsvbsds8dvWlItdgqwPMXZRXdjx3RCzxTYNDmNmoDHMImGeqjczql44XMaVa
 9+W9ZpL3SipM3eYcFfIMagH5BOpWwfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731536361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5Fl+OfhuhvR66RMK0J9j+qvcjCP6HzcTIv01gfanpQ=;
 b=23JwKf88UdcwcEzoKXZi6/PmN0+QVzfg5tQdXuycZIVsFF2dcE8NtUq4SSDkF08PVnJ7+9
 QvGKbeRIBGyAHqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F74C13A6E;
 Wed, 13 Nov 2024 22:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N8JtBeklNWcqHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 22:19:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V3 12/16] tests/migration-test: memory_backend
In-Reply-To: <1730468875-249970-13-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-13-git-send-email-steven.sistare@oracle.com>
Date: Wed, 13 Nov 2024 19:19:18 -0300
Message-ID: <87y11mhj4p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Allow each migration test to define its own memory backend, replacing
> the standard "-m <size>" specification.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  tests/qtest/migration-test.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 95e45b5..a008316 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -609,6 +609,11 @@ typedef struct {
>      const char *opts_target;
>      /* suspend the src before migrating to dest. */
>      bool suspend_me;
> +    /*
> +     * Format string for the main memory backend, containing one %s where the
> +     * size is plugged in.  If omitted, "-m %s" is used.
> +     */
> +    const char *memory_backend;
>  } MigrateStart;
>  
>  /*
> @@ -727,6 +732,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      const char *memory_size;
>      const char *machine_alias, *machine_opts = "";
>      g_autofree char *machine = NULL;
> +    g_autofree char *memory_backend = NULL;
>  
>      if (args->use_shmem) {
>          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> @@ -802,6 +808,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>              memory_size, shmem_path);
>      }
>  
> +    if (args->memory_backend) {
> +        memory_backend = g_strdup_printf(args->memory_backend, memory_size);
> +    } else {
> +        memory_backend = g_strdup_printf("-m %s ", memory_size);

Unnecessary space at the end of the string.

> +    }
> +
>      if (args->use_dirty_ring) {
>          kvm_opts = ",dirty-ring-size=4096";
>      }
> @@ -820,12 +832,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
>                                   "-machine %s,%s "
>                                   "-name source,debug-threads=on "
> -                                 "-m %s "
> +                                 "%s "
>                                   "-serial file:%s/src_serial "
>                                   "%s %s %s %s %s",
>                                   kvm_opts ? kvm_opts : "",
>                                   machine, machine_opts,
> -                                 memory_size, tmpfs,
> +                                 memory_backend, tmpfs,
>                                   arch_opts ? arch_opts : "",
>                                   arch_source ? arch_source : "",
>                                   shmem_opts ? shmem_opts : "",
> @@ -841,13 +853,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
>                                   "-machine %s,%s "
>                                   "-name target,debug-threads=on "
> -                                 "-m %s "
> +                                 "%s "
>                                   "-serial file:%s/dest_serial "
>                                   "-incoming %s "
>                                   "%s %s %s %s %s",
>                                   kvm_opts ? kvm_opts : "",
>                                   machine, machine_opts,
> -                                 memory_size, tmpfs, uri,
> +                                 memory_backend, tmpfs, uri,
>                                   arch_opts ? arch_opts : "",
>                                   arch_target ? arch_target : "",
>                                   shmem_opts ? shmem_opts : "",

