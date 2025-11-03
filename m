Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87685CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1m2-00017K-HO; Mon, 03 Nov 2025 16:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lz-00016p-Mt
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ll-0005SO-Hk
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4ySTRIKxvKeAz7Lm6tYyYb5uTFDHyjOqpDQGbAI3Y8=;
 b=OcJy0QULyHsUZaEva3E4L1LOrs+mrTgipQvgA5ag0YxNXlTP5NdJuTl70/c89q39phwymJ
 FTstv6niECYKNUbhFtvxlBcjPazCpD3T4djTHMTK4Bqw43Bmj8UlJu+2N7gbDmazkitLiD
 0Kp3w91J0LXiOezGqGypBU+VacCIyaY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-SqiFMpKeOHGOkRVPc-DYUw-1; Mon, 03 Nov 2025 16:07:15 -0500
X-MC-Unique: SqiFMpKeOHGOkRVPc-DYUw-1
X-Mimecast-MFC-AGG-ID: SqiFMpKeOHGOkRVPc-DYUw_1762204034
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8910b0fb780so735406285a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204034; x=1762808834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4ySTRIKxvKeAz7Lm6tYyYb5uTFDHyjOqpDQGbAI3Y8=;
 b=hAJ8n+umGriDi5qZwL3GDUcOz+zN3ZgCJXJKyfEzVDCSZGhVaQPfBYIqKZ52YU3MKv
 IdFDl8PWefCQ2egLpMT3r8HmoGnB2oc2bgx2XIFLeMK6sfOOR0pafe0k2HJpOGoslA6r
 AJC4//Z3qrYbn+v1ljlZytclWnqIYRgPDkt2/WYSaHE+6wdCtMOsM0b+jA7gRSXZKoJk
 /n87rLaOd0APALZDLs6ANuxGrVZ1+9VC24K8krjANGAvHRI8jmfaU1dDnBb9UAbwEAG9
 pmtu/OJLGGL5h35bxUAoy/4Z1DvIPFS70pSSjq2RVFwqqzKgqSGMKLetnPiGN8YGla8N
 2xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204034; x=1762808834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4ySTRIKxvKeAz7Lm6tYyYb5uTFDHyjOqpDQGbAI3Y8=;
 b=wXXuHwXIZeKpWSkXsvEDHgIbRvWdRbYixf5rhQVnjnxdUiU/AbXde98scx/1kIyb07
 lHYYiygzPT0H7gcZ1TA1ddNTXbWpH3/xEE0Z46BQa+BuAAg82j56WFjRte0O3EUsxSaW
 GOM1khIupSuK5Je8jyUOeuIa+f7ZDjXMq3KdeifHbwfjmYyiRq5ofnI50AhzUkTkCdwj
 rEkuE0sqCuGVra1H6bc+qzaI5QqqQu4U14WarjiS5yTxsq853Wxiw7mahMpU/I1dOuvT
 aHAT0ncdjF7ZehtWtlGwn727IeMqdgO8qsSNLuo9LUdgfiGWQOUn1c0Dn9Hk+Qm1qv3W
 4DUA==
X-Gm-Message-State: AOJu0YxvscNF02K04SA+s5UgJrn/4XFWtQYAcE6p4OAYrTUeI030/36d
 dQNpr8+lQlMrkSEL5ya9O8EQyAG3sEQLHnik+RjPg4NAIxpG5eHrJ41GO62dzdkQ0waT2KC1tC2
 mdvPuAOXUfApxZTC2LuZhatHpTOvjmBDDxFsz+Dtaxe22VvMneXuVvNOcWeSDZDE33H5y8IBqRt
 o3xDnp8d67AhNwcxX/fq6rqRmOYI9Nqu3je4JiVQ==
X-Gm-Gg: ASbGnctrg5Vu2pQQefM24/n5KmgMGjUDnWcuN3lwD21S06+RTearHSXBPiQo6KPCnNH
 Uyg8xErWf2CSWYTpsAjch26LNpjw2d53f6/5XEmXA+M7Gq738H7+xkwRcvpWlVEWTSIlCCEi+qV
 lKkrLovjaaMHxbALtMfw0UzIah6JZGtD3+LlqQmkkeS0kJyrECzhwnSxoWACDpE5mJ8exGV7DWe
 ldgz82iEI8us8IHusODmI8G5UfY9UIgpdKMRQ4qJsLXxxQhhgEthlzPqzk10gvk+w5NnritbdXl
 MgNWNm1gZa2+r3rnDfwUAi1TjFVaSAJTE7th+byvSbR0UwHpyZLxgVRvZ/NbfAZn
X-Received: by 2002:a05:620a:40c3:b0:88f:aff9:d89d with SMTP id
 af79cd13be357-8ab9bd5bcf7mr1790896585a.89.1762204033626; 
 Mon, 03 Nov 2025 13:07:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDMk7cFEQdXCXslPMf3f2xhVMiskTIkyu5pTd9mUYBpA+cKfZTtXm/9NYmCmDssQjOEg0PJQ==
X-Received: by 2002:a05:620a:40c3:b0:88f:aff9:d89d with SMTP id
 af79cd13be357-8ab9bd5bcf7mr1790890485a.89.1762204033015; 
 Mon, 03 Nov 2025 13:07:13 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 32/36] migration: Introduce postcopy incoming setup and cleanup
 functions
Date: Mon,  3 Nov 2025 16:06:21 -0500
Message-ID: <20251103210625.3689448-33-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

After moving postcopy_ram_listen_thread() to postcopy file, this patch
introduces a pair of functions, postcopy_incoming_setup() and
postcopy_incoming_cleanup(). These functions encapsulate setup and
cleanup of all incoming postcopy resources, postcopy-ram and postcopy
listen thread.

Furthermore, this patch also renames the postcopy_ram_listen_thread to
postcopy_listen_thread, as this thread handles not only postcopy-ram,
but also dirty-bitmaps and in the future it could handle other
postcopiable devices.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251103183301.3840862-5-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.h |  3 ++-
 migration/migration.c    |  2 +-
 migration/postcopy-ram.c | 44 ++++++++++++++++++++++++++++++++++++++--
 migration/savevm.c       | 25 ++---------------------
 4 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 3e26db3e6b..a080dd65a7 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -199,6 +199,7 @@ bool postcopy_is_paused(MigrationStatus status);
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
-void *postcopy_ram_listen_thread(void *opaque);
+int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
+int postcopy_incoming_cleanup(MigrationIncomingState *mis);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 6e647c7c4a..9a367f717e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -892,7 +892,7 @@ process_incoming_migration_co(void *opaque)
              * but managed to complete within the precopy period, we can use
              * the normal exit.
              */
-            postcopy_ram_incoming_cleanup(mis);
+            postcopy_incoming_cleanup(mis);
         } else if (ret >= 0) {
             /*
              * Postcopy was started, cleanup should happen at the end of the
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 880b11f154..b47c955763 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2083,7 +2083,7 @@ bool postcopy_is_paused(MigrationStatus status)
  * the input stream, leaving the main thread free to carry on loading the rest
  * of the device state (from RAM).
  */
-void *postcopy_ram_listen_thread(void *opaque)
+static void *postcopy_listen_thread(void *opaque)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     QEMUFile *f = mis->from_src_file;
@@ -2149,7 +2149,7 @@ void *postcopy_ram_listen_thread(void *opaque)
          */
         qemu_event_wait(&mis->main_thread_load_event);
     }
-    postcopy_ram_incoming_cleanup(mis);
+    postcopy_incoming_cleanup(mis);
 
     if (load_res < 0) {
         /*
@@ -2182,3 +2182,43 @@ void *postcopy_ram_listen_thread(void *opaque)
 
     return NULL;
 }
+
+int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
+{
+    /*
+     * Sensitise RAM - can now generate requests for blocks that don't exist
+     * However, at this point the CPU shouldn't be running, and the IO
+     * shouldn't be doing anything yet so don't actually expect requests
+     */
+    if (migrate_postcopy_ram()) {
+        if (postcopy_ram_incoming_setup(mis)) {
+            postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
+            return -1;
+        }
+    }
+
+    trace_loadvm_postcopy_handle_listen("after uffd");
+
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
+        return -1;
+    }
+
+    mis->have_listen_thread = true;
+    postcopy_thread_create(mis, &mis->listen_thread,
+                           MIGRATION_THREAD_DST_LISTEN,
+                           postcopy_listen_thread, QEMU_THREAD_DETACHED);
+
+    return 0;
+}
+
+int postcopy_incoming_cleanup(MigrationIncomingState *mis)
+{
+    int rc = 0;
+
+    if (migrate_postcopy_ram()) {
+        rc = postcopy_ram_incoming_cleanup(mis);
+    }
+
+    return rc;
+}
diff --git a/migration/savevm.c b/migration/savevm.c
index 2f7ed0db64..01b5a8bfff 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2113,32 +2113,11 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
 
     trace_loadvm_postcopy_handle_listen("after discard");
 
-    /*
-     * Sensitise RAM - can now generate requests for blocks that don't exist
-     * However, at this point the CPU shouldn't be running, and the IO
-     * shouldn't be doing anything yet so don't actually expect requests
-     */
-    if (migrate_postcopy_ram()) {
-        if (postcopy_ram_incoming_setup(mis)) {
-            postcopy_ram_incoming_cleanup(mis);
-            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
-            return -1;
-        }
-    }
+    int rc = postcopy_incoming_setup(mis, errp);
 
-    trace_loadvm_postcopy_handle_listen("after uffd");
-
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
-        return -1;
-    }
-
-    mis->have_listen_thread = true;
-    postcopy_thread_create(mis, &mis->listen_thread,
-                           MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
     trace_loadvm_postcopy_handle_listen("return");
 
-    return 0;
+    return rc;
 }
 
 static void loadvm_postcopy_handle_run_bh(void *opaque)
-- 
2.50.1


