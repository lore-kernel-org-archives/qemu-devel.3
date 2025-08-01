Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE927C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtWy-0006oh-3l; Fri, 01 Aug 2025 13:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3J-0002q6-N7
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3H-0000yo-4Y
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso12351755e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063529; x=1754668329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6tqNlDZhDFhmievpTc6TWIWJKAXo6zzMJoX/FphxVJA=;
 b=jAwzITqjjCMCUzIItli3rZUn+d5MJJz+5FA4CGsY9twaSakA9nHhun3f9O0Rfm2Lo7
 HeQWDcwDyUAPq20RUFF5oUdV6z3NC3HUMkP4KAWp3EMac5jjeBCkoqKgXOZJfsEcIHAm
 s42lHl6z6wCUE+wS5FSCjYYrflfRrE8AS1kDSqLXBh/HmlwGCW31F4yHLb5A1byFGx3D
 CF9i2WCV9/1Bfq8vEySlhTzZxN9fs6i0rVEXvJaoiTS7RDPoWPssSDczXePBdvRvUPGM
 64KengY51KpJqjgkOGrxqM5in3tltU2qM0YSBspvOHhAtOBjPe33aGx7DaAX+lOYF5/a
 YjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063529; x=1754668329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tqNlDZhDFhmievpTc6TWIWJKAXo6zzMJoX/FphxVJA=;
 b=LahFELU0bHRKKyKDv48OSDpDMSM7KBw3ydzrfL5a1FSuDZaiFOPSTNd2SOU2YrQ+v9
 GVExCwvnpPWXqUMM8vxd3Y7IGysFeBwiOVLkxFQsKTEUhil0Ub3iKuFv2rpb2gv5Fohd
 +71uHNG1LOsXGewQrJHydGJZz2BilMJVBtMn1ZSMmOPNGZwNDxqgf2G9oxVeqNg1mkXL
 hAxh20IH13FHgwpMSTmg8767C74iE4ijoJ/BnKJnAXB1vvPyLs1vLyLZB5yDClTJe3o3
 Y8xcxhV5FagO4A8aNu1iQ7HIVudf+uOCFCCd1mWul64arzqLviUgHen66YpWIt/4IopI
 cPWA==
X-Gm-Message-State: AOJu0YzExXrK4oCttRsRClDTGQD7ToLdyKuqzcZNds4jIi5eb0GLsM0K
 tL09fPqKG30MQt0PSCr5c5JvS4dLvWGIz0FYj49++bXaqvw7cEIoY7SHewxIGDNMoyiE7XSMHBN
 BjwPg
X-Gm-Gg: ASbGncsLaT6LncPh+1JBLOAtr/08QrEWnNTc6tGto7/qEt4UXESEPilpjoOYQaMyfx9
 7PrjcM7JgJcpX/2nFgxI21KSFLOfYh7ursOtLF6kvUmkPbtnZNHbJL4H3HXqBwNMvqmTX5aru76
 fWb61Qltw6alOpzkjlsCCaroH/vVbklyRZ572tpjaCaUj0QLQmxk9mS5d32/T4eGSz5ZgxowNYP
 eBIWp0AZWafJQBIoY7YYkJtAO8Dh/NuvBivz+qBMrPXFmz6NhxIYL+wlJogcTraEeUMir/FBPJk
 uLlBEYyWgaxHfjLzi0GjHOKEsGRPV8VecMpsi43xV1eXG2THCRla5F6U+NGrVV7VM2B2NRkO2Sz
 IhjUFguNBMF8PMvEuR56BN/XVURb6IbzmG8ltx1g=
X-Google-Smtp-Source: AGHT+IEAtSNjDNbiSAZaz6HYQWuGaunl8lIBuaOjDsM0rSdRc2tZxJL/DeV6yyd0YAOaa3+vUNKgjQ==
X-Received: by 2002:a05:600c:4fd0:b0:456:1608:c807 with SMTP id
 5b1f17b1804b1-458a29cad45mr64489065e9.26.1754063529394; 
 Fri, 01 Aug 2025 08:52:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] target/arm: Reinstate bogus AArch32 DBGDTRTX register for
 migration compat
Date: Fri,  1 Aug 2025 16:51:56 +0100
Message-ID: <20250801155159.400947-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250731134338.250203-1-peter.maydell@linaro.org
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


