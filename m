Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17ACC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R52-0004dQ-Fc; Fri, 25 Apr 2025 17:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4V-0002LA-0e
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4S-0000tq-TQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22438c356c8so33162445ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618335; x=1746223135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjtZ6ORW1GxJDkpB5cR+m2yg+nHU5H7+ttbjAUKoJMY=;
 b=xviYFDqfqAHzJ07aNtultPFD5XBsFMHQUkzE7EeaWySHkDL/YxttEr5f5xWdHKlBag
 AWWuFDBmJpJs/qDCUlwyY3nA9wXP3PyrULiLQrACAeoIwDH9wLwkAYNy0/vuP/UyFxmN
 A2sV4gsg3Y2qbPNg5tj1cOREo7EhIzCUvXCHaqf8Y5Y5NMFTOUp+5nlQj+nBpyQGWyKf
 aq+suWJKJiU7rW7RxoM1EBpbDKNkm0whuNMol/YMOe5lk2JE3TBtzs7QkoLdxokQc69B
 FkNxKe9I/IEC2E6e21Wos5/lyHufQjUkWSp4kG0izDb+7UfmLa0r0p2nsRmcSCq5dt2F
 g66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618335; x=1746223135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjtZ6ORW1GxJDkpB5cR+m2yg+nHU5H7+ttbjAUKoJMY=;
 b=AVbS4LMiVlq7N/G5hhKbS9IyBjBoe2LvUQensV7ADiLJkpeCaR+KE7Skt+6VoJdPs5
 CyKepK5VhdvWpbQms58Q0kCxHLpc3wwy/2IAhnHK+pJ3W17v+OEAwOrtzTkLj4IHkd8c
 k0NH4rIOot+T4zCva8LGyB7pYrMcP2NjS73fMQambpD8QK6/n+0USyk2bEFKbPGOZoU6
 ACxzc1eqFkZgFHG9ANAtXWvoP12LEhjxPGA8DrKcxGphOVLADoUSjK/4gEuia1wOSWks
 EpBOhkoriEnk/Ofe3jlidbFOvyAHcv7z4jm4NBNFwXs22K+j68MGjcJLiU+V+13c9Ym0
 SMGA==
X-Gm-Message-State: AOJu0YxNmNZFI9sC1LGpycI0a5oVxH95LYWSoJ4nY11OXhlG0uu02G/2
 nDvAiC7WqKYKR5sMywEqC3mqcUQ0nbgnkMm6C4JZIrrBxcTlEavF9+lNodwhqGHxuSN+lyALVNm
 /
X-Gm-Gg: ASbGncvDP7+NkBc9B2UxiJsDObm9zpyLScINh23tRaSOzelLWJbRM9qU+Rdxn5lVHHn
 /hxSySWDaRYVRAzyqBNV/gVmSoNaiJJRh8G1UE6ovjS0cQE6xVTyR4vqwZk4j4wesgoYnUqVYeE
 BEuK0JLdvGVCILuNh0I50Vaoqy7H62CYlK/sFf4GaPv8ZLWq/AOfide6WeKWWJkAKKD0s7FE7pG
 8JxNBh5mxIFDWl6SJ8Mddzeic8xNBUoOzDdWwcBYDPUd0JiW2V81OcdEmeo+YjSjhJV7SWlkBgM
 Te/LeH4EGzZfF9LcyXzvyxu5lvuYnFcBP1Ei/XCs8/mAAkQ0skLiRuTDb6UdZ+uRCm5tyJUBTjg
 =
X-Google-Smtp-Source: AGHT+IEUzatIvHLI1e/JK2euqH821toRpTNdCkHV25JfTn32PuBuuipSqTi3hR+ixpVVxCQXPf3tjA==
X-Received: by 2002:a17:903:2289:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-22dbf62c693mr53739785ad.39.1745618335161; 
 Fri, 25 Apr 2025 14:58:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 078/159] tcg/tci: Support negsetcond
Date: Fri, 25 Apr 2025 14:53:32 -0700
Message-ID: <20250425215454.886111-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h |  4 ++--
 tcg/tci/tcg-target.c.inc | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 2402889bec..7787347e05 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -10,7 +10,7 @@
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -19,7 +19,7 @@
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 563529e055..2eb323b5c5 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,6 +79,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, r, r);
@@ -966,6 +968,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                           args[3], args[4], args[5]);
         break;
 
+    case INDEX_op_negsetcond_i32:
+        tcg_out_op_rrrc(s, INDEX_op_setcond_i32,
+                        args[0], args[1], args[2], args[3]);
+        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tcg_out_op_rrrc(s, INDEX_op_setcond_i64,
+                        args[0], args[1], args[2], args[3]);
+        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
+        break;
+
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
-- 
2.43.0


