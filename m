Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE78E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 17:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKhT8-0002jH-Ah; Mon, 09 Dec 2024 12:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKhT6-0002j2-8Z
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:22:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKhT4-0005di-Km
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:22:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 508AC211A0;
 Mon,  9 Dec 2024 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733764963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPITwujyVk4+IIRvperNFhhrpWCt+sL9ERzfip1y/Nk=;
 b=QYViXUehagB9D9J34rkYuwJ6smenwtQINyLlxyZ6cPMzNJKhA6v6HY9lTaO+rgzIJnIZOq
 mp1T+NvlvszHeZjs3R7sP18wT5/VASvchcXnd4LLmob+RVOUvgIXAwuC8wAywdpzBQstlM
 ugn3GtMblcXOjWKvWdrM1zQbp8kXs0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733764963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPITwujyVk4+IIRvperNFhhrpWCt+sL9ERzfip1y/Nk=;
 b=ZR09Po819KAsegr65Irb2BfUfIzk8zgvhP972FPg3Zebcmcqo+feyh1knkY+SKO4hZk9TB
 mxGFNKwfeIYPbdCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733764963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPITwujyVk4+IIRvperNFhhrpWCt+sL9ERzfip1y/Nk=;
 b=QYViXUehagB9D9J34rkYuwJ6smenwtQINyLlxyZ6cPMzNJKhA6v6HY9lTaO+rgzIJnIZOq
 mp1T+NvlvszHeZjs3R7sP18wT5/VASvchcXnd4LLmob+RVOUvgIXAwuC8wAywdpzBQstlM
 ugn3GtMblcXOjWKvWdrM1zQbp8kXs0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733764963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPITwujyVk4+IIRvperNFhhrpWCt+sL9ERzfip1y/Nk=;
 b=ZR09Po819KAsegr65Irb2BfUfIzk8zgvhP972FPg3Zebcmcqo+feyh1knkY+SKO4hZk9TB
 mxGFNKwfeIYPbdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3A21138A5;
 Mon,  9 Dec 2024 17:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dTpsIGInV2dLOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Dec 2024 17:22:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, "Dr
 . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 3/4] tests/qtest/migration-test: Fix and enable
 test_ignore_shared
In-Reply-To: <20240530095408.31608-4-npiggin@gmail.com>
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-4-npiggin@gmail.com>
Date: Mon, 09 Dec 2024 14:22:39 -0300
Message-ID: <875xnsbwkg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,yandex-team.ru,treblig.org];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Nicholas Piggin <npiggin@gmail.com> writes:

> This test is already starting to bitrot, so first remove it from ifdef
> and fix compile issues. ppc64 transfers about 2MB, so bump the size
> threshold too.
>
> It was said to be broken on aarch64 but it may have been due to the
> limited shm size under Gitlab CI. Now that it uses /tmp, enable it.
>
> Cc: Yury Kotov <yury-kotov@yandex-team.ru>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  tests/qtest/migration-test.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index de380757be..86eace354e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1855,8 +1855,6 @@ static void test_precopy_unix_tls_x509_override_host(void)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -#if 0
> -/* Currently upset on aarch64 TCG */
>  static void test_ignore_shared(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -1865,7 +1863,7 @@ static void test_ignore_shared(void)
>          .use_memfile = true,
>      };
>  
> -    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
> +    if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
>      }
>  
> @@ -1890,11 +1888,11 @@ static void test_ignore_shared(void)
>      wait_for_migration_complete(from);
>  
>      /* Check whether shared RAM has been really skipped */
> -    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
> +    g_assert_cmpint(read_ram_property_int(from, "transferred"), <,
> +                                                   4 * 1024 * 1024);
>  
>      test_migrate_end(from, to, true);
>  }
> -#endif
>  
>  static void *
>  test_migrate_xbzrle_start(QTestState *from,
> @@ -3535,7 +3533,8 @@ int main(int argc, char **argv)
>  #endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>  
> -    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
> +    migration_test_add("/migration/ignore_shared", test_ignore_shared);
> +
>  #ifndef _WIN32
>      migration_test_add("/migration/precopy/fd/tcp",
>                         test_migrate_precopy_fd_socket);

I'm queuing this patch to qtest-next, but moving it under
QEMU_TEST_FLAKY_TESTS. Otherwise the move of this function to another
file (from the refactoring series) breaks checkpatch due to the #if 0.

