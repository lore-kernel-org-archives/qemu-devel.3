Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7520C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vN-0000Ce-3H; Tue, 22 Sep 2026 16:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tu-00081u-3p; Tue, 22 Sep 2026 16:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fi-76; Tue, 22 Sep 2026 16:15:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI75pd1129420; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aJBAKsAe03AT8vnFU
 rBRwGAoE1EpNeTqykTgXnfAVKk=; b=dNaV3zQBDVdqhYT/Nhf/OWIeSBFbzS6ZU
 QUdSvkRWNNbwjuHPQVCwsrNto3pfmbObzFgrBcoyQyOM97p+o6eD9/iHn9MZ6Bhq
 hOcuuwAbY2s7+CvwiXvFSCgzfR6H/cFLghjtErnzcZHSZ/XA5/R1jkjm/BnBuYoK
 C6qQPE8te2oj4be8K4mE8MESEAvoBqlTTA4oP1zqcjXFtWF3/F48PjdapUx39jvK
 GEPQzzdImAley5Q9rlRD/GL1nkMACW9xBxTwNn4RWjvn2Ehr+Gh8l8/WYJHODmHX
 zlyaMPXBdAL0EE67fRFgQU2ep3lNW+He4V+BSXEh8Bsvm/f/Nr75w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ftqw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHbEN3220323; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vkdxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFRx252166936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A4692004F;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78BD12004B;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 5E8F816142E; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 1/9] virtio-ccw: Limit ISC to MAX_ISC
Date: Tue, 22 Sep 2026 22:15:17 +0200
Message-ID: <20260922201526.2383047-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m-biI9B_e6ZKapVdyB7NTuikANb767hi
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=o2FE-jkhVZ_mc2e-VYYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX4bH9Q/N9tuQQ
 aug2CQS493PLzuGOgK4xR12ua/QORGYTzD/wj2vEzDJt3X18PoHjLIPbxVTP6Ee9WdG/wRGwW34
 wfrX4ThYSU16riGbXOOXf+mfUrjdBnhGU/NkTnvZgWOtJi32X8iYNw3UeLFncOhW74c79cSH1E6
 2gWd6+Fip5tDzBFmo8n6bS2yTDhAdQlIZDzi/Yyfos16CKfnliy5fVWVYBO0LRqD7R3Ru+vT2ql
 8/aBITwTcFSXYufZTrg8Js03FG0Lnp3EJtu9q5ecxmunGG6TK2GzoqMou8WOu0l0nUB4OTIGeA/
 mAIXC2wlaGsHhAKrYCrJxJe0dvqGrjZWH72QkyWJTQK1Nkna7rEO8f/Gb8RoP2F8TFQDv1TEfJw
 zC+p2kWIs2DD0ZHxuxTgvn1/ARTdJNMHTV0tl8BVGqj1VrpBRT0T7FxIryREc37kvYItk053sFR
 lc4K1t9+FlmIbTzJVvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX+QmTzGzxPFxw
 4IwQkNJydASoc0I9SKIXcVjETj/Ie4DLNCdgbsdAM9HOzhWa/SgW/yHZhI7egV6MlUckcm9+mIP
 E9PL1p6GG49C9rNe9Dsb160nJ8UByD4=
X-Proofpoint-GUID: m-biI9B_e6ZKapVdyB7NTuikANb767hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
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

The interrupt subclass is often defined as a uint8, though in practice
it will be within the range of just 0-7. Ensure that a guest-supplied
subclass does not extend beyond its expected range, especially when
used as an array index.

Cc: qemu-stable@nongnu.org
Fixes: 25a08b8ded ("s390x/css: update css_adapter_interrupt")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c        | 7 ++++++-
 hw/s390x/virtio-ccw.c | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 76dbca3bb9..9da9128d88 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -654,8 +654,13 @@ void css_adapter_interrupt(CssIoAdapterType type, ui=
nt8_t isc)
     S390FLICState *fs =3D s390_get_flic();
     S390FLICStateClass *fsc =3D s390_get_flic_class(fs);
     uint32_t io_int_word =3D (isc << 27) | IO_INT_WORD_AI;
-    IoAdapter *adapter =3D channel_subsys.io_adapters[type][isc];
+    IoAdapter *adapter;
+
+    if (type >=3D CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC) {
+        return;
+    }
=20
+    adapter =3D channel_subsys.io_adapters[type][isc];
     if (!adapter) {
         return;
     }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 30fb2c0681..eb6378ea4c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -46,6 +46,10 @@ static int virtio_ccw_dev_post_load(void *opaque, int =
version_id)
     CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
     CCWDeviceClass *ck =3D CCW_DEVICE_GET_CLASS(ccw_dev);
=20
+    if (dev->thinint_isc > MAX_ISC) {
+        return -EINVAL;
+    }
+
     ccw_dev->sch->driver_data =3D dev;
     if (ccw_dev->sch->thinint_active) {
         dev->routes.adapter.adapter_id =3D css_get_adapter_id(
@@ -659,6 +663,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             if (ccw_dstream_read(&sch->cds, thinint)) {
                 ret =3D -EFAULT;
+            } else if (thinint.isc > MAX_ISC) {
+                ret =3D -ENOSYS;
             } else {
                 thinint.ind_bit =3D be64_to_cpu(thinint.ind_bit);
                 thinint.summary_indicator =3D
--=20
2.53.0


