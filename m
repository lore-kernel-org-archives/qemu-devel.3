Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B53EC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29pS-0000uF-MA; Thu, 03 Sep 2026 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pR-0000t9-9X; Thu, 03 Sep 2026 11:58:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x29pP-0006rC-5l; Thu, 03 Sep 2026 11:58:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DVcZq1977380; Thu, 3 Sep 2026 15:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=L71/X1CRqsCfDlqm8
 PzyUT+3FcNN+dC9zV+GOkV/qV0=; b=Hqc+WzrGxIHcm0IqMbJ+TYdAL+Hhk32NK
 LIPZPXWkT2Dp0rcZLuIJOqbt27MfsRcQlLo2r9Aka7bgTlTSeauBvkkl7mO7o/TB
 4k3g1q+EPMlrm/or3ZuOHVlLGOXaDajxENSriRbQVNg1tyJTttdtTCHakBDx+837
 o4DH9FpIPyPJDIkSA0uiFsb9fm/u6+AjXxHHnghS68RHyoZS609NkFd1sb532n+D
 0ndzlQl24WvvaV6Y/XbgctH+0KsLElqJUYy0cRBSK77sDQVXxLwhcWkM3C9q2Wcj
 5p5nY6b5nopsSEIZNRNIRD0YTlPxx/Qbd8Aj5K3v3LXsNWiRV2S7w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue5brn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683FuI1u007185;
 Thu, 3 Sep 2026 15:58:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkgbvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 15:58:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Fw55R42402062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 15:58:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA4ED20049;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EB1720040;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu,  3 Sep 2026 15:58:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 7F4E3160DFB; Thu, 03 Sep 2026 17:58:05 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v3 1/3] hw/s390x/ipl: Add secure boot support to PCI dev IPLB
 builder
Date: Thu,  3 Sep 2026 17:58:03 +0200
Message-ID: <20260903155805.1881366-2-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903155805.1881366-1-jdaley@linux.ibm.com>
References: <20260903155805.1881366-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b72aTVlnqmym22wVQuOZlJyA6WvKoEWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfX6sh9u2J71gUv
 i3INOV7H03xMjAc9EScTIIkP5DZVbiqmArSiiwTZ3YuZm7LVXYb6k7a7N9YyrntUrjL+mKtddIN
 cx1kuJqSqM/MSg4khxLPfTs3KE9ZtxTaA9AXfNMDmmltrguIxa5F6KOwmKlsjcsW2Q0aoF2dqk1
 47wXpwrxCTtkm+K4zAU01KuClI6xZWWlnqUGMUTcGvImK2hkmV7YDRAz0IWP/Jz5MADiDE1OCQ3
 hkcPbRQHxxbVNu7n4TSjF7szxsTVFvDGR2ye6aiKNTTEhDs61XHEgJuSuDVpmVuZvVFAbLmTSd/
 MSzVs/tOwWKJQxh65DJClxrNg84pygpiAfhsk18L4U00qhYmBLtBQ3lWHOqhKJtWdKQ+vxprBKX
 UZz+1kQzwfi+rmlNP1JG3ugx7S8ZzpuZ6HtEng7qnekdKb0/0Xa9PeH5qtxECVUnjjC3aDEiljL
 vYnm/idHuetFVwVFL7A==
X-Proofpoint-ORIG-GUID: b72aTVlnqmym22wVQuOZlJyA6WvKoEWN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzNSBTYWx0ZWRfXzUrZWRPFrZIx
 T7La1MfZATi5ANdWkoQ6qJBIeRcJ1lzwGNI395Sh7WiBJC9lVqZ1rDZigBaXnZGptmo4yWggdF2
 WcV4T8bdwipDrh4zzhP49LwF8kQrF60=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a999912 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4QctWtjvTb62bRHQMjcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

In the PCI boot device case of s390_build_iplb(), call
s390_apply_secure_boot() to update the IPLB when secure boot or audit
mode are enabled.

Secure IPL is now supported for virtio-blk-pci boot devices.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/ipl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d59ed36c783..b0da3cbb278 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -599,11 +599,6 @@ static bool s390_build_iplb(DeviceState *dev_st, Ipl=
ParameterBlock *iplb)
=20
     pbdev =3D s390_get_pci_device(dev_st, &devtype);
     if (pbdev) {
-        if (s390_secure_boot_enabled() || s390_has_certificate()) {
-            error_report("Virtio pci boot device does not support secure=
 boot!");
-            exit(1);
-        }
-
         pci_lp =3D object_property_get_str(OBJECT(pbdev->pdev), "loadpar=
m", NULL);
         if (pci_lp && strlen(pci_lp) > 0) {
             lp =3D pci_lp;
@@ -625,6 +620,9 @@ static bool s390_build_iplb(DeviceState *dev_st, IplP=
arameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |=3D DIAG308_FLAGS_LP_VALID;
=20
+        s390_apply_secure_boot(iplb, devtype, s390_secure_boot_enabled()=
,
+                               s390_has_certificate());
+
         return true;
     }
=20
--=20
2.34.1


