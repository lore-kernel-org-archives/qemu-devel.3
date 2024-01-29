Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9CEC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 18:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWPy-0005Ba-QW; Mon, 29 Jan 2024 13:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUWPx-0005B5-4G
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:31:37 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUWPv-0001va-Ed
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:31:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ae42033e2so1703055f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706553093; x=1707157893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AUqrc350wLzgeXX9ItM43M1+gmDqwp5qAUbyxzezjGE=;
 b=hS3/wezPgGhUQUcI+hMdjXSp2rNVVd5p2iVUTInX4GKZNGY33/bFSCgnLcSsAckYV5
 7fAJ+9Rse2+gtzpSnY8uCk+nkyPy2oGO3t/iGxdXkMExgNMP/lVB6FK/frcCPQPaCqD3
 vUgUdKjF2jUZz4ivc3nHl7QYKDuqvBSf27qChrrfMu6XKRbU4YzAEZFtSSjxvb/jMgwn
 NvdcL+T7WepQjh3MjbEH2d7p6iQalHhsbB+LoOY4ZSbakuTXAAXnIwQ4wICItoJq39bb
 f/0G/OjY7+Wr3dlwz1W9rgNxt1oDc6CRg7icwgwmrH1wR248i0N1ZgzBAvJa2rgpHqGl
 4orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706553093; x=1707157893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUqrc350wLzgeXX9ItM43M1+gmDqwp5qAUbyxzezjGE=;
 b=ng6ibMG5M1Nq+Ws8oDUyjLNS5d4lgsKgcXgx0MteFDaDO6fnIaR4mvf4a8pkP8o7I0
 aqwRnn06aZi1lZDQWPdZlWTPpCReqOgjwPd/JNO3HRWYBwhnavZjxsp/J5zPjjWknTPq
 bC1kSTDv5Es8NWWNKVy3hNplhcRR1rcS+yZn42lToxgv1EykF0+YN5I8UZl/NCWruVzt
 W0vQPaTReyumh/M9fUxhuN8IVE/YMfQZvMF2iRK3HCe3pPdF5uiXmTrkZxv+WHx1mE7S
 0Gw3dYgo/15577VlYNa8j5AGsx6oiKH2EmNlIITMEoaGcYpR/ww6MQBuWtaKsYtA/joQ
 rLfQ==
X-Gm-Message-State: AOJu0YzHN+PnuDT+nsgrGhpKdVECVtk4hZBxJ20aOeL/QZ2x67p0GfT+
 L7o3pSNBo4YdT3SoC93ZzkIW7MT3RLPBVkFjKcZ4nkNVpNlUCUSq/uKxMoPbXsfCzGdHRYJfFo3
 9
X-Google-Smtp-Source: AGHT+IE2O+kMpTYZh2gryVAv3yRBTKinUQqxza8UQQufWP/SrJUmLB6y+R6nw7Dm9FV6TTmI46HcAw==
X-Received: by 2002:a5d:644d:0:b0:33a:e639:2da1 with SMTP id
 d13-20020a5d644d000000b0033ae6392da1mr3737052wrw.65.1706553093102; 
 Mon, 29 Jan 2024 10:31:33 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 i8-20020adfefc8000000b0033af093e296sm2494819wrp.15.2024.01.29.10.31.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 10:31:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] backends/hostmem: Fix block comments style (checkpatch.pl
 warnings)
Date: Mon, 29 Jan 2024 19:31:30 +0100
Message-ID: <20240129183130.97447-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While re-indenting code in host_memory_backend_memory_complete(),
we triggered various "Block comments use a leading /* on a separate
line" warnings from checkpatch.pl. Correct the comments style.

Fixes: e199f7ad4d ("backends: Simplify host_memory_backend_memory_complete()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/hostmem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 30f69b2cb5..987f6f591e 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -344,9 +344,11 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
     unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
     /* lastbit == MAX_NODES means maxnode = 0 */
     unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
-    /* ensure policy won't be ignored in case memory is preallocated
+    /*
+     * Ensure policy won't be ignored in case memory is preallocated
      * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-     * this doesn't catch hugepage case. */
+     * this doesn't catch hugepage case.
+     */
     unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
     int mode = backend->policy;
 
@@ -363,7 +365,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-    /* We can have up to MAX_NODES nodes, but we need to pass maxnode+1
+    /*
+     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
      * as argument to mbind() due to an old Linux bug (feature?) which
      * cuts off the last specified node. This means backend->host_nodes
      * must have MAX_NODES+1 bits available.
@@ -391,7 +394,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         }
     }
 #endif
-    /* Preallocate memory after the NUMA policy has been instantiated.
+    /*
+     * Preallocate memory after the NUMA policy has been instantiated.
      * This is necessary to guarantee memory is allocated with
      * specified NUMA policy in place.
      */
-- 
2.41.0


