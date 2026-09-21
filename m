Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635B6C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izQ-0005RC-6a; Mon, 21 Sep 2026 14:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz5-0005Gk-90; Mon, 21 Sep 2026 14:43:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zn-5I; Mon, 21 Sep 2026 14:43:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Zil1860816; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aJBAKsAe03AT8vnFU
 rBRwGAoE1EpNeTqykTgXnfAVKk=; b=mcvihVLLp6pwESyf61GY1b95un8ZjEomc
 dWdc+rrqWKuUAQFLTfSou9POPgFYvvtoW6SEZpk1bPvgG/cRj1yKNgm0Tb3Vy2/O
 3grC03MHGBjMcZVqeIp//KDt4oSO7lqp29cCipUAf4GhOoK4tWDC/Ro03Pa2gkxD
 5HfR3pQ+343KSJZ1y0zKsNO81re5i623bqEVNQMl9mpE6aNr3A6vDDyY8IwR05fh
 LTBim6Y5goX2oyeCn1GI9T6GRBq+gLnuiZ+cih3j7nmcG0IBEbwdEc5EST8WDvg/
 +6p3qIQNDOm/vBbkZuuo/LxXLKoUHgZhJjbvs50vzJhzmuZSMEawg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2a738-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHeQU2399989; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy6cnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9O237159324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A93A32004E;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8488B20043;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6851416038D; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/9] virtio-ccw: Limit ISC to MAX_ISC
Date: Mon, 21 Sep 2026 20:42:57 +0200
Message-ID: <20260921184305.3791311-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2xHIJ-AVdwwbBF_t-Cy9gXXlN3BfghUA
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=o2FE-jkhVZ_mc2e-VYYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX5KVNHNBf8B5A
 9FG8pKC1y8/GO0SFO9mKA6bGgIaqSu/9z36/pOvf19NbLsvSpy5PuLxBVKwRbwCrMLfu6+sRUOz
 OCk66+n8n9/gmILMwQwzYkRZAXyc4QmBXZRRnztVsa7Cp1ZDEStGX83JsrjxkfmOZfRjY/Pi6AL
 /ZaGq7CAI/grc9jEGMvo1kBGIVBmED4SdNAu9MJ7eYAce4ilZ1tXz4ZP76mUtBa6ZiFKTTPNx6M
 ZdNnjl6BQPAIz6C49ZgDm1Syv2yBN3w75HUTgq5h1O25YqcsoEg5bV7wVP52sO2EN8LSENHlYbH
 CMloXAICc8xwSr2KENSDD5Qcr4vqGpclpG5HRbeCBCgvRxyONjznwQ5LNzzkne1aMRKAZ+19X5a
 T+nCrbEmQsw/6toTUGrZZeC8vn4Qhon2MzMmjW2VdHlDSyHvD/LNTOsFRDaF3TJ3hwS/a+xaC85
 kl4nkAkQvXZOasOQJpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX5+3qDV3egYLV
 Asuz13DLo/iieoiKNBJJDMlnUdLId/EbxIkDa2nXg9D78FyXkp8fxXuBa0T9aumSEceMlPa+/lu
 5Q/Y8Rt6GkiUSIh1QqBhtptR7Sodgs8=
X-Proofpoint-GUID: 2xHIJ-AVdwwbBF_t-Cy9gXXlN3BfghUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
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


