Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AEAE909D0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNjb-0001CT-OY; Tue, 17 Feb 2026 11:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjY-0001Bw-92
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjW-00039N-GI
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC5875BCF4;
 Tue, 17 Feb 2026 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMDymZ9z5EH+qvOkmE6WNID+zsoFxrt6B20Lh0uqVi4=;
 b=H3VxDW6Q57FjfLRUsO44wjndma68208XtRU0vEpt2xp7QP3b/xobM8FCRr6CcPilxgXSsP
 PQFb76xS5PM0iud7cbZDIGgm/By/DFe7C2QQgMbzQFtoSBF9A9G2QPR1vocEQCI8dEqqoP
 EefMBoNgVRjEXBnYl4ZBieoAoRWVe+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMDymZ9z5EH+qvOkmE6WNID+zsoFxrt6B20Lh0uqVi4=;
 b=2sfMXXLZqrzc4Y+SHGAWKWkBD/Amzko7j5skKhpMHTuxY+EQzYVDU+RdeJ55pKxoAuM2u8
 GifInaoWXWCVTWDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMDymZ9z5EH+qvOkmE6WNID+zsoFxrt6B20Lh0uqVi4=;
 b=BZ/Q8Mt7GtSwK2xN6fCbq19s93B+r75bG6wEKYKoP/KawQ/8Pn5GbWm07eJVaWitt+2Hhv
 9MJ/0YFWEgMOdHFICLrddU7SlRFvJKPlEN2rjbKPshklVQvF47USCQRvyIJCKEcfM4ZVGw
 pzyigSxL0rabL6GkOKP0kCSNJqobuAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMDymZ9z5EH+qvOkmE6WNID+zsoFxrt6B20Lh0uqVi4=;
 b=B91qhMNeyo/yn2/lKVP24YYHUqDHvKfTznhoWmyGu7b1tqYRJ2OrynBAlFGSi6yKAERqhH
 0Q8VCjIVLQaLdHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B36EC3EA66;
 Tue, 17 Feb 2026 16:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8InqHQyUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 13/32] colo: Forbid VM resume during checkpointing
Date: Tue, 17 Feb 2026 13:14:24 -0300
Message-ID: <20260217161443.12738-14-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

COLO will stop the VM during each checkpoint on either PVM or SVM.

Accidentally resuming the VM during the window might be fatal because it
may cause the RAM and devices state to misalign, corrupting the checkpoint.

Hence forbid VM resume during the process.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-8-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/qmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 1ca44fbd72..0c409c27dc 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -84,6 +84,9 @@ void qmp_cont(Error **errp)
     } else if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
         error_setg(errp, "Migration is not finalized yet");
         return;
+    } else if (runstate_check(RUN_STATE_COLO)) {
+        error_setg(errp, "COLO checkpoint in progress");
+        return;
     }
 
     for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
-- 
2.51.0


