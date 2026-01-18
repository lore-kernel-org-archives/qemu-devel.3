Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E6FC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauR-0005tv-QC; Sun, 18 Jan 2026 17:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhauB-00054o-GX
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:57 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau9-0000zM-Al
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29f2676bb21so37329805ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773951; x=1769378751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joRi6369pVbDsKfJdtidvp6zyQujsSJuuqqcthZ9YJA=;
 b=qI6EjGQZte9u6gbA4X8VfNGsTcWtR1msKWggKEPZb5xAksruv8wjr09Dvf/wwH7qTx
 oKQAmGb5MroYFRqa8q0+GNiozaEPRPHjgQhhj20UjAThzN6NpKbPGodOCNUxkiNjHcxQ
 JtWQslBuu+jdd/Z07eBJ0Vb64K8KBN7thnEkQMN6tMWT6Fc/N3v1kesCICzBUT6w3O7i
 CoFXBMGK7D6uneJqqmWWG4OlNS6tuky2rMl5lab35TaMp3Kxm591h9ZuwvPqp0xVoQUc
 eY/t6f+yiQ7KpBym3b9b0jLe+NIFX5mkYyKKkyZgXX53LFhYT1iOm4XjDdEr5wez2J2k
 9LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773951; x=1769378751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=joRi6369pVbDsKfJdtidvp6zyQujsSJuuqqcthZ9YJA=;
 b=OIOHDXefr+uPS0m3Lp0BiWr59bmMfgdvzjlCND4q7RC5FKhvYaLbyk3J6NDAr1rVc/
 1Xc7V0bbFp2nSDDRZZh5QlWls459ze4TPfA/ZgkD4143RWHBbp/PNmL/jgV8YoZlCfaN
 XUAlhhOwfpklrYMVMfmUoZoUEuwtGfmKgtJHTTD/kp/xQxV7K5JjjOosBhl3/fSt/XHE
 kxgE55QKfs3yTSkShS+GPB25qczyFgaCA6SDsn1PJha884QO7Uzh1mbBX6L82mgw8U4s
 c0+UoeVFJZk1Gj1dfyDoJsD1RrJ5h37sXbHAE3vpOvjMjluZEmZ6BQ5W+F14Mz2uP/Ye
 qxBw==
X-Gm-Message-State: AOJu0Yxu3jAT8NbVskaDwEyxNeNQwrXkr0HANEsX8NSJxFetL54ksI16
 Shki/vbyc/TbmS6w+eOEeKpt/vpUIvmY/zALbLDiZ5ZudQDlyd9Cwi8G1NnZ23LLDkony4SsDcd
 yd5GClxXr2g==
X-Gm-Gg: AY/fxX6oiJVYEPY+vEab4HN+jRdwnGabn+SZMFcDAwAuGXhh7yIR7HCuFwrBjyyHjga
 7saF3OKBsXYhXlO90zmYzytbvSVtB3YzGDRS74YjcOqpLbYWAI9PFSdxVS880ycl8mzm58WOniS
 zNDFZSvbX/cBklemENk7oiB9vEKEmJIHg+No6Mp9514GAHXoAdCcz8c7cDsIPQnXqaWccTHT42a
 COn5+4k93glVndV18DsCXrXDFwrcKYImLXPUdJ9yfEBTEiAQqzH2eR283nSxsr5Mm58yYjdugPK
 E+PUoEPJHKtSg+/HhYLR6ngdsubIsydntPOdoxbbhCb21phcWsB9UNQna8mI419Avq+gvFBzQRv
 QwzPOzsrA+c49R3yTg7TSR2PKx2rQbvA89Vuf1lBRnJylLkzi8xpNxURR5czDf49amnSaFUYOf6
 lTvUJz/tHAj33EAG8bow==
X-Received: by 2002:a17:902:f788:b0:29e:9387:f2b7 with SMTP id
 d9443c01a7336-2a7188577d1mr94309825ad.11.1768773950896; 
 Sun, 18 Jan 2026 14:05:50 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 38/54] accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
Date: Mon, 19 Jan 2026 09:03:58 +1100
Message-ID: <20260118220414.8177-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This were only required for some 32-bit hosts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h       |  3 ---
 accel/tcg/atomic_common.c.inc | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 698e9baa29..dc89155c0f 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -73,9 +73,6 @@ DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i32)
 #endif
 
-DEF_HELPER_FLAGS_5(nonatomic_cmpxchgo, TCG_CALL_NO_WG,
-                   i128, env, i64, i128, i128, i32)
-
 #ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPERS(NAME)                                  \
     DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index bca93a0ac4..1ff80d19fe 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -59,26 +59,6 @@ CMPXCHG_HELPER(cmpxchgo_le, Int128)
 
 #undef CMPXCHG_HELPER
 
-Int128 HELPER(nonatomic_cmpxchgo)(CPUArchState *env, uint64_t addr,
-                                  Int128 cmpv, Int128 newv, uint32_t oi)
-{
-#if TCG_TARGET_REG_BITS == 32
-    uintptr_t ra = GETPC();
-    Int128 oldv;
-
-    oldv = cpu_ld16_mmu(env, addr, oi, ra);
-    if (int128_eq(oldv, cmpv)) {
-        cpu_st16_mmu(env, addr, newv, oi, ra);
-    } else {
-        /* Even with comparison failure, still need a write cycle. */
-        probe_write(env, addr, 16, get_mmuidx(oi), ra);
-    }
-    return oldv;
-#else
-    g_assert_not_reached();
-#endif
-}
-
 #define ATOMIC_HELPER(OP, TYPE) \
     TYPE HELPER(glue(atomic_,OP))(CPUArchState *env, uint64_t addr,  \
                                   TYPE val, uint32_t oi)                 \
-- 
2.43.0


