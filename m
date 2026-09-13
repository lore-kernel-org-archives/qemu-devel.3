Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0E9C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBQ-0004h9-Dw; Sat, 12 Sep 2026 22:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBM-0004Dx-45
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:04 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBK-00020Y-IG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:03 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so513785a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267381; x=1789872181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wIvwMDGGNQlMbo6lQyx5a2GRDK2imKA91k4EhrvEK2s=;
 b=zu57LzfylsdfURotGo7eOi1698P1D1R08zjbl23uuIuamn45rCCslxp7Hsq2zbTt1h
 W+fhYNDqmzLRwb8OZHa/vovPJFAaXtRAhfeoGARozOnRKrEIKlmJS2b2F+6P2NYpQ9JW
 VYjTFhNyyjX8XNAXb2SDg6Xjs92g5jibOy4RORRJC1/QP+POkc5e6eGyz4dFM2wBXKkc
 HGsytBkyfHnq/BFnsUfDVTe3c+pFmnOs2mJKEdmXTZW7kCcX6HVm2YewvL/oIp9oLCl9
 Gdr2E16fR3hWDpxKI4DTM92Wy0E9GS3KncpRP5T557tc/SexXOFVUZDSAhRqGRS0yZFV
 oJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267381; x=1789872181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wIvwMDGGNQlMbo6lQyx5a2GRDK2imKA91k4EhrvEK2s=;
 b=oUU/98bDQaz3WC5LmL0fQbm9X8cbQQ05GysPP5N69E6L1mIp98+/gCXghvlLcuKdFd
 rbeF6j3MvNqxW6r0+wJLt71cFxcIsnXx6UjM+dHEqrNv9QPUS0diozMiLoRKRtY9ZWtZ
 /Dd0aeQQyMHt+L9R3N8tCXrqdcH5Uzy+wPY38MrHe6OUG6mGuREZYpo+IfuWVImGuEEG
 dQitZkMvN+7Xo4k3TNSKy0K9DgrhDw5dDbJHzRR9XGVgsSadV7DIFfBQWWm057FFJXR6
 zk8Pk2LVRQQSTGZId02F8+po6LCzI6uD0uw+Yxr/lW8wfJDGO9iExp1ZMneN6EdbB0Sz
 YnTA==
X-Gm-Message-State: AFuF++kr1Qn9+RwGsI24osRDeFg0v+Qlu+fhbbwaTzUpWPPIWatCMsMs
 zq4YWiESZH0iQz/OxIZ3kMoq5NdY7jSwev8kEsYEvLa3/z4IuaLTK+mRkwd24PU0iSX9YTO/jnC
 Ldo5fPCc=
X-Gm-Gg: AYBFou17n34JPA+DbOrgNhNkvv3kVxFS0rTrIVokjOZ0zeTmUqJJHIPGGg80L8Vq0ou
 E4n4kKCggguRx+xaQgQoPpaVxY/VbeN320nNhGQY2olr6tk6wn0AFh9ps+KBy9tGXYF88hk+T9m
 GN1gT9KKEmKLqBZa9pkmgWOM+dXpvy0PYoUB/vRUztPiSJnukh3aOH9guPKNP6XBUZBgmlpFJVm
 OaMxuGg8d7cwy3MfkoKM4AnL/BOGrvwjL5svhU3SGNqCgMLpezmnzSF9rB6YJXBvsBKcGwIVS8K
 tW1lD0Atfvut2VULXzadms/fPqill06VH1Y/vZ0u320eB4ei9eeLrlUCLoay3EIbi6MP0noPCMW
 lrFhLICJvxbR6BkhlT8mg3jXudMbC1sIkYRli6m37tFUxen7FwcWhepmQwmi8xSr95IkLDXn6fI
 btQoPfGgtThNxxJhM0E+aj2zWqmcerWR7vWnz0b+mB1Z4xR2ZFaPtVGsweTLINfG8UcpNSYfqZY
 QOpiC8=
X-Received: by 2002:a05:6a21:a91:b0:3d3:ad3c:49a5 with SMTP id
 adf61e73a8af0-3db0e41ff18mr10365687637.19.1789267381144; 
 Sat, 12 Sep 2026 19:43:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.43.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:43:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 75/86] tcg: Use umax in ussub if available
Date: Sat, 12 Sep 2026 16:38:26 -1000
Message-ID: <20260913023837.741866-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index decc15f3d20..a350a8185d0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1207,10 +1207,15 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
-    TCGTemp *zero = tcg_constant_internal(type, 0);
 
-    gen_sub(type, tmp, src1, src2);
-    gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_umax(type, tmp, src1, src2);
+        gen_sub(type, dst, tmp, src2);
+    } else {
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+        gen_sub(type, tmp, src1, src2);
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    }
     tcg_temp_free_internal(tmp);
 }
 
-- 
2.53.0


