Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE5CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXH-00032A-M0; Mon, 12 May 2025 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWl-0002Oo-9f
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWh-0008SQ-HL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e4db05fe8so43637135ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073118; x=1747677918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgtD9a+F/fV1o8g6sPaSIZoYXGKqR0qNW17PKpxFW74=;
 b=IFQZLpX+e+NeiYMlFr9NmJX/ghxF4RtaEbXh35I6N6VuQ87yhu68JZvJ680na4i/0x
 EAjp0sWlDWVuYqrZFOY9qTkBxsBI6voVoVnfhpKlCMs+/EEGwVyE/fUZrpeZJft6T2H7
 F589kAP14wA0N0wvg7QsYvmBiafxDrkQXxMuJBxlWmmEap6gmf1ODnbG+567T0z5QZfU
 2NAhzrzdCWqHHlr7MWzWR9CK6X02WZVeQ06ksEVL49mv3sqGhZk4VDLkfNc6hwb6tXKZ
 5gt0Da+Dttg7olvIw/Dak9NX/pX9Ow/ycH7tjWczT7Jh+cxw3d1ylWrbgEFy0HCPDEHY
 BnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073118; x=1747677918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgtD9a+F/fV1o8g6sPaSIZoYXGKqR0qNW17PKpxFW74=;
 b=ADZyUaiprenNVYr1tCnotcFOR49TlUqwy+gaGiLUwjFazr+vWQM1HBW5nEF/14AakS
 5iEhpKB9LOTyZ0/u+HrlJbkOJtegqZ1l4CvL7zl2gCsQ0eDX2UTF2b2lqDHWysGRdavf
 pidYwbbEQN/uW3Miqg98mCmpzK341pxtoyS9jMebuOd+fRqycbQAvzZMMlg9T+NgSjF5
 ClDVx5LkSvzh6i0N893xkIi9OJ/F3Ud9EGbhG+S7QzP34gXlBRQSgttJ99QwUssxqyOS
 OXlkGQIKJJVOM3Fy1wA0b6lmw46PGwjGFjvlDPUoJHE13Sg9y6w9QKF6HYwpcAYwfGB7
 znjw==
X-Gm-Message-State: AOJu0YyF5ztYDQCg7WQrykc7nvob6A0b66ww/r7V1smohMpiAoa42ost
 6fITWe2DywUZ8Pg3OxSuPokWzctwb/6dB+EERcy0vsgdtS6UqS4hMa5X9m4D83ZDi2A8GwJC3h+
 3
X-Gm-Gg: ASbGncuc9LWSCZrcATSygUEzOLqA3p8a/9dVCpkYFJVJ9HRRIoOywH17y8hxur5TKej
 M57b586fzHXbyxFyV6SDGinkxF6Dk0Z4yBEdPmhCdXNYi0LZy2MvDd+9Zq81AuCjxsx4Ce9XAky
 hWaTbU6lNQ+wfh3SKGJ5avuiexHD4zedN+GYvbUvos4ebTKxmHoFaiLwDpVNyi/JFzgYZapLE3O
 IcCMtONjvmj4qixp6xcBHMfzNQInwNvUULkw7SbslZs7IzFgvPGLNeL4JnFCKIpbV51UdDh1UVx
 I91yg8g/4GHtGwa7G1n2FScQ5ZzVFiLMdOTofzj52UHAiGE7vtI=
X-Google-Smtp-Source: AGHT+IGFDRnIr5Z4IqZt9DDblisny1WwCZnifEmguV1wibcZJg9l4HCbr3eQigE/HjWaaYhhQjCACw==
X-Received: by 2002:a17:902:ce83:b0:22e:7e19:565e with SMTP id
 d9443c01a7336-22fc8affe99mr158659855ad.3.1747073117982; 
 Mon, 12 May 2025 11:05:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 07/48] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Mon, 12 May 2025 11:04:21 -0700
Message-ID: <20250512180502.2395029-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d062829ec14..b0eb02c88ba 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1171,7 +1172,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2


