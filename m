Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F29CC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUe-0007RY-W6; Wed, 12 Aug 2026 18:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUd-0007P2-1g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:15 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUZ-00013D-02
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:14 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so1391873a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573930; x=1787178730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ckt/pnsMJH+j62K1WhwdIZTXPxUbXNDNqiVkG4izvFI=;
 b=yUyRUqsM26tT1H77FV52ddJoTIMhFw9lQj/gUmamzFHEAGiHbD3k3yUHNQDXG4oUjx
 a+SJtUAVoFtlGLVvXg+6SZrUjfiRtn+mqhJ+g9jrnJ9zSSkn4xbUxczt8lKqWAVFY7tX
 5d+kwFT7KVd3nmmTRJR42dQy62Zc3RgPMdh1SqZ525LwuiOUcjA5kfNh8v+3rFR+m2fF
 ihG0VdaJ04k6XF7nS6M8LGylVhrCjVA1M9TiZPkaGxSZRJ6BFNwSGpAP7n+QpxyFMxLM
 rz54mgv/ET7Osi+TMK8kFhAlhrYdZgT1u3lDYzUQlZOUZsvYaWwRfVYM42wcbr0pEoOH
 xS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573930; x=1787178730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ckt/pnsMJH+j62K1WhwdIZTXPxUbXNDNqiVkG4izvFI=;
 b=g389Lk12nxnDeXjiWvD1alSFSHq7IIou+x2wumEN8vpkb4bpJSe40sUOAhcMrAoY2a
 poRUNTzGPI98pehoe8Y+ZbchYgjyWpwVHo5k9STxs9Y9GPwYzzwpk2hS5Um8+X+ZMzVr
 Msk8zDjwT/cWld0e1DwU+qIir85n7iV0BhItLZ/U7SnIJIwuPCxV1zc6jacUlbS0+drL
 unaQwDMkeQPcd9Lrv3yOjjAJnPBSB2x9KvTvRMwDIslDfkh3uuKwT/DPHy68lAxz3Dpy
 B7p82sYALy0gW22tUd2dBAtRr1x070dfuu6vr6QAaYuVqndp1ZE7C6Ao2rU37wtxZXip
 gfKw==
X-Gm-Message-State: AOJu0YwNehLsSZlhLm6gPWljBd+vU9vVMlfwcuKzVfxP8J95ykbt9CI5
 HMk+SFiPJKOkKUnKrHmCnPeDJ9b0BRRz5z6hBRzJYVvFGjf21Lxjgu4yTbRb1wu8Rq4COmKGDM3
 z2m0r
X-Gm-Gg: AR+sD11kV7/ZZfaksTK6vOm8p0obm8oXzYpSTKYO4BxpnevWpo6h5yhmtTuKUo0LtYG
 8N87Pm60eYkfVPF0oziMBW4zT9iY03w+znSs/KR+gXrMSZtIk6tCShmQacrk2SQHQzAqwKZufhD
 C1wkjm98ViUBnjgv2SNAg0CWrLVhGposCSoQqV38H0DdzloPSjAygHBlixf/kzbKPjWIT0Z4Dxf
 OVOcIxW5Vm6BKS27TdZGAai+RLDG4oWAdbD3wS4/IG6az4pipcbIQfRFyeQ6Z7YAI5fi26yXQY7
 jONlNCwZUop8mH8UV5JZcKrkI2b5nGGcXm84+vowUbXv9ldfbssRFTO/KAyMiwkTDXTAqNzryAd
 NkoB8/5oPMmDUsgErREoxk4kauROThYIiFBeJEhEZRrByEGByG2q94hFRVUjxXXYQ3kJ8wgE0sX
 fqIL71KI6mLX46CjO6rCKwXXZXq6fA2hjeFIdcOjVlIuaWO1+GRIxdSYQNSfKnqyUjtFDwlp6HM
 XzVNU7Bf/nJrq8aCSO2
X-Received: by 2002:a05:6300:4c:b0:3c3:a7ab:135a with SMTP id
 adf61e73a8af0-3cc5539b0b7mr2328039637.20.1786573929507; 
 Wed, 12 Aug 2026 15:32:09 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 25/52] disas/riscv: Break pseudo loop for jal and jalr
Date: Wed, 12 Aug 2026 15:31:15 -0700
Message-ID: <20260812223142.349142-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

These were clearly intending to simplify
	jal	ra, foo
to
	jal	foo
and similarly for jalr, but the pseudo expansion looped
back to the original jal/jalr with the full format.

Add new opcode expansions dropping the implied ra.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d3cbfb86ac..fe503b6cae 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -326,6 +326,8 @@ typedef enum {
     rv_op_bgez = 295,
     rv_op_bltz = 296,
     rv_op_bgtz = 297,
+    rv_op_jal_ra = 298,
+    rv_op_jalr_ra = 299,
     rv_op_j = 302,
     rv_op_ret = 303,
     rv_op_jr = 304,
@@ -1029,9 +1031,9 @@ static const char rv_fli_name_const[32][9] =
 
 /* pseudo-instruction constraints */
 
-static const rvc_constraint rvcc_jal[] = { rvc_rd_eq_ra, rvc_end };
-static const rvc_constraint rvcc_jalr[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
-                                            rvc_end };
+static const rvc_constraint rvcc_jal_ra[] = { rvc_rd_eq_ra, rvc_end };
+static const rvc_constraint rvcc_jalr_ra[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
+                                               rvc_end };
 static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
                                            rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
@@ -1068,14 +1070,14 @@ static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
 
 static const rv_comp_data rvcp_jal[] = {
     { rv_op_j, rvcc_j },
-    { rv_op_jal, rvcc_jal },
+    { rv_op_jal_ra, rvcc_jal_ra },
     { rv_op_illegal, NULL }
 };
 
 static const rv_comp_data rvcp_jalr[] = {
     { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
-    { rv_op_jalr, rvcc_jalr },
+    { rv_op_jalr_ra, rvcc_jalr_ra },
     { rv_op_illegal, NULL }
 };
 
@@ -1884,8 +1886,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
     { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
     { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { },
-    { },
+    { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal_ra */
+    { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_ra */
     { },
     { },
     { "j", rv_codec_uj, rv_fmt_offset },
-- 
2.43.0


