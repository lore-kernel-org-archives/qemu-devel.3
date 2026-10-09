Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D9CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFL7-0000id-Uo; Fri, 09 Oct 2026 14:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKy-0000Zv-8O; Fri, 09 Oct 2026 14:28:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKv-0001hz-La; Fri, 09 Oct 2026 14:28:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha5Rq592884; Fri, 9 Oct 2026 18:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JJxtrGwYI1kyFPZ/x
 dVJwpKY+R482bJ/wM3Gp3RXhao=; b=Wg7jsqEjHq1yR2ltZP68TkaB7NpQmj5PH
 rkUF49VP7P4qAtFioRqrBwdw5lhf6DtiG0sJDe1BU9ltUjiFuJ+Gj3FyCFKDKwhp
 0iSIPhiUYJ7ky58qrNmXTM3/1BtQ3lZilUwmASredFOli+1pZPx6mL0Jp5ylLwut
 62QrPnWqK9oteEupGinIAK6CXjatPR0RJaRfAr8Nx87/eBg45i1yV2DkGx7FOiw5
 4v3RCoiSSqm2U+H7U7Rqdq9/+auzIHESrbzFeE2S/BmmZclV02Y8xPGIG5jCcudY
 46C2dr9eBPsmr6oju1No7Qdt6edXD0sYj9bbh0+Pi+Rhx2qxOyZ9Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg8by-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8QGk4126010; Fri, 9 Oct 2026 18:28:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u45nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISoFQ32178850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66B7A5805F;
 Fri,  9 Oct 2026 18:28:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4767958064;
 Fri,  9 Oct 2026 18:28:49 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:49 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 19/19] s390x/pci: Reset a device in error state
Date: Fri,  9 Oct 2026 14:28:25 -0400
Message-ID: <20261009182825.148054-20-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX99CFAigjLw+H
 bNkzAmOEV5qRLHg1fkR1RZh5Za49pGfO9iH5NiMsGuWr3HLy86+MbtKAp3dWZNQG4SffxijF8mH
 vcWtLXwAFi9ZAXNGkAJqaUsOXXhJHkd1mG55O3DE7fi6+vYTByUU/6qI+dxkAZzCl+XEB/GTPqn
 HdpXz8P4Fyr/PKThD1OSi9YvTMWvtC3vkTiEANtLO6xB/IF+i4lZitCas7xslYqUcumtEmJixxd
 ZKqq8cuw7xxdvnn+dq5XyHvmzHSKyNLGSx4LzzZlGyM5FitJDdkKglAGNpM/lB0kWvm6S0+RAg2
 0unYSXYdMyiR/4ANd8jzteqGsPLCrNX4icGC2IJ3Y2xAguU5qxgh8GiQqAQ5kHr9RfsqxusN2P1
 i/f9IcTEOybvtORfFI53g6yFspA6fs4qSX9JBzv+Zv87WoekaOUfI+JSBIeIGJzJfXoLj/j5t0Q
 vp265fuNv8Lh9dtw7kQ==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac93264 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FuZLNSxbJke2QbDKExoA:9
X-Proofpoint-GUID: aBdg1ijXhkWhJNCMFuhw3005Dd1ShxA1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX1/zNg7B6Rsgv
 N4pb0fj+f0Nd0wlGLq+xlYG0t4At0j/Qc41bOVhMgJxaKT/mAIC2G72BCphVahmcPe8cwGSLTCW
 xPYEN9SB2JwtYypoc+RKpDsjYGHx3BY=
X-Proofpoint-ORIG-GUID: aBdg1ijXhkWhJNCMFuhw3005Dd1ShxA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Farhan Ali <alifm@linux.ibm.com>

For passthrough devices in error state, for a guest driven reset of the
device we can attempt a reset to recover the device. A reset of the device
will trigger a CLP disable/enable cycle on the host to bring the device
into a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261005174314.871-3-alifm@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 53ed79d17a..2724b27ec2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1786,6 +1786,21 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        /*
+         * Attempt a reset to recover the device. A device in ERROR state
+         * can be transitioned to ENABLED or DISABLED state via guest
+         * driven actions.  Since this code path is also executed on
+         * subsystem_reset() and the expected state of a configured device
+         * after subsystem_reset() is to be in a DISABLED state, we need to
+         * transition from ERROR to DISABLED.
+         *
+         * Linux guests drive the state transition from ERROR to DISABLED
+         * via CLP_SET_DISABLE_PCI_FN. So it should be safe to transition
+         * from ERROR to DISABLED state.
+         */
+        pci_device_reset(pbdev->pdev);
+        /* fallthrough */
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
-- 
2.56.0


