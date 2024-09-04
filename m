Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406F7CD4849
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNV-0004fX-0n; Wed, 04 Sep 2024 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNM-00049J-6a
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNK-0005Vz-DX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AA591F38E;
 Wed,  4 Sep 2024 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmzN9h1hq3ADXXvfx51VoENPQLC4RFTA8VHLqVTGY5U=;
 b=bLxxq6yWHSidfzuPEfV1p1c++wQyrMH06znY4GPcDcLESsGQHU1onYHYJSCmTrAVX/6aMm
 xJKCO71dr2d9p5PWqvxM1jebISzL36VI1z9DfWjW7SIesVNE9xZ1AmjvCbPNrexrUXAxdu
 sXrJFVpUpvhFLnFFT/4TjcJmwuWiTHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmzN9h1hq3ADXXvfx51VoENPQLC4RFTA8VHLqVTGY5U=;
 b=NAjyow80rZ7LgpBibPxpOCs62lq1Yf4gQPIfBNXtQS96IFG39CzQIzswSxED1JXCEvw8hB
 DoNUNo3EXzFxrqBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bLxxq6yW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NAjyow80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmzN9h1hq3ADXXvfx51VoENPQLC4RFTA8VHLqVTGY5U=;
 b=bLxxq6yWHSidfzuPEfV1p1c++wQyrMH06znY4GPcDcLESsGQHU1onYHYJSCmTrAVX/6aMm
 xJKCO71dr2d9p5PWqvxM1jebISzL36VI1z9DfWjW7SIesVNE9xZ1AmjvCbPNrexrUXAxdu
 sXrJFVpUpvhFLnFFT/4TjcJmwuWiTHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmzN9h1hq3ADXXvfx51VoENPQLC4RFTA8VHLqVTGY5U=;
 b=NAjyow80rZ7LgpBibPxpOCs62lq1Yf4gQPIfBNXtQS96IFG39CzQIzswSxED1JXCEvw8hB
 DoNUNo3EXzFxrqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF0E6139D2;
 Wed,  4 Sep 2024 12:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDE6HTdW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/34] tests/qtest/migration-test: Don't leak QTestState in
 test_multifd_tcp_cancel()
Date: Wed,  4 Sep 2024 09:43:54 -0300
Message-Id: <20240904124417.14565-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AA591F38E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Peter Maydell <peter.maydell@linaro.org>

In test_multifd_tcp_cancel() we create three QEMU processes: 'from',
'to' and 'to2'.  We clean up (via qtest_quit()) 'from' and 'to2' when
we call test_migrate_end(), but never clean up 'to', which results in
this leak:

Direct leak of 336 byte(s) in 1 object(s) allocated from:
    #0 0x55e984fcd328 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f328) (BuildId: 710d409b68bb04427009e9ca6e1b63ff8af785d3)
    #1 0x7f0878b39c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55e98503a172 in qtest_spawn_qemu tests/qtest/libqtest.c:397:21
    #3 0x55e98502bc4a in qtest_init_internal tests/qtest/libqtest.c:471:9
    #4 0x55e98502c5b7 in qtest_init_with_env tests/qtest/libqtest.c:533:21
    #5 0x55e9850eef0f in test_migrate_start tests/qtest/migration-test.c:857:11
    #6 0x55e9850eb01d in test_multifd_tcp_cancel tests/qtest/migration-test.c:3297:9
    #7 0x55e985103407 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

Call qtest_quit() on 'to' to clean it up once it has exited.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3818595040..6aca6760ef 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3242,6 +3242,7 @@ static void test_multifd_tcp_cancel(void)
     /* Make sure QEMU process "to" exited */
     qtest_set_expected_status(to, EXIT_FAILURE);
     qtest_wait_qemu(to);
+    qtest_quit(to);
 
     args = (MigrateStart){
         .only_target = true,
-- 
2.35.3


