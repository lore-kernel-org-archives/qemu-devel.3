Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46931CEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJc-0007UZ-6f; Tue, 08 Oct 2024 14:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJS-0007SQ-SE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0002Tb-HJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71de9e1f431so3496473b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413514; x=1729018314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvN0udLtupEne5xbmGMllUkO3gfAOouXveZw0bp9Mts=;
 b=GsytaxmSMxM2mwlcXgYfqOPCEpmAkAsywDL5dqFwoCJxQZ85cgYfG3Hm9sfb4/LAnB
 ELX3fbbTNYlVnbVgovtgtR6fE3R2/YLNzHQLPkAa7q9TUXVlUbqr0NUXEZLTgOVnb+3K
 3gCfSmzimjFOxWK5TltgVaNNNh3EwiJb24HhYqJkhrshwZmQUYpaNKytA1j/Af6huuVc
 5qMpaDZVY2pLT4ciB6d5eIwX2EoRNiCMlRyWDbj4dJbSQVEgVC6wY+96F8wsuLvJoHUd
 GiIET8jGtr+7sF9aq8othO/bnyj6veMP9EknwDsoA5PYWN8h4V3WLaxUw3IR3jzXvZWF
 sYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413514; x=1729018314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvN0udLtupEne5xbmGMllUkO3gfAOouXveZw0bp9Mts=;
 b=rHVm4N2WOjZLb4J43R7MKZnu4hhMZcLVeQAfvmAhSNhyW1b5LunuhpoIyrFkQIk8Dr
 yvPwvsIX91pRvNp/eBnOhVHPzbgXdxvwuXEaep8/MCC/XIbYeTU/HHlFAQfLYCh2JPju
 qkMHqUBhV1eETgcJZvHfobIXHpjsgJQKgnkGuH3BE3LVrDTMmU7hlaQ45u+PTJUN1ryt
 PRyepB6nToVfdEoQ1COXOJmRuFty4+5BbKelGFCVenFfLehu34PC93T1apR9b5wBafIw
 xmqrwJ9FlXfkq4XTh36CbFJZEe5skOh3Ge0g48umTkqArUMxhVy013tcZ0scZuebK0wz
 pOuQ==
X-Gm-Message-State: AOJu0YxrSDtERnoG4Dqcm1TzepF7svpAV+gRvx4ldoe7jBWGPGKzn55W
 p8aQLN+Fl+6jBLrFCe+2eBnfOtA+T6xin6jC8q4tyr12dCysT18WT02dEIoGmL8sqW16KbAQvr8
 c
X-Google-Smtp-Source: AGHT+IHNn5+NWfizX/ColqdqvQ5vlFjoJzYDPpnj670wn+v6qLchufZeZGMl03Kk/idq6CbRzVZLdw==
X-Received: by 2002:a05:6a20:c886:b0:1d1:21a8:ee8d with SMTP id
 adf61e73a8af0-1d6dfa46960mr28034015637.22.1728413513872; 
 Tue, 08 Oct 2024 11:51:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 11/14] tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
Date: Tue,  8 Oct 2024 11:51:38 -0700
Message-ID: <20241008185141.20057-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

In the fallback when STDBRX is not available, avoid clobbering
TCG_REG_TMP1, which might be h.base, which is still in use.
Use TCG_REG_TMP2 instead.

Cc: qemu-stable@nongnu.org
Fixes: 01a112e2e9 ("tcg/ppc: Reorg tcg_out_tlb_read")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-By: Michael Tokarev <mjt@tls.msk.ru>
---
 tcg/ppc/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3f413ce3c1..6be5049d02 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2704,9 +2704,9 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
         uint32_t insn = qemu_stx_opc[opc & (MO_BSWAP | MO_SIZE)];
         if (!have_isa_2_06 && insn == STDBRX) {
             tcg_out32(s, STWBRX | SAB(datalo, h.base, h.index));
-            tcg_out32(s, ADDI | TAI(TCG_REG_TMP1, h.index, 4));
+            tcg_out32(s, ADDI | TAI(TCG_REG_TMP2, h.index, 4));
             tcg_out_shri64(s, TCG_REG_R0, datalo, 32);
-            tcg_out32(s, STWBRX | SAB(TCG_REG_R0, h.base, TCG_REG_TMP1));
+            tcg_out32(s, STWBRX | SAB(TCG_REG_R0, h.base, TCG_REG_TMP2));
         } else {
             tcg_out32(s, insn | SAB(datalo, h.base, h.index));
         }
-- 
2.43.0


