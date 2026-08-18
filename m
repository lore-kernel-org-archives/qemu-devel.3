Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACDBC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9Tz-0007V7-BL; Mon, 17 Aug 2026 22:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tu-0007U4-5m
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:14 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tr-0008KM-NL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:13 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so3575755a91.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019789; x=1787624589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BhVD7+/45V1IEQ+bx2PiJcdOXSF4+dl06ha5CDBLiP8=;
 b=r2hCJDv7msHoEnJ148vgyUyCSZBvi3MNt429+xqYlB2zODWar4qUSD048Rh/yOSb9k
 ZVcSVdE0BMBpCHl2efwQ4KHtG7F7zTGgTKaSXVqp2LBiKX4mHWJs0EWBcmHq2RMzrqmg
 TiXPdi9vNU9y3uv0Mb7iiJXCF892LHEp6oveWLfA8gcoz0vg+9B4DBn8CgSUxbW/k7tX
 C7ZIB3vwfajvxny6z1xYfJzgrzpYMFXNbVpQC7WvicbVw8A4hj0s9GAaB8CXQy8586qW
 e/4tUUpk52RSpI4tJQvjyo+B9XHsIyJqMWl1bppotZsSSpEl59OSEXrSComZwiRWk+Hs
 DlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019789; x=1787624589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BhVD7+/45V1IEQ+bx2PiJcdOXSF4+dl06ha5CDBLiP8=;
 b=g8BNu+bSGu9u3zjrcuyIebvmPzlEXOeC4vFLxCukf30s4LNnFqtabJLwdtYKGkNyTR
 xS9pNrkYw39Rz4zt3XfIDTTqJm2pN4IKDZEjCMPOry6EVKNPFiCkBw7a6DGX0BnlSiTv
 qF7SGA1NxSSVArTpO4ZDHQ4MtKZRL1NlUwh27QNFGlepDoUqAIyfpWzjfvWRGTmNwPGI
 UQCU8CNeacai+m4m+VBYS4f837upYrPO73ZXBjQI75rNmFpZ+fO26+laDAzudzQGg20m
 jVCw6pBe95lb/GABtmd3GqQu4FL5JY7WvNTAG6TewGRyWOEwGeF3BgsSE7WUs/J5Rw0L
 0PsQ==
X-Gm-Message-State: AOJu0YxlMfcH/wzDY+fpksE8qu/nFAmJNss2Hub0cXDmhDwl9oRWkqkY
 TVSPhENS1ZxZiCRQzLClforPuGEFYLYxpotCfiwLMldI3B7ADSjYTcdaMDQVcw==
X-Gm-Gg: AR+sD133wK5ubDJkSMpAB1k5LAOShPoxrHhNclDJ5jLOpUJjllfF/gFJt2JQylNDHHM
 4BGqIUvVksQFLTzd0tPXgjuzBQtW5RZy/PbgkYpeiarxnsSnrX5MzsX0VYkKdkVFt8wmvsamM2L
 r99c4X3FttVzJCn4lEp1JHyGSBHEtarPHo/dxYWpsktvHDbSxFJ7CrehrUcv1smrjOE4cAZAnNO
 QUjkcVnGOdsTQJu2SEeHp6UQrX3uYLnMsigJ3Q9ZGcGu76hEgBsnoQWaTfeWZ5Jz+XJk9UQMRZ7
 xiva+O9BmU3MvbVYYO0Jcysj4kpTkMrJDWLX9AdyxDDagQ2nIeaE6AKRvTvHGSbpgYI+m0rwevl
 agkEh16wg9buDDujUnTv0Qx14j67na2ZPIKJ/iZ5cjvvN5yLlad8Zzh1CaqMjy49SYvo74BTfaZ
 +mzl03veLPt77ifuRjq5kzYCWHW4pIv3Ugs6/4ZQCSKDk5eMrB6MjYvcBvP9K8bac9p0plmMgO7
 QIm
X-Received: by 2002:a17:90b:582e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-3955a79ccb7mr5664872a91.13.1787019789276; 
 Mon, 17 Aug 2026 19:23:09 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.23.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:23:08 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
Date: Mon, 17 Aug 2026 19:22:18 -0700
Message-ID: <20260818022225.31801-3-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818022225.31801-1-54weasels@gmail.com>
References: <20260818022225.31801-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=54weasels@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

High level description:
The 68881/68882 FPUs require fsave/frestore instructions to read/write state frames. QEMU only fully implemented this for the 68040. The Sun-3 uses a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence. This patch adds basic 68881 FPU state frame handling (NULL frame) to accurately simulate an idle FPU state.

Impact on existing functionality:
Fixes FPU detection for 68881/68882 across all M68k boards without affecting 68040 specific state logic.

Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
---
 target/m68k/translate.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 138c89d3e5..bdf619883c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5364,11 +5364,19 @@ DISAS_INSN(frestore)
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
-    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+    if (m68k_feature(s->env, M68K_FEATURE_M68040) ||
+        m68k_feature(s->env, M68K_FEATURE_FPU)) {
         SRC_EA(env, addr, OS_LONG, 0, NULL);
-        /* FIXME: check the state frame */
+        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+            /* FIXME: check the state frame */
+        } else {
+            /*
+             * 68881/68882 FRESTORE: read the state frame
+             * (NULL frame is 4 bytes)
+             */
+        }
     } else {
-        disas_undef(env, s, insn);
+        disas_undef_fpu(env, s, insn);
     }
 }
 
@@ -5383,8 +5391,12 @@ DISAS_INSN(fsave)
         /* always write IDLE */
         TCGv idle = tcg_constant_i32(0x41000000);
         DEST_EA(env, insn, OS_LONG, idle, NULL);
+    } else if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
+        /* 68881/68882 FSAVE: always write NULL frame */
+        TCGv null_frame = tcg_constant_i32(0x00000000);
+        DEST_EA(env, insn, OS_LONG, null_frame, NULL);
     } else {
-        disas_undef(env, s, insn);
+        disas_undef_fpu(env, s, insn);
     }
 }
 #endif
-- 
2.50.1 (Apple Git-155)


