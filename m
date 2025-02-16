Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080CFC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyj-00005e-Cx; Sun, 16 Feb 2025 18:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwx-0004hx-Vq
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:24 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwq-0006Vs-P6
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:23 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fbffe0254fso7025030a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748075; x=1740352875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E2yGX843ehTy34ZyeZGFsTZ8T/gWZ/tMtASHWtzGxfA=;
 b=UXLktcwROdleE6MMhRWifIVf4Ts5rOKw04NWcJ/Ks1NVbUK3Qbjg8OHKX0/5zCsL6u
 8DCVLPKzh2Mq+ICUgRhENGYGR0TzIRn/gI8BUt13y3aEPZ2sQTXeaCk0FlLclXiHJtPW
 494mQop7HkZDJE4X4WlPa+hkMK1k8Q1jb8wZUzVr4//udqv/VoMcvFoM2UXoJ4Y5khTp
 odPzDhOFKIYWoaZxGbvj1hJxY/tY9MYzVtN4DSJwBXG7IQJYWXEtVE+H0nCNBw8czUVz
 PbR7Zf29r1Oc/q3NEdxWEaR/zD8O16yQsYEMaegZ0tAfxbkxsbIu4BP4GWX0VwbHDcgj
 7/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748075; x=1740352875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2yGX843ehTy34ZyeZGFsTZ8T/gWZ/tMtASHWtzGxfA=;
 b=cP1yJ6jrGxLUHohpdVblNRIoiL6ytDDx38wHR8koSxS3MJEDkSTP0OTvNwF0A+79xz
 S7dD0LspX4h8nqVhxtShWBndeGE2r0JNEhJ8FMU/pGP8flmdAdziX9Dv54ntYjUmx7Lz
 sLAx27omLXvgFJkaJChkFe65R6mGnEJszDkQDZtpB9PwJzQ0ZNY1A5iAu9BTmxozDYdF
 wB64l5k/YjK0cV565wm36ODTUZyXp1A/gmEWFx3xlWnvljeO+LPQYizW5z7trb3Zqsp9
 7MwXSXyEK4XwU17eaAkh19JPSJVLJgv4gW2nHRNQzN7yE6j26dKzVADed8TNeIbWUysP
 G42w==
X-Gm-Message-State: AOJu0Ywbwb2hQGqkzuBTDHLw8t54YnwaIn1oT939LIydVqccOLqceQEC
 jEwyMUt7Qx7Srr8kp6Siris3NU7HniNk07/I+edxPqMJlgkznOCZmb0JQmuPM4d9p7m7gWDAc+H
 0
X-Gm-Gg: ASbGnctb9At+A8B4T3IfKwo+SdyfIRXlLCO02m/2RL388gGRqKCsH0r2B0PPPjwqxNg
 nHJ7/4TDgkhZ70sS4wpHA+CMcjGyop0fdCA33uF6pGYNz/ttk0KkRNu9KWMK9XvT0nEtonKb/x6
 ERwGykON0QmuUeO1km+znQHOSoPsZoww8Ef8TG0thAEchQ5ZioIG9Qth06Vf0z52bmgS4rHqSg0
 5OXUrX79GsohLTyB66Xq24ftaPmKf/zUsugItG7kx80ogkUzF+sv+WwnHlUBw0wuxhLWmPogFGs
 tKJPX8eiBij9FL68mjtPD7d2BDaOhPHmed2DN3w6ANNSrOo=
X-Google-Smtp-Source: AGHT+IES23VnIaWknDqn/zRRLZJ/LP/D3zBqqoAA3BpdlqTDhamE5LRNhk5IJ4Zbdc7QfkHpwBaj1g==
X-Received: by 2002:a17:90b:35c6:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-2fc40f105bamr10828036a91.8.1739748074972; 
 Sun, 16 Feb 2025 15:21:14 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 157/162] tcg: Stash MemOp size in TCGOP_FLAGS
Date: Sun, 16 Feb 2025 15:10:06 -0800
Message-ID: <20250216231012.2808572-158-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This will enable removing INDEX_op_qemu_st8_*_i32,
by exposing the operand size to constraint selection.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 73838e2701..b0872d6637 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -91,11 +91,15 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
                      TCGTemp *addr, MemOpIdx oi)
 {
+    TCGOp *op;
+
     if (vh) {
-        tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
+        op = tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
+                         temp_arg(addr), oi);
     } else {
-        tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
+        op = tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
     }
+    TCGOP_FLAGS(op) = get_memop(oi) & MO_SIZE;
 }
 
 static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
-- 
2.43.0


