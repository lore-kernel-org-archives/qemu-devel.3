Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722EFC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRW-00024w-1O; Thu, 23 Jul 2026 03:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRE-0001xD-Bt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRC-000424-6E
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495590dde14so2854835e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790104; x=1785394904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W8/ql9oV4e6EQ7S+iz2MJkQ+GXmFiJkWowxvSQIx9Bc=;
 b=OfnZ3+E9UaoshLf+hW59CLEH26rajSuY3YhrxNpLHqhbyJtu9eaLI5DlGXh5XpSPHg
 Uq/Lorad3B3k3ustHpw2Z9ZW0C1aV0YMVjz8I66l5BBHqabt5ns4JEH7XEoIzeYsaOaV
 WgljRqLk3G4zps0RTAxiUiCH7OswyZ37s2eWSTzz05i6vNKrHKxt/y18HuLVua3GbfPu
 73QVzzGuU33x4TrdFfESBLK3qBoPfqEefPgvd7DdAig7M2yKiaGERxJ5XKoPvxggv0+c
 C1/ztRp9zvhTNzPiwWhyqyQW8mhqXuNGYDzhUfuODyg9T3AMDjrE28bL8/6LgCof22V0
 Yoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790104; x=1785394904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W8/ql9oV4e6EQ7S+iz2MJkQ+GXmFiJkWowxvSQIx9Bc=;
 b=WQBEFdHAjkZb3h5vulJm7VCPpHDkT7rfAEfI8WMvvbU4dYeTfftuom6YizdK7Yhtjx
 zEy5mr9bvVwem9ev/gFL4LOn7/bgQWnTNA7iGucltTAE7si/+78Uc9XHXe4lc/b7Be1Q
 PkFsbO73zLeXAw7ekR7R+7VZvozRp71thLEYOMh/OwdHjLYntrNWCcV65DKGXL7OCfBK
 Wo6U+U2lOOFrZzy9h8J0Fw9VV7xWi7vAlqVzJzVgM6d8WQrWEjyvmM/lrjfGYvU3qywc
 1O+f5k4uM0V658wg6DeApo4/aUA2wp0kjbxyV035egxieWYPPI9U1spnOij54HvQTiz2
 PwLg==
X-Gm-Message-State: AOJu0YyS+4Q++cpaqSRsD9K5qshx5zERGn/mdFo+WPY5Vglxo4mE1Ckq
 HOnPJCGgzGQRHXVSUvSodVlN0VbV74Ffk5COK1QykDvpo4NOJb1xC1rHzmrYpw==
X-Gm-Gg: AR+sD10D/DQTncT2eKtYfijS7hXMoNS++PhNH8wmdueU7G1m/uvMBnZOPzXJDCuaAEg
 4U1S3PtK7tSJHCm3BfBS5c+4oSDl4+zd4QVsycO3l8SNdA/4Pkptd8mAhFJofGMKU+Dp6EvUVwo
 JuTefB6YSqpQ7NNQ4tXbq6ag4wzpbHgG4P+siXQSy4aJvQAgwzJWciS3SjVYFtx/LVQeOWJtBI4
 suOiiTzPHl/IkGowvMJZGOM+DxYA/DdR0Xj54nLPUdLK/hMHeS49hsk58uqCrXnPgIELTyL099h
 kHnBGuOYSmQSbXLXPucqGiuD220HBOxwK02kC5DRQlt7ed3y9ABaS5ZV1CIP5Hg1H+nf7XCh48v
 JV7EdUcflWImxd3qmy5idXqsjgGanxN8Yg9ITvlmNV4J20s1FTyidEbh28F1Lv1shO9xL+4Azqk
 W4nUYTqwNwOix9+8PEU9/sOQuiVH0P1wQXpC1wbsmYyfYprjP6mDb3CHFvF+rFKf0/oxlbak3qE
 5B/W7DYFuF0fUl1srT+vT7bew==
X-Received: by 2002:a05:6000:4108:b0:47f:8fc9:6eaa with SMTP id
 ffacd0b85a97d-47f8fc96f0cmr1598370f8f.8.1784790104073; 
 Thu, 23 Jul 2026 00:01:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/9] hw/net/can/flexcan: Use mbs[] array for FIFO pop
Date: Thu, 23 Jul 2026 09:00:51 +0200
Message-ID: <20260723070059.6332-2-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implement FIFO entry shifting using the underlying `mbs[]` array instead
of the overlapping `fifo` union view. This makes it explicit that the
operation copies within a contiguous mailbox array and avoids Coverity
CID 1662971.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/can/flexcan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index da36d10bd3..3a97edf7a4 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -879,22 +879,22 @@ static bool flexcan_can_receive(CanBusClientState *client)
  */
 static void flexcan_fifo_pop(FlexcanState *s)
 {
-    if (s->regs.fifo.mb_back.can_ctrl != 0) {
+    if (s->regs.mbs[0].can_ctrl != 0) {
         /* move queue elements forward */
-        memmove(&s->regs.fifo.mb_back, &s->regs.fifo.mbs_queue[0],
-                sizeof(s->regs.fifo.mbs_queue));
+        memmove(&s->regs.mbs[0], &s->regs.mbs[1],
+                sizeof(s->regs.mbs[0]) * (FLEXCAN_FIFO_DEPTH - 1));
 
         /* clear the first-in slot */
         memset(&s->regs.mbs[FLEXCAN_FIFO_DEPTH - 1], 0,
                sizeof(FlexcanRegsMessageBuffer));
 
         trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 1,
-                               s->regs.fifo.mb_back.can_ctrl != 0);
+                               s->regs.mbs[0].can_ctrl != 0);
     } else {
         trace_flexcan_fifo_pop(DEVICE(s)->canonical_path, 0, 0);
     }
 
-    if (s->regs.fifo.mb_back.can_ctrl != 0) {
+    if (s->regs.mbs[0].can_ctrl != 0) {
         flexcan_irq_iflag_set(s, I_FIFO_AVAILABLE);
     } else {
         flexcan_irq_iflag_clear(s, I_FIFO_AVAILABLE);
-- 
2.55.0


