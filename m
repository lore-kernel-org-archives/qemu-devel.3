Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68CBC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CSc-0007Go-Gz; Mon, 14 Sep 2026 15:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CSB-00070D-ET; Mon, 14 Sep 2026 15:34:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS8-0004Cg-Jy; Mon, 14 Sep 2026 15:34:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJ1Vda2880902; Mon, 14 Sep 2026 19:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8J+9cPWJAQac5N5XW
 cE/HEpv/XLGhHXhUXKaVXCo6AY=; b=SgeUxOJqT1oHKYE5d/JAFzITRFMxHopIo
 V3zr3HCcZ1gTXxDZwUNh2QJPiMrh2dCAbSbgdXabnKvO7IgjLMbb/YaFWfMBUEj7
 ajsaDBIzTYQIw/PPbfO5gse5GySQA5MXOu4PRwQJXAxvXaRFwydH7/BMAF1RcNQx
 VUQgxEjthZLaBa2P501u2cd1oFRZQLCo3Ezbr8qP/rDA7OILG3YqmH7lSrQe7OEm
 to8apo9ANKwyrsY+Ktd5aUUr3wt7TTpwTNbRe0HHp+BonlUGFjt8E/FF1NR5WU/6
 Zoels2CPrMhPZtie9HRUiahw5iFlYmrCtrA94ple+fHo9AV7P8oGw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83km35-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIopC32763980; Mon, 14 Sep 2026 19:34:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgqs04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EJYAYw27460162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 19:34:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97A9B58058;
 Mon, 14 Sep 2026 19:34:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3603B58059;
 Mon, 14 Sep 2026 19:34:51 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.78.15])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 19:34:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v3 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
Date: Mon, 14 Sep 2026 15:34:36 -0400
Message-ID: <20260914193438.526407-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914193438.526407-1-zycai@linux.ibm.com>
References: <20260914193438.526407-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfXzKJburnWeS4v
 ciaC0+FHqC/Yvtwfg5T0H4SJGFQpKIq18IGvKwX/qiE1u8rUDlUPavo9pU+GnmE4RitEZmgQoh2
 AVs2QQQgmDb2xbFIo7f32I9kYjNpSESJAA4nSsmK6OryZ4phg3l/R423IAQXApHhHQVmbltZYGe
 gM4nL0DHbIqpcyFHiDhyqBKxsX90RYmQ5GO2/wJezFi9+XlJnHRNQIWIJsPe4tKLAbXfL93VLpH
 h3LVEJulFN3M1fPfPySxicIxCqC26rxJiDm0JnqdKm7O5x1XHBwQ6Ku3ArA5s7dH1IsFtdK+ttQ
 9QnN730xudyoUqBX2u3sC9u81MN0BH/lDca1zlRdTFMFU8Eow0RtvSKzTd09HyhkdO1eHEL3DoS
 lNTJQ0duIYTN8YHcAscr69JZlW97DXTTNWhpNFovz5FTu+k5RyhjmylD2NT2LQ2EHbFGMwFioqS
 gIGurEVnnLyl9krFOzw==
X-Proofpoint-ORIG-GUID: oejRvPNufX5ZoQFf1_A0o9u-ULn1YGam
X-Proofpoint-GUID: oejRvPNufX5ZoQFf1_A0o9u-ULn1YGam
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX4FBHHwV8HHKi
 eBp1EJSVId6bfiqY6mOaCwBM//hKRV1J61YzuJiDvHT6V4u16ePYQxuQGEDQPB34RuymGty+z4G
 v+kA7CO6iTKEVwtnJPzyaP4bN4udixI=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa84c5e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uBPJ6fAX7Dlw_A6SEmQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140278
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

The pxe test for a net device does not fail gracefully when the
s390-ccw.img in use was built without support for booting that device.

Add a boot_dev_support check that searches for a known string in the
bios image to confirm boot support. If absent, the test is skipped
gracefully instead of failing.

Also re-enable pxe-test in qtests_s390x, which was accidentally
removed by commit 973d97feca93.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/qtest/meson.build |  1 +
 tests/qtest/pxe-test.c  | 84 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..2cfbdf9b9f 100644
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
index e85dec5a4e..8b6015b6cd 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -26,6 +26,7 @@ typedef struct testdef {
     const char *machine;    /* Machine type */
     const char *model;      /* NIC device model */
     const char *extra;      /* Any additional parameters */
+    bool (*boot_dev_support)(void); /* optional: boot device support check */
 } testdef_t;
 
 static testdef_t x86_tests[] = {
@@ -58,8 +59,79 @@ static testdef_t ppc64_tests_slow[] = {
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
+    g_test_message("%s %s", needle, found ? "found" : "not found");
+    return found;
+}
+
+static bool s390_bios_has_net_ccw(void)
+{
+    /*
+     * virtio-net-ccw has always been supported;
+     * probe for the string it always emits
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
 
@@ -90,6 +162,11 @@ static void test_pxe_ipv4(gconstpointer data)
 {
     const testdef_t *test = data;
 
+    if (test->boot_dev_support && !test->boot_dev_support()) {
+        g_test_skip("The bios does not support booting this device");
+        return;
+    }
+
     test_pxe_one(test, false);
 }
 
@@ -97,6 +174,11 @@ static void test_pxe_ipv6(gconstpointer data)
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


