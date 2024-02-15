Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8EC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1y-00083i-Gp; Thu, 15 Feb 2024 13:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1q-0007Ym-BB
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1n-00023i-8O
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:00:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33cf7812777so639139f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020005; x=1708624805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEY5Q9cN6dyZ6ENA20XPMsBoCTRW9qgX5vERomv9BCU=;
 b=gISc223vv85RqmfTBjyHfX7Yom02HvnP7aeXJ3DB+LkJqz/bV/lDqZnLcMZHFNsjAB
 3ee73owj8x3OvCgjLKTcYo/0gXio8znOqtEZyiqjXT4fhSBSJf0Lr6xWay1idF4v7XpM
 FfH+S2fPMmaJTSe8HytSPvPV9Nm7KahG2Ky2A4tuYw01Kh0dVJ75r0NKGMjn6KUjWkCU
 QjuOLBtbBSCrNmLK3N7TJ/WXAqhf1+nG7OZ/HTaPeHoKyRePKuM4xrdBzboR1WaRz9/v
 8uViySEbLk41gd+h9nmii+sIfXkMhT6EXUwtcSdUfPtGV9DAdyNtvFyz1AjJDg4oW1FP
 mMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020005; x=1708624805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEY5Q9cN6dyZ6ENA20XPMsBoCTRW9qgX5vERomv9BCU=;
 b=TlZZhjzWCKfza0PBg7R2btQzKCx4bHAX+lkJ5bY9qez/2DwUjvfWrRFkYNjW+mkUop
 orotFUcNMs1Rj4JjfiNic5r98Y3YkGWEctXkJRJvpsH6u5J6Tm5Ih2VoJH+RuHgf9Tfy
 fnRzf7ElkDk/L4zP0HjB+pdGZMz0LfkH2+10YYa7mVBmGylHIOArsy9FCy/LFAbG3xLs
 bM+XbhA9dVNclB6vJ6FY0WuJfbHZExyEyZSKzZDnV78mI7sVblhg+1iaE9BbXWgR/N93
 trSHKzqIbS+b/m8oRyuwuvLexZ0tNMQbhsm4fUn160RwX927QuhZcZA4Rt8Bd3b06/hz
 3pjA==
X-Gm-Message-State: AOJu0Yziq3VSKzAnZ+/DIOddoY4K7onBK4TmMs0HLcD1d7YDkL7qKh75
 +0QotM86gCx+OUWg+FK2fj1XgMVup7SF4Ul5ybzxR+3GNcwq6Xc1g4sxt4ihL3EqLYFJ19E3xfN
 aVL8=
X-Google-Smtp-Source: AGHT+IEN0WVCyHBYi29wVrsc3DI5VmquZag5jlH68n5gHwL47UE7ze2KW06pHMGDuhVV28e4roT5XA==
X-Received: by 2002:adf:e7cb:0:b0:33b:6773:1481 with SMTP id
 e11-20020adfe7cb000000b0033b67731481mr1883493wrn.56.1708020005318; 
 Thu, 15 Feb 2024 10:00:05 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d43c9000000b0033afc81fc00sm2374790wrr.41.2024.02.15.10.00.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:00:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/56] hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
Date: Thu, 15 Feb 2024 18:57:14 +0100
Message-ID: <20240215175752.82828-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"qemu/units.h" is not used in the "hw/rx/rx62n.h"
header, include it in the source where it is.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213130341.1793-3-philmd@linaro.org>
---
 include/hw/rx/rx62n.h | 1 -
 hw/rx/rx-gdbsim.c     | 1 +
 hw/rx/rx62n.c         | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 73ceeb58e5..bcda583ab3 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -29,7 +29,6 @@
 #include "hw/timer/renesas_tmr.h"
 #include "hw/timer/renesas_cmt.h"
 #include "hw/char/renesas_sci.h"
-#include "qemu/units.h"
 #include "qom/object.h"
 
 #define TYPE_RX62N_MCU "rx62n-mcu"
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 47c17026c7..bb4746c556 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -20,6 +20,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 4dc44afd9d..d3f61a6837 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "hw/rx/rx62n.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-- 
2.41.0


