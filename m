Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EBBC36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 04:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzT2A-0002Nn-6W; Tue, 01 Apr 2025 00:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1tzT25-0002NQ-HO
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 00:15:26 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1tzT23-00067C-88
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 00:15:25 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so6707765a91.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 21:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743480918; x=1744085718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=XWdhtLkh9Cuym5k9ccauOExrWAXdOsewsn3csqwoKYE=;
 b=nLfXkeObSj9mcrV+8L1zoWWCYSZGkQMRznos3hsVMIoQMgLvQxePXfLSsr/omHnrqq
 +X6L9yRCvpFd1I26AaTYK7w65v0F8EkyVYepZENrQsxuseyyGG+sntG1ZJd1c6XfMEo8
 6yumgXQoVC4W9Bg13Znyq4VHgaB4XI2o2jzwuj96cJWB+5XjW9LI21n22zkdJxMA0kPR
 qZpFcw8AP3TEFwjWfSxaYRWuwXo3Rq7WUujNlGYbPAmkSBkBObZKyiljlPGOT3CVfJsq
 VbavQnoSkGR4pkwVKkjrX4KkL4OcadZOonA9egy78lAxTPHxpKZ5pezye4O2ZgAjg4Hy
 nC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743480918; x=1744085718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWdhtLkh9Cuym5k9ccauOExrWAXdOsewsn3csqwoKYE=;
 b=iVnY3lx/P4kunscWErjjTDIdRd/XnjKVyiMTAS2nAa88NTyd6xwWH3riC8BDV8Gxj/
 oy7dVNRFroSYGbfb0GwWV3q403SYxqBw+0MMWNVxO5U24bZHLgzUBvGvyTwkLe0fDZmv
 FQV1FDZOHOmBUDlslIbbvQStyCtUeudCSNhBTVFWxX4nhu3WI3pOUllUYQ2qQeOgxoud
 hwdbAHAeQIq/gT5394OCzlOLLVwNvCElFW8Twyt7/Nk+mJusFSCqdrRumI9RwEsFVJ/M
 ANnsBytCrj/1Pxwo0M8IKRvLKYoXYp8YeNMBGziLCXoWJSwUG+myvMIE2yIjVkv95iAq
 6vjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/eJtkRKW3XIfk4RzivHNHmkcFo4O7NHNEdERGgP6Ndd+0Tx4rjolgg5wVk7k14cBzqgVMjAdgHxz1@nongnu.org
X-Gm-Message-State: AOJu0YzGmnksWxuvL1Z+Dyge1ctQUOiIb/sxQOzuiJKP118GXvxBdPHQ
 LjAiLNL+woOlWx5G+2bcQLsTQgfbgfMgAefIdOvmIXtSF+1fCPgo
X-Gm-Gg: ASbGnctlONWUG5CHHYnBLPtcs3tS4MQL9Uge/VVK6+lcVGuv2f/PAUI4KzGTxYyFLFQ
 8Kg/4M9YZB8Y3xG4CQoL8h+fXytqFF5ZiTduVaz4VBHCYhdwu3xoJHPb0qxZfdaWcSFD5A46bSC
 5kTUvPpMmikavIBqv7I+SDv6G1I4oJFcwJn0a3pNE6NIpTtQc4deLKK53s8IvGhU9nv92JdVF/q
 FJESvK7XChiHfWJ7hgl6Ek3oLMF/gvBM9Ty4gB7obyvTkkwq4mlVq+s2NbS/K73LK59kBi18bZA
 ni6nd1lnAvhDsafPtQxTtKfnrgK3HLifO9XxeFoRLZLpFTQCJy1uuTGL7MtGA6gukA==
X-Google-Smtp-Source: AGHT+IGmaz1kDDKSU0sj9WNLtds4v+SkkJ4P5LDRtYwQlfPuKUzIirDQOUoGE1XknDZpNOi5c/0wAw==
X-Received: by 2002:a17:90b:538e:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-3056094a636mr2887609a91.27.1743480918356; 
 Mon, 31 Mar 2025 21:15:18 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.18])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30516d56008sm8192117a91.18.2025.03.31.21.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 21:15:17 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH-for-10.0] hw/core/machine.c: Fix -machine dumpdtb=file.dtb
Date: Tue,  1 Apr 2025 14:45:08 +1030
Message-ID: <20250401041509.719153-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In commit 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb
option") the call to dump was moved with respect to the init of the
machine.  This resulted in the device tree missing parts of the machine
description, depending on how they construct their device tree.

The arm virt machine is missing some PSCI nodes, while the riscv one
is missing most of its content.

Move the dump to after the notifiers have been run, allowing
virt_machine_done to be called and the device tree to be fully
populated.

Fixes: 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb option")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/core/machine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f52a4f2273b2..63c6ef93d296 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1731,12 +1731,6 @@ void qdev_machine_creation_done(void)
     phase_advance(PHASE_MACHINE_READY);
     qdev_assert_realized_properly();
 
-    /*
-     * If the user used -machine dumpdtb=file.dtb to request that we
-     * dump the DTB to a file,  do it now, and exit.
-     */
-    handle_machine_dumpdtb(current_machine);
-
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     /*
@@ -1750,6 +1744,12 @@ void qdev_machine_creation_done(void)
 
     notifier_list_notify(&machine_init_done_notifiers, NULL);
 
+    /*
+     * If the user used -machine dumpdtb=file.dtb to request that we
+     * dump the DTB to a file, do it now, and exit.
+     */
+    handle_machine_dumpdtb(current_machine);
+
     if (rom_check_and_register_reset() != 0) {
         exit(1);
     }
-- 
2.47.2


