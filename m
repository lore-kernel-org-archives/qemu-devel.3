Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E49C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82f-0006o6-2g; Fri, 25 Sep 2026 11:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82d-0006nS-1D
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82b-0004ed-Dj
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 209CE1FF16;
 Fri, 25 Sep 2026 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uAMitxzrk8B1HSnf4ZFJY8Z36882uhnQwCBIpoR2cQ=;
 b=UQxbQwZUFg1OCymd9Ypu+Ug1ewGZ4Fu5J8iiwm2tuKUzNRtXg722tFG+gCdnpKvr4d8/0e
 qCKcOqvgwUbNJN3h0vvlDM37ASUrjh2STuND4rBiSQQghx4WVf6hv1P4NPycpDu+0DEI1M
 Y4yFXYatcQnfLdNcy+hLnfPqAlsCG3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uAMitxzrk8B1HSnf4ZFJY8Z36882uhnQwCBIpoR2cQ=;
 b=2SUh7ODHehTjbTJavEiArTGlGNa6iOcYPWm0j/3JMQNq3QSUq2EBTlmFHkJlHJFoU7nz8s
 M4GIYSEyayJfADAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uAMitxzrk8B1HSnf4ZFJY8Z36882uhnQwCBIpoR2cQ=;
 b=q7cHVVuTWKSLxy3L/OhIqH7o2gYQzdrr71gsBXxfnues7v3tKjgWYy71e2jfKOHxl5RjAD
 B3Dbf5wSHwx3DBHtBnlBJZ1M2j9iTmr62UMi1HhjyHf5beoqhPhjvBP47E7YCIxM8clJjG
 nF8e0ewmRqGqdB4f5uMLeSiGhBbzdng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uAMitxzrk8B1HSnf4ZFJY8Z36882uhnQwCBIpoR2cQ=;
 b=voW7vlNK3SlmxLe7Ok5k3LFJepy/5M2gPyZMv8xk+Jj1sRmp3hw+KbUsmb7YeDsZCVleEV
 UXI3aFAAPlZx1CCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E99313353;
 Fri, 25 Sep 2026 15:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T20
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 19/19] docs/migration: document that postcopy can be used with
 multifd
Date: Fri, 25 Sep 2026 12:40:10 -0300
Message-ID: <20260925154010.599247-20-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Bin Guo <guobin@linux.alibaba.com>

Since commit e27418861288 ("migration: enable multifd and postcopy
together") in the 10.1 release, the multifd and postcopy-ram capabilities
are no longer mutually exclusive, but the postcopy documentation does not
mention multifd at all, leaving users unaware that the two features can be
combined.

Add a short section describing how they interact: multifd carries the
pages of the precopy phase, the channels are flushed and synced before the
switchover (because loading a page in a multifd receive thread is not
atomic with regard to a running vCPU), and the postcopy phase itself does
not use the multifd channels.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/postcopy.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index e319388d8f..570a3a1ce6 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -294,6 +294,32 @@ the background migration channel.  Anyone who cares about latencies of page
 faults during a postcopy migration should enable this feature.  By default,
 it's not enabled.
 
+Postcopy with multifd
+---------------------
+
+The ``multifd`` capability can be enabled together with ``postcopy-ram``
+since the 10.1 QEMU release.  The two features apply to different phases of
+the migration:
+
+  - During the precopy phase, guest pages are sent over the multifd channels
+    as usual, so the initial RAM transfer can use all of them.
+
+  - Just before switching to postcopy, the source flushes and syncs the
+    multifd channels.  This guarantees that all the pages already queued on
+    those channels are loaded on the destination *before* the destination
+    CPUs are started, which is required because loading a page in a multifd
+    receive thread is not atomic with regard to a running vCPU.
+
+  - During the postcopy phase the multifd channels are no longer used for
+    guest pages.  Both the background stream and the pages requested by the
+    destination go through the background migration channel instead, or
+    through the preempt channel for the requested pages when postcopy
+    preemption is enabled.
+
+Consequently, multifd only speeds up the precopy phase of a postcopy
+migration.  The bandwidth available once postcopy has started is the same as
+without multifd.
+
 Postcopy blocktime statistics
 -----------------------------
 
-- 
2.53.0


