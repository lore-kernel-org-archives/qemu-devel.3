Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8325CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUf0-00075x-LM; Tue, 29 Sep 2026 06:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUez-00075X-5Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:05 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUex-0008CP-CP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:04 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so2834715f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676122; x=1791280922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nPo555MX95A4dQjnAX09dz9zclW296ACMm7gAyXXzss=;
 b=u6DJ1SC4k5GTWsoFdO3m7xA7xGXwQFBE6C7tJ6+2QWNRDZH+j06zqNx/TTcy768x7q
 wQKE37GrDC19A9nYDdiAKa58ZUtUG1qyi2ruthlEJ7kyqMl/yefRo6DzqlWaXGpEhOzi
 4q5haRkUG6fC/DvsBep2FT1iSl7JFt+UtOV6ybHsFexoVWbbddJfnI5PVwRWL+E25wWQ
 hv/jS1uUjBFbg5C69p1pvbeXqfmZWtcx7MDO3IF7Lhlqk0P+IeySEeeNtmAGMOc2d96e
 q9+eVbrk1MNZ9GPA9nBgmKGUOtDL323+A8Z8KHH8+Uv8zExsytMhhiqIy2ECyLySKErL
 mBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676122; x=1791280922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nPo555MX95A4dQjnAX09dz9zclW296ACMm7gAyXXzss=;
 b=GKGj/URvlaZ4kEO07zRyDgyug7tq9UBH01/shPsHHxVyhSsnOP1OlnUoX5hrGBiBl4
 pt5y7j27R+uUyjPNnPLrioI+6q6R8kSD43Ae0193jR6wah98XwWTkybHTRJj4ctosAfG
 1NZ/eNq6McBQb5AAV0cZCn9JEZBvoWWJ+nxtggG4NPGzLXgW+mSISLpYRzpcC2xIm18t
 OIvFZGiL23TKG9Kb/3HmJb9flK1cqb6OFn92uVBu/TArWGpb4eb/DZ+TgAkg49mQQmSj
 X2P8ALOv/s49ADcWwUTurjs+NDKdFCWQFgbf2SMSlTPRD5b+hSAIbQv4sUMN1dedSLbB
 EVoA==
X-Gm-Message-State: AFq9FYKCSeWo7eJsGYRMxfPQwx1aeYi6bACyP6CLOVvpipbCFxIH+n+Y
 mbBnwQiBGSjqktBc08DDgdGvOCnLiQw76sOXIzrO34VB9wGm4o3vSMJVpaTWfPePxs3LAau80g2
 VXO7K
X-Gm-Gg: AYBFou1DMhDyxYmAIIIhzBYL0msLBcaNsyZfxSItc328nXQpYaksqJbSOPalB2QEDMy
 z3/MGxYaG2xZY/GJXTHBRhjBQe6XYq8Mc65PqeetPmveJazysJqHUasEyGQzTXTbRT8hU8Htebi
 WKoqyzOOxqkYlSOSm0x/eWsSZDtV/wlgQj7/krOqQ6p2A89KGRarxq9k5KF2gJ72uWbwda39kO9
 9ljJoT35JqsPkni69ko5d47vLyckxnsmH3+MzCBZgYJaJX6bzsbiX8yA/TdOHgXXqL+JRi2uaAx
 U68JR3rmPJLBqJTfAYnHJZllW7kAPUiJu9Prc6GM6mGnk8ncAbx8KSJ/Z9JSvjNPwqIsPY+mRtV
 e0Izk/bZM3JN+97zDajIOLKwGChAwPUSlbdOj7WwyinYfoLi6f8ZbvIxS5d+jb7QLe+0lejhNxC
 1F6hWHXrnKN0193e9uyoS/K2FS5Qps784myfFfRkPqgmsI/zne1voRrnDhkXLmWgSHIgn+t6S9a
 2PWMu65f5+rJA+u0jUXo0fbZiFkDz7A8chx5yo2Tho16ZdVsnPNYyxUjY/4TVuVXVA/4f1MRnfO
 Bw4=
X-Received: by 2002:a05:6000:2482:b0:48a:f592:fb63 with SMTP id
 ffacd0b85a97d-48af592fd2fmr1721189f8f.1.1790676121752; 
 Tue, 29 Sep 2026 03:02:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/37] target/arm: Move ESR_EL1 definition to
 vmsa_pmsa_cp_reginfo
Date: Tue, 29 Sep 2026 11:01:12 +0100
Message-ID: <20260929100133.2598676-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Currently we define ESR_EL1 in vmsa_cp_reginfo[], but ESR_EL1 isn't
VMSA specific.  This doesn't matter for "is the register visible when
it should be?", because currently all our AArch64 CPUs are VMSA.  But
it does matter for migration, because the DFSR definition in
vmsa_pmsa_cp_reginfo[] is marked ARM_CP_ALIAS on the assumption that
the migration of cp15.dfsr_ns will be handled by migrating esr_el[1],
which is the same underlying field in the CPU state.

Move ESR_EL1 to vmsa_pmsa_cp_reginfo[]; this will fix the lack of
migration of DFSR for R-profile CPUs.  This is a migration break for
those CPUs, but none of them are used in versioned machine types.

(The S banked DFSR is already migrated, because we register ESR_EL3
in el3_cp_reginfo[] if EL3 exists, regardless of whether we have VMSA
or PMSA.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-6-peter.maydell@linaro.org
---
 target/arm/helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c2e94153634..5f930f6fa8f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2894,6 +2894,14 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
+    { .name = "ESR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .fgt = FGT_ESR_EL1,
+      .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 2, 0),
+      .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "DFSR", .cp = 15, .crn = 5, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm, .type = ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dfsr_s),
@@ -2918,14 +2926,6 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
 };
 
 static const ARMCPRegInfo vmsa_cp_reginfo[] = {
-    { .name = "ESR_EL1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_tvm_trvm,
-      .fgt = FGT_ESR_EL1,
-      .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
-      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 2, 0),
-      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 2, 0),
-      .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
-- 
2.43.0


