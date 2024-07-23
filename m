Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2A4C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J1-0002M3-HO; Mon, 22 Jul 2024 23:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iz-0002Ev-9u
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:13 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iv-0001tm-HO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so778375b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705703; x=1722310503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lffTC77hfuBCBlcm53ysSfFxUjHJ9OXDuax++3VtjJ0=;
 b=vbOd8PDnk5mdA6+TL3HVqNnvHY80cUcfFdzM0ttwh8YN98R60y9NbQMpvEUmjgnYj3
 lRYEY4m9ecR6+/cih1n0/o64xR2zT0dN07Vxkjcu1m7uueZyKtXnewPtBOZyFkuijp1z
 9yn0/Pk3RwY6qfTSEsHDHqfE/qH2pkQ26hAVzr5tGt8Sa1nR5Kqp76pZKR1z+2ZyAnV+
 QdPPnxOdg1ba/nsKhCG9jqI/WnBXia6nwvENt9WYYul2Cpe5Pih93VzMYDrPtLb/BPSn
 NdNHL3zLnKZ4VbrX0BhrMLZf7rTGFiWy/yEnhvnUW7fPAaC0n7AI8ieotERrTYIAv85Q
 X7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705703; x=1722310503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lffTC77hfuBCBlcm53ysSfFxUjHJ9OXDuax++3VtjJ0=;
 b=u4PQDT/lW86UtHF38iCsdslev5waa2Hn4+ijCO9jsqhMbz7avQyxlkd1yOeJ+40Yw2
 IFcI4TZX2mO4vSOcwNpEeBw0vB4suNIux2xaUS6WbMmC38gKvdbI1UDcKjah3SwN4oon
 67z2GWzuwEVBAgyGZfBWCdYEgWKGZ+Q8kmaB3yP7GlSt0yw66fywb3ASGQ+++lSvwj4a
 CXXQ0YjeDJjBj7DOtZ2tfGr8qINqlIgY7+BZH0I4J7yPn5bZFvEXxXy59CZo9RawOs6+
 pibVe/y6HZi24xI0zwQuOuhW/1nTt97fFjLNPoV8LxfLHANhPoWbrCYG/Iy+4xzB3FK8
 2FDQ==
X-Gm-Message-State: AOJu0YxAYnAFL+8qr+CHlJkJ3Vk4srXM/kBJE7O81hN3Vu2ohp5Z9J5u
 /ZDQ6ZbUkWpjDE6+Fuftapu/Nn5Y1lnxwJP+ZtV5okkq27/HQKnr9/+cDJruZ3Vehkb93dVn1w6
 lXtHLJA==
X-Google-Smtp-Source: AGHT+IGC9k+zrXEsLm5UlcnnwNaYbgv5BXDI4j2WEbdKAiHhKg7KvJURFdQttciock8OgzM3UjCS+w==
X-Received: by 2002:a05:6a20:6725:b0:1c0:f09c:1b98 with SMTP id
 adf61e73a8af0-1c4521737afmr958698637.16.1721705702570; 
 Mon, 22 Jul 2024 20:35:02 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 02/12] target/arm: Use set/clear_helper_retaddr in helper-a64.c
Date: Tue, 23 Jul 2024 13:34:41 +1000
Message-ID: <20240723033451.546151-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Use these in helper_dc_dva and the FEAT_MOPS routines to
avoid a race condition with munmap in another thread.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0ea8668ab4..c60d2a7ec9 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -928,6 +928,8 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
+    uintptr_t ra = GETPC();
+
     /*
      * Implement DC ZVA, which zeroes a fixed-length block of memory.
      * Note that we do not implement the (architecturally mandated)
@@ -948,8 +950,6 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 
 #ifndef CONFIG_USER_ONLY
     if (unlikely(!mem)) {
-        uintptr_t ra = GETPC();
-
         /*
          * Trap if accessing an invalid page.  DC_ZVA requires that we supply
          * the original pointer for an invalid page.  But watchpoints require
@@ -971,7 +971,9 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     }
 #endif
 
+    set_helper_retaddr(ra);
     memset(mem, 0, blocklen);
+    clear_helper_retaddr();
 }
 
 void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
@@ -1120,7 +1122,9 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
+    set_helper_retaddr(ra);
     memset(mem, data, setsize);
+    clear_helper_retaddr();
     return setsize;
 }
 
@@ -1163,7 +1167,9 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
+    set_helper_retaddr(ra);
     memset(mem, data, setsize);
+    clear_helper_retaddr();
     mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
     return setsize;
 }
@@ -1497,7 +1503,9 @@ static uint64_t copy_step(CPUARMState *env, uint64_t toaddr, uint64_t fromaddr,
     }
 #endif
     /* Easy case: just memmove the host memory */
+    set_helper_retaddr(ra);
     memmove(wmem, rmem, copysize);
+    clear_helper_retaddr();
     return copysize;
 }
 
@@ -1572,7 +1580,9 @@ static uint64_t copy_step_rev(CPUARMState *env, uint64_t toaddr,
      * Easy case: just memmove the host memory. Note that wmem and
      * rmem here point to the *last* byte to copy.
      */
+    set_helper_retaddr(ra);
     memmove(wmem - (copysize - 1), rmem - (copysize - 1), copysize);
+    clear_helper_retaddr();
     return copysize;
 }
 
-- 
2.43.0


