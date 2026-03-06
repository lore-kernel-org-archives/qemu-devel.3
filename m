Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57631FCB614
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWiZ-0007Wz-TS; Fri, 06 Mar 2026 10:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiU-0006sV-G8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:50 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyWiS-0003JQ-L7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:50 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9423d62cbbso141048366b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772809427; x=1773414227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIAmNR0oZ0DWaK6vnXUjsxDdMhpQMXKTi6OwuCEcqAU=;
 b=FG+VJwCUv08n6o8sxrCCmRdeuZxhsPt3EQg1Ff3AgwtsN0VxQzQaPNVM1tlT7oSF6e
 lC4SfEJY7AQxTkKVsg0jzklk1gC5zb6u/FAJcXpZKkf+40t7uJoqXPqTaDEyK5vtFy0/
 tMyt1ZQ/7kQtZ7S3p+WhoAYOVXGKOOCJxdcTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809427; x=1773414227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GIAmNR0oZ0DWaK6vnXUjsxDdMhpQMXKTi6OwuCEcqAU=;
 b=pRWl9eV/ppNAfryvGqBrAuvV46DZVhDpl3H3BSiK7EZMZvSpW74iXPLVey0Oz/ZGYE
 nF6+UBajsbMOM+j+AFRnEUxVpTDSWp0z5vn/g97d4f5lDNZGmKgdqfwXAyzDNhwrfLeH
 wy1AO8XkT01mH8Js+st0fGmi1OiUc/WfSWtmazuayn45voRk5q4oRDfoZoYQzgYHu4CT
 ByvFElcyex7cKBoKVqdbHD/2zbL4JT28j+crRUOvNJaKq+KB57vyoonUI3wAJU0lSbT/
 hUkbONjev+Y86YVnwqbuZW2ZOkk2qPPDnqeYJgtMnsJZ7o6rybrepFNXoQ/ONnJezZ6W
 H4OA==
X-Gm-Message-State: AOJu0Yxy34ka8aKRLd2VjDCx/5bLIr1w/fFQM4ZUvkfUrsXo8bk6nGz/
 DkWgra5fpqBtx/rWoggiB8C7KN0LL629Kmu/VFRyfClpfuIYbBMkjtoWfY9hc8XSOSH2KP+Mt4j
 3je+lySU=
X-Gm-Gg: ATEYQzw/HdqKY0/5J+WreLuH4AccT4vXDMUnr0tVzfRAHyYx/Ke7uR8y8tnwy1iDNnL
 jEKePt7vep/TkO4885Lk6VP3k6yau9wAuhs5Aur51VN2CQPOyfHTovbDlrw/jni9VGEye23aRU1
 +9uy4QjJJlRQdNhG4sucl+u4wW1cK6fE8rLRpvxHUbMrsadzTIKJ2+tVuyEXXGx9wlrv5gigo5G
 HdXLysseTrNwhObKKeeX4a5uxshw6B7dSo7nDssLqhzggbIz1jI4tgkdUjqAzjTYYEv0J766Eat
 L1AaPlbBixFruY9mQBDPS/lv839ufUfk4bGlJtdrv7manchi6/DBmP3iaD8rageWSeFfeluMd5I
 awe5ag9udZjeug0QAZ7nXZnDk6VmOLtGXlri/lVZEmSHzimSdKSi1h0oiGwBeuFkOkuYHT32vfb
 Ko0okafT3NLaR2Csx3KFj5d3IJTANNTBZj44Q45/0c1ZLa8EohPOAFMMyZTEVtAUCvnRx5KuNqm
 bmqW/v4SgcDkFO52g+jVSyJ5OqmpRWmnQ==
X-Received: by 2002:a17:907:9605:b0:b87:75c:3660 with SMTP id
 a640c23a62f3a-b9409ed324dmr393923866b.28.1772809426188; 
 Fri, 06 Mar 2026 07:03:46 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf57228c00583f1937c9b9cecc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:583f:1937:c9b9:cecc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae36785sm4703623f8f.27.2026.03.06.07.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:03:45 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 2/6] tests/functional/migration: add VM launch/configure
 hooks
Date: Fri,  6 Mar 2026 16:03:38 +0100
Message-ID: <20260306150342.395923-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306150342.395923-1-alexander@mihalicyn.com>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 tests/functional/migration.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 2bfb1f77901..759906fd820 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -41,17 +41,33 @@ def assert_migration(self, src_vm, dst_vm):
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
     def do_migrate(self, dest_uri, src_uri=None):
         dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
-        dest_vm.add_args('-nodefaults')
+        self.configure_machine(dest_vm)
         dest_vm.launch()
         if src_uri is None:
             src_uri = dest_uri
         source_vm = self.get_vm(name="source-qemu")
-        source_vm.add_args('-nodefaults')
-        source_vm.launch()
+        self.configure_machine(source_vm)
+        self.launch_source_vm(source_vm)
         source_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(source_vm, dest_vm)
+        self.assert_dest_vm(dest_vm)
 
     def _get_free_port(self, ports):
         port = ports.find_free_port()
-- 
2.47.3


