Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D2DC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nWG-0002Qv-8A; Thu, 10 Sep 2026 18:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lNI-0003Pc-35
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:11 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lN3-00018h-Gt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:27:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA8CD1FEEC;
 Thu, 10 Sep 2026 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxJGuhRlX9wkUvThjA2Y5nMv5TNuGWBfekFjx71R4pw=;
 b=bcsh7DFoEtU9tihmgvI6tMuk+NYajLrM6JjRRMV4wOrhywbhqkxDBBtpZgJLS1NLZgeXxj
 IPo/7u7XPi304cT/ob/3dG2LfSHLhjcf4iX5bXjLvf5zznLCBAUmTxdRqwJthh6SE8FSGZ
 n/kp1y7/W0AoQ3dA71HHpUO8ak3AbMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxJGuhRlX9wkUvThjA2Y5nMv5TNuGWBfekFjx71R4pw=;
 b=egX6q7bFpAme3R26Weu/1iiXgyvNeeXbjsBA6mSE68hzeM0Bn+qbzE5sueryQCTeM/o4Cc
 QZnU/v2mYm8YMcCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxJGuhRlX9wkUvThjA2Y5nMv5TNuGWBfekFjx71R4pw=;
 b=gHeZ/yVj7skqIm0PAbP+i7Hqsx+ROofC8wvxmDXPoOqPoDEUQYISS+ehFlfEq38xt0nC/f
 aYw7l+0DU7c+gdRIkHnPOZweYnzpdw3czCpJU91wPhmcNdXqXZ2+QNtT61zGIIEpGeClGq
 U9FZVLv0FrHdLmKndwPiQNFwGKTvtaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxJGuhRlX9wkUvThjA2Y5nMv5TNuGWBfekFjx71R4pw=;
 b=mMxjO4pCdZc8AyT/MH3pNwol1SLToTFMhbvcNhnQdTTur/Zm2FR/HF0VMv5Lc+vxbgQMuB
 tFmhHONgQl/c2TCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4162B13A5F;
 Thu, 10 Sep 2026 20:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OGUcBWYSo2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 20:26:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>
Subject: [PULL 7/7] tests/qtest/ahci: fix a racy deadlock in the engine stop
 test
Date: Thu, 10 Sep 2026 17:25:59 -0300
Message-ID: <20260910202559.916866-8-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
References: <20260910202559.916866-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,openvz.org:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: "Denis V. Lunev" <den@openvz.org>

test_write_engine_stop_in_flight() resumes the suspended backend write
and goes straight on to restart the command engine and read the second
sector back. Whether the write has retired by then is a race. While it
is still outstanding the drive is busy, and handle_cmd() drops a
command that arrives in that state instead of queueing it. Nothing
retries the drop, so the PxCI slot stays set and no D2H FIS is posted.
ahci_command_wait() polls both with no timeout, so the test deadlocks
until the harness kills it.

Drain the port before issuing the read, so the abandoned write has
retired and the engine is idle. Host load stretches the gap between the
resume and the write completing, which is why the deadlock only shows
up on a loaded machine.

Fixes: d05ae87e7a6a ("tests/qtest/ahci: regression test for a PIO write vs. engine stop")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/ahci-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index eb8d239997..c49aa61862 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1912,6 +1912,12 @@ static void test_write_engine_stop_in_flight(void)
 
     qtest_qemu_io(ahci->parent->qts, "drive0", "resume wr");
 
+    /*
+     * Retire the abandoned write. handle_cmd() drops a command that arrives
+     * while the drive is still busy and nothing retries it.
+     */
+    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"aio_flush\""));
+
     /* Round-trip through the device to confirm qemu is still alive. */
     ahci_px_rreg(ahci, port, AHCI_PX_TFD);
 
-- 
2.53.0


