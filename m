Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DE6C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zLd-0002pj-16; Thu, 03 Sep 2026 00:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLc-0002pb-3U
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLa-0006Uz-K1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:47 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so2117771a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788410805; x=1789015605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I5Kx/vv5Aml97SX5v+rORs1NUsyXUXac0cX1brEGJwk=;
 b=FQ4ZKuKQ91nDA/2pONw3WP20rwjBJ/fzptOAeP6VeWfuOLDtouhqIohvcm1N4ZOnmx
 RNXwEqQYw3WlF2pIHPmat7dVfJJS/6QzqGA08wrqprU2iaJkjRTFsaN8arXo6+EDSQV/
 AhywBKNo7q2kDKUiGVTheG9BLbCMi/aRD0VizufhQVr2JZOlegV0TOJlkm+wfyeWhrzu
 5Y3eWs7VZB4P+qhWAzr7+SgrXIdU3CTmbU9qzxM/avJaTD9h7YdN32ef++c8jMH++Tfc
 XQRTBHGTyRONOWfWBjQyc4r1eQcRwL71xbnXxzFDIiiFrjZRHiWkIGfH0RQJUP28EEEC
 ssXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788410805; x=1789015605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I5Kx/vv5Aml97SX5v+rORs1NUsyXUXac0cX1brEGJwk=;
 b=A8rRyOVBngypP8IHGjXRg5qhWoBfwF7M8T/DHpgSP9g1g9grmm1THWp++rWIBwHTzd
 +EsYgQfXEudP9vlduHlnhXEG792OkVsyNOLTMA19QyZMnE5S4IpTmOwLpXHxgssH0VRp
 mDjrjnjVpymeq0BADZHe2cyWQLvzPut4LimZPEvNV2FEOQfffN/NnihcxVJ9ZQjjp24e
 kj4IVkLVOZGeuIPZQbKPJ03+8WCooXBxuagNhGkiMC1S60fGrb6xTAMVgtOQ6gZMcGd9
 h1yKdYClXToRq9qEHM+EhmVUV2wmnES1iYmd0agvxdPD3fUZlnU6ni3ewuSrJKXRkD0V
 Ac/Q==
X-Gm-Message-State: AFuF++k3q2MFwW2Dg/0WOnOiuc5if/Khxy11TWLBHMdvH6XpWMIDmLs2
 aZRWgzzojSKaMZJNJT1/tXuy30uu6wy/n2ndEt2C4dKLr3jqbYvoWweEzhdYyo27
X-Gm-Gg: AYBFou3QB2BIPGIDadh9sLGf6ytmxuGXIJV+KPvgKrgFhKyKPeA5i1vXxhj6gJwxrvo
 azlMNQZbhoBtLDUr6ctrlGc7cZn/gMPQUeDA8jDmVboeJ3QbJAjKO/h1KYY3ddehAV42ghHKRN6
 7/qnT/NvsKXut3eL5PBR7i98bUUI7bggc3ybcMg5/jq/xvlxu/t8LP5xKAzsw4yvjTTN498oSVB
 +24DC4mxqg0LCWtxpAmKnaJp/IuEPoMDOoJrzgM94zy7XoOhAKfiSQ9FKEtSJAdENGO8l3DpdxH
 3P4m+8mzAasP9VZgIkAtQIt2/MuqpNTztwSFB4H6yVyqAL9IwfathP0b94NBFxnzpEVkgZm7BXO
 8Xxwb4Vqyb8ISce4hXMMWIwEPX2HwPCI74V1rnY36P5ghyeUZWK7BQ9QIIBqfhQ7wZMgp7ZD6my
 L3OlQsWH1JK5a2ukt543iG35t1S/R0f2y7RCWloXKKZ7adkgysjurMLLjJLvZGE/z9R9tNB93O4
 0nuHMqqxWkrruCF4Q==
X-Received: by 2002:a05:6a20:9f92:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3d9ae0c7efcmr16886199637.9.1788410805121; 
 Wed, 02 Sep 2026 21:46:45 -0700 (PDT)
Received: from localhost.localdomain ([76.133.142.170])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm2337726c88.9.2026.09.02.21.46.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 21:46:44 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	balaton@eik.bme.hu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v5 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
Date: Wed,  2 Sep 2026 21:45:15 -0700
Message-ID: <20260903044626.24453-3-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260903044626.24453-1-54weasels@gmail.com>
References: <20260903044626.24453-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=54weasels@gmail.com; helo=mail-pg1-x530.google.com
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

Why this change is made & How it will be used:
The 68881/68882 FPUs require fsave/frestore instructions to read/write state frames. QEMU only fully implemented this for the 68040. The Sun-3 uses a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence. This patch adds basic 68881 FPU state frame handling (NULL frame) to accurately simulate an idle FPU state.

Impact on existing functionality:
Fixes FPU detection for 68881/68882 across all M68k boards without affecting 68040 specific state logic.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 target/m68k/translate.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 138c89d3e5..c89ef213ed 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5364,11 +5364,11 @@ DISAS_INSN(frestore)
         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
         return;
     }
-    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
         SRC_EA(env, addr, OS_LONG, 0, NULL);
         /* FIXME: check the state frame */
     } else {
-        disas_undef(env, s, insn);
+        disas_undef_fpu(env, s, insn);
     }
 }
 
@@ -5379,12 +5379,18 @@ DISAS_INSN(fsave)
         return;
     }
 
-    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
-        /* always write IDLE */
-        TCGv idle = tcg_constant_i32(0x41000000);
-        DEST_EA(env, insn, OS_LONG, idle, NULL);
+    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
+        TCGv frame;
+        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
+            /* 68040 FSAVE: always write IDLE */
+            frame = tcg_constant_i32(0x41000000);
+        } else {
+            /* 68881/68882 FSAVE: always write NULL frame */
+            frame = tcg_constant_i32(0x00000000);
+        }
+        DEST_EA(env, insn, OS_LONG, frame, NULL);
     } else {
-        disas_undef(env, s, insn);
+        disas_undef_fpu(env, s, insn);
     }
 }
 #endif
-- 
2.50.1 (Apple Git-155)


