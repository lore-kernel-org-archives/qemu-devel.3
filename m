Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAD3CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNB-0003S7-86; Wed, 04 Sep 2024 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpN9-0003LM-Dk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpN7-0005Qs-Lj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48495219D2;
 Wed,  4 Sep 2024 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXVgqh4miadmpincum38z66yhal5qVKzuhQP668uObs=;
 b=Xx76rvF3WSt/BYG5eikgXrTUYHjmqAz4F5WeZW96Ty07F/GmnCjR53fKmsGcujqRJe8Xfq
 wiqZOGvlA5e8evz80hrEBOBKy4XWiAdos3fZlfTv5ttaFXqAyXlNmwU3/cTaSArjzy6SLu
 RUD2XUg0oNkkHSYrUA0UHt/cmZ0ZeOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXVgqh4miadmpincum38z66yhal5qVKzuhQP668uObs=;
 b=f8Mu4F4AhYTQOncVOYZzyz6OapkzgsXs4b3ZK11rnKAVKHdZlWzkQQ8FakSgIi+zZvE216
 91c/D1P+WnNA7+Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXVgqh4miadmpincum38z66yhal5qVKzuhQP668uObs=;
 b=Xx76rvF3WSt/BYG5eikgXrTUYHjmqAz4F5WeZW96Ty07F/GmnCjR53fKmsGcujqRJe8Xfq
 wiqZOGvlA5e8evz80hrEBOBKy4XWiAdos3fZlfTv5ttaFXqAyXlNmwU3/cTaSArjzy6SLu
 RUD2XUg0oNkkHSYrUA0UHt/cmZ0ZeOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXVgqh4miadmpincum38z66yhal5qVKzuhQP668uObs=;
 b=f8Mu4F4AhYTQOncVOYZzyz6OapkzgsXs4b3ZK11rnKAVKHdZlWzkQQ8FakSgIi+zZvE216
 91c/D1P+WnNA7+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA47213A5F;
 Wed,  4 Sep 2024 12:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJzBJypW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/34] tests/qtest/migration-test: Don't leak resp in
 multifd_mapped_ram_fdset_end()
Date: Wed,  4 Sep 2024 09:43:47 -0300
Message-Id: <20240904124417.14565-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.927];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

In multifd_mapped_ram_fdset_end() we call qtest_qmp() but forgot
to unref the response QDict we get back, which means it is leaked:

Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x55c0c095d318 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f318) (BuildI
d: 07f667506452d6c467dbc06fd95191966d3e91b4)
    #1 0x7f186f939c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55c0c0ae9b01 in qdict_new qobject/qdict.c:30:13
    #3 0x55c0c0afc16c in parse_object qobject/json-parser.c:317:12
    #4 0x55c0c0afb90f in parse_value qobject/json-parser.c:545:16
    #5 0x55c0c0afb579 in json_parser_parse qobject/json-parser.c:579:14
    #6 0x55c0c0afa21d in json_message_process_token qobject/json-streamer.c:92:12
    #7 0x55c0c0bca2e5 in json_lexer_feed_char qobject/json-lexer.c:313:13
    #8 0x55c0c0bc97ce in json_lexer_feed qobject/json-lexer.c:350:9
    #9 0x55c0c0afabbc in json_message_parser_feed qobject/json-streamer.c:121:5
    #10 0x55c0c09cbd52 in qmp_fd_receive tests/qtest/libqmp.c:86:9
    #11 0x55c0c09be69b in qtest_qmp_receive_dict tests/qtest/libqtest.c:760:12
    #12 0x55c0c09bca77 in qtest_qmp_receive tests/qtest/libqtest.c:741:27
    #13 0x55c0c09bee9d in qtest_vqmp tests/qtest/libqtest.c:812:12
    #14 0x55c0c09bd257 in qtest_qmp tests/qtest/libqtest.c:835:16
    #15 0x55c0c0a87747 in multifd_mapped_ram_fdset_end tests/qtest/migration-test.c:2393:12
    #16 0x55c0c0a85eb3 in test_file_common tests/qtest/migration-test.c:1978:9
    #17 0x55c0c0a746a3 in test_multifd_file_mapped_ram_fdset tests/qtest/migration-test.c:2437:5
    #18 0x55c0c0a93237 in migration_test_wrapper tests/qtest/migration-helpers.c:458:5
    #19 0x7f186f958aed in test_case_run debian/build/deb/../../../glib/gtestutils.c:2930:15
    #20 0x7f186f958aed in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3018:16
    #21 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #22 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #23 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #24 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #25 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #26 0x7f186f958faa in g_test_run_suite debian/build/deb/../../../glib/gtestutils.c:3109:18
    #27 0x7f186f959055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2231:7
    #28 0x7f186f959055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2218:1
    #29 0x55c0c0a6e427 in main tests/qtest/migration-test.c:4033:11

Unref the object after we've confirmed that it is what we expect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 37ef99c980..b775ffed81 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2315,6 +2315,7 @@ static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
     g_assert(qdict_haskey(resp, "return"));
     fdsets = qdict_get_qlist(resp, "return");
     g_assert(fdsets && qlist_empty(fdsets));
+    qobject_unref(resp);
 }
 
 static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)
-- 
2.35.3


