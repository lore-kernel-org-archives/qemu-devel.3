Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC68C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzF4w-0005IC-P3; Wed, 26 Aug 2026 10:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzF4t-00057E-PR; Wed, 26 Aug 2026 10:58:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wzF4q-0000n5-VJ; Wed, 26 Aug 2026 10:58:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1fHk3084964; Wed, 26 Aug 2026 14:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7spCe3Y67e+3MfoY2
 7xIuIU3+EB/uJwsVYFYmbA9LS0=; b=gzolVLAUCjO8HpoH1LecSl9GlMhy0pHn0
 S1a6H0zP/Ai+k2+zOIvAdwLmErMXuc7+81Dp+PoFdAF1hedCrjKjdk/iDHEe7xj8
 n34LgBMfCobNPFPG29OQQ1STKRs1vFQ7zqoVjYUkeo135SRTuYHq0yzPIhIakbTy
 YSxn8WY7BndryIizC2L6pNvr3UuOZBvvfg6kxxLTppR3Ee9p0GDStOxuZVAxHkm5
 2av0Vuj6R2GJw5RltMvD14lAi9lBhZaFDQkpYenuiZvmamd89Im3TTlg3G8+Kza4
 f9feHTGyvuUVQjUlNRNtk1x5OLkeFMCObjIKhCDK7YgxP/WazLXZA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eqa8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:58:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuIQj020662;
 Wed, 26 Aug 2026 14:58:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwanf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:58:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QEvvmG47120726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 14:57:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4BED2005A;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEA702004B;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 26 Aug 2026 14:57:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id 92798161693; Wed, 26 Aug 2026 16:57:56 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v2 1/3] hw/s390x/ipl: Add secure boot support to PCI dev IPLB
 builder
Date: Wed, 26 Aug 2026 16:57:54 +0200
Message-ID: <20260826145756.2324598-2-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826145756.2324598-1-jdaley@linux.ibm.com>
References: <20260826145756.2324598-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8efefb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4QctWtjvTb62bRHQMjcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX4+eH86Z9ODz2
 QSTUwzTH4J62pOI/iJZLy18pDCpQeuQGBw2P0RPTNprOhJbmCbGOHFLDImpcADevxfBoRQ4ICVb
 /aQzM1sL7n5q+esDDlfqHSEuRM5vgek=
X-Proofpoint-GUID: XpnIA_aNDXM8NPRNrJpRrXExIE33VC_e
X-Proofpoint-ORIG-GUID: XpnIA_aNDXM8NPRNrJpRrXExIE33VC_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX4rHY9tuAU42q
 MnbdPbIGF9rkn3vaB/Ty9kGYz9frSR6PHK8CMp6sUjeOZij9dBB7k7gYPOA6F90LSFZGqYATVff
 usyzxs+o7rw0iJ4eUbZI2B1IG8hV2sNrcSOsGjrvAAq7YRevI3XhUs4YCYPxwwvpnqfmO/PVfyS
 Mjrz6wPXcCnTYSQTYpa4U3amaLMCrKICYN0g3Zeia9e76sXTq70WMsjird3PUlTdoq3X3GPRwwj
 OY0hZq2DahcqIOh+VNElea8mByDzyYxoeSd/8ShkKMsjZ0rtxahVBo7oGgeGIV8IKF0MwlPphoY
 zpsuSj/hnOZjeLpX3oVxb04IuWHwwGkOL4VgG82k+Ad6wq2AIycj4N8bDOhLDdqXujOuxAgurCP
 Owq1QOyiVvruqLjlo4FR/px9BTOerdwkQD4GhUHpdiOP+sGVop/HWdhYQmPWVpraYv+cC7L2mVM
 DpOSbgjVXPeuvq0W5nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260121
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
index d59ed36c78..b0da3cbb27 100644
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


