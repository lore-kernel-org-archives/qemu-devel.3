Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4878CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNL-00044b-MG; Wed, 04 Sep 2024 08:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNI-0003v2-FM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:40 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNG-0005Ut-Mr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CD212119F;
 Wed,  4 Sep 2024 12:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2Ri8HctTIXsXSaBfIqxljhxeFAgkjIWbGYXT0sfccc=;
 b=dfs6ckQVBxMw6kI4JyxWrA3OXTZTFWHeaMPPhzyp0hdc6jyFQHADox4cuwiErz9pLuU2M/
 irnbjy+MlsfB3ScQdQ9cK1Wn9jibDonERQZZHpIbAcX3XVPf4feaXYA0AtoXZ0Y8t9QEY/
 Hrlsl4w8tcsAQO6FnYF6weo/FdItPJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2Ri8HctTIXsXSaBfIqxljhxeFAgkjIWbGYXT0sfccc=;
 b=N9F48+vfk7EG5HpLcJxrHl7o1+/0mYmy/kv2EZrFdjZ+CtAiw6tv5RSLCGEdPrl0s9Tmy/
 +sOL0YgaUxIQz5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2Ri8HctTIXsXSaBfIqxljhxeFAgkjIWbGYXT0sfccc=;
 b=dfs6ckQVBxMw6kI4JyxWrA3OXTZTFWHeaMPPhzyp0hdc6jyFQHADox4cuwiErz9pLuU2M/
 irnbjy+MlsfB3ScQdQ9cK1Wn9jibDonERQZZHpIbAcX3XVPf4feaXYA0AtoXZ0Y8t9QEY/
 Hrlsl4w8tcsAQO6FnYF6weo/FdItPJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2Ri8HctTIXsXSaBfIqxljhxeFAgkjIWbGYXT0sfccc=;
 b=N9F48+vfk7EG5HpLcJxrHl7o1+/0mYmy/kv2EZrFdjZ+CtAiw6tv5RSLCGEdPrl0s9Tmy/
 +sOL0YgaUxIQz5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D43F139D2;
 Wed,  4 Sep 2024 12:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kEFXMTNW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/34] tests/qtest/migration-helpers: Don't dup argument to
 qdict_put_str()
Date: Wed,  4 Sep 2024 09:43:52 -0300
Message-Id: <20240904124417.14565-10-farosas@suse.de>
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

In migrate_set_ports() we call qdict_put_str() with a value string
which we g_strdup(). However qdict_put_str() takes a copy of the
value string, it doesn't take ownership of it, so the g_strdup()
only results in a leak:

Direct leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x56298023713e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: b2b9174a5a54707a7f76bca51cdc95d2aa08bac1)
    #1 0x7fba0ad39738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7fba0ad4e583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x56298036b16e in migrate_set_ports tests/qtest/migration-helpers.c:145:49
    #4 0x56298036ad1c in migrate_qmp tests/qtest/migration-helpers.c:228:9
    #5 0x56298035b3dd in test_precopy_common tests/qtest/migration-test.c:1820:5
    #6 0x5629803549dc in test_multifd_tcp_channels_none tests/qtest/migration-test.c:3077:5
    #7 0x56298036d427 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

Drop the unnecessary g_strdup() call.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 7cbb9831e7..a43d180c80 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -142,7 +142,7 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
             qdict_haskey(addr, "port") &&
             (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
                 addr_port = qdict_get_str(addr, "port");
-                qdict_put_str(addrdict, "port", g_strdup(addr_port));
+                qdict_put_str(addrdict, "port", addr_port);
         }
     }
 
-- 
2.35.3


