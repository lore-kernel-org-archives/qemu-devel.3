Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD175C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kx7-00068b-MD; Wed, 23 Apr 2025 21:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktk-00067e-JC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktg-00059l-RB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso456568b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456219; x=1746061019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msXtfBhGOXcEDb7wOAfBlBKK4V40wttZa0c5PZCnz/Y=;
 b=neQBW9yzPDtRLzErS1TK80tqsdCRbh9zBrlpHY6837gPrmXBuXRS4uI8zgqkChtFS7
 m087RLxHcCF5Y3bmJG2jnkN04znGN2OK9YXItC2e2cHrdi3b0QsYaoKKbSnFVToLCbAD
 g5BDZqrMPnjjNVT+LUgwpgK0dQswdnaJkRiTJabtvxVhYlOSt+s5ONQB4nPA9qRTruVt
 hg8LzhBkG/OsyQeeDFuMA9a8hLMRpJNw4tgBF/ijpYBeUnwPJuBkSLq9wxenHZy0tR95
 xz2l8UHXwLNaqVsnrBzIQIfyYSJUYM9uLYsf4P1l867jvodmqYC7sNNjY3hKU1hMXqar
 Bpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456219; x=1746061019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msXtfBhGOXcEDb7wOAfBlBKK4V40wttZa0c5PZCnz/Y=;
 b=Jtyw0ybixYEo6jPSppTLDi2P9ZMLNX4PhQ4TnlJgaZIVXJxPNMCmUZiv1OYuq0hm1Z
 VRund1NlP4E1XrgSp+z6KfW9k+VP7pXcd2fTbXganB5vuizneHs3Qr7GVuJ+i+1DjtbL
 E5WtzVHcOUFGy4jgcis8woGI5+bVoX4yyVKSiXWNQ+ZRYvS0Cq+TTVUg4tqxSV+Ir/iV
 /zge/E93I16Onpkz7z/NgCTXNCb02PUiz0jdyX5CTix03CdREfgWZHXWiTH+Q6xkVmON
 bx1umTnOf318dhywJoQwC1Srnmn0rVCg54zAVHqG5LJaX7uFpTF0YLYgyTRSFoJH44OT
 eepw==
X-Gm-Message-State: AOJu0Yx2d/QHgt95YR//58bqK/g8ZS9w7owCTjo737qMEFtz7bII+Dah
 bLDr5lFo+6jvjz3tYaEn5EoUFcswVCgF6RxxS12K7SS8In7AhPjOSFwAGttYH3/m8gcBS2d3zl8
 Z
X-Gm-Gg: ASbGncsAkmbfTJkwgaS0GPkVvpwNC08HShR5JJXD7vUlhENgqtB/9eEztSH2L+E9bPs
 1maf6PsnUr+ofd4nBh3CW3EnjTRDnqKLBy54YpkjBSJ0SwKo8BqNClKyio6fhMB3YsyT04/H2Do
 KOqPH5KuFalCYHPxYJ9cfu9G0EdpejRtS8seQRm76R52u/Y01wv5W62vAF1mETl6nD3x20IE7kG
 9db7S3ghV71M7Coze8RU4c7XgzCqyKMNvySw41xlJES1QusJWrNinOrfJFGW568OiiRkokCRYay
 ls5T9N/ooSTHt0CSqBweUWba2IXBPfph6UUCf9eA6AzS06xNg3mBavEbqsIDvd7G3lLqpXX5rpA
 =
X-Google-Smtp-Source: AGHT+IHOeD0+1UACHxy7fZwxJGWpqD5vQNeQx1JFj/Ksx953d7DRpCp6JrSbgt998Vf2PGzR+8VTdA==
X-Received: by 2002:a05:6a20:7fa6:b0:1f5:7280:1cf7 with SMTP id
 adf61e73a8af0-20444ee5eb7mr917627637.16.1745456219502; 
 Wed, 23 Apr 2025 17:56:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 117/148] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
Date: Wed, 23 Apr 2025 17:49:02 -0700
Message-ID: <20250424004934.598783-118-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

To eliminate TARGET_AARCH64, we need to make various definitions common
between 32 and 64 bit Arm targets.
Added registers are used only by aarch64 code, and the only impact is on
the size of CPUARMState, and added zarray
(ARMVectorReg zarray[ARM_MAX_VQ * 16]) member (+64KB)

It could be eventually possible to allocate this array only for aarch64
emulation, but I'm not sure it's worth the hassle to save a few KB per
vcpu. Running qemu-system takes already several hundreds of MB of
(resident) memory, and qemu-user takes dozens of MB of (resident) memory
anyway.

As part of this, we define ARM_MAX_VQ once for aarch32 and aarch64,
which will affect zregs field for aarch32.
This field is used for MVE and SVE implementations. MVE implementation
is clipping index value to 0 or 1 for zregs[*].d[],
so we should not touch the rest of data in this case anyway.

This change is safe regarding migration, because aarch64 registers still
have the same size, and for aarch32, only zregs is modified.
Migration code explicitly specify a size of 2 for env.vfp.zregs[0].d,
VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2). So extending
the storage size has no impact.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-22-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cc975175c6..b1c3e46326 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -169,17 +169,12 @@ typedef struct ARMGenericTimer {
  * Align the data for use with TCG host vector operations.
  */
 
-#ifdef TARGET_AARCH64
-# define ARM_MAX_VQ    16
-#else
-# define ARM_MAX_VQ    1
-#endif
+#define ARM_MAX_VQ    16
 
 typedef struct ARMVectorReg {
     uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
 } ARMVectorReg;
 
-#ifdef TARGET_AARCH64
 /* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
     uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
@@ -189,7 +184,6 @@ typedef struct ARMPredicateReg {
 typedef struct ARMPACKey {
     uint64_t lo, hi;
 } ARMPACKey;
-#endif
 
 /* See the commentary above the TBFLAG field definitions.  */
 typedef struct CPUARMTBFlags {
@@ -660,13 +654,11 @@ typedef struct CPUArchState {
     struct {
         ARMVectorReg zregs[32];
 
-#ifdef TARGET_AARCH64
         /* Store FFR as pregs[16] to make it easier to treat as any other.  */
 #define FFR_PRED_NUM 16
         ARMPredicateReg pregs[17];
         /* Scratch space for aa64 sve predicate temporary.  */
         ARMPredicateReg preg_tmp;
-#endif
 
         /* We store these fpcsr fields separately for convenience.  */
         uint32_t qc[4] QEMU_ALIGNED(16);
@@ -711,7 +703,6 @@ typedef struct CPUArchState {
         uint32_t cregs[16];
     } iwmmxt;
 
-#ifdef TARGET_AARCH64
     struct {
         ARMPACKey apia;
         ARMPACKey apib;
@@ -743,7 +734,6 @@ typedef struct CPUArchState {
      * to keep the offsets into the rest of the structure smaller.
      */
     ARMVectorReg zarray[ARM_MAX_VQ * 16];
-#endif
 
     struct CPUBreakpoint *cpu_breakpoint[16];
     struct CPUWatchpoint *cpu_watchpoint[16];
-- 
2.43.0


