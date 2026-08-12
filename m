Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B354C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAmD-0002jM-Qi; Wed, 12 Aug 2026 11:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAll-0002L4-OY; Wed, 12 Aug 2026 11:21:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wuAli-0000Lz-1G; Wed, 12 Aug 2026 11:21:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CE1UWK3686520; Wed, 12 Aug 2026 15:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XnvcytaxzBWsti3q/
 wFAhz65I4nqWmdC67U8fj1MKX4=; b=TP6zddMEXld/2mOHbjD5+zsC7UMeHIfXR
 6CIC3PgFiKZB9ZInGhE5MdTRtRSB0dWBDrVAyS8E94X1elrT3wVjcvu4sjIFzEwV
 nDaYSEKPN32VvZ/Te2HNAGCEtGI9hbVmxz6XUftZ5YWFBKsFnthMcxnUjwbcDy1U
 /LOh8UeooDqEwAUM+XWrhTJEeiv5sFDGaJzrOJZAzvkyqPxI5sfhfr0qHrcFIacJ
 FOppmrkvHGGKf+m2UoELSkZ6thjuOXtyYe0EAG+/HzIwI6XrHE31sRYNqtFZwpJj
 PqLOjQxFuTV55ZJ9p1KoLnoIJNJ5Yz12cddK1GV7LaVSrrzLZE13A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9u7c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFBG3Q003223;
 Wed, 12 Aug 2026 15:21:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6e1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 15:21:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CFLD4731457788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 15:21:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2E412004B;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C74CD20043;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 12 Aug 2026 15:21:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56370)
 id B02A7161222; Wed, 12 Aug 2026 17:21:12 +0200 (CEST)
From: Joshua Daley <jdaley@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, jdaley@linux.ibm.com
Subject: [PATCH v1 1/3] hw/s390x/ipl: Add secure boot support to PCI dev IPLB
 builder
Date: Wed, 12 Aug 2026 17:21:10 +0200
Message-ID: <20260812152112.3330493-2-jdaley@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812152112.3330493-1-jdaley@linux.ibm.com>
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX6NkKfJEEKSr5
 VTMSQHg4FD1HWQkVNRP7cguWqoJFGRG2NCy//5Nf/yVIQyKrUvikdoHaBxcxb7XDmRj8C6jcu90
 yu3lm7sL+3TvZ+vdQy/G2lhz+GxdsYCVsY0MpinbuFwEJBaHrvyZwwv8NRftCCSKNK1zxirH6Q5
 gU+XbF7tCAv+L+XtQjawvXdIKsXJGgrVmtqL6OTxyXvMrhho7dwwB0vhnpAIsXst6ItAmHMC7xd
 mFdPsiTgQYnVadWStQUVqXYdy9CwpkVM3ZHlpPN6Er242VhXTmYfgb+N/2qggHH07jaryMmSCGo
 5xzf7Q7HKF1FGGeIhrMZ1ZGu9gM8Bw5Aeb+Ed1tZHf8QfrZI7KbNghrqzU2M+6cWw0HneQMjI7m
 zLNu4ndilv78kZqwA7DUvRthWYf0xYEuV5hKwvouq4RhT44w3r+8QrnnrqWcnmKZLZV0PUdk1sv
 LE2EkM5HFL8t8Mhortg==
X-Proofpoint-ORIG-GUID: nK6ilDJBIXnRYcl9fqNMVfkAFgnFS6cj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX2hwDTZmO/dPX
 KTa0ycEtQwEcJqOQf8L1Lhuwf3rOs2V9bhsW1u6ljVbL46Eg1yL4XsU9YSr52QgqNNxN5iUe3aK
 mYVEtlhDt5uipv6hebc9Uxy8XnKhvZo=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c8f6d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=4QctWtjvTb62bRHQMjcA:9
X-Proofpoint-GUID: nK6ilDJBIXnRYcl9fqNMVfkAFgnFS6cj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
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

In the PCI boot device case of s390_build_iplb(), call
s390_apply_secure_boot() to update the IPLB when secure boot or audit
mode are enabled.

Secure IPL is now supported for virtio-blk-pci boot devices.

Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
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


