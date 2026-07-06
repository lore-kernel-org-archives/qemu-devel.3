Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C67CC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggic-0007BG-Uj; Mon, 06 Jul 2026 06:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiF-000702-C3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiD-0003G7-3q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso27109115e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334282; x=1783939082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OrDoB58JzaQayXuT6YvGlxG6wGKQEZMsvLHBmmmRoWo=;
 b=lNBA0q/TQce+AD0PhSJV35nUsNRBmIgx+SGExLI0JBgPnLC7fVhhEHS4de1EHtoqcn
 FqT3i1kLiQIHdA0Qcg2vvuA2/Ehvepbm4zQDzWPVcIEqVBo8BWetaFisrRlNeDrxZmCx
 KvzbJKQlOxss0zrW1Y47SpjoGSgDOLIYjqjUvmfphBp5SdcCYEwI5dza1asF80n07WXD
 ubud11qGBRMTbU+ZKGDOsG7UEPEdcwNtVT7m/bcIMly2i8xEHK9o0GzemyDIR5MyqqvJ
 x+gTlz7y3rClr5uG3OB+IAZgLxapFIVzVXAQSWRCHznxGdqLwCM8KoR8Grprkj0B5rxT
 5Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334282; x=1783939082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OrDoB58JzaQayXuT6YvGlxG6wGKQEZMsvLHBmmmRoWo=;
 b=SUktLAIfXRWkzLuozfeIANRB9Ll3FgTzQhljZc0K7UTMKOJij8U6mJAWr24iEvnxY+
 EndxYBH/jQbmZFrvR12I4PETKzuvukgmbLvfCgJIHl2L2om14sqJHWQ3epixLuzY/m2f
 3CN1xSeChP07HFEZ47c3A8JfGERTxZJiP6g/hJkhe3gS+SSbW0SP1d1y5wBeHa1HMBMb
 xEgzdYTs9lf8rzzTTadesstGBaZVX+RemkqKjUKnpwsaSyRFCq2ruuiz57AKl/VFINl+
 CCia7rbZy21/2h7yYUUJPdHcak/CPilvPl7vrK0ewaFxJY1qOuHElk/6lnc1wwv+MA0c
 ZndA==
X-Gm-Message-State: AOJu0YzCoRKOPeNyKJj94keCkdtwas6IaA5cYURQHhwwAC99fFUS4NMe
 /bJebpwjXIOBJAM1sTA0auKJFE3FOta7a71eiA6DcATjazc6OCdNv3C3jbe9Rt0g7b8J0T/60Iq
 rmHw8z6jhCQ==
X-Gm-Gg: AfdE7ck6mwj0rEycU/qQ2pztTQXrmX/vKLmM+Czdu/xiAzHvBRusUW42DY+rfawi/aN
 0rlY0bUgysdbL1OOG+itW6bb4uhMauYjw3vsH2/llos9mW4e/7+lCEJYfSU4tcq0Az83DXdpyoc
 TnkrYtEkbdL0Q77Lmj4pS4uYmKRFD0Gsf0/ja0HfamStLv4nEjuu9rr0eEcESZjFc1lE2315oRw
 Ejg7MZQC/zEG/bfcUghZXxVazy5OXHP83sNgxkQO0zuoE4uymUAIkgjRpB6rwT7LYojS/fAegXx
 BUnOxDrdliHyKlAZJs5BPTkIXu0+Q2HX/1WheBsnd/XuAl8oYrxBgtBfIrr03lrZbtspq8TTkMo
 gGtHvs0jX0cV0seCPArDSkBbA6s1MkMM7xBvKOmyLMdCNlFY84lNvbSIoBQHGIPVSZflhIgIGxR
 ltucBRr4u1WOXiaBAoc2sJOCMxQNrafSnjJtLdciMdZYHwsAxsYibhrBlBzdBmejcS8Nk3OZtmo
 j72Z0Y9J+ZhgXVsjxlOKQ==
X-Received: by 2002:a05:600c:6812:b0:493:92c9:1e6d with SMTP id
 5b1f17b1804b1-493d11faefbmr118894345e9.33.1783334282544; 
 Mon, 06 Jul 2026 03:38:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/49] docs/system/arm: Add FEAT_FPRCVT to A-profile support
Date: Mon,  6 Jul 2026 11:37:11 +0100
Message-ID: <20260706103752.320511-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260630-jmac-fprcvt-v3-5-f4840d5e0a7f@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 191d1a8c93..b1fec58840 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -86,6 +86,7 @@ the following architecture extensions:
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
 - FEAT_FPMR (Floating-point Mode Register)
+- FEAT_FPRCVT (Floating-Point to/from Integer in Scalar FP register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


