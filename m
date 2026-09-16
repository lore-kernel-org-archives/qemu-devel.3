Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A555FC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJm-0007hd-5p; Wed, 16 Sep 2026 16:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJO-0007Zn-Sv; Wed, 16 Sep 2026 16:33:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJL-00030e-NA; Wed, 16 Sep 2026 16:32:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1huJ046034; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ILf5TJe9Y2znuxk+O
 dFiNFiXdAyidaqWCS+8QOenYOA=; b=tNxSEKpe00NQZeXWsWNLTGhytAPfiGIsr
 rlE6zkwBUG+Fv4+9J7czZnEzOgyXOr8b/QMUu4Bn1cweSqk3qeZkRJHWbsJ9wx9K
 WPkJftFbDDV9YwvxB8xdsvNhUYurllAglYkMuydTBTeCdetIWUXO8IUzgVDcN9dA
 xP9OuVxXn9hhUWOokln+2mDhfdLjd3OeYs64AEqMU4xWKcdr4XhmtB/InVndeULz
 Q5+K2rSutvYx7rGm62IyRvHTMqubG76TOjAf/bMLWWllmXXvqNmxhfnrvxnM3y+A
 m0Bq467VOV1VQ0e1n+Rq3i6FOyZfhI+tygqXmRjVKP+k/i2Ojio+A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6enc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIwbWb1649282; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03c0b4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWkPG35193120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA6912004D;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 902A520043;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 79521160DDE; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 1/9] virtio-ccw: Limit ISC to MAX_ISC
Date: Wed, 16 Sep 2026 22:32:33 +0200
Message-ID: <20260916203242.2509787-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX7ELlZb1Xsna7
 uPVdbdgIiS27FJo/ad3oLb5bgHS7l6MwQ4NFsvzwChtrWLaL5HrhFLpDgoOcQpdAa8n2T6XLKCZ
 w76tq8fUNMiTvhC4U7ici63jLHXajhc=
X-Proofpoint-ORIG-GUID: qg_JnJhkwD8PVcKEVEnK6bzJCaLXHxnI
X-Proofpoint-GUID: qg_JnJhkwD8PVcKEVEnK6bzJCaLXHxnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX5lZvmGKpVwAM
 WNwl/0LSq/mv6snFvE+H5sTeSEwbKKBtTn4El/XjrhrNHpssVh9Y9DgW6VZ37ZzrprztcMHlo3Y
 iktyNLW7HXqEovTfYCXu6td8qf38ZVqT0sODcPrppad/iZHU8OiIv5IKlUptAqgGbI/O9qq0Mre
 HTZ03fEOMh94WIU5yLxG/2TQSgIc72moUQAnZC4HDJoSBPWpVZ10i1mSBoegsHlvxedLeYXOZ47
 FAxKi2aEtU/dTILrV+PMq7SJ1EUHJp6Pf+V/5+TIIK4n/VsnFbDn1qPgCJgHKHCqydaH+v1pcw1
 ejsfGlXo5SucKAzZGdCcQtmTPSt0RtejgwHXZRAk46W2QgVMakEg5Tt+2eNXgKEc2DsSk5hfpuA
 KWa5wXju3g8oWcdMeIn5eV5cbDcKCpv727izmO+Jh7jrUxl7amy5zB3vu9XYWhYzSIgXY0HrYc2
 BPBEgFmkaACFjBW5NLA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=osxc_5YrPWMs37QBt84A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160285
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

The interrupt subclass is often defined as a uint8, though in practice
it will be within the range of just 0-7. Ensure that a guest-supplied
subclass does not extend beyond its expected range, especially when
used as an array index.

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


