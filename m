Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4FBCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0i-000081-DY; Thu, 16 Oct 2025 08:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mz0-0005jW-S2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myn-0000Tt-2o
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so5333465e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617264; x=1761222064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BCJrU5ZLrWgbTac3F9afgkynkH23kc7VJ51ZhIVJfZk=;
 b=KuO6QiXyDMQL2VoUkrsuNGUBk9YICDu6yFFYoTfDo4jSwSQuNdqz9DJPz74+67fACZ
 JSv42ZzrSstJuhRuzuUEp5HM/RpaRNlitJtppeDHCBl+l8T7uS6P3ZvGTWAeEfBkstYo
 kUw0r8rm0uj7s1yZfp37KZ9t0N6/+DtMsMhU5Q9ViVb2lr+96hyzBr3MgHZgzX4aOR/E
 uuT0aTWEsW7JLn7gIiEWYD+UPDPfm7JGsBtK6jGvNXnjKHKFW9W8U396DsQuIa3AFjt5
 oFNa0FdrA4U9lEE32ilf3cqC3k7nDgL308bC0qKDYTPYH+lj6r7EUcUMrC2BHknteYwM
 Ag+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617264; x=1761222064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCJrU5ZLrWgbTac3F9afgkynkH23kc7VJ51ZhIVJfZk=;
 b=E5+NevuV7SrhP9qU4zM9YhvRrvRUirJ/LMHJoVqvatd6wWA8Z+n8FVkcgOAef96y/V
 Vs69Z3ulLIAc/cCPPP9iBvRoyzJ0iYSujuHDNyRgSEcupEpa9Vd0OM6G//oowNUqqIUF
 Gw7q7nVWiHJlBwpHBgNUje8TRcHeVfe3RBDg5gZY4xSGcs715Qrpb4NpVj2dOdtMkh2C
 7woSpWLSUIe8R2NRehIw7IQWWnmu7PrSrMN4XNSg0H9vvbccJAq7NkZwpiQYErpGSlIP
 r8AIpOH4tXTZP0HWlgKrCBgrei5DpFtR/B6sDsfj95GMmDCTxBxmizv3si3p1WzXX5a6
 xMIg==
X-Gm-Message-State: AOJu0YwyvNwF9PVuWhwuzLbFycuhocwA45zlo0GeDykL5eRgnq9xCN1Y
 g+zqe6cdo97N66Cy3RXnKeeFjrC+ICWucQb+e9DwbTTNg6BscdJr55F6S6gQa4r6PSH/QHP1xIG
 EUjKs2UQ=
X-Gm-Gg: ASbGnct4oLp4/ld/DLErsyv4KXNQu9BFALX2dNGajOPNLbiK311k63MsYJOC8K8TXix
 nDGVwBdQtEHEu4Tp6M52dzrZHl3piez5Sl7Hd3j3jk8UES3/3TNMIoqlNXpLrE7MYxa3JdrytKT
 HtE202WbK4K4yFvbTpCs29AM6uTRf/tprVe0KBQI8/9rv2eH2Ge70qZKsSMKHiFvfjqALtstZsW
 8GqZo0JKKvTUwQDdgbBuQcW/cG9qURvMWSefbh2+/8y2tpMg3DhIuibbIXS9+uD1ctfXct7/0xk
 k2BgI7v6THZ78dKXAiYvUojqCCKeSBza4gRzJlWmWdz2vwyoea9mIdq19q7ecNJPwRvHoWGsM54
 2fQ6TIsogS6C5oQyEfk07bw6JMZyHhV+Rz7dL9l3STFTHT1GOW709QGDKZB7KptDqz3Qz/YvDoh
 sE07IoF/aCb8Luu0iiD33eO/N3ZtIzoWRq8kpYQQZezLz/KxeTYQAXFw==
X-Google-Smtp-Source: AGHT+IFeImkrLnqR40Qx0dUeqIMNB7TyMDJjeqaB6H01p6xy1IvMLqOT9IQrQlae6GFdzZXlaFO3DQ==
X-Received: by 2002:a05:600c:811b:b0:471:16f3:e542 with SMTP id
 5b1f17b1804b1-47116f3e8b5mr1320525e9.2.1760617263888; 
 Thu, 16 Oct 2025 05:21:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442dbaesm24703395e9.8.2025.10.16.05.21.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:21:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 71/75] target/xtensa: Replace legacy
 cpu_physical_memory_[un]map() calls
Date: Thu, 16 Oct 2025 14:15:27 +0200
Message-ID: <20251016121532.14042-72-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
various load and store APIs") mentioned cpu_physical_memory_*()
methods are legacy, the replacement being address_space_*().

Replace the *_map() / *_unmap() methods in the SIMCALL helper,
using the vCPU default address space. No behavioral change expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20251002145742.75624-6-philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/xtensa/xtensa-semi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 636f421da2b..431c263dc57 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -32,6 +32,7 @@
 #include "exec/target_page.h"
 #include "semihosting/semihost.h"
 #include "semihosting/uaccess.h"
+#include "system/memory.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
@@ -192,7 +193,9 @@ void xtensa_sim_open_console(Chardev *chr)
 
 void HELPER(simcall)(CPUXtensaState *env)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
+    AddressSpace *as = cs->as;
     uint32_t *regs = env->regs;
 
     switch (regs[2]) {
@@ -215,7 +218,7 @@ void HELPER(simcall)(CPUXtensaState *env)
                     TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
                 uint32_t io_sz = page_left < len ? page_left : len;
                 hwaddr sz = io_sz;
-                void *buf = cpu_physical_memory_map(paddr, &sz, !is_write);
+                void *buf = address_space_map(as, paddr, &sz, !is_write, attrs);
                 uint32_t io_done;
                 bool error = false;
 
@@ -261,7 +264,7 @@ void HELPER(simcall)(CPUXtensaState *env)
                         error = true;
                         io_done = 0;
                     }
-                    cpu_physical_memory_unmap(buf, sz, !is_write, io_done);
+                    address_space_unmap(as, buf, sz, !is_write, io_done);
                 } else {
                     error = true;
                     regs[3] = TARGET_EINVAL;
@@ -408,11 +411,11 @@ void HELPER(simcall)(CPUXtensaState *env)
 
             while (sz) {
                 hwaddr len = sz;
-                void *buf = cpu_physical_memory_map(base, &len, 1);
+                void *buf = address_space_map(as, base, &len, true, attrs);
 
                 if (buf && len) {
                     memset(buf, regs[4], len);
-                    cpu_physical_memory_unmap(buf, len, 1, len);
+                    address_space_unmap(as, buf, len, true, len);
                 } else {
                     len = 1;
                 }
-- 
2.51.0


