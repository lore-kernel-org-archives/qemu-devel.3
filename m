Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02123109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYR-0001OY-NN; Thu, 19 Mar 2026 19:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYP-0001Nt-Mt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYN-0001SZ-VF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvYChAt7BjGSW8L2rQATcp7ZC0XhC8w7Tx3h3LXPv4w=;
 b=V8hAU69HHczmHzn+e+nKYAn9d11lKtdsvDeRBFgkW+tos5k2N7s6IcLNM7r6cDZ8AVElZN
 duHV7XNIw48xpA04JHAfJtYUGkKxlCuLA9j16Yr0KRC97dHKUYt/gi3QcIwR677y4uj1WV
 gtOtOWT9k+fUdDVqRPh6E3UDffRC9cs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-mHt8bz-4Pcqxj-Vo2Kx5aA-1; Thu, 19 Mar 2026 19:13:22 -0400
X-MC-Unique: mHt8bz-4Pcqxj-Vo2Kx5aA-1
X-Mimecast-MFC-AGG-ID: mHt8bz-4Pcqxj-Vo2Kx5aA_1773962001
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50939597b85so38900261cf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962001; x=1774566801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvYChAt7BjGSW8L2rQATcp7ZC0XhC8w7Tx3h3LXPv4w=;
 b=i7rzfxdysQTghlXCCHg6LjP8jyUB65Sw5eeqKjWSCc1iXT6IbjAqkuhpWFBuU3lOyA
 I7J3v/V36+lASdhCWk3ofGJaQCMPBC+SxWvTQFrvITWLpTBkEUVtZdblEg7CKflzO8p1
 Hjnhb4AWJRK+0ul4o0AhD3bCgtezP9utbNV5Zvo7aFKoLljJ/5TlIoO7cc7um28m9+En
 rxorwVkJiYlb7q3RBV3QJi5ZXYM0fLoWkd04ZNfFOPqwXEX+dEyMI5DpNeQQCihgYQT3
 AkCH8YygO77+NLRjq+YRE9dFxAfKjVzol1+TCSlLdgcuPg26aSt21AtBAGz2I4VZXIm5
 bVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962001; x=1774566801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SvYChAt7BjGSW8L2rQATcp7ZC0XhC8w7Tx3h3LXPv4w=;
 b=A/uGSeLQxsGQcD8yV91YJZK7y5V5yBLmyEyicHnWu8GUaE1doe1ZKKt1V9Vly64c2j
 1KeXVqD+3ofywwNUuGVBcj9OGO+/m9Etn5/17m3yeAO7SBb5wpSZ00wED9nrbV3t2Ssk
 AViPIwu7HepcYy+G9GMvKVefkqe0a/yDluJzjoUUPtzb3CGpSzVipvlrkywGEKK0FZs2
 K7HhQp/PryrkPQzEPDbDdnNxiF8+urgT13WPrADiJnjp2rk80ocIEsBQRe5LZYyzqN7h
 X3xEA9mwIEYcA6omy3mSDiw4COGwIZkPq26r5Pl8hfBjVRJ92gr1eeLcy5l3IVIJ2GTC
 Q3/g==
X-Gm-Message-State: AOJu0Yxpmd6XYKE9c1BYHocp3rQXbNI4iB2oA8jSsEUWlGBXjbDZe5Ya
 5PwDOlJYsnw40oDTfroaDVO7JVsr+ZrtR44xk/7ei4wt78nxJCZmuBZHtm+ne6uMtgB97bYHmpY
 Z+ys3+GMD+s0t8/273WlXUXsoDbDI1lcDlCwY5O/fGmrY/UZpaEane+n6nE9sCk3vSC0Uwv10lR
 h0D56QvQW9zKTDPCXrDAni70MfvV9qLMSTI2PplA==
X-Gm-Gg: ATEYQzy3pvmFJonG+exXrTDjDEI9eeF/pufAVNjYE0OGpgbHPg7p7QT4Xr8lRAykP5E
 lxG3+snpjEOZo61eVvLTd3j/VMV56WjIfxd+0Q7TAAlVJAmZG7PL3hcbXI1lAGLBLOUehETRm/d
 5dUBFPtbWd/KvyKZ4VIsqA+294cBYe5/aqtYutbvhh7Io2iRgr//nOzTD72e83ew/yZiv78S+QA
 woboluo9NW+Oo2XV3TO7emzpmEUwDxkN9qaKO+z3HmKhkKlHpqrecRvK2tMF4XTUjRU6u16dcpm
 ovAYgnb07NAjmXfGlI5lBN969L8RjUX/7/RiwWVs4MHadHcTKgKpuA6eDjdWQYsTTpZnW3FLhRb
 UeEfUeW/F08nLTA==
X-Received: by 2002:a05:622a:2c9:b0:509:2677:68fc with SMTP id
 d75a77b69052e-50b3739f85amr17479501cf.10.1773962001103; 
 Thu, 19 Mar 2026 16:13:21 -0700 (PDT)
X-Received: by 2002:a05:622a:2c9:b0:509:2677:68fc with SMTP id
 d75a77b69052e-50b3739f85amr17478871cf.10.1773962000447; 
 Thu, 19 Mar 2026 16:13:20 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 06/12] migration: Use the new save_query_pending() API
 directly
Date: Thu, 19 Mar 2026 19:12:56 -0400
Message-ID: <20260319231302.123135-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's easier to use the new API directly in the migration iterations.  This
also paves way for follow up patches to add new data to report directly to
the iterator function.

When at it, merge the tracepoints too into one.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h     |  4 ----
 migration/migration.c  | 16 +++++++---------
 migration/savevm.c     | 23 ++---------------------
 migration/trace-events |  1 +
 4 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index b116933bce..3c39190fa4 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -46,10 +46,6 @@ void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
 int qemu_savevm_state_complete_precopy(MigrationState *s);
 void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
-void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
-                                     uint64_t *can_postcopy);
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_state_end(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index dfc60372cf..99c4d09000 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3204,17 +3204,17 @@ typedef enum {
  */
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
-    uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
     bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
                         s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
     bool can_switchover = migration_can_switchover(s);
+    MigPendingData pending = { };
+    uint64_t pending_size;
     bool complete_ready;
 
     /* Fast path - get the estimated amount of pending data */
-    qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
-    pending_size = must_precopy + can_postcopy;
-    trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
+    qemu_savevm_query_pending(&pending, true);
+    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
 
     if (in_postcopy) {
         /*
@@ -3243,14 +3243,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * during postcopy phase.
          */
         if (pending_size <= s->threshold_size) {
-            qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
-            pending_size = must_precopy + can_postcopy;
-            trace_migrate_pending_exact(pending_size, must_precopy,
-                                        can_postcopy);
+            qemu_savevm_query_pending(&pending, false);
+            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
         }
 
         /* Should we switch to postcopy now? */
-        if (must_precopy <= s->threshold_size &&
+        if (pending.precopy_bytes <= s->threshold_size &&
             can_switchover && qatomic_read(&s->start_postcopy)) {
             if (postcopy_start(s, &local_err)) {
                 migrate_error_propagate(s, error_copy(local_err));
diff --git a/migration/savevm.c b/migration/savevm.c
index 6268e68382..b3285d480f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1779,28 +1779,9 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
         }
         se->ops->save_query_pending(se->opaque, pending);
     }
-}
-
-void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
-                                        uint64_t *can_postcopy)
-{
-    MigPendingData pending;
-
-    qemu_savevm_query_pending(&pending, true);
-
-    *must_precopy = pending.precopy_bytes;
-    *can_postcopy = pending.postcopy_bytes;
-}
-
-void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
-                                     uint64_t *can_postcopy)
-{
-    MigPendingData pending;
-
-    qemu_savevm_query_pending(&pending, false);
 
-    *must_precopy = pending.precopy_bytes;
-    *can_postcopy = pending.postcopy_bytes;
+    trace_qemu_savevm_query_pending(fastpath, pending->precopy_bytes,
+                                    pending->postcopy_bytes);
 }
 
 void qemu_savevm_state_cleanup(void)
diff --git a/migration/trace-events b/migration/trace-events
index 60e5087e38..5f836a8652 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.50.1


