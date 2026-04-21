Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DDDF55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Rz-0008Ju-Nd; Tue, 21 Apr 2026 01:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RE-0007xl-Iz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RA-0006Mg-QT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aaed195901so16373935ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748453; x=1777353253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bB3Celgz6ONoUj0JAK8UxtldJtL9rndv5ruwK3rAIow=;
 b=JUNR62jvpAyaM6oxISq/E1DwYmDJ/vCVU22hcjJKyI4uK4Fg8Ydfla14X0WzjZaJu5
 R7HDEFX13jN0zXbOn52IxN6HmJHi78ZUui6/WxJGLQ2XxPDwtIXxbrSLrIjRzeVGv90o
 zVsRGuLGpHr+bu/d+tRiCdC8N4XITgcmVMxjgvmyy4t8Mf9Milh7393fnM6k7qQocSsN
 3simJIVzaIfaiD1Ickqxp6ZUKteS0gOTvc20no8ZpWqhgFObwDVX/hZI1BdakcNM0mX7
 bZ94s5GQJfDUYL4WqTYJcKpb/Bt/AVuXfvCB951JiG+z8ZF7qsna2z5+W1tbVqLrDRvW
 +jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748453; x=1777353253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bB3Celgz6ONoUj0JAK8UxtldJtL9rndv5ruwK3rAIow=;
 b=h4Fr7UROLBEUCL3Uaz3dlfdooWo+J2y8bmN2kgKGIpo643kgxSK9uI72iclNl/clHc
 zdL3rBUUhpXbdXLcuaQfJWze+qUuSO1sX8D/46lGPVTEqo0MSBRifOVH738rCZ4CsXVv
 I7yjH4vuWs895tZT8oINqfbl409IbDAPTagxsod+FJkoJG4vv0O8WMWW7RuBrHTQKljb
 VwjBt1549YpO++1VJEe5svrkpfXAQwmnvNCJkD4iaamRAVv6JV1OW3c16swPFCdU7Eby
 oID+6ujjKqCCwcuzx47eq7opjZWStm0Se99wcv1zJzlWW8f0Ar3HwHC6NB7wn6mp7vQQ
 YIwg==
X-Gm-Message-State: AOJu0YxFnV9dIfI4HraGJgwP7hIMdEysHpRFsVipfezD9Y8xu6fAxXbX
 b/f3tJOFCGRTqWCLDPEolfwpTCb1kJz/4L/G1E7Fxe1wt+JJOrOG7vEGDTf18B+gImuDl+U5Ifg
 LiQRVNTg=
X-Gm-Gg: AeBDietOLMHyLdPrTUf8G4pDtGecmTb2v+bQjT7qunbqn+Oi+x/eZW6qlHL787YlHqT
 vH5EBh8XCi+3Juekw7Vo+MfxTZBRlvNkVeUdnPTmDUaZOJkVRG/BncZiSIq7NzWg/scWEzkDI54
 cM0V0NVzdhFfBCxONmzQ9oDCLEXLu+Swtao1rRpf3GbKRXpBsbuwMkcvAMwugC9DJZkThQ9Ro6l
 353tNAFl/KPVbf38bE1thtDi9dAGuV8/AWdTN822Si3054QM7TB8JVyqULF8EBQ6hwCd9+2iqbN
 zoAYGGoQ+qbls+cB6btXho4YDO2om0PFSCBNnG3BF8eJU14rQrHTmOuiI/KPH6Vl/2RWxyCVRDE
 fxHs3MD2zvRPBL7Q8560Fo9D6d8yG6898K/BoFL2olYhqIliVHl9cBIYrxvvivqjvPhw8nhuVoY
 r0DsArDt0476BrpFAZuOkVoagnf5rGRGL9zadNrHuU
X-Received: by 2002:a17:902:7003:b0:2b0:bed1:46f7 with SMTP id
 d9443c01a7336-2b5f9fdfb9bmr116830295ad.37.1776748453334; 
 Mon, 20 Apr 2026 22:14:13 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/37] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Tue, 21 Apr 2026 15:13:18 +1000
Message-ID: <20260421051346.41106-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 38deea01bc..deab811ba4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1459,6 +1459,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


