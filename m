Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A12C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQo-00043k-UU; Thu, 20 Mar 2025 18:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPf-0002Xf-VO
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPN-0007Bd-Ae
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22403cbb47fso25524005ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509834; x=1743114634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ozZ2STeyLcJfOi2HO38PmZ1SSe1ZJ6WASMV/GdeD4Q=;
 b=Exaa2x43Pt35lxK6xlGOomDqkBGws0dl0rqbXOOFoPdoP+9xTF6SxfK9jrplX1T/F6
 Db3cTTF1JUlYJMY6NdsIkk8PV1t4E8WgZUr/+Ml+mvtu1DRgb/WrCR44w3q32AfuxPuh
 XEVV383VY4pBj0A4YHH933+iUFisCkRXN1yZm9pmfdzvoa0SlakEN2LVMAQKOb2UAy3Y
 ga02z+q/VqxVdmnWU/L07Gyw/ZevgOFr79Z5yIqhfqOm+WjkwSNKOArRH2RAwwglim8z
 4la+NCIVquVNmS6eDJMSDdFXn9bAMl/bWBQPB4FCt/rRftguEvB9jgTxcroG8lS4x/uM
 mvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509834; x=1743114634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ozZ2STeyLcJfOi2HO38PmZ1SSe1ZJ6WASMV/GdeD4Q=;
 b=YMgX768lD6O1ZE7swnFKFeVaexpf3uKtakjzDEJWJdMItXjtEv5yyAt3vPrHqXUEAe
 1qKEHVkm3sPwtQrSERZ4lFhIBciU7eYTR2qIEx7E2iGWQ9EGu53gpx4Ga8Iht4vaDGXj
 RucKxDAjlWDuJhQ+y+7WF/+Bl1j5iBGylnj+PoLHYNdUGFaGddlXwAC6Sr0PHygF9KwU
 9j5I3xrU6DVUSByWSkWxhWyJzQDXZvrxw4qAM4+Tznso2Wrn4U7zObjGL8Pwm0173zBq
 jf1PjjNgLQIFw9KHSIUU0aVMN6TzjhtpZkvTJ/ksOf2/8E2M6KI0TknoQiK0tdu8s4bZ
 JJig==
X-Gm-Message-State: AOJu0YwmZ9rsEKSraFddZajuAh+gSJQeQ0stl54VOTK9/n+4GXHz70mw
 Jh/VkS0vgiuogtK3pNiZFSa2LZEoL5STYUr8zip0PwMdNlpz6DgFDODxHXp6Ay1nngsqS11gEY4
 e
X-Gm-Gg: ASbGnctVLryfdYOmUtraDJkOJFamYKnoO94G6PcYO7uJH7JvcUzg6/bOSjFQfk/5etG
 tWujMH0eHF3+Mwj9mm9wQr7kf3OjbZmBhXAvKh7W0h3Z+wiUdtvRLfR0/v2exHzr2zjgFbXmZ7E
 HyDDCLJtqNOX2iuwStDolzSbZxmVpGJ+tYhGBurB6QlODD5Nq+LDdLEegyZkyMlJfUJ0HzGMe9X
 mZ7V6k/4/hIPO3SLMc7LC3QSat9EoyKEKNAPYMkqsFyLJa3bVhy7yEd96mMJTNn+190VdxoR1Wz
 ayOPsl0+XDz8jkfqOomBS71+5x5Ah/9GoNfoKcE3pQl7
X-Google-Smtp-Source: AGHT+IHe6GBkn4KwpLvaTmmjJDIDMzLP05ORVKokysmKy53aE2ukm/kc/ZOTuWlwBaafsA2wQaDJ1Q==
X-Received: by 2002:a17:902:ea04:b0:224:1294:1d26 with SMTP id
 d9443c01a7336-22780c7afa2mr10974305ad.13.1742509833662; 
 Thu, 20 Mar 2025 15:30:33 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 22/30] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
Date: Thu, 20 Mar 2025 15:29:54 -0700
Message-Id: <20250320223002.2915728-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
---
 target/arm/cpu.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cc975175c61..b1c3e463267 100644
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
2.39.5


