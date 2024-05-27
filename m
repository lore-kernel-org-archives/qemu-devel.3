Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EFBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZgX-0000bC-Bg; Mon, 27 May 2024 08:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sBZgU-0000Zw-KD; Mon, 27 May 2024 08:42:38 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sBZgS-0006Qu-Mt; Mon, 27 May 2024 08:42:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB2621EB1;
 Mon, 27 May 2024 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716813751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxEIhdGuuslwn53WyiE5o3NvD6giWgIAan6Fo0EeV14=;
 b=eAczgyplJ+7UFc1mmE+QYR/acR9joauqPmrjrydITiGmehMDxqpLSd5r+DDp1qc7zt6osO
 0i65UKeG3sVTJigMZepCKmg6+F1/ngYdFw+oJHua8c/V7i2TxhOsQJuEt7tBdwWDk3VQQ2
 BrcZHeSEKcRLy/KI9uVnJf+E9T7/C7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716813751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxEIhdGuuslwn53WyiE5o3NvD6giWgIAan6Fo0EeV14=;
 b=eitGx7QNM8qkyaxlNf8YWBeAQ+HJhpu9xsVwjIch1yI8VhDA/NiIEAMuMrHB9UbNPTI9z1
 NzRMv0iG66qrKxCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eAczgypl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eitGx7QN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716813751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxEIhdGuuslwn53WyiE5o3NvD6giWgIAan6Fo0EeV14=;
 b=eAczgyplJ+7UFc1mmE+QYR/acR9joauqPmrjrydITiGmehMDxqpLSd5r+DDp1qc7zt6osO
 0i65UKeG3sVTJigMZepCKmg6+F1/ngYdFw+oJHua8c/V7i2TxhOsQJuEt7tBdwWDk3VQQ2
 BrcZHeSEKcRLy/KI9uVnJf+E9T7/C7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716813751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HxEIhdGuuslwn53WyiE5o3NvD6giWgIAan6Fo0EeV14=;
 b=eitGx7QNM8qkyaxlNf8YWBeAQ+HJhpu9xsVwjIch1yI8VhDA/NiIEAMuMrHB9UbNPTI9z1
 NzRMv0iG66qrKxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22B0713A56;
 Mon, 27 May 2024 12:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8ZaXNrZ/VGY3OQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 May 2024 12:42:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu
 <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, Yury Kotov
 <yury-kotov@yandex-team.ru>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>
Subject: Re: [RFC PATCH 3/3] tests/qtest/migration-test: Enable
 test_ignore_shared
In-Reply-To: <20240525131241.378473-4-npiggin@gmail.com>
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-4-npiggin@gmail.com>
Date: Mon, 27 May 2024 09:42:28 -0300
Message-ID: <87a5kbh1e3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,redhat.com,nongnu.org,yandex-team.ru];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9EB2621EB1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> This was said to be broken on aarch64, but if it works on others,
> let's try enable it. It's already starting to bitrot...

Yeah, look at the state of this...

I don't know what the issue was on aarch64, but I'm all for enabling
this test globally and then we deal with the breakage if it ever
comes. I don't think it will.

However, there is an issue here still on all archs - which might very
well have been the original issue - which is the fact that the
containers on the Gitlab CI have limits on shared memory usage.
Unfortunately we cannot enable this test for the CI, so it needs a check
on the GITLAB_CI environment variable.

There's also the cpr-reboot test which got put under "flaky", that has
the same issue. That one should also have been under GITLAB_CI. From
that discussion:

  "We have an issue with this test on CI:
  
  $ df -h /dev/shm
  Filesystem      Size  Used Avail Use% Mounted on
  shm              64M     0   64M   0% /dev/shm
  
  These are shared CI runners, so AFAICT there's no way to increase the
  shared memory size.
  
  Reducing the memory for this single test also wouldn't work because we
  can run migration-test for different archs in parallel + there's the
  ivshmem_test which uses 4M.
  
  Maybe just leave it out of CI? Laptops will probably have enough shared
  memory to not hit this. If we add a warning comment to the test, might
  be enough." -- https://lore.kernel.org/all/87ttq5fvh7.fsf@suse.de

>
> Cc: Yury Kotov <yury-kotov@yandex-team.ru>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/migration-test.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 7987faaded..2bcdc33b7c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1862,14 +1862,15 @@ static void test_precopy_unix_tls_x509_override_host(void)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -#if 0
> -/* Currently upset on aarch64 TCG */
>  static void test_ignore_shared(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>      QTestState *from, *to;
> +    MigrateStart args = {
> +        .use_shmem = true,
> +    };
>  
> -    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
> +    if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
>      }
>  
> @@ -1898,7 +1899,6 @@ static void test_ignore_shared(void)
>  
>      test_migrate_end(from, to, true);
>  }
> -#endif
>  
>  static void *
>  test_migrate_xbzrle_start(QTestState *from,
> @@ -3537,7 +3537,10 @@ int main(int argc, char **argv)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
> +    if (strcmp(arch, "aarch64") == 0) { /* Currently upset on aarch64 TCG */
> +        migration_test_add("/migration/ignore_shared", test_ignore_shared);
> +    }
> +
>  #ifndef _WIN32
>      migration_test_add("/migration/precopy/fd/tcp",
>                         test_migrate_precopy_fd_socket);

