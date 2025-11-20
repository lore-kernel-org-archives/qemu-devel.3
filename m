Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899EDCF9C7D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8wK-0006rh-Im; Thu, 20 Nov 2025 12:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wI-0006qC-Vj
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wH-0006yg-Fy
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477632b0621so8401495e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763661563; x=1764266363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EctDLYXHneCSbnit9AgBWHWi2e7ESBxD60JGtambQRU=;
 b=ibJDPCeE5luEjrKvlJ3Sjyp5ZYr+x7j7sMwgcqtACGE0NVqZh/gIeM3A0oJISZq4Fv
 6C04s4Xmbs1Wul8jfYdVDzfheeb4at9GPd7TcKN3G2O6KM0OF2zlttCDYIlgAIfw2b/U
 DJO1eiTFeSy40rth66NalY6keVlBLfTMo8Rha+ncqnDSEyes6NrIuFCrYSuCoOzEiBZm
 lV4/wE6tfeg6jWzogF5IgH0DAQFtYu+XeaA+RW1l8OLJxY7ZyHDm/Rmj87Po0K7jmweO
 jzdSIkybvs4TCOFxgCmxK4GEY1yS8cHSYxzfloXaM7hWt0+SkDQ+lGRAqZuHkwul1q4u
 jCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661563; x=1764266363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EctDLYXHneCSbnit9AgBWHWi2e7ESBxD60JGtambQRU=;
 b=loej47bxuN0wDXyuqv6sR97d/eaAYWDnc1wuNh242y+QSOj0HfVTJctXMJJwymGAzL
 ieuHKWnB2E1kEU7FYKu41fuBT4CqKGoMTNlcP4pwOdiM0EtwMTD5FK8pd3bwM/MGRxhF
 J6ia0glVkVAnWlQrSr2uEBxfBr5LOyz8RIXjrBfOzsAKDd+0a1E2Pkv5Mbz3D6BcBw+H
 Pk6kstEjd0oyqXLQhvnPAvKE9MreP3ffRmo1oUihqeEmzWTkomdyYTJHtyfhrpJPlDWu
 OqqDSsUgPl/0msJoahu/tRX8Y4AYzfRyO1epNGSxdIw3MEWumdpasKDE3++NpnqUJ4vX
 NGRQ==
X-Gm-Message-State: AOJu0Yzq6KnAsxeZaFcUBFLd65enr5hDv/v00sdrB9KB40aRR+B1aftb
 5akAdCs9SPhKhy499KYgEv37UjLppyWR6uLCQvJenizppjCD/yBVq3OPMUO3KC3o19J9t80BNqs
 7JEvl51j8Wg==
X-Gm-Gg: ASbGnctBdIFdn/uYDLwaEDUKUxAH0IU2NFeMAWBIWP8XyKGKDZ4iiXP8s0+XAaSGrSL
 2bRzPlbsHdoZ/GqLNwLQMug+39nrZDWDDTqSNnL1Dr8dLBBYnj3FWVk1xJucNrcKOfLhCfjIfW+
 NPvBuwPDNIXDZjYGNi0WDJ3Aq/OZOkzUrnwb8kyY662dxvrY1bIKCnvM6AYhti+7MhHmQkVlvoc
 Tu3XaWtXt2hzBWMXcEnF/nHifN+AV3GkS5I7+n/Fy+csbTMwpo/QyHLmTQOeZQfVOsUrgHIStKT
 L/9oTL6ftofaka+4+ahjLtt/+AUxTRgBK2DVNdBd2azByUPhYhoNqq5/d2cS8+BY60MHr+e7PDa
 p2m5vR7dn4MMW1B1qersCKEsrtaRehgOxoCkTSmxqQ3gwWPgRvZkvZmokD9fkl5VBNB+Yb59RqB
 /6GKneOeWIDUueq9eL7tOHnCRX32I6HLD2zcPdk+BRPWvWmj8hQyd6ToBy95RJqf8vLMNPNbE=
X-Google-Smtp-Source: AGHT+IFGNX+0G/mPk+Y5npk6yjXlbh0i5nDBV7z9KOCIHItBvpAUwHD1RjcnlzfXyUmgzFC/+OQ7Cg==
X-Received: by 2002:a05:600c:190e:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-477b867184emr6545485e9.7.1763661563039; 
 Thu, 20 Nov 2025 09:59:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a974cdc8sm72988995e9.2.2025.11.20.09.59.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 09:59:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 1/5] accel/tcg: Add endianness variants of
 cpu_ld{uw, l, q}_code()
Date: Thu, 20 Nov 2025 18:59:10 +0100
Message-ID: <20251120175914.6515-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120175914.6515-1-philmd@linaro.org>
References: <20251120175914.6515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Allow target with fixed-endianness to not use the MO_TE definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 43 +++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..e4ec4e7d367 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -481,25 +481,56 @@ static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
     return cpu_ldb_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
+static inline uint32_t cpu_lduw_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUW, cpu_mmu_index(cs, true));
     return cpu_ldw_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
+static inline uint32_t cpu_ldl_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
     return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
-static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
+static inline uint64_t cpu_ldq_le_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
+    MemOpIdx oi = make_memop_idx(MO_LEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
+static inline uint32_t cpu_lduw_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUW, cpu_mmu_index(cs, true));
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint32_t cpu_ldl_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
+}
+
+static inline uint64_t cpu_ldq_be_code(CPUArchState *env, abi_ptr addr)
+{
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_BEUQ, cpu_mmu_index(cs, true));
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
+}
+
+#if TARGET_BIG_ENDIAN
+# define cpu_lduw_code        cpu_lduw_be_code
+# define cpu_ldl_code         cpu_ldl_be_code
+# define cpu_ldq_code         cpu_ldq_be_code
+#else
+# define cpu_lduw_code        cpu_lduw_le_code
+# define cpu_ldl_code         cpu_ldl_le_code
+# define cpu_ldq_code         cpu_ldq_le_code
+#endif
+
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.51.0


