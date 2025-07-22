Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83404C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 23:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueMdy-0002jm-Cd; Tue, 22 Jul 2025 19:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMdQ-0002aD-Av
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:43:02 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMdO-0007t3-J2
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:59 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 045211F7B5;
 Tue, 22 Jul 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZZh+ZVa3T5k6vTaImGQ/AbOZe7gkNeo6VdPQTexAdg=;
 b=c5Sdy7JDGgvNeN+YG3ps+AR/dRQAeultV4WHn/dXRh4mkycGxw847Z9RiHvnr+pqbqfony
 Aabm2ce8VEmmeFtdZjhESPSt1pMbWNl/i/xIfU4uKG4jNHrnUdVEkkSnXiXK1iafxNXCgH
 8kRldLLfniw8prarRd2QTkf/28voigc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZZh+ZVa3T5k6vTaImGQ/AbOZe7gkNeo6VdPQTexAdg=;
 b=0o8t8Fy2vz7w49WsHcC6dB+2J8+iEJVPuiJFrdKPedtdj8twdyO2u4h1jMbMIi7aM0tuSO
 msdSdmxCkdg7jDBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZZh+ZVa3T5k6vTaImGQ/AbOZe7gkNeo6VdPQTexAdg=;
 b=c5Sdy7JDGgvNeN+YG3ps+AR/dRQAeultV4WHn/dXRh4mkycGxw847Z9RiHvnr+pqbqfony
 Aabm2ce8VEmmeFtdZjhESPSt1pMbWNl/i/xIfU4uKG4jNHrnUdVEkkSnXiXK1iafxNXCgH
 8kRldLLfniw8prarRd2QTkf/28voigc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZZh+ZVa3T5k6vTaImGQ/AbOZe7gkNeo6VdPQTexAdg=;
 b=0o8t8Fy2vz7w49WsHcC6dB+2J8+iEJVPuiJFrdKPedtdj8twdyO2u4h1jMbMIi7aM0tuSO
 msdSdmxCkdg7jDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6FE013A32;
 Tue, 22 Jul 2025 23:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFgnGechgGiqOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Jul 2025 23:42:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 7/7] crypto: add tracing & warning about GNUTLS countermeasures
Date: Tue, 22 Jul 2025 20:42:15 -0300
Message-Id: <20250722234215.6807-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250722234215.6807-1-farosas@suse.de>
References: <20250722234215.6807-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

From: Daniel P. Berrangé <berrange@redhat.com>

We want some visibility on stderr when the GNUTLS thread
safety countermeasures are activated, to encourage people
to get the real fix deployed (once it exists). Some trace
points will also help if we see any further wierd crash
scenario we've not anticipated.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20250718150514.2635338-5-berrange@redhat.com
[add missing include]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 crypto/tlssession.c | 11 +++++++++++
 crypto/trace-events |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index baef878fa0..86d407a142 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/thread.h"
 #include "crypto/tlssession.h"
 #include "crypto/tlscredsanon.h"
@@ -615,10 +616,20 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
          * only have to protect against automatic rekeying
          * which doesn't trigger with CHACHA20
          */
+        trace_qcrypto_tls_session_parameters(
+            session,
+            session->requireThreadSafety,
+            gnutls_protocol_get_version(session->handle),
+            cipher);
+
         if (session->requireThreadSafety &&
             gnutls_protocol_get_version(session->handle) ==
             GNUTLS_TLS1_3 &&
             cipher != GNUTLS_CIPHER_CHACHA20_POLY1305) {
+            warn_report("WARNING: activating thread safety countermeasures "
+                        "for potentially broken GNUTLS with TLS1.3 cipher=%d",
+                        cipher);
+            trace_qcrypto_tls_session_bug1717_workaround(session);
             session->lockEnabled = true;
         }
 #endif
diff --git a/crypto/trace-events b/crypto/trace-events
index bccd0bbf29..d0e33427fa 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -21,6 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
 # tlssession.c
 qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
+qcrypto_tls_session_parameters(void *session, int threadSafety, int protocol, int cipher) "TLS session parameters session=%p threadSafety=%d protocol=%d cipher=%d"
+qcrypto_tls_session_bug1717_workaround(void *session) "TLS session bug1717 workaround session=%p"
 
 # tls-cipher-suites.c
 qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"
-- 
2.35.3


