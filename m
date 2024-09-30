Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA9CDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGf-0007OE-9r; Mon, 30 Sep 2024 15:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGd-0007Hv-Gz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGb-00022E-Mz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:11 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuY3v012948;
 Mon, 30 Sep 2024 19:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=ebp9rJDFJtzKf5X44bz9xoGS+p+nfvIXI79Rl9Jsp8w=; b=
 K4PPDNQVQEtgxI9kiqv6Pv93lE+M4pLBSS40lUvPJSpuEjyYQVzBJFxgyHcrpuyb
 VIcboQi/BMPMhf8l+G4+TzxcaxBpOtHgF1K//lACH2vYuQWrdD8AvM+ubNuUWveu
 we0s3ZATzSDQtEh+JaWcvW1c3QvFCLboaZwojHehqI/nbegdDS62dspSk7dzgrwl
 frna2JvoJXFyTYybphG79dFVFi+d3KrVBfTzctBrixMPtlcuHldBnl9l6yl3o6pD
 zsd3mmSvNv+BXHy7wfe78b6DEIlFjGgTYgPoncKjfEHAJWmirWe/mWd49ZPxtEgH
 6TJ88dJCcwBhQqfxTFzPag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9mgbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UITJbb012602; Mon, 30 Sep 2024 19:41:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868tyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepV0028204;
 Mon, 30 Sep 2024 19:41:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-9; Mon, 30 Sep 2024 19:41:02 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 08/13] migration: VMSTATE_FD
Date: Mon, 30 Sep 2024 12:40:39 -0700
Message-Id: <1727725244-105198-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-ORIG-GUID: m2kq_DFpAm4-1Mse0OiMlSQBw5rPn1mX
X-Proofpoint-GUID: m2kq_DFpAm4-1Mse0OiMlSQBw5rPn1mX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_LACKS_WORDS=1.955 autolearn=no autolearn_force=no
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

Define VMSTATE_FD for declaring a file descriptor field in a
VMStateDescription.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/vmstate.h |  9 +++++++++
 migration/vmstate-types.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f313f2f..a1dfab4 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -230,6 +230,7 @@ extern const VMStateInfo vmstate_info_uint8;
 extern const VMStateInfo vmstate_info_uint16;
 extern const VMStateInfo vmstate_info_uint32;
 extern const VMStateInfo vmstate_info_uint64;
+extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
 #define VMS_NULLPTR_MARKER (0x30U) /* '0' */
@@ -902,6 +903,9 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
 
+#define VMSTATE_FD_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_fd, int32_t)
+
 #ifdef CONFIG_LINUX
 
 #define VMSTATE_U8_V(_f, _s, _v)                                   \
@@ -936,6 +940,9 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#define VMSTATE_FD(_f, _s)                                            \
+    VMSTATE_FD_V(_f, _s, 0)
+
 #ifdef CONFIG_LINUX
 
 #define VMSTATE_U8(_f, _s)                                         \
@@ -1009,6 +1016,8 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_UINT64_TEST(_f, _s, _t)                                  \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_uint64, uint64_t)
 
+#define VMSTATE_FD_TEST(_f, _s, _t)                                            \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_fd, int32_t)
 
 #define VMSTATE_TIMER_PTR_TEST(_f, _s, _test)                             \
     VMSTATE_POINTER_TEST(_f, _s, _test, vmstate_info_timer, QEMUTimer *)
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e83bfcc..6e45a4a 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -314,6 +314,38 @@ const VMStateInfo vmstate_info_uint64 = {
     .put  = put_uint64,
 };
 
+/* File descriptor communicated via SCM_RIGHTS */
+
+static int get_fd(QEMUFile *f, void *pv, size_t size,
+                  const VMStateField *field)
+{
+    int32_t *v = pv;
+    qemu_get_sbe32s(f, v);
+    if (*v < 0) {
+        return 0;
+    }
+    *v = qemu_file_get_fd(f);
+    return 0;
+}
+
+static int put_fd(QEMUFile *f, void *pv, size_t size,
+                  const VMStateField *field, JSONWriter *vmdesc)
+{
+    int32_t *v = pv;
+
+    qemu_put_sbe32s(f, v);
+    if (*v < 0) {
+        return 0;
+    }
+    return qemu_file_put_fd(f, *v);
+}
+
+const VMStateInfo vmstate_info_fd = {
+    .name = "fd",
+    .get  = get_fd,
+    .put  = put_fd,
+};
+
 static int get_nullptr(QEMUFile *f, void *pv, size_t size,
                        const VMStateField *field)
 
-- 
1.8.3.1


