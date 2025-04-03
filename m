Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED82C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sgn-00018S-UW; Thu, 03 Apr 2025 18:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sgl-000107-EW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sgj-0003zt-N2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43948021a45so13194545e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717927; x=1744322727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtZrrkt2ntmoiQ4mVP99KUX/c8Ppft+k9zep++rss8s=;
 b=Nm6QjevMu/mc6NgtzyCe/Wg/OIhvti6R/FovHhID1bKB95dRALyzHVAZbcGTSRQKpk
 qmUnS2Xn+4PJITnwdNMMl9biMhtwdJatMFSP88/UTt7doAcWzE1mDFXMJbF+tQFLYjXJ
 CsZedmkk4je3l6WWB36fxMIAjktVsc4ZY8z3b8bMl391gyNEecYdyYttAMoXq7KX1iy2
 AeMFYfWN/iLnoRKhEkM4/7bgpF9qud25IcrfsiU1Ymb5GcGDt8pZJguoPkigE4UsGPHy
 naE/iUr9KK3EVVTElpaDuTeh8lDhjIQQlGPBmCv7p7N1J3hFeoWX1VIdvXK/OGZJQ7Dl
 pk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717927; x=1744322727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtZrrkt2ntmoiQ4mVP99KUX/c8Ppft+k9zep++rss8s=;
 b=P8RQql3KSkD1WCaOUUTnjE0mjK1l/s2lGWwjQzZ13n1IWWMOHW3XLRjh9r2WnPKPO1
 D/bgudESUGnKucWp0/RN3lLZuAGrHUElhhUDr/THw80PQwV2mbOv9AVm0WWjA/hZrtL9
 pxB8A2ANml2tlU8V6kslgiuKVSzTnKllW5u5L7Ny8pezKX5CwFp95NDCgT03AR/l5FSZ
 rJvS5WVUdPP1lKhhyVvgqPLI1xUd8DYEcFIp35i9zCmBs0vklkdshDPdjQDdI4Zl6oDw
 Q+0+gqrYLL373U2p8A+SL1IckMxj0Mw0q/1Aq5QCodHb1YH3oPIxEt5X9yEN1s6igIo/
 xGVw==
X-Gm-Message-State: AOJu0YxV6AhA6oQM/IeOiqSnP2KWKIRr/UetGBYQzN+EmEx6puU21Pl6
 M8glvnhrETQ/w36nHOO6un/TXrxbLE/FD1fp+DGYhqShQHudyyTJ4HR1fCRpYxZfyllVtU5yO8C
 M
X-Gm-Gg: ASbGncvqfUvZbksIRSolL1xLzaFhuZhwanUmQfKZgLx9zIJQs5X4giNoxAHlyz0zcpJ
 D/IXHqw6fY0uyYDMIuZNDTTClWxIrw9bfbZDt1ZkrOxkgFay3LYfAOwGau3fPYSIvmB7vitCDMY
 uy41a+f+/OjLy62FtbBcE3CmLNJOANKytExlqIGEFxQIN16Niz26h93I+uUVAqoRM3FjRdkkme7
 fOkAqNPtBFfcZnX9nxjXRbOAkKvTwN+GYm28z+lWlAVKuPvlqSwr2pZ4mIOpQFJ6cE8fIW63uha
 6ednMCmOgk3tuW8EiM9Q6XzoFczM6vwrVtPNGQ4zalbzCk93cXuJfzk9ofbNjXWr2dDPN1kIK3j
 0u9CL8UXEW4if1Zcmx+DGXVce
X-Google-Smtp-Source: AGHT+IH7MoWwihKJS+RDY0C8G0yMIApAZ14lJ3hnmc3lJMcmb01OVsZR1dAmULDsDxYtfS1+o55MhQ==
X-Received: by 2002:a05:6000:40cf:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-39d14662f92mr310914f8f.53.1743717927503; 
 Thu, 03 Apr 2025 15:05:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16049sm60441215e9.0.2025.04.03.15.05.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 13/19] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
Date: Fri,  4 Apr 2025 00:04:13 +0200
Message-ID: <20250403220420.78937-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

In order to use TCG with multiple targets, replace the
compile time use of TCG_GUEST_DEFAULT_MO by a runtime access
to TCGCPUOps::guest_default_memory_order via CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 23aac39b572..f5a3fd7e402 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -46,16 +46,15 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 /**
  * tcg_req_mo:
+ * @guest_mo: Guest default memory order
  * @type: TCGBar
  *
  * Filter @type to the barrier that is required for the guest
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
- *
- * This is a macro so that it's constant even without optimization.
  */
-#define tcg_req_mo(type) \
-    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
+#define tcg_req_mo(guest_mo, type) \
+    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
 
 /**
  * cpu_req_mo:
@@ -67,7 +66,7 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  */
 #define cpu_req_mo(cpu, type)     \
     do {                          \
-        if (tcg_req_mo(type)) {   \
+        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
             smp_mb();             \
         }                         \
     } while (0)
-- 
2.47.1


