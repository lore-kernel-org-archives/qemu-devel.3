Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01737CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAY-0008Bj-Is; Wed, 30 Sep 2026 11:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAW-00089Z-KP; Wed, 30 Sep 2026 11:24:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAU-0001yz-TH; Wed, 30 Sep 2026 11:24:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5J3d3170634; Wed, 30 Sep 2026 15:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TRK0BKErCtNVoD7Tv
 P6+q+2IsWkUDt53dP0K7/PMcFU=; b=InZpM0VoWO/3jw/SF5+8jQZHYegN5g8pY
 Ape5eZHHTfNAM/FVOm+Y21FMrwPtJAYzWN0uSpBSMTQlvZEEY3SYckxZl0UTnOpt
 O4DhpNaT+2PldPnTyQQJLcAr2N6Z2otbpPegzL3LAjx6CFEZ3dFlnRO9q0cHPMUg
 yi7P8g0tOX9efYST9qmCpUpl1A4lmyhriPKGbIalqnrhjlvcrtpaNULAu3WF7T5w
 CHwX5roqu18Hbkkwr3jBpNs0/PAa1WLV0iS3QTehP2bVj4bW4sWVy5VPau3rGjzY
 I09PbhombKYNYO03TYTKhLnaD/rYNXg8MxVbBNAeiiXrG0yWbFWig==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5dtqv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38nA2287796; Wed, 30 Sep 2026 15:24:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pb3j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOMcM000868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 202E45805A;
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 919EA58051;
 Wed, 30 Sep 2026 15:24:21 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:21 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 01/23] virtio-ccw: Limit ISC to MAX_ISC
Date: Wed, 30 Sep 2026 11:23:58 -0400
Message-ID: <20260930152420.1956230-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX4agOkTCPrmFa
 E08SHSErDfdhVkBFfv/M91Q9YqPSo/XhHEryTvYzEUUPss3zxTR+29vRhU+bbrMYtilUoSjH3D4
 D36Jqe2V++sn8iLBNqNEx8egIkC/NjI=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd29a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=o2FE-jkhVZ_mc2e-VYYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 282tYkktETkbfkC8sMAgpM0Tbne0nAli
X-Proofpoint-ORIG-GUID: 282tYkktETkbfkC8sMAgpM0Tbne0nAli
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX3DsWHQRtqnP5
 SDlmSQZ5ZLoPBIExdfuMnSnxyMPf1pofFJHkeLOO/Pea/gnUullHx6s/MU4ePzOPDDVFL55Omr/
 wlZJXe7jrrLy4z9OKvu6Jj0iyR6Ayv6rWwz0dD0y4P6GlJbYjOu+Ub/EfM2G6hmE+n4JTTQlMfF
 HlCJ+X/BmptXBDl73AOX2+A5LEIabqPIEQblumW8jt73gK+1tpKx9jk/lNRCvAztMYr8rr4GPvx
 F+QqKE7rf8FV9gHsOvgoc9bLKeBgDgoB9C2bMrYaCL7fhuQ61WrMZxfYfPZH9Pny9Ul1JYux/qC
 LAqcWN91T1ZzIrAnLylMapUCZgRgw4cQrzBLubRILi7TQ7ajoOj55k0DN7k440wUCqDGSynLJqj
 TlwVRpZcCEIeLLjH7BhilFCBwhwFzU2O4XX3a/rgHvECyG4ToKbXyT8yZvYf2mUodiko/120gSJ
 w7FW0lFxVEU9MMViL5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
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
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-2-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c        | 7 ++++++-
 hw/s390x/virtio-ccw.c | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 76dbca3bb9..9da9128d88 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -654,8 +654,13 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
     S390FLICState *fs = s390_get_flic();
     S390FLICStateClass *fsc = s390_get_flic_class(fs);
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
-    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
+    IoAdapter *adapter;
+
+    if (type >= CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC) {
+        return;
+    }
 
+    adapter = channel_subsys.io_adapters[type][isc];
     if (!adapter) {
         return;
     }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 30fb2c0681..eb6378ea4c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -46,6 +46,10 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
 
+    if (dev->thinint_isc > MAX_ISC) {
+        return -EINVAL;
+    }
+
     ccw_dev->sch->driver_data = dev;
     if (ccw_dev->sch->thinint_active) {
         dev->routes.adapter.adapter_id = css_get_adapter_id(
@@ -659,6 +663,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             if (ccw_dstream_read(&sch->cds, thinint)) {
                 ret = -EFAULT;
+            } else if (thinint.isc > MAX_ISC) {
+                ret = -ENOSYS;
             } else {
                 thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
                 thinint.summary_indicator =
-- 
2.55.0


