Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C50AC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQom-0007zY-6o; Tue, 18 Aug 2026 16:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQob-0007vI-LQ; Tue, 18 Aug 2026 16:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoa-0000kG-3v; Tue, 18 Aug 2026 16:53:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJXPbp1296031; Tue, 18 Aug 2026 20:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WbZUt51KHA9NwgZXv
 5rbrlcZZonj3r1OvqGvYCOYKm0=; b=rf9H/G+stpG7TA00NeTCocsd1oPzDPWBs
 exNQQJT2eOn37Kkzr0clzPF3ItnvmSN0YhEFM6RMH9SIkAOjOrTt3ZRLjPlHzMo+
 4VSh8qg/2ehyvkWcTyg0hxudVdTOCggYszDM8SSvCqh4T8SdkKECM+FmqR+KLIh7
 K9XmePREhdp92yPVKvhICPEtKblm0TQFevIALAGhTG2OcFXzCaBC6nH2wUdKqcdQ
 cWPugucQH0FJOrxUdO7/1UjQFR7+9gDA0ujhJH0XfHpxB1rnz2mE/oeSeKHDtbqg
 /4IOpwQKbRTmzkFJq2cZj0stQqHto300pO8TYYOqy/8/fDdl2fSeQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frta88t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfKcH001335;
 Tue, 18 Aug 2026 20:53:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek5e2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKreDR31523392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C17B58054;
 Tue, 18 Aug 2026 20:53:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E196758045;
 Tue, 18 Aug 2026 20:53:38 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:38 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 6/7] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
Date: Tue, 18 Aug 2026 16:53:23 -0400
Message-ID: <20260818205324.580199-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205324.580199-1-zycai@linux.ibm.com>
References: <20260818205324.580199-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84c656 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=PkLLOfym-WlFbigP99UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX+UVNLWsY9dRY
 wDsQ/mBhk2CFWdpSRM8NuP0I5EDMOlRz2RQ/RPJai+xCsDxLuGEqDr67o/o+nEyTOWkXrAYZYIG
 ONutd3g7abGAwzbwDX/eLnahXpvOoJc=
X-Proofpoint-GUID: eKzb7gmd1HMXj8BhxHe3B3lI65NqMB1D
X-Proofpoint-ORIG-GUID: eKzb7gmd1HMXj8BhxHe3B3lI65NqMB1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX9XrZl3W5fv6Y
 IimrHhSoueOMjIi49O9oGsm/CMmWBPwVbX4Pz5KCQPZqea9zIVoNHoIGnLWYcNIh9vZ3kOVIQlN
 OfW3bgw5ZWJVxXG534Vxq2CVMa01CarmMMVmeJBeIjkK3vekhDn8uj676On+Jan0IFPT7QGa/id
 O+PNsVpsGS65Y97skEtvHoWpYZ9I8DPYb5SCDWZyl/gUoS2TFQdz2p8DKk0vt0u1NNKtGdOjgMz
 nH5wU2E3of1rBtYGHwa788+HtH8kSbNOqOu/7b9FecdTwKZ77IVNGUioLjFD3dY3a++ewUtg7lk
 LKPy0jA47xO+PVmNAAKB1mlDqtwqjBmf25nN5ELq16cjpX8L1WrVEMCMhxe1bFzoaX8xammeRnS
 jeg+UEBYpsFx6aHKsVA0TSMYy4A2bXF6XpVmcvr9LCMCq5VvSZ923mBW+PNPB+P0GqhvJi82KJ8
 dSCORvfH0nYMhU8uYUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Add test coverage for virtio-net-pci network booting on s390x by
including it in the PXE test suite. The test verifies that PXE
network booting works correctly with virtio-net-pci devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/qtest/meson.build | 1 +
 tests/qtest/pxe-test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620..94e2555935 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -281,6 +281,7 @@ qtests_aarch64 = \
    'migration-test']
 
 qtests_s390x = \
+  (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
   ['boot-serial-test',
    'drive_del-test',
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index a3f900fbea..d4b74e28cd 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -60,6 +60,7 @@ static testdef_t ppc64_tests_slow[] = {
 
 static testdef_t s390x_tests[] = {
     { "s390-ccw-virtio", "virtio-net-ccw" },
+    { "s390-ccw-virtio", "virtio-net-pci" },
     { NULL },
 };
 
-- 
2.55.0


