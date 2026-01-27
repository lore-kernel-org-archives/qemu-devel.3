Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9E5D2FEDD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCl-000592-FB; Tue, 27 Jan 2026 13:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBo-0003Dw-Gn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBm-0000np-2p
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNDhsqkpTzBpXh+tonhVJQSyR6a5H/fOQEVAtUlW7O0=;
 b=bA/PeF2gLh/c6O6OV+kgAb3OqlivVY1w5bC6u2Rz1WyG97E0QmxY98vS605Xq2rZAkIgBs
 bAXZ4WwdTySXBuVzdpN3jtqvdtMdb92/ysCpe2vqq0YZyK4VVgP59X8orYgJ9m5eJkwxGh
 cmR8WK0LtXxSmxp9CKmyGdg6g3uXiIA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-NNCBNYbXOA2zGav5jpP-MQ-1; Tue, 27 Jan 2026 13:53:19 -0500
X-MC-Unique: NNCBNYbXOA2zGav5jpP-MQ-1
X-Mimecast-MFC-AGG-ID: NNCBNYbXOA2zGav5jpP-MQ_1769539999
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8947d47793fso313931366d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539999; x=1770144799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNDhsqkpTzBpXh+tonhVJQSyR6a5H/fOQEVAtUlW7O0=;
 b=TjimngkpjpxMZPcjOI69dNf+wiVi6h0tJuzQvFHrvtAQ9Nw+foMWjyC3hBj3Szfttx
 OtZQqsrAYcRpjMizJVNtujxhRZdKgJdd8kLv7XTO9WOpl5aiw9YsQf29xcr/iKbE+hwa
 1Fs6I+wO86k5WBeRBoU7IiIRoAuChDEq/Au72hyYwJ0iO9iMvl6H0Y8a564viaPfNIq7
 NVTijzpyzkYSEDcyTiQ8qH4ly4QR/aNxOYgd8L4AyNILzt4MeHuIllzoAf3gRhT6trQN
 +09CPqRhDFEVY9oJtfBcYfM9YfZG3fyV7NT3SIpdZ6GX+wH5Eu7gODco/dVeuiB4zdzn
 n6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539999; x=1770144799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZNDhsqkpTzBpXh+tonhVJQSyR6a5H/fOQEVAtUlW7O0=;
 b=rsrA4dWqOISDVn0NEN/sbifwTTd7UYJw/N4GBdiKa2Je3Pz+UIuEAxlWoVKo/vsBLl
 2l3Y4NwqDHaWeDsk2BluHUcvnL+cjkQLzPdjZ7Bp6vtPxvs/f/G3W3qb7c4pxilPjNTq
 qlR9yTfmAdBo2JfAgRpCQjIFQ2c6EEY4H52B+8mh4Hs8n8JamnspptO0pN3fHWADDpiR
 j6tlu5iUyqFD1alsRcVW3UHDXI7jxZkw77YBioGg1e0nw1RqX/VAyEX+QgEj12EslOBv
 Z6WYST2/zqebcgWGaI7esNSXgZ1cM5FV+dLpT1Sp2d4oro6hyQ5eIdFJRFKy+8BPHGx9
 6fjQ==
X-Gm-Message-State: AOJu0YzXBB2JsSUMgXka/CuQZl2W55F/e5J73rZbJbZOi1K32iJjtjuD
 rJQQiY+U+U+QkHHy/1mRr/zrvWUaTurrNgUpgdOTwR8DqL9/l1qdYO8WA8RHv3NfnmM7+vqHBI5
 XvkR0Xr7idVVgARIASW+UrkOtS0ZEuIUYGaWTm2gXnPK2VkWUvRYh4PZ92SNomYlTQYOudWnd+L
 luastDA1y+IsT/Dgnv3CqBIy7P167YnolPHg6x1w==
X-Gm-Gg: AZuq6aJzPmz9n/M+d+hzZ+n8RMQyKROfRVCtCJSAZQWF1KIs5vL+EIr1TS02AbE3xJI
 oXdaWWjmUpbJzVHIIpuVe5S9OgQEXD7HIlMTB4LIYKd2hKsPSXC6BO/iNRN6h2tjsgNYfn6RqND
 +/PsPHiIPC/zW8fp25DWYIiAo/Da6Kz46r2e+/3B9AXEBeSFJiTPjlb5LD25yVnOHQlamv1jedd
 jLXWJWSB650Yy8bzD6MIqq3PCdCETwHurwoOcv9GonDNQamkhf2OlLuuTnFFBB9P37qozVt38xN
 tsMNuwkNKb7z9Xs1rovUwhsM2aXRhrkROlJFI04kewfSLMQiLM12sSl3bOTMbNjx9dTlOPvplbm
 +
X-Received: by 2002:a05:620a:4405:b0:8c3:528b:1b10 with SMTP id
 af79cd13be357-8c70b932fcdmr364398385a.90.1769539998682; 
 Tue, 27 Jan 2026 10:53:18 -0800 (PST)
X-Received: by 2002:a05:620a:4405:b0:8c3:528b:1b10 with SMTP id
 af79cd13be357-8c70b932fcdmr364393585a.90.1769539998057; 
 Tue, 27 Jan 2026 10:53:18 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 19/24] migration: Refactor qemu_savevm_state_setup()
Date: Tue, 27 Jan 2026 13:52:49 -0500
Message-ID: <20260127185254.3954634-20-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Split it into two smaller chunks:

  - Dump of early_setup VMSDs
  - Dump of save_setup() sections

They're mutual exclusive, hence we can run two loops and do them
sequentially.  This will cause migration thread to loop one more time, but
it should be fine when migration just started and only do it once.  It's
needed because we will need to reuse the early_vmsd helper later to
deduplicate code elsewhere.

QEMU almost sticks with qemu_savevm_state_XXX() to represent the dump of
vmstates's section XXX.  With that in mind, this patch renamed the original
qemu_savevm_state_setup() to qemu_savevm_state_do_setup() instead.

So after this patch:

  - qemu_savevm_state_non_iterable_early() dumps early_vmsds only,
  - qemu_savevm_state_setup() dumps save_setup() sections only,
  - qemu_savevm_state_do_setup() does all things needed during setup
    phase (including migration SETUP notifies)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  6 +++--
 migration/migration.c |  4 ++--
 migration/savevm.c    | 56 ++++++++++++++++++++++++++++++-------------
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index bded5e2a6c..f2750eca09 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -34,7 +34,7 @@
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_non_migratable_list(strList **reasons);
 int qemu_savevm_state_prepare(Error **errp);
-int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
+int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_send_header(QEMUFile *f);
@@ -75,7 +75,9 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_non_iterable(QEMUFile *f);
-
+int qemu_savevm_state_non_iterable_early(QEMUFile *f,
+                                         JSONWriter *vmdesc,
+                                         Error **errp);
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp);
 
diff --git a/migration/migration.c b/migration/migration.c
index b8c85496f8..2cbeebc9ba 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3528,7 +3528,7 @@ static void *migration_thread(void *opaque)
     }
 
     bql_lock();
-    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
+    ret = qemu_savevm_state_do_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
@@ -3651,7 +3651,7 @@ static void *bg_migration_thread(void *opaque)
 
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
-    ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
+    ret = qemu_savevm_state_do_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 0683a103c8..b04a21ffc9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1367,29 +1367,33 @@ int qemu_savevm_state_prepare(Error **errp)
     return 0;
 }
 
-int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
+int qemu_savevm_state_non_iterable_early(QEMUFile *f,
+                                         JSONWriter *vmdesc,
+                                         Error **errp)
 {
-    ERRP_GUARD();
-    MigrationState *ms = migrate_get_current();
-    JSONWriter *vmdesc = ms->vmdesc;
     SaveStateEntry *se;
-    int ret = 0;
-
-    if (vmdesc) {
-        json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
-        json_writer_start_array(vmdesc, "devices");
-    }
+    int ret;
 
-    trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
             ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
-                break;
+                return ret;
             }
-            continue;
         }
+    }
+
+    return 0;
+}
+
+static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    trace_savevm_state_setup();
 
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
@@ -1399,14 +1403,34 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
             }
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
-
         ret = se->ops->save_setup(f, se->opaque, errp);
         save_section_footer(f, se);
         if (ret < 0) {
-            break;
+            return ret;
         }
     }
 
+    return 0;
+}
+
+int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp)
+{
+    ERRP_GUARD();
+    MigrationState *ms = migrate_get_current();
+    JSONWriter *vmdesc = ms->vmdesc;
+    int ret;
+
+    if (vmdesc) {
+        json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
+        json_writer_start_array(vmdesc, "devices");
+    }
+
+    ret = qemu_savevm_state_non_iterable_early(f, vmdesc, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = qemu_savevm_state_setup(f, errp);
     if (ret) {
         return ret;
     }
@@ -1826,7 +1850,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ms->to_dst_file = f;
 
     qemu_savevm_state_header(f);
-    ret = qemu_savevm_state_setup(f, errp);
+    ret = qemu_savevm_state_do_setup(f, errp);
     if (ret) {
         goto cleanup;
     }
-- 
2.50.1


