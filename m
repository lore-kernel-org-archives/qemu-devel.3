Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CDFD3E788
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 02:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTWqy-0000gL-Sd; Wed, 10 Dec 2025 21:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vTWqw-0000fN-IN
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:56:26 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vTWqv-0005E9-5A
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 21:56:26 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-343f52d15efso530543a91.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 18:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765421784; x=1766026584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXnex4JwlAFkgPgcPuA0yCUiwy94oRkZ+YJBQ3Q9138=;
 b=ShDqqBvODE7OWg+uxciOqy2k5ij4j6Nea6XcdFQdcawNxfhpy72x4iwcjaCqAo/ICM
 xHVmF2ltkvhjxYWDvURNwXakw5KGbHtvneCX0sWvV8x5fpFE7eK07dznSx5lJtEPRRtb
 PjRKN+48c0X9EjdkMwMCFvIg3v8qpsJjvMCu9j+05kMuI4/tgZ+tZGUAiNpnuVBqYTVj
 0loE1ryiRbZi+tfkqUR/Mu76M5OoRRylL9Vn5CG87BDJN2CkZGLfHnDvCmPjbB3BXt/l
 eHLDdn3SPFk+GaBACmQzkkyzaP3GRNFOUi8PrJXpNH25QNr+K+y/M2Rg+LhOrwGk1RZz
 3daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765421784; x=1766026584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EXnex4JwlAFkgPgcPuA0yCUiwy94oRkZ+YJBQ3Q9138=;
 b=c7d0+7WS8REItbjoaFd0dim6XZ4sPYQJxb93674GkZcQkT+/Ux8DTKVBvSxpVVONQs
 ejZWMJFFjH/O77xJv5slDkemKZESPYf2TnczDEEl4JAb6ZotMYPYNpiUaOuBdbl3GJcg
 bmuiqb4mIajakKzbY9SWAGyP5n2oFCPaI6hvBXfqB4BWvnwXKSWSbxJS0cWb7SQvbxyW
 QtIijJ4a1PDjb7pzHqt6/svAisYBeRxQJfYQ1Xwq7QGeHRJR3un99iugY2tnbWyNpkA4
 +Y61oziq2KNhFPOfstqKK45yYYIF5jI909SafO1t/m9QhPjX2OoyiCSiyNkpHpATrZla
 6o7w==
X-Gm-Message-State: AOJu0YztrHJ7GgQbYSd+UXcARPBWwp1rOe0tbEz9Arhk4T+9enxYqumy
 Hf/j6BQ7Z69wX+03wsQqBWRaSvhTLgfhUpuFpuyCNZrC+Ss9gkSVuMFQdfNjkTWb4aDPC90zHo4
 hizcmBMx2xEeFMtQsu37zk7fiT3FmC6ae5jQXd/o4aQ0jV6uatRYvoNIFdS/Y9jJ0rHgKvTVz6D
 QhyA7m3iQyQ23VfLlXRe0Ti+y7wi/gzZWlkUCf8SI5
X-Gm-Gg: AY/fxX6fLwnGAeO40CI7gkdF8P5um/BXsS9neiiy+02R9KA3IGSQwxxXhLbC6FjMQxQ
 eSXJjV0mG91ezElE8qNpaBB1Lhh1xPQ3oszNIB4f7SLN+cBvF/EdZQcuwRuePG18rjatlqT+ceQ
 tS5u0HB42EuSrCKEGUrTHzTx0Ntyz6KDuuE6ttCCVJwDTrqE6486w7q0ZINfDa2KJ5hQJ7sDaaL
 gI56zdIpCnKJ/oJr5CO93fzy0L72m6gQah2zEOvqwivYi89jbQTpwGmrnSz+41JqnfgbecTMfu2
 DdA6z1pn23A5ajYWLDdeHpkRiACAyi3xf0NEdVgh3mEf9RwVyXuGJ1OqIs+1yiuO1xBD87DYiw5
 b9Z5PxASkByIIvsqUN/n6G7sy+lmYkT42c7o5zB9IYzpa5t9d8CNVHZ92eFm3rGAx+zTHPTvjbm
 4vyadjTB9NZxykNVYusgNPpFHXXqzJMIVxzKNx0fm/2ZjMXHhQzg==
X-Google-Smtp-Source: AGHT+IEvVrFUMv+QlPMr2PMUuIN0LFAFn61taXzj/m3Lz610IbLKrE7V1ZkSiuAWmtnhlJd/b7vorg==
X-Received: by 2002:a17:90b:1d82:b0:343:edb0:1012 with SMTP id
 98e67ed59e1d1-34a7287480bmr4362416a91.21.1765421783503; 
 Wed, 10 Dec 2025 18:56:23 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34a926de17dsm70870a91.6.2025.12.10.18.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Dec 2025 18:56:23 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 1/2] hw/riscv: Don't insert DDT cache in Bare mode
Date: Thu, 11 Dec 2025 10:56:10 +0800
Message-ID: <20251211025611.99038-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251211025611.99038-1-jay.chang@sifive.com>
References: <20251211025611.99038-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In Bare mode the IOMMU does not perform DDT look-ups, therefore
caching DDT entries is unnecessary.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 69852f4f13..79eee2e85e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1312,16 +1312,23 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
 
     int fault = riscv_iommu_ctx_fetch(s, ctx);
     if (!fault) {
-        if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
+        if (mode != RISCV_IOMMU_DDTP_MODE_BARE) {
+            if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
+                g_hash_table_unref(ctx_cache);
+                ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
+                                                  riscv_iommu_ctx_equal,
+                                                  g_free, NULL);
+                g_hash_table_ref(ctx_cache);
+                g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+            }
+
+            g_hash_table_add(ctx_cache, ctx);
+            *ref = ctx_cache;
+        } else {
             g_hash_table_unref(ctx_cache);
-            ctx_cache = g_hash_table_new_full(riscv_iommu_ctx_hash,
-                                              riscv_iommu_ctx_equal,
-                                              g_free, NULL);
-            g_hash_table_ref(ctx_cache);
-            g_hash_table_unref(qatomic_xchg(&s->ctx_cache, ctx_cache));
+            /* Remember ctx so it can be freed */
+            *ref = ctx;
         }
-        g_hash_table_add(ctx_cache, ctx);
-        *ref = ctx_cache;
         return ctx;
     }
 
-- 
2.48.1


