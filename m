Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A91C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMF-0004X5-Mi; Mon, 29 Apr 2024 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMB-0004Vs-7U
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM5-0005Fb-RE
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFml1T021753; Mon, 29 Apr 2024 15:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=LzcEoTaqq99sN03X9qX31cStr9peqSwOasAJUDXCZM8=;
 b=kI51nE349QCVJ4sWJyq4jeYPzaVdsQcW09dpM9ZSN6iFj5WNaUhjCLXNIL6qkAG+pMuV
 pEMWqutrIVYh1ZYocwSMATQZe6KEbNbOiWh6JPSNmZUOLd+Gy4gQI2/esQGEnFs/S2Ja
 7rKs1/zQCNVaZdViaj+buEGcBP8QQgHxCTFl8bDonLjLcGA+Of+KyRPJN0HJRhlz3SB3
 VQ1C/OsXKKgK0IBTGRCPh7M3LaTiUx5mZYlQ/MyZOFzZyE+yXpEgvtGpp751Vivukjhw
 6h7ttHLl+Q/YP/BUp+wWsQKms7UGTQ9TnLTvxRzMHF5Mwjom7quyQwpp0VhbkoiVfjg+ XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54axsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:46 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFp3V3011441; Mon, 29 Apr 2024 15:55:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j69q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGo034442;
 Mon, 29 Apr 2024 15:55:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-12; Mon, 29 Apr 2024 15:55:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 11/26] migration: vmstate_register at init time
Date: Mon, 29 Apr 2024 08:55:20 -0700
Message-Id: <1714406135-451286-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-ORIG-GUID: ohXr_sM7tsS6uc2XKKMImGShsoBvCqMc
X-Proofpoint-GUID: ohXr_sM7tsS6uc2XKKMImGShsoBvCqMc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Define vmstate_register_init to statically declare that a vmstate object
should be registered during qemu initialization, specifically, in the
call to vmstate_register_init_all.  This is needed to register objects
that are not Objects (and hence cannot use the DeviceClass vmsd hook),
without requiring that qemu call an object-specific initialization function.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h | 18 ++++++++++++++++++
 migration/savevm.c          | 32 ++++++++++++++++++++++++++++++++
 system/vl.c                 |  3 +++
 3 files changed, 53 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 3d71b34..8cb3d2b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1255,6 +1255,24 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
 }
 
 /**
+ * vmstate_register_init() - statically declare a VMSD to be registered when
+ * QEMU calls vmstate_register_init_all.  This is useful for registering
+ * objects that are not Objects (and hence cannot use the DeviceClass vmsd
+ * hook).
+ */
+#define vmstate_register_init(_obj, _id, _vmsd, _opaque)                    \
+static void __attribute__((constructor)) vmstate_register_ ## _vmsd(void)   \
+{                                                                           \
+    vmstate_register_init_add(_obj, _id, &_vmsd, _opaque);                  \
+}
+
+void vmstate_register_init_add(VMStateIf *obj, int instance_id,
+                               const VMStateDescription *vmsd, void *opaque);
+
+void vmstate_register_init_all(void);
+
+
+/**
  * vmstate_replace_hack_for_ppc() - ppc used to abuse vmstate_register
  *
  * Don't even think about using this function in new code.
diff --git a/migration/savevm.c b/migration/savevm.c
index cd2eabe..ec48da9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -957,6 +957,38 @@ err:
     return -1;
 }
 
+typedef struct VMStateInit {
+    VMStateIf *obj;
+    int instance_id;
+    const VMStateDescription *vmsd;
+    void *opaque;
+    QLIST_ENTRY(VMStateInit) next;
+} VMStateInit;
+
+static QLIST_HEAD(, VMStateInit) vmstate_inits;
+
+void vmstate_register_init_add(VMStateIf *obj, int instance_id,
+                               const VMStateDescription *vmsd, void *opaque)
+{
+    VMStateInit *v = g_new0(VMStateInit, 1);
+
+    v->obj = obj;
+    v->instance_id = instance_id;
+    v->vmsd = vmsd;
+    v->opaque = opaque;
+    QLIST_INSERT_HEAD(&vmstate_inits, v, next);
+}
+
+void vmstate_register_init_all(void)
+{
+    VMStateInit *v, *tmp;
+
+    QLIST_FOREACH_SAFE(v, &vmstate_inits, next, tmp) {
+        vmstate_register(v->obj, v->instance_id, v->vmsd, v->opaque);
+        QLIST_REMOVE(v, next);
+    }
+}
+
 void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
                         void *opaque)
 {
diff --git a/system/vl.c b/system/vl.c
index c644222..7797206 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -78,6 +78,7 @@
 #include "hw/i386/pc.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
+#include "migration/vmstate.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
 #include "hw/audio/soundhw.h"
@@ -3663,6 +3664,8 @@ void qemu_init(int argc, char **argv)
 
     qemu_create_machine(machine_opts_dict);
 
+    vmstate_register_init_all();
+
     suspend_mux_open();
 
     qemu_disable_default_devices();
-- 
1.8.3.1


