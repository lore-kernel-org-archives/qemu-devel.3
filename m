Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45587CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIz55-0004Q9-3F; Tue, 11 Nov 2025 19:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vIz52-0004OU-MQ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:51:24 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vIz50-0005ox-UX
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:51:24 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-88267973e5cso1732986d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762908682; x=1763513482; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CaohwLtIR7C9243DMpjNQ1vbzBgBz3c5xAC0e8E0Q+0=;
 b=CEgWIjNkVsVgpAojw07FM1Yh5cdq5ET05ul1GlNQT/lz6xHqsXvKCC/Va71iOz0N1B
 JkntsRunPQvKirMFNO0sRFNNE3xKeKPHj/NXE93zqe9nGJit2MiLogNuU3pJZ70SoQ+5
 RkZmXO4BVDo23Vg92GGkovt+pdfRWU7nm8FJLuDIzsOIA4+iX9/ijkeIr81v6E+8G4t/
 F2qpuSy7xIjpP/gs/w3JAXltsfBWoOZiHopGOJfb3zFis7UnhZTJxtH0HOvwXu3gXlB/
 yZ15Dg20sQ0/VWguNxgY8NMcaAKYNCa7jmMvCpxziYNKwrfMtnj8p0/I6QuStMbrGlUj
 kB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762908682; x=1763513482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CaohwLtIR7C9243DMpjNQ1vbzBgBz3c5xAC0e8E0Q+0=;
 b=tJTmouriwLGhkLCSuQZ/RE0OkY5COMUDjVXwlxJGS9XRSRDWHE3Nr8LWkQkg/TCCyy
 Ca2h0Jtl7vlejI+QnzGvLjvGqDPWGjINhNKglP2s4KimzHWFT4kn/pnGtn/LrFaFHyZF
 U4fednQ46FTh6L+XfsvXnADzLSCeKtd8p4TH6Svg8RBgxTJLbSDM82D2VP3gunYbAXtZ
 JaA5TV/PsnKs55Y9lf+kyyaUCFKSS+P82QY7/EOJZ0DGxXArbepcj1cI3phQY6w5o2tj
 JZLKSycU+naRmb1mM8wDhTfndRW9djNBjtXuf06ZekULMJNu8EUw4n7LeGgJpLMvbomt
 38Gw==
X-Gm-Message-State: AOJu0YyUEqWGJ2e7MqTBWyIjnIkQSG9i6ngHwOLF89+Z/GuoybeLJZZA
 wqrsAWcB33Xt39WvUFVxsXRbg7ufRfSBuT1ikA0gzwjjq54UcrUvUu09eiWPsVOi
X-Gm-Gg: ASbGnctexMLfjZvWd52WLTeOb8Puc+SrbW8VPy5JDkmOeNZActq/dB7ZKWKrjhiarKe
 86hR5Fi+iPclMj0uHQlBQ52pj0TLhf2WB49so6/0YDrYQ8CZ5mzPL02InFidylKM0N0yRR2+t9l
 zfPo0dMeX9HseFb1EmlwhEzfuEFehWY37gRPV3u+Zxb1JVDTuVdzLxRfLRld/hpkzDPZE9E5qdu
 s7oKbcwR+dvKG2fyA+v6gt/3pxCGyg/COHuf2b5bgvH+PJvUeio9/YqiOBEGoe+DWRCXTrjSqrT
 vCvEsxarPA8GcvOQO8vGMsFXoJfoUoLaNHnx6zy3uLkviESPbO/2TOJnXffCgtZ7UhY8xZvbp4J
 JJ0m0MxZss+YRf/tv0lIqLFIkadt9aVavj57ZYzZSb058ICrAPH/bBcaH5pcyx9IsL0+u9UWlZ0
 MnA3tvPCc7
X-Google-Smtp-Source: AGHT+IF+iQ2O/bPV8bzxfq2n7/AJoDexY+2jxkQwYFmiEtInhWya4OGn7/fLuEKgyLuWPYTyEA8u7w==
X-Received: by 2002:ad4:5aae:0:b0:882:49b3:c696 with SMTP id
 6a1803df08f44-88271a1145emr19627776d6.50.1762908681800; 
 Tue, 11 Nov 2025 16:51:21 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8823892a79fsm81445096d6.4.2025.11.11.16.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 16:51:21 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Tue, 11 Nov 2025 19:50:53 -0500
Subject: [PATCH RFC 4/5] target/arm: add FEAT_MTE_STORE_ONLY logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-feat-mte4-v1-4-72ef5cf276f9@gmail.com>
References: <20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com>
In-Reply-To: <20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762908676; l=1406;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=yvgh0EMVT0ltvLWA+q61dbTURKT5fEJL48Kbo0rzv/c=;
 b=Kdv1k+wkfEJeapVX/a2Nintjqzq2Mrx8gjbxU6/lwZPigtn5Tki8JOSTHHSblyJE+Js2qB2/d
 01WgRerU9qCDZtFMgUUQOUCmG+dOCMGCcZctDyrpWKn9YZpS2bAt7M3
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf34.google.com
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

This feature automatically succeeds tag checks on load instructions when
the appropriate SCTLR_TCSO register for the current exception level is
set.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/mte_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b..3f7e89f436 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -865,8 +865,30 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     return 0;
 }
 
+static bool mte_store_only_active(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    if (el) {
+        if (SCTLR_TSCO & env->cp15.sctlr_el[el]) {
+            return true;
+        }
+    } else {
+        if ((HCR_E2H & env->cp15.hcr_el2) &&
+            (SCTLR_TSCO0 & env->cp15.sctlr_el[2])) {
+            return true;
+        } else if (SCTLR_TSCO0 & env->cp15.sctlr_el[1]) {
+            return true;
+        }
+    }
+    return false;
+}
+
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
 {
+    if (!FIELD_EX32(desc, MTEDESC, WRITE) && mte_store_only_active(env)) {
+        return useronly_clean_ptr(ptr);
+    }
+
     uint64_t fault;
     int ret = mte_probe_int(env, desc, ptr, ra, &fault);
 

-- 
2.51.2


