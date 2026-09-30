Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA04CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAb-0008Gc-UP; Wed, 30 Sep 2026 11:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAZ-0008CQ-2N; Wed, 30 Sep 2026 11:24:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAX-0001zy-Gc; Wed, 30 Sep 2026 11:24:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5bqZ1335969; Wed, 30 Sep 2026 15:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yY5GacTibTvZXzAEK
 X+jjlWyEpFRvJYd594FU9L2WZw=; b=nwJEWmQjr7t0N7JFjjpWvmjfROPdKALP9
 8Bd1uMkW6iSanUdIQ708xMW1Ys3/zrzB4mqdc82P7KWB+MzoMYgTxrACSLzbgQFg
 FGQwSmdsiX0EkQETKdVgoJhS/s8uYPwAO58rKBJweDjOeJH9pWRPf5ChgQakw6NN
 Uaev/ZNpzNIrqsXN/uuL1eWCnwp7Wabss9QDqjsk/HUfpEbzPOWh4t2wv3ciJFf3
 v7xo2hqn8b+S7Gdfm7E17YBtYcMe+Z0/rhZJ/MB5B+GVpfkECW+C4Obe/AtklKx2
 sugue8T5lo5W3S1RdblWpkRBwreF6Knd84RhAxL+L2FcBOe81yo8w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrdtvw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE39S32287821; Wed, 30 Sep 2026 15:24:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pb3jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOPQD32309988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BAE158051;
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A75595805A;
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 06/23] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
Date: Wed, 30 Sep 2026 11:24:03 -0400
Message-ID: <20260930152420.1956230-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXyUWFbuBu8WEn
 6yRRCOLNVAMmtpOg8sOdYXku6EpJR/V/37ltgw0DMpsX+4Kd/O9rUa9dKOUgusfDCdlGPsKtvei
 eVZIodQza0BBWeFMVCzNAhBSB78E4bLQXMevO+b7oSoP5egiSsDzDHFtSNdW7/f81ANH9d2ePqI
 VBsLi+MLRi0mkRASQ/vqg3A7p+LjSxVZof8inpG0zXjbKL1iT0KyTy4SE4sCNW+8aJ2La/gWjF5
 QLgW2n5ui9L8uAJDHJxL7XpowCBKIO22QERdRmHWqWhP3QTtjHYmDen+odcyQsPBv9iTJfUv85G
 fvXIdNMQaPKtHlQ7gyFsDioMS8dNeAWQGAMOvInPCXzYPFJqvAFwxHQiDRS5n478qcBNrj1KJo+
 kzUM7wB7EW2Rp7W0pjhcupKjFnFHZM7fmNq4VWDxvBjqVUMb9XhOztFbmuRDaRIpgIF9YwDiTcv
 PZ9u6VZnyZ/aH9lz7ig==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abd29ab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=cb2EWknS8209ijoe3xIA:9
X-Proofpoint-ORIG-GUID: CkAxj3SQUuGMh13Qof7-pGGIM9_kMwkm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXx4EbZstJpgfv
 Gc09f7xpEMm8hlU+PapBAjSX/u0aTz6EQZeZFy5o2YB3eW6o3e7DkT6H9XLOBsg2ffYevVNT1Uj
 mwhXsFU9sWFQkn7u5M23NjbBtz3szcI=
X-Proofpoint-GUID: CkAxj3SQUuGMh13Qof7-pGGIM9_kMwkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
receives the contents of the attribute struct as its payload,
rather than a pointer to the payload itself as is convention.

This may result in erroneous errors from the ioctl, which would
result in clear_io_supported being false when it otherwise could
be used (which is helpful in device recovery).

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-7-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index f833a3996a..5e6d422fba 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     /* Check clear_io_irq support */
     test_attr.group = KVM_DEV_FLIC_CLEAR_IO_IRQ;
     flic_state->clear_io_supported = !ioctl(flic_state->fd,
-                                            KVM_HAS_DEVICE_ATTR, test_attr);
+                                            KVM_HAS_DEVICE_ATTR, &test_attr);
 }
 
 static void kvm_s390_flic_reset(DeviceState *dev)
-- 
2.55.0


