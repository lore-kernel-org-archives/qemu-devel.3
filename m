Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21786CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu2-0005eu-F5; Mon, 12 Oct 2026 19:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtz-0005cq-1W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtv-0006ES-2e
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:54 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgg03335366; Mon, 12 Oct 2026 23:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=v7qjH
 wdeZIN4wgfv7mC42SIX6IlK5DRp7PAEaikx15Y=; b=pFT4+G+UIG6TL9Ua5B3Fx
 lw/na7UnuADRgHw+VA69m+U8taDJQXk7T4VxVJCQct6aF//7m6e24GEsfolwUzuJ
 r9gtQ6B+wAzSG5ASoKFdeC7hVq2eFLjPbHJ5CqnH8ililf8U9xVy8qi8mreDRFP8
 FCCvJW/kPOJWbCpJMB4vFiYQTHmdHjJcoNPHn56zIkV+AMI/RzqR46vCahFsJA/j
 rd56HEX0Y9/wplkpPSTMWkuIrzbHNttPE87NfUlfDlQoHd54VRJ6k91r71VWqK1X
 6Cfk1kcweOlanyWLFjmj+BAJTa+FF/c4DgGfLfLjagV+ekW7B2ngKyXDCoXFd/YV
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dddu7t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeAn015078; Mon, 12 Oct 2026 23:57:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:44 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHD025328;
 Mon, 12 Oct 2026 23:57:43 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-4; Mon, 12 Oct 2026 23:57:43 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 03/21] scripts/update-linux-headers: Add liveupdate.h
Date: Mon, 12 Oct 2026 23:55:59 +0000
Message-ID: <20261012235727.398133-4-dongli.zhang@oracle.com>
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
X-Proofpoint-GUID: RmI4on2TXIcY_HEddZkw-onoTR2fizuP
X-Proofpoint-ORIG-GUID: RmI4on2TXIcY_HEddZkw-onoTR2fizuP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX8O6ZiXTcM38F
 pOQq6l+NK9c7wHKW++WZWyZiTXmWZ19PFccgrOMw0C9DyTA5Yez4ld3cdtH72csGcBygGvKcCn7
 fCmGFh3P2gQCjndnROtEokgGs5zToyub1uizy0LGMAyhg2GEtZps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX6xQT9veYEOYK
 WfvtfAVZVQKcwLkHQnHUGpfx+syv+5WuqLOwtJzKmM3EXOpawWiylFfWFbza4Pf/QMkINhx0ZbS
 FAPPakpNP1ae0y7BLsaBgg4nNufp1QJ1rLB56Zn4pqcvVUYlQCK9O2KXUk7kIxGLNdOuSPRD3PN
 ge8fVHHZKC8nKJXAyHLhhlI6ZIBngvfD5D/1iIImg4hhbAUdu+ucV1neDcxi+cP7az2V+amHuK7
 wV5cH4hUIqbQ80j6lfrNDu9dGyZ1rCiB1l18EsicmPv5XGPU2bqoSGRfBcN3mUq1zmqGF7A12Ex
 be8EAuSXdPySFc+r9aQXoSi/8AOsesY2BDU2IFfIXt51C27ROUffcazkiSqYAAHpWW6NWNbJvRc
 BJOck2vRP/e4YWMSX71xXD67DJUbFO/DpzhKH4qqrzKk4QH3EuiwEg4fIKljK1CQmNAN+L2fS13
 kJMhSGibRMA+K+ibGEOYZb6I0OQmK8cLelApaTjM=
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6acd73f9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=9CnQiUKmxWeaQBo3fDIA:9
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

Update the Linux header import script to include liveupdate.h. QEMU uses
this header to issue the ioctls for session and file descriptor
preservation and retrieval.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 3c3a0e9394..aeec7a9666 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -197,7 +197,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h bits.h mshv.h; do
+              vduse.h iommufd.h bits.h mshv.h liveupdate.h; do
     cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
2.43.5


