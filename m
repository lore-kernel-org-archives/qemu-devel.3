Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6106CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlkM-0007lJ-1N; Wed, 20 May 2026 14:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wPlkJ-0007gA-At; Wed, 20 May 2026 14:34:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wPlkG-0004rl-3V; Wed, 20 May 2026 14:34:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KHpFj51950620; Wed, 20 May 2026 18:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ZgBwAXr8emsaabnntqaPrgAxKnEboW2/3RRBNALB2
 w8=; b=EVBj9tZhKavPo1QPLPRCxRMHgnmfkJvTM1zX4S+6Qm+yINU7BZFacmSWN
 bdffMQG0THtujjLnRB2myBnbqXZAJs9jvyMGP6hZs4pTeu92CdnsXDazdPgrwJ4C
 IjD8gd5Vuu0rWPmmpEwXKub9jeOpc97xIitcbo9UWBchkRW7AYAMb7yAdXeZGBpq
 W3j3TJ+Wb3WWlWtlyXnXcB56ble0iJ1cpKkydgZj9EmzwF7wN48zkBaPdQDDQLDz
 DaJAgNG7VBthyh1MA8nEqpTozVmI1YwM5JkhsHLeqVdeLqLZC3fxpk7cFdRVFh+P
 P9PjvvGiY75f3+jt+B9FQ6fJw1PBg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88jdmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 18:34:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KIO6oG004654;
 Wed, 20 May 2026 18:34:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8u4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 18:34:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KIY8Or23986846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 18:34:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DE4258053;
 Wed, 20 May 2026 18:34:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B931D58043;
 Wed, 20 May 2026 18:34:07 +0000 (GMT)
Received: from IBM-GLTZVH3.atx-us.ibm.com (unknown [9.16.58.46])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 18:34:07 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, cohuck@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v1] hw/s390x/ccw: Mark virtio-pci disable-legacy property as
 optional
Date: Wed, 20 May 2026 13:33:58 -0500
Message-ID: <20260520183403.223983-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o-OA1ISbHLTb2-Dqlc91OITyHswAeP80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfXy0MOogU17Xx0
 wsC+mOZzqbdt2WJA3eIPwd9mPIkbm5sfro6K6nDl68URoAbJJi0R6E2wcyoxDt1VNLnxCdeHmQD
 6sGDtXo/kbhG2/DGwzZXXH9fJkkz6lq5ZfbAp7PM0ax18PbQy6xeWiWCI27u0tnHBWkbbPX/5JF
 9IeQA9dRCRC0u+atUEfWakD8hFFyAWys2vH1JhZpn0NAmLf6uSqJzzB1cZ+Hi3hE393nGsYabn2
 xG1O/Hv2u6l3WGRactnF0Wu+F5Ak6NZboDvrzq1GPK8Tnt5xb3kRDbb0Q9PtUz2Z+m6NK1wrFQo
 dVdWcj7uIjdCGbjGld7o/bp02utGqfTje6L90vuXrs8sxP4iiKSo5Vp+wAJeBVJxrpsHhiUPVqq
 Vso+U4eT5GiFb3vR6n6+XEHCn5eEjY5WJr6Hdarlu296/sONyvePWR8GwAnWYY/GI/reNcz3utw
 sK5h6Ksc65rrQ30sQcg==
X-Proofpoint-GUID: o-OA1ISbHLTb2-Dqlc91OITyHswAeP80
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0dfea2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=viQzzXmSu9F1O3B2SAwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The s390-ccw-virtio-11.0 compatibility property for TYPE_VIRTIO_PCI
"disable-legacy" causes QEMU to abort when instantiating
vhost-user-fs-pci devices:

  Unexpected error in object_property_find_err() at
  ../qom/object.c:1284:
  qemu-system-s390x: -device vhost-user-fs-pci: can't apply
  global virtio-pci.disable-legacy=off: Property
  'vhost-user-fs-pci.disable-legacy' not found

The issue occurs because some vhost-user devices like
vhost-user-fs-pci only implement the non-transitional variant
and do not define a generic device type. Non-transitional
devices have disable-legacy hardcoded to "on" and do not
expose it as a property, while only generic device types have
the "disable-legacy" property. This affects users running
older machine versions (11.0 and earlier) even when using the
latest QEMU version.

Mark the global property as optional so it only applies to
devices that actually have the property, allowing vhost-user
devices without a generic variant to be instantiated
successfully on older machine versions.

Fixes: 26103c13cff0 ("hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)")
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4d35f9b10b..25a9fa4955 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -946,7 +946,7 @@ static void ccw_machine_11_0_class_options(MachineClass *mc)
      * keep legacy virtio-pci enabled.
      */
     static GlobalProperty compat[] = {
-        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
+        { TYPE_VIRTIO_PCI, "disable-legacy", "off", .optional = true },
     };
     ccw_machine_11_1_class_options(mc);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-- 
2.54.0


