Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD278105F7AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13GG-0005Ur-UV; Fri, 13 Mar 2026 10:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fq-0005Q7-Og
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Fl-0006Mo-SL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:12:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b611274bso1475065f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411149; x=1774015949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mdV95Xn1uRZNv+wMaqt5uMFd58yUD2RuxYvZm/pTuU=;
 b=XA0zGeV14fJoCUtM8l3sHhHL6+utlwRzE8JOuNzusGg8nbf7JyQBlmYEYU0t8KuqMk
 Xq42mcNdfnKo07jWlh+xvYvQtpUUPxFrZ/9HCt0IuJD9/66l+4O2/PqkPZgkRLtTC8pJ
 KquUxy7+mA306eAP6L/+DwAFw+/aYz27gy3gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411149; x=1774015949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mdV95Xn1uRZNv+wMaqt5uMFd58yUD2RuxYvZm/pTuU=;
 b=faZ81nlvLJR0rnSqr7HZ8XeVuDKcjDwmHtJ0C9aRk3m0ykhp6k5mHO0wErdpKbggzD
 lsPhxgx6529Hi/1AcxWsCceE/nmFMGgwFQ+eyy31VzjrlYS2/ED53twBrtEWJ5285D09
 XCt1jZTGVM8RKDhJkelPEKSEvDYgarvZGDgfauuknvK8FZOx16AckdtAF26EUsq4WkUc
 OH7wp85+/8+eEB5DVIeS4pG9Nrco/l/HCzoNCh4lEQCftt6bDNakYBzJVnvjnDmDDZfj
 zjq1Rep+vFW2I9y2lu0DZtoxuSlNo+N3LqW97vEmpA+U51pwnvNembdEEefnk7mSK09x
 gc8Q==
X-Gm-Message-State: AOJu0YwY6Fb4IYgrblgO5oqcDHM/k86TE3lQMPuq5Wujd84wJl5HXzJI
 VPb4ELPckTMts4UUwAdBoSgZ4GEhumuHlq6wrrkG1NG/ARvJ6ZsSG6rIM/wbRIT2y7H63e3aYXe
 9KmAxRBk=
X-Gm-Gg: ATEYQzyIZKZ5U2BTL72WA15L4vKdeM1Zua6taxqoO6ZB58ymytuIhDtBlEvz5oyob1T
 xhYN8e/y7X0eyCmVYmvEz1aCq7PIPgiiMjb9egeo1Wl29NZB/yLHSxDAgElIHIJgaKXPyYQvGAA
 6PTaX3wwfmGwkF8AXAcPjDO/aBPfDo3bM1rR67UHmsHIFX+G2veqrbFYem2rVKFD46OvQMzaZrH
 nylJq78pV8h8iI7xItiHyY/P2+imFA24st5zKDgRYBt5Mp26RIP+6lwWiH0DcVaxdQhN24vDtOu
 CtBIcvyIA5PNv4ZZUDsULwgvS2MwWiI2UIL8bpJ7BIJ6GpPz8Dhx3wMpYhcmk4oIJLsvgHyf5W2
 zQ9XIKiFNzuRxraDy0iYb7kGnnx2aCPPu5aQTjAo7AHwAtlOcDF9xRtiBeR9m4G9PVm6qfTAUQI
 ZXUrtbBh2voWZgnKxXYprflpmQr0o9JiZsD21bMqTb7JZW+KpFGOw0POLg9aDSVF90j9DDLwo1a
 GFFculP7WNJBaXU/c8pUIQ=
X-Received: by 2002:a5d:5f46:0:b0:439:ac98:7520 with SMTP id
 ffacd0b85a97d-43a04dbed03mr6986089f8f.37.1773411148739; 
 Fri, 13 Mar 2026 07:12:28 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00321ddb23f48fbb73.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:321d:db23:f48f:bb73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm18580939f8f.7.2026.03.13.07.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:12:28 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 4/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Fri, 13 Mar 2026 15:12:17 +0100
Message-ID: <20260313141221.359503-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313141221.359503-1-alexander@mihalicyn.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Introduce configure_machine, launch_source_vm and assert_dest_vm
methods to allow child classes to override some pieces of
source/dest VMs creation, start and check logic.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/functional/migration.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index e995328e833..40e9c094c46 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -40,19 +40,35 @@ def assert_migration(self, src_vm, dst_vm):
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
+    # Can be overridden by subclasses to configure both source/dest VMs.
+    def configure_machine(self, vm):
+        vm.add_args('-nodefaults')
+
+    # Can be overridden by subclasses to prepare the source VM before migration,
+    # e.g. by running some workload inside the source VM to see if it continues
+    # to run properly after migration.
+    def launch_source_vm(self, vm):
+        vm.launch()
+
+    # Can be overridden by subclasses to check the destination VM after migration,
+    # e.g. by checking if the workload is still running after migration.
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


