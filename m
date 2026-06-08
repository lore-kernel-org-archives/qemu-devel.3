Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38864CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCs-0000z2-Bv; Mon, 08 Jun 2026 15:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCk-0000tt-BK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:10 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCi-0006az-7W
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:09 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so3858885a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945206; x=1781550006; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rQTQcSFhX67Mh9pYSYiVJEnF8m2j9W2wm7GejxGsl9A=;
 b=CEqS6u8wweKBq+Kgf8qUnWhf05RTHs1Egev+GMuGdBQmQ0hZqakRvlBYZINnFeq9pU
 2s3Zdt3i3une4+4Cw3eFZJCvrfX3z3XA0jD1iu7LTtO1lCE9zHIFoxuLVXpHNGm/l5Xe
 O3/gcQ5h6iT1BBztHHcqZyZZE+oWG52azWbSB0MSOGXW418vScsy7VjJzcVoJq6UYhRT
 S9VGEV0Zvk3Sj6L+TS+lWF+6DnwKNGyubc6xGMYal+8pyfsPZBbabumNDCO1ALyIAPQ2
 DS3qi0EK5tFLUr1gRUaULH1Hw+SGoiUuYHKRWyPioLBN5c2xVm4VIb8bwbJjK0lA8Lv3
 v0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945206; x=1781550006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rQTQcSFhX67Mh9pYSYiVJEnF8m2j9W2wm7GejxGsl9A=;
 b=RiHt4QR3gWGorviDsP110A4oDj2R8tCu5sjVWYAu53mnVifHhi02HzKw1FgCgBvWls
 l7nJ/laqQEyoJTpubGpsYPE0K3pJdSITP5NN9kZQNx55iYrzHG9SXHVTfe1YOS26XiHp
 G9fcQeiJi4DOjaORqmT3IkQqgnb23zKWpUH3ttUpvZwrwa4IZTrrs2g3eWBS6QaJ8d2x
 F61kDU8gTLsHNnDNfgamjO+u1X2M9pLrI2/YgVNKqLbfqEtFTJ+zYeEL9oDNNVxGBSvM
 unCNBbkLeq1Q0+JbJFrh3anCyzaYiDny+wBxpu3F5mpygXDbSf5d12CD7q0YYYdEOyi3
 So3A==
X-Gm-Message-State: AOJu0YxHuZuh11r7I6mk45CI9zPIL2QmP+Lehcwv69oZ82WZKf6+Jycv
 +564+MMvFu1Vw/AbX3X2Sm9FGWG6gdgz72p9a/n/TUfrpF2BKEX3DdxyZLjjDbJ8y3M=
X-Gm-Gg: Acq92OEe1/W5NUvR5ve2aZ8O47CthZTwQn1tLGcDPE3hCK2xX6IxrQHlK3J7NwK8JS6
 6kSVHHtC8U59xGVRqYXAJKXznThPKlXpALZYhBuvc2+P4lGCdl7uDLNeDtvgxUJ8cE7CE6bf5+c
 Vqo5UkZyxX1gR/uCV3OyXczAHSztTMkO/FXcJWaddm9rOqYiZxc5/Njvq7/3eYsa17sK+ILqByh
 BURpMMD9KBWBExzQl6qAE0XXUxhEKrqIfbSS4oGpG1BzhYvd+N6KVzCRdbCUf3/etvcmG8ONSK5
 yXgHnpX4uCrn3SM5UOuIJIsViRwLJ3G1F2icwv2EG5U4zcS9tXASIHuyrVvCI2b334pZydvupsw
 0DKq00tExLhBPaZCt5Mjauu+36r4YgcrlcEGYK5vZVKCCRxsiaY3bqUWo1ACNwZMn5/3jATErmc
 xVvqXEmBAxm/Jl/TWKenLWR1gsFdFPpBumbq/i017ckY3nfY1s01weuhdP2TQXCuwnW+adXXJ4D
 hRI962XsTQDjY/nuNt0ody01rOyLvRSofT+uDqMZCOn6Xpsufw9DaWM7tEqScrbcVFV1OBgDxV+
 S4UzeiekKLZ8D5gHWx0y3EzfTcADVzsC
X-Received: by 2002:a05:6830:4425:b0:7e6:ff83:4b46 with SMTP id
 46e09a7af769-7e70ca5c621mr11732465a34.23.1780945206277; 
 Mon, 08 Jun 2026 12:00:06 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:26 -0600
Subject: [PATCH v16 01/21] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-1-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
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
index 392406aff8..3df71adf9b 100644
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


