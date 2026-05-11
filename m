Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48BBCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSIR-0005pR-BQ; Mon, 11 May 2026 11:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIJ-0005om-Dv
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIG-0001or-V2
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso41324565e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1778512299; x=1779117099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CxqHbd3By135psgYqUZT9zQLEQSBWcZUYKQnFu3P5w=;
 b=DFywGeQhk3UMFO/GLvuhBs3ao6TnqzB5tjIDZEMt1DW5XiBaHthOS1iJVkrsrthwhb
 I9/GWcuFqYbuvkauvD7Rr6cDyuoFqhwuC0D9Kh+d3QF4709Ur6G7aPUgITULdU7OXt4B
 CYlnJH8XFgi0HrnPD0NBypAnGDIndRuj2Cxy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512299; x=1779117099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1CxqHbd3By135psgYqUZT9zQLEQSBWcZUYKQnFu3P5w=;
 b=PyhBUf3dsleXOu99azwi9mAxQTy5biQk90rW0fBs5RTFHOwzAppVe5PbbWE4YIqIKq
 W5FJPe1+RkHOP0FykfJWUXFDAMUCCDkvz1Geb5xO/bjiPqgvppaDPti9IOxfbKLHcPST
 devKuXdaodr6MH72MLHg1GIXV5q7hYCbf8YQjpeD2Xu7g/1uGyn36vr0pDLDSoXDCv6h
 lYEet+ZgCmpwf4A0fdnBPNoiTpPYlm8rgn4cXR6jLrz2N0sZFKVqGvmzq6qjcGj8imFG
 L/ZxROwx01t2Nm2nRe4LmPQdqzKmZxHbFO23d2csQ7+PLrJuZM02FQHuHyYBkqZdcFoi
 Qvug==
X-Gm-Message-State: AOJu0Yw8jmmg0ioe2GaVUd922m/BEkrC9zvtXJe3mF+6aYZWAPTNbVAN
 15Az/PICXSZhtrmJ7FOVMXV3Y7WKj9nDvyWXk1oxYLor7ZENmuI/lLhh0mAvFmi7RyNdlh6mdWH
 Aef9achU=
X-Gm-Gg: Acq92OEubPgKWrO/xM/hvOB+bU7U8aTwcO3dHAjtHbocvgYw2pW+eDglUk7Hm1AiUwp
 Tg2+tGLY5K7at6Uj6K5ojYeNI1m/X+fttmPE3Wr42AaeN5KGUbybrm+RW+gfa++ACu9YJjyMpHU
 hdj/HYIDXjxPd73IY95uR2AD3eV0XYIvPwiKcogy98q6zXjfE0DpJq3mm7ACzGaJZeoPAraziKJ
 ZWHsFx1l+IJXwrGBCyCzzih7u0EgMO/gw+4gjw+UocWpea1vSQ995/ZcCBiXpKvSQzfHrzHKTFL
 zOmBLg73qr/heMBoVo9KsoQjZVcmXVJRdxHzvwtLrk1qJkhsQhG3MSx1PZziwQMGk4XOSDZBjeY
 QUsrMFUlxacnFw7r1PJg1lWRKgr11zgxvmf8hXN0o5TBeNxICfLu/Qi7dTVGHU3/g2dlGDUdgVF
 F1JeXDNwDG9kvrmsvK4gvI1wsNJOwEeXDb0erKMKbHR0QfMNUr0YcRWGEHFwgXHfSKNelNWKx31
 4CY17/5V2YNjEXvIrML
X-Received: by 2002:a05:600c:19c8:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-48e70687ed2mr170139945e9.5.1778512294752; 
 Mon, 11 May 2026 08:11:34 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00267b069c8b2d0c7b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:267b:69c:8b2d:c7b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6813sm65766925e9.6.2026.05.11.08.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:11:34 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v7 1/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Mon, 11 May 2026 17:11:24 +0200
Message-ID: <20260511151131.483217-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511151131.483217-1-alexander@mihalicyn.com>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
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


