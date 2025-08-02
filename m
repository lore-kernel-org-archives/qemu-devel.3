Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB8BC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLl8-00081N-MT; Sat, 02 Aug 2025 19:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLiE-00018Y-JP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:27 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLiD-0005Bu-25
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:26 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-306ab1b63fdso1327284fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177544; x=1754782344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=T79WVbvjSXh/SjbwdAiVUeSldUv9m4NG40O3SOuzsaD1Gu34MpMR8dQRALBt7R0r5e
 mpPFOQm4eG0cmNFXaBel8NWytpIYBUMEHkKhg6q3NN62te+Zydg4DEkno3aXSjQyABf+
 NGIzTFNOBLeZ7P9ci0hW6tzll8n+mnd0uEzr9++YrSePkkvt1/1k+Q9IitURrSUNQYDM
 9K2R7/G6r1hPIelw7qNwvxITIY6WFSU+4awe78ftGSZAsKFOS4obCC3Aly2j7KqhFGa7
 gM1ULP8ctm8xrgf0CZZC4gKv6Z9u2HwbF0pxEXJwoLdrGT370tmIn9mncsIVxDSuzqzw
 8CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177544; x=1754782344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=iEGt8LERLGkFqqe1aHBu2a/qHfjl3qNNP0+K6DHRD7um8S8SNkRs9UcXNsLiyOUs6k
 NG6X4dVE7nVUfVb4BTAKLOJplB8Rl5XiBnr2nCBxky0a8vBa4AYz7rMAkI//QsSidxoL
 hJY8YO2RNAcIPx4Y5xJzxN0x6SshF7qjwwQBH5Hurtb1+7V5dAbVLIKhxBvenflssyQ4
 3SC2AYDgAuNnhs8LXF7SayCEq0MDeKPpMkqDqIys0AvddLKXWGnPvRvrPe06edR27vvD
 7qB5fGKCRpUuJ2vtf+XgRJYX5hWIdTsbMR3o+cm+tD2I5djpNXk5COKDof6On5N4LftK
 Up4w==
X-Gm-Message-State: AOJu0YxbVjvpvrZP3eaWNkbvlm3pBjWTT86XEVQ/hqzXaU2ZOIFWBR2K
 ygRYovENDAWZljazUyxW+GMPwExXN+4JejtGFclFgqe+S/ZTLq5/qei7Cdq5YE3IpZ3RMeDOs+V
 Z108gleA=
X-Gm-Gg: ASbGncupEGUyAcYkqjenbIoREP5YCYhO8xsPMqYHMTjq6gb+g85QcV4v5hJRf49QOCE
 bpSofzTqGWo3BoK1nzariRATx6Zvoa+1NxwW3LU1AdNV8GFgSDLj9NiCh7VMUf7OpJyDHLgd/Tj
 f3Vwm9fByfm79Yub0rd46GL1eQWCQPrTlq8bbNf89C6x+rE8AcxKkiPe+oIIc/K9FRqW3JdCStH
 q6KV2dsYdVoaLGtWjvJ41mIt9gpvviSlPoyIFT+kTTMA4MldlDYaSKeAlj3ENFFCmnHlYzdBQSk
 gjhlv5RNVOhEFxObNFa4juiW5Mak0Qln1uMfpNAvharSVm45Js1TYRi30tGm8QVQlR8IqQovULu
 pi7JxO9VXeckYCjzK1Bgis3LwPWQ1onmL2RytfSFFg7xafgsVuZJy
X-Google-Smtp-Source: AGHT+IG6NWPotY80eQ3XZ5CSOfebqtBbgd0mWrQ1Oh+Mcabdpqtc8IW9VQ9VTzpJULz3LNRCVcIYQA==
X-Received: by 2002:a05:6871:2318:b0:2ef:98fc:6f59 with SMTP id
 586e51a60fabf-30b67bc7100mr3265862fac.35.1754177543907; 
 Sat, 02 Aug 2025 16:32:23 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 30/85] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Sun,  3 Aug 2025 09:28:58 +1000
Message-ID: <20250802232953.413294-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a3..66d9c58b3a 100644
--- a/include/exec/memopidx.h
+++ b/include/exec/memopidx.h
@@ -25,9 +25,10 @@ typedef uint32_t MemOpIdx;
 static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
 #ifdef CONFIG_DEBUG_TCG
-    assert(idx <= 15);
+    assert(idx <= 31);
+    assert(clz32(op) >= 5);
 #endif
-    return (op << 4) | idx;
+    return (op << 5) | idx;
 }
 
 /**
@@ -38,7 +39,7 @@ static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
  */
 static inline MemOp get_memop(MemOpIdx oi)
 {
-    return oi >> 4;
+    return oi >> 5;
 }
 
 /**
@@ -49,7 +50,7 @@ static inline MemOp get_memop(MemOpIdx oi)
  */
 static inline unsigned get_mmuidx(MemOpIdx oi)
 {
-    return oi & 15;
+    return oi & 31;
 }
 
 #endif
-- 
2.43.0


