Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A82CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdUw-0001Gz-0K; Thu, 11 Jun 2026 07:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUu-0001Fj-22
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:56 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUr-00015y-AW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so514130f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781176972; x=1781781772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXW8+TkkbO/zdqSD0tRYgROfejMENktX+Aqzp4oymc4=;
 b=cg99FJDvRhm+JIfkkZ4ZICDWLbcOHG4UgH1nOiTbbsqfWJRXf9+PNdnA/Z2cuFw6tC
 Hy/JYN5jv3h41ZsJCaNwvh/dDsIhsn7mKvva2XvFpnJn8y18i/5PqMXvme8jIWTdnUog
 7UfOCIRDb7PTbnHpw51Q6K/KHjcxuCzAGpspY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176972; x=1781781772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXW8+TkkbO/zdqSD0tRYgROfejMENktX+Aqzp4oymc4=;
 b=JH0Y9Xooj59TeNBXyRz+X0pGHHxIRRKJwsw91jYlAW+E1swhEEJiY9ECVZruXT1qjX
 iQIYycrtnzO67k9KazmSG00iHnVTP2WuHW/BxIJGobROIg6GoZYwdo+/IAeZDrPi5KFW
 3Bdvc22Q07lrTbZUFklfib9v6scnfztLlhYUzXuuOPRUt5EQ9agEdXyhAi5O7s7XOo0z
 9M+pEpq2pTJcud/aO+UpNtpo3+ZDrGS3Ic9htLQqwP6HFflB5UuBQIgzP9NwSa1O0YX+
 5iCv5BYcKpgn3/eb1OOHKrr7wWuvftCk9MHl4zZgYuhFtHNYFIUiVMdg/J9+xWk3VSiu
 lVDA==
X-Gm-Message-State: AOJu0Yxt8VYqBNx4GheBfFDabH9Q4JnuQeVKumQzu/k8IME2eM4osJal
 QbK2UdlJqBFAjDZUpMXmXjrWKH1zkIPlFCm6/P8pEgeVsvJYlQt2xRKdB4TG7pCE41eUsYhBWhO
 7zHLSw3Q=
X-Gm-Gg: Acq92OGwUr9v3k/bsCxGgvaxuet5jOcFKFiXjZTlTDRrKi0hBEBcSLOprHCb1F8etD/
 k3eNgIkdfdyGVaiNSY3uTi4V86loJwWUErP+l+cUb8Q1JmjN+nBQYiFOuCV4vZeewd3YMta9GR8
 n8zQ7cW2RtQh9eOKpnMI1dQoIUTeZQA85l4YtLeFfRGw8+dL28+PblojiLpQOxrSqtleRLfdHNp
 FyFax4aamsdT85CO3nnI5ojDxNyp/vusS3lvfPRWmDODXtTlbjwmS7h0+33ejNzPCLjdTu5oYoY
 I69L5FR08WCDo2JkRLz3mPEdW0nj2EmzgdzRH9YTK5CbsEtwtOzssulLzUEfZZiumesnOxk6jvE
 DIfnmjoS/782/KcRw0wenhxSDhqykA6gqku4IYJLphDKLbuOCwKBJtm9e1Si3qY4TT/S5Z347Yf
 9Vlcay2/PZ0hSIY0H64VH5xTdsS3IjHfmb9/EjcA8EqvaqfR1z11bmYFQcjonyj90tPXYm+yah7
 AXe7m03PxNDDSeRnfk/nA3q+zlp+nKd4N777QbaFU24
X-Received: by 2002:a05:6000:1862:b0:45e:daa9:f34c with SMTP id
 ffacd0b85a97d-46067c35ea9mr3157241f8f.26.1781176971754; 
 Thu, 11 Jun 2026 04:22:51 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006c26edf58ff062dc.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6c26:edf5:8ff0:62dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm86375554f8f.34.2026.06.11.04.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:22:51 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v9 1/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Thu, 11 Jun 2026 13:22:42 +0200
Message-ID: <20260611112249.165012-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611112249.165012-1-alexander@mihalicyn.com>
References: <20260611112249.165012-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x434.google.com
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


