Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104D9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQoj-0007xt-0z; Tue, 18 Aug 2026 16:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoZ-0007ui-KT; Tue, 18 Aug 2026 16:53:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoY-0000jq-3w; Tue, 18 Aug 2026 16:53:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJW7Mp1293771; Tue, 18 Aug 2026 20:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aP9wmXRqnnY2CBEju
 P0jtjd9JNEhdCbSSu2tAGzEIk4=; b=Y4rWK8vZTfFE52NvgjHWKOox4bxk3MzqY
 JbjH5AKGF5q6ofFdouDDRXA0AhNEhTj+zYK6dPkArWjPXrYci8RYziPstKBLhp6c
 ynnsVS+nJmU1RG0/z9fsf2aJlfvSiC9OoeULE5MvqcVsmIGaRxBdt+6jnaOG1PGQ
 vVnpcNshHSr+8a5JjwuEC0oeO+rlpByxbcDV1GBcLfY8ImH79S3mkQJ+DIO34uK2
 qKB5ELYOi6yhFJJ4q9FynYaljE/T3LoHrxOkML+tEXaoGvZy2FQXr8TLr4m57KVr
 VmSXJH7rG5moNDSFb/Q68fU8pp1ys0OMBF0qQMkz+qtm5C4MyJU/A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frta88q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfKxV022628;
 Tue, 18 Aug 2026 20:53:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq5k0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKrc9X26280558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA0CE58052;
 Tue, 18 Aug 2026 20:53:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11A3258045;
 Tue, 18 Aug 2026 20:53:37 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:36 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 5/7] hw/virtio: Add "loadparm" property to virtio net PCI
 devices booting on s390x
Date: Tue, 18 Aug 2026 16:53:22 -0400
Message-ID: <20260818205324.580199-6-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84c654 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=kEjPX4MDc84h39DGsG4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX6vzuVmNvazo+
 +cH8j3IVqYy6zXP727QL+hqnn+z4rzPZjNL0xmZakLL3i6NGiDXBTETv7QwRArIwW5eCgPdxYf2
 LaNr7/FV5+HXsmHUuQhGn/uwFtbFzTI=
X-Proofpoint-GUID: xJ7rFLxf_xUSNQ0JAzgDqug4yipbyyx6
X-Proofpoint-ORIG-GUID: xJ7rFLxf_xUSNQ0JAzgDqug4yipbyyx6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX6Htt4csmTVp8
 fqj9XhWrRD9r1D1lfegFXKX1alR0M4BDd5vcvw2j7NEn4YROFCvnrSZVSvcoW4kzkHkQx5pc5XU
 fJsJhKJrJzEU+rsuwg4DR2C2w9zfzW8ympwq8ZZ1cUx1r8sJCLnVPMH8rt5cK1amwQr3vnu5FG3
 BQMApAiQGHR2SroGxDgNvL4FJ9yf6hDtWQlf9NppKa+hAT8YXDE6XCR51Qh5VUezxIYJNrX0pjc
 0pVsP/jnMPb3n4/UVpsx5wwEfD2qDUzyvyouRRXiCA0zXyldM39LJS8rCsArwpuLmuVZCVt+KYp
 xmlapITzwfTgAPnDkxEbCZUWtfv7mhGnNVqhjEbaCiq0/MmCzRT/VnS5ZRiiQrFCFR2gac3gy/S
 3ZACdaWQiHf2rvOqFe41eMIO4iA47CfXXN3oLBrxKpoQZ/C9/mLjYRALAcJCkpNJaUgh2atNKiv
 5SIKyCfcumWoAfN+9jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

s390x PCI IPL devices require a "loadparm" property. Add it to virtio-net-pci
to support booting from it on s390x.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index fd3e0303f5..893d1905a9 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -77,6 +77,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
     k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
+    pci_qdev_property_add_specifics(dc);
     vpciklass->realize = virtio_net_pci_realize;
 }
 
-- 
2.55.0


