Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A15C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTt-0003hL-LJ; Fri, 21 Jun 2024 13:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTr-0003Yv-Ky
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:23 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTp-0003bi-Jh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:23 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05D0321B40;
 Fri, 21 Jun 2024 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Aaj/WoDV5uAm41cMA1Jz8VwWrLFuTsQAw9Ij2plECo=;
 b=UqeZyirSgl4zrPxBJ4R4HhItS1QsGvxT8utKE/w4CoQ4/qhGRJZl5GLIqMsCJA2GUJElXw
 NVZ6rBAwAHYVfIjfkzlDTkbjqPY/R2jxi+Tkuf1Q24Dew/GCYJpQEFDj1xP6kVFzNQqEES
 zr+qIE/iEhUJXsjqKWmqvGpzn/z13ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Aaj/WoDV5uAm41cMA1Jz8VwWrLFuTsQAw9Ij2plECo=;
 b=WwEYt153PR7cBHHj5r8DV+EpqHeQweOsMBmqjPGGPxa7TYYZE0R3fyIMZZxp7dkJt7NVWy
 lZeL3WYaqcBTVHAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Aaj/WoDV5uAm41cMA1Jz8VwWrLFuTsQAw9Ij2plECo=;
 b=UqeZyirSgl4zrPxBJ4R4HhItS1QsGvxT8utKE/w4CoQ4/qhGRJZl5GLIqMsCJA2GUJElXw
 NVZ6rBAwAHYVfIjfkzlDTkbjqPY/R2jxi+Tkuf1Q24Dew/GCYJpQEFDj1xP6kVFzNQqEES
 zr+qIE/iEhUJXsjqKWmqvGpzn/z13ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Aaj/WoDV5uAm41cMA1Jz8VwWrLFuTsQAw9Ij2plECo=;
 b=WwEYt153PR7cBHHj5r8DV+EpqHeQweOsMBmqjPGGPxa7TYYZE0R3fyIMZZxp7dkJt7NVWy
 lZeL3WYaqcBTVHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDFF313AAA;
 Fri, 21 Jun 2024 17:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJ98JIa+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/28] tests/migration-tests: Always enable migration events
Date: Fri, 21 Jun 2024 14:54:30 -0300
Message-Id: <20240621175434.31180-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Libvirt should always enable it, so it'll be nice qtest also cover that for
all tests on both sides.  migrate_incoming_qmp() used to enable it only on
dst, now we enable them on both, as we'll start to sanity check events even
on the src QEMU.

We'll need to leave the one in migrate_incoming_qmp(), because
virtio-net-failover test uses that one only, and it relies on the events to
work.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 1 +
 tests/qtest/migration-test.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0ac49ceb54..2ca4425d71 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -258,6 +258,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     g_assert(!qdict_haskey(args, "uri"));
     qdict_put_str(args, "uri", uri);
 
+    /* This function relies on the event to work, make sure it's enabled */
     migrate_set_capability(to, "events", true);
 
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7dea1aabb..32e31fff86 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -852,6 +852,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         unlink(shmem_path);
     }
 
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(*from, "events", true);
+    migrate_set_capability(*to, "events", true);
+
     return 0;
 }
 
-- 
2.35.3


