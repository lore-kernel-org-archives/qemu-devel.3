Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6420C369C3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mH8-00036e-KM; Tue, 15 Apr 2025 15:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001IP-7Y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5f-0004gE-EQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so4072107b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745787; x=1745350587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E2yGX843ehTy34ZyeZGFsTZ8T/gWZ/tMtASHWtzGxfA=;
 b=V+kGHjhEzPCVEvL81Bs/7KjzREBahxV03SJHkFw6eLVpXBTo8d2Q3Sn0FlJDeZ+uBx
 4hHXG42YA9BhxjL5cYG9wL2UCAT0XccOsTgj60ysreHqfaweB1tRowinKvBTdFQpUUUD
 JB7NHyxsgXlSZ9SSJ4qXLaCbP3dmp/rVVFRrsJWNhmyrGzc+aMd3WaBJzc97wbWwifTm
 JdwrCzBXEifDphgkIkaFXiU0j1ZfyYtDbS6lwzczg3fn5yjIMyPLrp8o01nlL+HmH3n8
 cOdRzJy92CXv46W7tioOuP3S1nRU+cBxrfUAf4xP5Uu69GHOOWx7Wegx2BGG0LvHTYcJ
 pnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745787; x=1745350587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2yGX843ehTy34ZyeZGFsTZ8T/gWZ/tMtASHWtzGxfA=;
 b=Cb2pvFpzkeGvPjzL5S+gNxmcBRnMXZWO/QMHxbe3M7+K9mMafKl6MZEQ3g4SbJl+1K
 8oqq1GYJMAJprCbu30egptuZqVQuwSQyd/a/prXK1EE9yY6M6K5V1hqJbFhxwoj5b5qR
 w6h59y5DBj6DudO8e7FtnFlw1QInLwkJn2ZPQ47K/j0gbpd9k7Hh/jEhzGXj/7yMTZ9W
 1CWMw8LiFwegSrIGSNV1fz9pYhr3aajZLIMR4ar6YlTDjHcvxlNigCod1IN0aLLTJxGj
 AEcrcaCwPz/l2DXFyrHQYWRxXFzmczfOXknJ9xgYIZEChwRo8FfzfuYAb+M/X9nSUVMh
 vFEQ==
X-Gm-Message-State: AOJu0YzF4q5Pp6TgN1sqkSDcnkH/TPqlXj+RDGppgUjy12AipcZTOvZA
 n7lkvwpksBmtuAMRBbMFnvzBhRMVNOlJZ4WvrMBZuRY8qDZVXDOGUsB5G0TSI6r1HLW7X1YX8xK
 u
X-Gm-Gg: ASbGncsZYl7e136lYMJO+C5IjFXU6lVdYyhVg8+Ry5VWDmIsdmTUXIENRktXEuIOKTF
 t26/9md+WV8TFMECjG1PWbK8gRrRehdGNNPSV9s+ks+iBAAKNeFX4loQId/S5wFbk6CG82G59BD
 eW6VSuDZkaD3fXrsuDCZjWPATbeNjFiXQDm2es0XgXtRoi1H6zB2oeskTR6s+bD+ZHYOZqTgPMH
 r+V70fD7GEyi2c2sG5RXtcwUzOdlfQuLRoRbddpewtEoXPx/UyHg2vxuAiOJFXHCmOMyX2vIBnI
 uvxWIK2ViqEugcUS6fFgcemYiEtuSn31ufQaMcHMtbgO+0WU6LnMM6lJtqg4fHyL9mz9shyOqIc
 =
X-Google-Smtp-Source: AGHT+IEbLE0KXVnFmH6QNgDDBgF+ubhy7mq7bjIkc6BVVmTeGI7o0rrf29GKN1kirshrG2vJ2XITaQ==
X-Received: by 2002:a05:6a00:148a:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-73c1fb257bemr951350b3a.16.1744745786558; 
 Tue, 15 Apr 2025 12:36:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 158/163] tcg: Stash MemOp size in TCGOP_FLAGS
Date: Tue, 15 Apr 2025 12:25:09 -0700
Message-ID: <20250415192515.232910-159-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


