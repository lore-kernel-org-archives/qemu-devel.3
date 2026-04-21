Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246EAF55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3c0-0004yr-Oq; Tue, 21 Apr 2026 01:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wF3bd-0004cY-OU
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wF3bb-0001S6-Hh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776749102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8KBW0A8lledewlQBJoGaV29wjsscUDIJq9deU9jVCUQ=;
 b=Gj1o1qO/KaPZ0ftx2BZLu1OHZAb4T9JNc4k8im26OoB319gt21swF88ebOFlkmdNLHMDNO
 0t/2LWs406Z1TM8RXLwzzZdOZZJ1+RVTWZy6pTdf+/GL7sXMgGJfjRx6f45ZHXmNl8Nkoo
 m/CqltFGR2umkr0WYg/QPsx3grBwdbA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-fcDwTH9uOWS-LuioV2wD1w-1; Tue, 21 Apr 2026 01:23:40 -0400
X-MC-Unique: fcDwTH9uOWS-LuioV2wD1w-1
X-Mimecast-MFC-AGG-ID: fcDwTH9uOWS-LuioV2wD1w_1776749019
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso7945979a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776749018; x=1777353818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8KBW0A8lledewlQBJoGaV29wjsscUDIJq9deU9jVCUQ=;
 b=IXgiEvhtGCJZFGCglH/YgX57OoHjkBlAD8E8161GyRc/WP+vNMi2gxj7ZSfmwW8g9P
 c4N7yCMYu5+mJwyKkXXvfBeBwIvW/+7jcsVCqgga1HdCzyElBho87uQBOUWPvjZCbC2z
 DOJexd8wytqkG0njqO1U6DbjOJRAqYz574FG9HPTgh9HC9aFeRoaGDiAEPKSnfHfrZje
 h4Zf8jRVVbLWIrBf5QVgcl5Zm9P+jdOwt4E/wq0+sN95KgYE4ClQYS4pwNmW+aVD0rDk
 kBWOsyOspS/A0fqh80jk+slpoWrN4do3qWfzO/gzQzsfyr6HfvosGUmYd9s/P3IK1TVE
 3EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749018; x=1777353818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KBW0A8lledewlQBJoGaV29wjsscUDIJq9deU9jVCUQ=;
 b=eUqYzwWDBQ2+0etJCR2SLMBgVaHOuhQMxVCUTjIfV9isa/EEjuMuKfR4D8MliqQjwd
 wZ3YGcyuc9IGMbHnILTN2el/MDeqHiMC6I3Iry9HOsJUjfTDqpxylpYVIj6RIbS2TlcP
 PCYE6s7P7armY6kdxOlBXovD9oPCLWlZR6Pf/bTLW7vgxllY07mmJMnIW2LiCDjw7jpt
 a1fHBW/l9oXCN52cnf7AXl3+ezQ3PAr6MrmivK0dWTUDuCblhpHR+Qf0pw1dPKsdVpQS
 pRty+z+TRmqyeyVW6Lb/sOVMAMgkVp/4eM4qmKyd2oIupxf6T5VsBsdr6PYKrsUXmFcJ
 Fqvw==
X-Gm-Message-State: AOJu0Yw+FjCtzKOV5RKC4LjxFke4iM84kMV2VjmFIueGyaufvkoukbLv
 X1I/bGsHBuNs/LttkV5VGzdIOtmoUlFuO1Q0sVhgVJs1lruO+QPPA79g7bkg1Y5pQiKx2VqsLPa
 Um5cNKBp1Hl0fVfl5hGOOaqkhQoWMvs8E28rvohyLhhgMBcn+WN7sSEPMZ8kosZfps1p4U/Caes
 Ae1nhIR7Sk8jI72SbZGfqgjz4AuJW09Ri1rED4PJ0+Mw==
X-Gm-Gg: AeBDieuwTpvK4KF7NmNpS0jE9XVCpXU/anSUSXBqeo2Ps6JUYO0+ovoZ9ZZyPJ2LBup
 NZWUS6OC3ihCvo3ZcmP3xLTUn/95ApGPF9LC45QXCdl9ZIvm8U9sqkbMtE7EcX0+6QSIILLbfsx
 gqFERb8iQcPdS3i3J4Jb8vzmoETJHQdrENFigb5ETyEkQONsfxjl43A+73OF0k6mflEF90yYqXq
 JXVtzjAq7okYLg8G0yuUaICi41BBoYKChvBn0BLRPprkHwVSltV/yKKG0wES4eQ+PIu/EqUuv3j
 Egsy2R95Rp23qLuPEBCV8a0S5ReQgk5bRkQZWatzCOvk23rbaf0Xo2sxmpJPdF85j/SqlX0nqn4
 lM8lt0iQdLUIOND29F1I5s9KHzbfm1QK/zfL1HX7KQaeHI3vQuvvX/2RE7tWJI9PgWNtY
X-Received: by 2002:a17:90b:3504:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-3614046f76amr18163109a91.18.1776749018423; 
 Mon, 20 Apr 2026 22:23:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3504:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-3614046f76amr18163080a91.18.1776749017851; 
 Mon, 20 Apr 2026 22:23:37 -0700 (PDT)
Received: from prtyagi-thinkpadt14sgen2i.bengluru.csb ([115.110.236.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc593bsm15460364a91.1.2026.04.20.22.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:23:37 -0700 (PDT)
From: Pranav Tyagi <prtyagi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Pranav Tyagi <prtyagi@redhat.com>
Subject: [PATCH] migration: Fix blocking in POSTCOPY_DEVICE during package load
Date: Tue, 21 Apr 2026 10:52:27 +0530
Message-ID: <20260421052227.8278-1-prtyagi@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=prtyagi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The package_loaded event is not set in case MIG_RP_MSG_PONG does not
arrive on the source from the destination in the return path thread. The
migration thread would then be blocked waiting for package_loaded event
indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition the
source VM can safely resume as the destination has not yet started. The
pong message can get lost in case of a network failure or destination
crash before sending the pong.

This patch uses the error detected in case of network failure or
destination crash to set the package_loaded event in the out path of the
return path thread. This will kick the migration thread out from
a condition of indefinitely waiting for the package_loaded event. The
migration thread then fails early and breaks from the migration loop to
resume the VM on the source side.

Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>
---
 migration/migration.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..1656c1203c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2386,6 +2386,15 @@ out:
     if (err) {
         migrate_error_propagate(ms, err);
         trace_source_return_path_thread_bad_end();
+        if (ms->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
+            /*
+             * Kick the migration thread if it gets stuck in
+             * POSTCOPY_DEVICE state waiting for
+             * postcopy_package_loaded_event. The event will never be
+             * set as MIG_RP_MSG_PONG from the destination is lost.
+             */
+            qemu_event_set(&ms->postcopy_package_loaded_event);
+        }
     }
 
     if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
@@ -3232,6 +3241,17 @@ static MigIterateState migration_iteration_run(MigrationState *s)
              * package before actually completing.
              */
             qemu_event_wait(&s->postcopy_package_loaded_event);
+            /*
+             * Check for errors in case the migration thread was stuck in
+             * POSTCOPY_DEVICE state waiting for the
+             * postcopy_package_loaded_event which was never set.
+             * If so, fail now and break out of the iteration.
+             */
+            if (migrate_has_error(s)) {
+                migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
+                                  MIGRATION_STATUS_FAILING);
+                return MIG_ITERATE_BREAK;
+            }
             migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
                               MIGRATION_STATUS_POSTCOPY_ACTIVE);
         }
-- 
2.53.0


