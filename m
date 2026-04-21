Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E7BF55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3S0-0008Kx-Sy; Tue, 21 Apr 2026 01:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RK-0007zi-JW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RI-0006S5-Sa
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so16747565ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748463; x=1777353263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/eF6UxrydbmzCRXNoWVc07UBJDv6wjeDkTY/rB2YuA=;
 b=S0O5fUqfJZc0h1mUXKbWRdu3BT9gOHU2T9Ya41lnyB+twSinZNNx310O6ysDF8LWat
 r+uDvNjHTqXmZSrx4CDi80/XZhYPsfets2x/k76QxI0K4S2aF5lsyOQVDlbHOFBwJX7p
 7xAnFTqWet0yUOHGAXbB3y5gFQTUms3o68fg4PUzfiVXcHTkRKY6fvNDVe0ES2Ngj8Sr
 T+k97HXCgJIQKNzkA892kTUk2+fN8EKrDFGzefJMe3awNlMoTh/rqwZ6XxmTYcPE/cA8
 sCUUslPLT5jrtxE7bt86V5HU1zGECOi71Z1GiEwcrpcJoXUhoI0hpOenWWIzdnt6XZ1J
 ajXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748463; x=1777353263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q/eF6UxrydbmzCRXNoWVc07UBJDv6wjeDkTY/rB2YuA=;
 b=O1aq7oJZ37qbXB+IjD24JrkOinxVRdIHplNHDwGSO0WWNRCZuzRLFYcy11P77zxgM7
 af17yRQOkGF6vHqYxm1NspUHRf3lH7LL0JieoO6lPXk+mWKXnqHExWZuSbAjfyrf1pYC
 HKIuXRJcGFjIh9/RapIIUC8znD4aaUEvKXZvVCSvbJMpl1CnZ4Fnxy/g6kf0ffDnvxph
 16PkDP6tUOxz+FteZWNI40LkLBPsgeEYda6Mw8v8RpBfpMV8Uj5ctBAtCC6MpQYPN2GQ
 GXchWRfMLMf3Qy5PV6uAURv2Wpz9UIB1HgsyM6gVQX+hojQUSQ0LtxS+AvX4lFl+ej46
 06Ig==
X-Gm-Message-State: AOJu0YzWzjKsthQd6W8pRl7yKCl7AHj8ao/iZlfgLwd4KhpfBFgij0gp
 akCaRDPVXDWIUkAHKBvEjUktbEdyo57feau+fBq43nsAEqn8Ct21la4HOJGGncmKO4wMdbgTFDy
 zkFP32kY=
X-Gm-Gg: AeBDieswMWyYAfpPrpZxV20EAH4J74Y8ELEVxYR6wjgu/hDOI0fRjKmiLPieFIoYFqO
 XUBzfcNrxhyQFXxDxatfak9ASG3btQneAIZMrh5gTZ0Yk2q8Y1m/Vvo4MoHyhXGx++vQZy83msm
 d8nKYjDRCXtSL0q5rgfTN4bZXdu5rOSyXEThF2G0+05K5ghn0G8OTcbZvw482DGm0Nn39DyZqs4
 ttlPtQRbPQxxmgBvgxOlvSStHMR58zeZ+xH+4Vx+IhcY7OkJVGEedizz7gvpKwtijg3Kwfjr32c
 CPN7D1ZM8WGNqbGpjtFfiatY+oq5BErIKLUNE7VF0hd58xCJUZSf4xrxpGCfCXSn1Eej3YSOmA9
 yP/s5u8zKYWnxzi9MVLXusxb+nLLlo4qFUtc1s0lzV4vzSoUvrUaL3AKzAhagfPjJAYpLFhphB6
 sf/KZktrynVT733X2LG39NAHv904iFcOMM9vj27X5d
X-Received: by 2002:a17:902:aa98:b0:2b4:5cb8:99eb with SMTP id
 d9443c01a7336-2b5f9f8808amr126443295ad.27.1776748462900; 
 Mon, 20 Apr 2026 22:14:22 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/37] target/arm: Trap direct acceses to FPMR
Date: Tue, 21 Apr 2026 15:13:22 +1000
Message-ID: <20260421051346.41106-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ef6038e98b..d132e051ca 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2898,6 +2898,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


