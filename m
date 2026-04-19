Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2830FEA7199
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERmz-0000xD-8z; Sun, 19 Apr 2026 09:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERme-0000tm-Uc
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmX-0008IU-RU
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:01:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so1419024f8f.0
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776603703; x=1777208503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OztW63tvsDLU5EHuMGMvPzYUtmXl7GocMNqQvsnffQ=;
 b=Wz5mhKN5kiETJuPc4AHKD8m/D1YkXPnp3OBO1+96VTJ5Kc0zHNSFuZUDMHe6mIKl3T
 fkKd5Dqq0CT4KOWrNzIATEfSinAJNTlaojLcQd0bPkDnM272Y01EemNam0HsIMbA9X5l
 40bacxg5Yt4H9KmfYAsLdA7gc1nY3BAYQ0/+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603703; x=1777208503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OztW63tvsDLU5EHuMGMvPzYUtmXl7GocMNqQvsnffQ=;
 b=Em7/hcpNh13wFXn4ElSfSqCTvwSuDP7CLacsqXhbYIaTieoxVAeyKKy9yv6/UeBbw0
 6zog2N1Ak51do4uaadV7hL62fSjJ3kPzCOX3Ik9B0WbFTKXzbXf3gAAyh6ew1iN6Etq5
 bh4RAMeLwsBtZNG7xHpkWXyP1KRgM6PCnM+CoMDHpUv4CY5LGO1B72dl+3m6VX4uZUIv
 6SOr2Zx23i5j9LvMLEqLjq00XoA21xe2FjXpD0ueMm9gVn2+YWEBrKWIKvsF0z2R1swF
 dgrBWQ550jg0pmlijcMQhQN/GMYt3Qub6L5Krp4ILAgSTlJr9W/2pSvhiICo9abSWeZZ
 8CZQ==
X-Gm-Message-State: AOJu0YyaqU7GbGuobZbCEhw8/uITdeObJqMrjF6Z7UNiQtqFOA8C8lsY
 Fc3O2VF4O5CHAoJbO21uSMYYs7J5gxQW9y0dh6SvW85iZUcI41u6+CyRdBA/TICCKJBdiV4cuAU
 DKgsL2Os=
X-Gm-Gg: AeBDieuP61Bx1wRJv4E/cxi+BBOuBZVkb+2X84FThCTGupxGzjxppHzHzrxq0oTQgIt
 kK3CtwxBOq1XnItqGZliCXonhrL6WJsZxxdvLVD0QNI46D9c+iVgi/Pr6k3vrgr06J9XzViYUom
 bB2rJs68xvUACajWe1FYGxAGDEfFYRHEFdYV/O1t0yXEs0DFTUHydK43Mk7OK8BZKH+K10ExREt
 6HXS/OhcXK5eOEqz7Pm8B/4KpCulpK9DYpUun35KrRBhuxXMID9+lob1hwmUtiadbs1J6guNun7
 QaGDi+tifYbjBKhlGbYqME8zfkC0IPK8AnumdWH7dhqDUs/h7g/ycW8kqBOCmzky0yHVd/7cXFe
 Jy26st/jz3+mv3d5KQRl/X6TZv2hCE9vpRfjS3hTLLxoeDZjPuPtY3DAFfUzyTIKVmL0kCZ9M6m
 YsMMxmIg3V5Ru6h65m1MQ/K/hjClZpTNPxQUiYM3h6Mtzf0A3SlDFsDtLkMOILsnI533KFvrdM6
 bJuhHQ5SOuDvMPSw51UA2/x952X4FYTSA==
X-Received: by 2002:a5d:64e5:0:b0:43d:7606:5a47 with SMTP id
 ffacd0b85a97d-43fe3f358a5mr14523615f8f.2.1776603703174; 
 Sun, 19 Apr 2026 06:01:43 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00995e4e0d3496e07b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:995e:4e0d:3496:e07b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm20734304f8f.13.2026.04.19.06.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:42 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v6 1/8] tests/functional/migration: add VM launch/configure
 hooks
Date: Sun, 19 Apr 2026 15:01:32 +0200
Message-ID: <20260419130139.15554-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419130139.15554-1-alexander@mihalicyn.com>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42e.google.com
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
index 2395119d6c6..9b5b31efe3e 100644
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


