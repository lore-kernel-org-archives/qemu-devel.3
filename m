Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC957CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEuA9-0004Up-Ix; Thu, 08 Oct 2026 15:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1xEuA7-0004UT-SX; Thu, 08 Oct 2026 15:52:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1xEuA6-0002hI-9B; Thu, 08 Oct 2026 15:52:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HZht42064207; Thu, 8 Oct 2026 19:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gDKY+FWO8cY1kxxan15rMOAaeaapYKk7llky00TJ2
 Yg=; b=YhUvFQsUNt01SKLLP/1VpSyzUw4QFM6+a7GD+9LC046EmbX+NUhlD5JbI
 JgUpoQaGy8oZL61/5KXQN2udE4iFU3M7h6vrONF8/Qwd5u21M6K7FxSRSdYGTIFj
 VVrQ1cIR+/bzInikv+OSgnMGyHWAzUeAv8G9wQ4s9Jpx/oMCaMzNT51zRbyosPAi
 FAyKC5YuTkBxEVi3ZmBWBHbXMiLMM7m9xjfyk0akEuAUKgN84uiHqlZEyAYrRlro
 3FEIQsKgJ+VXkiYN9qPWsa6w4AQx0XzRz4Rc+TpZSiNNaLMKx8bLgCrh2s9Aa4k2
 FMV1DSyNCoV62tnlCFn7KQCHH0+qw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvx8cg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 19:52:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HWg3W2564531; Thu, 8 Oct 2026 19:52:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tyws6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 19:52:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698JqDqo64684408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 19:52:13 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E91558054;
 Thu,  8 Oct 2026 19:52:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61CA25804E;
 Thu,  8 Oct 2026 19:52:12 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.85.144])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 19:52:12 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: shentey@gmail.com, zycai@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2] tests/qtest: Fix pxe-test build failure on Win32 due to
 missing memmem()
Date: Thu,  8 Oct 2026 15:51:58 -0400
Message-ID: <20261008195158.289711-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NRFXakH0J5-56wOtyPhNE-wEvwReOCFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX0PoZ1U7hbELD
 Pavgq+80Yf77IYKJDngBF8L1cbsswtyrDrQDx5tD/Me8Rs4yTaVulP2m7Ho4qfSLUj8tQrAz7zV
 ghIa1pWdUD/cE66rTFX4J/O5j0JNzyfgMqOhlOp026rfrUjpWB9kJYQEhpoog5jCsEcaX7RTjgs
 aiM4DTByNFif3h3EXXBqqNp5rZBcp8eavTGyoG3to+alCOSBvjY+8yJ7AL3e5vI5BqcnwXu94kt
 mnsGhOg6Tim/vR880uWALWUyKXNWL9KgeYj7naSOfOIxCPyYGxdf3Z4pkiQE8jwP/EvF2VGIuKd
 Wie3COYe76Q82rVA7qKRAKz1orxhmFxVSh5a3QEtgNoMUz42gQtWwyNnXJQ2gk2zf9yTpPf5Nq2
 zRXG4QQTBKrv+nzxbmLOoJsMpIs+ViLlv8Eu19YmTncIH9ULba3RDuCw+iRSjHOjPgYk8RYJTNd
 /QRMumiTCuGOGK7cNBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX3oGUcXp7BTOe
 tbWsaBY+9oy6uniFoQaQT5p6Zhviwg8yXBEEl/QepKutFaiaeqXpp7SDXHd1Y8N0QvVZ3hgEdul
 6Maa7dJxlUFoIjwT7G3tA3/ouhtFJiI=
X-Proofpoint-GUID: ZFwbyryidf73TyY7Uk3EiGqM6Y2J70b1
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac7f46f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=8LW1FKvlAemA4EBBcoYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

The s390x PXE tests use memmem() to probe the s390-ccw.img firmware
for device support strings before running each test. MinGW-w64 does
not provide memmem(), breaking the MSYS2/GCC build.

On Win32, skip the bios scan and return true; if the feature is absent
the test will time out rather than skip.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reported-by: Bernhard Beschow <shentey@gmail.com>
---
 tests/qtest/pxe-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 61c92a2df4..03e4054c5e 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -59,6 +59,7 @@ static testdef_t ppc64_tests_slow[] = {
     { NULL },
 };
 
+#ifndef _WIN32
 static const char *s390_bios_load(gsize *len)
 {
     static char *cached_contents;
@@ -106,9 +107,18 @@ out:
     *len = cached_len;
     return cached_contents;
 }
+#endif
 
 static bool s390_bios_has_string(const char *needle)
 {
+#ifdef _WIN32
+    /*
+     * memmem() is not available on win32; assume the string is present.
+     * If it is not, the test will timeout instead of detecting missing support.
+     */
+    g_test_message("\"%s\" assumed in bios", needle);
+    return true;
+#else
     const char *contents;
     gsize len;
     bool found;
@@ -118,6 +128,7 @@ static bool s390_bios_has_string(const char *needle)
 
     g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
     return found;
+#endif
 }
 
 static bool s390_bios_has_net_ccw(void)
-- 
2.56.0


