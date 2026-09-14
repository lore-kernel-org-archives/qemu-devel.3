Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA232C88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5vsx-0003wS-GN; Sun, 13 Sep 2026 21:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vso-0003w7-IT
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:53:23 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vsm-0005Bc-Ut
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:53:22 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so2418067a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789350799; x=1789955599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jNZOvUK8o3EJEk6F6/4jpgOYEq/Vbqy/CIwqaCtwpbY=;
 b=G5SkqK92WnW1T67vqt2KRQhgrg4aHqHWPIcuZojUg97c6wusJgqvT66HhtlDr00DVK
 phxTB0Kp71YP5jFRPijG0Vv2b/IYBiFLZg/BTCKZT18G7yfopRSCrAiGwHRUZZHISLC+
 2GUeA0roXF7HEzjy6SXcfADy9b0vD9J795hz9x1wXLo5VMkgNy6SFjIA119Ny9tKyErT
 GL/yTrZUt0ZJRwDA4+kRXxtlo/EFTTXYCxZKuMTg1v7GgG5pzBSmXHR6it7F/vRg/bIa
 Ha+RxUOfwX4xUlvou6FI986yoHtFu3F4LU/q/81xQlmJDe1TZWt8BaSrlkr6605gcMEA
 PQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789350799; x=1789955599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jNZOvUK8o3EJEk6F6/4jpgOYEq/Vbqy/CIwqaCtwpbY=;
 b=mAhZN6FJIyQejCEAfiv4oZWgZ5Pbvtxl4m5onnJwl5rxSTRnykjV4vzwnq/0PV3RDa
 KASNClQYYaa6OCQUigH0soe7h/NsRItKU+hcKv+uOcE9uRuGfvj651eAO+aQj/gfFxNj
 q9w4+UUiWeIvmSxlooAfREzVaqctPvtcZFBHaSJZy/D8nLoS1VtToIH+HH+28hFuXtO7
 JB+YII3Y9gZVO1n9tZXzoZ0jdO1kz4sMRm061028WDwq7dLHI1pSF5WbQr+Bmwgfe9QH
 +mpZGPkC3u6kg2PimIMcnrwnih/z/g4hdJPx41G+QpFRpsbD5sL0mzoq6zVbOqACQnKA
 9u7Q==
X-Gm-Message-State: AFuF++mi94rbkjXmOnrxjeZBDJW2KIkIwP+xhJX6CDVb6vmT3FGvizuL
 uORd2KpsUW4ZZFvfQWetBaUE1K/55C5qTKVr5EGFYLDuJlDtfbpTnLdn+7XVwuXgn8MRNQaK4rB
 e7BS8
X-Gm-Gg: AYBFou3J14bAg53zehOZJndzfhKqOGLSX8JUSnzkiNv/V0UhGVUtgjkNJusMzvYXZ9D
 mcucBji8M9XvfEIYFl2OYNkVUpHFap60WVBo9CDiiCv314oE7mqmYg2bam11zgFaRaKi55IP6iW
 QJ8B3bb+iWk0ELpfjObQzWYuKA/vZoV2d28qicEL8JXc/5kLlKbAcnjAYzfX3QXJEbQL73JRAXe
 KqkpfiinDSWrWwatI06Q3kUAGmjYpw9U8EfwFPLYVqWbdxID87VATuhFeYK9Dh7lxkZkezPLnlv
 uk5EtPFg0xzxqPaYIIeCJsR3blc05tXdQmgag2Cwbk0xwKd0Dw0JIyUVyo1uqCvBzk0s1lGZFIK
 rCCrDw3OlOEs2Ftk4i9Z6Uj649hX7JWP2Z1B3AP679ITfO35d0Qze7sPCV7pwA4RuahvaXru6bu
 dAQ1wWP4HVK+hzyt+ZPF4y6KC47ckKg45Z545/NwNCP0qovs9jmbHDnXqPzsgaNwfOhkjuIkIFp
 jdcCGk=
X-Received: by 2002:a17:90b:4c41:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-39dec05d384mr1091834a91.15.1789350799016; 
 Sun, 13 Sep 2026 18:53:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8137fsm22323467c88.9.2026.09.13.18.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 18:53:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, qemu-riscv@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH] disas/riscv: Fix csrrs decode
Date: Sun, 13 Sep 2026 15:53:16 -1000
Message-ID: <20260914015316.792751-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Resolves: Coverity CID 1685513
Fixes: 4fec981f18fd ("disas/riscv: Split rvi_opcode_data")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e85dbac0351..ef8b7ff20f9 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2560,7 +2560,6 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 2:
-                return &op_csrrs;
                 if (operand_rs1(inst) == 0) {
                     switch (operand_csr12(inst)) {
                     case 0x001: return &op_frflags;
@@ -2574,7 +2573,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 0xc82: return &op_rdinstreth;
                     }
                 }
-                break;
+                return &op_csrrs;
             case 3: return &op_csrrc;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
-- 
2.53.0


