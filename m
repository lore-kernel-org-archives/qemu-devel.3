Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3ADCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MyQ-0004z7-B0; Thu, 16 Oct 2025 08:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxc-0004MA-EK
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxH-00006s-8k
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-421851bca51so551056f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617172; x=1761221972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WwKBolYPewFdGn15799ZYMv45v6hkYA7hxjMuubm4AA=;
 b=RTky9gLH11KgodtNOqchjhlNd/i+E8JMP+9ZtlaaxgxRSdHlkaPjsmDy/R9KQQFcdH
 Oz40mcuUYNnIQJpToFCn3lj0q+YIPB180sfucgTXCLTsd3sa6u2tBDiLVCLOiR8H94ad
 x7OogF/Q3pC3N+YVpQbDYFEzFSgi0RZaoQ/cv8LYMj4PKnzkA9F4qaoI37wYOMl0U56o
 c/Qx7reB0C82ODU8szDDZfjghOxEECdsmqxdYXfnKQPIVXSkHdyW2Z+oDV0undmsb64j
 /BfDafn4SFxvbXm6hWVZV+/oPyzlAdQS6f677Mo3+gEFVlOZJOUHmbMUie64y8NpsLmh
 BQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617172; x=1761221972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwKBolYPewFdGn15799ZYMv45v6hkYA7hxjMuubm4AA=;
 b=MGF2lytJqesFdgPKkYpFlPVOgaqZVoZ/8HWXBenLu5b1cf5dbKu8FhrA/A4HeBPTLZ
 zSrvOR76kh10GX0fqqpw9UKggLQF/KRBIMa5r2aPcd3ab2kQjP71HLrNewJIVWj1qWHK
 fzDekmxX6IrXPfuVImycYyIvVr3bFqf+pwPOBNu8IQ/v+uM1lS9gf/yO+Dsqo9MZBYnV
 oOhYc6Ybozbm7jGUIm9Y8GhtJouoKEzzmepDz4zAwqZPje28pnEnyzgDBS3yh/9FPZg/
 4++XR8Y06KGp8zRyHlVHQpE/mfWvf9+BfcwzEfd2bHr+zdGoFKxa7iRzJYOzxcKbihry
 cbgw==
X-Gm-Message-State: AOJu0YyJPASCA6KVzPGL/Kzg5LrzLhPRkYmqfuqkAxdGmmGWUQgHLfRB
 oWK6sDBQOym2QOQPZZvifo4VIXLkUYpEvwzbgq1CAOlJOMtY7L78jLTElYX+0hbKjn+Al6v8Qlf
 2FeCj/x0=
X-Gm-Gg: ASbGncv5vWLD7y2srZNoyRKL6GDmff3zAfcBTfoAkZWFspq08Na6MjAya3dtSheHJKT
 f5Rj18NZgtEhy32pjjwBZlBvepk299gVrRfxeG+ai5SR/0ZyNQ67IY2yYuyb1vkMPEZUgLTseGx
 IyXO3a2KqIlBzF+F2G4gX9/ZxwT5NXaO2sANLmuqE4G9dEQuO53LL5cNriA2BovHP7RHXpGSVrb
 zg5fUI5dF4hCBwyyfQiDNZDtXCKcRTsMZEOOcldVJWBJ/isBzsZovMTxXubJD3vcQpT6Bg/FiTe
 Dtsj+ia7umzOG9NJkuzSK3HOTPmBg0kEUAht0nUWxjF2OjhIylcP3uT9bae583c1bKX+rz8b8G1
 rhU+au3MVaSZR7wpnwor533SsjUawkygOLz2Xoi6G4z+XrWRMNs++gmJvVZVbGRdmuJEgCSsKt7
 obVf9U/vuTF8WrI+2gRv+ENx2wetp+sCnTPUAtwCLPh78oAe1WCCuBFkyt3A0HN1gM
X-Google-Smtp-Source: AGHT+IGfs96tAJOUHYxILpw8sRbmcgw46B66s5qZrO9e9k1gCjWSMJfIc6tp8m4s3fqN1MTVVc0giQ==
X-Received: by 2002:a05:6000:2285:b0:3ec:8c8:7b79 with SMTP id
 ffacd0b85a97d-4266e8e0bdfmr22800000f8f.61.1760617171737; 
 Thu, 16 Oct 2025 05:19:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm36014654f8f.10.2025.10.16.05.19.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/75] target/s390x: Replace HOST_BIG_ENDIAN #ifdef with if()
 check
Date: Thu, 16 Oct 2025 14:15:07 +0200
Message-ID: <20251016121532.14042-52-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Replace preprocessor-time #ifdef with a compile-time check
to ensure all code paths are built and tested. This reduces
build-time configuration complexity and simplifies code
maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20251010134226.72221-15-philmd@linaro.org>
---
 target/s390x/tcg/translate.c        | 6 +++---
 target/s390x/tcg/translate_vx.c.inc | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c7e8574438c..ec9e5a07516 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -258,9 +258,9 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t enr, MemOp es)
      * 16 byte operations to handle it in a special way.
      */
     g_assert(es <= MO_64);
-#if !HOST_BIG_ENDIAN
-    offs ^= (8 - bytes);
-#endif
+    if (!HOST_BIG_ENDIAN) {
+        offs ^= (8 - bytes);
+    }
     return offs + vec_full_reg_offset(reg);
 }
 
diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index e073e5ad3aa..f3b4b48ab7b 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -175,9 +175,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
 
     /* convert it to an element offset relative to tcg_env (vec_reg_offset() */
     tcg_gen_shli_i64(tmp, tmp, es);
-#if !HOST_BIG_ENDIAN
-    tcg_gen_xori_i64(tmp, tmp, 8 - NUM_VEC_ELEMENT_BYTES(es));
-#endif
+    if (!HOST_BIG_ENDIAN) {
+        tcg_gen_xori_i64(tmp, tmp, 8 - NUM_VEC_ELEMENT_BYTES(es));
+    }
     tcg_gen_addi_i64(tmp, tmp, vec_full_reg_offset(reg));
 
     /* generate the final ptr by adding tcg_env */
-- 
2.51.0


