Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7D2CD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 05:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV0bE-00049l-1z; Thu, 04 Jun 2026 01:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV0bC-00049d-MG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 01:26:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wV0bA-0007th-Rf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 01:26:34 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6545QDxT008958
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jun 2026 14:26:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Jtb58Q0bo+ruLxhVDtt1iz7EyCH4ENLaedk1u9XckJE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1780550783; v=1;
 b=UtJSFkD6mUElBeA19hQ6Fq2Md3s/77UTTqWryO8+rlIOjybRGL+JkA3pjL5Z2RGt
 mFV1tqXksRMn4pFWTyty3lV9qsV3E1a41e3ZONcqRKQ8nUas8DzEgxmB7yQSzQTF
 1q2LUJaidOTsYtRk3hp5lgGWmGCuFO5IjWOdHF6rjnyENcC/NYobAjM0LXAKfW9W
 vQlTTcT+VjnnBjGzKEzR8UAYdY7BlBP3N+KsH6+24iufbgDtiKiKzeVyRHAnCSvc
 SN7U34mvr0AA8K8eNYC/anI3D9qFvssO8P+wVOh1RJfbDYoeP7auFXAbECvzpxg3
 22P7ieZTO85IZDlPHj0njQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 04 Jun 2026 14:26:13 +0900
Subject: [PATCH] system/physmem: Assert migration invariants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBSA4VdZ59pqG5a8ilxsc3CU0YaUvLvh8
 qu//4KIgTBCzS4IeFCkxSfIjIEbjR+QU5cMSigttFB8piGYLVVcllJVncVC5BpSvwbs6fxeTfs
 77nZCt70DuO8H/PAYQm0AAAA=
X-Change-ID: 20260602-migration-15128dbe4036
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=c7OrWXCfjCvelYLH9J8v7KEw3IYBvGn59VWjHXSUou4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5YiT82xhBLtT3aNvqdvr3zuOGcTw6oZx86rRyjfbdE1y
 H4bOCO2o5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCJXOBgZVvJeSoxJV3GbdaDd
 ii/wvmL4Ie1PC25dWdg9IdTS/itnBiPDJYMVJZsmf/8VKm4f6vivL8DUVCG+vbF0h9zsyl/p4Yv
 5AA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The migration stream assumes that the set of migratable RAMBlocks does
not change while migration is running. Assert that RAMBlocks are not
made migratable or non-migratable during migration, and that migratable
RAMBlocks are not freed during migration.

Non-migratable RAMBlocks may still be allocated or freed during
migration; for example, QMP object-add of memory-backend-ram creates a
non-migratable RAMBlock without exposing it to the guest.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 system/physmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf8757361..42a39141645e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -39,6 +39,7 @@
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
+#include "migration/misc.h"
 #include "system/xen.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
@@ -1911,11 +1912,13 @@ bool qemu_ram_is_migratable(const RAMBlock *rb)
 
 void qemu_ram_set_migratable(RAMBlock *rb)
 {
+    assert(!migration_is_running());
     rb->flags |= RAM_MIGRATABLE;
 }
 
 void qemu_ram_unset_migratable(RAMBlock *rb)
 {
+    assert(!migration_is_running());
     rb->flags &= ~RAM_MIGRATABLE;
 }
 
@@ -2599,6 +2602,8 @@ void qemu_ram_free(RAMBlock *block)
         return;
     }
 
+    assert(!migration_is_running() || !qemu_ram_is_migratable(block));
+
     if (block->host) {
         ram_block_notify_remove(block->host, block->used_length,
                                 block->max_length);

---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260602-migration-15128dbe4036

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


