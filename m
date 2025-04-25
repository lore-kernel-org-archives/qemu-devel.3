Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70996C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REf-0004PY-Oe; Fri, 25 Apr 2025 18:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RBC-0004QC-Ix
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB8-0001vY-5c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so2516147b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618748; x=1746223548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEQ1CskHpy5UZJtEGgxczI5xJOhRj5rC8GuSQjCYOmU=;
 b=GgsjvU8csUiz59oA3onw3GW+LaqUphXc9ziWrTS/U8M9lCdd0ynJMX2eUslDHOLXLG
 +qQZK8le2EdnBppGgygKgdru1EmeZRW1SYmwxMeX80PC+jqXPl1syJRiQznGlQuu8a1i
 N5hJGZfhVAKXsRc6Hr4mzsottzzSHJl99NtbV67oD8MMH8WntYxilgCxnFxnR09tGOxr
 2XsT3h6U1o8yM7pXuYrnR5uBK0d3tGhcbXFfwNhRD/xmZ/ffKbjwY3q3OdrNHt6URBJV
 8eqhIMSmjXzyxeK+mImogi1uKVQnWTyLfdKP96F47ZRkCYZzZg07gwcv99rnTRdpNk16
 VZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618748; x=1746223548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEQ1CskHpy5UZJtEGgxczI5xJOhRj5rC8GuSQjCYOmU=;
 b=tuN7eGJ2OXUloweSl8p69BSAebbpX0VnF9l54RPg1rmqn6+YZMaQ7nAVLrgqJ+F8EH
 cIUbeturlOT7ElY9QfDMJvrdw4qhycOkA8REqiDmRndnYMSrJW1DNI0B6jVX1J9ef3T6
 MLs9zAa88LMrD/gXJU75SEQFlXY8X6kPPNLzvObcq/xZk7dl32jfmwDDjl2gc4dvnbsw
 z0cHrS/D7JGKpQ8+vGPdpoWD4eeh6CdP4V1ju9eXWwZ8o3abk5qGxSk2CHGSLdseCz9n
 mcXb8cpOu1SriBBkeQTRr1sCjEGJ1GcJxHapbl2JMvkv1JvikZDKo4rRvlzOTnr0H89k
 ejGQ==
X-Gm-Message-State: AOJu0Yw+3ZCy0LfDvh+pPvGZrAi9P6RUr9InPZx0/Ez1tR1rrURRfrwd
 DkytAbshgayLb9ObRqjMKfO1/REbsSzNFU1on1coZkd9FbrlnzzcwPACXpUG4dugf8Pn+0K2EID
 v
X-Gm-Gg: ASbGncsI29nyszys+ChcrkGRHDGLMs9rlZYB8wyEibHFNmQX6UAfoMh7mDAq+MJsTPN
 AdHz3MKJ9REFxhlSKj1U5U3PR8AP3Hu8l2jT0vw9CuOvVcBfmaU+Q3D3YzX4aSi0t94QDy7RjhW
 ybOExZQH0Q1WU4FajxpqI9e3KWnaUAiI2WYrJDQgm+GikQYn7Vs95gZ0n6M8yc3pGGr5Jq1dcZd
 hFhy2QcEvMjdKQEqpmngboIUBFiv7MvDqdiLa/Az/wXlKTJi23cHg+7ucfFtykg7ycyskY6fGIs
 Oj93MHQw2MkLVSPo1bxeWSlUOsalI25il5WxlCaqgSXZ6v6W7G2pBcAnFIb8w1GyaRxi+1Pxa7c
 =
X-Google-Smtp-Source: AGHT+IHnDosaCIpDemq/S4TudCBmU/yLg7XhSfZmV73Umqc2rn8E+2II+P0LD40hRFFNxY4VW65E0g==
X-Received: by 2002:a05:6a00:3984:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-73fc7c4b0d9mr5416083b3a.0.1745618748251; 
 Fri, 25 Apr 2025 15:05:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 154/159] tcg: Stash MemOp size in TCGOP_FLAGS
Date: Fri, 25 Apr 2025 14:54:48 -0700
Message-ID: <20250425215454.886111-155-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 3b073b4ce0..9e4626e51d 100644
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


