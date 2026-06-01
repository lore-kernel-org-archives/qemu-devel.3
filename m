Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B670CCD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAap-0006g8-HN; Mon, 01 Jun 2026 17:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAam-0006dw-KV
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAak-0003sV-9Q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651EF9Eh1183044; Mon, 1 Jun 2026 21:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PwPqa3NanoWUvSmXd
 bjqNA+jYJ9Yb+pXSz/Q4rtwMVI=; b=kxLPTTAb3WoEdJoQWMlKs7P6dpyVn5ueY
 XlP4Wud/rByFz25f/lDXNVFZ5q8dEiIgI7Q8lJJZGpXg0xjb6j3EmFUPZXdNhHPx
 lt3Xrtha4s9A11iotYJFCErnpvjKkRcTCZUfTYeRKq8BIGLyZ8BmmUaYvvoOHJpG
 va6o9/GNRZpQRmUezcnQKhbe5K+Pu6HNlySA0Lv2K972mNXcw36/8Z0z/gEFsL4Y
 vD+fJ2+vJzcA42H2RVTdlKCcX3jC/rwi4u81gr1dIgmIx0IPEqVixbFRfncjFvO+
 Lt5O2Fd9YQ9aeLZeNXw/9bGEJRngP+OXJtj6TxzkVRcsTWW8lgSKw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd434hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsFgK020880;
 Mon, 1 Jun 2026 21:54:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwy7ycd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsYJh34079440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8083358054;
 Mon,  1 Jun 2026 21:54:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086B15805A;
 Mon,  1 Jun 2026 21:54:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:33 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 14/16] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Mon,  1 Jun 2026 17:54:07 -0400
Message-ID: <20260601215410.517009-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX0T8538YbJoD9
 jxWbTuWfH1m7UM+ZI31C5zFc3SWn1viqfL13wroPYoGnWfrnKNvmjfE2lQ9kKY5LE5xvke8UG0X
 /ghjbokA6shRJU3jB68XkHXUBiCUbOvGSKvtnT7iyabqBTQA8xtK89VTjkOZoxWYm2cZvJ9HcbI
 3qJsvU2V03Bxe+wP3pEabgArOxHDqtzpV/BjeoqAsIfHVrN6dVhF8y8SYZjxReIZl+mIwM2cD6p
 ADtM0CYgjetXK8P0YGEk5vLu4nr6LGici5INOISR0cL1eqa2nL4q3J62CRGDJCSH5okFPe4/cnn
 hM3pJv52WfksR7u8QV5N0IZCdioGFFhPBRVrU0g8xHvb0u8YVGFKJpLI5/JB7DFL2NEi02ynsDA
 tpq206UCO4UN+/Tm3ehZqZfBfKwjyTBZviHjh4Fn4FE/r1+bqNEbKnMM8BCcEFwsbRKHKpU+/Zc
 UOZwHPLEmQbqUjItEPA==
X-Proofpoint-GUID: Dym2uQM_5WdQtuJ4JrI46lx1C_9X__tG
X-Proofpoint-ORIG-GUID: Dym2uQM_5WdQtuJ4JrI46lx1C_9X__tG
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1dff9c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=PccO3vSE9Jhpd1bwbKgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Arun Menon <armenon@redhat.com>

- Add subsection in VMState for TPM CRB with the newly introduced
  command and response buffer GByteArrays, along with a needed callback,
  so that newer QEMU only sends the buffers if it is necessary.
- Implement a migration blocker to prevent migration of the VM if the
  user manually enables chunking capability, cap-chunk, but the machine
  type does not support it, using a new hw_compat property called
  allow_chunk_migration.
- Add a post_load_errp hook so that during a migration, the buffers are
  validated before destination VM is started.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260506075813.120781-7-armenon@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/machine.c |  1 +
 hw/tpm/tpm_crb.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 00eb3432a7..17970b78b6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
+    { "tpm-crb", "x-allow-chunk-migration", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index f85df08185..54fa2042b5 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
+#include "migration/blocker.h"
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
 #include "system/reset.h"
@@ -50,6 +51,8 @@ struct CRBState {
     TPMPPI ppi;
 
     bool cap_chunk;
+    bool allow_chunk_migration;
+    Error *migration_blocker;
 };
 typedef struct CRBState CRBState;
 
@@ -349,18 +352,68 @@ static int tpm_crb_pre_save(void *opaque)
     return 0;
 }
 
+static bool tpm_crb_chunk_needed(void *opaque)
+{
+    CRBState *s = opaque;
+
+    if (!s->allow_chunk_migration) {
+        return false;
+    }
+
+    return ((s->command_buffer && s->command_buffer->len > 0) ||
+            (s->response_buffer && s->response_buffer->len > 0));
+}
+
+static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
+{
+    CRBState *s = opaque;
+
+    /*
+     * The external TPM emulator (example swtpm) determines the backend
+     * buffer capacity (s->be_buffer_size). This check ensures that if we
+     * migrate from a source with a PQC-enabled emulator that supports
+     * larger buffers to a destination with a non-PQC emulator, the
+     * migrated data does not exceed the destination's capacity.
+     */
+    if (s->response_buffer->len > s->be_buffer_size ||
+        s->command_buffer->len > s->be_buffer_size) {
+        error_setg(errp, "tpm-crb: Buffer sizes exceed backend capacity");
+        return false;
+    }
+    return true;
+}
+
+static const VMStateDescription vmstate_tpm_crb_chunk = {
+    .name = "tpm-crb/chunk",
+    .version_id = 0,
+    .needed = tpm_crb_chunk_needed,
+    .post_load_errp = tpm_crb_chunk_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
+        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
+        VMSTATE_UINT32(response_offset, CRBState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_crb = {
     .name = "tpm-crb",
     .pre_save = tpm_crb_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_tpm_crb_chunk,
+        NULL,
     }
 };
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
+    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
+                     allow_chunk_migration, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -415,6 +468,7 @@ static void tpm_crb_reset(void *dev)
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
+    int ret;
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -424,6 +478,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+    if (s->cap_chunk && !s->allow_chunk_migration) {
+        error_setg(&s->migration_blocker,
+                   "The tpm-crb device does not support chunk migration with "
+                   "machine version less than 11.1");
+        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
+        if (ret < 0) {
+            return;
+        }
+    }
 
     memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
         "tpm-crb-mmio", sizeof(s->regs));
@@ -454,6 +517,10 @@ static void tpm_crb_unrealize(DeviceState *dev)
 
     g_clear_pointer(&s->command_buffer, g_byte_array_unref);
     g_clear_pointer(&s->response_buffer, g_byte_array_unref);
+
+    if (s->migration_blocker) {
+        migrate_del_blocker(&s->migration_blocker);
+    }
 }
 
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
-- 
2.54.0


