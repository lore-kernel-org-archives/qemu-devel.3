Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE97ACA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAi-0008RD-QQ; Wed, 30 Sep 2026 11:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAe-0008K0-BM; Wed, 30 Sep 2026 11:24:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAc-00022W-9Z; Wed, 30 Sep 2026 11:24:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5o3x3167020; Wed, 30 Sep 2026 15:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ECdyu2CDFa/Yxbl6d
 6F9f8tzTbpoFlN2d50swpfDvtY=; b=nZqmGG7XpRj0/Hf1z6v5/LPWK8a9KlpYI
 lguu7k33/e0KrgXMDuHVwXReUec2iGGSTum/sPxIHP2SfAHRyoVM7t13ak9zgxKM
 nYb38WMW06OYvQpzvAL8yX2sNvq/lyxQ2B0v/qieVT+Rgn9vUgajVMU49scYcMS/
 62jloy8vsuY3RBSduJ2Rm8sKdrgWSldmOonyM+Zak+m5tb3tWlq3TEvWRJVy4j+x
 cylp5Okde+Pn2o/YEinRysACsVNsnjRjd3UvXFtl+iPo74L7kYDCl4SiwDBcYG6B
 dLej2RqkYv4eDfN6wFg75PgfMDNbfQXFDbwUpRZ5npWm0mpNjVnEA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptcv9e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEIG6P3569682; Wed, 30 Sep 2026 15:24:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9n2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOVIQ3146464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39F4D5805F;
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B50EE58060;
 Wed, 30 Sep 2026 15:24:30 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:30 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 16/23] tests/qtest: Check s390x boot device support in
 pxe-test.c
Date: Wed, 30 Sep 2026 11:24:13 -0400
Message-ID: <20260930152420.1956230-17-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1eUZYU2ZTls2SDxB_Tpwa4Nnu2gT-GtX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX/gBLlzo3Kxuy
 2TdKlTJpv4X45lzOy3yxwLikYfbQtdBvm5axuQZpx5QfxXnaW4Wl8lB0IqfRsPM0MXBJzKzxUWL
 gYm5SqMtpv3fCK6gh+H00EA1RNlOk2d96T873uoSkRlNMiBn55qAzKtkYitSnkR29D4QDhgYRmm
 00IwVqElZb9aIa0ep+YtlAbBGjFwIvbWMq2NcbNDzhRO/D6hbh9aLR5V77SUoTowYHoFNwfUSeM
 hyk3R4bexYVEOSS8ZzAvqmFwFHzil0VWANusNZeF7VZPFY6hLNMBda6Q3MhsJotUbfRXIsqrzgx
 pKkJtAJ6/Y5LsFXiTQm7g72i596tP+Yul/cIlkkeb1lpJIocB+BJ2PrIplB1P/J0ATSIhRnYzRc
 aUAOOOfkkBdiOgHWr1LR9XW9BZRABvtMfdHfHhvgVoiVTf+ho8WfiOtfPNO5bD2tVtkx1uQW4Ld
 AmgOEOnA+Z0WW+1BuEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX2pSIPhxTiZMQ
 JqztJ3/SXIpnECCUhQyKO/pslRjFpnRe3TX+UYAHCkZ+6Ju8jX+O0MIsjIQ7oYrOy7nbRXOaXAA
 jbga+Oo7CKslwRk2f2HDJExsQCzn5QM=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd29b0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=uBPJ6fAX7Dlw_A6SEmQA:9
X-Proofpoint-GUID: 1eUZYU2ZTls2SDxB_Tpwa4Nnu2gT-GtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
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

From: Zhuoying Cai <zycai@linux.ibm.com>

The pxe test for a net device does not fail gracefully when the
s390-ccw.img in use was built without support for booting that device.

Add a boot_dev_support check that searches for a known string in the
bios image to confirm boot support. If absent, the test is skipped
gracefully instead of failing.

Also re-enable pxe-test in qtests_s390x, which was accidentally
removed by commit 973d97feca93.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-7-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qtest/meson.build |  1 +
 tests/qtest/pxe-test.c  | 85 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 33f58b0e95..341f6ad1ba 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -292,6 +292,7 @@ qtests_aarch64 = \
    'migration-test']
 
 qtests_s390x = \
+  (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
   ['boot-serial-test',
    'drive_del-test',
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index e85dec5a4e..5c6415b936 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -26,6 +26,7 @@ typedef struct testdef {
     const char *machine;    /* Machine type */
     const char *model;      /* NIC device model */
     const char *extra;      /* Any additional parameters */
+    bool (*boot_dev_support)(void); /* optional: boot device support check */
 } testdef_t;
 
 static testdef_t x86_tests[] = {
@@ -58,8 +59,80 @@ static testdef_t ppc64_tests_slow[] = {
     { NULL },
 };
 
+static const char *s390_bios_load(gsize *len)
+{
+    static char *cached_contents;
+    static gsize cached_len;
+    const char *qemu_bin;
+    g_autofree char *cmd = NULL;
+    char dir[PATH_MAX];
+    char *found = NULL;
+    char *path = NULL;
+    FILE *fp;
+
+    if (cached_contents) {
+        g_test_message("Using cached bios contents");
+        goto out;
+    }
+
+    /* search the qemu binary's data directories for s390-ccw.img */
+    qemu_bin = qtest_qemu_binary(NULL);
+    cmd = g_strdup_printf("%s -L help", qemu_bin);
+    fp = popen(cmd, "r");
+
+    if (!fp) {
+        g_error("Failed to run '%s'", cmd);
+    }
+
+    while (fgets(dir, sizeof(dir), fp) && !found) {
+        dir[strcspn(dir, "\n")] = '\0';
+        path = g_build_filename(dir, "s390-ccw.img", NULL);
+        if (g_file_get_contents(path, &cached_contents, &cached_len, NULL)) {
+            found = path;
+        } else {
+            g_free(path);
+        }
+    }
+    pclose(fp);
+
+    if (!found) {
+        g_error("s390-ccw.img not found");
+    }
+
+    g_test_message("Loaded %s", found);
+    g_free(found);
+
+out:
+    *len = cached_len;
+    return cached_contents;
+}
+
+static bool s390_bios_has_string(const char *needle)
+{
+    const char *contents;
+    gsize len;
+    bool found;
+
+    contents = s390_bios_load(&len);
+    found = memmem(contents, len, needle, strlen(needle)) != NULL;
+
+    g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
+    return found;
+}
+
+static bool s390_bios_has_net_ccw(void)
+{
+    /*
+     * Assume that netboot support always includes virtio-net-ccw support.
+     * Check only that netboot code exists, rather than probing virtio-net-ccw
+     * support directly.
+     */
+    return s390_bios_has_string("Network boot starting...");
+}
+
 static testdef_t s390x_tests[] = {
-    { "s390-ccw-virtio", "virtio-net-ccw" },
+    { "s390-ccw-virtio", "virtio-net-ccw",
+      .boot_dev_support = s390_bios_has_net_ccw },
     { NULL },
 };
 
@@ -90,6 +163,11 @@ static void test_pxe_ipv4(gconstpointer data)
 {
     const testdef_t *test = data;
 
+    if (test->boot_dev_support && !test->boot_dev_support()) {
+        g_test_skip("The bios does not support booting this device");
+        return;
+    }
+
     test_pxe_one(test, false);
 }
 
@@ -97,6 +175,11 @@ static void test_pxe_ipv6(gconstpointer data)
 {
     const testdef_t *test = data;
 
+    if (test->boot_dev_support && !test->boot_dev_support()) {
+        g_test_skip("The bios does not support booting this device");
+        return;
+    }
+
     test_pxe_one(test, true);
 }
 
-- 
2.55.0


