Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB88C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgee0-0004O0-HF; Mon, 06 Jul 2026 04:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedb-0004H6-Va
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedY-0007b5-Uz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIWlv2197965
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tQbmRetQo2bmZgvFM
 yKukoRsTJOxM8Z2LgeR1rBLVQ0=; b=jkmQkk4KEkUQAnAlh0883HHaxqHBiGntF
 Q3DwbBwVxVcp1UM9wK2gcE6O5Ry39w++aKY6lZt3Taresz+zRo8PAyu1cMsnzyVn
 zcdaHrcgkdH4bkfdibB6wLbBZ6u7E2rhRhrNcUdMgcDMMon80FT8+i2IEsWFxoXO
 Vsd/1odjxPQ50Nh3nkx1VY4K4qOr1AvkhbX8ku7wZBiuce8PWlKhETd7Gm0Zilyf
 njsFMGcWBoB6j18B0AtS7+57GoQdgGUIfSl99BFa5lAewjBmsCZNgqONpETU2DG3
 GLQwXkn2rqFtvg4ANIDeDsqL/LAXen9xbfMwONZN2KJymdROxZrcQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4gdyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:25:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JdZB014648
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:25:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjvr3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:25:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668P1AO43254104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:25:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EF852004E;
 Mon,  6 Jul 2026 08:25:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 394402004D;
 Mon,  6 Jul 2026 08:25:00 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:24:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PULL 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Date: Mon,  6 Jul 2026 13:54:45 +0530
Message-ID: <20260706082451.59299-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XvhuN4bZMGosatfq7cq11owigE-BO7eW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX598UVNO54NLi
 65jOrqz1oR5F84Aq8bBorr58u0Gu+lrMYJUHge6rO/r3J/AqgqAnYPRK4DTZTBq+QO07trlm+Mu
 bIUavenklB2yn4QLNLCtiHxemRxnhexDPkaPiiyZFtZNLY47TfI9vKagYVFQjUntHodBP7lHljx
 RzR8O5DSV/DPsQWhL2bgo6Tg/IBfiyXvySbwzG9K4ETpNIDPlXC8J4ZVt4ueKCBcTMU7KAOJsRG
 AMWBdt/p3uZqF/RxNELIrdrAL2K9IDFrfX+wrP015Ra8ZYtWYaW+BaX+X8njBehTIwvbamx7ud2
 OQh51VrzB7RJ9oGd2ZsEvbY0zOEWSX1CHKINPZfP71wnFV5F6dvxlRf0soaxEhQl7+geRqjTlHL
 ucFBDKnjF0PRDO8RBi1zJcOWXrMEsx73JxuNsoSRoBLarSP5fKzmId9dsg/2PaNJZzN8zrDcRgD
 fLPaacncHgM1Zv1944g==
X-Proofpoint-ORIG-GUID: XvhuN4bZMGosatfq7cq11owigE-BO7eW
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6662 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gL735G7rtJRJJwX7cZEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXzujjvJa2oj6w
 /EkG1QM3VXngehrhTvYLXjqJr1YSBS/vNO0pplf53zBfqv3IRmGqduoZRq8VQ+Qg5DrFSALjfxS
 402IJ3RJv/uCysZKtunV1b3ZaYFQ/kk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
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

Currently pnv-spi-seeprom-test was hardcoded to test the 4th chip in
pnv_chips (power10 as of now).

This requires ensuring to update the index when removing/adding entries
in pnv_chips, such as when Power8E or Power11 gets removed/added in
future commits.

Iterate over all the chips instead, similar to other tests in
pnv-xscom-test.c and pnv-host-i2c-test.c, but skip older chips, since
TYPE_PNV_SPI only exists from Power10 onwards, hence skip older machines

Tests all the pnv_chips similar to other qtests

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-3-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 44e0b92730..1a78e8d966 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
     const PnvChip *chip = data;
     QTestState *qts = NULL;
     g_autofree char *tmp_path = NULL;
+    const char *machine = "powernv10";
     int ret;
     int fd;
 
@@ -87,11 +88,11 @@ static void test_spi_seeprom(const void *data)
     g_assert(ret == 0);
     close(fd);
 
-    qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
+    qts = qtest_initf("-machine %s -smp 2,cores=2,"
                       "threads=1 -accel tcg,thread=single -nographic "
                       "-blockdev node-name=pib_spic2,driver=file,"
                       "filename=%s -device 25csm04,bus=chip0.spi.2,cs=0,"
-                      "drive=pib_spic2", tmp_path);
+                      "drive=pib_spic2", machine, tmp_path);
     spi_seeprom_transaction(qts, chip);
     qtest_quit(qts);
     unlink(tmp_path);
@@ -100,9 +101,16 @@ static void test_spi_seeprom(const void *data)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
-            pnv_chips[3].cpu_model);
-    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
-    g_free(tname);
+
+    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        /* TYPE_PNV_SPI is not instantiated for older Power8/9 machines */
+        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
+            continue;
+        }
+
+        g_autofree char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+                pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
+    }
     return g_test_run();
 }
-- 
2.52.0


