Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CEC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izM-0005OD-Gt; Mon, 21 Sep 2026 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz3-0005Gc-HX; Mon, 21 Sep 2026 14:43:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz1-000609-VZ; Mon, 21 Sep 2026 14:43:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8NeL4193604; Mon, 21 Sep 2026 18:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=33dBcRKi+nNEAHJlA
 fyo41vvgUGVDBeruD/O56vvJAo=; b=aJLHubZyJwHhxvjOXgezeCJkHW4go6vh+
 uRnRziltqLoGYT3e65yM7VlQZFV25Mtron9ugR3yGc3Trdav0APoiA8it/bQmBgo
 8+j9klZTdjPbJfWHc0RVujW6axiWjitWm3uhV8R9T+CLGq8w2/FmFX/WSM7zDg1o
 pYLdLS0lZkBcuQBXWNIbWodeAKvWswF0R5jBGiwAWLdgMgVNSAlzmGLKfOWlDK3E
 Mew8HWkQapTMi10WlrpNRWHY0JixcLJ8SMaxZXObsk9qpHwZtabolKxYG9YqSIaq
 2CRRJwLavcfo2fHYDGtGiemS+uHL5LKcu0zsCCUwHLVIabosFKgYQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1j78x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHX3w1408451; Mon, 21 Sep 2026 18:43:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjpku8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh98t46727554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCDD220043;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADE622004E;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 72694162303; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
Date: Mon, 21 Sep 2026 20:43:02 +0200
Message-ID: <20260921184305.3791311-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MVPSFVXXYuQ5_3k1pURhMB5e6xUC-i_1
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=cb2EWknS8209ijoe3xIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX12ojIe6BnFlc
 0UtXQgcwO7LErA7mz+aSBzwi9veT2ZCNRtFpbDiQSTMpOrjydYTdI7MT69IB739DWTtHtkkMPnk
 dbG+ldehIUdv6WsB77aLf057MxeJASk=
X-Proofpoint-GUID: MVPSFVXXYuQ5_3k1pURhMB5e6xUC-i_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfXwqsFvnChQ22A
 dc9YQFbhbe0WhbMBrLlKFj2LrF9NRDqFKBRqDUM1+aA0/D6DRuzyPaL0A6QDW1wy8wAo2SuK0gI
 Gs30E+gtRC/5qSqopntt6idqXewTk7cGdi/8r1dmIZtffcCLzn25C/kS2QlhJZsAFdDCgBV+3YH
 sJjlEz2boPHjaLsm40C+3M5Yf69sGK8uxS3TW4cpK+O5q+rGzrH8CoIjKoY/3lVv6ZWcgM01Rwm
 fsT5FGjuAGDMgkM99V25QWnWOWiuZzWSRy0X//qpHk1pWEbEQc/tDl8+jTI8KsTE4BcFpnm3qou
 WKyR4PvuVoL5kIomDHccrjZS7A6118VchEqE2E+JRQv5rLhSqQlVQXOJJliVJhCcVt4JB9exTbv
 NxnYL1pCh7YtgJPP1ZNyeUDiC8u9PL5PEy9Xd13RIPhBw/e5DsMgbRs50dBMYDUyMuH5XYJBKF2
 SNmfbqqBzaduWaF9mbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
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
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index f833a3996a..5e6d422fba 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, E=
rror **errp)
     /* Check clear_io_irq support */
     test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
     flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
-                                            KVM_HAS_DEVICE_ATTR, test_at=
tr);
+                                            KVM_HAS_DEVICE_ATTR, &test_a=
ttr);
 }
=20
 static void kvm_s390_flic_reset(DeviceState *dev)
--=20
2.53.0


