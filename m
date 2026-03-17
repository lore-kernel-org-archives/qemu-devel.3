Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C19FD7072
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ReS-00023J-50; Tue, 17 Mar 2026 06:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdx-0001va-B8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rds-0006W2-2z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853c3c2fe7so32668925e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773743235; x=1774348035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mdV95Xn1uRZNv+wMaqt5uMFd58yUD2RuxYvZm/pTuU=;
 b=BT4WZMfRk2VhKDke9wpMnwkiEAhVQjrvX673zFan8dCTyGOic7FpJ+2lXVbEa+mxqL
 D1g7JRPQM9LP261LM0SaGmTp+pWjiqoEzOt4HPr6Tei8UjsTiW2b/6SA+gvFqvn1Fo6p
 olnxGzhofadI3j7E1KwfIcNU5PaKBJjNre2bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743235; x=1774348035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mdV95Xn1uRZNv+wMaqt5uMFd58yUD2RuxYvZm/pTuU=;
 b=FYBvKLTa1vMNv93MMiZ/lZt5iJWxpQTMnNq0OTcQqQkA8L8Z3GLBcDeS1sS2DEbWes
 YGxY7kl7sw08askjuMu6HH/gmLGNEiUEIcPVk2ERbrpDRzIFAZYcCrU/oMPNhQ1mkU9j
 x1DSvZxuk+6pvSP65x+UB77AF4lvxeVjjmj/fmiRwCqPL+mz+HKefOoSa1GkgNJ+aVx2
 FjZYsAGrnakzF4vnQ1eACe+FiNLu5RWVpaSemys0ODV/2Y8WxFpVPdHDNIxFTH2vel+P
 jolKkiYtO1fBI3F6flrC03iJ9L77uuHiExELSeNjk3zz6ORzgohwHCzq2EDoh3QnDRqD
 aq6g==
X-Gm-Message-State: AOJu0YyrZldsZ87jBaXlX3S3gSd5movGkQc9OYcZWhlL6WhZjRwOS2e5
 e7uIBVBNrPf2zZaDGJ2aAZg0w4ihFhkQ2U2LHIPAOZas2J0HB/7jk959/njTDFwn+EYN0e5WueT
 c56Rxefk=
X-Gm-Gg: ATEYQzyGeBjg+McFgFaRKt6q+O4InedLnoYZ2YeF3lZNxn9k9EmnwxEvpB7DLM0pQql
 5ni7IW4qKkwUdlqMs3cn4s8qcaF9YqYmrxJO8Yot6M8oyGqfwIRcc1Mxm3a8DFqyi7Ahf0IkiSR
 Fd9fyRTFdBtg5M6ZUSRjh/+esjibCoafI+z8ErtJwhrSq71dfGhIxpwyaasBAaZbWjTje9gjR7c
 IihCZ/fttTwXG52eDNq9yZkp0Lt/d0juFyxXIH3X4Fmrb857a6QJ0WzI70jXGTh9gwj1aasW49d
 OsuOx7FJ8Pe/1rpHhfxMSfUV5IvlJSfP8wkyzG7Sf1dQPCw1TOMQHU2o+gGlYMWdSQyWvu/yv6n
 D5pKDSvdbxexX2Xf1YWH+EHtoxX871lfpBZwwrvk82rfykUtGHULC0GElN2YcAyJV6dHn6q/7fG
 h4JQ7IVdjqQCAgAKJpAFP5qK3TUBl1yuw/k+U3tTY4zUACjcGIYzLxzQKKA06G3cgPmzi/GDiq/
 UBXj+VkNVvkTOYKxO8kXE0=
X-Received: by 2002:a05:600d:8488:10b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-485567060a1mr198689335e9.24.1773743234402; 
 Tue, 17 Mar 2026 03:27:14 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0051af80c54da1a9bc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:51af:80c5:4da1:a9bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c36bsm61977665e9.9.2026.03.17.03.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:13 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 4/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Tue, 17 Mar 2026 11:27:04 +0100
Message-ID: <20260317102708.126725-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317102708.126725-1-alexander@mihalicyn.com>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
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


