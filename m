Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F77CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pv-0007FK-Ll; Sun, 13 Oct 2024 18:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pa-0007A4-4V
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pY-0000vf-EN
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2dcf4b153so2229771a91.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857571; x=1729462371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvwlrMz3Fk2P5q43/JWG8Wh7xLnVWB9wP6XAmMUyGN8=;
 b=JSCedkKGgDGHqgNK74jdohI0C8V8sya4nAevMefTFc50RjPnlRxakv3Eg30hqfrkKQ
 iGZvwVjDdbmxLm5lpe3nkVaShs/th6XA9j72nnYBFnj3gmYW24HEMZ07isNXKiqPTx23
 7r5YYAU3lVGzFM9wmkAOnBSQGinuq2+LSWRAffmg2TOx7bxkgFTfuq58KijYSjxuAppT
 KN4nmXWzMiSI5TPpiFCuDJ2Vf1t+pNaCPN9v8xHa7b82yWrwBrE8Fw/aoVqMrXuykAnl
 /D6gr6Vfod7kQ72QB06A2FD0tMo0ZW11Wf8WB+lzqtQkvy2hcM26PaIp8JHLYYm5RZoh
 hD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857571; x=1729462371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvwlrMz3Fk2P5q43/JWG8Wh7xLnVWB9wP6XAmMUyGN8=;
 b=WcYsh71katJoaB35Xxgs6H6LfRS3Zr8k+1fugMYcnaJn1iSFogKIR/lnnL+bjDdFpc
 GTYJFViZA0wdev7z1HhnJ+z6Y5B8CFp2aP675+ByTfYv0X/E8CH49BnBQIHGwhp6aWxc
 PpsWTl61cVj2+34xutra/kGBLYedr4+VCMHjgnXBtGHtbttImHw6yTg+2HLkXIrvLdI5
 X+TQdiNvC6bsRY+YQMU/boJRywwTXPJG3bdf20dnxM3e2mxXQgdIav9BgSOwZgcF0Ntt
 7n4I9fBx0Ll/SEgHXpVNwlfTzNpV98dlMb0kfcRJ5434IGRfMf0Mvtg+7dpo/nENkpui
 g5lQ==
X-Gm-Message-State: AOJu0YxAZP5zaI85wNgfk4vfaV0LQjTjbE13N3U0d86HQoeXGv5l7RV5
 Y6YuYcwBQSurtT5VTsVmtj9KaIIGHyoBrKE2fym7xFhvSdwfzLCQ3tLbLw8nOP/vfCuSpSetKBz
 u
X-Google-Smtp-Source: AGHT+IECTx8ryhMseFkj2tvyby8ENbkgmNVnh6fxEfbgPFbgAKOiVb2YSgmFlVGe65WZ1thAQ1tS6w==
X-Received: by 2002:a17:90a:ee8f:b0:2d8:dd14:79ed with SMTP id
 98e67ed59e1d1-2e2f0d7aa18mr11741015a91.31.1728857571226; 
 Sun, 13 Oct 2024 15:12:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 15/27] target/hppa: Perform access rights before protection id
 check
Date: Sun, 13 Oct 2024 15:12:23 -0700
Message-ID: <20241013221235.1585193-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

In Chapter 5, Interruptions, the group 3 exceptions lists
"Data memory access rights trap" in priority order ahead of
"Data memory protection ID trap".

Swap these checks in hppa_get_physical_address.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a386c80fa4..f027c494e2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -267,6 +267,12 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
+    if (unlikely(!(prot & type))) {
+        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
+        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
+        goto egress;
+    }
+
     /* access_id == 0 means public page and no check is performed */
     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         int access_prot = (hppa_is_pa20(env)
@@ -281,12 +287,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         prot &= access_prot;
     }
 
-    if (unlikely(!(prot & type))) {
-        /* Not allowed -- Inst/Data Memory Access Rights Fault. */
-        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
-        goto egress;
-    }
-
     /*
      * In priority order, check for conditions which raise faults.
      * Remove PROT bits that cover the condition we want to check,
-- 
2.43.0


