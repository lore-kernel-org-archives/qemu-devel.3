Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A763BC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsPe-0007Vp-SL; Fri, 31 Jul 2026 14:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPO-0007PH-46
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPK-0002BE-QX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc891373e0so14332385ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524190; x=1786128990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlOhR5U7/uV9vGGNut8ZfzjLrEkIzDJiUisc0wTeYk4=;
 b=PQ+ss0rc5cFLFVpPYs9MFg1slG8T5gWjOpsVdghbePkb+KEiBCMZn76HDNNGzGOMse
 N+tT8SaefTPUMkjpGj+EqUvfjZUWDtpuN23TGtmMafc5vv7nHnv1NK4XTFCFz/NPcRF1
 fg+IhwNVppFu+l9a3HjajyShQLoPjkhrMLx41a5Snxm1POwAOu90eroSlDULqMe29Lq4
 ifrCT3OSMm4p03mkXJzcu/JxMl9V+7K8+Bp77KkC9PXDXvu6MGlyFPLmCDFl5vkWDIRf
 wxH/hghRtEkw8PsmIqD/djPJoz+hMLPAsht/yaPMaLgW3sCoxphWAXelb6juG8U0FZ1s
 x3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524190; x=1786128990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlOhR5U7/uV9vGGNut8ZfzjLrEkIzDJiUisc0wTeYk4=;
 b=B+AcYqWeOrH3WFKobDKczkr7Y796NsPL54dnBSx/a9WS/fbJZ9A8JjHboynB0lArVA
 9KM9dXEDDrSxAnLseeGc1pDMbaiHokzH42DTprdhMGDiVx+DojMMrmtAnCCqz4pwy8m8
 ib9APQ5E2z9eaUdRaSDytKR3w/xdwPzQwINU7mx+NwZ2P7L00C4HGvx3QoEl1h3q3npB
 yRSLjHW7c0Ud7fws5WliXNEFmFxTFG7R6glESqUis132fSjJWga0rPUO/tTAgpVZHSec
 YiFvpQTCLVtRC8ajnonY3mb5KffjVN8nxGkilpwGU12BgJPxiU9mwBno79QEQFTWZB4G
 tpuQ==
X-Gm-Message-State: AOJu0YwqktN5wNl8LYBrxRDbpTTfoDxs7Y2gxG+Ep/XjCkJ2jwmlCjnk
 /LWCyD/YNVGo5gres1tmAQLvCg3YDIGqC21ZXzDfo27Xtmz2z4roxzEGGwlRuXdm++KzZ85W89x
 SS2Gj
X-Gm-Gg: AR+sD10gQh1oJXCW9/G1alBa1PZ58ffSTcrXdejSLzIdKxCzRIT3y8YGqby8kUG2lmL
 SEcL24WTL5MTmSmVf02sj/JVR0EAGQIyW0tP35anr8ioS1Ii5zS0MTtX7stv7ReiV3TtBLK1t16
 1NRHAEBjLSiWFiHNOIk60+jrcEKPGSlAz3zI0ultZye2Y9w7l2PVKOA9KXyHCyP3mppB9zGRtoQ
 dEvyWHTvGM1PXeQytQolrhxxv38hLDec8gAVTeTaXQSSEFQwmN7nG/4sshubK+c9OcCn/j15N7Z
 FUBcwA4jeY4oCW0RBMpyYgNlNgBQC3gkFvWsJ+zUj/txSwzJ5Mc9DSMp84rH/iyD2g1jBOeoYLN
 ic0+ERn07Y+EH0xL0c2yl16S/cfllP/5rmKCjQkluolCbI8ILbMWXpl3+qyNKAhd7KWzXdvpOS2
 xV0QnRaHzdr52qR0Bp9gPMWDN9Vil3WnQU00MUnRe0DMV1ojgsK5cti86DW9soL+KxJSHe89Gme
 jdP+alEBrIGuD0w8u++
X-Received: by 2002:a17:902:ce0d:b0:2c9:97a7:b1eb with SMTP id
 d9443c01a7336-2d0524723e0mr8695835ad.42.1785524190292; 
 Fri, 31 Jul 2026 11:56:30 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 01/14] target/s390x: Convert op_ld8s to op_ld
Date: Fri, 31 Jul 2026 11:56:14 -0700
Message-ID: <20260731185628.23161-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Begin unifying load operations by storing MemOp in insn->data.
Start with op_ld8s.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     | 4 ++--
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 82165ac1ec..25a7842409 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2749,9 +2749,9 @@ static DisasJumpType op_llgt(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld8s(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_SB);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), s->insn->data);
     return DISAS_NEXT;
 }
 
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0d5392eac5..989e40ce34 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -481,10 +481,10 @@
 /* LOAD BYTE */
     C(0xb926, LBR,     RRE,   EI,  0, r2_8s, 0, r1_32, mov2, 0)
     C(0xb906, LGBR,    RRE,   EI,  0, r2_8s, 0, r1, mov2, 0)
-    C(0xe376, LB,      RXY_a, LD,  0, a2, new, r1_32, ld8s, 0)
-    C(0xe377, LGB,     RXY_a, LD,  0, a2, r1, 0, ld8s, 0)
+    D(0xe376, LB,      RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_SB)
+    D(0xe377, LGB,     RXY_a, LD,  0, a2, r1, 0, ld, 0, MO_SB)
 /* LOAD BYTE HIGH */
-    C(0xe3c0, LBH,     RXY_a, HW,  0, a2, new, r1_32h, ld8s, 0)
+    D(0xe3c0, LBH,     RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_SB)
 /* LOAD COMPLEMENT */
     C(0x1300, LCR,     RR_a,  Z,   0, r2, new, r1_32, neg, neg32)
     C(0xb903, LCGR,    RRE,   Z,   0, r2, r1, 0, neg, neg64)
-- 
2.43.0


