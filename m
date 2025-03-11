Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E902C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzC1-0000wk-7x; Tue, 11 Mar 2025 08:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzBs-0000vG-Ql; Tue, 11 Mar 2025 08:58:38 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzBo-0007oR-DD; Tue, 11 Mar 2025 08:58:35 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2feae794508so8081948a91.0; 
 Tue, 11 Mar 2025 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697910; x=1742302710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7wjPkG/ntlVqsAo3bR2GeOkCsbyPnLbq91ceDRWcvk=;
 b=SIii28Y+MGsgzRfdpDvapK2psDdhlbbzpw1IPdEUbpA6Cz8r8pTTrB19guznzUNH23
 DvNPUM0JaSQ00mNyngm58NCsysj7CIOexRVwSL7oxs2E3GIba2od2R8nd4pqe8Efoq1u
 wFykPqxSznAl+cVdB2Ar8/hYrtLf5D17Mv3zdl9be7GOF3/Kbjk7/fzc5fW4u5YklP6R
 +ALVlMgZEBlF+iZMgxUKzQ7w+I6Tr5VSf9nLhqWQRlbFCX8kqKeqm9/z/yFaOgizkDDn
 6u5dZRfTJVdwDmlAgrrYgkDFG5QNCrVor3zbnQgEyAq34Tm0qIxMmQvmXFsWAmNPPbOB
 EmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697910; x=1742302710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u7wjPkG/ntlVqsAo3bR2GeOkCsbyPnLbq91ceDRWcvk=;
 b=Fi4LQShifCOD3jXogMDZ50JaPPEQGPhI8kxbxLS5Vg5paYhJGlMKClr9qV6nDC3sDz
 Z03u3nVD171K3sSF6+ewT8MX9eptSQGX1qm4Q1LofoOacIjOIxU5beXJqVS3bUsDCLLe
 2eu/2ZJzP+Qt1KaJA0Oi4ml4Ggh7e92gmBqWypwTBBhWG0MIixBWUEF9RChV9AOxwBcp
 fpyFWT3CVtGCSJfTfDUNZHL/DsSU2bcsD53lH/ip0xbXnDl1hCNai9H9vrDMnyprRyie
 1fAnzV5jJ8/gHR1hqytOVPuNFqyyNldFVaoL6nDZisac1ZdnT2Xzv7SfK5L3DKHmgPuP
 DJAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYS0NIBBX134ptewyiUy8umBUjCRLpMm8P18Le+mgi0B8m6hTlpYOjTevFNwgZxME6zOdytb568Q==@nongnu.org
X-Gm-Message-State: AOJu0YzL5GbZtw0ZzuTCs/TpCiG3ol4aLiu/x/hZtEbX1vgIKYbcqchm
 om2QqAO+/ph+0msj3VTqoJ9MuHjG470MKDAIp5plmYZbq1qz0z961f9Y0w==
X-Gm-Gg: ASbGncsCJrj7YsReHKPJazPSTfwSj251Om8+OpjIjwVmV3jmnoqQK7fqmdWGNktKIvu
 058YGpzOIAuQ964NOMqBTNOxG/PzlGaq3CrSZxYfcniiInZEm4OHK3t/FBbq6F9zw318ESnlmvV
 g6cxqYETZypCTAJqZuf1CjIuF6g64GeWPkr0Ql+xAFD12j5tw03IXlBUiW4M/dQpYNcA0XCjeqR
 V1Sj7a0IFZwNWUYxcJ7dtxQtSFPP/GS/EWz7f67nUJ806Bh3YfuoevoQNC+Qh3RsJKVwmUH7Vc7
 Jvp7N/alQ+udBSqRAqcYU5J04m1YcQ6l2r5BYc9d6LW3NDU5XWI=
X-Google-Smtp-Source: AGHT+IGIqYa8qeyLfWBVgGoHt+p6wAsY1KCHmJ7RHjz24qW8Etm3dVWkWNWeWdinz2VYptWdxW8HjQ==
X-Received: by 2002:a17:90b:2d82:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-2ff7ce89db6mr26355537a91.20.1741697908460; 
 Tue, 11 Mar 2025 05:58:28 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:58:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/72] ppc/ppc405: Remove tests
Date: Tue, 11 Mar 2025 22:56:55 +1000
Message-ID: <20250311125815.903177-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Cédric Le Goater <clg@redhat.com>

Since we are about to remove all support for PPC 405, start by
removing the tests referring to the ref405ep machine.

Link: https://lore.kernel.org/qemu-devel/20250110141800.1587589-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250204080649.836155-2-clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/meson.build     |  1 -
 tests/functional/test_ppc_405.py | 37 --------------------------------
 tests/qtest/m48t59-test.c        |  5 -----
 tests/qtest/meson.build          |  1 -
 4 files changed, 44 deletions(-)
 delete mode 100755 tests/functional/test_ppc_405.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e78560a901..74f8414a0c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -207,7 +207,6 @@ tests_ppc_system_quick = [
 ]
 
 tests_ppc_system_thorough = [
-  'ppc_405',
   'ppc_40p',
   'ppc_amiga',
   'ppc_bamboo',
diff --git a/tests/functional/test_ppc_405.py b/tests/functional/test_ppc_405.py
deleted file mode 100755
index 9851c03ee9..0000000000
--- a/tests/functional/test_ppc_405.py
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/usr/bin/env python3
-#
-# Test that the U-Boot firmware boots on ppc 405 machines and check the console
-#
-# Copyright (c) 2021 Red Hat, Inc.
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
-
-class Ppc405Machine(QemuSystemTest):
-
-    timeout = 90
-
-    ASSET_UBOOT = Asset(
-        ('https://gitlab.com/huth/u-boot/-/raw/taihu-2021-10-09/'
-         'u-boot-taihu.bin'),
-        'a076bb6cdeaafa406330e51e074b66d8878d9036d67d4caa0137be03ee4c112c')
-
-    def do_test_ppc405(self):
-        file_path = self.ASSET_UBOOT.fetch()
-        self.vm.set_console(console_index=1)
-        self.vm.add_args('-bios', file_path)
-        self.vm.launch()
-        wait_for_console_pattern(self, 'AMCC PPC405EP Evaluation Board')
-        exec_command_and_wait_for_pattern(self, 'reset', 'AMCC PowerPC 405EP')
-
-    def test_ppc_ref405ep(self):
-        self.require_accelerator("tcg")
-        self.set_machine('ref405ep')
-        self.do_test_ppc405()
-
-if __name__ == '__main__':
-    QemuSystemTest.main()
diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index 605797ab78..1e39a0e8f0 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -247,11 +247,6 @@ static void base_setup(void)
         base_year = 1968;
         base_machine = "SS-5";
         use_mmio = true;
-    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch, "ppc64")) {
-        base = 0xF0000000;
-        base_year = 1968;
-        base_machine = "ref405ep";
-        use_mmio = true;
     } else {
         g_assert_not_reached();
     }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8a6243382a..b23fe67db7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -171,7 +171,6 @@ qtests_mips64el = qtests_mips
 qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
-  (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
   (config_all_accel.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
   (config_all_accel.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
-- 
2.47.1


