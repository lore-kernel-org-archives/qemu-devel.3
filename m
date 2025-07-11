Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9DEC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEYI-0002hG-VJ; Fri, 11 Jul 2025 10:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETH-0001iI-Po
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETF-0006hV-5Y
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C9F71F455;
 Fri, 11 Jul 2025 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtcLz3HoOuMb7dWaVW/7n137qzfJKsmUGSn1VyrRD58=;
 b=SjfxJleEp1JDj4xy2dkfdIf7LPhgK3JA22+/142axIunnsYt+xImBNteYUeQfLo7dv2hRg
 y/sRVzi1Y1/brnQGamRpkup8CPPjwPpLIeqgwwFFF55+TslEBBJkceAoPQFnQNXrdgkpPO
 qd2OenIAz4GVsqULZYRrUBzlGJVaHHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtcLz3HoOuMb7dWaVW/7n137qzfJKsmUGSn1VyrRD58=;
 b=fg/AZulPxsJ4R8duTEe1wKZT3ByQIu4/u2JvKLxuieeFCMbH5bXE2cqeYe1FhRs2OtjJ4h
 O8FtIRhqwwUYKTDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtcLz3HoOuMb7dWaVW/7n137qzfJKsmUGSn1VyrRD58=;
 b=SjfxJleEp1JDj4xy2dkfdIf7LPhgK3JA22+/142axIunnsYt+xImBNteYUeQfLo7dv2hRg
 y/sRVzi1Y1/brnQGamRpkup8CPPjwPpLIeqgwwFFF55+TslEBBJkceAoPQFnQNXrdgkpPO
 qd2OenIAz4GVsqULZYRrUBzlGJVaHHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtcLz3HoOuMb7dWaVW/7n137qzfJKsmUGSn1VyrRD58=;
 b=fg/AZulPxsJ4R8duTEe1wKZT3ByQIu4/u2JvKLxuieeFCMbH5bXE2cqeYe1FhRs2OtjJ4h
 O8FtIRhqwwUYKTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2A7D13918;
 Fri, 11 Jul 2025 14:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CA1yI3AbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Yanfei Xu <yanfei.xu@bytedance.com>
Subject: [PULL 11/26] migration/postcopy: Avoid clearing dirty bitmap for
 postcopy too
Date: Fri, 11 Jul 2025 11:10:16 -0300
Message-Id: <20250711141031.423-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

This is a follow up on the other commit "migration/ram: avoid to do log
clear in the last round" but for postcopy.

https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com

I can observe more than 10% reduction of average page fault latency during
postcopy phase with this optimization:

  Before: 268.00us (+-1.87%)
  After:  232.67us (+-2.01%)

The test was done with a 16GB VM with 80 vCPUs, running a workload that
busy random writes to 13GB memory.

Cc: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613140801.474264-12-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index e4871b4c17..7208bc114f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -835,8 +835,10 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      * protections isn't needed as we know there will be either (1) no
      * further writes if migration will complete, or (2) migration fails
      * at last then tracking isn't needed either.
+     *
+     * Do the same for postcopy due to the same reason.
      */
-    if (!rs->last_stage) {
+    if (!rs->last_stage && !migration_in_postcopy()) {
         /*
          * Clear dirty bitmap if needed.  This _must_ be called before we
          * send any of the page in the chunk because we need to make sure
-- 
2.35.3


