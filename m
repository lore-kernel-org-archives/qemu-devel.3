Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69D7C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6R2D-0003T3-Li; Tue, 15 Sep 2026 07:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1x6R27-0003SU-H2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:09:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1x6R25-0006kY-Oy
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:09:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FA1e8d366146; Tue, 15 Sep 2026 11:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gJFMZ+7UKcMJ+JKAA7mn4Bn5YKtZ0WkeHbjwAgMtr
 DQ=; b=oUl+2grLSAL5hqAelH8pVMbodv2+JzxaOjsP2TWkFrBV/jdq2suh/Qi4T
 22ubwqgpSeP5D14bml7zY7wnNhhNnj25vlwVNXsaNHnApzIZ2py6unfjnwNdvsVJ
 8lVLZM/hYCWgwcVEhWd6sDOT7pOw85R5GW6i6vXCQHpqcJmsHdTZMFnL7K20zMi7
 Ba5ZMeLxHm2GWkbr1dXBAp2gkbtIka9xpkZUJMt572t0imwpNQ2icd7A+bch+iYI
 A+FZBKlr8+9xYulP6ZIZL044zljGuVzQFIPuTi9yjSLzW35OO8hDSMhlTIdU6gPw
 +r4hl0kSkzqLPiPLoZdfS0cxixM0w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hpq79-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 11:08:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9o8gB512469; Tue, 15 Sep 2026 11:08:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d1k6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 11:08:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68FB8vwQ16384420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2026 11:08:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE8BA2004B;
 Tue, 15 Sep 2026 11:08:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B511B20043;
 Tue, 15 Sep 2026 11:08:56 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.56.140]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2026 11:08:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tests/tcg: Fix building outside of the source tree
Date: Tue, 15 Sep 2026 13:08:41 +0200
Message-ID: <20260915110855.491985-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE1OSBTYWx0ZWRfXw3P8sT5PqA/Z
 Fyt04IO3t2IrZUJSvnPLOo0k1c4mW8D8huKYasa+qZbvYXJlOWXtFVvGX2fpZoMQ2SWx9ifI0lV
 vIir3bu1kEhkcCVsf9j0ccbuHBDaY/zF20h+4RsQUKVAWn7iH12aatpUoiGhNNcOuzXOOFL1c8G
 IBEXqpqRmetdflHRCeXz0ylzaC2EnvVQ2EiO8WlP1X4XV+XXB97L1OJLL3KkXWdgGCQ1yDkz94V
 /qoqzaPuxjQ/pMxQQ1tLaCxPyBO4kcoBVGZpQgSmpEU6yRI1gm83HSDczgrZUOMcc31zFDbShRT
 L0a/dqiT/omxCy0PACvkFdZaP/ZNG3n/4cBvhIFC73BRQSftJDusHaUjSpDkaQpwOG1BbUKh3Ra
 p3cpe7Xpo/86gk5r/CCb1CGLC1bfBRL3yn4XBSt6Er89emQY9r7Cp0p3styXdps4efZBjDsWxvO
 bVSv7eFK8CDFebky3CQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE1OSBTYWx0ZWRfXzyblf2gVxl22
 vjNZFUhZkZrysGhVTwC75yniBgx61K+shwS+sD9NSeYW7EOIxNhBGKzvmUnHXrdhW5tF1m0kGuP
 +GAQcxGY0OgA5nmBnsL5ZCCRGne16lc=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa9274b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=QnZgAXV4qX4V9HuNx1cA:9
X-Proofpoint-ORIG-GUID: ayzQFHarjl0MmOkSj1V6QROUFkEVmk5H
X-Proofpoint-GUID: ayzQFHarjl0MmOkSj1V6QROUFkEVmk5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

Running TCG tests from a build directory that is outside of the source
tree fails with:

    [...]/qemu/tests/tcg/multiarch/libs/float_helpers.c:228:1: fatal error: opening dependency file tests/tcg/s390x-linux-user-float_convs.d: No such file or directory

This is because the build directory is not mounted into the container.
Add this mount. Do not bother with preventing overlapping mounts, they
are harmless.

Fixes: 27939ad414ca ("tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d41a228fb3d..cae64efb06c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -269,7 +269,7 @@ foreach target, plan: tcg_tests
       mount = mount + ':' + mount
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
-            '-w', here, '-v', mount,
+            '-w', here, '-v', here + ':' + here, '-v', mount,
             cc_dockerfile, plan['cc']]
       has_cc = true
     endif
-- 
2.55.0


