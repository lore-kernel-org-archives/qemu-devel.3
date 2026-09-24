Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C5C9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9YDb-00017g-AY; Wed, 23 Sep 2026 21:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDY-000161-S2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9YDX-0007Lf-28
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 21:25:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNZmji569262; Thu, 24 Sep 2026 01:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KZJnzYue7WWe7Vi2S
 kaJjrYjVg+Wm0wS1eF999/2WzE=; b=Vg9AXGaxFnWOtPUZJ0wm4tieFb8Wyescp
 /B6I+SHiBgxwfIFGHYz67qNc7Tz4CsOSEcW+CkpZBuyTeloRAr6Gbme5m4aCVWDT
 5xiOLR+GAxGb2Ne5ZjPA5SrilagIGMYGzkxZ6VwbpnioRGsGsTGV2Iw4Ux5ijUnh
 rjdB9S/g+VPZKsd/IS5f/xlrejnugR5aWfbW/R/ADlyRgwOTDFPuQpu5G0aD1MdM
 tHtvobZdipVQ5zV/uM8rkCN1+P/2JQAjVkZMBNfcc2uqyw8sWnH2WuvdfrngMhdK
 X9Ze7SY+xX0/8seyyjcYwFzC23sepUA9PvGIeyNHnBsFC2MVuvmUQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsecv1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NNHSdq1079959; Thu, 24 Sep 2026 01:25:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2uf3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 01:25:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O1PdLZ65601918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 01:25:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44E0D58061;
 Thu, 24 Sep 2026 01:25:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B91C758059;
 Thu, 24 Sep 2026 01:25:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 01:25:38 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 05/10] hw/tpm: tis: Use uint32_t for len to avoid truncating
 size of command
Date: Wed, 23 Sep 2026 21:25:22 -0400
Message-ID: <20260924012527.858527-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924012527.858527-1-stefanb@linux.ibm.com>
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab47c15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RY3EVia8NYhRY2h5:21 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Q9dn6whS7C7IXuWMxioA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: xRA97vmJgKbVd82JXMtSA9-38aL4d897
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX9Qjw5qbR8iQP
 941sSd1U0TKFEM0XRB4mFX/7X++MgljLxbDbRXOaiUtSeuZM/lAooUG3tyTQqxJcubZbJaqj1Ls
 6o+22MGFpoio7ManOzbYSsOXPr86AeBNGqOxsZhWJomzg/2jvybeJPa/isxxPhq9NjD7g8uSGBv
 oib3Q5zIV6uvf71asCGkhYRUVLrRMW8GspUBuRVtZKmMdP+vphFyaa3v14VMEmDQPCYzAE6Rfs3
 jDGpwpj2anhFN+ru80za4O7nuqSGvgmXkdTC+6bzbsQ18ccigZ19MeYhvvNe5/yXfV+GOvnlnLS
 eBH4h5l69qz2Dclgfs8ZnbfdQT22gijaj6UbvM6IOTNJabW+eZjgNOuHkeaU+AitrvI5raz+t6f
 YRnUWOy4sOwVHkcXEj6P6u/KI29VmBC96tU9XThk8LfcwVCX4czIKcL2VBFMi4r0Tv6lqox8rU9
 1JMNxCKtrOIW4za5+Bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAwNiBTYWx0ZWRfX6n2OzxHwcDrI
 TIISsw+rmfWTT/ytxHkSsaD/c4fN1bN1gzGJBtUDWrg4KIPQTaYwwmSQiWkLwqiYqMmUPz81Y27
 2SIVhjbYPewJ6tsNo5wLtbjZB2FakUo=
X-Proofpoint-GUID: 25qADrRBje_zAHLzo4qVgklnteF8b53B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_08,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240006
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

To avoid truncating the uint32_t return value from tpm_cmd_get_size()
declare len as uint32_t rather than uint16_t.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 4ba228116b..8fa1bee771 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -481,7 +481,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
     uint8_t locty = tpm_tis_locality_from_addr(addr);
     uint8_t active_locty, l;
     int c, set_new_locty = 1;
-    uint16_t len;
+    uint32_t len;
     uint32_t mask = (size == 1) ? 0xff : ((size == 2) ? 0xffff : ~0);
 
     trace_tpm_tis_mmio_write(size, addr, val);
-- 
2.55.0


