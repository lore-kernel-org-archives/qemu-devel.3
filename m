Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED61606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=T+pHY3+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwa-0000aH-Cz; Fri, 30 Oct 2026 10:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnry-0006jJ-Pg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:15 -0400
Received: from va-2-55.ptr.blmpb.com ([209.127.231.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrv-0005Ui-LM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371563; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IonDBf2B4G18TwW12GymOA0TnRXyi4hiyiUl+1xvtRM=;
 b=T+pHY3+hxzzydPxMg67ObZJxQP1cJo3oaHLvNTeywpbxeHfHWrhHLJ+baJL0yfcjaVN09F
 VYyK1/16DeUsGUPYQQB2QBnW7E7PEaKMll6q9ilV0eOfEEnIa01/ZDa8tIOOVEgVyFE0hm
 pBJl9NDY5pbaWfl/EwlUGLgzoNek6Lysq4TbMH7qVVWM4eQDuJMJCAadpFZ0fxJyIYBwVf
 hqbu1htEjiE2Q6mZduglgyQuNja0efArIBBhUEVYPKUJh/E9Qr2/wT2KcAzYaYz/WCC63j
 sH0DTorbaPXgnocmKaTZLen8FeyRciSgytNmQp4Ef9igiPAl15n1PKBOzUa8bA==
To: <qemu-devel@nongnu.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Subject: [PATCH 2/9] hw/nvram/fw_cfg: reset out-of-range cur_entry in post_load
X-Mailer: git-send-email 2.56.0
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, "Gerd Hoffmann" <kraxel@redhat.com>
Date: Fri, 30 Oct 2026 22:45:40 +0800
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:02 +0000
Message-Id: <b3508b2dd7f8bf0a9961ebf37b9b07b3a9890416.1793370600.git.lbyxiaolizi@x6z.top>
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
X-Lms-Return-Path: <lba+26ae4adab+fb0596+nongnu.org+lbyxiaolizi@x6z.top>
Received-SPF: pass client-ip=209.127.231.55; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-55.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:42 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fw_cfg_select() sets s->cur_entry to FW_CFG_INVALID when the requested
index is >= fw_cfg_max_entry(s), so fw_cfg_data_read() and
fw_cfg_dma_transfer() only check for FW_CFG_INVALID before indexing
s->entries[arch][s->cur_entry & FW_CFG_ENTRY_MASK].

vmstate_fw_cfg restores cur_entry directly from the stream. Add a
post_load hook that resets out-of-range selectors to FW_CFG_INVALID and
clears cur_offset, matching fw_cfg_select().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4773
Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/nvram/fw_cfg.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b057d87..e5d7811 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -36,6 +36,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
@@ -676,10 +677,27 @@ static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
     },
 };
 
+static int fw_cfg_post_load(void *opaque, int version_id)
+{
+    FWCfgState *s = opaque;
+
+    if (s->cur_entry != FW_CFG_INVALID &&
+        (s->cur_entry & FW_CFG_ENTRY_MASK) >= fw_cfg_max_entry(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "fw_cfg: vmstate transfer received bad entry value 0x%x\n",
+                      s->cur_entry);
+        s->cur_entry = FW_CFG_INVALID;
+        s->cur_offset = 0;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_fw_cfg = {
     .name = "fw_cfg",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = fw_cfg_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(cur_entry, FWCfgState),
         VMSTATE_UINT16_HACK(cur_offset, FWCfgState, is_version_1),

