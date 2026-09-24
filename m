Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94352C98324
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pRJ-00040C-Ka; Thu, 24 Sep 2026 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pRB-0003yT-GZ; Thu, 24 Sep 2026 15:48:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR9-0008BG-Nv; Thu, 24 Sep 2026 15:48:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5RHi1201893; Thu, 24 Sep 2026 19:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ag92YFbITaeUgUdvK
 AF2x5Yn0zaB4uG61hHoGRUZOkg=; b=GAy4+lU96+XIaBnS8Kl8nq3hP+eS9a9FD
 GIFysyyFyCzayfqhdr3R7BZHjjy8q34m3s2ZybQ1ZzkNIDMduoFxInSXaDRaghZj
 VeuPXTHVKY1ohe0LDfccOH1l9Rm8vGU9bk0qQNHhRRhAZiwqTOifJ3y06LRnNbg4
 sW7V68csZkmxZ+uVwPBSXpRKV5Z02GkmMocfKwFq0n+1g3kJFNw50+exQHI8yN5D
 X5frURVNamw9ihonjZWmLnJ8PzsOANUyYf0CkxCoQnylSldhp9ze8H+QWeyIBnDQ
 bCc8m3UFLVTfdO4aW3gZuour706Sa7+cQLvXIEDiuhHnDp38Uusww==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske239m0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlXts1233804; Thu, 24 Sep 2026 19:48:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ebpjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OJmpAx17171002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 19:48:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C842E58058;
 Thu, 24 Sep 2026 19:48:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55BFD58059;
 Thu, 24 Sep 2026 19:48:50 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 19:48:50 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v4 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
Date: Thu, 24 Sep 2026 15:48:35 -0400
Message-ID: <20260924194837.80732-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924194837.80732-1-zycai@linux.ibm.com>
References: <20260924194837.80732-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ch1OoQicXFZvOX-VYwTDS9LQ7umyGXG1
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab57ea5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=uBPJ6fAX7Dlw_A6SEmQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX3vtjWLa+VjhA
 3Ky2Joobm/vS8QglWpX+2PMFxcQa0rHibyiFnbn0T03+03UKCYC+WiH0994+NPweFBV/3ckSUUi
 HrrfgtBZ9UQ28LNWGHV6mKfjUVDpbMQ=
X-Proofpoint-GUID: Ch1OoQicXFZvOX-VYwTDS9LQ7umyGXG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfXwvYh9nR/Qbdh
 CEaABe/Fl/8SreBaRz65eswAJHs/+Q65z/0BOchskbRcBbgV75HoZeCJbTcFhK3ANa7FWOj7WND
 7NiRoJhwl9ssxYnOF5d4IHx2ZGGpBce5Yh5LrIngByN2HxpA2hPFw2ERReRXlyFDq/aflzKRTcx
 R9zTIqZ+aAaspum1lidxR0y0ouKhwus0lxQ3WxQCFk1BdSiL8Qtxzibbfz5QvbGarexxp2ehC1Y
 aao1CYqRCg/ruk5aFd/K66tKuzBhb8g8tNwJS9TJhLaG6OItdjC+8KMAm4rwUza8ZIqoJJCmDOF
 dj0vO9PJnY2FHP/xrQA4nko2QCORBUenjZPW3S+V4HKlUitWjDYUvP2O9gqTeV6jKCyaxpcEXb5
 FMKQSSxdIXTDYHvVvkbN52wM6ZgmYZz4HZpW45z9bcdmqQIMMI+zyJtHoBMxmBn9DVbnY992I8n
 vAUqetkOpqhAcfkyZ8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240080
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
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
---
 tests/qtest/meson.build |  1 +
 tests/qtest/pxe-test.c  | 81 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

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
index e85dec5a4e..61ad572bb7 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -26,6 +26,7 @@ typedef struct testdef {
     const char *machine;    /* Machine type */
     const char *model;      /* NIC device model */
     const char *extra;      /* Any additional parameters */
+    bool (*boot_dev_support)(void); /* optional: boot device support check */
 } testdef_t;
 
 static testdef_t x86_tests[] = {
@@ -58,8 +59,76 @@ static testdef_t ppc64_tests_slow[] = {
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
+    g_test_message("BIOS boot device support indicator \"%s\": %s",
+                   needle, found ? "found" : "not found");
+    return found;
+}
+
+static bool s390_bios_has_net_ccw(void)
+{
+    return s390_bios_has_string("Network boot starting...");
+}
+
 static testdef_t s390x_tests[] = {
-    { "s390-ccw-virtio", "virtio-net-ccw" },
+    { "s390-ccw-virtio", "virtio-net-ccw",
+      .boot_dev_support = s390_bios_has_net_ccw },
     { NULL },
 };
 
@@ -90,6 +159,11 @@ static void test_pxe_ipv4(gconstpointer data)
 {
     const testdef_t *test = data;
 
+    if (test->boot_dev_support && !test->boot_dev_support()) {
+        g_test_skip("The bios does not support booting this device");
+        return;
+    }
+
     test_pxe_one(test, false);
 }
 
@@ -97,6 +171,11 @@ static void test_pxe_ipv6(gconstpointer data)
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


