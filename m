Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AF4C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEVA-0005dM-Af; Fri, 11 Jul 2025 10:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET9-0001Mv-0I
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:19 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESn-0006Zt-70
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:10:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D67F21192;
 Fri, 11 Jul 2025 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Afq2KYMYYL/Thf/uD8cq+0jXlmbxqDVWTWRLkkwZEnM=;
 b=X1u1Vh/J2gGNhySd3aEJflSbRBprM7qRp4crKBPz/I5dBWXcIxJqmhblJ5XRsFGrN6GVOr
 V6w07HMWA7nUdFqFkGUucjGNFgAC36yztw3euW9yAAiLvkWzt9zGtLQHmTlNqoi95rftwB
 T/OVinYRHdLM4rrj16Wb6dqXa5bbJHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Afq2KYMYYL/Thf/uD8cq+0jXlmbxqDVWTWRLkkwZEnM=;
 b=pcVwHQmnIZFugjh8AxQ6kZj6wEEi3Odm5S7o7SbezsjdCqVVIJUfnZAgxe5vaGUfNg2vic
 A/CNUR0+IawchTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Afq2KYMYYL/Thf/uD8cq+0jXlmbxqDVWTWRLkkwZEnM=;
 b=X1u1Vh/J2gGNhySd3aEJflSbRBprM7qRp4crKBPz/I5dBWXcIxJqmhblJ5XRsFGrN6GVOr
 V6w07HMWA7nUdFqFkGUucjGNFgAC36yztw3euW9yAAiLvkWzt9zGtLQHmTlNqoi95rftwB
 T/OVinYRHdLM4rrj16Wb6dqXa5bbJHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Afq2KYMYYL/Thf/uD8cq+0jXlmbxqDVWTWRLkkwZEnM=;
 b=pcVwHQmnIZFugjh8AxQ6kZj6wEEi3Odm5S7o7SbezsjdCqVVIJUfnZAgxe5vaGUfNg2vic
 A/CNUR0+IawchTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD6241388B;
 Fri, 11 Jul 2025 14:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qJ68GmEbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 03/26] migration/docs: Move docs for postcopy blocktime feature
Date: Fri, 11 Jul 2025 11:10:08 -0300
Message-Id: <20250711141031.423-4-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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

From: Peter Xu <peterx@redhat.com>

Move it out of vanilla postcopy session, but instead a standalone feature.
When at it, removing the NOTE because it's incorrect now after introduction
of max-postcopy-bandwidth, which can control the throughput even for
postcopy phase.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250613140801.474264-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/postcopy.rst | 36 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index 82e7a848c6..e319388d8f 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -33,25 +33,6 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
-Blocktime is a postcopy live migration metric, intended to show how
-long the vCPU was in state of interruptible sleep due to pagefault.
-That metric is calculated both for all vCPUs as overlapped value, and
-separately for each vCPU. These values are calculated on destination
-side.  To enable postcopy blocktime calculation, enter following
-command on destination monitor:
-
-``migrate_set_capability postcopy-blocktime on``
-
-Postcopy blocktime can be retrieved by query-migrate qmp command.
-postcopy-blocktime value of qmp command will show overlapped blocking
-time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
-time per vCPU.
-
-.. note::
-  During the postcopy phase, the bandwidth limits set using
-  ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
-  the destination is waiting for).
-
 Postcopy internals
 ==================
 
@@ -312,3 +293,20 @@ explicitly) to be sent in a separate preempt channel, rather than queued in
 the background migration channel.  Anyone who cares about latencies of page
 faults during a postcopy migration should enable this feature.  By default,
 it's not enabled.
+
+Postcopy blocktime statistics
+-----------------------------
+
+Blocktime is a postcopy live migration metric, intended to show how
+long the vCPU was in state of interruptible sleep due to pagefault.
+That metric is calculated both for all vCPUs as overlapped value, and
+separately for each vCPU. These values are calculated on destination
+side.  To enable postcopy blocktime calculation, enter following
+command on destination monitor:
+
+``migrate_set_capability postcopy-blocktime on``
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+postcopy-blocktime value of qmp command will show overlapped blocking
+time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
+time per vCPU.
-- 
2.35.3


