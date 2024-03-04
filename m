Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8691C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7RR-00086C-CO; Mon, 04 Mar 2024 07:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RJ-00082y-17
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:06 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RG-0004SX-NB
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ0840HKz4wnq;
 Mon,  4 Mar 2024 23:28:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ045g00z4wcK;
 Mon,  4 Mar 2024 23:28:52 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 01/26] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
Date: Mon,  4 Mar 2024 13:28:19 +0100
Message-ID: <20240304122844.1888308-2-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This will prepare ground for futur changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
set_migrationmode() always sets a new error. See the Rules section in
qapi/error.h.

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/s390x/storage-attributes.h |  2 +-
 hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
 hw/s390x/s390-stattrib.c              | 14 +++++++++-----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 5239eb538c1b087797867a247abfc14551af6a4d..8921a04d514bf64a3113255ee10ed33fc598ae06 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -39,7 +39,7 @@ struct S390StAttribClass {
     int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
                       uint32_t count, uint8_t *values);
     void (*synchronize)(S390StAttribState *sa);
-    int (*set_migrationmode)(S390StAttribState *sa, bool value);
+    int (*set_migrationmode)(S390StAttribState *sa, bool value, Error **errp);
     int (*get_active)(S390StAttribState *sa);
     long long (*get_dirtycount)(S390StAttribState *sa);
 };
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 24cd01382e2d74d62c2d7e980eb6aca1077d893d..357cea2c987213b867c81b0e258f7d0c293fe665 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "exec/ram_addr.h"
 #include "kvm/kvm_s390x.h"
+#include "qapi/error.h"
 
 Object *kvm_s390_stattrib_create(void)
 {
@@ -137,14 +138,21 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
     }
 }
 
-static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
+static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
+                                               Error **errp)
 {
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_MIGRATION,
         .attr = val,
         .addr = 0,
     };
-    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+    int r;
+
+    r = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+    if (r) {
+        error_setg_errno(errp, -r, "KVM_S390_SET_CMMA_BITS failed");
+    }
+    return r;
 }
 
 static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b5f71772639fc180bdad15ecb6711cb..e99de190332a82363b1388bbc450013149295bc0 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -60,11 +60,12 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
     S390StAttribState *sas = s390_get_stattrib_device();
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     uint64_t what = qdict_get_int(qdict, "mode");
+    Error *local_err = NULL;
     int r;
 
-    r = sac->set_migrationmode(sas, what);
+    r = sac->set_migrationmode(sas, what, &local_err);
     if (r < 0) {
-        monitor_printf(mon, "Error: %s", strerror(-r));
+        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));
     }
 }
 
@@ -170,13 +171,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
+    Error *local_err = NULL;
     int res;
     /*
      * Signal that we want to start a migration, thus needing PGSTE dirty
      * tracking.
      */
-    res = sac->set_migrationmode(sas, 1);
+    res = sac->set_migrationmode(sas, true, &local_err);
     if (res) {
+        error_report_err(local_err);
         return res;
     }
     qemu_put_be64(f, STATTR_FLAG_EOS);
@@ -260,7 +263,7 @@ static void cmma_save_cleanup(void *opaque)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
-    sac->set_migrationmode(sas, 0);
+    sac->set_migrationmode(sas, false, NULL);
 }
 
 static bool cmma_active(void *opaque)
@@ -293,7 +296,8 @@ static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
 {
     return 0;
 }
-static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value)
+static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value,
+                                            Error **errp)
 {
     return 0;
 }
-- 
2.44.0


