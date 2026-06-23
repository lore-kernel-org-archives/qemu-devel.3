Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2563BCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc1zt-0001If-HH; Tue, 23 Jun 2026 10:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc1zW-0001BI-Lw; Tue, 23 Jun 2026 10:20:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wc1zR-00062b-4q; Tue, 23 Jun 2026 10:20:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmjbr1858065; Tue, 23 Jun 2026 14:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Oo1DI1cigjYHEXJlO
 Cc4hvYNnEir0As+KBxL/muY1u8=; b=Hsxx+CX7KgDIETK0jLs1m4+EYyA4nRo/G
 94d0v+jT+lopFjYc37Drg9bttlAXUfKtUS2gwXIfIYWB0gOA2N0jSDOCbYpgrpp0
 hrCki0Zw/7tbx6eghUBuFvzxrQj22cU/P53rI5vOwotEAKzbBqzDMswA/eilObKG
 7TlT+CBezHBvQImnFFtfeeiGgR/sITtBaEG9FUd8eX8Jdtg+pCjl4RP4zb4+1lQQ
 Qs+3T5DDYsrwatKTk+iNrjWw7TvqCKg5nqMu03pEEu1PNyCv6EHgPGkh3fAlNa9f
 0zv62WQsVHtXri0tpWLSg0DAQZTlgM8NFN9vQFKPCae4LmeXGpg6w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:20:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJcmt016927;
 Tue, 23 Jun 2026 14:20:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3ne8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 14:20:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NEKTbF13893930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 14:20:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33AD420043;
 Tue, 23 Jun 2026 14:20:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30DD92004B;
 Tue, 23 Jun 2026 14:20:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.165]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 14:20:19 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Date: Tue, 23 Jun 2026 19:49:27 +0530
Message-ID: <20260623141933.577981-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zY29oYf-Mng2kbSTbR7dt-ryP2AHWUcg
X-Proofpoint-GUID: NcIYaBKxD9xmGeuaoVZd2LyEUwyfAL0Y
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a9632 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=gL735G7rtJRJJwX7cZEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX/1wvyjBxzrrL
 nm+i+w+8UHiUgK+trOC+UXpJbv/8qBT29vuxn1IGoSB5aOC2F/sKFeQOQkZikDywLJJM5/BBLPz
 JCGTNI91hZGjci6wfX2yF+fh6zmf+fLoC+ZdvrwtaawXXyWrQuoVXl6KNO2/tF2XnYMHbdMZn4y
 HqQjBWKWQ5j8pEX70AgnmX3z2hs7fuTJe7UmN2zTLbZ48LeXQ3Je9vea7VJI8dbJe8Zc7VC4RrT
 uAsQqBbCoXiOyzbZvxyKdDLEOez3ByQj0IkZDsdSoIQGDlGfr17IZO0o+1662ZGStXjMzrVxuj8
 0FZVve1ag/dFBDM5Dp8OgetlZNYQHw6BD3ML09DFUvpmSsjyJsCeFKBvmwI+etXbpqvSXG64l/x
 lAxk3uLicfasBXPVxrRfMWKgN9PgIK9UAMQOpmNsBvw1u6GGcfK5C2yGGkj1g0ntnPSLcot8NsE
 +NdaPs2f8q5J3IgqDHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX0oLe7glAZPJO
 gOpzNFVNFbFfw7iqL0hCMue0EvvGP4tB/D8/cKXvY2NTofdBKEgGYkS5kiz1tDEYrxCvLYCja58
 bTalRIFBMe5GJibdkySFSdk/n/lrJ90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

Currently pnv-spi-seeprom-test was hardcoded to test the 4th chip in
pnv_chips (power10 as of now).

This requires ensuring to update the index when removing/adding entries
in pnv_chips, such as when Power8E or Power11 gets removed/added in
future commits.

Iterate over all the chips instead, similar to other tests in
pnv-xscom-test.c and pnv-host-i2c-test.c, but skip older chips, since
TYPE_PNV_SPI only exists from Power10 onwards, hence skip older machines

Tests all the pnv_chips similar to other qtests

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 44e0b92730b4..721129cd39ab 100644
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
@@ -100,9 +101,17 @@ static void test_spi_seeprom(const void *data)
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
+        char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+                pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
+        g_free(tname);
+    }
     return g_test_run();
 }
-- 
2.54.0


