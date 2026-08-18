Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B9C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCs-0007hm-Ie; Tue, 18 Aug 2026 13:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCr-0007gn-5K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCp-0004rP-NC
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso145514b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072550; x=1787677350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1g1jwGxUmfnS3pxw6qSk0+WiXgPGC6AGTRxMMonvsBA=;
 b=clnlUQ4CaxGhitx7ubJYGjUhrxUGz7l5kb5AigSDa4RrAFkYjvUqbyVNoLxVduuKQ0
 pvHjgdwqYx1rWs25PavUgCDIBC/7Vif+RMrhmOabxdB/MDtp1rgUiuSU+R3y43NBsEpG
 gneM/jm04FTYb7FGHNzjPvAmdX/PNsy2ufRz+Z0bZr/oIDbEB8WuCSIWsJUGZB5jEO8y
 aAK/aDTHtSVwuaEWzUxYN8TL/RqoYCEhUd6DHFiEm3kLREUlYaaT6QwsexTZ6xwz91Al
 wwP41X1ISjS4Uixftw60RfVPswMXS3y2rXvEI1MYh9Qrd0A/Jt0xItnrgi1uwWskVQPd
 gBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072550; x=1787677350;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1g1jwGxUmfnS3pxw6qSk0+WiXgPGC6AGTRxMMonvsBA=;
 b=YHpNGbWviqm7xWR2irwc9Qd/ZRLOQu4KKVk8Y84veVX7/veE1kN1f8H+rzuf5X8ryP
 vV1cS4EQMhLeum+mYRHEftyxDVEsD45zZvVr9MAtujmBuksNs2VpPx4FeJt0ojRNm6bD
 KX2/QWCmjOjbD66dcrOnhhMVAlJMg52Opd8YjYLpUa8QpS87BX9Q56yK8m86KVWx/6UK
 FTV4g/cffIQIweHxmxxE2GGXsGrb6Xu0hTWmi0466qoR8Ue1FSMdJdtPg6NrAwoBGUUo
 jM4TdWsWS5w6fKbQUwd53PNFPzywEWt4VjWEWDCXJ8RVjsJyWOKtjvOeaBOwT06yl3eC
 9CdQ==
X-Gm-Message-State: AOJu0YyfzKrgmVO5WZhZmWwcGtQtq0VarfiSf3B5+ZttaUWW4LFWGcHe
 1CoenAN+g4K05QRQQtSsVkglosLZfWePCrMRxKZecIIoGFdmG7l/L7UN10z+jzaWuS1rsQMmGqn
 KM6hYQYE=
X-Gm-Gg: AR+sD13/vsdfcziY/5oq2VBCcgkk5+TJOYCLJA+Gd0jrwLrg62w5/a6NMGPVPijgZmQ
 BhOBqv0LJgGjboJ1laJVNmTgNtUuVhGcK4FO8viGZ2nChxfMrRfKSyr5KQcyOcUx4LQmpUe5VP2
 sKouimtPaC+GFnHwin4+dQdjZmVeAb1SVgzFLy0EWXKllNR/2wLhrwj9RTWnslyFoQsf6AEvdpk
 S42tEpvXFOhjHXUimoNoJc7z0dho+6Gmf2Wo9Ot8OUX06yO+0OA/TjGQ0Zo4sU4OKBxRCCGJyWW
 IGQaXYAO8IdgksDsl+iNi9l0puDMB/5Abkt6r8wMAz9u0jRG2rcL2ONPWUoojkcOCq3bP6GHbBF
 iqKU/InswBOqYaVElR9r9XjZmjwfU9E6+NhFT6+0IMRAH7nomak7BJDduP35TQuQRyxNJa2Di2y
 DOQgFzKvbb54A0Y9kNdwQAKxVxERBreZWIsviKH6JrnOBoNqFG+cW9GGpVpnXUyPHBoEM1TbzeJ
 XaxKpSm6KwtARYa49nx3yXJANKgiWUZGto=
X-Received: by 2002:a05:6a00:ba8d:b0:848:4ff5:5316 with SMTP id
 d2e1a72fcca58-84fde224682mr37795530b3a.19.1787072550365; 
 Tue, 18 Aug 2026 10:02:30 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 28/38] tcg/aarch64: Implement ctpop with FEAT_CSSC
Date: Tue, 18 Aug 2026 10:01:45 -0700
Message-ID: <20260818170155.1907006-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 55b3be0b96..1f784e8d46 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -535,6 +535,7 @@ typedef enum {
 
     /* Data-processing (1 source) instructions.  */
     Irr_sf_CLZ         = 0x5ac01000,
+    Irr_sf_CNT         = 0x5ac01c00,
     Irr_sf_RBIT        = 0x5ac00000,
     Irr_sf_REV         = 0x5ac00000, /* + size << 10 */
 
@@ -2251,8 +2252,20 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_CSSC ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_insn(s, rr_sf, CNT, type, a0, a1);
+}
+
 static const TCGOutOpUnary outop_ctpop = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
 };
 
 static void tgen_ctz(TCGContext *s, TCGType type,
-- 
2.43.0


