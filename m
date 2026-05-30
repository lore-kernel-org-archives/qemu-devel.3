Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6973CD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSr9-0008R2-8l; Sat, 30 May 2026 19:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr5-0008Ph-QG
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:37 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr2-0007Ma-VU
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:35 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36d6bb38b44so395492a91.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182752; x=1780787552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfTQIO3Td5ZnJtjFXmscxPDzamgvs+aWLTRE3ZdC8D8=;
 b=bc6pqyPdhwix//MalUMbWfv9uSuxUubjkURyV2DSU1Sn3f7zlJO4wFrEuXIvXMquab
 AzNY3nABKOV7FMb4mn0U3uldzFSiE4pbYExYhamQ4dySf2EthwkZp8pTfl1CrTFAPjC+
 9mNomZex7S9S6HCGwAA3hDjUh2dbXg/jaXlx61xPlcVlLEmnSJwoDxnEn9aqm4gx7z38
 qQpHFa8OoVIHX+W/hC9UWTTmmtWXRVgxz3F8nsz2k6jPexTWnHcri18WrfD0t9VYTLki
 jjGtgXwB3/7oVhtDfUifCWho68oSnm+QdYeyc7P3ggTfGRannBo6dvjc0Rx88VKohkhz
 HIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182752; x=1780787552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dfTQIO3Td5ZnJtjFXmscxPDzamgvs+aWLTRE3ZdC8D8=;
 b=fsEOamW0dZAcXkUCnZDZhkVl35N/bpd88kolmXyW1y2gLfz1q6Jdp9PgR7XUXBBy87
 X10DFPwRkFYDos0guvfdtrjcF2MdDGIzH2Wk8Ikam0RR1Ovs/BerHyCZ053WBV7o0BNT
 l4GNFoAQ8ot1i4QpBycEAft+ymkVC219cV4ZaWEy95ON5+dwQCbMI0pKuO/jZ6Z5F4jH
 iqoIbUNsZCm1B1L4F+PN0jtWgBc2WoMCEUchqrTD2x3cfu5SPc7CX3ZZSLqJ/NtDddna
 1kRvSTm1hT798Qdsy0cj25dF1FHXZlj2rs/ZfmjWxOWICQyKRP76kWi0f0d66ngnJ8BN
 VyWw==
X-Gm-Message-State: AOJu0Ywu1GCkIVIQN2lOM3bQ6hJLdp2y//cyIExkxtU9+8Vu1lg1SD2H
 UONJEzpU8TC6wKJ+5XN2YY/vGqjUItIe06XQJ6yL0uYDX8vFH/r+eD6vFVLTlUsNbHbcL4v8a6e
 xXIT3qc0=
X-Gm-Gg: Acq92OEYfq/O7SSA1QlUICGqwx27hCypTiREgRBZVbCkZmZxNYsxQpmmO7Fis1zEjgp
 aVv0Z0T140rhVWOTmS1YipCBnqd8DnJ9S3ZmlFfO2X4/+779Co3J9lX8Fw4X0yedera2fIHjjsX
 3rmQ9vR9sl84/HzJgXPGYly6AL36kG+yW8uBLvV4j67347mi64m+4uvtijxN8TcOTBhJ+BmgCFS
 ZqU+WbnNZl6xMxo/nCNkYNaDa0IlGSBM+4jW32EMUiFX/AJFUSXR32cJGPrlh6wS8cjQFW5+c6f
 XrH7utc7OjH5D5D1nCvC9EiC2YnY2/TLnBwWC2JNWJqxlBIwkxKBGjrIWoNMPW1+6cVbyByPjNP
 B6BtIMPSukeCGOFXw1gUedgknH4toXGVcXq/QZWgv/+F3IDkohcjC7nzI0i25WOI24bx8IhUPDN
 gpwWnEZ40WJZw8ohz+2QoNZ4uzCmXteIdcI5c5M8g=
X-Received: by 2002:a17:90b:2f46:b0:368:a297:bd38 with SMTP id
 98e67ed59e1d1-36c4ff3a634mr4539942a91.7.1780182751649; 
 Sat, 30 May 2026 16:12:31 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 01/41] target/arm: Introduce arm_init_fp_status
Date: Sat, 30 May 2026 16:11:49 -0700
Message-ID: <20260530231229.400441-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Create a function to set all default controls for a float_status.
Other settings for specific FPST will be set afterward.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a13e6dae2a..b75c6a6622 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -304,6 +304,13 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
+static void arm_init_fp_status(float_status *s)
+{
+    memset(s, 0, sizeof(*s));
+    arm_set_default_fp_behaviours(s);
+    /* We want 0 for all other settings. */
+}
+
 static void arm_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -626,20 +633,16 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
+    for (int i = 0; i < FPST_COUNT; i++) {
+        arm_init_fp_status(&env->vfp.fp_status[i]);
+    }
+
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
-- 
2.43.0


