Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790DCCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umba8-0005TW-22; Thu, 14 Aug 2025 13:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba4-0005Ss-OY
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba0-0002pg-J9
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgE27020388;
 Thu, 14 Aug 2025 17:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=JgRIAMoCHuh6OPoNq+NuoU6FlbtY4XgJKfRrNefoGR4=; b=
 dzcB7OJudoAeaKal0GCPwXyQ38Ev0H12Vm6btZPoPtCAJWWLMmEb7ToP7eJsC+Jq
 C0MrdqGhXo0iYtOl4gIpPmrgW82vgoTSLkuUwIpsThFgGBZim3aFn9bhaERDyG9y
 mZEmO2OPjBSZGo+dvCt36cveXkpgJCcQNravdEkmy2FP5bN4zJAKhT5ubtU17oVq
 JR9vOBkgexK7AWACCGS6jVIgk/haowDBSQLUfrq5sS8dJOLa7rimCiL687zj/eKc
 XasuAXtXZKURcGPwNNAbyYD4tJ7oU9rXsf02UNPiUZfFy3izvnlw4hf4vNbO1ui2
 a2COi1dOM01NxXrjPexAZw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw452hcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EHEemW009858; Thu, 14 Aug 2025 17:17:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbs0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuC038225;
 Thu, 14 Aug 2025 17:17:28 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-4; Thu, 14 Aug 2025 17:17:28 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 3/9] oslib: qemu_clear_cloexec
Date: Thu, 14 Aug 2025 10:17:17 -0700
Message-Id: <1755191843-283480-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-ORIG-GUID: dceiOfFlFjEC_F95EDC2pLeWdAfB8kDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfXy+k58kRWSG8T
 7FIofaHTWQoCIyBurTn098xkgMRxHKTRe9PArTkvSNR3FZ0vMSMiNFE9sDZPoJIxl8LBVNVHf7D
 7T5MWdkn3G1PgqivXStvCg/Sg4ewSBLxRog82bQUgo/aYvTDo0RKBwNo5h+8GT9eDCC9ETKuctr
 BtF9g4QafdpSUahTv6uyJT97aXATWH17AABTFGIfFOP7biAL3tzhHUz8al/n9NysKGbCpXLBCR9
 mwX0HBSOZ8ObQ4JimIsf1V6XgN85Duc2ruDHCUx3lMfWAFQ2MtCg1rPiqULBDe4ULBtY0lLOr8h
 DKolLcO0FmM3NqdLPb2qywCI0tTlUET//fSdKqTzBrbUAHK6HQcC6MVXjOkGrk57kNBGxPSKUN+
 jrTMKU+HaO37c1YxMFawut9dxLmuE7TOxib+S1YrsdjGIqsKE7KfZAloLfwu88AfdFBWVJ4n
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689e1a2a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=eRAJs6dweEk5O_tl00MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: dceiOfFlFjEC_F95EDC2pLeWdAfB8kDU
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

Define qemu_clear_cloexec, analogous to qemu_set_cloexec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/qemu/osdep.h | 9 +++++++++
 util/oslib-posix.c   | 9 +++++++++
 util/oslib-win32.c   | 4 ++++
 3 files changed, 22 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96fe51b..30136ea 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -680,6 +680,15 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 
 void qemu_set_cloexec(int fd);
 
+/*
+ * Clear FD_CLOEXEC for a descriptor.
+ *
+ * The caller must guarantee that no other fork+exec's occur before the
+ * exec that is intended to inherit this descriptor, eg by suspending CPUs
+ * and blocking monitor commands.
+ */
+void qemu_clear_cloexec(int fd);
+
 /* Return a dynamically allocated directory path that is appropriate for storing
  * local state.
  *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4ff577e..4c04658 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -307,6 +307,15 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
     return ret;
 }
 
+void qemu_clear_cloexec(int fd)
+{
+    int f;
+    f = fcntl(fd, F_GETFD);
+    assert(f != -1);
+    f = fcntl(fd, F_SETFD, f & ~FD_CLOEXEC);
+    assert(f != -1);
+}
+
 char *
 qemu_get_local_state_dir(void)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b735163..843a901 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -222,6 +222,10 @@ void qemu_set_cloexec(int fd)
 {
 }
 
+void qemu_clear_cloexec(int fd)
+{
+}
+
 int qemu_get_thread_id(void)
 {
     return GetCurrentThreadId();
-- 
1.8.3.1


