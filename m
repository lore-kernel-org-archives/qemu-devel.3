Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82654C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKU-0001k4-2R; Mon, 27 Jan 2025 05:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKP-0001gk-RY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:50 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKO-0001xn-Cs
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so27831095e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973605; x=1738578405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BMW+C7jqPLrnYT1UisfzzT75nHHylLVxw3pRQiBjgM=;
 b=klcQMQ4gZjO9taC3Ll8E1ZnYdjps6GrnEkb+zbWMg/v8bCriT5UZ8kdsY8lHe+4oHM
 QBPhekSNPsWiV6DiCeNUbUMpZGgZtGTAeb892profmuNrdn9cWxUMrrkygZxp1hkW4Gm
 OSVt5O1wbj4KveKFbslSWSopcE7LvAWRzaRX0YOBs5qIZY/Z4b7aXSeE0RNbZ069Vfr9
 R/5YcX6Ov2Ohd67tOLdGghibaax6JtmY1kbkS7iKjz14ovVAGDF5pX0nvYpuP+N7sJsJ
 DVwzjx6o8uxejA5UwZdg5pxM3WsFAEVGhqgcXnWSXHXO8FEl9I6V6wUtbaX7eSVpsQCS
 KztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973605; x=1738578405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BMW+C7jqPLrnYT1UisfzzT75nHHylLVxw3pRQiBjgM=;
 b=lL9yvYHcRdSM1cITT5+u9UzEGjpNOQeZVqzDlVKIEJtHzmOzS2n+Kq60Pnb8mG5NC7
 +fM8903TR/iXVmQC9wFIui06Ezf2/APh6O7W+BcdW19E5sB8Yzin8dnWr6JqSw9Mtle+
 phJ7oee4Nu6+u1O3wMNWY6z6nbYjiEo9FcFfW3MOFirzCpsI84HmwYTebT2G/HAvXIxQ
 PWJQ5OJ9QayffFHMEJF7E+F58lijgo33rPzwEdof2RE/ongO/BOsPx9dEEUQLmoO1JgI
 9BDutS9ntoq6KvI3oFnY7826KEs5+VjKx1i+9txE4kWrJWvyCNLPjgAxcTqJcR5NkHpp
 VCpQ==
X-Gm-Message-State: AOJu0YwrY/VRhU0SfS5prUrUFJnQQrN6QrSV2MXj7d1L1sCPamqmWDlT
 zTJGWFyo8wD5B2LdQ+Qek+Zt5KbKJc6Wg6DKpIqC92ZJ4F0kuefR8XVedhzVJ2VayuUaezIDhpy
 4/ec=
X-Gm-Gg: ASbGncvypLkF8qRlv4w6lBBfrFycC5znJmwJNJMhXuUV2+eXZBzpAs9IfsnwVpjPa2G
 II7ufSo6J/h6wTEjJD7D1c5lk6B5BaMnWvN3xza0rMlrhf9DHrW5MA0/qRFxqHgKTGdH7Dxd8C3
 UNp8FZFR9wkITT5swgyRUFwAZaIn1ribaK7O+1RWPeOTiYA5UCkwpDWEKW/2IsBArCtkU/eEde+
 GB97gSBVLWlWDlLgiSN9B8diMe8+rkBwiUxw3xctmgG4ZUtS1Nj86JHmpUPPBL40Pk9hlU0BQZu
 F4+ad7HT01xIzLTBODUYPMcUPGoWc4eQFh36mRN0r6BoJp8DD6Z5gHk=
X-Google-Smtp-Source: AGHT+IGvGNTBxF0tECIn1PrpIrZxFIygS6t0G/4z47Sstwpd6opDtWXrnS/HmcAZjEWPA1G8F1oQCQ==
X-Received: by 2002:a05:600c:4f16:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-438914409dcmr310031275e9.26.1737973605443; 
 Mon, 27 Jan 2025 02:26:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d2952sm127789335e9.34.2025.01.27.02.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/15] target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
Date: Mon, 27 Jan 2025 11:26:09 +0100
Message-ID: <20250127102620.39159-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c     | 21 ---------------------
 target/ppc/tcg-excp_helper.c | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b05eb7f5aec..8956466db1d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -136,27 +136,6 @@ static void dump_hcall(CPUPPCState *env)
                   env->nip);
 }
 
-#ifdef CONFIG_TCG
-/* Return true iff byteswap is needed to load instruction */
-static inline bool insn_need_byteswap(CPUArchState *env)
-{
-    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
-    return !!(env->msr & ((target_ulong)1 << MSR_LE));
-}
-
-uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
-{
-    uint32_t insn = cpu_ldl_code(env, addr);
-
-    if (insn_need_byteswap(env)) {
-        insn = bswap32(insn);
-    }
-
-    return insn;
-}
-
-#endif
-
 static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
 {
     const char *es;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 3402dbe05ee..6950b78774d 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -199,4 +199,22 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
+/* Return true iff byteswap is needed to load instruction */
+static inline bool insn_need_byteswap(CPUArchState *env)
+{
+    /* SYSTEM builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
+    return !!(env->msr & ((target_ulong)1 << MSR_LE));
+}
+
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
+{
+    uint32_t insn = cpu_ldl_code(env, addr);
+
+    if (insn_need_byteswap(env)) {
+        insn = bswap32(insn);
+    }
+
+    return insn;
+}
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1


