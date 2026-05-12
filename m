Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EFDCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMobZ-0007Nf-GM; Tue, 12 May 2026 11:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wMobR-0007Kp-Mn
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:01:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wMobN-0007zU-Hn
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:00:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CAfYQb563418; Tue, 12 May 2026 15:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=Bp3JWvn1TnZy2izBm5V2Qsc/QDF5r
 9jqNKyngkSzXPY=; b=ZbDIjEQAn+QFnyUoy1yfujgtfM/OozH50ozEPSPGCA1hl
 zn5/kw18ktu/gFrWAoP/QVEa2KgCdX65Rk13BZKG7Wya4kwIEFCwv0T1t4DeO3Wd
 cOv/v18eNPWntd3CIWnpSA8P9ZF/vJTVHi14nnvbXJo58O8jgHBrFFwZbsQjXUt7
 nVh+UdrdJudrSGlxrDr4bN2WO6215T/7Vj/FmBBNt5ReCWgdMh4Gyd/OLqGoDTN2
 j9uEX3tCA0L7pV+0VtPrhloEI9DiLjGxur6QOqfra4OP04TPwIDEACdud22U3Oib
 0zMrvILQ5ru8yCMidnwyG9wT8u0OL7YzaP756N9NA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv01dk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 15:00:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 64CEuMve020643; Tue, 12 May 2026 15:00:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4e3nebb087-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 15:00:46 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64CF0jEb001769;
 Tue, 12 May 2026 15:00:45 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4e3nebb06u-1; Tue, 12 May 2026 15:00:45 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: sarunkod@amd.com, pbonzini@redhat.com, mst@redhat.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 1/1] amd_iommu: Update command buffer head ptr in MMIO region
 after wraparound
Date: Tue, 12 May 2026 15:00:44 +0000
Message-ID: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NiBTYWx0ZWRfXwE1Qkl/Y1Pl+
 AibFybX6T097e7SAiZ3ygsE68YXIKWffWz3HWN42L8MSSTfse1CdtaClRYreakDPKdKPxuvAEjg
 BwS7/OVyLZEvn5+adRXIpbp27E2JmwzNyKJpKINC7Arxtn7kYPEopIWHvTPouTDJXasRRZ1Q7WD
 SE57doZWPIIgFZ4eX+9yuTpAMS+vFsD/ZELx8W7oKq5+fhsCaCpVowRUYGD9EtSFN/G5JP5gDOH
 p+inpxU3BHPuDKiUzooFDP5z0bAr0IPTgICyH3xh2GiljaiSNwekBDaj3IsMXyqXGbWwpHLjR0Y
 tKAxLGodPnX7ZGziDT5FMYi+vELp43XiMn1ck4AKEW+lCHvrpk/zvkO00LVGU0beKZ53iZjYB4h
 r3VSIo7xWjKE7jw+M6/GG/MnAi0+Wut2HO30y01IoK7OWb3Sk1Qz4Uv7LIGoD96Bt3bBT56ou2s
 6MjcAF37bj36bJOu8FtRgTInMI5S64r6BW7TpdB8=
X-Proofpoint-ORIG-GUID: ug1X7epNw7Ar0WhFa6QUtLSxfixhZuJB
X-Proofpoint-GUID: ug1X7epNw7Ar0WhFa6QUtLSxfixhZuJB
X-Authority-Analysis: v=2.4 cv=OMoXGyaB c=1 sm=1 tr=0 ts=6a03409f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8
 a=nVvs5_CVLXPfDsJYVQUA:9 a=O8hF6Hzn-FEA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

When processing a command, amdvi_cmdbuf_run() increments cmdbuf_head and
writes it to the emulated MMIO register space before checking whether it
has reached the end of the command buffer.

If the incremented value reaches the end of the buffer and the tail pointer
is zero, the loop exits and the COMMAND_HEAD offset still contains an
unwrapped value. There are no errors in command processing since internal
cmdbuf_head state is always correctly updated, but the spec defines the
CmdHeadPtr field in MMIO Offset 2000h Command Buffer Head Pointer Register
as RW i.e. guest-visible, so it should be kept consistent.

Wrap cmdbuf_head before updating COMMAND_HEAD so the MMIO-visible register
always matches the internal command buffer head pointer position.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 197e452e3c..5d6a405263 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1475,12 +1475,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
         trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s->cmdbuf);
         amdvi_cmdbuf_exec(s);
         s->cmdbuf_head += AMDVI_COMMAND_SIZE;
-        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
 
         /* wrap head pointer */
         if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
             s->cmdbuf_head = 0;
         }
+        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
     }
 }
 

base-commit: 8333dba7326d89ce180221c4d0c6d34826a9a4a3
prerequisite-patch-id: df656299f90e928acad39d99e3701c5641e972d5
-- 
2.47.3


