Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37226C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8m-0008KD-Ki; Sat, 15 Aug 2026 16:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8k-0008Ho-1e
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-0008M4-Ir
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cf452def93so25334675ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826271; x=1787431071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=huYYxmonle9nqEQnUjnQGUQR5AICjj+SiFqAyTmaqDk=;
 b=ciNBTV24uJDwZWxz1yv8WN83AK60mqsIV8znpuvg+5m9hHhcBkXan1xXG3Ort1ozuR
 ASz7UMZ4ghS6pvMJrtlQ9FtF2Llvq+gSBy2kGwJKI/KgRusMpyqagCpYCGumt0XAmr0M
 Ifbtxeu5U2Qvsv94mmDzi+DyTU9KVQtgGpVqHICIkowaCDg++jfXuqd0ZDqvolzEdrNx
 2iAogrqUteTHD2O5gvg/MAhCQrLLky0LkJ1ay/IOg4XSEdxQ1bR5BCQmauz5kvNgZAMZ
 xrdP/R3DoP3DZ6/7oi8gJ6ZYBjGfQuOcAEp6sqw3tt30m96wuL9fcCC1ZkJPF+rhuhFR
 02Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826271; x=1787431071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=huYYxmonle9nqEQnUjnQGUQR5AICjj+SiFqAyTmaqDk=;
 b=sAqN+87mNdjnWADZB+kZ8f7wfShUY176G66bGXyannLX2GOf980Fek6hVxk8NGG6JR
 Etpggrpms+1bcC2u+UQ1iC773Q9iOx1iBzAJyXHPBIZIAkPqlAtC6PymZtGGbKdgRvfU
 radqNVHJ/bqKu/1PTQdqmrG/QFx9+LEM8pjVKzzi89SEvKZn/hBOR+JhM8/5sJIQ6y+N
 PGhSKeetcOFYkuzrBCbA6DQFFWcEX0BXyMEMeOCFFMIB+5YzkNBmXIOqAy/gCBCQPAgH
 8RkwLmlwF/oZsSlXJ6sS+N6d6FrXKzdWq8ME4uJ7LQcM8Z6x6Nd83W0I5uwGRn8NEG+h
 EpZw==
X-Gm-Message-State: AOJu0Yw26FURUOWQU6h5C27YVS+dMwu/LVA2LGgqftl5QNzQwmYRdHH8
 LzgVoa+XTP03yOEpLX0un4GMnT4VvQhQgxBr+1ze3w3lizt9ua80mlhRXGZQ0I9YJyPEPMpwblL
 PPfMi
X-Gm-Gg: AR+sD10ZomHBU5su54F7XLrcZ+Xpplm+CPytX7UMCkM2gtwIfgs9ZxRaAjH/3COAWNh
 STFAe9UofoqieaqR1ZP2wsQhSB3gehiL0ECvApGNqBQSzDph/eJKBbj1wjwUHlJjVaGvX/PhQwj
 Oi1P4fhgkCLzozNlnsXx8A6aLUjgOOdOPgogsLNZnSQVwvTfAWJ/MwLM3Sm0BTmALDZfHkqKgXu
 AJJTp+6tUqRVTm1CocyuN8ZFYRZALLEwCjQsVx8JTR32GOXscZsV4Hd19TJ4NOdIFk+Tl03F6v+
 hRE4rQleDylI19UmlwDnhK2HWrlqKIH60RK3xUtYfZ4JXgpSy5kpExfzcLihLMal+nuLWwegjFH
 08KhLgfTkcZ1u5jkI7ZKyPnOBlqdKbRNpZUT5h499QUTNpH8xn6M86qgAC9AUkoIf8bY1DuTP1I
 HLTwcE4OUpTFVJwttz+m1DHQX88w8BVecD03OtZnopxfhWVWFNZfHphyxYqAbpoanjgE1aTRCfQ
 T7Wg4kgEvgZkid0C/we
X-Received: by 2002:a17:90b:2e87:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3933af038ccmr12391331a91.3.1786826271518; 
 Sat, 15 Aug 2026 13:37:51 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 15/18] target/riscv: Use boolean logic in
 pmp_hart_has_privs
Date: Sat, 15 Aug 2026 13:37:27 -0700
Message-ID: <20260815203730.1468365-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

While addition with bool variables isn't wrong, as they promote
to int, it's odd.  Use normal boolean operators instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/pmp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 5ea0e5b6c3..fc035c95cf 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -413,16 +413,8 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
         s = pmp_is_in_range(env, i, addr);
         e = pmp_is_in_range(env, i, addr + pmp_size - 1);
 
-        /* partially inside */
-        if ((s + e) == 1) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "pmp violation - access is partially inside\n");
-            *allowed_privs = 0;
-            return false;
-        }
-
         /* fully inside */
-        if (s + e == 2) {
+        if (s && e) {
             /*
              * If the PMP entry is not off and the address is in range,
              * do the priv check
@@ -517,6 +509,14 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
              */
             return (privs & *allowed_privs) == privs;
         }
+
+        /* partially inside */
+        if (s || e) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pmp violation - access is partially inside\n");
+            *allowed_privs = 0;
+            return false;
+        }
     }
 
     /* No rule matched */
-- 
2.43.0


