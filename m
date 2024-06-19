Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD0DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pc-0002F9-3C; Wed, 19 Jun 2024 17:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PT-0002C8-Pm
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:05 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PQ-0000KD-U4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:02 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6e4dbca52f0so177480a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830799; x=1719435599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1R6PniPLNMWr5brkBomFlTCMhKgUFohFxAyFLb2Rr/U=;
 b=DwsPC9pHX3XZFzx0xbIkplf+dwcEYudnU/nKLbORf1k7v4aFI8XqLvp7WqGDtTOcJC
 KXXQlPv3C9WSUdgsLxsxa2DSl6tajdOZ+ECdk7sZGqC1xFR0+5igBrwRk0h031dlvK/2
 xDoaBkgN4qVh32SHCBjJ2f0d00i8PuBkEEDffCYTbwwKatuC+0TKnE5eDVJowqzj3INq
 +lb24o+hppp3tqCOSGx/hy3KZtltuibGSQ/5kvnx3uYlnYeX1UsRc2pats50MaBe70xu
 LZ6r1on4WbF5uEkxwEag7+pUNTS1GrQWzFu5yoGpUXNq9YLRh7Dj/zbtESl96dIEgYhg
 XTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830799; x=1719435599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1R6PniPLNMWr5brkBomFlTCMhKgUFohFxAyFLb2Rr/U=;
 b=XgI21Eb2T5ghtw9QIYi6361oC0fsxTa41bCOGdX9DNi2zAVFy34PunmZPq96VM7yva
 OocIIjua2Ey9HL6wgEVu2kYPRLRadW0zJJj0KIQb2xpRRmxhylSAPXtk0O40z8wEmGG8
 SleOxB/5vCZnGTPiJAIrRJF6XTg+2GmvHnG1+btRFofw9sLsUITH7CRLkDJpX9uEo2IE
 VgHR8NrURkaRq/S8oRlS0NXfwRvvkMrw6KgFuAsPDotmReEXYWNsezV6vyuJoRX1DFZ+
 sqsBRO6b0Ctar7Yna8b5UoNTFeWRip2ETQi7IvL2awhFztsVSfzcUGFtlE3Kk6kkkrZU
 uv2w==
X-Gm-Message-State: AOJu0YwbkKDmk4vLcAQ9A455MaHkr2A2XdIBgnKA6RP8vf7GCAtuhEhP
 Mj4uwZrSWnUFwzPuNSaVH2KIBuKAmPSNjHQcqAu7pERryFo3cD/gb85YQrfQRnAXDjIOSM3KIVi
 O
X-Google-Smtp-Source: AGHT+IFpTRNcv0313QMDfjFS1Ep11oQST3wo1aTJLp2Xa6fm9pV4nuub5XHsndlPuI9o5zKIHLDVnA==
X-Received: by 2002:a17:902:f68f:b0:1f6:673c:ff2f with SMTP id
 d9443c01a7336-1f9aa472200mr39234485ad.68.1718830799082; 
 Wed, 19 Jun 2024 13:59:59 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/24] tcg/loongarch64: Simplify tcg_out_dup_vec
Date: Wed, 19 Jun 2024 13:59:34 -0700
Message-Id: <20240619205952.235946-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 980ea10211..b1d652355d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1674,22 +1674,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
-    switch (vece) {
-    case MO_8:
-        tcg_out_opc_vreplgr2vr_b(s, rd, rs);
-        break;
-    case MO_16:
-        tcg_out_opc_vreplgr2vr_h(s, rd, rs);
-        break;
-    case MO_32:
-        tcg_out_opc_vreplgr2vr_w(s, rd, rs);
-        break;
-    case MO_64:
-        tcg_out_opc_vreplgr2vr_d(s, rd, rs);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    static const LoongArchInsn repl_insn[4] = {
+        OPC_VREPLGR2VR_B, OPC_VREPLGR2VR_H, OPC_VREPLGR2VR_W, OPC_VREPLGR2VR_D
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_out32(s, encode_vdj_insn(repl_insn[vece], rd, rs));
     return true;
 }
 
-- 
2.34.1


