Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A013CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu9-0005ip-39; Mon, 12 Oct 2026 19:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu1-0005en-Ro
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0006Fx-0X
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgGZQ2685917; Mon, 12 Oct 2026 23:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Q/WNW
 xAWfn5RfBiI1OuDlUw6/QBloRRA+0bNXR2Ravk=; b=gO0SfbkOUQEzUSbDGPx9E
 YSxPfKVD2wAUclROIk/gVaIFDvJIZaGLWYGDIpyp4b93xF/R943HomcI1z8f6xwO
 aZMOHaqapMCjLqLU5MgmhdE1V+rcg1pRTO7/YS7sdZBm+mBczhQDGssnAC3KKLOj
 auYOTlr9CJJM+MwkiEq9EdDMrz6jBy/jC4ets3tMGogPE434D9Ujy8L3xvA/FGwC
 jWMlpLwx8oaHU46HwkskwiBpzIszvZ8TeQfNkecgn+wy8HzP/TdjbKjZzCn1jl9v
 SaGGckLcs5/+q1k87H0FU0cPs9Q2e5wM7x5LR5KXsrvOzY1/HO9cxN1gTpiNQP1n
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwtb596-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpdl5015063; Mon, 12 Oct 2026 23:57:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:50 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHX025328;
 Mon, 12 Oct 2026 23:57:49 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-14; Mon, 12 Oct 2026 23:57:49 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 13/21] migration/cpr: add more arguments for cpr_walk_fd()
Date: Mon, 12 Oct 2026 23:56:09 +0000
Message-ID: <20261012235727.398133-14-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX1TrsG/d3Q+Dy
 zCbv2aPlbD9yTujqOZ2Wl+154ERh0++Z6cb+78BDXepFTj4WT42RL7zbhT9lRQlAobNqxXfcVpk
 hIKMKclJGTWOEHFrh2/N+cAJza42Ei4ZoylnYSkh+cVpkVoXscBsM2IDB6LraNZVqBoPADZ1qvY
 NLfUXY7E2d5NNaXCAzHGMRfTQXCCsFwmcXYXlGoK2WkWWQvSNAQDqdFEJJ45xm0L8cs3J+Ofdot
 P7ZgkW6HHK3PupU9UC0ISQvlgM4w3snx9mkAXwbbl+XEc4dVVMzIfhRPAA6oH+4pjnU5NVYmEBF
 IwOYF8NubDrGbIeDfCO0NW3K6zpSamjkALeV+Q2DnlIgvgz4DJdUCf7JMsRId/nn7iOVEv1Un/Y
 Y6AOBJ3RvFCSc//OU5lr6s4h8hxMJaf6WfqEKk4rFvdGrWmy4vT6U9qZWPW5DnvlEgitet8AfIG
 Eo78MDEzkN1YASqU6b6qD/aR4++ZREwAiPQXWoIg=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acd73ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=a0vYn-nyonuW8HCG9-gA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12107
X-Proofpoint-ORIG-GUID: J56M05EUMBL8mEwpzUJxRj4O0KxZT9TF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX7CbQ+B/xYbek
 /FM4/QK4Ddg3r8TwQHH3jMV/sLyPhogeiiLqGarN/HhfYNIUe6m32W+KKKhJgfQZUx1Y1nUDser
 IIBLyeOUpo2zZjfl9FyDJt4tmjbXsQLcHK0D7c5SgaU7IzWwe1B/
X-Proofpoint-GUID: J56M05EUMBL8mEwpzUJxRj4O0KxZT9TF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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

cpr-luo requires walking through each LUO-supported fd to preserve it.
Unlike cpr-exec or cpr-transfer, which only require the fd value, cpr-luo
requires additional information, such as a token, to preserve an fd.

In addition, we may want to return more values, such as a retrieved fd
based on a session fd and token, and pass errp when an error occurs.

Therefore, rework cpr_walk_fd() by adding more arguments for
flexibility.

Remove the assertion on elem->fd, since cpr-luo does not save or load the
fd itself, only its name, ID, and token.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h |  4 ++--
 migration/cpr-exec.c    | 12 ++++++------
 migration/cpr.c         |  5 ++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 4897d302f1..775f584368 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -49,8 +49,8 @@ void cpr_resave_fd(const char *name, int id, int fd);
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
                 Error **errp);
 
-typedef bool (*cpr_walk_fd_cb)(int fd);
-bool cpr_walk_fd(cpr_walk_fd_cb cb);
+typedef bool (*cpr_walk_fd_cb)(CprFd *fd, Error **errp);
+bool cpr_walk_fd(cpr_walk_fd_cb cb, Error **errp);
 
 MigMode cpr_get_incoming_mode(void);
 void cpr_set_incoming_mode(MigMode mode);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index b31ec3e59f..06cbced7e0 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -94,26 +94,26 @@ QEMUFile *cpr_exec_input(Error **errp)
     return cpr_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
 }
 
-static bool preserve_fd(int fd)
+static bool preserve_fd(CprFd *elem, Error **errp)
 {
-    qemu_clear_cloexec(fd);
+    qemu_clear_cloexec(elem->fd);
     return true;
 }
 
-static bool unpreserve_fd(int fd)
+static bool unpreserve_fd(CprFd *elem, Error **errp)
 {
-    qemu_set_cloexec(fd);
+    qemu_set_cloexec(elem->fd);
     return true;
 }
 
 static void cpr_exec_preserve_fds(void)
 {
-    cpr_walk_fd(preserve_fd);
+    cpr_walk_fd(preserve_fd, NULL);
 }
 
 void cpr_exec_unpreserve_fds(void)
 {
-    cpr_walk_fd(unpreserve_fd);
+    cpr_walk_fd(unpreserve_fd, NULL);
 }
 
 static void cpr_exec_cb(void *opaque)
diff --git a/migration/cpr.c b/migration/cpr.c
index 2253fddb42..bc4d1e979d 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -230,15 +230,14 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
     return fd;
 }
 
-bool cpr_walk_fd(cpr_walk_fd_cb cb)
+bool cpr_walk_fd(cpr_walk_fd_cb cb, Error **errp)
 {
     GHashTableIter iter;
     CprFd *elem;
 
     g_hash_table_iter_init(&iter, get_cpr_fds_hash());
     while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
-        g_assert(elem->fd >= 0);
-        if (!cb(elem->fd)) {
+        if (!cb(elem, errp)) {
             return false;
         }
     }
-- 
2.43.5


