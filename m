Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C606FCEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJc-0007UK-0b; Tue, 08 Oct 2024 14:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJR-0007SH-I3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002Tj-Uk
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71df0dbee46so2510260b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413514; x=1729018314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdZ1rsJXsMXK9Xw+CkLT1YF+f8XvML7ftUECJVUUWO0=;
 b=k1G/9jlRImAn/XTA9HFFH+k3u7r333aaT/kg68TtIXlVmCSNXQ08otD/gwBsI6XGnM
 1DInKggBAhFOQhRZ5SzMdxuwuSre0kEpArOw0lVy3Y0TUgyLMUMEtMlee3tZaStKmiUT
 zHtKjhk3xNnaeJ+sezPw6mNqy+DI3nA33vDT2/+eZ28ZyS/oDCaTJaaq5wjk1qchFC9Q
 QkgqQ9R4yED4KckEklGfHXbnMibeWcoioPOhdS72rkp7SPWHazAgb15ROX3Hd9gv30Ik
 1LteSU1YsJhL5f66kDmKAEn+Tbx9DO+cv/tj1T02bX6+37rfrxMUm01keDzxkje8ZknA
 I8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413514; x=1729018314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdZ1rsJXsMXK9Xw+CkLT1YF+f8XvML7ftUECJVUUWO0=;
 b=dDq06hG0SmgB4zZwY92u2h+tjIse/7qF1rbiF45NsucnGvjBa03rxZGpL0gD/wK/Pj
 K03p1vOUkH48z4iu/+3CUzt0jCyrZWGzbytgn846/tyEZnHlA49qGjMu2ThiVIXwKyrH
 jjte1kPq3xzHKuCsDTDsMxNgW3TDEpKfufEbivS/8qzFa/7SYQ4SLQYcmVdrDDRrksCK
 4zCwb2x+27/Lfy6pMtONo7gOdraECOpqm8wzfeQZOKXPg+I7cf69ghQ2mjcxrfrn/n6y
 kmUrXBkJE9WhGnTnycSa0H/Lrz+I9bzJawNAL9Nit3pthJ2NDsbWbaFLGW0xmF32ZctX
 S4uQ==
X-Gm-Message-State: AOJu0YwlvyWbKWg1zH1VR2mrBUQ3HtqsLoUzG3b7G5YlADbrIOPxI6UY
 2RsslCFkZ1nFeokyHwEbTFJDrvpYaUOeMrNsVzBbwb114vaDh9u4tLig3iH/kjhX5dn9Ig2WjBQ
 8
X-Google-Smtp-Source: AGHT+IHaczJ8o+7d5MbgGT5EYFHjOmevPnrKWxP0iXWCCw+9TIaXK3QSjtLLLZKhpWmd/pb5hrptAQ==
X-Received: by 2002:a05:6a21:e8e:b0:1cf:4dfd:f4e0 with SMTP id
 adf61e73a8af0-1d6dfa3b3aemr25125505637.13.1728413514622; 
 Tue, 08 Oct 2024 11:51:54 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 12/14] tcg/ppc: Use TCG_REG_TMP2 for scratch index in
 prepare_host_addr
Date: Tue,  8 Oct 2024 11:51:39 -0700
Message-ID: <20241008185141.20057-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

In tcg_out_qemu_ldst_i128, we need a non-zero index register,
which we then use as a base register in several address modes.
Since we always have TCG_REG_TMP2 available, use that.

Cc: qemu-stable@nongnu.org
Fixes: 526cd4ec01f ("tcg/ppc: Support 128-bit load/store")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2597
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-By: Michael Tokarev <mjt@tls.msk.ru>
---
 tcg/ppc/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6be5049d02..223f079524 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2617,8 +2617,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
-        tcg_out_ext32u(s, TCG_REG_R0, addrlo);
-        h->index = TCG_REG_R0;
+        tcg_out_ext32u(s, TCG_REG_TMP2, addrlo);
+        h->index = TCG_REG_TMP2;
     } else {
         h->index = addrlo;
     }
-- 
2.43.0


