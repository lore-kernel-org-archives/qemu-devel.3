Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0FACA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEq8r-0005sT-SZ; Thu, 08 Oct 2026 11:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1xEq8q-0005rv-0b; Thu, 08 Oct 2026 11:34:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1xEq8o-0000qz-86; Thu, 08 Oct 2026 11:34:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EZvAn1615430; Thu, 8 Oct 2026 15:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=LkQFJfLLzFPLMws56KgJRgN9ekO0Pew1cOn71Hwys
 sE=; b=j64e7XMMPPUjShH2LffSMKlSuQk5CqokMJ09beNDiorseYb3TW/BhUe9k
 TH12sWm2eowY+9DRZO2J/iL9K2+nxNfppb9kdDrszNuX1I6A48btu9xzg8mULGWC
 Nv3BaRndK5Kzh63gbi4p7yeTWNd7BByYMgs8jArB+8rCAX91CKmk9AOYrj15FpCc
 BLLj9weiG0GpyDzX4B7SfLNx2uCUZmYXquro0lvkEwOMvICKybG/p3Sq3LidK5kt
 ZZIurpzrp78ubZ6sMRk7SaVsdIOmDvRKrgvq3fzbLUKCE7QjGdGAsnnL/Sr12ziS
 hnvf/h6alRWJpLcUDT4A1gbqITq5A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvmc5t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:34:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EXj063594262; Thu, 8 Oct 2026 15:34:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek81qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 15:34:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698FYbGc29229692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 15:34:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7EC258067;
 Thu,  8 Oct 2026 15:34:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 023BE58065;
 Thu,  8 Oct 2026 15:34:37 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.85.144])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 15:34:36 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: shentey@gmail.com, zycai@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v1] test/qtest: Remove s390x boot device support check in
 pxe-test.c
Date: Thu,  8 Oct 2026 11:34:35 -0400
Message-ID: <20261008153435.207538-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1UMOD5yYWgGvftv4VteSWmvpIOeGheth
X-Proofpoint-ORIG-GUID: 4aygAjaNQ3-WvHC_aOtLomIvj6K5Go5A
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac7b80f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=SyjWlHDdrRwBuD68TaUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MCBTYWx0ZWRfX1hU45+aE/JMm
 3juyapkekojB+UzhsXqHQSLCDuVfDA57huBE8vaSR3a2VDQpkfLyLFLXQWUTJz4Q84ZAfXHnOTj
 iiBN5lxA5VJLWrigYqWmQwmNV3idAGk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MCBTYWx0ZWRfXwA6d+LmBZaiU
 yOu4E6pKpiA8r3+40mBL798D+qgfLiNmv+a+2o9FLADqxC+vDXUzwulX/mnO5KuqcGuBARPk0as
 n9ze3kJ2W0J1bgUSjTIqNRTGjY0zu0Yh7qlwAWOCfPcgFTANCGvi2aVhEnRjX3nbiiGXMA1Idkv
 UAWyqfRXZyvtxuT3k2phQcK2SaUuSzWlusHwscK4ZVIjT1dslstaavY+gHPjdJjuNyxeBrEC4+s
 fGtbsaF8nOVsUDiL+rY1Vka0jjtAhsj1j+sZQy/8jHGml5rHpMVFIKlziynNHIgjWVKG6bbwFLD
 k9VoB28H8OIGQPCQD83gkgpzxl0Gsak7Rfqrz3CVX4YYqBWYWrxnkiNGHz/7reTCZgS4++0Rc4g
 l2WhqsqOHEXXXxMYFiKUjXDoB3BiCwAbIAzwB9CbkxlSuaI44xyHU3YSGVboTA6vgj7pX68Pi/n
 0RgKKqhU8f2wIvKXzaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080060
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

The s390x PXE tests used `memmem` to probe the s390-ccw.img firmware
for device support strings before running each test. MinGW-w64 does
not provide `memmem`, breaking the MSYS2/GCC build.

Remove the check as a workaround.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reported-by: Bernhard Beschow <shentey@gmail.com>
---
 tests/qtest/pxe-test.c | 97 +-----------------------------------------
 1 file changed, 2 insertions(+), 95 deletions(-)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 61c92a2df4..51e6bdac2a 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -26,7 +26,6 @@ typedef struct testdef {
     const char *machine;    /* Machine type */
     const char *model;      /* NIC device model */
     const char *extra;      /* Any additional parameters */
-    bool (*boot_dev_support)(void); /* optional: boot device support check */
 } testdef_t;
 
 static testdef_t x86_tests[] = {
@@ -59,91 +58,9 @@ static testdef_t ppc64_tests_slow[] = {
     { NULL },
 };
 
-static const char *s390_bios_load(gsize *len)
-{
-    static char *cached_contents;
-    static gsize cached_len;
-    const char *qemu_bin;
-    g_autofree char *cmd = NULL;
-    char dir[PATH_MAX];
-    char *found = NULL;
-    char *path = NULL;
-    FILE *fp;
-
-    if (cached_contents) {
-        g_test_message("Using cached bios contents");
-        goto out;
-    }
-
-    /* search the qemu binary's data directories for s390-ccw.img */
-    qemu_bin = qtest_qemu_binary(NULL);
-    cmd = g_strdup_printf("%s -L help", qemu_bin);
-    fp = popen(cmd, "r");
-
-    if (!fp) {
-        g_error("Failed to run '%s'", cmd);
-    }
-
-    while (fgets(dir, sizeof(dir), fp) && !found) {
-        dir[strcspn(dir, "\n")] = '\0';
-        path = g_build_filename(dir, "s390-ccw.img", NULL);
-        if (g_file_get_contents(path, &cached_contents, &cached_len, NULL)) {
-            found = path;
-        } else {
-            g_free(path);
-        }
-    }
-    pclose(fp);
-
-    if (!found) {
-        g_error("s390-ccw.img not found");
-    }
-
-    g_test_message("Loaded %s", found);
-    g_free(found);
-
-out:
-    *len = cached_len;
-    return cached_contents;
-}
-
-static bool s390_bios_has_string(const char *needle)
-{
-    const char *contents;
-    gsize len;
-    bool found;
-
-    contents = s390_bios_load(&len);
-    found = memmem(contents, len, needle, strlen(needle)) != NULL;
-
-    g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
-    return found;
-}
-
-static bool s390_bios_has_net_ccw(void)
-{
-    /*
-     * Assume that netboot support always includes virtio-net-ccw support.
-     * Check only that netboot code exists, rather than probing virtio-net-ccw
-     * support directly.
-     */
-    return s390_bios_has_string("Network boot starting...");
-}
-
-static bool s390_bios_has_net_pci(void)
-{
-    /*
-     * Check for a string unique to virtio-net-pci boot support in the bios
-     * to determine if the binary was built with support for this device.
-     */
-    return s390_bios_has_string("Setup failed for virtio-net-pci");
-}
-
 static testdef_t s390x_tests[] = {
-    { "s390-ccw-virtio", "virtio-net-ccw",
-      .boot_dev_support = s390_bios_has_net_ccw },
-    { "s390-ccw-virtio", "virtio-net-pci",
-      .boot_dev_support = s390_bios_has_net_pci },
+    { "s390-ccw-virtio", "virtio-net-ccw"},
+    { "s390-ccw-virtio", "virtio-net-pci"},
     { NULL },
 };
 
@@ -174,11 +91,6 @@ static void test_pxe_ipv4(gconstpointer data)
 {
     const testdef_t *test = data;
 
-    if (test->boot_dev_support && !test->boot_dev_support()) {
-        g_test_skip("The bios does not support booting this device");
-        return;
-    }
-
     test_pxe_one(test, false);
 }
 
@@ -186,11 +98,6 @@ static void test_pxe_ipv6(gconstpointer data)
 {
     const testdef_t *test = data;
 
-    if (test->boot_dev_support && !test->boot_dev_support()) {
-        g_test_skip("The bios does not support booting this device");
-        return;
-    }
-
     test_pxe_one(test, true);
 }
 
-- 
2.56.0


