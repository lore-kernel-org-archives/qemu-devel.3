Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A6CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu0-0005e2-47; Mon, 12 Oct 2026 19:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtz-0005cu-4v
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtw-0006Ew-H0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:54 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgp8h335869; Mon, 12 Oct 2026 23:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=iqqAi
 qOggl+FdokUW4MvN0/Ddwp2nsKGVlE7PbY+Frc=; b=lysj8kOcGqbgkIo94XRR8
 X6ToQpKCqirIOKATSi9/uWzw3wwYxxv7e9Vllnmwj+7RF5BUmJcwrWp17brdkTob
 CwB0d+ZUwbZ6lYHPGBa6w49GMvwvXp14otSKFnNRfFzAx0KwBQxbU1ExhUnDehpW
 aV+xtPpwNnhZ0LQ3LssHzu5jqR5Z4WRU9+PPyc7YVkfj/pLlunHU3m6XnGUdnE+3
 bWRCT09yGPalT1KBBoeva77vCHoqbaX+WqBL0jr12/6apfvf1LCRZaPOFNO6Zliv
 2kBc+pYqMxPyvAB5WoS5gXbup6WnQISx+YEkG1KyI/NvNb5xfHMK8AJ3P0227g9n
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dddu7t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeFM015082; Mon, 12 Oct 2026 23:57:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuht4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:47 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHN025328;
 Mon, 12 Oct 2026 23:57:46 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-9; Mon, 12 Oct 2026 23:57:46 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 08/21] migration/cpr-luo: track LUO fds
Date: Mon, 12 Oct 2026 23:56:04 +0000
Message-ID: <20261012235727.398133-9-dongli.zhang@oracle.com>
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
X-Proofpoint-GUID: dsuToRXu0Vr7ALMmjpEmc9dJFjY74pxU
X-Proofpoint-ORIG-GUID: dsuToRXu0Vr7ALMmjpEmc9dJFjY74pxU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXzqRKISyFd345
 wFiDT59XBs7kTYtAFvhcto3oe9E4asM3Bu8Q3u9g6qm38rB+1iv8rKgv8o151+KHghcS4Fp7m6H
 2kxqrSKrQRdmx70tgbv/A5ogJakc5TkuzK2M2k1LeqxzbfjbJc+6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX6hjQGHxsHIDp
 RpvKMdnRLOm2zlmfQ5qCCHGVROgNB8lLIkFRuqetfOQbIs42/cBuThONXU0KEJCq7QREMrfzS81
 u4+CE9L5CeJ9VXoAnunSu7v9HjFlhfj5fvQodytXixvYS6lwjJo1brHh4z4m64cMxY3BCT/35BT
 w5kKKIHl12rZB7kbNXfR1dQ1o5PoQUAWgjUfIh6DnuQ70JQqt5peaM6vY4RG4S06yb5+2NZ8L0Q
 gFwVw2ZoxLsnWn9EkV54fMCUV3Ry5+7EvlmxBjNhbaUe2pKxtolqYXHdChB1cydyLaE7IuSKG+t
 xyb6a7ii8avQ9o73iV/J2dzCeYz4x2JxN2EcHoPzNLgOevTj+maoRtVtC0zuFvr03xYf3pBWHnL
 z6DXPvQ9wfzDs0nJEdTCSm9XeOb4cSnDHYgOtyBltd5HGOxvEcmZFiAvNXcteIdfa5RUgonI9ag
 6tJh11beGFJvwRkx13VQu46UECMFFUpfCz28UZ8c=
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6acd73fc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=5oX6RG7t2f6SuAMBXUgA:9
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

Track whether saved CPR file descriptors can be used for LUO. Currently,
only RAMBlock fds (RAM or device/firmware related memory) are used for LUO.

To find the locations to mark a CprFd as LUO, I simply searched for all
direct and indirect callers of cpr_save_fd(). Most of them are for VFIO
and can be ignored.

Another option is to introduce additional argument to existing
cpr_save_fd(). Just add additional function for simplicity.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 backends/hostmem-memfd.c | 1 +
 backends/hostmem-shm.c   | 1 +
 include/migration/cpr.h  | 2 ++
 migration/cpr.c          | 8 ++++++++
 system/physmem.c         | 1 +
 5 files changed, 13 insertions(+)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 666593ff6c..c47bb09ba2 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -85,6 +85,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
     cpr_save_fd(name, 0, fd);
+    cpr_mark_fd_luo(name, 0);
 
 have_fd:
     backend->aligned = true;
diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
index 4766db6aad..77ec329f70 100644
--- a/backends/hostmem-shm.c
+++ b/backends/hostmem-shm.c
@@ -49,6 +49,7 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return false;
     }
     cpr_save_fd(backend_name, 0, fd);
+    cpr_mark_fd_luo(backend_name, 0);
 
 have_fd:
     /* Let's do the same as memory-backend-ram,share=on would do. */
diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 5f30df7ec8..425f6ee956 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -23,6 +23,7 @@ typedef struct CprFd {
     unsigned int namelen;
     int id;
     int fd;
+    bool luo;
     QLIST_ENTRY(CprFd) next;
 } CprFd;
 
@@ -37,6 +38,7 @@ typedef struct CprState {
 extern CprState cpr_state;
 
 void cpr_save_fd(const char *name, int id, int fd);
+void cpr_mark_fd_luo(const char *name, int id);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
 void cpr_resave_fd(const char *name, int id, int fd);
diff --git a/migration/cpr.c b/migration/cpr.c
index 33ac74c1f3..9b6b85cedd 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -141,6 +141,14 @@ static CprFd *find_fd(const char *name, int id)
     return g_hash_table_lookup(get_cpr_fds_hash(), &key);
 }
 
+void cpr_mark_fd_luo(const char *name, int id)
+{
+    CprFd *elem = find_fd(name, id);
+
+    g_assert(elem);
+    elem->luo = true;
+}
+
 void cpr_delete_fd(const char *name, int id)
 {
     CprFd key = {
diff --git a/system/physmem.c b/system/physmem.c
index db3dda563d..263acb5727 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2458,6 +2458,7 @@ static int qemu_ram_get_shared_fd(const char *name, bool *reused, Error **errp)
 
     if (fd >= 0) {
         cpr_save_fd(name, 0, fd);
+        cpr_mark_fd_luo(name, 0);
     }
     *reused = false;
     return fd;
-- 
2.43.5


