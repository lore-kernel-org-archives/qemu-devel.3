Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D998FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yr9-0005Br-3q; Wed, 01 Oct 2025 11:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqo-0004ML-PY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqa-0006Pi-97
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMmut018716;
 Wed, 1 Oct 2025 15:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qLNHKUlUg3IKOiVVxtcSzwTwsfWTIOGy9gGV6FylCYI=; b=
 Xe58IJBcozD6ShLJrKhE1kWlIrWNQnIoaQcdXwC84TO3uIvrWVVjkoCIAe5y/QaD
 3ftu475gWFV1/zZlLCKOQuqGEITtA26bphlRQSAomLU4neuTGaeQESGqtRr75O5K
 +aFXzI8p8XNxRTTUrX7WQpO4YrvSHMsQxLj77Mb0FUEHntR309kHBUm00iRHqp33
 pFYUIje8EFwDLgmU8oj5hU+Sxpc0hK69Qty9hoVOKF8xzM6gVj9LCamwqRAmA/LO
 UcjpE124wY8j9NhBcfAFePnPsUtXKbbA2jjmcJFe2cdbeBqWM/5o9uQqLUgRABrM
 whKymxApFRAnq3ocWldm+A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmrfsmjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EmOSP023357; Wed, 1 Oct 2025 15:34:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:14 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqi014790;
 Wed, 1 Oct 2025 15:34:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-4; Wed, 01 Oct 2025 15:34:14 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 03/19] oslib: qemu_clear_cloexec
Date: Wed,  1 Oct 2025 08:33:55 -0700
Message-Id: <1759332851-370353-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-ORIG-GUID: hH2Qjavp1YUKxdnosUlgsZNnIlshtRYq
X-Proofpoint-GUID: hH2Qjavp1YUKxdnosUlgsZNnIlshtRYq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE3MCBTYWx0ZWRfX4rRk5uym4rkD
 IONYXwZy/bixpLJvhDucqMxOqYrW6B9a/4sfERmGmy0RNTgUQB+jyga1Xt2YEsgoNCmU0cu04J6
 DxIjvdm196oBbwuVwofrymBNOIzF8hDn0rRaP6TTUJpMbbxiciWUSs4PVzHym+1SP8MeSmtLejd
 4BK17KK+myngP1VrvLjnZ2uvmHa3LhKLXY2Wem6arwsziEDksRluQl+51ZZ5MUUWimR9lNEzujh
 ccu1McwvzWXeLG4pLv3Z3KdKKxU0lVX7UBDseuRr7PdRIUeTp+mLdjPua1Y65jOFM+he7NiU4Q0
 9Fk8JvKeiExMX0h9HMwpPAyA/2krjngCYuVrOZwND9TzQ6EN7P/ufeYRS6bwvskpbT96tTUmcVe
 uSujQ+Nw/VE8I51ZQPByjDRXgy4u2w==
X-Authority-Analysis: v=2.4 cv=VpMuwu2n c=1 sm=1 tr=0 ts=68dd49f8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=eRAJs6dweEk5O_tl00MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


