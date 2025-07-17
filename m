Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F808C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVZo-0000k9-D2; Thu, 17 Jul 2025 16:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW8-0008WI-LU
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW4-00008i-Mf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0i2r018938;
 Thu, 17 Jul 2025 18:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Yv7L4OwqL9MTFjfSdoAcXNtPgLe1md+/tBkeCxeUoZc=; b=
 WphManCyyzgWaOFQ8kjQ2iFhH7bAFBWQEgca/00ePTgrRau6JYpNevDJeFA8/rSZ
 R/0KyYUaA0ymOxiyJ0hGYwF4jV5p763JmRCddhwT7COVVITM07AFD7HbufT+Agur
 fYOm3fn8FdWipAvkpSsOBuKevxkgCyQRG9lWpDEv8EhmXEl7hrAmbHiH3nAtZzgq
 vWW0LBRoBnBKbn1chaMkJDSB485QbdRazWdl07rxHIQ3vQDDpar4ibkMNtSlPm1W
 qvJX3zORGOpRpiG3I+c2wWxYHQUkkXoMEFbK6E73xwrB5vt//j7b2yJfuxrwJniX
 ZfHU2iSz6s5gENkSYnjpnw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83ybb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HHgBow023735; Thu, 17 Jul 2025 18:39:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2tac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoip007425;
 Thu, 17 Jul 2025 18:39:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-5; Thu, 17 Jul 2025 18:39:31 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 4/8] cpr: delete all fds
Date: Thu, 17 Jul 2025 11:39:24 -0700
Message-Id: <1752777568-236368-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170165
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68794365 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=n655hgSsutws6UkWyQYA:9
X-Proofpoint-ORIG-GUID: t6huPCgt8nWRKANxwO7vM1ybTmNrAKU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX1LlgxG23QrDr
 B2d09INMNXAWJVBfQAjc7cwsBg8q546pX0Hu5mtF2ECXmsF4zSGNoyfa4MTx2+vh47pRy1DX+vF
 mLQ/C6maaIS2Uu1ImbuMatyHCVjrZNOOAsttk1sBdW4Ptif+W0myQDQJg0UrQLN9zzj2qO9R44Z
 A5IgfBC8QBEuJIhbxMMM/U2T1SnsmXcB0ZjL8Gxi9s5XRv8wvcYzrGlTUrE3V+bJkHLBKLDVVWl
 cJot4JUw1RBO0wtX5lGxNdoqkL5WXCKvXrsUW6NwPYzYH4lm86Z1aU5RJybWa2FMbRtCWycnfCE
 rqTSJlIZW1EDyjrJWn7VqxgoxE+9HUjcjVpe7OanDIKdh/Hb0qSFIyxJFk3QYsxxKDz49r/yYeQ
 JbA3iVr5p9aF7jJo3aNyTIWdVuG+PI/4O2ydmakVbf0sDhDEu4VT/kImTx6Nn/LhhMTSTKWL
X-Proofpoint-GUID: t6huPCgt8nWRKANxwO7vM1ybTmNrAKU8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add the cpr_delete_fd_all function to delete all fds associated with a
device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  1 +
 migration/cpr.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3fc19a7..0fa57dd 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -29,6 +29,7 @@ extern CprState cpr_state;
 
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
+void cpr_delete_fd_all(const char *name);
 int cpr_find_fd(const char *name, int id);
 void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0..e97be9d 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -83,6 +83,19 @@ void cpr_delete_fd(const char *name, int id)
     trace_cpr_delete_fd(name, id);
 }
 
+void cpr_delete_fd_all(const char *name)
+{
+    CprFd *elem, *next_elem;
+
+    QLIST_FOREACH_SAFE(elem, &cpr_state.fds, next, next_elem) {
+        if (!strcmp(elem->name, name)) {
+            QLIST_REMOVE(elem, next);
+            g_free(elem->name);
+            g_free(elem);
+        }
+    }
+}
+
 int cpr_find_fd(const char *name, int id)
 {
     CprFd *elem = find_fd(&cpr_state.fds, name, id);
-- 
1.8.3.1


