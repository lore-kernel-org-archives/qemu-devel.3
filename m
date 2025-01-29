Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10071C02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAZW-0001Fd-Lj; Wed, 29 Jan 2025 11:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWG-000447-2u
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:25 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWE-0005QR-Gj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5089F1F383;
 Wed, 29 Jan 2025 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGlzGgaaWlouropGbF5BCLSmn8WL6jHgth/Das2ZUyw=;
 b=dOMWrQGUlLAfQoPrEJHxUG4OYCcFsSpRo1F844sbdLHAwg+MVx4j7jSWhKWY5prvdhSIRs
 zfn4QfZDxleGV6vRQpoMMCsgveqrCZA9xMqvlJgpuqeM0Vf8kmATJLeMkvggMvua/mv2B3
 S30/syb/vT/jU1fMCt0O3JRGur4/OGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGlzGgaaWlouropGbF5BCLSmn8WL6jHgth/Das2ZUyw=;
 b=Y2D7b6HWnSpmHqXe4KSOgn/9ejNOGwlA+2JzAuh7kQBy9eJ21erVLPnJpHYB3ZZWUG5zts
 CG9FErSwRrWXASDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGlzGgaaWlouropGbF5BCLSmn8WL6jHgth/Das2ZUyw=;
 b=dOMWrQGUlLAfQoPrEJHxUG4OYCcFsSpRo1F844sbdLHAwg+MVx4j7jSWhKWY5prvdhSIRs
 zfn4QfZDxleGV6vRQpoMMCsgveqrCZA9xMqvlJgpuqeM0Vf8kmATJLeMkvggMvua/mv2B3
 S30/syb/vT/jU1fMCt0O3JRGur4/OGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGlzGgaaWlouropGbF5BCLSmn8WL6jHgth/Das2ZUyw=;
 b=Y2D7b6HWnSpmHqXe4KSOgn/9ejNOGwlA+2JzAuh7kQBy9eJ21erVLPnJpHYB3ZZWUG5zts
 CG9FErSwRrWXASDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C453B137DB;
 Wed, 29 Jan 2025 16:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABvxIAtRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 38/42] migration: Cleanup qemu_savevm_state_complete_precopy()
Date: Wed, 29 Jan 2025 13:00:55 -0300
Message-Id: <20250129160059.6987-39-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

Now qemu_savevm_state_complete_precopy() is never used in postcopy, clean
it up as in_postcopy==false now unconditionally.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-14-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0ddc4c8eb5..bc375db282 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1577,25 +1577,19 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 {
     int ret;
-    bool in_postcopy = migration_in_postcopy();
 
-    if (!in_postcopy || iterable_only) {
-        ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy);
+    ret = qemu_savevm_state_complete_precopy_iterable(f, false);
+    if (ret) {
+        return ret;
+    }
+
+    if (!iterable_only) {
+        ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
         if (ret) {
             return ret;
         }
     }
 
-    if (iterable_only) {
-        goto flush;
-    }
-
-    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy);
-    if (ret) {
-        return ret;
-    }
-
-flush:
     return qemu_fflush(f);
 }
 
-- 
2.35.3


