Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430DDE909D4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNk1-0001re-SM; Tue, 17 Feb 2026 11:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjq-0001EU-4c
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:51 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNjo-0003Bn-E7
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:49 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D14C3E71C;
 Tue, 17 Feb 2026 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkyeT7dds1sm7FK83yQLWS0CkUqXnbiS2O9oKsYDH18=;
 b=0mU5LoMQlWT2u44KFRChoICEiVtPTmVHk2KQRMGtMxvOKDgiQAHD5jOV0V209Ewjo6SzZQ
 fXslSftzz0+n4IcW/d2a6/EvbYXJbAfpG9qJA7uzb5CQm4XmYLLI8WthISkBoWMaNTyOzP
 BStQLfedRXN8L+B1eYfKjDgkur6AUNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkyeT7dds1sm7FK83yQLWS0CkUqXnbiS2O9oKsYDH18=;
 b=SV+yoC2/KcmyFscvEH5wtYVhP/1HAhgdtkY34Mm4Q8s2BiGCT9rEFuBtRLNPu3GNEi7Evx
 ot60B5qp5QhrH1DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkyeT7dds1sm7FK83yQLWS0CkUqXnbiS2O9oKsYDH18=;
 b=0mU5LoMQlWT2u44KFRChoICEiVtPTmVHk2KQRMGtMxvOKDgiQAHD5jOV0V209Ewjo6SzZQ
 fXslSftzz0+n4IcW/d2a6/EvbYXJbAfpG9qJA7uzb5CQm4XmYLLI8WthISkBoWMaNTyOzP
 BStQLfedRXN8L+B1eYfKjDgkur6AUNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkyeT7dds1sm7FK83yQLWS0CkUqXnbiS2O9oKsYDH18=;
 b=SV+yoC2/KcmyFscvEH5wtYVhP/1HAhgdtkY34Mm4Q8s2BiGCT9rEFuBtRLNPu3GNEi7Evx
 ot60B5qp5QhrH1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 445F73EA66;
 Tue, 17 Feb 2026 16:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uMXPAhKUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 16/32] migration: Drop iterable_only in
 qemu_savevm_state_complete_precopy
Date: Tue, 17 Feb 2026 13:14:27 -0300
Message-ID: <20260217161443.12738-17-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Now after removing the special case in COLO, we can drop this parameter.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-11-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  2 +-
 migration/savevm.c    | 12 +++++-------
 migration/savevm.h    |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 850150a261..b7a2eee25c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2757,7 +2757,7 @@ static int migration_completion_precopy(MigrationState *s)
         goto out_unlock;
     }
 
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file);
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index d41be3a4a2..da9a60c73f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1717,7 +1717,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
+int qemu_savevm_state_complete_precopy(QEMUFile *f)
 {
     int ret;
 
@@ -1726,11 +1726,9 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
         return ret;
     }
 
-    if (!iterable_only) {
-        ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
-        if (ret) {
-            return ret;
-        }
+    ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
+    if (ret) {
+        return ret;
     }
 
     return qemu_fflush(f);
@@ -1830,7 +1828,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f, false);
+        qemu_savevm_state_complete_precopy(f);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
diff --git a/migration/savevm.h b/migration/savevm.h
index 528607f09e..ea01ca63ec 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -42,7 +42,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
+int qemu_savevm_state_complete_precopy(QEMUFile *f);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-- 
2.51.0


