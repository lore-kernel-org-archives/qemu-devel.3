Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1E8C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmn-0005FD-Vo; Wed, 23 Apr 2025 20:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmm-0005EE-48
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:52 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmk-0004Ky-Ad
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso385174b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455789; x=1746060589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6Vz4XH9MaqIFBg1Am0iCdgJbwVNs6lvQ+uGdrd8MMM=;
 b=E+3qSF+YivTJGGQ4mqPRkXcFC90yY2RROdeIZE789EMOtkIFsxssiclRfK3cmK2Zuv
 1sekOjkGwW0jzbf6VSnmP28z5gqgjlQ3yHxDPqrrycd1T8eG+FqNaJJF+txzWce8bVNq
 VijL4PXYtaPze4EJKqWU8h+4rb3qFVqZX7qeFHvhSEzONAXKtLZaOxSNAlVq1JMjFwEE
 uo6EZ+TM277fTiQAXkkslnpo42oYxYl3kL7SKYxIwEpcGi4Ur32X2lZf4ZAM2qswUWMB
 lSIgKHe1Knmn1DWdpS7PnWP7JKymg66uofQf7a78iivfiSFYPH5X3s3BdRYSgIU5lIL4
 BKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455789; x=1746060589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6Vz4XH9MaqIFBg1Am0iCdgJbwVNs6lvQ+uGdrd8MMM=;
 b=C/BolflBOuQgvzvJ0IlGmq5K8AMejp7fSKgBy6XAmo5wrGRSXHq6YZWwmY/sDv67Qp
 mIWhk054OLQYM9iQECpvty9KiX1XL9fWGffrEvW8mOcs/x6TkpOs7iKVmJRVGvZd6P+I
 V3fNc0d4v4UwaqV6R+PvpSoz48efokRTFp/2XkTrWKbUVCVFd7byswhcGwQUMXxaLsTV
 rUP6kfR383qnvnAAWpA21XPFnL9AQNQQTufP09yN/HlK+cvPmRudkTsXmbRWcfZ+02uo
 Rf3km12p1HJ78eUOjaacgfNO9UvFL5Wv1mwXPpzBJ0HNLREhEBnD2o9tWboOEWv5fiRy
 uy/w==
X-Gm-Message-State: AOJu0Yya9n+KpY81Paxb4kw3OMoPOY7LzrQGy8k/vNjpT6hm7NykAOzq
 GMBgzCiJ6l8jX9v3y+WbRY6wNwIS1NkrLJU+eDj7Yd/iP4xtxh5/Yd0w4zEUp6Me0l617qUqmyW
 8
X-Gm-Gg: ASbGnctEfEJ7ZdlpT9HAQQOw0fH5KcdsPhQtF/thPuz7baegYc660D8/x6NomDhWsJZ
 vAHvYM06yZQPj0Cp354uFMUDzMrug63UPRbLnVPlgr5avddhtQrE3C6lDf6BSzHfxM+BwyxPWk/
 5v0U/y5I4wQeyvTqh2X1U/Obg+rUlY8VRnmc4ONvF1hn22FPBHAJEqt5ioeXHYst3lLV4v7gH4v
 pyUPqNiNWYEhUo0YEcoE18rw2DO4aL1YasF+eQZX5EkSai/BdlRld0Ze+QD0Hpo2IPScmpyA55I
 cPFUNhthKl5NAg/VON6R1a+nCjJyDBlupH1feBl7rCrnoszrTJeVL5ArBM9Os3bwgm7dNFxemd4
 =
X-Google-Smtp-Source: AGHT+IGGT19k7qzFFytZA20lHRRUxoeJBKUJ5Rd4rvNunH1r9wIPM3fP3xRHTyHcF91+oTA6sqUaxw==
X-Received: by 2002:a05:6a00:2d21:b0:736:a4ca:62e1 with SMTP id
 d2e1a72fcca58-73e2460543dmr1099518b3a.6.1745455788634; 
 Wed, 23 Apr 2025 17:49:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 017/148] system/memory: make compilation unit common
Date: Wed, 23 Apr 2025 17:47:22 -0700
Message-ID: <20250424004934.598783-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


