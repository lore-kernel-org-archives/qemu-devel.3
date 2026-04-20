Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58FAF5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEu4P-00026Z-Eq; Mon, 20 Apr 2026 15:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wEu4M-00026I-NR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:14:06 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wEu4L-0005sI-3G
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:14:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BD7F5BCD5;
 Mon, 20 Apr 2026 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776712441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2PDvKPJh+vw3yGeE4UxU8QHppQh3dAiLUVC5UZgsx68=;
 b=yBISvz2o/IFOuVhwx6Yqws+kgd7YhGd4nu2ZSojGwxPuIz44gA3bsTsL/warikhaHADUOH
 VQus4i+8ARDAYnh89zhCZrXpRZO+SvsrSyGAN1VwvuCPzxzw2E7zqoxBleTGfNNz37LZP/
 B0ljz5C0D7l41Sy4Q570EITwaq2WOYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776712441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2PDvKPJh+vw3yGeE4UxU8QHppQh3dAiLUVC5UZgsx68=;
 b=oYV812H1cj2sRmzHEglW+rfmiH5Rfs2yFaibBtU1xPUTTEuZTmBkDl6LrW0/9b6T4aBEwf
 YiNfaL6mn6SsK6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776712440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2PDvKPJh+vw3yGeE4UxU8QHppQh3dAiLUVC5UZgsx68=;
 b=zA0T3Rw1lkgtMuvbarLAvqiwjyhf1P5nNsMvPiXI/X1VuKcAkhBLevGIj2LOMVRRPoBkQz
 uylFv6JtPO2VE/G1JEdf6gDsndHlKxEYoV3/CghKMKEbl5L/C9vXV+MrIKmwNS0cqGHAuk
 TVap1rTfwB2Pe4aPUVcOP0qASYk4n1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776712440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2PDvKPJh+vw3yGeE4UxU8QHppQh3dAiLUVC5UZgsx68=;
 b=ShsodDu/x9n7+NnlAIAffueezxmP/pbKkBSD0inx4f7teGHDBHzxoA+CT6Lh432SYo+u9n
 mVkoILuNqXSiFsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C74D593AE;
 Mon, 20 Apr 2026 19:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2IpmAfd65mkgegAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 20 Apr 2026 19:13:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v1] checkpatch: Allow spaces after all coroutine annotations
Date: Mon, 20 Apr 2026 16:13:56 -0300
Message-ID: <20260420191356.4439-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.984];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

The coroutine annotations may be used in the declaration of function
pointers, which triggers checkpatch due to the space before the
parentheses. E.g:

  int coroutine_fn (*run)(Job *job, Error **errp);
                  ^
The coroutine_fn annotation is already included in the list of terms
where spaces are allowed. Add the other coroutine annotations:
coroutine_mixed_fn and no_coroutine_fn.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
the next migration PR will trigger this
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b77bd69328..e1cf2ff23b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2441,6 +2441,7 @@ sub process {
 			if ($name =~ /^(?:
 				if|for|while|switch|return|case|
 				volatile|__volatile__|coroutine_fn|
+				coroutine_mixed_fn|no_coroutine_fn|
 				__attribute__|format|__extension__|
 				asm|__asm__)$/x)
 			{
-- 
2.51.0


