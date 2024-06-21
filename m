Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A837CC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTq-0003YU-E9; Fri, 21 Jun 2024 13:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTn-0003Xd-Mu
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:19 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTl-0003Oz-VW
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF30A1F835;
 Fri, 21 Jun 2024 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efojn5wV30laV0QjhernOtFVCmnPaNi8u6WawLOknLc=;
 b=jA7epGcqdAjlQlGm+QwWNZsNxYEAMh9AZGN3lpffpg0EPbOJa3XG2rcVbugrygDnObAdAq
 X06Ie6cWFVt8eku/fg3vDyw1Is3LUrf/u45tBFsuf2pdLy+rVGaHr+Hkd5hxZ/itf1bRJ5
 s1ATx3cNlaml6WiS9fJ4SZa8tTN2ox8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efojn5wV30laV0QjhernOtFVCmnPaNi8u6WawLOknLc=;
 b=BpvNzRo4heX09psgfhh3nyv3suzDyDec/VXOyrAn0rqU/5A+Gu0GbgQex5efoPnHPuGp83
 YHkI3gg6DJt0AKDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jA7epGcq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BpvNzRo4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efojn5wV30laV0QjhernOtFVCmnPaNi8u6WawLOknLc=;
 b=jA7epGcqdAjlQlGm+QwWNZsNxYEAMh9AZGN3lpffpg0EPbOJa3XG2rcVbugrygDnObAdAq
 X06Ie6cWFVt8eku/fg3vDyw1Is3LUrf/u45tBFsuf2pdLy+rVGaHr+Hkd5hxZ/itf1bRJ5
 s1ATx3cNlaml6WiS9fJ4SZa8tTN2ox8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992516;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efojn5wV30laV0QjhernOtFVCmnPaNi8u6WawLOknLc=;
 b=BpvNzRo4heX09psgfhh3nyv3suzDyDec/VXOyrAn0rqU/5A+Gu0GbgQex5efoPnHPuGp83
 YHkI3gg6DJt0AKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2B513AAA;
 Fri, 21 Jun 2024 17:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mKFWFYO+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/28] migration/docs: Update postcopy recover session for
 SETUP phase
Date: Fri, 21 Jun 2024 14:54:28 -0300
Message-Id: <20240621175434.31180-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF30A1F835
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Firstly, the "Paused" state was added in the wrong place before. The state
machine section was describing PostcopyState, rather than MigrationStatus.
Drop the Paused state descriptions.

Then in the postcopy recover session, add more information on the state
machine for MigrationStatus in the lines.  Add the new RECOVER_SETUP phase.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
[fix typo s/reconnects/reconnect]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/postcopy.rst | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index 6c51e96d79..82e7a848c6 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -99,17 +99,6 @@ ADVISE->DISCARD->LISTEN->RUNNING->END
     (although it can't do the cleanup it would do as it
     finishes a normal migration).
 
- - Paused
-
-    Postcopy can run into a paused state (normally on both sides when
-    happens), where all threads will be temporarily halted mostly due to
-    network errors.  When reaching paused state, migration will make sure
-    the qemu binary on both sides maintain the data without corrupting
-    the VM.  To continue the migration, the admin needs to fix the
-    migration channel using the QMP command 'migrate-recover' on the
-    destination node, then resume the migration using QMP command 'migrate'
-    again on source node, with resume=true flag set.
-
  - End
 
     The listen thread can now quit, and perform the cleanup of migration
@@ -221,7 +210,8 @@ paused postcopy migration.
 
 The recovery phase normally contains a few steps:
 
-  - When network issue occurs, both QEMU will go into PAUSED state
+  - When network issue occurs, both QEMU will go into **POSTCOPY_PAUSED**
+    migration state.
 
   - When the network is recovered (or a new network is provided), the admin
     can setup the new channel for migration using QMP command
@@ -229,9 +219,20 @@ The recovery phase normally contains a few steps:
 
   - On source host, the admin can continue the interrupted postcopy
     migration using QMP command 'migrate' with resume=true flag set.
+    Source QEMU will go into **POSTCOPY_RECOVER_SETUP** state trying to
+    re-establish the channels.
 
-  - After the connection is re-established, QEMU will continue the postcopy
-    migration on both sides.
+  - When both sides of QEMU successfully reconnect using a new or fixed up
+    channel, they will go into **POSTCOPY_RECOVER** state, some handshake
+    procedure will be needed to properly synchronize the VM states between
+    the two QEMUs to continue the postcopy migration.  For example, there
+    can be pages sent right during the window when the network is
+    interrupted, then the handshake will guarantee pages lost in-flight
+    will be resent again.
+
+  - After a proper handshake synchronization, QEMU will continue the
+    postcopy migration on both sides and go back to **POSTCOPY_ACTIVE**
+    state.  Postcopy migration will continue.
 
 During a paused postcopy migration, the VM can logically still continue
 running, and it will not be impacted from any page access to pages that
-- 
2.35.3


