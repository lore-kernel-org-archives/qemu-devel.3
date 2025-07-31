Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1913CC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUbG-00026N-HB; Thu, 31 Jul 2025 10:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhTZS-0007CS-4F
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:43:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhTZP-0004OP-DL
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:43:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b77673fd78so319243f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753969421; x=1754574221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gC/sYbZmuKXxQePBVZ1P3dDnE7e4TeVo5Iiow384Kq4=;
 b=Q6vqknAYGjAF0LJPVi7uGkiSubkoaDLwvEOnLpO+NBw+o/sCA6iYPQwuSCk0puXc4b
 8YUaqsQOZelQ/rlH1iKrj3l0NgMYcbDUax7PPxkULcrSrfq13IRr5CeJwpmn2794BHnn
 IRPFfsegJYcxuWnYf0o9thV7DJ0BsX2nfBeEOgx5Of8v/OB8yTZBro3Gv/v0wtGtyyAq
 LJ4RfOgjSkpuKbH9JdaUuGxOQMRhBiJvzyL1IA8oJ8y6AMDZv//13KVZiqcQQ2PUbmNK
 A+N0S1wSyPJj012R3fON2XPzOp8JIX+AHT20cWf3LNZ4SBKp5qt09WLQmDrEv5gCcL8t
 2snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753969421; x=1754574221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gC/sYbZmuKXxQePBVZ1P3dDnE7e4TeVo5Iiow384Kq4=;
 b=CXk5VQ5TbtVUtfg7/awRUOszNZu6M9IKF8EAH8HNldbsIPGztbjFpxGAe1Ll0QXTYx
 Ki5D1thQyN/xKARZJLwKnk1Yf1wMxNUnX+YLvT7gX/HQYrKGyDH7c5vMwqNHxFhUbYuQ
 jPwqmlv9ung0CWwoH+92LZIlbEF5BuKTLCbWF7kxXOivEt/ibey6Ubxwzd/2ZUl1lXEg
 UCNly3jZPnNV9XV2g4wCurzaTRUNDRwQyMhsuPAu011P3Uazv02C+REXEuRSo0KfE8S8
 SSBjctAZDU014/SuV2mpIRrKn/9HK8TeM/8IdECKkJfuQmK9+mT5+LuWy9FbQ91MN3s+
 LRLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNRRUszo7GIfD/S/7y6ZbCRMp0gT+bMi4fdXoRogZH2e2rzoP78lmZL6xCn0XKFayJvOYmJITU3bxh@nongnu.org
X-Gm-Message-State: AOJu0Yycdr9mnX/76zHcInMB26J+2A3UtdfEsnZufvZaJVbY1CmCUP2v
 No2KwEO26YRMrf+nL8DOc3SRc4wg8mpGlyGfMM+jywgEpqs+fSYjhHMUkM6wL20boKs=
X-Gm-Gg: ASbGnctM74VLF18vAIqr08GbriH8qSLoLmQdMxIvn/Vuu5hKONTjR5A1cbC+PPHTq/O
 7Y8IXq4PdsJtGmQL1+6ggkgykj2snDd0wkGVPP5NdkxHVnRFn9fzQuA3BfO0NrOSRPFhahYh1bZ
 H/w19tvGJgtHuzVrSEZndq+8C/vHsHSsydOdSmd5rEAgNJIPFrXMJi4jIUUZPDIfRHP7p3Xr93f
 tF25LRNeDfO5Tafzs58V40DWX4dqijRoIEUO4AFUyP9z0cIkpmpqO91r7QwESVCUs8WWIOJ1YOd
 BAGExXCBU2fZ1+YrQcneWhbIOgKCp1GuzicraLXFz3i8F/BC6Cwam10FhT9qZ5yAa7Yvkge+6+0
 zDzDH0006pA9hUCACH7XTRwkMulJgspqURTpUDBA=
X-Google-Smtp-Source: AGHT+IEqZg4cs9sTLJ3JYU9PNQwQr9qbByszo2WLdtkf6M+3NQ3GNWNWiqetuVRL637LMprd0afG9Q==
X-Received: by 2002:a05:6000:26ca:b0:3b7:76ac:8b72 with SMTP id
 ffacd0b85a97d-3b794fb5719mr5905784f8f.12.1753969420910; 
 Thu, 31 Jul 2025 06:43:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm2486249f8f.12.2025.07.31.06.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:43:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PATCH for-10.1] target/arm: Reinstate bogus AArch32 DBGDTRTX
 register for migration compat
Date: Thu, 31 Jul 2025 14:43:38 +0100
Message-ID: <20250731134338.250203-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

In commit 655659a74a we fixed some bugs in the encoding of the
Debug Communications Channel registers, including that we were
incorrectly exposing an AArch32 register at p14, 3, c0, c5, 0.

Unfortunately removing a register is a break of forwards migration
compatibility for TCG, because we will fail the migration if the
source QEMU passes us a cpreg which the destination QEMU does not
have.  We don't have a mechanism for saying "it's OK to ignore this
sysreg in the inbound data", so for the 10.1 release reinstate the
incorrect AArch32 register.

(We probably have had other cases in the past of breaking migration
compatibility like this, but we didn't notice because we didn't test
and in any case not that many people care about TCG migration
compatibility.  KVM migration compat is not affected because for KVM
we treat the kernel as the source of truth for what system registers
are present.)

Fixes: 655659a74a36b ("target/arm: Correct encoding of Debug Communications Channel registers")
Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Fabiano's suggestion for a migration compat mechanism is
https://patchew.org/QEMU/20250730205245.2118-1-farosas@suse.de/20250730205245.2118-2-farosas@suse.de/
---
 target/arm/debug_helper.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index aee06d4d426..579516e1541 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -940,6 +940,13 @@ static void dbgclaimclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.dbgclaim &= ~(value & 0xFF);
 }
 
+static CPAccessResult access_bogus(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    /* Always UNDEF, as if this cpreg didn't exist */
+    return CP_ACCESS_UNDEFINED;
+}
+
 static const ARMCPRegInfo debug_cp_reginfo[] = {
     /*
      * DBGDRAR, DBGDSAR: always RAZ since we don't implement memory mapped
@@ -1002,6 +1009,28 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
       .access = PL0_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    /*
+     * This is not a real AArch32 register. We used to incorrectly expose
+     * this due to a QEMU bug; to avoid breaking migration compatibility we
+     * need to continue to provide it so that we don't fail the inbound
+     * migration when it tells us about a sysreg that we don't have.
+     * We set an always-fails .accessfn, which means that the guest doesn't
+     * actually see this register (it will always UNDEF, identically to if
+     * there were no cpreg definition for it other than that we won't print
+     * a LOG_UNIMP message about it), and we set the ARM_CP_NO_GDB flag so the
+     * gdbstub won't see it either.
+     * (We can't just set .access = 0, because add_cpreg_to_hashtable()
+     * helpfully ignores cpregs which aren't accessible to the highest
+     * implemented EL.)
+     *
+     * TODO: implement a system for being able to describe "this register
+     * can be ignored if it appears in the inbound stream"; then we can
+     * remove this temporary hack.
+     */
+    { .name = "BOGUS_DBGDTR_EL0", .state = ARM_CP_STATE_AA32,
+      .cp = 14, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_bogus,
+      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.43.0


