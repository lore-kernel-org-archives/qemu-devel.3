Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE71C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSQ-0004DL-HT; Tue, 22 Apr 2025 15:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JPB-0005iO-F6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP9-00078H-Di
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso62424675ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350538; x=1745955338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyzHc3eX2pZAMrT5P/TXvsGD8d5rYU2E84wns2dz+CQ=;
 b=Wo9Z+aNj68uKrR/B0VwBKHzABTPBmT8t+MkqDzm2xxpeON70ZmDtbnGuSttKcovXIB
 ELyH9s+n7iTnpjzbC+1MmiNuaD/lpMCVty8uiWapA6Ldv3zdyWPjtGOYnX+8VINo4lPt
 4uAZfyCfwW1/St2Jzv5HG52M4N6YinCl71DsZ5z0KobjyrrtiUTKHxlhqhIxQYBSU6Vj
 FdUq0MYOlIJ7HKL2cudgFtzksqDIYlOz4heKP9r4wamjDeaNt8lPTWed03esFeXsxwmD
 DSn9+xSotKrmcseQ6BWKnNVvHxwZWQukS3KVdpFL3CJkgUS2A4a17wAUIYe9dE8m2/Uh
 jsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350538; x=1745955338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyzHc3eX2pZAMrT5P/TXvsGD8d5rYU2E84wns2dz+CQ=;
 b=iwfcjh4urvt3U+wESuaYbSN0Z1Y2qTOC5JVxqzGMQ10i2F3Q2M8fS1y+UAlxZMbd1d
 yklaCbAtRJ4CZ5i+sqML4wsyfYLmgqegQlMD3/5SnURCyOoHJcweyCUupzVp8+I+PBSf
 HgyvdFpNoIrryjeD7aNF9WLqr5vh95dfp6j/IkmntLlhptLpifZpgw6AXPpv2ywciAwJ
 FV7GwA6URxi9P7yfJH/1xbd+g79AD6wTr8mg2qoRh60dfYPogFGlMWpfyTtOdaZIIdCp
 mkSxCRAt7glgqHPI8YfJdCeKN/26YX21JC3u3NC1QJjGl+kh/j9fWnUEVnsBiQ2uVU98
 DxRg==
X-Gm-Message-State: AOJu0YyX6taS0LQhYuj+rf3wNBF0rgGwP3ojr5PXtuVuH7XGJ8tOlMFJ
 sCIRphQ01/Exr6W+vsswS09mMeBkLsdUgqy0J/eZc/dOh1v9GzEELgp+BZuA3ycZ8ATVYBf8n0A
 c
X-Gm-Gg: ASbGncvec4Lu7mKn/OoSNNE0OSyVTbMBS2pnwwJ9JpZHonfdAmav6GnxchUBAokm4Ap
 FED0F/C8ZyDAJ4I2h60qpGc0XdSdu7CnkJO+0rdRt0zziY4+U4iezKsDdd02QNqVMmWEgV+LJVW
 3O8Bq3xYFf1otf1Htua4+pFz8W7ypJ92BeUcP3kDPwyMIPXT6eLDvZQzSJLqPVbgc2ql8H4xHJM
 e5LhQhR7Gm7c7PCURbk4Prcp04ZfnLK5wKq4cCdqWyW6bVbp7nDZPElrx15MEVd2upGe+ahCZf2
 0qQgHNgT2vICsxK8HLPFhxFwuSLaD1fAtGCPX4CBJ057a/1eC5z5dZBpFL5eyPauCK07k7WlDC0
 =
X-Google-Smtp-Source: AGHT+IHyjz34D/p+lGTiMsm8mtZUPTaTQW0WhL3c3tCwHq71zhz3KgIrUF0n9nFmAyF1bh+JwRFTtQ==
X-Received: by 2002:a17:902:ea07:b0:227:e6b2:d989 with SMTP id
 d9443c01a7336-22c5362e557mr248884745ad.44.1745350537912; 
 Tue, 22 Apr 2025 12:35:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 118/147] target/arm/cpu: remove inline stubs for aarch32
 emulation
Date: Tue, 22 Apr 2025 12:27:47 -0700
Message-ID: <20250422192819.302784-119-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Directly condition associated calls in target/arm/helper.c for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-23-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h    | 8 --------
 target/arm/helper.c | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b1c3e46326..c1a0faed3a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
  */
 void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
 
-#ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
@@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
 #endif
 }
 
-#else
-static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
-static inline void aarch64_sve_change_el(CPUARMState *env, int o,
-                                         int n, bool a)
-{ }
-#endif
-
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index becbbbd0d8..7fb6e88630 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6563,7 +6563,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 
@@ -10628,7 +10630,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
+#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
+#endif
     }
 
     if (cur_el < new_el) {
@@ -11640,7 +11644,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 #endif
-- 
2.43.0


