Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EB1C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180a-0000J6-C6; Mon, 31 Aug 2026 15:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180Y-0000Hx-Cs; Mon, 31 Aug 2026 15:49:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180W-0002bF-Lg; Mon, 31 Aug 2026 15:49:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVcl13108100; Mon, 31 Aug 2026 19:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5IK+F8PP4Raqq3BJB
 4nLCs/in/QuWj2w5zEVvaHbvEo=; b=GnYg0b7LowFZKOta7nddFyayX29OP+rLA
 Oki5l9mejwJegtlwYj/pspxLZHTYZrGWr15pZttxN8MwFYcsOqDmWfReLN6azwE4
 +Ngcc6c3sxcZ29BJ3CpUiSOkLWzLWeSkKWvratYsx94riMjACrF/OndnDNuNjSYz
 F37a4O5AxLEWFJ+xoL3glAWs2oR60o7+6vbTEkmHqb5WPy3KAVu7czJg35snG6mP
 S2tZJTtB4SK3dSCyisCxfyL0LQwx5QF2uzj1s+nEPL2WjCPLrwyIXKUhx1w7DXTv
 rYDmONgdPzEY//KaI9mLUVpUwpKsOTRJztc65+305Gkt2jna6qHAQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54kgtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfiCj026976;
 Mon, 31 Aug 2026 19:49:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexyjaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnN7o52429118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FC6F58052;
 Mon, 31 Aug 2026 19:49:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8AFC5805A;
 Mon, 31 Aug 2026 19:49:22 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:22 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 1/8] pc-bios/s390-ccw: Check if a PCI function is already
 enabled before trying to enable it
Date: Mon, 31 Aug 2026 15:49:12 -0400
Message-ID: <20260831194919.3830270-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260831194919.3830270-1-jrossi@linux.ibm.com>
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX8BsSHXqHPfhu
 Z2jNnXJMs326PwByylydIHY2hb+KiZHr78sTbwWGSt+vJIWSC+GOOZliHsbY3Op0rBBgGB8naWC
 YESNRKF/HRU6pB/Z3z58IjMzoBArCqwBS5zIpaMlm/+CYwMiNpFRc7H3flmhRwvDqEMoQ4fqaFG
 FB4Y6ikSWQsJkyIXbCBcDjNeF3unWbG/mT0hTr98TA1I5u9hJbf+vXgetBItgb/G6DGr2qznMG2
 e52xNFA/nXD4+MJfRCM6tS0bpl+2ePm8se3196RWGEknpXLeAsKfzUVqHLGuyRdTvGpfJc5GWhr
 lqSD1AWbrFrHf+g8MaImgnTmQWez+824Mvk7rrvFJVIKmoUkkHbLwx89pBU1/aKM6gy0Zu946/f
 9tcTGp4oaCSOELkYJpV+Zzd5pcS/FUPTXAwFjx362LhyZ9YbJ3Hz0tgTN6H+CfT5K8bMJJ/eQPb
 TS79HP4CD96mr7tMf3g==
X-Proofpoint-ORIG-GUID: bqHaiMMX0JB6jat-AOZ85mrKHw4eVJZk
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95dac6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=rOHUGBc37_MNbdIC:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=NApzFvG8OdL9Xanj_wQA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: bqHaiMMX0JB6jat-AOZ85mrKHw4eVJZk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX5EKVS3qtvdtP
 ZQtw8u7cLPpzt5QgNNHdnud6TLh8nnuYtrzO15LwFc38Mm+tfD4NP/C/n/uHuxQvqZ2E3wHo9lq
 N18BQ3ZIuFp0BDsqqlH3Np16wnV8v7g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Enabling a PCI function that is already configured will result in an error.
Simply check if the device has already been enabled, and if so, return
without doing anything further; otherwise, enable it as usual.

Also, because enable_pci_function() prints its own message, let's remove
the duplicate message emitted during the virtio PCI setup steps.

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/clp.c        | 4 ++++
 pc-bios/s390-ccw/virtio-pci.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
index ca9565d8de..7917f13345 100644
--- a/pc-bios/s390-ccw/clp.c
+++ b/pc-bios/s390-ccw/clp.c
@@ -82,6 +82,10 @@ int enable_pci_function(uint32_t *fhandle)
 {
     ClpReqRspSetPci rrb;
 
+    if (*fhandle & CLP_FHLIST_MASK_CONFIG) {
+        return 0;   /* already enabled */
+    }
+
     rrb.request.hdr.len = sizeof(ClpReqSetPci);
     rrb.request.hdr.cmd = 0x05;
     rrb.request.fh = *fhandle;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index f501252c81..231ab6e04d 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -452,7 +452,6 @@ int virtio_pci_setup_device(void)
     VDev *vdev = virtio_get_device();
 
     if (enable_pci_function(&vdev->pci_fh)) {
-        puts("Failed to enable PCI function");
         return -ENODEV;
     }
 
-- 
2.54.0


