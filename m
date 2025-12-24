Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A1CE7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQkn-0001Tv-Hi; Wed, 24 Dec 2025 10:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkk-0001HZ-04
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:26:18 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQkh-0005Hr-8b
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:26:16 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so6051665a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589973; x=1767194773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciHvWMdrW5Sv2qvr8WHVSOrW+TYMJuHWb7J/Tww5uQw=;
 b=QWDP2rAMMOeFcm1MF5qq6YodrXLCXklSPZeMLm0Gz9xeHe2vabUKyRs81AXt4O4/95
 Vm1QHTkQIIZeharHsRbiD2VGksm5YhUxjnKXgNqZU5Q1oTo5eIbXa+edH2i777ujafkL
 Jx2kUiuv5UTQR++oHB//GIlz0wEudNtQrnT47koXJBS7JeyP0UsU0BdpGeMVullWLdL7
 uxgeBO1A54FZ/k/wyXuQQ0dvM7Ux/W+P52i6v0DexARC0y3kCkI1I4mz/0oBcdL8lYut
 rE99Fwyiwzu+WLqL3NNJbtPRPcFoFbhogRyaD6HiCiB08LG1fTw0xOwi6nngm67gffLS
 MnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589973; x=1767194773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ciHvWMdrW5Sv2qvr8WHVSOrW+TYMJuHWb7J/Tww5uQw=;
 b=UcvJhl+BhfXZBng6E1KU6mTkwvzSP0yxj4M/MqP7XuMHkqw8BGoY79ZEBTqQFqDKVr
 N724fiZ7H9jsIA1sUi+/du+YCUUComeSvBxRFBXrPxsxxPpYxT7Ac8scuyW0OMlzCNSX
 zMrwJBEVd+Bmmrraac4THSte2AJs9zn1OiShz9nVlEeLcymRtdKGamRC0TAMxHZQqDuG
 gqU3Gwu3uh2O4yIIWolZi7xzMx7M8JFbkKyCHEjCGx5vkkcl4GzC8g00TLeq8b6Nlu7U
 8zLyUERhCuk7RMB+B3Wsnnf37/dY5Aywpu+H/zJFY+HYKz6hFxRskjm90h9ZNWbuByFG
 XqUA==
X-Gm-Message-State: AOJu0YyieaE3TCyajYkEmkL0zuLpQmHk7z88kWquXy+pontBN7nZBPXI
 g3drqg8XNho8T5jfuPAIjePjsUIAAj+0sAQtmNZDjZ0EZgJrDEDGmaH5poqz0oaEaNrLyk8OO1/
 ksBTxwIw=
X-Gm-Gg: AY/fxX56J4uq0NgZY+Rh/8fwWfRhx1madKdMT9hCuVCR+mtRjEEBY5MmOEzrQN/Tx9N
 I3HCHhGEoEJCRU5d1t2HkrT+VB9GnVW1xbjocb1Z/zxTv1+umCchJLYjk35NxEeDbfZ94LG9g0+
 K7ZP11IINdknl+2SCNQ/F1dm1DdAkJ5hzd6b5voIp2sS4HbTW+bUFU/ejI8DjbTWTdntfinIFPC
 bfWzAAdx+r8BogeNRuvF3MK4uDiYIgX3t2rM5QodLVMbzE7MQnoivBDLSlFhO+ckru/SrkMhFb2
 qtgGTcA7XZubwp37lE//UpTb5ng9plcPFAQijkPLMG8LjEFWIYuz/5il2/LTBPBssAUjEuCNnUN
 9QIPt8sU9jssBrqPoe5MXb1sF0EbQoDqV7yhrlicD9jM0GZcD3h4YTtW2iAzCI10L/Za3Lbvmoe
 at9iUmzMa3QCW5/5uQ2BcbKXuFcGiKgFxLKR3Q1PysXSidL1Zl9GaCwh0=
X-Google-Smtp-Source: AGHT+IGEBh2/gMyJLa7wUw2/GaVeqYlmAeW0ALlO0G9kMvdQK/loO8X7EiXDGTY6phUO/69UMsujTQ==
X-Received: by 2002:a17:907:3e1f:b0:b80:3346:496 with SMTP id
 a640c23a62f3a-b80371529aemr1767972966b.42.1766589972983; 
 Wed, 24 Dec 2025 07:26:12 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80620c4520sm1231188266b.28.2025.12.24.07.26.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:26:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 25/25] system/ioport: Do not open-code
 address_space_ld/st_le() methods
Date: Wed, 24 Dec 2025 16:22:08 +0100
Message-ID: <20251224152210.87880-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

When a variable size is known, prefer the address_space_ld/st()
API. Keep address_space_read/write() for blobs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/ioport.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 35ad256c940..5cc71906b9f 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -61,58 +61,50 @@ const MemoryRegionOps unassigned_io_ops = {
 void cpu_outb(uint32_t addr, uint8_t val)
 {
     trace_cpu_out(addr, 'b', val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        &val, 1);
+    address_space_stb(&address_space_io, addr, val,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void cpu_outw(uint32_t addr, uint16_t val)
 {
-    uint8_t buf[2];
-
     trace_cpu_out(addr, 'w', val);
-    stw_le_p(buf, val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        buf, 2);
+    address_space_stw_le(&address_space_io, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void cpu_outl(uint32_t addr, uint32_t val)
 {
-    uint8_t buf[4];
-
     trace_cpu_out(addr, 'l', val);
-    stl_le_p(buf, val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        buf, 4);
+    address_space_stl_le(&address_space_io, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 uint8_t cpu_inb(uint32_t addr)
 {
     uint8_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                       &val, 1);
+    val = address_space_ldub(&address_space_io, addr,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'b', val);
     return val;
 }
 
 uint16_t cpu_inw(uint32_t addr)
 {
-    uint8_t buf[2];
     uint16_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 2);
-    val = lduw_le_p(buf);
+    val = address_space_lduw_le(&address_space_io, addr,
+                                MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'w', val);
     return val;
 }
 
 uint32_t cpu_inl(uint32_t addr)
 {
-    uint8_t buf[4];
     uint32_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 4);
-    val = ldl_le_p(buf);
+    val = address_space_ldl_le(&address_space_io, addr,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'l', val);
     return val;
 }
-- 
2.52.0


