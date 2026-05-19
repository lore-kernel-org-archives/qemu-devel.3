Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F228BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDl-0006kF-IW; Tue, 19 May 2026 12:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDh-0006ib-Ti
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:01 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDf-0000l3-UP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:01 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1809566fac.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207779; x=1779812579; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tJTOJpARwPfc/tocOh1bggQi70PenUs9b33stQ3sgD8=;
 b=V5jiU1g8LfUnOQl5UEHRz8thQw4GsDxPhqD12xLeRxWBt9/NOn4T6+wZbdN/gOPB3r
 C2gzI6YFyI+THvYQ2+VTGdfgs8xe1NgXXF1nS6erZ4qfELAw8iQQxJ42hUG6HuPoKHRv
 a1UEUTKIxGzwOnskW3C742oOzhRqQVteBLYvPQG1mJvK05KeWQ0IG9fp0XibKHoec2OS
 i759oU8Wxw2GUvQBw6Na9St/M8B4PA473ssnYG+37piNvLz47bRYxnrTBvl/CkiOM5gC
 HhJwVUNrj0JFevdgGiwnp+biMTZYgcDazB5J909wuYAx6M2rrYalF09tPbmQ/vuEpt/K
 tKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207779; x=1779812579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tJTOJpARwPfc/tocOh1bggQi70PenUs9b33stQ3sgD8=;
 b=rmqwqC2/HX+894MjPUwn9jF/xnP75WFMY5jhQ8WD9omjiGmNS2jW+/mLc4IPUzRa5I
 kM7aMLXwZcWLBD3yP/I5a+fWfabWj8LHyDPGS7/raX0MZi9B89n/Rt6o4649V56jAS6S
 etJ7nc/I8DOrt2MSYkGfm9iVmkMfV7A/wY7LeCRKHiyUldZfTuWGLhSsgu6diZeEQbRc
 9Sv6TjgFvvfr8kndDL7N6rlZGOOfa84uVkYplQURZ9RAiw+0RxqjSTK276D8QuaYf+to
 YPOgxeo5+/zeUbvSuj2QEX7AtuyD8boENYrPp2/eQKMfq+ZgBNwK4EoRLKX4+6seWhuR
 1KMQ==
X-Gm-Message-State: AOJu0YwVWBrUCJzAi2gbdJ5PeDPFMsRZYTIPkdwphm5OskGGv3OFgZys
 kYnizEQqlynQp8yd+rq9Xuc4ks6TegbC049djVCFVsAdQMuskFWkYSCK
X-Gm-Gg: Acq92OFKcorMmvPlI+Vk2s3hQjS3a/kkckOk/OuD+iMQOtADavNWH5yrgp4uPJk7JM1
 2C79yCsq54JViwMQeNdi8VHiAcb5G9mCTg/jEYcxlMZ4JXs4SPtBnAEy82k8KZoKdBXU7xOnF1Y
 rcVPQ2TGHx2Bsuk0T6hkv1XoMSncN/uTeTUu8ikZ5TcYaC6FwJe167IqGdbQHfelMh1aL9yc0Zh
 fNKJPIbEfcY/Np+3bbwpWf2rbqN5Z3Y2LtlgayuI92raynn+BWev6Z8fPgcuRNEKqinpsA1/1yG
 iqXpNRbtVXpIu/TIu+2aGwmIjPJFdmHaTgjMy8FqVYbwFZziYZMyK9v032sWeU1wYuwO95uJ6BB
 PG7pDEQEEATZxSaItC0xnamjlzksomRhZa/JI6jgaiPg5XNbaEq4RNrOableiGqFlmbvZfa6gz4
 eDUgwcuwMZL85bIzFHQUtPvwi7Tuk8TNqFi9X6zxSYJn4uhyji+VIOcTB8VxM1XuuAsDF6rSWUm
 z3IQbaaUD7JSc1fsSaenMx+TBu5S3/28nySsJCdaQiSXOGMXLY0Qf9SgKQZ7cSh27QC
X-Received: by 2002:a05:6871:724b:b0:42f:24c4:e317 with SMTP id
 586e51a60fabf-43a2da1b958mr13079506fac.14.1779207778788; 
 Tue, 19 May 2026 09:22:58 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:26 -0600
Subject: [PATCH v9 24/40] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-24-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add the common state needed by Octeon's selector-driven COP2 crypto
interfaces. This includes storage for the base hash, AES, CRC, GFM,
3DES, KASUMI, and SNOW3G engines, plus the shared selector-window mode
used by overlapping hardware register banks.

Describe the shared HSH/SHA512, SHA3, SNOW3G, and ZUC selector window up
front so later engine patches can add their own state and helper logic
without rewriting common comments. Keep selector values out of the CPU
state header; decodetree owns instruction decode and helper-local
constants cover the few shared-window arithmetic cases.

Migrate the state in an Octeon-only subsection so non-Octeon CPU models
do not grow migration data. Later patches wire helpers and explicit
selector decode on top of this state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Remove the MIPSOcteonCop2Sel enum; selector values are decoded by
    decodetree or kept local to helper plumbing.
  - Leave only COP2 state and migration data in this patch.

Changes v7 -> v8:
  - Split COP2 crypto state and migration coverage out of the combined
    COP2 crypto core patch.
---
 target/mips/cpu.h            | 37 +++++++++++++++++++++++++++++++++++++
 target/mips/system/machine.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..66c8653211 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,41 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef enum MIPSOcteonSharedMode {
+    OCTEON_SHARED_MODE_NONE = 0,
+    OCTEON_SHARED_MODE_SHA512,
+    OCTEON_SHARED_MODE_SNOW3G,
+} MIPSOcteonSharedMode;
+
+typedef struct MIPSOcteonCryptoState {
+    uint64_t des3_key[3];
+    uint64_t des3_iv;
+    uint64_t des3_result;
+    uint64_t hsh_iv[4];
+    uint64_t hsh_dat[8];
+    uint64_t hsh_ivw[8];
+    uint64_t hsh_datw[16];
+    uint64_t aes_iv[2];
+    uint64_t aes_key[4];
+    uint64_t aes_result[2];
+    uint64_t aes_input[2];
+    uint64_t gfm_mul[2];
+    uint64_t gfm_resinp[2];
+    uint64_t gfm_xor0;
+    uint64_t gfm_reflect_mul[2];
+    uint64_t gfm_reflect_resinp[2];
+    uint64_t gfm_reflect_xor0;
+    uint16_t gfm_poly;
+    uint8_t aes_keylen;
+    uint32_t shared_mode;
+    uint32_t crc_poly;
+    uint32_t crc_iv;
+    uint32_t crc_len;
+    uint32_t snow3g_fsm[3];
+    uint32_t snow3g_lfsr[16];
+    uint64_t snow3g_result;
+} MIPSOcteonCryptoState;
+
 typedef struct CPUArchState {
     TCState active_tc;
     CPUMIPSFPUContext active_fpu;
@@ -558,6 +593,8 @@ typedef struct CPUArchState {
 #define MSAIR_ProcID    8
 #define MSAIR_Rev       0
 
+    MIPSOcteonCryptoState octeon_crypto;
+
 /*
  * CP0 Register 0
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index f988b3695b..ebfa0a9eb0 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -279,6 +279,42 @@ static const VMStateDescription mips_vmstate_octeon_multiplier = {
     }
 };
 
+static const VMStateDescription mips_vmstate_octeon_crypto = {
+    .name = "cpu/octeon_crypto",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.des3_key, MIPSCPU, 3),
+        VMSTATE_UINT64(env.octeon_crypto.des3_iv, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.des3_result, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_iv, MIPSCPU, 4),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 8),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_ivw, MIPSCPU, 8),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_datw, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_result, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_input, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.gfm_xor0, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_reflect_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_reflect_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.gfm_reflect_xor0, MIPSCPU),
+        VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.shared_mode, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_poly, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_iv, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.snow3g_fsm, MIPSCPU, 3),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.snow3g_lfsr, MIPSCPU, 16),
+        VMSTATE_UINT64(env.octeon_crypto.snow3g_result, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -396,6 +432,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
+        &mips_vmstate_octeon_crypto,
         NULL
     }
 };

-- 
2.54.0


