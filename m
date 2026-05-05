Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F4DFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDp9-0007G0-FB; Tue, 05 May 2026 07:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDp7-0007Ej-KP
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:20:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDp5-0005pJ-ER
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:20:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so2754460f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777980018; x=1778584818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
 b=VcEbhw/t7kKXz1zdaXb8ZiTotxl5PlrjAet853UXSBa3SxJTnFZelbv2uwB0TC9cQE
 bj/PenbWoV0OHMKlKuEhX0L2H/dD0jkFYl2HCm/DSa10ZatrRPkF/jOm9XXQdhnKKleJ
 5eb9XXBeadOxGVTaMDfdyJDCJLoaWOQ4up+ZI1KM10V6+/ScYubuZKrIaIHenVpRAF08
 RhwjiRVm8b2zPvY/vHVFP1H7V949x/XCDdh7hWX3/5hrdhC2SeUYKKyBV5N02mfTjLJt
 ATHrJkvRnGkzRcK3BQbdB4to+D6AFTbRnl/X70WCysOrcdLp1CCg0Lf6+mZL6/4/zebg
 cQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777980018; x=1778584818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
 b=p1oTX0usPXLO2cKHxfjk8eKnj8t+fDole5ln3xHc0RBTz3T/dR00RnEXJR89NyvdBW
 xMKRNEXIu0acghTAPgEyGNVMcSLL5LkkdVyuY0q7LnEPPH1Kh89pGt0ht18R1hX0YLV0
 lLSAim2p1BOQlypybfGpwStxkfFkhJ4VTrBE18OAWU+JE/EobD9iG1rT9zveyxhjikuu
 V779f+7npcLXoS8LrVw/Rtdx/m9k6ZuDlUg+4vInr1MalKuX2rY+bG9hD7vdRcu/niN5
 OmHk78PgYo2Hq0Z42/tlIZguGWYOfcH9dTjw4N4vdh1Yep7Cjp3Jw4edYeneEseX1biE
 4Wug==
X-Gm-Message-State: AOJu0YwIm5uBaQfP0s6DWTZ0/5h3QItizuyyUisyUrS4XJ4t45Qz+UHB
 kY6qaPyFELkPOq1Oua4qsH3f5cbexwnm4iwh0ykqHGmz7UCQ+MB7K3sG4x/Gm7fEFQg=
X-Gm-Gg: AeBDieu4/n6AbCUyBq4jvmCW6X68W6Cak+L4vCO72Nebsh47n0PavwQpMcS8ZyBqUSN
 WtGSxw2v+x9Lzv+lwhktWsmsPDxrtIXC7wjZY7CglDeMyYhz+ZM+QoSgyEXDz0vQyvZCZxjkD86
 AvUp5IMD8FciMGmBZjk6XQR7ljolYBJWCyo7hm10nyit8yleJsQmSA/49dsM/X60qAvettx/kY4
 DUCJshqG32UQmOZ49+23TyZCRo5ALVs9bW4qdC6WzRTrt0l4XegbquA4C1w0+V5+5nb08TMNH4L
 Genak/74O8cXlspn+DS2F2GtJqCuDQPMihKm9CD1SjwdHaU6IpHl3NBJFJG2tcegBCrMDwUl+sB
 /Izzuq7yBE615TcThMWimY15dIqIsSDoYK21GtUJqQLqQM7udJkwOf6/H/17bcW9ZfGRTMrae1P
 gIGTrI6dmx84+YndSfTpw3f/F2OHTUhWOU9Q==
X-Received: by 2002:a5d:5f87:0:b0:44f:f8f2:665a with SMTP id
 ffacd0b85a97d-44ff8f26672mr5117226f8f.10.1777980017867; 
 Tue, 05 May 2026 04:20:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03d59sm3787813f8f.20.2026.05.05.04.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92A0C5F9CD;
 Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 3/7] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Tue,  5 May 2026 12:20:09 +0100
Message-ID: <20260505112014.102993-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505112014.102993-1-alex.bennee@linaro.org>
References: <20260505112014.102993-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

This mirrors the logic for DISAS_WFE in 32 bit world. As the WFE/WFI
have similar behaviours shuffle the case statements around a little
and update the commentary to cover both.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - shuffle case statements, unify the comments.
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec7..25f0a806512 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10916,25 +10916,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-        case DISAS_WFE:
-            gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
-            break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
             gen_helper_yield(tcg_env);
             break;
+        /*
+         * Both WFE/WFI can cause exceptions or exit the loop to
+         * halt so we have to make sure we have rectified the PC.
+         * However they can also return directly if they don't
+         * enter a wait state so we must add an exit block so we exit
+         * the loop and check for interrupts.
+         */
+        case DISAS_WFE:
+            gen_a64_update_pc(dc, 4);
+            gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
+            break;
         case DISAS_WFI:
-            /*
-             * This is a special case because we don't want to just halt
-             * the CPU if trying to debug across a WFI.
-             */
             gen_a64_update_pc(dc, 4);
             gen_helper_wfi(tcg_env, tcg_constant_i32(4));
-            /*
-             * The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts anyway.
-             */
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
-- 
2.47.3


