Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A6BCA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu3-0005fT-IJ; Mon, 12 Oct 2026 19:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtz-0005cy-5H
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtv-0006EY-09
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMidcF2859531; Mon, 12 Oct 2026 23:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=hqRfU
 PnhtX0Bed/56TAdAIJetvyLh26h3k2vBq9Tac0=; b=n6MLV7N1B8TNE1DoaIx6O
 4CwHqwuPLD8pw7lldJPUiE1wnFagqsuDin8BStlLdc6VMlxfsqJMfd8NIaHOePoe
 8siQpLlagwDTNnTPtCGizscsKI3TyhYFDIj28c2pKWOgYBPDYBYgZqgX9wTcu/mH
 rwWjSeksRW24OZ4+lIUmEBubukkm2FCJ7gUi93x+ZAIKd21aix/hi1yHuEKh6RY+
 /lrgj8oZkLzYbJjJkZSChJ17XRGd4M3hgNu5VFw16UrvUhD9cUhzsjePkjdTacwK
 ZyJVGH/VCd2PEN+LwT8o8BeXBzt2T4qdkhTHvJRWY1bgamPf/iHj2/K8SaJCDIdY
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demk5v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeFL015082; Mon, 12 Oct 2026 23:57:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:43 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHB025328;
 Mon, 12 Oct 2026 23:57:43 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-3; Mon, 12 Oct 2026 23:57:43 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 02/21] migration/cpr: move CprFd definition to header file
Date: Mon, 12 Oct 2026 23:55:58 +0000
Message-ID: <20261012235727.398133-3-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6acd73f8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=HSzY4yhsOYPL0Ecqzf0A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: zFthHOEoypMUluxB5yU4zG2D0yFTsX1H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX3qYXQY0qMbG2
 U4x6fPwP3C7SP5tMGrW/q6yVjs++XnuOujtrs8x1Ns9H0O1yqVdC9GLFPa2W4Fb8ZvRbErlm9/K
 atcaRhc9scp+OVub/dN72lp7gOTBd1lk3zpW+bi2gFaGkIRd0LLU
X-Proofpoint-ORIG-GUID: zFthHOEoypMUluxB5yU4zG2D0yFTsX1H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX65Plhv18C8FR
 8eRl87z9dOobyXrlU55quDZ68qLzUKqcDTlfmHDzXT02jLkkSWlLOxyrYC+0uxn+xHmJKbtcztZ
 3vXl7kh0jFkMKZjZ471o8mNWLLIL+dT87jFYk/MCPvKQObTOq9wQQlwBc05MzkHCrgH9jclPBbN
 EMwIlhaUja2upfLaxCAWAP/DZ/KBIvnSVYxmc3zVca87dUK/kyKaKu9GQCxV9lL6Cu+FvqmEbC2
 ZATXYFvZu5y9ih+BdTLj+/1xa79JZhpGUlWgpAmbb9GVnqVy82S0CRq/PoGDy2smMk/+vjcgwyV
 I/Sl+jmwRg3S2FsDS1eFg8cm/5jRgYICkEOCc/saqJ5c8nwdfsbk37P3jqZ5DPHTOijELie3uXm
 FIY73z2xc3edmtSZwECfQ07Iyf5QCfZEgW2yaUGVZl3LFPeJF+Tk3OVjOLJtuslyWO1xukyUMsH
 xnPj5KrmzjS22Ptyao8+q/3P1TwA6rRndbiJ32q4=
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

Move the definition of struct CprFd to a header file so that it can be
referenced from more source files.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h | 8 ++++++++
 migration/cpr.c         | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 56fb67e6b4..e33eaf588b 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -18,6 +18,14 @@
 #define QEMU_CPR_FILE_VERSION   0x00000001
 #define CPR_STATE "CprState"
 
+typedef struct CprFd {
+    char *name;
+    unsigned int namelen;
+    int id;
+    int fd;
+    QLIST_ENTRY(CprFd) next;
+} CprFd;
+
 typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
 typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
 
diff --git a/migration/cpr.c b/migration/cpr.c
index bca43e9bf3..33ac74c1f3 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -28,14 +28,6 @@ static GHashTable *cpr_fds_hash;
 
 /****************************************************************************/
 
-typedef struct CprFd {
-    char *name;
-    unsigned int namelen;
-    int id;
-    int fd;
-    QLIST_ENTRY(CprFd) next;
-} CprFd;
-
 static const VMStateDescription vmstate_cpr_fd = {
     .name = "cpr fd",
     .version_id = 1,
-- 
2.43.5


