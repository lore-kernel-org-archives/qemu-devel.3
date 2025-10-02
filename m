Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926DACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Klb-0007QS-Dv; Thu, 02 Oct 2025 10:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4KlS-0007OI-8z
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Kl4-0000Lx-Lt
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso9514315e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759417088; x=1760021888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0izgqgQPxEFUV3fbD9mNX/9Xd9YILFJwZ3Tpv0yfZhc=;
 b=YM1uv/8y4S1PtmoMt4L4jy3suO7qjsKkrVhWwcZh6+h0n1DHMKNVc5UjhjBUKnJdap
 sWS/BcJcjDP0eTpWXqZ8MUUDSjZWuOcIOln+ss38//JIeU4naftCBemqxmo0H3oioub2
 ErVttl3lH4CsIC2NLfBL0ZFrAuR3wMqkn9x9fSj1P995Fgikv9k1dFjJuVlFeXHfcYKc
 ORye/67C6+I+2YVCJ24inazcrAJbYUOlvu99E22kTymS9jD556qRaLfi/0q9E/oS3A+o
 9wdx3QoAAYQ/AIVs/YnFM44MyvS4O2y1l1zpyBloViEbmMrRcQI11V1QS+EOZEmkxFF4
 rBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417088; x=1760021888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0izgqgQPxEFUV3fbD9mNX/9Xd9YILFJwZ3Tpv0yfZhc=;
 b=pveaPOeMHJO4Pauq7mkrTYv3cp9rCZRR8LovqJivr7qcKOki48qTRqF1mSaPKuDf85
 DlVsVpjIe28ORTmZ61oYv2jnFaXRndSXVfdGjRRXJwBVfzGR/Znb+m7uuhIpVasShgOB
 yr4V5SSOZhXyScctMRO6PO734AKf2UgLtmlJY5ecpRSnEa+BO86vYoJwruE1Ptu/wDbs
 49ki3SPxL4UeW8OlyGuo/5AxiecBMyuAVNCpD73RhWpKa49weOTkTZqQdUd50C2fRiwM
 TH0GaxKd+4EY7aNQQQJKFLwARbHOZytZeIjH7bYVtqBNADAZVKji8vvdLv3bPfTE9N2d
 XD6w==
X-Gm-Message-State: AOJu0YygJLRNDly6l1SfruxrQBTUfslpDSE5pQJi07+m+eTN6py3DUz6
 kzkxSxdtrjV09EWXKfiDrCFXuogiFxiuvkv5uc0p2B9tozGTRn0oiue1pxKpXGPNuUVinV4vpX5
 GKN3QgiF0dQ==
X-Gm-Gg: ASbGncsydZuCGgKeagyFSgQr3hTEYz/ZsAbX7JuSbu+Gu5dTa3JnoGs2ET9JfajGhgI
 Frzu0E+5U/xmtIiFc7/GwDCXH3a7IpFDZsiANfixUWUdc0Y9T0KnBhDFZ5iZ8j5/sjAW+WM1T+Q
 MgtA73JUAO3/pNynsVeYOdCDRBZyZC8DZWJZzEzVaSgOwiA6D0Mj2kBAcCPKfWVtWG4ryHf+0wI
 nTb0jfmbHsIZ4YUAt4YHOud2vXVK7q/MdSezZp8RpOlJ5+6yG4PS3e1bZ6xq37gdTq/M3fRaSLa
 G+T3Oa678B1zH4BrUiE3H91lqUr1Bk2aIxHpk81Vj0wJIUDTDEFPtC10ZCyvkCc6jhEFVcADQ5s
 iIpYYMb4N6oN9lOSSbGnS0LqgmojHikHFh+sTOVNkDXeJ2f78+Dvrvv8ysttPdDBHnqJAaXF2uK
 +t4VQ6mVdlPPnlzyjupl3i0frO
X-Google-Smtp-Source: AGHT+IF6k7IasRkJZ6/byTlNsF0gw6uHMcWrt6aJ835DaIWYOqY74I6isesCnT6ffcFG6J+pVs2Afg==
X-Received: by 2002:a05:600c:1d1e:b0:46e:1fc2:f9ac with SMTP id
 5b1f17b1804b1-46e6a2e09aemr22076735e9.10.1759417088212; 
 Thu, 02 Oct 2025 07:58:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c396esm85237665e9.8.2025.10.02.07.58.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 07:58:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] target/xtensa: Replace legacy
 cpu_physical_memory_[un]map() calls
Date: Thu,  2 Oct 2025 16:57:40 +0200
Message-ID: <20251002145742.75624-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002145742.75624-1-philmd@linaro.org>
References: <20251002145742.75624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


