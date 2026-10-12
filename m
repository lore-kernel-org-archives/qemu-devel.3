Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC078CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu9-0005ir-IR; Mon, 12 Oct 2026 19:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu2-0005eq-9D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0006GQ-IV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMh7OJ3089566; Mon, 12 Oct 2026 23:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=RntxU
 dv9kSPTnZFp1VWl9lCdJoJTCVSpbRfwxdRg0Jk=; b=doyFYP0Brej5Af1g7B3bj
 r9oN/O8ig70T+OnR8t5u48SAxrqfaqUj0zvOwz3FhU8U7FnHeQ9w67mK7HKjeeJI
 JBzl6cLHlKQnJcbC8z8AG536HD2Wi4iyf9AqWVnQLOuQWZYHvKmtKGB4Y3yfwYUm
 vpUF5GLo8ebfjzhmXIPU3tNJPZ6ezeYeomnCrK5XUsCm9OK4PfrLwf7lUIk1L/OF
 fGchCDg8UJxTe6Hv9rPMMPsxIdx8N/mHtmdSSw9Kz/AF+ypXLvGUAGX2yen0Vn2c
 NpxGcScdv2+Y9obDbGrj+2znSq5x7J5UIqumgepQjT7LcGXvx30RiKhCfr+/B5kA
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1k555-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeFO015082; Mon, 12 Oct 2026 23:57:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:51 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHZ025328;
 Mon, 12 Oct 2026 23:57:50 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-15; Mon, 12 Oct 2026 23:57:50 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 14/21] migration/cpr-luo: add helpers to preserve and retrieve
 all LUO fds
Date: Mon, 12 Oct 2026 23:56:10 +0000
Message-ID: <20261012235727.398133-15-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6acd7400 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=qgt_1DZC0AILELGDL5IA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXx3hGvLqokRWD
 6SsWhI7JcQ2/UQ4eKf1RIPJ+h2brXzAXV7AV91Y3tngel7aEgdlUI618xuND+QwgpszQSS+49KR
 GS9TWLDyiCdnbmydKwkEVUbfqAti1lqZgc7mEZjTH4LJIvKeiGWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXz3Xju3X4oRii
 OoJ6IYKv9EC55NU/z7RlwsgHoH8kehYo14SCms/QhwuSCsOR+mItiC0/VDmgs2FjakAP8FIwuD6
 +rWA5cvxmOpnGYS9R1uHC/Np2EEzWIIb0hUPqZzgR9m6RgL7Oks8mFyJt57PExZDFyWmniPRA1i
 fZixi9CPX7fgA76NcOwkD4UXGH0vBqvbHumvaTiYLflwFol1fCsSxhR+jPARW559JF+tU5g/JE4
 QPRqWXdGt1SIdKpniGjTpqmqYfXAKmNcNYTgcDxlXBHaBpX5yiD9xOo5iC3/r5DxQKhHQpgb0hk
 GVKtOjr4fTcFKHl3jj77wGa9+avNPUA5aD28O3FB0xwuAwXqSSSoGNOQwjcmkpBM5UC/s7R/RS6
 48qK2Ez/bmt53rzibv18UIS4tNRQxZ7T+SL5rVLeyxAXKWtKWi3DDtMJUDi7ZPAen4gopjWf05o
 ffAZwJUVeSZafVyv1gnYJ7OrbjTSfs5+IHhoZyAQ=
X-Proofpoint-GUID: yFzmdjVN669XjcB4Zntc5PmECND6toLm
X-Proofpoint-ORIG-GUID: yFzmdjVN669XjcB4Zntc5PmECND6toLm
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

Add helpers to walk through saved CPR fds to preserve or retrieve
LUO-supported fds. Ignore fds that are not LUO-supported.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h |  2 ++
 migration/cpr-luo.c     | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 775f584368..bfb2bb0b50 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -92,5 +92,7 @@ int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp);
 QEMUFile *cpr_luo_output(Error **errp);
 QEMUFile *cpr_luo_input(int session_fd, Error **errp);
 bool cpr_luo_persist_state(int session_fd, QEMUFile *f, Error **errp);
+bool cpr_luo_preserve_fds(Error **errp);
+bool cpr_luo_retrieve_fds(Error **errp);
 void cpr_luo_abort(void);
 #endif
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
index 5b6bd6e191..f20ba1f30c 100644
--- a/migration/cpr-luo.c
+++ b/migration/cpr-luo.c
@@ -152,6 +152,65 @@ bool cpr_luo_persist_state(int session_fd, QEMUFile *f, Error **errp)
                                CPR_LUO_STATE_TOKEN, errp) == 0;
 }
 
+/*
+ * This function must be called only after cpr_fd_pre_save() has assigned
+ * LUO tokens.
+ */
+static bool cpr_luo_preserve_one(CprFd *elem, Error **errp)
+{
+    if (!elem->luo) {
+        return true;
+    }
+
+    if (!elem->luo_token) {
+        error_setg(errp, "missing LUO token for CprFd %s id %d",
+                   elem->name, elem->id);
+        return false;
+    }
+
+    return cpr_luo_preserve_fd(cpr_state.luo_session_fd, elem->fd,
+                               elem->luo_token, errp) == 0;
+}
+
+bool cpr_luo_preserve_fds(Error **errp)
+{
+    return cpr_walk_fd(cpr_luo_preserve_one, errp);
+}
+
+/*
+ * This function must be called only after cpr_fd_post_load() has
+ * initialized luo and received luo_token.
+ */
+static bool cpr_luo_retrieve_one(CprFd *elem, Error **errp)
+{
+    int retrieved_fd;
+
+    if (!elem->luo) {
+        return true;
+    }
+
+    if (!elem->luo_token) {
+        error_setg(errp, "missing LUO token for CprFd %s id %d",
+                   elem->name, elem->id);
+        return false;
+    }
+
+    retrieved_fd = cpr_luo_retrieve_fd(cpr_state.luo_session_fd,
+                                       elem->luo_token, errp);
+
+    if (retrieved_fd < 0) {
+        return false;
+    }
+
+    elem->fd = retrieved_fd;
+    return true;
+}
+
+bool cpr_luo_retrieve_fds(Error **errp)
+{
+    return cpr_walk_fd(cpr_luo_retrieve_one, errp);
+}
+
 void cpr_luo_abort(void)
 {
     int session_fd = cpr_state.luo_session_fd;
-- 
2.43.5


