Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D7C4452F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmAJN-0002AY-JM; Tue, 21 Jul 2026 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wmAJM-00029w-7W
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:15:04 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wmAJK-0004Mn-6d
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:15:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82C937A530;
 Tue, 21 Jul 2026 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784639700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WK4jDRk3tBLZtWM/SlakkKFYeM9tJHiMADPfj6sdEB4=;
 b=SYbTL78WAtFW5Qaxh/73fSRThtqlZwXojj0O+nGxv1xhygtwUUF5qlDj5p6agLXtq4+NNS
 5QVMO0BkkpCDNGMDHyuXdxHaBrNjiPk5R9+zmYcj+S0wtiThIjZ+NFOZXWSQhnvJbYYG+V
 XhIEX9h7OLZUQYPE3RlORS6WskNQawc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784639700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WK4jDRk3tBLZtWM/SlakkKFYeM9tJHiMADPfj6sdEB4=;
 b=yrD2Z79+9Xz8xrAS2zxz/TEFjSuUSZLyNAzkzkrA8vH9skF7cH3nwrB+Qu2Rarl16w9EzI
 OSuxQNEjkhbtnJAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SYbTL78W;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yrD2Z79+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784639700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WK4jDRk3tBLZtWM/SlakkKFYeM9tJHiMADPfj6sdEB4=;
 b=SYbTL78WAtFW5Qaxh/73fSRThtqlZwXojj0O+nGxv1xhygtwUUF5qlDj5p6agLXtq4+NNS
 5QVMO0BkkpCDNGMDHyuXdxHaBrNjiPk5R9+zmYcj+S0wtiThIjZ+NFOZXWSQhnvJbYYG+V
 XhIEX9h7OLZUQYPE3RlORS6WskNQawc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784639700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WK4jDRk3tBLZtWM/SlakkKFYeM9tJHiMADPfj6sdEB4=;
 b=yrD2Z79+9Xz8xrAS2zxz/TEFjSuUSZLyNAzkzkrA8vH9skF7cH3nwrB+Qu2Rarl16w9EzI
 OSuxQNEjkhbtnJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64713779AA;
 Tue, 21 Jul 2026 13:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P7mODdNwX2q7ewAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Jul 2026 13:14:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] docs: Add security considerations for migration
Date: Tue, 21 Jul 2026 10:14:57 -0300
Message-ID: <20260721131457.3062767-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 82C937A530
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Add the security considerations that are unique to migration and that
do not already fall into one of the other categories. Some aspects are
better framed as security architecture considerations, so extend that
section to mention TLS and clarify that disk images and guest network
also need to be isolated from other processes, not just other guests.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/system/security.rst | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index 52bbf0cc7a2..af626a42307 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -133,6 +133,16 @@ an issue as a normal bug.
   that affect the level 0 QEMU process. While these bugs should be
   fixed, they will not be triaged as security flaws at this time.
 
+* **migration/snapshots**. Migration failures and snapshot load
+  failures are considered part of normal operation as long as the
+  source virtual machine and savevm file, respectively, are still
+  functional. Aborting the QEMU process at the migration/snapshot
+  destination is similarly not considered a security issue. The
+  migration stream is assumed to be secure as long as the design
+  principles described in the Architecture section are held, in
+  which case plain manipulation of the stream is not considered as
+  an attack vector.
+
 * **low severity impact**. As a catch all rule, issues which
   are judged to have a "low" severity impact on the system will
   usually not justify handling as security bugs, nor assignment
@@ -159,10 +169,11 @@ could allow malicious guests to gain code execution in QEMU.  At this point the
 guest has escaped the virtual machine and is able to act in the context of the
 QEMU process on the host.
 
-Guests often interact with other guests and share resources with them.  A
-malicious guest must not gain control of other guests or access their data.
-Disk image files and network traffic must be protected from other guests unless
-explicitly shared between them by the user.
+Guests often interact with other guests and share resources with them.
+A malicious guest must not gain control of other guests or access
+their data.  Disk image files and network traffic must be protected
+from other guests, users and processes unless explicitly shared with
+them by the user.
 
 Principle of Least Privilege
 ''''''''''''''''''''''''''''
@@ -223,6 +234,9 @@ Some Linux distros already ship with UNIX groups for these devices by default.
   system calls that are not needed by QEMU, thereby reducing the host kernel
   attack surface.
 
+- Transport Layer Security (TLS) protocol can be used to ensure authenticity and
+  encryption of the live migration connection where the network is untrusted.
+
 Sensitive configurations
 ------------------------
 
-- 
2.53.0


