Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CB9C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis3-0003zD-Df; Thu, 29 May 2025 15:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKis0-0003yQ-Nm
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKiry-0000CF-JI
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsX3009722;
 Thu, 29 May 2025 19:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=LoRYiuZjJFkdi2SKpqwGsZxCUG9B/MdcUAMZSBADbuk=; b=
 S0MMnHvx/Pkg4XJtXz3c7/6v15U2HrRas10H2+NE0SfmYzdAaO/v92Q3PTj9zj6j
 JtSC0+6fKrKJ7KEFfDlw0GJQXiacMEAWE17QNaGmeTy+uwdUtFrsg+HaX7Mhg0Pg
 +bzEeyZwqjsC/3vCa9peCmoCA3ZtrR0J2Gogrh0EsgOkJD+4A5NojSS3kKjgLT8r
 37VnuUXvrHeHu86nHs35X0TSzGQ1xmMN1fDIxtVRx7gAMj28C4v89yXWjg7JZvQ/
 hI2AyfjHkIaRF6DSypKREvQr3Pz8AnljWQHW9JXknB/8/Z1yhj8xeB02I/svt0bu
 tKoN/b5NliizcRT7JAvBqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJOTSj020393; Thu, 29 May 2025 19:24:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeR1022158;
 Thu, 29 May 2025 19:24:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-8; Thu, 29 May 2025 19:24:46 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 07/43] vfio: vfio_find_ram_discard_listener
Date: Thu, 29 May 2025 12:24:03 -0700
Message-Id: <1748546679-154091-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: a_dn_iot1oc4pK_PqAXrmp270azfMdG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX22jvLkyfLbWy
 VLwoSWG9ftbanwF62B8urDfOnt1tRiBIgVhR4hsR/6VHBAX/+yYzmZ+XsP6WU8GtWNMtyTx6PXU
 vlXCHkA9OChEEmphsZjOTZSciPMgc3YMVW25KOS4rAjP6t3BBPZFjwtO4hPPQPyahLNu/j/hNIt
 4tVMWpO8hXVbEv1yd4Amc7IdmznEPaU6pW/YEShc1XGg/LIPtcEYMldT70OooqKPozGsqeKYHBz
 Gbb6DUHWAv71xwPcZjk7CIDxvD8XdNbPyzSyVqkryLuh1PqiUHNQBJ/KeCl17ryyR8FFLseiWbw
 FHzvdaYWXT7nlRUznpOk+za4pOQ3ud8MbzavtyGGoGDBltixAeePrkMp+jIw0SGRgdYMOnEZzgb
 0K/nCvifeZixrwjsUXw2lm/cOxNmh3NHgX8N2MkOwGwhe3xG571rt73JeySsXLKdeYn0mLEb
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b47f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=MtPhzGyV-s5HnW-BJbUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a_dn_iot1oc4pK_PqAXrmp270azfMdG5
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define vfio_find_ram_discard_listener as a subroutine so additional calls to
it may be added in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  3 +++
 hw/vfio/listener.c                    | 35 ++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 83ba7a5..01cdcb6 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -196,4 +196,7 @@ struct VFIOIOMMUClass {
     void (*release)(VFIOContainerBase *bcontainer);
 };
 
+VFIORamDiscardListener *vfio_find_ram_discard_listener(
+    VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index a1d2d25..fb1fd84 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -456,6 +456,26 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
     }
 }
 
+VFIORamDiscardListener *vfio_find_ram_discard_listener(
+    VFIOContainerBase *bcontainer, MemoryRegionSection *section)
+{
+    VFIORamDiscardListener *vrdl = NULL;
+
+    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
+        if (vrdl->mr == section->mr &&
+            vrdl->offset_within_address_space ==
+            section->offset_within_address_space) {
+            break;
+        }
+    }
+
+    if (!vrdl) {
+        hw_error("vfio: Trying to sync missing RAM discard listener");
+        /* does not return */
+    }
+    return vrdl;
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -1086,19 +1106,8 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
                                             MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
-    VFIORamDiscardListener *vrdl = NULL;
-
-    QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
-        if (vrdl->mr == section->mr &&
-            vrdl->offset_within_address_space ==
-            section->offset_within_address_space) {
-            break;
-        }
-    }
-
-    if (!vrdl) {
-        hw_error("vfio: Trying to sync missing RAM discard listener");
-    }
+    VFIORamDiscardListener *vrdl =
+        vfio_find_ram_discard_listener(bcontainer, section);
 
     /*
      * We only want/can synchronize the bitmap for actually mapped parts -
-- 
1.8.3.1


