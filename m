Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843F0CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2I-0007sn-Ho; Tue, 26 May 2026 07:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2B-0007pj-CU
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq21-00020H-So
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45ed18d8a1bso802582f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795185; x=1780399985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwNYE+3EsOTt/DYhXoT3Hi/46A9RRvvAOGKzlEPdgeU=;
 b=HgOVOQErGn5WhwVrVYLZlY4zzqZ8ErvsfncOkZlDgKoeKwVcpvtRiRGAgM1fvDgnqN
 Y0863DFp8B+uikaerc9KfZhJCcCFC6rEDpzgxMzuVDSZGd9WBFoBsxqATUBjIUD4HZRm
 3AuwCcpciU9Mbtm+jLjkiYv8mfjpvo3P3oszY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795185; x=1780399985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwNYE+3EsOTt/DYhXoT3Hi/46A9RRvvAOGKzlEPdgeU=;
 b=i0mrVcww5O9oxDndkRf8NRagtzMhAbv5JTY3JCnqetPW8tHSgyZP5MDF+q/5BNOu+V
 k4QHV4ihz0/AEmKOAh7oA1fPMlpvmW0TXzSt6SexM4eKvHnJ7x3X37leOYTCucJaGQJq
 1F8Uh0zXI3udSzdKx3zKiOGcJBsHCdIkguhn6cxy5pgXbZV8anVUQWt7PDB3OlPqcn9z
 Elp7/fUZnilu4eMUR4rBSYWTr8ZCceyRjUr8JzlKtVrgLzm1iJHK66sbDMDS/NheBUJe
 BRwrSzBZ0shpaZf/t0YcamG5lr9u23deorNkhN2HbDJOkV414EKo+TzSdaZPfekw9Yp7
 Wu3A==
X-Gm-Message-State: AOJu0YzsgjW9JBN7lAXlNX5/rggGFcp2e4gGdoeU2sjsj2hBY9UhPlYO
 66TQnqlO2Jany1MD67BiUMMnLoHkjuf0MA6qjm/L0S4WjCbkWNTcCMPRb4n/ua0P9ObzIIKP/Jk
 dQMJdMJs=
X-Gm-Gg: Acq92OFO/haixJLwfqR2TSNjSJzwG383lJmOnmtey51vySq1WhtPN3AlTBpw7geNK5H
 2fuYmdYZJAIMLAQBziZd0wfwusdNjBjIlYAMJzkEMjhWqEp6H3LOFXAjiODu2/WCe1DdXT0jsOD
 jEtFie0irD/PTtPu5IAAx246SFnDSoAeYj+wMHZYkmV5f8HonyyDrRbsoWx9eMBiOqjHp2vnvX/
 B59xeHyvUJtc0ij6nHfkikDvjHwxvl10HUA6PUjN+SicRhUqg9bXpLKoalrWk7JmLB6khy/keMW
 Zpj/daZkrOF1K7rmK3AbDm2Tqo+fC5pGso4/G+hF/9ZJULdwUbzkyyibBIJSg/5TqpCctIZ56Hc
 oe99cuKOIXmzl8WGhMGofI2iZB6schA450vWnhZeNaOkPmhFdcGRsORMFywFab1mee6mk8/Ra8T
 lCX83u2Av3KSMa48JFNdFBRg6HMlu/FeJWp5UplruqOaGd3B38Ma0irfKkKg4DSZpI12amtNZYs
 h1gLPJIr5Au1C7avC8qmrc=
X-Received: by 2002:a05:6000:1848:b0:45e:93d6:359b with SMTP id
 ffacd0b85a97d-45eb36887a9mr31328138f8f.9.1779795184549; 
 Tue, 26 May 2026 04:33:04 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:04 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v8 1/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Tue, 26 May 2026 13:32:54 +0200
Message-ID: <20260526113301.91492-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113301.91492-1-alexander@mihalicyn.com>
References: <20260526113301.91492-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x429.google.com
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
 tests/functional/migration.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 3b7674af3b6..1932151ab64 100644
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


