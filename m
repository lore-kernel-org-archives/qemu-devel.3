Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A24C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgee4-0004Q5-0i; Mon, 06 Jul 2026 04:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgede-0004HU-2r
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgeda-0007mS-Eb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MISa42427801; Mon, 6 Jul 2026 08:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TiXkjj
 O+1enboyWYwMd6wBc7BflTvpA5asGePAwa4fQ=; b=png9vkKFOs9zc91UqTNNiL
 vvWJoR35sD7CZSKzN7xfRWE7cAuVG+BR+9Cc00VKo7Bv/ynSASQTr7UACtCaYPpJ
 cdaY2EFEgUmEt+dmfKlQ/+pygLfPS8ucAcWViLCsfGyVJmR/dxDrWjIKoADlsAtG
 x/Mcjg4LD8SjvEoLqozUaNY8x5zKEOCwHc5mIyN7NFl0+wlorYwq5bMCRQT6ujIW
 YV+tp3SaexTjUCQsEG22oC0sJ5WqK7U1thIPtgEtctYVIczRSyRAYQ2hKYz3E2Y9
 zaJSJ7/ZqGPAWzhZUBCVhxPGaKdFCCTXd3txZ2gh4uQVfaB0xDWHtbD5B5wjQrzg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqgc5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JcCZ024141;
 Mon, 6 Jul 2026 08:25:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4mnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668P34k47907190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:25:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C642720040;
 Mon,  6 Jul 2026 08:25:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA45A2004B;
 Mon,  6 Jul 2026 08:25:02 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:25:02 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PULL 4/8] tests/functional: Use default powernv machine instead of
 power10
Date: Mon,  6 Jul 2026 13:54:47 +0530
Message-ID: <20260706082451.59299-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX40PX0q4aznRL
 Iaj4ozkHd0kyRYlIv+q74Be77wIKBHp8X8/iN/A2P6nWW5OfIARR94cPB6fXdsdenLcKj/vlbTw
 t1qBcztUSbBeSukyfhIkFgbCIXMnLus=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXzqG4mKfc0ukl
 J0V5dcPGFVMUMSwz10Wb4H5H5gbMJJISgaxhf+UcJsw3A3u4Pe55JbjGoVUobTKVFrE9SSqsNLm
 o6Jtfyjd70mRfRWt0op+LiM48YbDLutU6YEotbnwUfobC1xVO6YQFNsXSv3VmhnY6QiaOIr/BWE
 gPF7FS9bEujwdKFrDU8bYSTcywA6R4HCBF4RU1hseBwe00lC9TVjUrJYGsjkvceVIhjkSu/OYJd
 43oYTi3FpoMk4fx5gsYW1xukyTQxWv4GxRD/TPbqCcxb3vbpKrETyWw96M1GP+G75ojTdyCUHwV
 c9QvrFX7DvmNC3ZTSOBKopHGksTNIOBEF7KnCiROQGeaz6NOVsJ68czKOJT9tFqnvfi6DMekwHK
 y40ZRXzls5FS6IGTIhc1bHmgWjc0d/V6JZA9avoKyweeQW/caJWqeAT+WlYREVTiD/iDAbGwD2D
 JNaHcwojA14a4f4jP8w==
X-Proofpoint-GUID: MaYVombPG2OUsTIZL0xSGES8n78RL_n3
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b6664 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=87qQxv4GzNj1ccyGg9MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MaYVombPG2OUsTIZL0xSGES8n78RL_n3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

The default powernv machine has been recently changed to powernv11,
though fadump functional test used powernv10

Change it to use default 'powernv' machine for the tests instead of
being fixed to powernv10

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-5-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_fadump.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
index 7ea65974e0..c75095076b 100755
--- a/tests/functional/ppc64/test_fadump.py
+++ b/tests/functional/ppc64/test_fadump.py
@@ -53,7 +53,7 @@ def do_test_fadump(self, is_kvm=False, is_powernv=False):
             self.require_accelerator("tcg")
 
         if is_powernv:
-            self.set_machine("powernv10")
+            self.set_machine("powernv")
         else:
             # SLOF takes upto >20s in startup time, use VOF
             self.set_machine("pseries")
-- 
2.52.0


