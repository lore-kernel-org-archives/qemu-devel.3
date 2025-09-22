Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28B0CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvX-0000Ps-T5; Mon, 22 Sep 2025 09:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvW-0000Ph-P4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:49:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvT-0001uF-T3
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:49:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NMAE006534;
 Mon, 22 Sep 2025 13:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qLNHKUlUg3IKOiVVxtcSzwTwsfWTIOGy9gGV6FylCYI=; b=
 Ce+Xb1ytsKiNrnfhIi0Rg+1ray+YUXIlT8Cg35xaZQhqEA4S8RDIEj8tLQwUIvMv
 YWgXhX1/SLhrg+y3YQm4Fd/nkaYDQXM0RMt14y+C/XUNI/Z5n3eTVjxv/xh3e0pj
 hW39eyMZKOeP22DMyIXHMEfslHA2ZxGIAMq4u7NbDT6bU9LYErW22vghA+oJExLD
 z32naFnk8aMIXUymeBO+98XQDtkU+YA5e8SrxvfNab5T7JLkdDDjfxX9tnnfu1W2
 stUgH9darr5DpT7Y7iccTNbAPsTmNt5J7xP6omVgbi/km03aWSW7akgiqJDqc6Gu
 IHElx2RGQh3PQq6XEeeEOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvttfmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MC2Hng034336; Mon, 22 Sep 2025 13:49:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhan9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWH004351;
 Mon, 22 Sep 2025 13:49:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-4; Mon, 22 Sep 2025 13:49:51 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 3/8] oslib: qemu_clear_cloexec
Date: Mon, 22 Sep 2025 06:49:40 -0700
Message-Id: <1758548985-354793-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8hN8TxdVL8e1
 nT6awQCEDNAmy/Y7MxhCAI2MZDVMs2iZ+jaAXL77F3QOYLocD0f4X2f9jM67qgxcHURoFdOvsKu
 NSCskU8JJV88IiD6MdAEdWgWiyaFk3cV/OLJLhIk4T8/KtLKqqqmuT7yjmShfJ0JFq6cPeCL5mr
 0X4dMltJU5aFbI8ko9D9p3hVEQdiyaodah0gvyqkhPS0GWNe74/R0O6bbUjHCmw4OzbGUmF+zjR
 E1Ego7FtgeysxdnrJIJGhSq12LI5gM+BNG8M28TWQ6Z7EqSFLp4OUyId27g/IHSL8lpNehxSqKm
 2NfPbO3YZjTw6KPfe0EKCTHnGkqRkFJhNat6U4yCIDxkF5kmXRBIpsbUclQwiRNn7uFGpxO25Dq
 6WdyXnGH4E+MyGF4rjcAqMyFSLlrYw==
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d15401 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=eRAJs6dweEk5O_tl00MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: OTB-cUUrGNnIQakcpuSLp0Y6WbVzMZeI
X-Proofpoint-ORIG-GUID: OTB-cUUrGNnIQakcpuSLp0Y6WbVzMZeI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index be3460b..8dac4ed 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -688,6 +688,15 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 
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


