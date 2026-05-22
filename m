Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12E1CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJ4-0002RB-Sy; Fri, 22 May 2026 01:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJ1-0002Q7-To
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:19 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIIz-0001mu-PA
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:19 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso3699622a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427215; x=1780032015; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x0NUdarwlNBIbAV+0BMqGTTe4aMVplAxOCrABMuHx4A=;
 b=lX9Z8iNByPq0Yh8tfbU10h2htdmV/cV1issCjF6FySZbqChYUbGqnAv7ztzn7g3wOz
 qX8o+bMTT71Fj4k/9a9ZsWiqeC/OcxpY1uci9zej5FaPkPwSRZcATPHMzDWAAV72FoGh
 eWfuohD6MG39iW4sdncDJk6LJglWnldTswW1ewvXh7z7wX/SMJgoIMN1d60fP5eP9Mp7
 BJPsprR9Z2RpzffzKmhwLCUSf9ef7Kr5+F9DEMwPGgdqxXfQTG/iqGUCKQHxBxmW/AyG
 NAamiaMCrASsMPZHG99wCrh01573X37Q6nKsnKs4zF/XOUBQCSpXksZ3ooc2tCed1c1O
 W3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427215; x=1780032015;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x0NUdarwlNBIbAV+0BMqGTTe4aMVplAxOCrABMuHx4A=;
 b=Ui0wY4PoL8IThUPdUZq8u/phwe+L+iRYfqxxYDiErrdZV0MrNw+X6gADrMj7rTyjuq
 Ym9ukD2LYe6+VxsytIz1PUNyMHBi3hBYY6Iidln3t2mhAWcKzRikJyZajycWZ2vlQtvu
 fCDc3nfX7b0VjIFc5Qk28TjZRakcl/qP+WMamwbhughjjW2Z1+GdxMPFxeY/JNl+LNW0
 tEE1xlpPlj+xHSMDMRquk+klfKilzTsoeHRrRmNqAlMaTuGcF4+0Leto8Wj77StMyPiV
 /KgjDAOEOM1fSnuVj1L94uqlt/l/cCOignD9lzf2gCGCCFbpawbGS6+EX57jTwbbUp6d
 rGxw==
X-Gm-Message-State: AOJu0YyPhAPNTf0Yjayq1f37GbXhsEJAo1bOOTGgdJ8OU2k+uKHer6U5
 XDV4k4yeyQIBmuCTVg8OcmtSm5O0BuYyptSWGCS9BVtR7OsGdikmeHoB
X-Gm-Gg: Acq92OECC683osn6ZajxsSTzgLSMbhMlWXfvHkEe6R7u0hvIo5xvsVu8Sdhlr+NmJeN
 Hc604aCoiYESa+awYakcfD+zOeDWm293Ce1zquK0RzJbF7DgTsQST0/QEqkrwqSZndgquMgy0GE
 +7tm0Y5jwx5nZ6M/xJ9rnbcmZyTEX8TaFJUBDHZUf5wRZe/R0zfKlhW5dGX0aL/cZKyiHpmfJl7
 eKSkFs8YE1mQMSv2o3514KVjg/oCHSGkNNYUeN2mSvxwp/65GtzHi5ZMpCuJTKVA4n+ApA2tb6q
 Yl7hPp+olTxeU5nm2ygzfoV6v0x2k1cKcZc8yYY5nox/Q4j5JiGbo6DAi3iBhHYazpteyYPAG/R
 DylMS1EjA+SY6h8grwNNmX16ZnfjHtYQJog7h3tL7qnGPfHQR9qRYCi7JIhFRqDwkDKsnMYKKSU
 eCqKQaVunEpSFCdKAvx/1Tbx6sJNLmuOkFJ71I2INzcIDdO68g1dwts7vCgZe/aQu7fQH+h8586
 LFcsDtY5zujCTX/F/eUAGmiOJbcAGggd7sBQoZdTCQp3N9wuSyGB8hr+vl87ZNAlgtD
X-Received: by 2002:a05:6808:23d2:b0:467:819:dc61 with SMTP id
 5614622812f47-4854a29f503mr1222801b6e.23.1779427215037; 
 Thu, 21 May 2026 22:20:15 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:44 -0600
Subject: [PATCH v14 02/22] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-2-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
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
non-architectural shadow state.

Migrate the state in an Octeon-only subsection so non-Octeon CPU models
do not grow migration data.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
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
 target/mips/cpu.h            | 21 +++++++++++++++++++++
 target/mips/system/machine.c | 27 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..2dad7f538f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,25 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef struct MIPSOcteonCryptoState {
+    uint64_t hsh_dat[16];
+    uint64_t hsh_iv[8];
+    uint64_t sha3_dat24;
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
@@ -558,6 +577,8 @@ typedef struct CPUArchState {
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


