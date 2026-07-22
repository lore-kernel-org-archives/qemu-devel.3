Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD723C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVPA-0004Xd-T1; Wed, 22 Jul 2026 07:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong.lzr@alibaba-inc.com>)
 id 1wmMBc-00051q-Uy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:55:52 -0400
Received: from [140.205.0.221] (helo=out0-221.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong.lzr@alibaba-inc.com>)
 id 1wmMBW-0001zA-Li
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alibaba-inc.com; s=default;
 t=1784685265; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=pNVKijdnjqR2liQ7V09rN3/E58kKE001F7kXRdqce3Y=;
 b=Ym3zZb6ibU6DDpCaaa0NnaTzPa2Ds5Osg+oyirSnjaswR1vorbIO4JXhp/OAFIuZOtFaTUH+DinP+Mu56LbDXDBw3ITUsK1HUn2zB528oTx2t/8y/tCM8xMGfpBsiu7r+rWfLT05MdZ8QfPriwhZU8+gKKNqZPoJiQbgQPOTroE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068016216;
 MF=zhengrong.lzr@alibaba-inc.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---.iRIiPAj_1784684943; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong.lzr@alibaba-inc.com
 fp:SMTPD_---.iRIiPAj_1784684943 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 22 Jul 2026 09:49:09 +0800
From: "=?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?=" <zhengrong.lzr@alibaba-inc.com>
To: qemu-devel@nongnu.org
Cc: <pbonzini@redhat.com>, <viktor.prutyanov@phystech.edu>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <zhao1.liu@intel.com>,
 "=?UTF-8?B?5p2O5bOl5bWYKOadkeWPlCk=?=" <zhengrong.lzr@alibaba-inc.com>
Subject: [PATCH 1/3] runstate: set crash_occurred on guest crashloaded
Date: Wed, 22 Jul 2026 09:48:37 +0800
Message-ID: <20260722014840.36671-1-zhengrong.lzr@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 140.205.0.221 (deferred)
Received-SPF: pass client-ip=140.205.0.221;
 envelope-from=zhengrong.lzr@alibaba-inc.com; helo=out0-221.mail.aliyun.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
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

Windows pvpanic driver writes PVPANIC_CRASH_LOADED (bit 1) on
bugcheck, not PVPANIC_PANICKED (bit 0). As a result,
qemu_system_guest_panicked() is never called and crash_occurred
stays false for Windows guests.

Set crash_occurred in qemu_system_guest_crashloaded() as well,
so the faulting CPU can be identified in the guest dump.

Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
---
 system/runstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/system/runstate.c b/system/runstate.c
index 08acf801b0..c7961cc1df 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -724,6 +724,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+
+    if (current_cpu) {
+        current_cpu->crash_occurred = true;
+    }
+
     qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
     qapi_free_GuestPanicInformation(info);
 }
-- 
2.43.0


