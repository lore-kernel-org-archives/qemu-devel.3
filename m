Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33ABCA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu3-0005fP-7b; Mon, 12 Oct 2026 19:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu1-0005eJ-0W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPty-0006FX-Kr
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgg5N3087997; Mon, 12 Oct 2026 23:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=BVOej
 UXav0jxA+HEffEKWSyMlhQNfpFPuBn+c6g38DQ=; b=SLB3FVLWbccQvI8qUjScZ
 JNji8ToVtYXnF/4vcYsS3g8+kc1fsf+pOVZNCOJI+QC1HxdmEm5RpMbVNVCqVTnv
 sAjB5wiFxDrx5gc8ewfp6Kq/1UxzKeKX2/6dXrhC9+iA0ffDzVzWgUvc8A2IYPI9
 1Jy4Nf6jqp7qUTpTdU4SBTFvsb7KaemB27CNrTcjgb0nyF5I2LO8qEdKMcBzt3Q0
 zINYBQ2oBYYjPsildRdCBcw/QNDCrGTV6Q7B9IFmpbFZAH0EWXaOQZ6sThT+IMnp
 Obcx5JTENNBkAqZ4glBmjCIr2nR7H50SOnaXsNtWQRIpOUHE+0RB4n0BwVssQGX7
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1k554-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpgrD015202; Mon, 12 Oct 2026 23:57:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:48 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHR025328;
 Mon, 12 Oct 2026 23:57:47 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-11; Mon, 12 Oct 2026 23:57:47 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 10/21] migration/cpr-luo: add tokens for LUO fds
Date: Mon, 12 Oct 2026 23:56:06 +0000
Message-ID: <20261012235727.398133-11-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6acd73fd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=tetSL9Y0ncEMf86toeEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXzaOs91N2eD4Y
 J9tgMfAyLR5Dv6eIAuuUytWCe9Gx2jn3yVdMvZLsDecNaqA6Syk9deFRw5IlNHoS7wRR6661OWl
 lcQ403cGqYks77vzWvFytjs8+Rh6m0bRGc0FCYi7hOtqDp6AhuMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfXzx2zw6Z8r5qw
 rJf8AQilOYvRz/UT/KvRgbN2yu73uTBeWT4syMOT2QLNHB8XC1z6CIaP0B/y0+LYwavxlWPZgV0
 hREn6krDZ58ZePRdOfXyWFrw6dI6ZXO86gbrhZIeVilaxALa2beyM9XpeGPD0bJR4/icWDWY7IJ
 nbfIphTo5EGrpiJrXOcESTclX0IN6NG658cs1usizg6KMn+V37i0KV8H4zfhF5DStm5nW96d0AO
 lcSiOp5hewkc67cAXHnILZG4fEGXHl9kZ1YYxN/YP86zgeEKhW9xAMz3JSlUFW+GOavOcShF3ID
 zhV8V0i4n/Wa/tw82kfwvane0RjEkuGBndVjA7uPHL/ifqZ+4yE2+oPEnQ+DioYb0vU/KbNCrV2
 BYbQDZfAhXO9h8OAuYBC1wtbAh/OBl8G6F+Xl9lZu2KcHtbgxsgEqMQcnP7erGdqZFOULe+9R0D
 bPz4+5+1zMUXMUmVCUHOzjSNpONiOmT92MPw2KYo=
X-Proofpoint-GUID: VWedBxC-l1V4Vbqr5y7UgAjl_1PgmOXJ
X-Proofpoint-ORIG-GUID: VWedBxC-l1V4Vbqr5y7UgAjl_1PgmOXJ
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

LUO tokens are required as keys to preserve and retrieve LUO fds.

Instead of assigning LUO tokens during fd creation, assign monotonically
increasing LUO tokens to each CprFd only when serializing the CprFd.

We reserve token 1 for the CPR LUO state for later use. Therefore, regular
LUO fd tokens start at 2.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/migration/cpr.h | 2 ++
 migration/cpr.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 3bfe91f10f..77e753a278 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -18,6 +18,7 @@
 #define QEMU_CPR_FILE_VERSION   0x00000001
 #define CPR_STATE "CprState"
 #define CPR_LUO_STATE "CprLuoState"
+#define CPR_LUO_STATE_TOKEN 1
 
 typedef struct CprFd {
     char *name;
@@ -25,6 +26,7 @@ typedef struct CprFd {
     int id;
     int fd;
     bool luo;
+    uint64_t luo_token;
     QLIST_ENTRY(CprFd) next;
 } CprFd;
 
diff --git a/migration/cpr.c b/migration/cpr.c
index eaaca6d47d..700e833003 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -49,6 +49,7 @@ static const VMStateDescription vmstate_cpr_luo_fd = {
         VMSTATE_UINT32(namelen, CprFd),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
         VMSTATE_INT32(id, CprFd),
+        VMSTATE_UINT64(luo_token, CprFd),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -98,6 +99,7 @@ static int cpr_fd_pre_save(void *opaque)
     GHashTableIter iter;
     CprFd *elem;
     MigMode mode = migrate_mode();
+    uint64_t luo_token = CPR_LUO_STATE_TOKEN + 1;
 
     QLIST_INIT(&state->fds);
 
@@ -107,6 +109,10 @@ static int cpr_fd_pre_save(void *opaque)
             continue;
         }
 
+        if (mode == MIG_MODE_CPR_LUO) {
+            elem->luo_token = luo_token++;
+        }
+
         QLIST_INSERT_HEAD(&state->fds, elem, next);
     }
 
@@ -149,6 +155,7 @@ void cpr_save_fd(const char *name, int id, int fd)
     elem->namelen = strlen(name) + 1;
     elem->id = id;
     elem->fd = fd;
+    elem->luo_token = 0;
     cpr_fd_hash_insert(elem);
 }
 
-- 
2.43.5


