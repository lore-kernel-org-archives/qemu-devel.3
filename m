Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76399CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpk-0006zl-Lx; Thu, 11 Jun 2026 14:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpj-0006yW-1P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpf-0002FQ-L2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso1269735e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201325; x=1781806125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXW8+TkkbO/zdqSD0tRYgROfejMENktX+Aqzp4oymc4=;
 b=Q3Gvyof7JJ4mEldhfO5aPt7O93qyNMLt8lvG7Kej1v3bwqEVHo08JO9N8JuEQjlPA8
 GrnoUurl8NbVNHiPMjvccJTFCGrB+NkI7cMCZI0VZEuoCm7vheU0K1QJd6GelpZIM3i4
 HpZvWDsNmMiO1sgmQeegH0xQu2MEFs38f/fH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201325; x=1781806125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXW8+TkkbO/zdqSD0tRYgROfejMENktX+Aqzp4oymc4=;
 b=Xx1s8D/Cfwplxdvw/iq28oAFmtdpeGA6wPab/I2U5mDZCFK4ufejATBNN1al5VDpVk
 UtGn6ABnz3ko9HAOi/S5LAP5QmQo8hi5IcYAQwukO8Yp0wSnItBP/mE5y3yRx8mGFoZr
 3zxZRBAd+tT5DB1Inkx/1CRq8P9vpGbl7VXWt1KMLWIiVTOdDZhLCwdsz+2UnmPB0abv
 rCAR2AYBi9Tc55FtxdCa5dCaPfj2Wp4Qp6f7DEtT9L55XK0PMZby0e7ZAuY1jsnBv7yR
 x4Xvtye7c2bw51ejfIMSLHkv9GPRg2erg4AZYCsATU01VT0uOunl4CK5BKTrIClB+xkQ
 Jctg==
X-Gm-Message-State: AOJu0YzouGeeMyKIfHx9ikVzzGdBhXXiQesT6tmZm+S5nHdJlyaEbhYV
 CBtU2sB6xZhXmuMuflUdHmhfhlBwHglsRs/l9GjCrv3LinNgxqlaJg+RkPvLwuCMIawlQx6C6s7
 qLxbhPu0=
X-Gm-Gg: Acq92OGq79r+zz9ArD1Oofga86hlgCmVGDbKtRJcxgwwiXirlpfC5S+RfwLbieNlC62
 geU6IK9bN+qwc4Dejjt1gXQYbNDzYB1B7dhiC0sfGqaOSOIdQTyY1ACdy1pM8dxK4y/EK3AlIKg
 ifDJzE8lDi39PV461EqnGQ6q/31Ad11Gz2SNn6qczJ+2OLbATpEgYWv46tP6jZgjB6A97Y5Eob5
 G2ZH3OLsbDN98O8KiMr7WAnEyTSrhu8f+YAvz+h+e17KMZhjX1Zq53XEly0TCbXyJPl6iLAcoCs
 g1x4oV6yYiVefKyUOJT0K3WUuaf2W+RfSi7fpjTtu37Do+Sr9K7fHqzkfRLLtVOD1HkYD+FNEpH
 sL5bFh+xMf/F4zg02/ZJiQALiQUGeKmjiVDzRBfRJNQcxVOOsu95xwbS+6t+oKOl03zuqXopQP3
 7flem7+P1ngfuLJWjM3UCR5F2dXedTdZG1OHlFCriIz7ieyoGc583YQHHnDPOzRH8ueM9EO4p6L
 xndoPBKYvt87PnDCQoRuVA=
X-Received: by 2002:a05:600c:8682:b0:490:c2a3:3303 with SMTP id
 5b1f17b1804b1-490e56248d5mr35200145e9.34.1781201324811; 
 Thu, 11 Jun 2026 11:08:44 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:44 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v10 1/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Thu, 11 Jun 2026 20:08:34 +0200
Message-ID: <20260611180842.6390-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Introduce configure_machine, launch_source_vm and assert_dest_vm
methods to allow child classes to override some pieces of
source/dest VMs creation, start and check logic.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/functional/migration.py | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 3b7674af3b6..4344e03be41 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -40,19 +40,36 @@ def assert_migration(self, src_vm, dst_vm):
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
+    # Can be overridden by subclasses to configure both source/dest VMs.
+    def configure_machine(self, vm):
+        vm.add_args('-nodefaults')
+
+    # Can be overridden by subclasses to prepare the source VM before
+    # migration, e.g. by running some workload inside the source VM
+    # to see if it continues to run properly after migration.
+    def launch_source_vm(self, vm):
+        vm.launch()
+
+    # Can be overridden by subclasses to check the destination VM after
+    # migration, e.g. by checking if the workload is still running after
+    # migration.
+    def assert_dest_vm(self, vm):
+        pass
+
     def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
         dst_vm.qmp('migrate-incoming', uri=dst_uri)
         src_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(src_vm, dst_vm)
+        self.assert_dest_vm(dst_vm)
 
     def migrate(self, dst_uri, src_uri=None):
         dst_vm = self.get_vm('-incoming', 'defer', name="dst-qemu")
-        dst_vm.add_args('-nodefaults')
+        self.configure_machine(dst_vm)
         dst_vm.launch()
 
         src_vm = self.get_vm(name="src-qemu")
-        src_vm.add_args('-nodefaults')
-        src_vm.launch()
+        self.configure_machine(src_vm)
+        self.launch_source_vm(src_vm)
 
         if src_uri is None:
             src_uri = dst_uri
-- 
2.47.3


