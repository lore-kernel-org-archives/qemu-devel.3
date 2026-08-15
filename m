Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B766C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 04:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wv61O-000834-GO; Sat, 15 Aug 2026 00:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wv61L-00082m-5v
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 00:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wv61I-0007pY-Dh
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 00:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786768157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=blw4ugvd8db62yMo46WBCAjgnfol3PrWmDjmhnl7njw=;
 b=dUWqF9U784uqR6VynU3e9H9yQ4RolfzqRswKXv4etZTfA4xuqbaKhXbxUXolHZs8CwN8H/
 WA0NwNUiKcOkiuv2y0eGnhXTTW+TPdHlp4z5pKORPt+7MSxojhVG8SEkBG52u3gevFMfTf
 kzj6Wh/ST1hifQe7lb/zfaS9/In52dg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-F8ShYZeBMXKY9XpXM6livQ-1; Sat, 15 Aug 2026 00:29:15 -0400
X-MC-Unique: F8ShYZeBMXKY9XpXM6livQ-1
X-Mimecast-MFC-AGG-ID: F8ShYZeBMXKY9XpXM6livQ_1786768155
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso1818480a12.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 21:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786768154; x=1787372954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=blw4ugvd8db62yMo46WBCAjgnfol3PrWmDjmhnl7njw=;
 b=UgJkGYYkTrgOL9cpw/hVWZxX6rQhBNYHb9q1/QG+I+HktzddRAOwJ7NBcrcoFWgaNX
 3mnD3mwDtAFbp4LtkKQJKNMTBFbnKVN16Ra8Ej2846eCrN20cN1IwpDrk6zX7S8skHSR
 bD6cn6zgewiextrEqn297RKbF4hqVkZslzYC+P2CyhXILEInaZqtieRcJ+wRkTWfraCN
 dw+xH5SjMYz1BTPXjjvS6tadq/huLwUT2o5BgJFoXn/k1rjSgFI6jNF/wez88ycjDtxk
 Kd3C4UFBsPnGkNJYEblZMWUZSODB7aC32Cjn2RPhfOH1Yb4+rcDapnaKOnWrhXMaP87Z
 Mbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786768154; x=1787372954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blw4ugvd8db62yMo46WBCAjgnfol3PrWmDjmhnl7njw=;
 b=rO+IPUbzQYN8FMLADMz1HpeGknY/8bgz4kqBjIoZpvk5AdvwLCPgeI60gLObscvlsa
 EGZ8/+3cF/YbvcoezLUF3ustXv8drexpkoZm+yme15PomeTW9H3H57511Yzgt8Tba4Xe
 nk2sGmWq9ET7r+46j+O5cII73aqdyPeZChbyUihbDLGfpWNoIr7jcCh+X0ETpZmZZKdK
 WEAs2rn6Yf62dsYmMBE0tDFkSBsDXOk3yScw3sekF+nGo80lXsIKhvwcbH+vCBPZC4lr
 Hu1ljh0Qr6/EdkU078B6qHkeXMnm53ILhu1Pe1eAovx45tPBpMhdpuXxLk2KyDw1mKjn
 WwGA==
X-Gm-Message-State: AOJu0YykqAi3WqPAIGEwxzdr/bFvMuG2LjQKijPvnLv4HmU2pUza0zV+
 QiyftwO4wqhSI+7OID19hi7zCJmbqXeTJEj/DPZooUu0rcuuTC4qqhd00JArrMEsncYCYNHkDDy
 +CxXY6mjk49mtPvtmnw2waMiPLaOnHBgD098dn+qESaJzR7Aon1q0Y9JV
X-Gm-Gg: AR+sD11x3gJnh94sg/jX0AKWzK7Ah4NcOJ+ph2X/W40a+iKY7mjuJgcfBMTeNh495kQ
 QA460/lCwF58OJs8aF0WiVDTG8p7jtrSlaF5Zftev+YjVacIbgRKMM9dpqNS5CIzyjEmiRr275J
 2EC10+UPxdLwCN58P3YDDe1fXq12PL549K3hjkEDB96Gp2Zj9qc1Wvf9Am5Y5a40rXMUa27GGW5
 QYBUjW9S3qxLai/TY9aCTPIeNp16MRfDMYxIgyz+DmTyBBWWqP6HfKjSJ9eCViLlyxnM8FusopB
 viYggf0B/W91yz4+3TIPktA45buEq+mKqdRgy2FHqIx+C6JiiufuNLgBztkhle0t0Auj1FQ4Dct
 NAjS/4REpPTZ0+Um9rORjwOLg+ZicOh54R3d/
X-Received: by 2002:a05:6a21:6e86:b0:3c3:89cf:f43 with SMTP id
 adf61e73a8af0-3cc71e063e0mr12604561637.30.1786768154425; 
 Fri, 14 Aug 2026 21:29:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e86:b0:3c3:89cf:f43 with SMTP id
 adf61e73a8af0-3cc71e063e0mr12604530637.30.1786768153932; 
 Fri, 14 Aug 2026 21:29:13 -0700 (PDT)
Received: from ani-lenovo.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-320ea8fe3cdsm10877724eec.28.2026.08.14.21.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 21:29:13 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] test/qtest/launchupdate: add another test to exercise load
 and set host igvm
Date: Sat, 15 Aug 2026 09:58:45 +0530
Message-ID: <20260815042845.184329-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A new test is added that loads a new IGVM bundle and sets host igvm
ctrl at the same time. The expected behavior is that first reset will load
the passed IGVM. The second reset will restore the original host provided IGVM.
This test exercizes this functionality.

Some refactoring is also done at the same time to re-use common operations from
within multiple test routines.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/launchupdate-test.c | 245 +++++++++++++++++++++++++++-----
 1 file changed, 210 insertions(+), 35 deletions(-)

diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-test.c
index 89a117dfe4..de780eac62 100644
--- a/tests/qtest/launchupdate-test.c
+++ b/tests/qtest/launchupdate-test.c
@@ -248,6 +248,68 @@ static int wait_for_match(char *serial_f,
     return ret;
 }
 
+static void set_test_params(const char **igvm_f, const char **igvm_init,
+                            const char **snp, const char **cgs)
+{
+    if (confidential) {
+        *snp = "-object \'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec0\","
+            "\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'";
+        *cgs = "confidential-guest-support=lsec0";
+        /*
+         * The following two IGVM files can be built from the source
+         * present in https://gitlab.com/anisinha/virt-firmware-rs .
+         * Typing 'make' from the top of this repository will build the
+         * IGVM files for both confidential and
+         * non-confidential tests. The IGVM files for the non-coco
+         * case has been checked-in into the QEMU repository for
+         * convenience and easy CI pipeline testing.
+         */
+        *igvm_f = "tests/data/igvm/snptest.igvm"; /* prints 'hello world' */
+        *igvm_init = "tests/data/igvm/snptest-nohello.igvm";
+    } else {
+        *igvm_f = "tests/data/igvm/hello.igvm";
+        *igvm_init = "tests/data/igvm/qemuinit.igvm";
+        *snp = "";
+        *cgs = "";
+    }
+
+    return;
+}
+
+static void set_expected_out(const char **exp_out, const char **exp_out2,
+                             const char **exp_out3)
+{
+    *exp_out = "Hello world!";
+    *exp_out2 = "Test succeeded!";
+    *exp_out3 = "boot process complete with initial igvm";
+
+    return;
+}
+
+static QOSState *set_qemu_args(const char *cgs, const char *tp, char *serialf,
+                               const char *igvm_init, const char *snp)
+{
+    QOSState *qs;
+
+    if (tp) {
+        qs = qtest_pc_boot("-machine q35,igvm-cfg=igvm0,%s -m 1G -accel kvm "
+                           "-device vm-launch-update %s "
+                           "-chardev file,id=serial0,path=%s "
+                           "-serial chardev:serial0 "
+                           "-object igvm-cfg,id=igvm0,file=%s %s",
+                           cgs, tp, serialf, igvm_init, snp);
+    } else {
+        qs = qtest_pc_boot("-machine q35,igvm-cfg=igvm0,%s -m 1G -accel kvm "
+                           "-device vm-launch-update "
+                           "-chardev file,id=serial0,path=%s "
+                           "-serial chardev:serial0 "
+                           "-object igvm-cfg,id=igvm0,file=%s %s",
+                           cgs, serialf, igvm_init, snp);
+    }
+
+    return qs;
+}
+
 static void test_load_igvm(void)
 {
     const char *igvm_f;
@@ -255,9 +317,9 @@ static void test_load_igvm(void)
     int ser_fd;
     g_autofree void *igvm_blob = NULL;
     g_autofree char *serialtmp = NULL;
-    const char exp_out[] = "Hello world!";
-    const char exp_out2[] = "Test succeeded!";
-    const char exp_out3[] = "boot process complete with initial igvm";
+    const char *exp_out;
+    const char *exp_out2;
+    const char *exp_out3;
     const char *tracepoints = "--trace memory_region_finalize "
         "--trace qigvm_cleanup_memory -D /tmp/qemu-debug.log ";
     const char *snp, *cgs;
@@ -268,35 +330,13 @@ static void test_load_igvm(void)
     QOSState *qs;
     VMLaunchUpdate launch_update;
 
-    if (confidential) {
-        snp = "-object \'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec0\","
-            "\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'";
-        cgs = "confidential-guest-support=lsec0";
-        /*
-         * The following two IGVM files can be built from the source
-         * present in https://gitlab.com/anisinha/virt-firmware-rs .
-         * Typing 'make' from the top of this repository will build the
-         * IGVM files for both confidential and
-         * non-confidential tests. The IGVM files for the non-coco
-         * case has been checked-in into the QEMU repository for
-         * convenience and easy CI pipeline testing.
-         */
-        igvm_f = "tests/data/igvm/snptest.igvm"; /*
-                                                  * this prints 'hello world'
-                                                  * on console
-                                                  */
-        igvm_init = "tests/data/igvm/snptest-nohello.igvm";
-    } else {
-        igvm_f = "tests/data/igvm/hello.igvm";
-        igvm_init = "tests/data/igvm/qemuinit.igvm";
-        snp = "";
-        cgs = "";
-    }
-
     if (!trace) {
         tracepoints = "";
     }
 
+    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
+    set_expected_out(&exp_out, &exp_out2, &exp_out3);
+
     if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
         !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
         g_test_skip("igvm file bundle(s) does not exist!");
@@ -326,12 +366,7 @@ static void test_load_igvm(void)
         fprintf(stderr, "serial console file is %s\n", serialtmp);
     }
 
-    qs = qtest_pc_boot("-machine q35,igvm-cfg=igvm0,%s -m 1G -accel kvm "
-                       "-device vm-launch-update %s "
-                       "-chardev file,id=serial0,path=%s "
-                       "-serial chardev:serial0 "
-                       "-object igvm-cfg,id=igvm0,file=%s %s",
-                       cgs, tracepoints, serialtmp, igvm_init, snp);
+    qs = set_qemu_args(cgs, tracepoints, serialtmp, igvm_init, snp);
 
     fw_cfg = pc_fw_cfg_init(qs->qts);
 
@@ -342,6 +377,11 @@ static void test_load_igvm(void)
 
     /* exp_out3 should be printed once from initial boot */
     g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "initially booted with host igvm\n");
+    }
+
     g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) == igvm_sz);
 
     /* create a data buffer in guest memory */
@@ -389,7 +429,7 @@ static void test_load_igvm(void)
 
     /* check if VM_LAUNCHUPDATE_CTL_HOST_IGVM function works */
 
-    /* set VM_LAUNCHUPDATE_CTL_HOST_IGVM control */
+    /* set only VM_LAUNCHUPDATE_CTL_HOST_IGVM control without IGVM bundle */
     memset(&launch_update, 0, sizeof(launch_update));
     launch_update.control |= VM_LAUNCHUPDATE_CTL_HOST_IGVM;
 
@@ -410,6 +450,139 @@ static void test_load_igvm(void)
      */
     g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) == 0);
 
+    if (debug) {
+        fprintf(stderr, "booted with host igvm again\n");
+    }
+
+    close(ser_fd);
+    guest_free(&qs->alloc, gaddr);
+    pc_fw_cfg_uninit(fw_cfg);
+    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
+    qtest_quit(qs->qts);
+}
+
+static void test_set_ctrl_once_and_reset_to_host_igvm(void)
+{
+    const char *igvm_f;
+    const char *igvm_init;
+    int ser_fd;
+    g_autofree void *igvm_blob = NULL;
+    g_autofree char *serialtmp = NULL;
+    const char *exp_out;
+    const char *exp_out2;
+    const char *exp_out3;
+    const char *snp, *cgs;
+    uint64_t gaddr;
+    size_t igvm_sz;
+    size_t filesize;
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    VMLaunchUpdate launch_update;
+
+    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
+    set_expected_out(&exp_out, &exp_out2, &exp_out3);
+
+    if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
+        !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
+        g_test_skip("igvm file bundle(s) does not exist!");
+        return;
+    }
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    if (!qtest_has_accel("kvm")) {
+        g_test_skip("No KVM accelerator available");
+        return;
+    }
+
+    if (!qtest_has_device("vm-launch-update")) {
+        g_test_skip("Device vm-launch-update is not available");
+        return;
+    }
+
+    ser_fd = g_file_open_tmp("launchupdate-qtest-serial-sXXXXXX",
+                             &serialtmp, NULL);
+    g_assert_true(ser_fd != -1);
+
+    if (debug) {
+        fprintf(stderr, "serial console file is %s\n", serialtmp);
+    }
+
+    qs = set_qemu_args(cgs, NULL, serialtmp, igvm_init, snp);
+
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "initially booted with host igvm\n");
+    }
+
+    g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) == igvm_sz);
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&qs->alloc, igvm_sz);
+
+    if (debug) {
+        fprintf(stderr, "guest paddr: %"PRIx64 "  igvm size: %lu\n",
+                gaddr, igvm_sz);
+    }
+
+    if (debug) {
+        fprintf(stderr, "writing igvm file into the guest memory\n");
+    }
+
+    qtest_bufwrite(qs->qts, gaddr, igvm_blob, igvm_sz);
+
+    if (debug) {
+        fprintf(stderr,
+                "tell hypervisor where igvm is loaded in guest memory\n");
+    }
+
+    /* now tell hypervisor where we loaded the bios */
+    memset(&launch_update, 0, sizeof(launch_update));
+    launch_update.fw_image_size = cpu_to_le64(igvm_sz);
+    launch_update.fw_image_addr = cpu_to_le64(gaddr);
+
+    /* set both host ctrl and format_igvm ctrl once */
+    launch_update.control |= VM_LAUNCHUPDATE_FORMAT_IGVM;
+    launch_update.control |= VM_LAUNCHUPDATE_CTL_HOST_IGVM;
+
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
+                                  &launch_update, sizeof(launch_update));
+    g_assert_cmpint(filesize, ==, sizeof(launch_update));
+
+    if (debug) {
+        fprintf(stderr, "resetting the virtual machine. This should load "
+                "user provided igvm.\n");
+    }
+
+    qtest_system_reset(qs->qts);
+
+    /* expected string should be printed on the console */
+    g_assert_true(wait_for_match(serialtmp, exp_out, WAIT_SEC, 1) == 0);
+    g_assert_true(wait_for_match(serialtmp, exp_out2, WAIT_SEC, 1) == 0);
+
+    if (debug) {
+        fprintf(stderr, "hello world found on console\n");
+        fprintf(stderr, "Now resetting again in order to reset to host igvm\n");
+    }
+
+    qtest_system_reset(qs->qts);
+
+    /*
+     * exp_out3 should be printed twice, once from initial boot,
+     * once from restoring host igvm.
+     */
+    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) == 0);
+
+    if (debug) {
+        fprintf(stderr, "booted with host igvm\n");
+    }
+
     close(ser_fd);
     guest_free(&qs->alloc, gaddr);
     pc_fw_cfg_uninit(fw_cfg);
@@ -435,6 +608,8 @@ int main(int argc, char **argv)
     g_test_add_func("/vm-launch-update/errorcheck", check_error);
     g_test_add_func("/vm-launch-update/load_igvm",
                     test_load_igvm);
+    g_test_add_func("/vm-launch-update/ctrl_set_once",
+                    test_set_ctrl_once_and_reset_to_host_igvm);
 
     if (getenv("LAUNCHUPDATE_DEBUG")) {
         debug = true;
-- 
2.54.0


