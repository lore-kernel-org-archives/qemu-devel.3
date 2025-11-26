Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FCED11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM29-0002Ql-JU; Wed, 26 Nov 2025 15:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM27-0002MV-1Y
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM24-0002Kr-Hl
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so494175e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188551; x=1764793351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIPG/naiBj4JXek6sevzzf+dt9iCr5C8g6EGc2RUz7w=;
 b=ndFSz1FNhmbqaFgjHpnbdbmqyMLvsCc2i1k1jc8VyUvqkRScn9IZCvIgIISWLzJ5FF
 YwL9NRJCetB3Hk1iizW3giaWvn/4sMFFwD4xtbuO/oCR0lGPsA0PoA2N7rHR6aarmy9H
 IzJpLV1eOA/tWVnf0M853ADCU7tPecp3PWlSosE+Bsayf7qVaFPxKQKyt64AbCBrY5AS
 RzrUdqEdXgjvgFAHALd2U18kAv7BctBS/6GrkYWcsu3rs3IC7jaywuFkvWmudEmy8BAH
 jvD4PdtsqDTnKByAN1sHuZDNKq6V1VOwtLJJ1XAdGRMEILphOOPTCa24JbFm5wATEhwj
 TbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188551; x=1764793351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VIPG/naiBj4JXek6sevzzf+dt9iCr5C8g6EGc2RUz7w=;
 b=wJR5lPNyqteJLisfUlMWLm/FecYIENC0BgQtjrw1D5wB2w7xdxcnKk1Xj5vF5+D+rn
 Im6JKdjuT51s+hzYDCpo6BCVmzqmCsklerVltnz1yxLDcYH8OI6n1AVMYrBSBm8oSCc7
 uO9zy1BBqgfcR6GQjRABrtZyulpV0mNAFzEloRmmjmBPYXYqY+vZec97C9Elo4G9/mmM
 hhEr6tJ8WJDYYynD0spndKKcuPBXWeXKT3lGw4Ux9lxTYDNbMseZpzVsfJQODXdI5Hxe
 qUUFTzC0h4DXzvfXnLgajjoOJLvmY/7ilxLqH35ff9J+G8/LslWQ8bXKyUUNZXTZ+Srj
 ezoA==
X-Gm-Message-State: AOJu0YwOju+V5UvsTK6Jgr1kaH2xpGaiYyBucjkbMgxbSZy+fA8Dc6gR
 Pnl2a9WGTgJ6pBm8kUDNyDOEpvTyU56WFQL9E1YuZM7jZOEn5T/dQC6JFhwkh6kzGNjYnbsbH6O
 HnYJy5vG2W0G9
X-Gm-Gg: ASbGncsNDLnPoCn2ub4RTEYyAO8PR67fBi9Y0HYHKTCmiKLZjlytXGG/9k2nfHixOMg
 RNAkZeDCFpvSCor/8bva5+6ykX1jUR6wacSQVa2r+Np7YB3XY7SrgSFq8+R9iLIJvRdcdujCtWs
 I6OEmKXw07JEcW6au9CbmzdV8FVRR4oCWh6Ad9GgAxa+Lk3Ove3gdM8IpoSKDqZoRa2LovZ3ax5
 BclR9Ss8AAD8h0bwetxv6sU7JwQpJXG0ULndPL0fZ0rEF34Gm0SgXcgzeSqN7LLzgDyqSZqxK0g
 qH52tSbYVFBpsi3jljrbLAOC2dlXpeaPnRS4gB5RbX4YCC4p3ICWHRbiztBiFJB+6JS3pOK5sf7
 6vATMkhOEOWEKtHDeNEEGFn7M3kaxqwmksEJn2Pus3zR8KFAdXxIEnb+uhx8sAranyn/wXoSHJU
 sCV1CER+eK0cvn6NLX9pHSvUamsfT4hP6vCZ4u3jtQG7eQfu+7jYyq7yGf2Veb
X-Google-Smtp-Source: AGHT+IE+J4hkPc+qoDBzLlo50hXYN9XPtG+xb4Q3feL46FZeUSlPs/IpusCjFjCSzhOQ7W/cwQ0vJA==
X-Received: by 2002:a05:600c:1994:b0:477:5aaa:57a6 with SMTP id
 5b1f17b1804b1-477c016e402mr186697295e9.10.1764188550847; 
 Wed, 26 Nov 2025 12:22:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f49a7bsm42205519f8f.19.2025.11.26.12.22.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH-for-11.0 v3 04/22] target/rx: Use little-endian variant of
 cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 21:21:40 +0100
Message-ID: <20251126202200.23100-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only build the RX target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=rx; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/helper.c    | 14 +++++++-------
 target/rx/op_helper.c |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index e9a7aaf610d..83cd491eb4a 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -68,10 +68,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
         qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
     } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        cpu_stl_le_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
         env->psw_ipl = env->ack_ipl;
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         qemu_set_irq(env->ack, env->ack_irq);
@@ -82,14 +82,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         const char *expname = "unknown exception";
 
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, save_psw);
+        cpu_stl_le_data(env, env->isp, save_psw);
         env->isp -= 4;
-        cpu_stl_data(env, env->isp, env->pc);
+        cpu_stl_le_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         } else {
-            env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
+            env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
 
         if (vec == 30) {
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 2b190a4b2cf..ca3e9e85fc7 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -217,20 +217,20 @@ void helper_scmpu(CPURXState *env)
 static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
                                      abi_ptr ptr,
                                      uintptr_t retaddr) = {
-    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+    cpu_ldub_data_ra, cpu_lduw_le_data_ra, cpu_ldl_le_data_ra,
 };
 
 static void (* const cpu_stfn[])(CPUArchState *env,
                                  abi_ptr ptr,
                                  uint32_t val,
                                  uintptr_t retaddr) = {
-    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
+    cpu_stb_data_ra, cpu_stw_le_data_ra, cpu_stl_le_data_ra,
 };
 
 void helper_sstr(CPURXState *env, uint32_t sz)
-- 
2.51.0


