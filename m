Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E544C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 16:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMV-0004oN-4s; Mon, 29 Apr 2024 11:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMH-0004Y1-Vi
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMF-0005FB-Ux
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmlZq021746; Mon, 29 Apr 2024 15:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=mfUEBur7xmKrlLkLi6qOQJ8fPpHhzHrrtYVn+a6Puyk=;
 b=i1ifYD+4Amn7wTHZUK7DSc8ql/ht70BhjC1LRoGFGM9qjco5vJOIkXW6ClJZ3SoFDpYK
 hPQUUqr1dwA/1WS1J+7ur6OF9/hY+uFVPSGEWnU2aS1jh5BAzvpl27saWew6+23UjuXF
 pawTTRZQudhu2L0Ftr1B5ucK0xzjEAV3LSv2Dm1AsNk+EHXqwqmDTbNJ3PtUKoEegmbE
 bjob9sODzDM82woWxubH+DKB+Qya5FPtA8VxBT+QnanCHRCJOlH4rZItdpJ5ImyCvvm6
 +TFRJTX9ukQGpA1h/VJi49idWxqOqoImL3LiQAAmu7s4+2GoJU8IAZuWKLuIP0egFKMs IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54axsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:43 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFGqtP011343; Mon, 29 Apr 2024 15:55:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j66j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGi034442;
 Mon, 29 Apr 2024 15:55:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-9; Mon, 29 Apr 2024 15:55:41 +0000
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
Subject: [PATCH V1 08/26] migration: vmstate_info_void_ptr
Date: Mon, 29 Apr 2024 08:55:17 -0700
Message-Id: <1714406135-451286-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: DVn4SmJXNGnbMp5mluxbY-_8LL3x95ta
X-Proofpoint-GUID: DVn4SmJXNGnbMp5mluxbY-_8LL3x95ta
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

Define VMSTATE_VOID_PTR so the value of a pointer (but not its target)
can be saved in the migration stream.  This will be needed for CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h | 15 +++++++++++++++
 migration/vmstate-types.c   | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a39c0e6..bb885d9 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -236,6 +236,7 @@ extern const VMStateInfo vmstate_info_uint8;
 extern const VMStateInfo vmstate_info_uint16;
 extern const VMStateInfo vmstate_info_uint32;
 extern const VMStateInfo vmstate_info_uint64;
+extern const VMStateInfo vmstate_info_void_ptr;
 
 /** Put this in the stream when migrating a null pointer.*/
 #define VMS_NULLPTR_MARKER (0x30U) /* '0' */
@@ -326,6 +327,17 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset       = vmstate_offset_value(_state, _field, _type),     \
 }
 
+#define VMSTATE_SINGLE_TEST_NO_CHECK(_field, _state, _test,          \
+                                     _version, _info, _type) {       \
+    .name         = (stringify(_field)),                             \
+    .version_id   = (_version),                                      \
+    .field_exists = (_test),                                         \
+    .size         = sizeof(_type),                                   \
+    .info         = &(_info),                                        \
+    .flags        = VMS_SINGLE,                                      \
+    .offset       = offsetof(_state, _field)                         \
+}
+
 #define VMSTATE_SINGLE_FULL(_field, _state, _test, _version, _info,  \
                             _type, _err_hint) {                      \
     .name         = (stringify(_field)),                             \
@@ -952,6 +964,9 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#define VMSTATE_VOID_PTR(_f, _s)                                      \
+    VMSTATE_SINGLE_TEST_NO_CHECK(_f, _s, NULL, 0, vmstate_info_void_ptr, void *)
+
 #ifdef CONFIG_LINUX
 
 #define VMSTATE_U8(_f, _s)                                         \
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e83bfcc..097ecad 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -314,6 +314,30 @@ const VMStateInfo vmstate_info_uint64 = {
     .put  = put_uint64,
 };
 
+/* 64 bit pointer */
+
+static int get_void_ptr(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field)
+{
+    void **v = pv;
+    qemu_get_be64s(f, (uint64_t *)v);
+    return 0;
+}
+
+static int put_void_ptr(QEMUFile *f, void *pv, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc)
+{
+    void **v = pv;
+    qemu_put_be64s(f, (uint64_t *)v);
+    return 0;
+}
+
+const VMStateInfo vmstate_info_void_ptr = {
+    .name = "void_ptr",
+    .get  = get_void_ptr,
+    .put  = put_void_ptr,
+};
+
 static int get_nullptr(QEMUFile *f, void *pv, size_t size,
                        const VMStateField *field)
 
-- 
1.8.3.1


