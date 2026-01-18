Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773B4C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYZ1-0005uz-Vy; Sun, 18 Jan 2026 14:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYw-0005ou-2C
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:51 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYm-0006ey-RX
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso23517225e9.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764939; x=1769369739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCCB9HNX1wAOtME2z2I9ds2IWShnOrLBot6ZnveN7zw=;
 b=ts9LNirTqncer6PF8MDXAW5GtSEEKnQZSEN/csON6EujCtXPJ6SCY8B+vvF0ryLCf5
 rKYXxjjWo9540rRAvUrcBHPkSGGtW5FyHefHWhQa83jCTS4JThLBrpNJ5ViHtnZvwzIc
 Q+o0yx+fj5xENXRHRSOziEQlPWLm3KLG5XZjj4J6IzcYmk125N0GQnbZ6wiKEFr+R8qH
 34p5z4EbrxOMb7xx3kNOGJEwx4U2i3A3Y95I0aEYpMCdPcOl+Sm6PEx89z+wBgmr1fPu
 XJnR4VwJ862zCGaZxiEQv9TXCE4i06dNS5TsiFoS5NSIsfclrWjl8JhLc8Skjn4nKQMI
 x7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764939; x=1769369739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCCB9HNX1wAOtME2z2I9ds2IWShnOrLBot6ZnveN7zw=;
 b=uVnba1RrO6ZZ/kWIj8BTz+vTcozxs63L5v9vGgoStwlJYkFCCV/c1ibH2+naaPVgVo
 fhXBlVBCrwFPTTB7juD9zwP2LUIiicsRM+3NLfqjZv4VkJF3CsDIQ5J3hFRNLyHL/FQA
 cH+wKztz+PDOsDgDVmQ9kVcEDLMucQaBrY9XDTvVHAC7tngZ4N66RzaHGPWEokfMkfi0
 2Didxk0/6xBbgm/K2zO76jnyeWJ98WHbuVv+yoGa5FgZEG8LYnsqijWFBHid4c2+nB65
 CtKwwmIHbUl8Sth1/R2xv9VP0z85xYauMCOa8K6vKhBRu927XwCN34fblmTOYLiaCDsL
 V7mg==
X-Gm-Message-State: AOJu0Yx6Y84u3Jq/w8NNMy41AGD20bAbxMbEmNAULyydtcXsamwNR6Kk
 SpBLldX3snEOfkBPqZUozI6nIG5LjZBB+QUFe4kAYuWmF5AlID/JoLisAN/4Ac395KawA+nti2V
 NCcjDbM0=
X-Gm-Gg: AY/fxX5gLXlU8k8mYcblwvMh7+estVhgHhOivfLGgU3kBS7FNRId8caXc1/Yw4+NBGs
 ck3yP7hOvejFvQli44X6n//JFghZ4PfPMkk2JUt/vdd2oslyFo40jPbPHDiyLbdUszzngq90p9X
 6W9gXceRlkbeNEWUvMD1Pr0KECsqQvHxG4ux9WWXSXj0OrWrrcjAPUICiGb1XDBQ6z+xJ4yRdga
 2C7G6vrzWV8jS+njPqZ6hoiCBKBxNq9YK6HYD/U2Jg7CpwDB4i+V/o+vbGzxMrG2UKmLjnMxGXl
 G5FQcOWhn5ESliN250EkHL0QbvR9sqrcls0aXLUQR10YOIsMdVlUmm77jlOuyN19ivG3FGPoN3d
 oL1M1wD6LwZe92nHhwAOR3ElvdqbEVo74TgUIkX+KJlbaz/tQLsHg5ugpDg1m4USbvu2bpz2GwE
 NjCcG7TLnmPPKzDkcfrNwDyARUhly5bUFTSY/t3+doI/xuXUef7a8glwII3xkigBx2DQTngdg=
X-Received: by 2002:a05:600c:8b2f:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-4801e34f952mr101625605e9.33.1768764939062; 
 Sun, 18 Jan 2026 11:35:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2c2a2sm63720935e9.10.2026.01.18.11.35.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 04/18] system/memory: Introduce ldm_p() and stm_p()
 load/store helpers
Date: Sun, 18 Jan 2026 20:34:54 +0100
Message-ID: <20260118193509.42923-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Introduce load/store helpers which take a MemOp argument.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Possible optimization:
https://lore.kernel.org/qemu-devel/546f3a4b-64ff-4f63-bb07-f5cb52b6c64c@redhat.com/
---
 include/qemu/bswap.h | 72 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 65a1b3634f4..387d65c0b0b 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -2,6 +2,7 @@
 #define BSWAP_H
 
 #include "qemu/target-info.h"
+#include "exec/memop.h"
 
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
@@ -375,6 +376,77 @@ static inline void stq_be_p(void *ptr, uint64_t v)
     stq_he_p(ptr, be_bswap(v, 64));
 }
 
+
+/**
+ * ldm_p: Load value from host memory (byteswapping if necessary)
+ *
+ * @ptr: the host pointer to be accessed
+ * @mop: #MemOp mask containing access size and optional byteswapping
+ *
+ * Convert the value stored at @ptr in host memory and byteswap if necessary.
+ *
+ * Returns: the converted value.
+ */
+static inline uint64_t ldm_p(const void *ptr, MemOp mop)
+{
+    switch (mop & (MO_SIZE | MO_BSWAP)) {
+    case MO_8:
+        return ldub_p(ptr);
+    case MO_16 | MO_LE:
+        return lduw_le_p(ptr);
+    case MO_16 | MO_BE:
+        return lduw_be_p(ptr);
+    case MO_32 | MO_LE:
+        return ldl_le_p(ptr);
+    case MO_32 | MO_BE:
+        return ldl_be_p(ptr);
+    case MO_64 | MO_LE:
+        return ldq_le_p(ptr);
+    case MO_64 | MO_BE:
+        return ldq_be_p(ptr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * stm_p: Store value to host memory (byteswapping if necessary)
+ *
+ * @ptr: the host pointer to be accessed
+ * @mop: #MemOp mask containing access size and optional byteswapping
+ * @val: the value to store
+ *
+ * Convert the value (byteswap if necessary) and store at @ptr in host memory.
+ */
+static inline void stm_p(void *ptr, MemOp mop, uint64_t val)
+{
+    switch (mop & (MO_SIZE | MO_BSWAP)) {
+    case MO_8:
+        stb_p(ptr, val);
+        break;
+    case MO_16 | MO_LE:
+        stw_le_p(ptr, val);
+        break;
+    case MO_16 | MO_BE:
+        stw_be_p(ptr, val);
+        break;
+    case MO_32 | MO_LE:
+        stl_le_p(ptr, val);
+        break;
+    case MO_32 | MO_BE:
+        stl_be_p(ptr, val);
+        break;
+    case MO_64 | MO_LE:
+        stq_le_p(ptr, val);
+        break;
+    case MO_64 | MO_BE:
+        stq_be_p(ptr, val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Store v to p as a sz byte value in host order */
 #define DO_STN_LDN_P(END) \
     static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v)  \
-- 
2.52.0


