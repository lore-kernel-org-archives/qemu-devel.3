Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2204DC98327
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pRJ-000408-Ix; Thu, 24 Sep 2026 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR8-0003xZ-TY; Thu, 24 Sep 2026 15:48:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR7-0008Az-Gj; Thu, 24 Sep 2026 15:48:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5Zs21896355; Thu, 24 Sep 2026 19:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fQzxeG2c1QXfVbNWB
 r0gRpg7Ovvr7j78tqpuR5tkQSc=; b=M5kZMyRA9sY04NJpf6d5PVpkJzBfVXpyI
 0gXuX7ql+JGHgXhX6gyxRzRRL4IO7FTYV2g1L1UJihe0i27FsZxAtC8ungN/yecw
 Md8Vak+MFYx5zaQVZQGRuv0f8iSbThxh2Fa1rjunIZwPqKI5XaC9+Vh5D5yW6uIS
 Z8f+oholgEYTP1PAvvnucpSuF8ROH3wHPOMTFKBi9Zg7hWZAVphahIDoebT9r9E2
 zNJehKKAIBntvm0im+DuUHLYhYrfMdoq9llyQLV67/PJ2/WPYd6meA2K01uW1riX
 mDK7MFFnZeXF9cHx4ZCN9gzXZhaHXf9qsADV4I5niu2U/YvsjV1Tw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqteaa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlYVY2559304; Thu, 24 Sep 2026 19:48:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1yfjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OJmokX25953022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 19:48:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21AF258058;
 Thu, 24 Sep 2026 19:48:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94AC058059;
 Thu, 24 Sep 2026 19:48:48 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 19:48:48 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v4 5/8] hw/virtio: Add "loadparm" property to virtio net PCI
 devices booting on s390x
Date: Thu, 24 Sep 2026 15:48:34 -0400
Message-ID: <20260924194837.80732-6-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924194837.80732-1-zycai@linux.ibm.com>
References: <20260924194837.80732-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab57ea4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LEpY8eO1VcgwfWkpOzsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX47duqwgcujMo
 snY/SXjsEN6z0qt3wVQq7U3Z5zvF3Zl1AAzhYrFQ7peAiv1SjCoOHSHDUT7DHBQ8ezXqBYVa2q8
 Y4zRUQ/Y9kmO92PEufEffhNBYRjX+G5FpSycSGpFCGY+l++VAvNbB96vJI/4JZQ8EeS4wKrbgTl
 feM5Py0uW8Lu0fQyLJclT9XTJK8YrKzxaQqBleIQapEOlH8az5zGSCWHMIJ54V2TojhppKsHs6Y
 5WXmc3VBR8+pfajCObF0JsFV16o2tTink30ZZ7vV971Hn7eLIrzWtIhhAK8wWd/mIjsoaSt0sz4
 +tJV2qN7cssAtdTf1OgtRpobGNj4TBqK0UKLef79JLRJxhCMpZPzv6ONABl6Vf8TWq+fuPtapn3
 pcreGeloT6FDOkrQ2RnmljPi2F+pslq2+zyey1XivkmLsHUB14kVnCb1PZCbnxicz+TvdaQCp0q
 Xsvizcq6Cf68C/pSXLA==
X-Proofpoint-ORIG-GUID: LWv7NI-h_xs1LmNBUHOlTxtCLEw-YuXK
X-Proofpoint-GUID: LWv7NI-h_xs1LmNBUHOlTxtCLEw-YuXK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfXy6gMcMC4IgW2
 BZnXRslH2hqjtONGz1BIXBS8OwJsZ4rlcryuAWjbydW44DfE5hU7ZTSjaWlmcWyhpfQzGSCailg
 QrV4c56MoBoJQYDg9BGgVs55564moY8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240080
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

Add optional loadparm property to virtio-net-pci to allow boot entry
selection on s390x, consistent with virtio-blk-pci.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


