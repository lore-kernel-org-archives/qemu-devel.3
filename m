Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4BBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVc-0004X2-Vn; Thu, 06 Mar 2025 10:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUF-0003am-28
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:17 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUD-0006f3-Gf
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390f69f8083so790352f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276211; x=1741881011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=12zNcZ/J8iu/OABHwpRBgZT92nQcl4kBcq8dKGM93S4=;
 b=P8nNi2xpGOWeokJ3ruzS40fhyhLESsClhyq8nxh2aeBdNSS6AZnPsBrea1I8h615oG
 TiJ3mptB10mgTYfetStrGFmEFNm2NLP4A2D22BKxAhBSsoSM2bj2/lJCaIeOPYplmrSs
 UdunP7NGPA7qy/hUWBnBKLcC7yqZB9GTTxeZ08HiiXjls4JUEdWszwOdAH7E65+1dU6Y
 4IIhFKHRnTGMCBFnMXYhtuIk+OnoNEWunpLSoVK9uVJtaCjcUHyBLIzSQS6XboJZTsLE
 gRlRC4tbFTpBShBpmX+lVcWqXpcKs7XyoqLsyC7zdSOFEeHvpVw9JJ/tlkAFfQ0A2hH2
 RP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276211; x=1741881011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12zNcZ/J8iu/OABHwpRBgZT92nQcl4kBcq8dKGM93S4=;
 b=jbJCTutfei9Weca1dmIDMMs2MX62IfQRswtirJSWHD4p7gHsdV7JZuPYPy1TmGM5di
 hlRsXFO3MYlfPq76CNDHbczRNHzl4yXyPF9snGTYzCf1kRiADzsIaux2Ybc4BwQSao0E
 WtZ+2BvIah5vVc7YS/yyl8AujY94b3Eb4S+p6eOVW0l77Ykx/A0wLwVdqUwSZFwIVKWa
 xZMjVqY4As8eTkW6JihIfru3dtZc2EXGkgiEyIfTzaB2FT9NfTAbX0x5SvSAF0Psf4uw
 8eFT2s5ABBAbgDJYv7jydGZQn5gVgKfNmUCsw2qbxnWQ51XceFPEdwc7uok6kX7ohRDP
 Z1jg==
X-Gm-Message-State: AOJu0YwCbOfXR7PQyVzP7r28cu0iCuB4ABanYEF3yaq0k0uzDaZkLgi4
 OGkrMO85okFNwIC98p9hD/YF5tsY4QrPQy1LEpwLCs1UGRvL8VjNG2ii4cX4JDoTDAT/7tRE0/o
 nrUg=
X-Gm-Gg: ASbGncv3BXK41Xc8MaksRB8WXEuXAAvdryxgqEOQmjRuHeSOue7kyLiAzaf0jk+fuOb
 j4Qg3WYmDZmD1ifcJMncBGo4Ud009X00HHvxMyP0vuzV1lw99IAudgep4Xl/C13MjV26FkmNBBC
 oNsaj3j7bVN5qHaXFaP8Xtv+TcnYF3JssMORLOxyq0Rk+gvcyCuBnyH2db08kxNdPCovM9GgFtC
 YSjul2kDEx+kav8cDZ3uozoiPvMldib9FVzjI4nF2mx+yzDPE1qEy82mP3zryVWtyvOkAS9Cfrf
 taDxJkbvGia1bHLsWkCgR8MM4Vz8NFRyf7Bg86B/T7Xvpof4cWcOB3BAcgszqiPh0XEMK/r+NLc
 DzLfuAuoYef2NSX/VJ4U=
X-Google-Smtp-Source: AGHT+IHHiswM5cv9QvdxjsyGCKmpVmil+EfbgZw/2sbI+WV6lOrqekBklZzIk3A/T7bVaG8ztpUW7g==
X-Received: by 2002:a5d:5f8b:0:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-3911f7b76ddmr7639406f8f.35.1741276211467; 
 Thu, 06 Mar 2025 07:50:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c324csm23300605e9.12.2025.03.06.07.50.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/54] target/tricore: Ensure not being build on user emulation
Date: Thu,  6 Mar 2025 16:47:16 +0100
Message-ID: <20250306154737.70886-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Currently only system emulation is supported.
Assert no target code is built for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250121142341.17001-4-philmd@linaro.org>
---
 target/tricore/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 8e431d79222..cf9dbc6df8e 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -26,6 +26,10 @@
 #include "qemu/cpu-float.h"
 #include "tricore-defs.h"
 
+#ifdef CONFIG_USER_ONLY
+#error "TriCore does not support user mode emulation"
+#endif
+
 typedef struct CPUArchState {
     /* GPR Register */
     uint32_t gpr_a[16];
-- 
2.47.1


