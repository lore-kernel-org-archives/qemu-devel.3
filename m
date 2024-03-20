Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048A9C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpld-00026r-EH; Wed, 20 Mar 2024 02:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplb-00025w-9X
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplZ-0001R2-Lw
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rhg1zVR/KkRoYk8vgxinEsCnHBen4As/1Px29DrecbU=;
 b=FjHpXH8nrvP++BTb6yNn/ygXyI5rztBWo59WOcWfHTFvzNxXbtYJsG0rXEgUI2R0y+j0O2
 Owes45hXCYWL+w4B1EB+di2tCCBFV2HBoFrNgp2P8GdR8K5S7USdz8lXY4M3QqDaQfXto3
 IgLLykLzyUmCCHZGwrHL0BbIy2xPpYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-3XGrUekeMYaYjFFeoG5z8A-1; Wed, 20 Mar 2024 02:49:29 -0400
X-MC-Unique: 3XGrUekeMYaYjFFeoG5z8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7709A186E12A;
 Wed, 20 Mar 2024 06:49:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 536BA1C060D0;
 Wed, 20 Mar 2024 06:49:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH for-9.1 v5 01/14] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
Date: Wed, 20 Mar 2024 07:48:57 +0100
Message-ID: <20240320064911.545001-2-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This will prepare ground for future changes adding an Error** argument
to the save_setup() handler. We need to make sure that on failure,
set_migrationmode() always sets a new error. See the Rules section in
qapi/error.h.

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/s390x/storage-attributes.h |  2 +-
 hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
 hw/s390x/s390-stattrib.c              | 15 ++++++++++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

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
index 24cd01382e2d74d62c2d7e980eb6aca1077d893d..eeaa8110981c970e91a8948f027e398c34637321 100644
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
+        error_setg_errno(errp, -r, "setting KVM_S390_VM_MIGRATION failed");
+    }
+    return r;
 }
 
 static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c483b62a9b5f71772639fc180bdad15ecb6711cb..b743e8a2fee84c7374460ccea6df1cf447cda44b 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -60,11 +60,13 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
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
+        error_free(local_err);
     }
 }
 
@@ -170,13 +172,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
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
@@ -260,7 +264,7 @@ static void cmma_save_cleanup(void *opaque)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
-    sac->set_migrationmode(sas, 0);
+    sac->set_migrationmode(sas, false, NULL);
 }
 
 static bool cmma_active(void *opaque)
@@ -293,7 +297,8 @@ static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
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


