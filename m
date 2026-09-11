Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B867C88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Az-0003h3-8P; Fri, 11 Sep 2026 10:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x52AX-0003UN-5o
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:23:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x52AT-000567-3I
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:23:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so649919f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789136631; x=1789741431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VE+MVcm8/cLaSkZ698BO2DSG7Db82s9o5WJWIxU2Vx0=;
 b=XR+qVjX4kTnc+O5yOpOiy4iB91zH0D35sDgXsRJ7CriGYx5lxrNCvDOQxBTfLYMUFi
 hT4mpbIPRUiQx4XT7OOZQ23WeSwLLP/TzleIvtMShwKgs20dTQ8p5dmJxTZe8Cr+oqr3
 NO6lujvBeQ4NL2EReJYyU1AecoXX+qkDFpUezU4z3kKpUrwjIGx3R8ze0D+lx5NIw7FK
 9If6qLqFrnjK4C1EwemKg0Z/Jb1zlXpRV6gnN5saMdLDv4+zUxB2plyxg9kyCqaA1njx
 k9+Sina4WUZdTDe2vETHGJA4uBHKUIQ76TZ3MbQ6OXV/qguMjn1YfDpk346w2mefeJ4z
 F1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136631; x=1789741431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VE+MVcm8/cLaSkZ698BO2DSG7Db82s9o5WJWIxU2Vx0=;
 b=l3sklTukHug7tDK5rky/Rwfd6S3zXDlghocg7MwUe/9LVuWZvXhqrMAL4fnhxiw9+B
 Y5BVJOtTPHIpPRrFf9B1KLGl1BTeY9uam7isuWQhKwHbCGm4jYMPadLWN3D42LY+dMvy
 1l1g6vs65UaxIZp8kfzFPdbG9TF6r8d6/oES5300tdy8DAEtkFwy7CRT2k6xBdI+XiCT
 B2N1awY565mR13rd2B8nuZF3WbeQ+MyodeNE8cuSknYOOR+KViDPqawjQETWp/V4yrAC
 cK4395ihGAy+7PDNvJ4AdEKSsfXshSFRgC5J/3a6n4tLS4UR56Ogi/NhfA3THNfFQwIo
 ak6w==
X-Gm-Message-State: AFuF++lIZaMbZTS0hamMzprzyT2+rkEDiSOgeTxzsa0YN61RyO/llsOn
 OIOdwBix5Q7UmROQ6U9WpAZxeBXDRMm3x7216bbTOOrBpndT8v4XoYocr92ynvbO3iQtK9Iz/Xh
 Dl/+C
X-Gm-Gg: AYBFou33L9L/wAQ/ggbMjrz0nCzA7wP6JtL4cUSRlzmiumsYgjaerRWJfUxlcbEZSfD
 EdF2qyJGfyzGRqQ6QGQAgRZhUp0jeidL3E0zvN8HuZBnoVlbvA01nVEVVIVgtsONlrkJadeokl+
 B5ORtUD0eziIo6c9esEqdK/eXDTiboxh6Tqer1ZNOcXTSv+itVM2p0mRiQ6Do+v7dP6PKPMbXMb
 Y5FX6dgLtlFoRyPxpmyxtJZm5pvygi5yMNt7e0eJJbz4gZxlYSJ1nHhtg7MEUct8L0qukrLg/Pz
 8lZbRsCyPZcA/5yulidV/MfAd/aipRS9R1aUGd8OTH00ake1ZSapoV+ONbppwZMwwhxit6flCgN
 l7rA/ksJV9s48yktDlZaJcWuzLBUuLz1ayZHiamwEA86Yo9e0tMH9maShmv58rV4aiDnPQilvo3
 57xFyLv6/VuQkWwNgcordbLF9nqNJGyBF3qU6VXfhecChYnlBOmV7XKkKAmaZ+EtObAd8=
X-Received: by 2002:a05:6000:c84:b0:482:e10e:58df with SMTP id
 ffacd0b85a97d-486eb303607mr4100158f8f.21.1789136631120; 
 Fri, 11 Sep 2026 07:23:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a007:bd26:918e:c58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm6398448f8f.20.2026.09.11.07.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:23:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 1/2] migration: let a vmstate defer its post_load to end of
 stream
Date: Fri, 11 Sep 2026 16:23:44 +0200
Message-ID: <20260911142345.3999518-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

A post_load hook which only rearranges the memory topology forces a
flatview rebuild as its section is read, and the cost of a rebuild grows
with the number of regions in the machine. A device which does this once
per vCPU therefore scales badly on the destination.

Add post_load_deferrable. A vmsd which sets it has its hook queued during
the load and run once the stream has been consumed, in the order the
hooks would have fired, with the whole drain sharing one memory
transaction.

Opt-in, because deferral is not free in general. A hook which can fail
must not be deferred: failing after the stream is consumed means the
source has already been told the migration succeeded, and may release a
guest the destination never started. A hook which reads guest memory must
not be deferred either, since the drain runs with the topology in flux.
Postcopy is excluded because its listen thread walks the same stream
concurrently.

CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 include/migration/vmstate.h |  40 +++++++++++++
 migration/savevm.c          |  23 ++++++++
 migration/vmstate.c         |  67 +++++++++++++++++++++-
 tests/unit/test-vmstate.c   | 111 ++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+), 2 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index e72c3fae9a..16045319d5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -303,6 +303,29 @@ struct VMStateDescription {
     bool (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
     bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
+
+    /*
+     * Run .post_load() once the whole stream has been loaded rather than
+     * as this section is read, so that it sees a machine whose devices
+     * have all been restored, and so that several of them can share the
+     * work they would each repeat.
+     *
+     * Three things must hold of a hook before it may be deferred.
+     *
+     * It must not fail. By the time the queue is drained the stream has
+     * been consumed, so a source may already have been told the migration
+     * succeeded and may have released the guest; there is nothing left to
+     * report a failure to. A hook which fails here is a bug in its vmsd
+     * and is fatal.
+     *
+     * Nothing else in the load may depend on what it does. The hooks run
+     * after every section has been read, so anything a later section needs
+     * to observe must not be produced here.
+     *
+     * It must not read guest memory or resolve an address space, because
+     * the drain runs as one batch with the memory topology in flux.
+     */
+    bool post_load_deferrable;
     int (*pre_save)(void *opaque);
     bool (*pre_save_errp)(void *opaque, Error **errp);
 
@@ -1299,6 +1322,23 @@ bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
+/**
+ * vmstate_post_load_defer_begin: Queue deferrable post_load hooks
+ *
+ * Between this and vmstate_post_load_defer_finish(), a post_load hook whose
+ * vmsd sets post_load_deferrable is recorded rather than called. Hooks are
+ * queued in the order they would have run.
+ */
+void vmstate_post_load_defer_begin(void);
+
+/**
+ * vmstate_post_load_defer_finish: Stop deferring and drain the queue
+ * @run: run the queued hooks, in order; when false, discard them
+ *
+ * Returns false if a hook failed, in which case the rest are discarded.
+ */
+bool vmstate_post_load_defer_finish(bool run, Error **errp);
+
 #define  VMSTATE_INSTANCE_ID_ANY  -1
 
 /* Returns: 0 on success, -1 on failure */
diff --git a/migration/savevm.c b/migration/savevm.c
index 4b590ea672..2352dcf684 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3128,6 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
+    bool defer_post_load;
     int ret;
 
     if (qemu_savevm_state_blocked(errp)) {
@@ -3147,7 +3148,29 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
+    /*
+     * The postcopy listen thread walks the same stream concurrently, so the
+     * queue would need locking and a defined owner for the drain.
+     */
+    defer_post_load = !migrate_postcopy_ram();
+    if (defer_post_load) {
+        vmstate_post_load_defer_begin();
+    }
+
     ret = qemu_loadvm_state_main(f, mis, errp);
+
+    if (defer_post_load) {
+        /*
+         * A deferrable hook only rearranges the memory topology, so the
+         * whole drain can share one flatview rebuild.
+         */
+        memory_region_transaction_begin();
+        if (!vmstate_post_load_defer_finish(ret == 0, errp)) {
+            ret = -EINVAL;
+        }
+        memory_region_transaction_commit();
+    }
+
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 24004565bf..3745f80dc8 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -250,8 +250,19 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
-static bool vmstate_post_load(const VMStateDescription *vmsd,
-                              void *opaque, int version_id, Error **errp)
+typedef struct VMStateDeferredPostLoad {
+    const VMStateDescription *vmsd;
+    void *opaque;
+    int version_id;
+    QSIMPLEQ_ENTRY(VMStateDeferredPostLoad) entry;
+} VMStateDeferredPostLoad;
+
+static QSIMPLEQ_HEAD(, VMStateDeferredPostLoad) vmstate_deferred_post_loads =
+    QSIMPLEQ_HEAD_INITIALIZER(vmstate_deferred_post_loads);
+static bool vmstate_defer_post_load;
+
+static bool vmstate_do_post_load(const VMStateDescription *vmsd,
+                                 void *opaque, int version_id, Error **errp)
 {
     ERRP_GUARD();
 
@@ -277,6 +288,58 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
     return true;
 }
 
+static bool vmstate_post_load(const VMStateDescription *vmsd,
+                              void *opaque, int version_id, Error **errp)
+{
+    VMStateDeferredPostLoad *d;
+
+    if (!vmstate_defer_post_load || !vmsd->post_load_deferrable) {
+        return vmstate_do_post_load(vmsd, opaque, version_id, errp);
+    }
+
+    d = g_new(VMStateDeferredPostLoad, 1);
+    d->vmsd = vmsd;
+    d->opaque = opaque;
+    d->version_id = version_id;
+    QSIMPLEQ_INSERT_TAIL(&vmstate_deferred_post_loads, d, entry);
+
+    return true;
+}
+
+void vmstate_post_load_defer_begin(void)
+{
+    assert(!vmstate_defer_post_load);
+    assert(QSIMPLEQ_EMPTY(&vmstate_deferred_post_loads));
+    vmstate_defer_post_load = true;
+}
+
+bool vmstate_post_load_defer_finish(bool run, Error **errp)
+{
+    VMStateDeferredPostLoad *d;
+    bool ok = true;
+
+    vmstate_defer_post_load = false;
+
+    while ((d = QSIMPLEQ_FIRST(&vmstate_deferred_post_loads))) {
+        QSIMPLEQ_REMOVE_HEAD(&vmstate_deferred_post_loads, entry);
+        if (run) {
+            ERRP_GUARD();
+
+            if (!vmstate_do_post_load(d->vmsd, d->opaque, d->version_id,
+                                      errp)) {
+                error_prepend(errp, "deferrable post load hook failed, which "
+                              "its vmsd promised could not happen: ");
+                error_report_err(*errp);
+                *errp = NULL;
+                abort();
+            }
+        }
+        g_free(d);
+    }
+
+    return ok;
+}
+
 /*
  * Try to prepare loading the next element, the object pointer to be put
  * into @next_elem.  When @next_elem is NULL, it means we should skip
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index df1fb4c778..e1e64b23c2 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -1619,6 +1619,116 @@ static void test_tmp_struct(void)
     g_assert_cmpint(obj.f, ==, 8); /* From the child->parent */
 }
 
+/* Deferred post_load */
+
+static int defer_order;
+static int defer_a_ran;
+static int defer_b_ran;
+static int defer_inline_ran;
+
+static int defer_a_post_load(void *opaque, int version_id)
+{
+    defer_a_ran = ++defer_order;
+    return 0;
+}
+
+static int defer_b_post_load(void *opaque, int version_id)
+{
+    defer_b_ran = ++defer_order;
+    return 0;
+}
+
+static int defer_inline_post_load(void *opaque, int version_id)
+{
+    defer_inline_ran = ++defer_order;
+    return 0;
+}
+
+static const VMStateDescription vmstate_defer_a = {
+    .name = "test/defer_a",
+    .version_id = 1,
+    .post_load = defer_a_post_load,
+    .post_load_deferrable = true,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(a, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_defer_b = {
+    .name = "test/defer_b",
+    .version_id = 1,
+    .post_load = defer_b_post_load,
+    .post_load_deferrable = true,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(a, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_defer_inline = {
+    .name = "test/defer_inline",
+    .version_id = 1,
+    .post_load = defer_inline_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(a, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void defer_reset(void)
+{
+    defer_order = 0;
+    defer_a_ran = 0;
+    defer_b_ran = 0;
+    defer_inline_ran = 0;
+}
+
+static void test_post_load_defer(void)
+{
+    uint8_t const wire[] = {
+        /* uint32 a */ 0x00, 0x00, 0x00, 0x01,
+        QEMU_VM_EOF,
+    };
+    TestStruct obj;
+    Error *err = NULL;
+
+    /* Not deferring: a deferrable hook still runs as the section is read */
+    defer_reset();
+    memset(&obj, 0, sizeof(obj));
+    SUCCESS(load_vmstate_one(&vmstate_defer_a, &obj, 1, wire, sizeof(wire)));
+    g_assert_cmpint(defer_a_ran, ==, 1);
+
+    /*
+     * Deferring holds back the hooks which opted in and replays them in the
+     * order they would have run. A hook which did not opt in is unaffected.
+     */
+    defer_reset();
+    memset(&obj, 0, sizeof(obj));
+    vmstate_post_load_defer_begin();
+    SUCCESS(load_vmstate_one(&vmstate_defer_a, &obj, 1, wire, sizeof(wire)));
+    SUCCESS(load_vmstate_one(&vmstate_defer_inline, &obj, 1, wire,
+                             sizeof(wire)));
+    SUCCESS(load_vmstate_one(&vmstate_defer_b, &obj, 1, wire, sizeof(wire)));
+    g_assert_cmpint(defer_a_ran, ==, 0);
+    g_assert_cmpint(defer_b_ran, ==, 0);
+    g_assert_cmpint(defer_inline_ran, ==, 1);
+
+    g_assert(vmstate_post_load_defer_finish(true, &err));
+    g_assert(!err);
+    g_assert_cmpint(defer_a_ran, ==, 2);
+    g_assert_cmpint(defer_b_ran, ==, 3);
+
+    /* A discarded queue runs nothing */
+    defer_reset();
+    memset(&obj, 0, sizeof(obj));
+    vmstate_post_load_defer_begin();
+    SUCCESS(load_vmstate_one(&vmstate_defer_a, &obj, 1, wire, sizeof(wire)));
+    g_assert(vmstate_post_load_defer_finish(false, &err));
+    g_assert(!err);
+    g_assert_cmpint(defer_a_ran, ==, 0);
+}
+
 int main(int argc, char **argv)
 {
     g_autofree char *temp_file = g_strdup_printf("%s/vmst.test.XXXXXX",
@@ -1663,6 +1773,7 @@ int main(int argc, char **argv)
     g_test_add_func("/vmstate/qlist/save/saveqlist", test_save_qlist);
     g_test_add_func("/vmstate/qlist/load/loadqlist", test_load_qlist);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
+    g_test_add_func("/vmstate/post_load/defer", test_post_load_defer);
     g_test_run();
 
     close(temp_fd);
-- 
2.53.0


