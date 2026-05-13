Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6084CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3Uh-0002SO-Um; Wed, 13 May 2026 02:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3Ug-0002S6-6o
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:54:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3Ue-0003Aq-MX
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:54:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso58602515e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778655295; x=1779260095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4bOQuqHp18KRI9+SeXYv9W+Vz0oAIFVkyuXucZjK/s=;
 b=mGcB7BW1Fu9Ek9+sknr0qOYsHqLFte5GeuyN46qd87tI9+uCJH8Z2l9hwXqH4vjSL4
 L3u4aR6gwAUPOBjzd01dNc1uZvNaER1RPSIMPCB0n+NZh9OWv92y+LUOk0/Ad4XkRHT7
 pTBaoLVcxC30uZoYMv1vy3cmmAG63WVQx7SEQy82RfDK9qjZWincn7XkLtOY5sC1YnQz
 zcES0MbtkKpEB2FsZeAo2L4H+v87L91RfgzYE168nO+pu4IzwbyLJoA03y/p0pJBxDvq
 vbQbxOf9mFU+qzy116MKh5slhPVAGs5eO3FVbYSlKsi9Gf1Jde48xKjYGlKXQwwUeUSS
 YZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655295; x=1779260095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/4bOQuqHp18KRI9+SeXYv9W+Vz0oAIFVkyuXucZjK/s=;
 b=rzpa66onvlhj1yfz924GAE8y7P03Lu7mRoIYYcY/lKNKsWpbrtfjLI7yUrCOzzb+SY
 Nc+r+By3tCNmlTxB3QF5CWRXDD1Bsn8thBZGavfeJGbhcmz5AON3J1yeWkxxJaR8hkzp
 JzEPaG8nouqsnERELDtuFZyuIwhQRFiy/JgHwvF/uh/MVvvu1XGyLxAoTEyVkKFmyuCS
 eIqBgNCkyx6u6J5YcmefTyFDnRKu4IEtELD6/Wzw7/OJqy0VH1YISyGMFtrK0cecKKzw
 SqqX50laBoLhLfkHdxI82jRUPMwzWqbGpUyJSljMozVJmG2hj3yb628Wt4dMhXNshDR7
 Uj6Q==
X-Gm-Message-State: AOJu0Yynqwo4/c0yfcLQs/KfKDfPZh2aoqS85/c5ANQ80SQwz/42RsnC
 GVkEZWmnklagJQFmtkfPbZyS9VEXO4ZEPVok2xXm4O8tOPZ0bDcAl2gGjHRPddTEjnc9EaCEPTR
 FtJVBT7A=
X-Gm-Gg: Acq92OE1EkpLGNAxiTLtaY9OuWxPxGku3PJXGgOyIp+zyhq4oEanJiIsjKjVnV17UAT
 RcbksW0rGB9uADL99ilBpVRwAAuFIhS79Z06pm4qvd+PO3qCOFyop0tFpObpID8nhtHiavTDZJh
 sNNsVcVbU5/4GtqKfCc9/l4JZCRGpZ24y8HjcuRkpotZAUN7dH7C3FEB5FnITJDdX4a//OPXSqQ
 W9MPWdjT3IJZWO7dK68Os1lP7TCESg2QvisKkUP/bXoKoLGncVYshScLlVjx8P4Pd/AVUroUGVU
 Y/sxT0zMWccysxvF8pbtRDY6yzzleomLjiqzFt6KanV8lizeIhVK7BRY6Ew6s1gAJ+0RlvB+ccF
 hI26ozkS67UbsrAkqCYQz8pvvuuCIWxEZtfmu2oNh8XyuPkIcmNgUYtTy3IT3sYzCnFQKUg0sOi
 33Rl2QJB6Q8+vPyY2E48b0GSliKjBC4TXHxl7QebNo4UzImmKLhBP+DcHQT1Q0xS0uiOpTwrvpP
 S1mMcE3xAY=
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-48fc9a4b276mr26766155e9.27.1778655294567; 
 Tue, 12 May 2026 23:54:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fce06ca2csm23688085e9.8.2026.05.12.23.54.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 23:54:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/sh4: Hold alignment as DisasContext::mo_align
Date: Wed, 13 May 2026 08:54:36 +0200
Message-ID: <20260513065438.8680-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513065438.8680-1-philmd@linaro.org>
References: <20260513065438.8680-1-philmd@linaro.org>
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

Hold the alignment in DisasContext::mo_align,
initializing it once in TranslatorOps::init_disas_context().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 3ddd4f612e4..5957f294c22 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -39,6 +39,7 @@ typedef struct DisasContext {
     uint32_t tbflags;  /* should stay unmodified during the TB translation */
     uint32_t envflags; /* should stay in sync with env->flags using TCG ops */
     int memidx;
+    MemOp mo_align;
     int gbank;
     int fbank;
     uint32_t delayed_pc;
@@ -51,10 +52,10 @@ typedef struct DisasContext {
 
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(ctx) 1
-#define UNALIGN(C)   (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN)
+#define UNALIGN(C)   ctx->mo_align
 #else
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
-#define UNALIGN(C)   MO_UNALN
+#define UNALIGN(C)   ctx->mo_align
 #endif
 
 /* Target-specific values for ctx->base.is_jmp.  */
@@ -2225,6 +2226,9 @@ static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
             return;
         }
     }
+    ctx->mo_align = (ctx->tbflags & TB_FLAG_UNALIGN) ? MO_UNALN : MO_ALIGN;
+#else /* !CONFIG_USER_ONLY */
+    ctx->mo_align = MO_UNALN;
 #endif
 
     /* Since the ISA is fixed-width, we can bound by the number
-- 
2.53.0


