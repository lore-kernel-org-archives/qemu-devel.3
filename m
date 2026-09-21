Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F804C982F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKH-0006IF-Sh; Mon, 21 Sep 2026 16:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kK9-00066l-Qt; Mon, 21 Sep 2026 16:09:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kK7-0005O8-A1; Mon, 21 Sep 2026 16:09:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8ZLt703577; Mon, 21 Sep 2026 20:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4Z38P4OupDQscBXCP
 AeMX+qM2B60MlQgO0RQFGt4TQ4=; b=EiLhdOjlFkKImDfujM9CMsxMvhZ14MxWe
 s3vodgb3T/U/496u42CGWaG92mp36B7UF94PURGIqv2YDKR4tZ39yIBLWlckyb9E
 O6wmw1IDJTm+3GjRPlqbLjAcyODWaSlxyY4qdpSZOuogQ55pAClWmdyEWW5YDN1h
 tAJM5CXxrm9DcTte03lrR8X4BNodV4iPQBWzDD4TIm2DETTbzfO1ROhGL/immHk8
 sY2ONQL2i/HAdXVCw1591Bm4JBoMP3dDFPh0SpNLT5LY1YfH/EoiGt36sm1JWCIT
 r3Uh9LzazWW52KScQrD+0aj/YvFxk/1Bcz4V+5pe3Si/LtlUp5kbg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqa9e0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJSllt2399662; Mon, 21 Sep 2026 20:08:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy6nbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8kjk53019066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39CA25805E;
 Mon, 21 Sep 2026 20:08:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAE8E58055;
 Mon, 21 Sep 2026 20:08:45 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:45 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 24/33] pc-bios/s390-ccw: Check if a PCI function is already
 enabled before trying to enable it
Date: Mon, 21 Sep 2026 16:08:21 -0400
Message-ID: <20260921200830.1302919-25-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab18ed0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=rOHUGBc37_MNbdIC:21 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NApzFvG8OdL9Xanj_wQA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX35+oPeR6j03T
 Nw/R6jgrRwZl5e2mFYXWUPcXmF+P+7FLXAzLrV02AQ5NC/Sy5/A6yQbjElgT/qTZaMPky6AtwDX
 Lox0UTMsG5qnI1rq7ZrcWaWOtxxAgzowseScc6QtgRPdiFqnBiVgZUUpryV8a96Zex4B6qEGy4U
 Zcx4z1ubfud1LBPKtIluczB4YMMqFw9aIY9owi1gQrjH1ThqieAKugqhO7pcIf9jn+iGna2MMUZ
 IsLKunL8E7ZOBl5HxcWOHQ+LFPXMetYMxgu7/WMnaBtoEj2kkLZjXtuYBiDLWacFWtWa3vb8jSK
 /GMhPlggqhPztQHhmlpsdCHCyfQcapFGg+49emh+tSLAs5mgiX2HzSI5U/LmTXbstNvmqsvAZbE
 oCoY6bvUn84QwwikE/g3nj9KQB05h2PtEaa4KEUpV2WsXcL32Uc6cCtlnfmfA3Bkg9Y+woF9t78
 KaUVt9uFk351Msw1ggA==
X-Proofpoint-ORIG-GUID: 3q5dNCWM83aAjZoVM_HnXbQA-kwITUHW
X-Proofpoint-GUID: 3q5dNCWM83aAjZoVM_HnXbQA-kwITUHW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX79PGhWKaJb0U
 /9/8h6H8Qbk67I+TwXeVKxRpHN7K06v48GJrSLcsSTIGt+lrtyHmJIhDshDg8CTnXWd8z9LgwdW
 rL0VPpXtOZHL9LtEW3Igrl5nKkX9xvY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
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

From: Jared Rossi <jrossi@linux.ibm.com>

Enabling a PCI function that is already configured will result in an error.
Simply check if the device has already been enabled, and if so, return
without doing anything further; otherwise, enable it as usual.

Also, because enable_pci_function() prints its own message, let's remove
the duplicate message emitted during the virtio PCI setup steps.

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-2-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
2.55.0


