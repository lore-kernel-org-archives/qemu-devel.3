Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B4CCD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVfz-0001cn-CO; Fri, 22 May 2026 15:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfw-0001c7-JH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:52 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVfu-0000Qw-0W
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:36:51 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47c7b282d73so5025025b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478608; x=1780083408; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vjuBTuc0CwoxnFM7dFzZrSvU/FhfadxTvGG76M+/dO0=;
 b=MGrbc+L8iWi60PDT+NSePkCtId+0MtwUnRV5UTNTnek3sLbsxvuYuVCsSSOkStea1H
 pmUS+ofvvexWaIU489F54uZCARSSYEsIn/5MR5feRMdWBlIkIkQ4WAca9lcOfdcsqhhN
 1Yawj2BE0J0J7TelhWKYv12Bl8ju2QksyjGnUy2oMEUB2//RxaAAB7CerocGcK3C12p0
 YabEBWjgJHuR2frSjdgi2hUCEZ3emRhhIo1nF9f11QLvI7v0oJB9yxAZHJQOxcZCAO/e
 aSRIppFjaHsxmbXglvF/pCxlW8TPIXffgTOIgGowM4BTqFBFcCagevtVNXxKRiYMvZoI
 tWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478608; x=1780083408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vjuBTuc0CwoxnFM7dFzZrSvU/FhfadxTvGG76M+/dO0=;
 b=VkDpYnl24/BcUUInO6hz0+6ob+TxMh0jEUhuIY5Jkoc+IlG+V6fGds38fkJQLiS+mL
 zIdM7ozR7DAepiDJ0Cz2sq2kBu+GGTcQcd+3lIOGWqU6Du0s7Dw+JsHCjXM3LB/lFeXF
 yBlg9WGydqddvndgvwb7znhXXriEhaU3F1l19IXm5VXWfQh7pv3bEinuC41nDUWI/9Yn
 5sgSCLnenC12SLKGb/eqDerYvWzTRL7CfVoHCaXucPP9lnjS3qz5cTIv83wzxJYE7++H
 n5W2K75RP433pePOul8R9RlLsj6MYRq4EgL/vH8yyyoBi0T3+feX6UQnotAzHELe/ZUT
 g0+w==
X-Gm-Message-State: AOJu0YzCLinwx65BwnOaL9EPwLnHb5qDLEBCwGGQKXEExGel0Dyn902I
 S6htGKjskhmeTIgID2mrQHx0mkOD22A2yGxZHloJDikyYzpahLUJbT7w
X-Gm-Gg: Acq92OEDwPfc3AV7YT9teDsVuFQEsaDh13RK3gpy+jM4DOltPFM5VwIkl59Ult5ijiG
 GtMVOJ55KQyBVXQAcsLleKi+o7PUc5HZW32jr0hNNrP8NZqV3hAQS02p9BPBRWEwF7RJ/ZTSHuP
 XZXyKgOv0YnqOQ3JmS/M4iyRCqnJp4rBLKD7ejbNHbY/AyWuNXWGbmmJk0I14OW3ekl4rukbhJc
 EtO5+KACYNRKOPTnyxStlbYe/bb6SEKGmay2ivwTVlmEa/9Ri7M2dlXP8LAxmwHLe1ioILyOEpU
 4Ypvht1DVhoxmr4uGIy49ya28/i7qXZkmidyr3VeESrLx7XSu7N4oFOufRNGD/1Ts23jNjnXj5w
 aETeqV9E2O7iw3foBTdY0tb41+8CfR0OF0vi1FqLXq+iheSyGJwgFnqzFvpVKGOZ8LpNZYNPJVA
 w0tyWAtZSbd+zll1Dp17Obh4LKgyNmyWdYdSfVmy4amFkp/Oyim/4TMnvzmyiAfH2L4+hlkXpb3
 KWw9o7OzBQINy7vJ67sEDvSplrepeIMS9fC5wtGHzEw8/IKNu1KaUxDRjjKs5nMvttf+5yyapoO
 bPk=
X-Received: by 2002:a05:6808:1703:b0:479:faf5:ef4c with SMTP id
 5614622812f47-4854a3f95ccmr2649912b6e.32.1779478608530; 
 Fri, 22 May 2026 12:36:48 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:36:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:33 -0600
Subject: [PATCH v15 02/22] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-2-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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

Add the common architectural state needed by Octeon's selector-driven
COP2 crypto interfaces. This includes storage for the base hash, AES,
CRC, GFM, 3DES, KASUMI, and overlapping HSH/SHA512/SHA3/SNOW3G/ZUC
selector windows.

Keep selector values and helper-local aliasing logic out of the CPU state
header so the state definition remains limited to architectural storage.
Helper code uses the same register banks instead of adding
non-architectural shadow state. Model the SHA3 view as a direct 25-lane
alias of the architectural HSH DAT/IV/SHA3_DAT24 storage.

Migrate the state in an Octeon-only subsection so non-Octeon CPU models
do not grow migration data.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v14 -> v15:
  - Model SHA3 as a direct 25-lane architectural view over the HSH
    DAT/IV and SHA3_DAT24 storage.

Changes v10 -> v13:
  - Keep reflected GFM selectors mapped onto the architectural GFM state
    from the start instead of adding temporary reflected shadow fields.

Changes v9 -> v10:
  - Drop non-architectural shared-mode, AES input/result split, GFM XOR,
    and ZUC/SNOW3G shadow state.
  - Model HSH/SHA512/SHA3/SNOW3G/ZUC overlap with the architectural HSH
    DAT/IV register banks.
  - Store CRCLEN as the architectural 4-bit state.

Changes v8 -> v9:
  - Remove the MIPSOcteonCop2Sel enum; selector values are decoded by
    decodetree or kept local to helper plumbing.
  - Leave only COP2 state and migration data in this patch.

Changes v7 -> v8:
  - Split COP2 crypto state and migration coverage out of the combined
    COP2 crypto core patch.
---
 target/mips/cpu.h            | 26 ++++++++++++++++++++++++++
 target/mips/system/machine.c | 27 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..527ad68a7f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,30 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef struct MIPSOcteonCryptoState {
+    union {
+        struct {
+            uint64_t hsh_dat[16];
+            uint64_t hsh_iv[8];
+            uint64_t sha3_dat24;
+        };
+        uint64_t sha3_dat[25];
+    };
+    uint64_t des3_key[3];
+    uint64_t des3_iv;
+    uint64_t des3_result;
+    uint64_t aes_resinp[2];
+    uint64_t aes_iv[2];
+    uint64_t aes_key[4];
+    uint32_t crc_poly;
+    uint32_t crc_iv;
+    uint64_t gfm_mul[2];
+    uint64_t gfm_resinp[2];
+    uint16_t gfm_poly;
+    uint8_t aes_keylen;
+    uint8_t crc_len;
+} MIPSOcteonCryptoState;
+
 typedef struct CPUArchState {
     TCState active_tc;
     CPUMIPSFPUContext active_fpu;
@@ -558,6 +582,8 @@ typedef struct CPUArchState {
 #define MSAIR_ProcID    8
 #define MSAIR_Rev       0
 
+    MIPSOcteonCryptoState octeon_crypto;
+
 /*
  * CP0 Register 0
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index f988b3695b..77f576a25b 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -279,6 +279,32 @@ static const VMStateDescription mips_vmstate_octeon_multiplier = {
     }
 };
 
+static const VMStateDescription mips_vmstate_octeon_crypto = {
+    .name = "cpu/octeon_crypto",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_iv, MIPSCPU, 8),
+        VMSTATE_UINT64(env.octeon_crypto.sha3_dat24, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.des3_key, MIPSCPU, 3),
+        VMSTATE_UINT64(env.octeon_crypto.des3_iv, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.des3_result, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
+        VMSTATE_UINT32(env.octeon_crypto.crc_poly, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_iv, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_resinp, MIPSCPU, 2),
+        VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -396,6 +422,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
+        &mips_vmstate_octeon_crypto,
         NULL
     }
 };

-- 
2.54.0


