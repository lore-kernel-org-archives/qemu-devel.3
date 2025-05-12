Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C4DC3ABD9
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYM-0004Ut-Q6; Mon, 12 May 2025 14:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWs-0002Rn-Hv
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWq-0008W8-7f
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2317d94c9cdso54095ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073126; x=1747677926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfHS+52V3f05Qs2m5d7Nh2wTK+yUmoJBcA8DI59GOAc=;
 b=ztXkEiv30RQAedCBYdectJnOgOvWhFRUhEtAKA/43rPcKrVrs696zB6F2ojBRXww7h
 FhpoeYv5R356pon/syy9bzAQ9vzXx2G/9Xp5K9OI5PpfOOaSkmpAM07qwrl9u6IHEUL/
 qhAik2PUH+dLqQTNwbZHAG4blcdH+iUYh79AYpHYpIcBDOZ840trAivEHBodt/Ft37iq
 A8lqNGwT6mz63VZvKcGBOImx7IwSS0oRLnjVAjLGZQCviH11MtefKhCRx2bpbfdOYhd6
 Hn3Wt/IpCtnaieS3asHJrFlnGnY1Xa/mjVRVh5Lap1Gv4mPEA8XAnMhgSU9eiA7BGGWo
 3L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073126; x=1747677926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfHS+52V3f05Qs2m5d7Nh2wTK+yUmoJBcA8DI59GOAc=;
 b=voNoRZwB9fwkgBMsCc45r4D5CsHuFMGq3IEp5aUKAMX4wpifZaueR5A4+Sx+YD2ipJ
 dTgcPcv2kd7252zV7QqToW12dDUwpyDyfoGInmpayRGzCRP+6loG7FFUhZzpXffWMGNB
 0BbJ6PwicqZ6+CGOK74OfcWSeCblaHni5WYzemXz+cIhX60hbIkcVIiSSmdH8XuPEAEf
 TxvMwuX+j+g3eqY6xbQ/AkteG3wEwBqqlU2uKF3K6gCI8lzBcC5EAuyx7qXubIpPDhFB
 yo259ZRJME7Y5n05HteTX0IbTPfWo9rDKmyDYUki45SMgfsdAEMV09eNt9icq0p0/BAi
 zRpg==
X-Gm-Message-State: AOJu0Yx5BtOm99OQMBavyQAO7os3PQ0yVyZ0c5Q19sm4XqP9ptziJ2Sq
 HhpoglWR9gzGZj2D23S5lc3DYfVfTqwQXQqB3raccoiRmMvC2BW5wTI234g+6EdFWM9KbFypoPf
 x
X-Gm-Gg: ASbGnctlz7pqzLnxjtfU+HyVI1wD1fTMTrEfnuMcCAVEzJQ2HsbolYVYwn5jz4Ewv6t
 TuYMnRrBryMUIeTNIoV0w3EgaRSi2JsW8YZZFkHuYJdKOnCNVRO0M06iRM3SxulkkGU6QLqul/V
 VL+43xm5/hF//xIVtLty/vUh2TemVqXuwgph6Ewev1E+NKq5Kn5Znnt8x6qMhZrMF8m0pElP6ve
 eK/LVK73d465l4MyuoKmuE1YEoV5HOsL8yAalU7Gb5j05CwLfgn1eKAHIlY47BHGLeQEotWiQcH
 ++CPjU4OCAdrnvrInTn3Mq2T4/798hNuYRC1MRf9I9wMHW4DL+Rus6k6lIL6Bw==
X-Google-Smtp-Source: AGHT+IEEH7iAqqDA68fuoaWPuS79K3+C1FsiPNsaDzF/9dqgyPWdEGPHvdAfcxmHtZcyfQ1XFCuGtg==
X-Received: by 2002:a17:902:ccc4:b0:22e:50f2:1451 with SMTP id
 d9443c01a7336-22fc918fd2bmr202795785ad.37.1747073126314; 
 Mon, 12 May 2025 11:05:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 16/48] target/arm/debug_helper: only include common helpers
Date: Mon, 12 May 2025 11:04:30 -0700
Message-ID: <20250512180502.2395029-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index de7999f6a94..cad0a5db707 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,10 +11,12 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
-#include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
-- 
2.47.2


