Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A662CF9C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8wk-0006x9-Ff; Thu, 20 Nov 2025 12:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wj-0006wy-5G
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wh-000710-L7
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so10354745e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763661589; x=1764266389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vtPJyMqgCGMhr6VLZ/OxluMX8n/5Gh0ZiBYoSL9UOw=;
 b=khCDtdKd6R6DVT9ktn7A8JlQEHPHsEFHsayECfpw1juCnLih5HY3ZMjI9dSmeNH2ts
 DD7yvqEVzY/L34UYezOKv2c55BXqYPmbjtTNwbkmHIYEffFReaoOyW82RypCDvOj7rKv
 nnuFHb7NFovVe9ivGqhEmvUKZjKnB9WqeiG10eQh76Usv6wl8a7xNwnB+qx8+kPlrr6M
 F+HObwIdP/6/p8DMRNj74+avfE3YB+50rN6rGjIZI1ahlOYP1nWbcSkK8Trrf6YciP7l
 bUBCxVcU4FBq7QrOoymh++FmMyqmc0wn1uDYuJ3tk+JwmbySW0iOFBrwJurgih1aLe9C
 oKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661589; x=1764266389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/vtPJyMqgCGMhr6VLZ/OxluMX8n/5Gh0ZiBYoSL9UOw=;
 b=RW4vQCkF6zg87dAg8eosT/u9+Enwzua8Ogt2tHticTeil3iBGoBHz16eeUBAlVOA15
 2QXZbz84jwlARqA5UL6sHimaORc9Wywo+8Gx5L1EiFhcgf1U8ap/EaUQmVbOXZtcyKUt
 B3Pte8I552YN7xuYjv68Cw7N3A2Ke//YIRAQvNeAHYBg4mVGk4h5Tasq35k8lZG+YXH+
 nW61Q/oU+sq6w0J5Y7BixULuqH8ZPK1XXqW1vSkjdtMMHU9ERwJy0TgSyHT7Ts39hU+1
 YatamSvDLruIVfYQaXjZXgxpLm9VbiLAkIz/JP84q03Kg5/VwLSxUdlvQgucdqUeg/sT
 vklw==
X-Gm-Message-State: AOJu0Ywgg6j9UJJ8MtH+5nZkTBRYPscJqkaDaIVHzsnqONGykO/I76eY
 vLsusoyZX6aCn3CxV0tqir42/JDLLZWtWnnArDAEANlakTILZKkyV2o8rcXqfARwQAo+dJ7fC+l
 89P1eIh1T6w==
X-Gm-Gg: ASbGncs+sNzasv1v+8DF4bVxiGuunnpAgFWzJbdvrjjCmMBccmApwICCtpRCOL/N0Xw
 /eIzYpM12ydMo11wifWRzhv+PEPpiBRrw7yR6rCooRmiFIR3EGc572Bfu9csE31G4Xlit/xsO7x
 b/VVAGSh4ew+BNjLzJV1yOQepRKCzDDyWEfEYFfCiNLRFlutnF7bndzEd7Gfp25dVnQkWlBW0Xw
 nGxxrLf59+Vq3wszp/tufGyjcTYHAzTUyXh6G/ug4hRvaambiPIRupx6/owJdhJETs2B86Bo4e0
 bjh0GXIoX0qazzSEQYDLscQ2AqjKJpDBmdvDINNWSDa/9Bq+lEXXmfCnzU8m2Yap5a8dbCnidex
 zutBq1kNH6ns731FSAX/CoDNgb+siud7lrBQ4TCxL2s4F1iZ7ORmQ5C6ARqGrjRfcFPakAnbPMZ
 VOQo+T0h6J7Q0AKzvrE5ZLqlWmaUyfDEGZEfL3vy2fOuKUDwjVmWOBrQGc2o3Y
X-Google-Smtp-Source: AGHT+IHosIeYbIb/mhgMUy4D75IG6BcbvOXPhXuC5ZhGKOifdEk8EyMRxSwR0mnp7/PbBa9y9j1N2w==
X-Received: by 2002:a05:600c:46c3:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-477b8954d83mr44701375e9.4.1763661589417; 
 Thu, 20 Nov 2025 09:59:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1e868bsm2057665e9.4.2025.11.20.09.59.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 09:59:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 5/5] target/s390x: Use big-endian variant of
 cpu_ld{uw, l}_code()
Date: Thu, 20 Nov 2025 18:59:14 +0100
Message-ID: <20251120175914.6515-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120175914.6515-1-philmd@linaro.org>
References: <20251120175914.6515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

S390x is always big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 24675fc818d..84d901c2008 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2437,7 +2437,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
     }
 
-    insn = cpu_lduw_code(env, addr);
+    insn = cpu_lduw_be_code(env, addr);
     opc = insn >> 8;
 
     /* Or in the contents of R1[56:63].  */
@@ -2449,10 +2449,10 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     case 2:
         break;
     case 4:
-        insn |= (uint64_t)cpu_lduw_code(env, addr + 2) << 32;
+        insn |= (uint64_t)cpu_lduw_be_code(env, addr + 2) << 32;
         break;
     case 6:
-        insn |= (uint64_t)(uint32_t)cpu_ldl_code(env, addr + 2) << 16;
+        insn |= (uint64_t)(uint32_t)cpu_ldl_be_code(env, addr + 2) << 16;
         break;
     default:
         g_assert_not_reached();
-- 
2.51.0


