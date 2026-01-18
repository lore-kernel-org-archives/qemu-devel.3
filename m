Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02782CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatv-0003Og-09; Sun, 18 Jan 2026 17:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhati-0002RC-SP
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhath-0000sO-CK
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a102494058so22840015ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773924; x=1769378724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3quorIoavgbRlUqCdA1N/hSlFNVi1G5ba+Ci7qX808=;
 b=Cax0Zoj53Ddf9qgvbbJruRAjm3rWVuvqGWCirKBKvQyQXhKuG0DfpmGD0nojuSI6LS
 egSgRK130UwYUEYN+qwHKzQ9aNfXnzTSTkAUBvTfDZ+WRgCl3x/qcJNwDx/2kRmGcusx
 NFwxE+8dnb43kbOk9BHOE89Wi0oO085c7C/24NYMG6bPcf20+jlhACPumn7c0tRGB5i5
 62S5NiwOyfo+4kP4xMPzlccKn9qTwTmziFV5UdIVchb2gsoPRGQKs20Ay0i3PFkGq5Ah
 7mfF9Szuh354jMZ5ZQa77rts15AFSAqhd3TBtBDVuG4dsxQ0oyXJGan/08a9Kep3btyZ
 7eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773924; x=1769378724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E3quorIoavgbRlUqCdA1N/hSlFNVi1G5ba+Ci7qX808=;
 b=PXx+e2eN9JJg1L+qzCvM91Y1IdKEQ8KgrIeJopd41Uju4BE7gt22e7ixly5cIkVdEp
 upz9v0Avm+FlubUu+NizBYPasrk73Fcw+a30KIfpQwsN6Sr94nGGFMJG8WMsNMnIc23W
 AF4gQD6MEIyqb5bcNSkCrLlKirqQtmLe3S6QJIoqiugYBMcivmTR0QkE4Z0uo6xlnLcM
 B8ZsrLQo4ynnNlRKtGuA97LsxYze6xCO1myBSgRiKuY7F+STZHNNetr6MOcQer53sAGU
 lcJbn4OVraWuBkrlkCcglW4g6gupc/2Ng5V67azzJx2d4tQEwx9Bet3/upX5lQvIGiTH
 Pabg==
X-Gm-Message-State: AOJu0Yyd5p8kowqhrkERkcmZrXzjZLMX9Iu7SZM1MDN/Qh3UztPRV382
 LicTLWbXOBO64rz+Yam9wX4pex0wzaLB5ysETZZqmw6i8RCCIBqMyPqCt+Ez5Dref66g6S/X4c+
 nOfbmOGLu6g==
X-Gm-Gg: AY/fxX7iiSXee33UXIY6StEsJ0RDgvXoDV6V4daEX519sH5qVDo2Ma8K3whPT6bxfWC
 YRU8GuYxs920vJyUDa6Q0sKIEVtRSwEUS9juHiL4KLtjXrFYGt93fESxZX4djeD7SRpe+ELiFFM
 bCyx49j83PbBJW0sg9GsO3eydYEyf60c5LtoUPzkxAmIUyn3229SbmXBtZ7xK+g3zTIGi68cxHn
 np49fqeifYZA8Tv8OZ4cQjyFyaXHsII28fRXk5+w2fmdRX6MNVfFyYJUnyfLb6pt/97FhawK5T/
 91F+eoL/TkMsblNCwVfjxhY2YKjhIrjlB4xFWn1IhckEnHvSiXv3RM4TCZUhN87XPYtJCR/dl0j
 PDYFPF9cC3XtLYnsgYMWhFa1FwNBqi9JMu20Dg/pZeZGYHKcQYxNZ4wuqFlt1qWevFcxNP0J8DK
 XnXabnWMDhPSmvqxM+Jg==
X-Received: by 2002:a17:902:e745:b0:2a3:ccf5:6691 with SMTP id
 d9443c01a7336-2a71782783emr104058355ad.30.1768773923937; 
 Sun, 18 Jan 2026 14:05:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/54] tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
Date: Mon, 19 Jan 2026 09:03:46 +1100
Message-ID: <20260118220414.8177-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index f71993c287..29ecb39929 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -26,11 +26,6 @@
 #include <ffi.h>
 
 
-#define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
-#define deposit_tr  glue(deposit, TCG_TARGET_REG_BITS)
-#define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
-#define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
-
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
  * Without assertions, the interpreter runs much faster.
@@ -525,7 +520,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_ctpop:
             tci_args_rr(insn, &r0, &r1);
-            regs[r0] = ctpop_tr(regs[r1]);
+            regs[r0] = ctpop64(regs[r1]);
             break;
         case INDEX_op_addco:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -639,15 +634,15 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
         case INDEX_op_deposit:
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
-            regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
+            regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
         case INDEX_op_extract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = extract_tr(regs[r1], pos, len);
+            regs[r0] = extract64(regs[r1], pos, len);
             break;
         case INDEX_op_sextract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract_tr(regs[r1], pos, len);
+            regs[r0] = sextract64(regs[r1], pos, len);
             break;
         case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
-- 
2.43.0


