Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4D6CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu5-0005hB-S8; Mon, 12 Oct 2026 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu0-0005e6-Iu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtx-0006F2-Ed
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgg5M3087997; Mon, 12 Oct 2026 23:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=++7Cd
 huM5HXOcyyQegmGD7/9LK6gIz75oT7hH4ljyio=; b=GA+8/ntjit+oHWvYS8580
 mKezJjiLOW1e1aY0cyiRzOC1pbMssd2sHdohhtiITpSjW7jgSYnbS/ZMTxxtB/S/
 AXNXVHUxikC0P/48tI3UXdhIEB0q4/Z6UnbYl+gqzhBmP0oQr6mQWpXzGE7u7rpk
 4wd2XIx8zlIJ0reUb47mEy+jlCOhZ3Pxvbrau7YhDVSHrMpQG6sTOk0jxiKo7QS+
 MMQgVvrtWUnZUTEDTJaaINlGsc2+8Q824h33VV67UGQR1Gq6DI4uKho2JCIvZ2Ik
 NBU55p/qxDfblcSA+JZEZ3gtsv6UOtzSzUp1nbRdvqvSWscH1Q5Az0/uAeHyVfRH
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1k553-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpdTp015062; Mon, 12 Oct 2026 23:57:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:46 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHL025328;
 Mon, 12 Oct 2026 23:57:46 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-8; Mon, 12 Oct 2026 23:57:46 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 07/21] migration/cpr-luo: add LUO fd management helpers
Date: Mon, 12 Oct 2026 23:56:03 +0000
Message-ID: <20261012235727.398133-8-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6acd73fc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=NjJOnVSnIn4cxv5EFd0A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXwzVSAknL/B5l
 PoIVGk0ogw/VpsOEQhdNY8rPs3hBMnCVIPmlkLZoU9tyBdynqaC4crfHHl+GSUWphRdALHlWOPA
 axtMbqgdMNhCaRrn4everxbGV2ddvsuwowufR6NWQsumIwwXlHss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX9kNrw6uOVSde
 +hteQWBMfA2Nf1MKE6SpuxJSdLtQXvDI1f8TmPmgWcp7xL1Rr80SZnAaEf0ek5DHCq6L7uXVogm
 sEBnVnIlYpq/DP5nfkfnCLQc1d8icwOQcb5knBkIATE0ASXMNeqdWC+9eyVxZllQL15TxE+TCGh
 c77+eAHvOeDbnM3D9smLewfZY812H9oJ/5RaZcpz/nJ8a4dqyYnFEDCe4oSSvzjwp15HeJTnDu+
 oH6LvHDwzTaMRENvQ+uHi5HEvdmVBE5G1inPq6u2yYV3rXv4VEFQHMUZyZijO+WsvaLydpY0lEB
 05kDgACeh766uT58WnTfPoVLbGHgjNGrxx6gN/l9Grex7llQrXuX6AzelBk2MgkgyiQsA1ea/pt
 iIuPKagkk2RmdR3VrVEWJJggVSpJkWCm4QBU83PVAciRmL6cPiATXTY13+8Rd0sUdBKC133XvTm
 vul7Ra7r5oiadNsN0FC0dBchOAxxREKxRRmFIcwI=
X-Proofpoint-GUID: AyfBx81HTxTqK_kHldb74VYhHSqUQJ8c
X-Proofpoint-ORIG-GUID: AyfBx81HTxTqK_kHldb74VYhHSqUQJ8c
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

Add helpers to preserve and retrieve LUO fds by calling
LIVEUPDATE_SESSION_PRESERVE_FD or LIVEUPDATE_SESSION_RETRIEVE_FD.

The LUO API is available only on Linux. Provide error stubs on other OSes.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h  |  3 +++
 migration/cpr-luo-stub.c | 11 +++++++++++
 migration/cpr-luo.c      | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index f8b161b3d6..5f30df7ec8 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -77,4 +77,7 @@ void cpr_exec_unpreserve_fds(void);
 
 int cpr_luo_create_session(const char *name, Error **errp);
 int cpr_luo_retrieve_session(const char *name, Error **errp);
+int cpr_luo_preserve_fd(int session_fd, int fd, uint64_t token,
+                        Error **errp);
+int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp);
 #endif
diff --git a/migration/cpr-luo-stub.c b/migration/cpr-luo-stub.c
index ca060ae8c8..ab64e1f99b 100644
--- a/migration/cpr-luo-stub.c
+++ b/migration/cpr-luo-stub.c
@@ -24,3 +24,14 @@ int cpr_luo_retrieve_session(const char *name, Error **errp)
 {
     return cpr_luo_unsupported(errp);
 }
+
+int cpr_luo_preserve_fd(int session_fd, int fd, uint64_t token,
+                        Error **errp)
+{
+    return cpr_luo_unsupported(errp);
+}
+
+int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp)
+{
+    return cpr_luo_unsupported(errp);
+}
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
index 48288ed5f9..f6e0e23657 100644
--- a/migration/cpr-luo.c
+++ b/migration/cpr-luo.c
@@ -72,3 +72,36 @@ int cpr_luo_retrieve_session(const char *name, Error **errp)
     close(fd);
     return retrieve.fd;
 }
+
+int cpr_luo_preserve_fd(int session_fd, int fd, uint64_t token,
+                        Error **errp)
+{
+    struct liveupdate_session_preserve_fd preserve = {
+        .size = sizeof(preserve),
+        .fd = fd,
+        .token = token,
+    };
+
+    if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &preserve) < 0) {
+        error_setg_errno(errp, errno, "failed to preserve fd %d with LUO",
+                         fd);
+        return -1;
+    }
+
+    return 0;
+}
+
+int cpr_luo_retrieve_fd(int session_fd, uint64_t token, Error **errp)
+{
+    struct liveupdate_session_retrieve_fd retrieve = {
+        .size = sizeof(retrieve),
+        .token = token,
+    };
+
+    if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &retrieve) < 0) {
+        error_setg_errno(errp, errno, "failed to retrieve LUO fd");
+        return -1;
+    }
+
+    return retrieve.fd;
+}
-- 
2.43.5


