Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BBC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSQ-0006vJ-7d; Thu, 20 Mar 2025 18:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPm-0002ah-FO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPO-0007Bn-Ex
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2239c066347so30586965ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509834; x=1743114634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUQD3Wdd1LujT1Sus7xanYZ7bZ9IH7iAgdXy0WNcaNg=;
 b=nbFQkTQ09JLbQTDgufOcVphuPbuzX+jiAQGVu2jxUTt3NOvpg0nAOoQRtdSTmH8Ty+
 G/hA+gUg5rnKCHUiZWkJttgTcJ6E5MOK1gJY92JPdsy2pPRPqLpfzlCGX98rf+7nTzu+
 XD53t1Kr70Je+DkWBz/qnXUUSUsfxqYmxqPw0HXDOpT1+lZJ4j94rTxAXvasw+2VFh4I
 SKUOFytbRs8Z0t1/GBKuaC+AOKNBn/cx1K67w1I7/+yRD7XguH2D8Pfx5CsDgV5l4hZ4
 hQxZu4UtDytksEAhFm4jI46bdxZ/KVKpPJIp15nUNg7BKSAgoT1n1ZyRjs+7S5L8KYoa
 6ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509834; x=1743114634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUQD3Wdd1LujT1Sus7xanYZ7bZ9IH7iAgdXy0WNcaNg=;
 b=BF08mP2vhn4yEpH7ZuSiezEjWXutTeueQir7i/zGByqZ1TmzNITG0e7rDRUvM3QxLa
 aMQgRYXn0QeqQZpC1p/POdPFzBNd23v0GD9qeEosLXn1Fp7jaiaz2OXxAOPZNJZLcvJY
 33Q8QYdjeVxGsxJEOvLyCMXti9Fkp6NNay9wQh5P55JRtElNkqEKHELC4N1KiLonakXx
 zjO+qxq1yM1DHoF6y4LWVt75MpB7ku0mM0noiXzd3AdC22Pq55iSPUe1GH3CtvVO0VcG
 juwqf7zxjvpLYK0Z+B8LRIoz2HuQK4LtAhZXkWnlKcC8ADI83J2G4In5ftr9a69sflmP
 C27g==
X-Gm-Message-State: AOJu0YxmzXWXHbA3C2I3qZsx61/41j2RTpNYve+AQZ7iR9iXzcPhYv1J
 0CbNTpt4mpFdiCg63yJk/Y8RmGwbBI76KldlV+5lkhcBznK+bnFaTvHK0IzAcjt0HC3yXsLTnMb
 x
X-Gm-Gg: ASbGncuHS94pZiIFkyMOdO8nnuBMeOGz05lzc2+RVNijWTJhGhcP7+wqJt25E1JNbnH
 ORYEkXwhUjfwiKPRJBq+srJmLF4cLuMNTNEjOKz0ntdJ50khPjb7tztLq2XRjuR0x89+1SnTKX4
 gqYwr7yFC74ML7xcxWyvhHGOkY7tUDftkwou2A1+KXCi2Qto89VXrbjlQfKVM0H06LA2xoQKcWU
 21YQUfspJ5Ce5zQ5OOYnYcnswGPew/TZOPam7ETW288zN6Mr0VA3U9fAWfd1ssLuDtW2EKVO+27
 BWcYYCjfRvTuVaKkzwYOzP16Zcf+RYB8WsMnD+HwiOKvvwhZ3u2Y6bI=
X-Google-Smtp-Source: AGHT+IGlfrWg0bBEua+CzOZalX3WCoH9cy+wc/InKanm94Z9NrDL7g5YrDWENrVtS87EAmZz7TQInQ==
X-Received: by 2002:a17:903:2284:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-22780e5ffb1mr15478685ad.46.1742509834560; 
 Thu, 20 Mar 2025 15:30:34 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 23/30] target/arm/cpu: remove inline stubs for aarch32
 emulation
Date: Thu, 20 Mar 2025 15:29:55 -0700
Message-Id: <20250320223002.2915728-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Directly condition associated calls in target/arm/helper.c for now.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h    | 8 --------
 target/arm/helper.c | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b1c3e463267..c1a0faed3ad 100644
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
index fa23e309040..73e98532c03 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6564,7 +6564,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 
@@ -10648,7 +10650,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
+#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
+#endif
     }
 
     if (cur_el < new_el) {
@@ -11665,7 +11669,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 #endif
-- 
2.39.5


