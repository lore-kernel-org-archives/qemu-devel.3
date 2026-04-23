Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE12FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzbF-0001rO-Pb; Thu, 23 Apr 2026 15:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbD-0001qu-Rh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbC-0001n3-5P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:20:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75AA85BD7F;
 Thu, 23 Apr 2026 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkCfBpNfc54W4lu2o8abv4Mu9Sgre3nkQSL+bsElAQ8=;
 b=Q81xwtoM3+0WicRjQq9bdjIio9ASt/oyTV5fnQ9RZmApVhLgPNLvSId4E9Pz0rSFva+4nF
 R7ZFw1aySyimjlhLEXycoWajYW7Zf6LZoqDUCOtzPACUJ9pr94vboF7RDDWvcQ7PacHPei
 p6z/k5Hczo5hQ45Tg4YZq9BYnwL2GnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkCfBpNfc54W4lu2o8abv4Mu9Sgre3nkQSL+bsElAQ8=;
 b=vH7k1NqTQJqjSbGh4wItlJhFKG+4DQYvvfY/xi3TfOOLe34g37S8Mig0WHostRbJV0nHIW
 Ma/V8SOVix1yDFDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkCfBpNfc54W4lu2o8abv4Mu9Sgre3nkQSL+bsElAQ8=;
 b=Q81xwtoM3+0WicRjQq9bdjIio9ASt/oyTV5fnQ9RZmApVhLgPNLvSId4E9Pz0rSFva+4nF
 R7ZFw1aySyimjlhLEXycoWajYW7Zf6LZoqDUCOtzPACUJ9pr94vboF7RDDWvcQ7PacHPei
 p6z/k5Hczo5hQ45Tg4YZq9BYnwL2GnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkCfBpNfc54W4lu2o8abv4Mu9Sgre3nkQSL+bsElAQ8=;
 b=vH7k1NqTQJqjSbGh4wItlJhFKG+4DQYvvfY/xi3TfOOLe34g37S8Mig0WHostRbJV0nHIW
 Ma/V8SOVix1yDFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0EA593A3;
 Thu, 23 Apr 2026 19:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gCnoDvdw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 16/43] migration/cpr: move to new migration APIs
Date: Thu, 23 Apr 2026 16:19:30 -0300
Message-ID: <20260423191958.1440-17-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-15-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/cpr.h |  2 +-
 migration/cpr.c         | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 5850fd1788..96ce26e711 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -43,7 +43,7 @@ void cpr_set_incoming_mode(MigMode mode);
 bool cpr_is_incoming(void);
 
 bool cpr_state_save(MigrationChannel *channel, Error **errp);
-int cpr_state_load(MigrationChannel *channel, Error **errp);
+bool cpr_state_load(MigrationChannel *channel, Error **errp);
 void cpr_state_close(void);
 struct QIOChannel *cpr_state_ioc(void);
 
diff --git a/migration/cpr.c b/migration/cpr.c
index a0b37007f5..05266dfcfd 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -178,7 +178,6 @@ bool cpr_is_incoming(void)
 
 bool cpr_state_save(MigrationChannel *channel, Error **errp)
 {
-    int ret;
     QEMUFile *f;
     MigMode mode = migrate_mode();
 
@@ -199,8 +198,7 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
-    if (ret) {
+    if (!vmstate_save_vmsd(f, &vmstate_cpr_state, &cpr_state, 0, errp)) {
         qemu_fclose(f);
         return false;
     }
@@ -223,9 +221,8 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
     return true;
 }
 
-int cpr_state_load(MigrationChannel *channel, Error **errp)
+bool cpr_state_load(MigrationChannel *channel, Error **errp)
 {
-    int ret;
     uint32_t v;
     QEMUFile *f;
     MigMode mode = 0;
@@ -241,10 +238,10 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         cpr_set_incoming_mode(mode);
         f = cpr_transfer_input(channel, errp);
     } else {
-        return 0;
+        return true;
     }
     if (!f) {
-        return -1;
+        return false;
     }
 
     trace_cpr_state_load(MigMode_str(mode));
@@ -254,19 +251,18 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
     if (v != QEMU_CPR_FILE_MAGIC) {
         error_setg(errp, "Not a migration stream (bad magic %x)", v);
         qemu_fclose(f);
-        return -EINVAL;
+        return false;
     }
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_VERSION) {
         error_setg(errp, "Unsupported migration stream version %d", v);
         qemu_fclose(f);
-        return -ENOTSUP;
+        return false;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
-    if (ret) {
+    if (!vmstate_load_vmsd(f, &vmstate_cpr_state, &cpr_state, 1, errp)) {
         qemu_fclose(f);
-        return ret;
+        return false;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
@@ -280,7 +276,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
      */
     cpr_state_file = f;
 
-    return ret;
+    return true;
 }
 
 void cpr_state_close(void)
-- 
2.51.0


