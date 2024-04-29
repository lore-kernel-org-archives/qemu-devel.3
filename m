Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CE5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMF-0004X3-J5; Mon, 29 Apr 2024 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM6-0004TS-5l
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TM0-0005De-9K
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:55:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmlHi021730; Mon, 29 Apr 2024 15:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=APXR9kXyXmqqAjJjI1A0Ctj4zR+Lv7xd+zkmXLq6AjI=;
 b=XA4RY79X18QR8yX0r0vv1vY4JGRhMXR0CqzLsbktzzcYSIMGtJeBOGsMmNDtiEkhj/kH
 1zt3sleRsHAB8aJNzVbwsG6lbKXOpGnycFEe5oRw+VvLrvA0rqHPOYXKHIpno8B6n2hT
 +t/RaRaelO1tFo5z9ZlZW34WsRZrXqnU0xScYTM8MH7+zFQikssKkY6evv0u+nfI+JQa
 pt6eA17GaTZ69RzuGsiRF0Nm1S9bAOmWfqOOs+Fp+qP9w/14oiBGBnKtTWPK+aDPKVA6
 Z59cowPP1eQeblIn+mJRD247R234GXlZ0LQ9xavHxDx5lzSma/djyu0axr/4oJ9huLOs cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54axse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:38 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TEgWMX011336; Mon, 29 Apr 2024 15:55:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j619-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaGU034442;
 Mon, 29 Apr 2024 15:55:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-2; Mon, 29 Apr 2024 15:55:36 +0000
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
Subject: [PATCH V1 01/26] oslib: qemu_clear_cloexec
Date: Mon, 29 Apr 2024 08:55:10 -0700
Message-Id: <1714406135-451286-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-ORIG-GUID: eg93MLnPdshm7l52FbHOTNVga8e6GdBq
X-Proofpoint-GUID: eg93MLnPdshm7l52FbHOTNVga8e6GdBq
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

Define qemu_clear_cloexec, analogous to qemu_set_cloexec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/osdep.h | 9 +++++++++
 util/oslib-posix.c   | 9 +++++++++
 util/oslib-win32.c   | 4 ++++
 3 files changed, 22 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c7053cd..b58f312 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -660,6 +660,15 @@ ssize_t qemu_write_full(int fd, const void *buf, size_t count)
 
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
index e764416..614c3e5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -272,6 +272,15 @@ int qemu_socketpair(int domain, int type, int protocol, int sv[2])
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
index b623830..c3e969a 100644
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


