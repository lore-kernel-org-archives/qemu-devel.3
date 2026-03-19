Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576F4108E1ED
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQI-0007fe-NZ; Thu, 19 Mar 2026 07:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BPq-0007WY-0U
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:19:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BPo-0004Hc-9R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:19:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so6521485e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919186; x=1774523986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAlQ6OL3gpyVI0jWnvjBgu6bCA13ejnahNH1d2j0ink=;
 b=BrdwRIj/yB7cxkZ9iXg4wAcmeEJYaalcHtE9LhOIZMOx8dESoV7uI/bAoRRkNQvkzT
 VZ2KB24ekmI43IfHcyuZFS+EzjcBr4c/d77tQ4i6IarPVCGoVMo4f+9p/+W125/iOpRS
 tPwJ0E6W8MPbhCWD+BFOajee5Gjyh4it4erBmDazbzPT+rxk/3YuclqZV1mox2jz/QVs
 nTSdgP7M4aU7PwZzvvEiwNn1XkVsGgLkjnMm7Ze49gAvks8nVaKNTiWoC9r2kLykoFsJ
 x5/y0vI8QHqkOBbHcFrx5XGDB9oj3hiLcpj7iY+OAJQXyfc61QXlb0hYwD/5QcSGlkDW
 9wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919186; x=1774523986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MAlQ6OL3gpyVI0jWnvjBgu6bCA13ejnahNH1d2j0ink=;
 b=qnTUoX3mZ7xn/dcHnNrbzQ0q+WMrQnQcCuwOBab3+KjUXUFvMSkg1YqgCDnc8Bdk9Q
 dCotNXh0ydkotyCOvDt7cmDJ9P31mCcKnvJUJjDtK3X8v3SKO5CA307gOoQDBejiQZl8
 7e3ST1WWIA5/eBxTpbWLunezWjjFzN3+CMm98A1/E9kpU1qd3tMhBI+LsHjfifFOzHGg
 bS+bVEFf+fmdkZzSkwBKMZm3HfhoPIZrcul8E0CfZAyoPmybRndoQzj63BCDaQQxCuMT
 dz2PQPdCpcBYzwZfhbnSxjPsVpyiTSYFrSpskEAFyTikNlhfYQFizE2GP9FtBW85bV9J
 ehLw==
X-Gm-Message-State: AOJu0YyuGMHKB4V0sGc+jnvv+a3dojo6aWe8tIq69Iag6LkxVF0owWMc
 LlwIYgWsAfPN5DrWoZHjUXxh7YwEEEi2p2sC0GEE/ZpFyd9YBf5U1rTaN9iez4l4grAj2SLvL7B
 4diFQ9Dw=
X-Gm-Gg: ATEYQzxDiXBAhc1QxQS1b2M3XpgYtdVI3uYmc2rEToSKBLjYKrtRNz3BkfjN6vZch0G
 WjzlY5l4iAIUNUyO5a8HshF1A4ZAXjEDrhAAIdI9ih8rVqPaxvHkxyaKIXbANkobnTf0fumWwWn
 rlkfSzndkmAUNnOJUcpKJTHarsXNuY9ouYY+ymlX4C2Wz6UeRAOefxu6vlonnTcZg1dHguGaGNk
 UjbuWA9HX+MINMTrn7q7DI3WDlQaNhruq1WvvIzbdBceXpgVbyUzMfNPyKtSzyz8nnXp8DEhCzT
 2ymfRSSVjPOFsmT5TlKMW4fWwkZHU/TN8QcKZXNJ1PIs3KjQTTUkuemZQGO+dGYRYR+fdVPfX+l
 P1ZQVn3K52o6+5+IvkDvFKnAz/pYNs1nP4Kd0XevVSo8ySdvZGjP5d/nXNPev178lDIDFzHXI9H
 0bjlWA32aqbMBeQxF6pdeHFghl+ynodIBJ5LZDam1Op0XdO+mPPgagQOKr0UlqLT3518guG/bz1
 RTl+p10iYc=
X-Received: by 2002:a05:600c:4fcb:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-486f44384d4mr115148365e9.3.1773919186220; 
 Thu, 19 Mar 2026 04:19:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b949e1sm103526265e9.9.2026.03.19.04.19.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/ppc/spapr: Un-inline rtas_load/store() helpers
Date: Thu, 19 Mar 2026 12:19:29 +0100
Message-ID: <20260319111936.68041-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The 32-bit binary doesn't use these helpers, so don't need to
compile them. Rather than using 64-bit target #ifdef'ry in a
global header, un-inline the calls since the helpers are called
from I/O (cold) path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h | 18 +++---------------
 hw/ppc/spapr_rtas.c    | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b022f8dd25d..9acda15d4f6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -796,21 +796,9 @@ static inline uint64_t ppc64_phys_to_real(uint64_t addr)
     return addr & ~0xF000000000000000ULL;
 }
 
-static inline uint32_t rtas_ld(target_ulong phys, int n)
-{
-    return ldl_be_phys(&address_space_memory,
-                       ppc64_phys_to_real(phys + 4 * n));
-}
-
-static inline uint64_t rtas_ldq(target_ulong phys, int n)
-{
-    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
-}
-
-static inline void rtas_st(target_ulong phys, int n, uint32_t val)
-{
-    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
-}
+uint32_t rtas_ld(target_ulong phys, int n);
+uint64_t rtas_ldq(target_ulong phys, int n);
+void rtas_st(target_ulong phys, int n, uint32_t val);
 
 typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                               uint32_t token,
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cb79ad34053..0871425237e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -52,6 +52,21 @@
 #include "migration/blocker.h"
 #include "helper_regs.h"
 
+uint32_t rtas_ld(target_ulong phys, int n)
+{
+    return ldl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n));
+}
+
+uint64_t rtas_ldq(target_ulong phys, int n)
+{
+    return (uint64_t)rtas_ld(phys, n) << 32 | rtas_ld(phys, n + 1);
+}
+
+void rtas_st(target_ulong phys, int n, uint32_t val)
+{
+    stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4 * n), val);
+}
+
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
                                    target_ulong args,
-- 
2.53.0


