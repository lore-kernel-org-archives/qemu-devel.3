Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5CBD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacK-0001S1-KJ; Thu, 15 Jan 2026 22:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacI-0001OF-Jn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:18 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacH-0006EB-1A
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:18 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81f478e5283so1397737b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534516; x=1769139316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGBrEuQ4ySeYQyQaMh9vioeyRGMPOCdt+8viJgwwXN0=;
 b=A7WtctokLym5FwhdMzbnZXHgkTlVX2iEldYrXiNQ3zLz7SqgmdOIjBnILa5EHD+oKX
 gfcI671aIl0S9sR+FtlnSq+ioDbLCITEC0oUSTckdU1tO8DjZ1RxB//ZlI4OFsThUbte
 DUwj+/Q4sKqONKg86BwOmOoXdn5ZLyLREZA0qypB6rt+8dyVMXt2LGBialR+o8oKkiHW
 p3lm2HArrS/I7X1U9Id9wS4JYbflKQlQVfv4lz1jnSo/E/Kv+W+Aqr9LaOi+96ldXtmG
 gRiz/5LGfM/b20Gpap4ZPCtxcjTQPQmp3UTcxvyi37FoVlWC3QeOmRQtlViNOU5+I86p
 jzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534516; x=1769139316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGBrEuQ4ySeYQyQaMh9vioeyRGMPOCdt+8viJgwwXN0=;
 b=ZtoLdhqQzMAkBv9SH3ztE1aA1B5k1S95I3VY8XzA3dHqCPrhc9jvCalLvPL0C3pi0U
 44EcGks6eWvs0fyGwgt3StLaDiyOSGbTjZqM1jpeC0dSqhENJijkQe8sqx2l5fXY+iCU
 wnIJ/jaSD6JHdw66013vUtuXBeZqdQVvusWJpbKUL8puensMrqcYbzuFE1WxtZB4OoEP
 ZkwobP5NuLFbMoW8MzU1NyiDVio9G4++u1y/BZiofQhBJpVN+isvLEQXKDzTwz5IMOQB
 J56esnfzT78df+FWWqqKvc3UXbLk0+fmoIBRwO0ST3XoeTVVFCty/NXvtqt5KRyCKDt+
 GT4w==
X-Gm-Message-State: AOJu0Yyi6vkgvfrRKcZRc7+IzhA4CpApy0tkDx2OBPWFwjgSqh8YzYYQ
 9SvN4BOMn1IPBo8MHqytD0F0jJ6ZGUwaHx/KN/N27x0E7P+sKK02RVO7lFpHO/6J70T01nwyWiV
 05kZAfikVhA==
X-Gm-Gg: AY/fxX7UnUWa0Haj8x8O86rmiGBbYSMwlN6s+wPMOuL7I/2FJUqKzN56UjMdXbPJqTU
 hRWd/yAKGc0qSCeZhcN3+CapT1Z/RFMNqpbLGraMB6++9G8aSzZsu66T/6naofOQcFp/iHAllJm
 0wG4h+qfOT22QBaTzrmEdGVk1s90yeEQW6j1h4qr18krwA+uMZ57fusN9sif/8xiBYHueXdZOlq
 KxpvrtiFGIpXEMuZ5wD3IpdNHGLqUgl1fhxkrkgg0IaaixlC+J9TKKn9+1pBwskH6/oQ/vyZ+cX
 UyGVEWzuNGJb1W+mwKxJCC6+jJQ6MEhH4nPjc4VhrL7oWgjlCBmyJ4megaY1jyZVlC0MCVsQFqj
 RA7Q6YbAfRndHyA4b4/FsaICBFOtbaT1EiGmOhfatNbHkTdZX/Bb3wDWv3c4ZHYf7k/xguc+J//
 pTxrCDeSaEykmK+p0e+QRl2QWzL9pt
X-Received: by 2002:a05:6a00:4517:b0:81e:8e66:38eb with SMTP id
 d2e1a72fcca58-81fa03cd847mr1536188b3a.63.1768534515617; 
 Thu, 15 Jan 2026 19:35:15 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 31/58] tcg: Drop TCG_TARGET_REG_BITS test in region.c
Date: Fri, 16 Jan 2026 14:32:37 +1100
Message-ID: <20260116033305.51162-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 2181267e48..5d4be1453b 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -464,17 +464,6 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
  */
 #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
 
-#if TCG_TARGET_REG_BITS == 32
-#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
-#ifdef CONFIG_USER_ONLY
-/*
- * For user mode on smaller 32 bit systems we may run into trouble
- * allocating big chunks of data in the right place. On these systems
- * we utilise a static code generation buffer directly in the binary.
- */
-#define USE_STATIC_CODE_GEN_BUFFER
-#endif
-#else /* TCG_TARGET_REG_BITS == 64 */
 #ifdef CONFIG_USER_ONLY
 /*
  * As user-mode emulation typically means running multiple instances
@@ -490,7 +479,6 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
  */
 #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
 #endif
-#endif
 
 #define DEFAULT_CODE_GEN_BUFFER_SIZE \
   (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
-- 
2.43.0


