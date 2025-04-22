Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338E9C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIc-0002aG-Fm; Tue, 22 Apr 2025 15:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002UR-IR
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIH-0006Bg-Go
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:36 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3081f72c271so4854831a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350112; x=1745954912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwyTBdqp13kCnM3X/zqfhjWljdjzp0yIZaSQfrCHsoc=;
 b=O6qCBERf1fo3fjZiwrFoBw0qQ2/pcDrOuIFPvyRjaun4z76ofl2juNF8dScMfl3c+8
 deRsm9alaB5M3Pqp5i5dxFPdOqFbg1iqPFyo2oAsQ9QqHXgrQxRSNfcB6XAIYtj8t8mi
 SYxMFI/Rb29wA7yzRNEaCLo9JNc7lKw+L+alOz9VWdJ+yad/tqyNRQzC2ANB088Qu+5E
 upX98dgM6Ji9rSHRsvvuUu5qNbLm2sU3YaS1XO87KlbG/fGygE0eBOaBMiHQdTyvq8pz
 Up1kdwT9rQGGkWqzRZATLzOfIWWY/dw+zhf8u1Pbd4yN/u8y89HreOn9ckZHar+ffTFf
 7CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350112; x=1745954912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwyTBdqp13kCnM3X/zqfhjWljdjzp0yIZaSQfrCHsoc=;
 b=hFS5BOfar+o/x7Irj2TSMDwLEqKY8094Ud0k+y4poNF3lxkeSWnpua634LkhjZtHNI
 3XhTl+rwwZ7jFyGFL2ymwtMJUQt1l9drLR8TdyMSCr9gxFMe+GDPFiPsETSrSz6qVCo5
 PTGo/eUiWBzyuBRCwjVDcorjOXov/lBq1lWIDeTe8rgqg04g/HqRYIOSPHDc9r/mocwI
 /FV1LWiMwOpMjOg3k2p1GLUCDnOwGg/mGwcb+ZPrt+GWTKM4WNMSeskKRTcFrBnzTwP3
 7p+DVp6OwK8ZJT/8U4WzSQJQHyQGG931qIap/286shcmrkE6r1/E3KKFe2J/xy3NgL3X
 PhXw==
X-Gm-Message-State: AOJu0YwxEt+piQPTGg3p90D//PeZKO+Qhoy1kKNaeqd+RHyYv3zpnHnY
 cAKeZ441AYDJHTlz55kfGyIqD2WQW9xLLVb1OHU4bm1mO6Fh6jz2t0OQNs7SyABeyt5Lh/ClQE+
 x
X-Gm-Gg: ASbGncvwtMDnFrBd/gFSHfhR+TPQgmLC0r4RujEt1PXP4i22VsKM9M12VwFqUHeg5u9
 wAO+tBwb558N08YeKuglfyxzc3XeOMQX7gBtgDM555CoOmaSH2axH6IyC0yFEaiTlquv4ic3ngb
 ysfs4MQco8EdcyzkItUzL2C2Em6K+fVoIDC7OT1256PnYZAWZXf7NcxbYaKManHpI7E3AWYUCG0
 FCl/oYaBnlB0hf8uFjKMXSGmRS1066pIiDNSTd89eHVQ6O2ZQWSuMdeWzGbylvEa8xBS7JMYQtd
 uCAWNwgDEyUMtlzEFHzbnoMST1mQTP8yDp9gbToPZd2nWOfeMWSh6Er5IB5rCkJbfORidUSXWds
 =
X-Google-Smtp-Source: AGHT+IEfnzozH/GD/39Rm678OeN/okYxpIAa0DABYFglYsxIbO2m3beYL+85XmjjGKkimhlzYNdHtg==
X-Received: by 2002:a17:90b:3d50:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-3087bb69fa6mr27181132a91.18.1745350111685; 
 Tue, 22 Apr 2025 12:28:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 017/147] system/memory: make compilation unit common
Date: Tue, 22 Apr 2025 12:26:06 -0700
Message-ID: <20250422192819.302784-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-18-pierrick.bouvier@linaro.org>
---
 system/memory.c    | 17 +++++------------
 system/meson.build |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4c829793a0..eddd21a6cd 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -353,15 +353,6 @@ static void flatview_simplify(FlatView *view)
     }
 }
 
-static bool memory_region_big_endian(MemoryRegion *mr)
-{
-#if TARGET_BIG_ENDIAN
-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
-}
-
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
     if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {
@@ -563,7 +554,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
-    if (memory_region_big_endian(mr)) {
+    if (devend_big_endian(mr->ops->endianness)) {
         for (i = 0; i < size; i += access_size) {
             r |= access_fn(mr, addr + i, value, access_size,
                         (size - access_size - i) * 8, access_mask, attrs);
@@ -2584,7 +2575,8 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
@@ -2619,7 +2611,8 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
+        MemOp mop = (target_words_bigendian() ? MO_BE : MO_LE) | size_memop(size);
+        adjust_endianness(mr, &mrfd.data, mop);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
diff --git a/system/meson.build b/system/meson.build
index bd82ef132e..4f44b78df3 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -2,7 +2,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
   'globals-target.c',
-  'memory.c',
 )])
 
 system_ss.add(files(
@@ -15,6 +14,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'memory.c',
   'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
-- 
2.43.0


