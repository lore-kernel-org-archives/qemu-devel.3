Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C1DE8FDB0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 17:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZBbB-0003zA-S0; Fri, 26 Dec 2025 12:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZBb9-0003xy-CR
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 12:27:31 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZBb6-0007AN-FA
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 12:27:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A734233688;
 Fri, 26 Dec 2025 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766770044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKaGBR9TuzvYoykp+wKgXYGZDmMXzYDNXwVXlI7Y0yg=;
 b=CSOpSnm4Scf4LjE+btzi2sBL+G/wLNahm30LH9I7LGAT79DDhrL21luhcqHehFInZo5kiV
 kjRWpdhbBHXqKjIbuxDm6jyf47CrZvP+ZUe4RbMlhU7ve5fow7nCuKtw2zOOS0RIZqHFh/
 MU3MaqP44u0Hk2n6910EHEpHaYYx2o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766770044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKaGBR9TuzvYoykp+wKgXYGZDmMXzYDNXwVXlI7Y0yg=;
 b=YraF//6+M8vLQbVdBL/YepZcqWhMdhhhJ+hKTQdA5VYHet/4wakgdDtHEBKxmZJ7vKqj9X
 Y8/ZOUYhJpj5vOAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="bJCuok/W";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lBk+v48e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766770043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKaGBR9TuzvYoykp+wKgXYGZDmMXzYDNXwVXlI7Y0yg=;
 b=bJCuok/WD5K6Pm3zS0yokecT0tpoRxtl77JiVjT88OqMiLUkR2mI+/WrgPf7849V/8oQE3
 dvuged+kuiwEFdlxD6hVLn9u6p7CsVT1X+J8KhmyBHPVA46QKkmRHrD6NWfueHcNQBZ0kI
 ZlUQ4GiZHzh1pmQPHT4LlQkl1qIR3xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766770043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKaGBR9TuzvYoykp+wKgXYGZDmMXzYDNXwVXlI7Y0yg=;
 b=lBk+v48eAKxIIT5czd8Q7zGwDyc/HN5DBAdP+YnqqwMY9MDL47wc+/PWYfR+B7T3mStY9u
 FcTorhRrXtgr6aDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FFDD3EA65;
 Fri, 26 Dec 2025 17:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLFXBHrFTmmTAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 17:27:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 1/1] tests/qtest: Do not use versioned pc-q35-5.0 machine
 anymore
Date: Fri, 26 Dec 2025 14:27:18 -0300
Message-ID: <20251226172718.12071-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226172718.12071-1-farosas@suse.de>
References: <20251226172718.12071-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A734233688
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

As of QEMU v10.2.0, the v5.0.0 machines are not usable anymore.

Use the latest x86 q35 machine instead, otherwise we get:

  $ qemu-system-x86_64 -M pc-q35-5.0
  qemu-system-x86_64: unsupported machine type: "pc-q35-5.0"
  Use -machine help to list supported machines

See commit a35f8577a07 ("include/hw: add macros for deprecation
& removal of versioned machines") and f59ee044067 ("include/hw/boards:
cope with dev/rc versions in deprecation checks") for explanation
on automatically removed versioned machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/qemu-devel/20251224085714.83169-1-philmd@linaro.org
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/fuzz-e1000e-test.c | 2 +-
 tests/qtest/lpc-ich9-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz-e1000e-test.c b/tests/qtest/fuzz-e1000e-test.c
index 5052883fb6..b66a2e2313 100644
--- a/tests/qtest/fuzz-e1000e-test.c
+++ b/tests/qtest/fuzz-e1000e-test.c
@@ -17,7 +17,7 @@ static void test_lp1879531_eth_get_rss_ex_dst_addr(void)
 {
     QTestState *s;
 
-    s = qtest_init("-nographic -monitor none -serial none -M pc-q35-5.0");
+    s = qtest_init("-nographic -monitor none -serial none -M q35");
 
     qtest_outl(s, 0xcf8, 0x80001010);
     qtest_outl(s, 0xcfc, 0xe1020000);
diff --git a/tests/qtest/lpc-ich9-test.c b/tests/qtest/lpc-ich9-test.c
index 8ac95b89f7..460d459c70 100644
--- a/tests/qtest/lpc-ich9-test.c
+++ b/tests/qtest/lpc-ich9-test.c
@@ -15,7 +15,7 @@ static void test_lp1878642_pci_bus_get_irq_level_assert(void)
 {
     QTestState *s;
 
-    s = qtest_init("-M pc-q35-5.0 "
+    s = qtest_init("-M q35 "
                    "-nographic -monitor none -serial none");
 
     qtest_outl(s, 0xcf8, 0x8000f840); /* PMBASE */
-- 
2.51.0


