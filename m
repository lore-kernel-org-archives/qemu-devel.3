Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EDACCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAF0-00024j-FA; Wed, 29 Apr 2026 15:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEk-000235-Us
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:18 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wIAEi-0000V7-UP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A01896A820;
 Wed, 29 Apr 2026 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuIC/5ApKnZIeBsrthfG2kENi8s5IqdSqJq9eBy6xCM=;
 b=QvNqfviQ46jREZ/i5WFNKBEg35w5OTN5KdX1WZ1RdVPRkYLNxOpWUPulzP7pxHZs+QO7aO
 fiD8WBMmTDawcUOWBqulvo+2TNpfKGnC/SbNm8VPKOYRLT9yhxIuy/1eqMntskLVXAD6+Q
 pSbo1y3xrjrXOZt5KaS9JQOSogbTPiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuIC/5ApKnZIeBsrthfG2kENi8s5IqdSqJq9eBy6xCM=;
 b=Cg5YxdUH9yV3tBfeumcCIs4X1DSXFpwTIOTsH2jJW5kT20hdJnZosss0PmlsBVb/+AFNoz
 1LhUbshL8DK7NhAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SyqCtA9l;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="yXNb0n/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777489560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuIC/5ApKnZIeBsrthfG2kENi8s5IqdSqJq9eBy6xCM=;
 b=SyqCtA9lV3j6YpTOyCJhHmubdbg4KVAQQGnrbS8lYF/fr/puHQ1NyfU3UosFQ/KUu9GLlR
 ylz/Cy9HNZurogUtzTbdIcYKbaUd64urXM9UyK2Ut611grSLZ2iKVhx3zNIejrTBRlvBtm
 jNgOl9igduX3iC2J1q84LO0jzoXZYyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777489560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuIC/5ApKnZIeBsrthfG2kENi8s5IqdSqJq9eBy6xCM=;
 b=yXNb0n/1ofw2PcJXkOmxcnfgCdvDQwgOja0WXX6QqZm6gXtKwVeoYZgo1aupLmXRGdHn3I
 7UHYI8GVvkjgujCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44CE2593B0;
 Wed, 29 Apr 2026 19:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UHZXBZdW8mm/eQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 19:05:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, marcandre.lureau@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 4/5] tests/qtest/dbus-vmstate: Stop the daemons explicitly
Date: Wed, 29 Apr 2026 16:05:49 -0300
Message-ID: <20260429190550.20122-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429190550.20122-1-farosas@suse.de>
References: <20260429190550.20122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A01896A820
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The dbus-vmstate test is currently non-deterministically emitting a
"cleaning up pid" message, followed by the PID of one of the
dbus-daemon processes used during the test. This is due to a race
between the GTestDBus g_autoptr destructor and a child process that
does cleanup when the program ends.

Add calls to g_test_dbus_down() to make the issuance of the SIGTERM to
the dbus-daemon deterministic.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/dbus-vmstate-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 05e598a3e3..15c35e7c0f 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -260,11 +260,12 @@ test_dbus_vmstate(Test *test)
     qtest_quit(src_qemu);
     g_bus_unown_name(ownsrcA);
     g_bus_unown_name(ownsrcB);
+    g_test_dbus_down(srcbus);
     g_bus_unown_name(owndstA);
     if (!test->without_dst_b) {
         g_bus_unown_name(owndstB);
     }
-
+    g_test_dbus_down(dstbus);
     g_main_loop_quit(test->loop);
 }
 
-- 
2.51.0


