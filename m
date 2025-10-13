Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01ADCCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O48-00063z-95; Mon, 13 Oct 2025 15:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O43-0005pB-9Y
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O3v-0001qB-Bg
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso2547552f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383103; x=1760987903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X90IRoVtGXRK/n4lfBXEc9IWcosy5owAxi6CDzYBJNc=;
 b=GJlcRM1zkS5IKe2yf61WBz/elajCJLR+SjsDDWIegQRkGk+hbmT1y89Wfgfkh244+M
 fwc4nLEcYRwjZIjMTD7tSisU7tBy0jPBfYjZDaBWzva5SV49ewl8cphx9haL42qIFFHZ
 51erApXd8ke+VtsxsNUnho8+FiSFVHuOA9wwMCP+kmyjjQZY/9VCHFRLpK61yPc9sOkI
 bcZHARjE/XySd3bbQ67HmXQR50coMeo5hQ27rps4jVLQFB7MWg2kOiRuBDcG00JjBg8B
 SkS/149MGJmHn7SlXtbxH2yLCBKa38nUs/7j+f5lpgA53FQwXGJWFaQBCFFotGdI2QS0
 RiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383103; x=1760987903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X90IRoVtGXRK/n4lfBXEc9IWcosy5owAxi6CDzYBJNc=;
 b=X6g26/b/D3+Eb+ZoZFQG6Sh05DPN6hE9+Kn/dHvB9uaWZ86KnV7dEs8th65zPd+o/7
 XRPyGt4F+qViXWytfVKIwt2QhUGPijObEZXU/Fg+QvKAOkMq3KrlNLgi5Vu4K1FWoFh4
 obbjXTE6LI3AdMG9Q121C03YL2eU1jXPRMTtqH73dUOw/9RXyGcOxiHcLUCfVKXzGSqr
 Qn43Tj5pUM0h7dhNizG/CAPAp2WyXOFG7XCkIgxSGHfJ8FdoWJRQJ1LlsssyXgqurJuM
 jIVWUSeJAhsQApkY0LRJyMcwNL2+BT18tbqsr29Ls91ePJg2C5pjH4dTqDQ3R3EBQZD5
 dROA==
X-Gm-Message-State: AOJu0YzyIKNDSHI5pMze9hTpgiP9MYhtrqBsOxp6hkL1d3PG9qecWwis
 wLLr5VHTnCbVowBem2CRs+4pJDMIRzUqNyB7QzlAcPWKYkzLGMyj7VU/zg6+t6lHn62RPe5WYQc
 e7rWhP5fqgg==
X-Gm-Gg: ASbGncv09O7mD5jIV3PeY7Olj0sq3jyfApv4pPaSnpsJ3FdO3WrGHubXCT2FqAyF49+
 jleK9eyAwBY6V06rscAN3CPKyrvXZvJGb3nVhi9JpHJuteudU19znHhkuLo+VwJ/K4KBLXCJSVG
 3tiXlosox/fmbom6/lWZh/CXGirWoIhx6ZksUwYAlEW6Zvp/iiwZhM/N30d9vp5GEk+1DfXwy17
 iVx/f/tB4hYxizFAXO6nq98d5NXQmmmUzmDQZmvkDp/eAu7OoLE2b+mBXLECp6sEnQGam7MGUxj
 +pUfW3SJpYOWpMcgvOW9Urq4Koppn621ZjgOsiT4Ewgu/WnPir6aO+OOt0Dg+Xw/Qfj8hm2ZivX
 +AOSRbqTonYM/iFIi+ECk5U6/NxVsQRJmyy/TgNG+wL/bm8PokoGs0gOV78COYtYfqFWPznoi2D
 /oHqqHGC6HKTOMkrG9BWsJHujTHj8TUQ==
X-Google-Smtp-Source: AGHT+IHZcjh/CWpGI6wMKL4zqlhNy/vPU53B7E9T6yG27v9FeijaoBSGPQamkVJObmmye30BTo+kLA==
X-Received: by 2002:a05:600c:6383:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46fa9a8f146mr160813435e9.7.1760383103134; 
 Mon, 13 Oct 2025 12:18:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3cc939sm137491935e9.1.2025.10.13.12.18.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] hw/xtensa/xtfpga: Have xtfpga_init() only initialize MMU
Date: Mon, 13 Oct 2025 21:17:58 +0200
Message-ID: <20251013191807.84550-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

cpu_reset() should not be used with an unrealized CPU.
Here we simply want to initialize the MMU, not the CPU,
so just call reset_mmu().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20250925013513.67780-1-philmd@linaro.org>
---
 hw/xtensa/xtfpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 6efffae466b..55de1a7a073 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -268,7 +268,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         /* Need MMU initialized prior to ELF loading,
          * so that ELF gets loaded into virtual addresses
          */
-        cpu_reset(CPU(cpu));
+        reset_mmu(cenv);
     }
     if (smp_cpus > 1) {
         extints = xtensa_mx_pic_get_extints(mx_pic);
-- 
2.51.0


