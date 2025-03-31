Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA3DC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFiK-0007Kb-6P; Mon, 31 Mar 2025 10:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFht-0007HM-Hg; Mon, 31 Mar 2025 10:01:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhp-00030v-Sz; Mon, 31 Mar 2025 10:01:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VCSWqA027981;
 Mon, 31 Mar 2025 14:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xUsQByUUEazXMjWzd
 /z/mqEsKquik4uF9QG5VN/snzQ=; b=f5jdFDVIuGvPLVh4EzUo2RZ0Cb9GbO0+s
 qs+oQZQcIG02fDoWZybRSWZNxH3D3U5MSD2iufvPKg27m9EBEG+B30zOwHIDmtAA
 //NXQM6pF31vK0ZTBi7f4rlQdLamf5wUlg+iW0Tk9zyRSKuUBYQAMJT2mjGgZpnb
 O5jC+PBfZgiBUOsK4u/DU2qlHSvaVNpBLw1sLj/x1jWwNicgpja+MgYfPOfNb77k
 uinYL8hbka4j8CymTrQRJLbAQpzXPiGaFjlXg9WFgdVlmiunx32NkNqNUPbbyA/4
 oWqoawl2BYbkFawfoLDmdtCBgMf2nrH3EpMSmRvYjuhm874XGGKKg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qu328ewc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VBNXG0005421;
 Mon, 31 Mar 2025 14:01:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww25r94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52VE1VJF12058900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 14:01:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44B3E2004B;
 Mon, 31 Mar 2025 14:01:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23CEF20043;
 Mon, 31 Mar 2025 14:01:31 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Mar 2025 14:01:31 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v3 3/4] hw/s390x: support migration of CPI data
Date: Mon, 31 Mar 2025 16:00:40 +0200
Message-ID: <20250331140041.3133621-4-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250331140041.3133621-1-shalini@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W0KXMKCmGOVCEnQh0cKvE3lMzQlzgpEe
X-Proofpoint-ORIG-GUID: W0KXMKCmGOVCEnQh0cKvE3lMzQlzgpEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Register Control-Program Identification data with the live
migration infrastructure.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 hw/s390x/sclpcpi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 969c15e43d..0b1b5293ea 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -62,6 +62,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
 #include "qapi/qapi-visit-machine.h"
+#include "migration/vmstate.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -133,12 +134,38 @@ static void get_control_program_id(Object *obj, Visitor *v,
     visit_type_S390ControlProgramId(v, name, &cpi, errp);
 }
 
+static const VMStateDescription vmstate_control_program_id = {
+    .name = "s390_control_program_id",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
+        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
+        VMSTATE_UINT64(system_level, ControlProgramId),
+        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
+        VMSTATE_UINT64(timestamp, ControlProgramId),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sclpcpi = {
+    .name = "s390_sclpcpi",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(cpi, SCLPEvent, 0, vmstate_control_program_id,
+                       ControlProgramId),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void cpi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
 
     dc->user_creatable = false;
+    dc->vmsd =  &vmstate_sclpcpi;
 
     k->can_handle_event = can_handle_event;
     k->get_send_mask = send_mask;
-- 
2.47.0


