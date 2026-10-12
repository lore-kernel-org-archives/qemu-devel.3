Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5779ACA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu3-0005fL-4d; Mon, 12 Oct 2026 19:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0005e4-Gp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtx-0006F9-3j
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgjB32853744; Mon, 12 Oct 2026 23:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=UX2nu
 iT3ERVhqtmZpW8pGYIj5obLsF2HyY9cxzBHoUc=; b=OMv+7RmItZbfhdXEInUCu
 FIUVzl97Lo1hoWdFGIZWV9YKS2rItLzIi18R/F5tSrM1eEuTH+R1YriAPqzhFV6b
 P0Mn24HpT6VIdHbgi6PEDQK863R7xIRQDzsnHStKIpPQ1XQ6AuFXOZMBiGbJfkux
 6K2q5KitafHzDnfXPrdQirT3so3AdcLkBurcbwCNl3jX9ki3LwDMf29UAjWlmfQw
 fqxtJSsdra7cOoqZmeKdycvWgUvEIJY1i6pon/sm21xK8j6JW1gsWWizAuJYzRHQ
 qbp+afd9C4f0beFYXAfvAjWp6C1mqo2kBLB/hFTy4MMJmWiw7XnvNnNxcMSofl4s
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dcsb68p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpe9j015117; Mon, 12 Oct 2026 23:57:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:48 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHP025328;
 Mon, 12 Oct 2026 23:57:47 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-10; Mon, 12 Oct 2026 23:57:47 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 09/21] migration/cpr-luo: add LUO fd VMStateDescription
Date: Mon, 12 Oct 2026 23:56:05 +0000
Message-ID: <20261012235727.398133-10-dongli.zhang@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXy5sXKNk1/8dv
 4t0T9r6J68nu7S3bz2HdVsBadlaM2ZqIKuGKsdZMdRRCBx0myVhFY34LxbH/5jyF0HXpxtXjbZ0
 58ojfxQoPA9cOjxPqAjnncqVmj8T3AyAL1wIinBQmuqyLPEqyDpf
X-Proofpoint-GUID: U1SRU0PicPMgqoSQMYCW5UPBt3unnsT6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX1IqmxukuYrSL
 Cs5bYO7HLpqr7JOm1MpIjx6E5zgHd/mgl+za77Ed7LBLS/IRVuUARuDGTugLO4Xv0FqP2CCN347
 44Mp8aBPHo8Doy5IAHPKc6MKXFRyhRD46ueVxFO6YDNiNIZq7q2ytoUrr200X5XaRVeHLjgrc77
 wPtnja+ap341QjR6bwu3NwRQ0j1Ea9zTZDJaWcUvHyDBzh+lbK+U/FQsxvLU6j6EZVn0nnmdV3U
 uP+aQR/7CYEqFWGNQkyZhQE7VJ/WZ4Zt7JlKdni9FiQrAWsIBTtBvrvoGu4UnUHIRuq92OsN3sN
 nJYD2pws14w2SO6ywt2z/p2nSjiyM5/yZJZSmrZFYTE1YhNTV+nvl5GERY0Sl3HouZee7EZpPSc
 bYtHuXE9xo9KhhzCJ+8TEzu5vVlJcipbVsTKKW1RH8ZoNJ03fKusMNUkkKbF5kJp3k7TPrgCUJd
 d4qRF2xv+NQqn4SnW5ngFbuZca0OeIjP9sXBTiig=
X-Proofpoint-ORIG-GUID: U1SRU0PicPMgqoSQMYCW5UPBt3unnsT6
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6acd73fc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=tsAY0nOKkvl7n8IhwF8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of reusing vmstate_cpr_fd and vmstate_cpr_state, add a new cpr-luo
specific VMStateDescription for LUO file descriptors.

In this way, we won't need to worry about version and compatibility issues.

As only LUO file descriptors are migrated to the new instance, we don't
need to save or load CprFd->luo.

When cpr-exec or cpr-transfer is used, the original vmstate_cpr_fd is used.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h |  1 +
 migration/cpr.c         | 46 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 425f6ee956..3bfe91f10f 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -17,6 +17,7 @@
 #define QEMU_CPR_FILE_MAGIC     0x51435052
 #define QEMU_CPR_FILE_VERSION   0x00000001
 #define CPR_STATE "CprState"
+#define CPR_LUO_STATE "CprLuoState"
 
 typedef struct CprFd {
     char *name;
diff --git a/migration/cpr.c b/migration/cpr.c
index 9b6b85cedd..eaaca6d47d 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -41,6 +41,18 @@ static const VMStateDescription vmstate_cpr_fd = {
     }
 };
 
+static const VMStateDescription vmstate_cpr_luo_fd = {
+    .name = "cpr luo fd",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(namelen, CprFd),
+        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
+        VMSTATE_INT32(id, CprFd),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static guint cpr_fd_hash(gconstpointer v)
 {
     const CprFd *elem = v;
@@ -85,11 +97,16 @@ static int cpr_fd_pre_save(void *opaque)
     CprState *state = (CprState *)opaque;
     GHashTableIter iter;
     CprFd *elem;
+    MigMode mode = migrate_mode();
 
     QLIST_INIT(&state->fds);
 
     g_hash_table_iter_init(&iter, get_cpr_fds_hash());
     while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
+        if (mode == MIG_MODE_CPR_LUO && !elem->luo) {
+            continue;
+        }
+
         QLIST_INSERT_HEAD(&state->fds, elem, next);
     }
 
@@ -104,6 +121,10 @@ static int cpr_fd_post_load(void *opaque, int version_id)
     while ((elem = QLIST_FIRST(&state->fds))) {
         QLIST_REMOVE(elem, next);
 
+        if (cpr_get_incoming_mode() == MIG_MODE_CPR_LUO) {
+            elem->luo = true;
+        }
+
         /*
          * Preserve legacy QLIST lookup semantics if duplicate keys exist in
          * the incoming stream: the first matching entry wins.
@@ -214,6 +235,18 @@ bool cpr_walk_fd(cpr_walk_fd_cb cb)
     return true;
 }
 
+static const VMStateDescription vmstate_cpr_luo_state = {
+    .name = CPR_LUO_STATE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save = cpr_fd_pre_save,
+    .post_load = cpr_fd_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_luo_fd, CprFd, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*************************************************************************/
 static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
@@ -256,6 +289,15 @@ bool cpr_is_incoming(void)
     return incoming_mode != MIG_MODE_NONE;
 }
 
+static const VMStateDescription *cpr_state_vmsd(MigMode mode)
+{
+    if (mode == MIG_MODE_CPR_LUO) {
+        return &vmstate_cpr_luo_state;
+    }
+
+    return &vmstate_cpr_state;
+}
+
 bool cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     QEMUFile *f;
@@ -278,7 +320,7 @@ bool cpr_state_save(MigrationChannel *channel, Error **errp)
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    if (!vmstate_save_vmsd(f, &vmstate_cpr_state, &cpr_state, 0, errp)) {
+    if (!vmstate_save_vmsd(f, cpr_state_vmsd(mode), &cpr_state, 0, errp)) {
         qemu_fclose(f);
         return false;
     }
@@ -340,7 +382,7 @@ bool cpr_state_load(MigrationChannel *channel, Error **errp)
         return false;
     }
 
-    if (!vmstate_load_vmsd(f, &vmstate_cpr_state, &cpr_state, 1, errp)) {
+    if (!vmstate_load_vmsd(f, cpr_state_vmsd(mode), &cpr_state, 1, errp)) {
         qemu_fclose(f);
         return false;
     }
-- 
2.43.5


