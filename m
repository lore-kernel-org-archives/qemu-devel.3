Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42055C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvy-000330-9b; Wed, 23 Apr 2025 20:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktl-00068r-5r
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:08 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kth-00059y-Dw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so371207b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456220; x=1746061020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyzHc3eX2pZAMrT5P/TXvsGD8d5rYU2E84wns2dz+CQ=;
 b=cngk6n/JfaZLLyKI1zHqugNGu6mtJdocYayHtMyrsyzvrCWaHdBhX3mpE7X3zvjhf1
 RsXJq2i0HxFRnB+gZ3cjnIRLwvmtfTCv6uJN0V/OCrCAcLzzlvvX2QKq44k94zwraADw
 j3+IRaCsvINQ9PGhumMCcaIwN511VRggr01fmPDDkqsEkZ9QvqTqcPKIC6ecMkzuYi8n
 9VNcSx5m++ZqLx2auEW3SCSFFg/l73w6ZxJvCni7sKgCIb7aH0ImAQpVlKwa5qktJby7
 u8V1O+mhvKwEkgGH5gPq61Bsujm9g92rPlZx+Qu/eSVtNZjCbPS7kQ9OkbTX0B+sJfMr
 9saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456220; x=1746061020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyzHc3eX2pZAMrT5P/TXvsGD8d5rYU2E84wns2dz+CQ=;
 b=p9uIb5zs2fkY1SzUVDUfU51vDnaCfJaBBUUh001SUeBY5mgLo0LJoxpvSM6cyaSc6N
 rU85xqlyMDpKmgrZvUAm9DGOcImGc2T+IFfGn61e0Y4bTXpznx7U842t9TzGTTw1LTOW
 VpoVQYA6m/ZvM3zVijL/jMUVMp8+gPaDmLu2PF+FzcY5v/5YGYZIseTGRj8H9tRuHkJz
 ng9yEoCiIhueX6gzzEL+ZNaUaOjQ+QtvaGNTnKBd/H6YTbfU5jvbEelHuH+HUiirv7iw
 KPc3q7PHZwdlMSIhUTA/4kZIM86L6yfltsOtzuh0mAp+N79XAS2hHRlk9wLTw7RockPH
 e3Vw==
X-Gm-Message-State: AOJu0YyyprlYF/jswBjsJ3o3zzOgMII3VxReMaQ8CSPqY4qTS9yxn/vn
 Gkxko+d25gs75cXfYKXEnA3AGRwVhKr+M+nR9nQzZgctxi9FQXkoyPThwUy4ZZTHDTBmDc8UYaI
 N
X-Gm-Gg: ASbGncuMZE+hJ1YAokha+aPCMlWaERWiyev2pWCehufB8MfLs6iaqv+I8xC7NEqlqTu
 J9+/vcMYM9SPlWxBE+aIoWhx3Rkhhar1arDZJyamj3fDprueBQPXcQtSQdBsjtS9WRH8nBUJq2v
 HjRUfv4TZu9AzVLiUvRDQILgh8x4T7mKu/5pSVe/P0ionCOq879LeCH+DfhD1oOHJgLqjtGatvY
 dp/zJieO3IVj8eBVnllb0iiW8Llmt8qQTtETlUTwUzAYX1FSa+kOA+/Gu9Jecxme+8guhcezYIp
 GaiCmFcuD0Q0kGjUHgXrKVhhj7UtnfmmTrW9BqkBtbWI5ozAwhUg2q8xuV1gyl0FlDYmY3+CnJM
 fzPrDiFVy4A==
X-Google-Smtp-Source: AGHT+IFJjoErT8TVs1vau/YnUeQZjXPO5B9wQUnJu8q+PrgZ5U0f0ceM55JuAK4R4eGM4bM9eMd6gQ==
X-Received: by 2002:a05:6a20:c906:b0:1fb:e271:82e2 with SMTP id
 adf61e73a8af0-20444ee7ff5mr793375637.11.1745456220111; 
 Wed, 23 Apr 2025 17:57:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 118/148] target/arm/cpu: remove inline stubs for aarch32
 emulation
Date: Wed, 23 Apr 2025 17:49:03 -0700
Message-ID: <20250424004934.598783-119-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


