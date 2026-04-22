Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710E0FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdja-0005b9-62; Wed, 22 Apr 2026 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjW-0005Si-Aj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjT-00013z-AF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so5365994f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887973; x=1777492773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pptr/WwqzakJMAPPMzmdFh/Fnek5VOfh7tccpjM7+V0=;
 b=qecUPg9arAuMefNeCPd5A8rbl0wRVXhPtgfNScoyL7MTyRyvXFeakx22Ja4RgTOKma
 TFCf35qfH3i9rSmzHI6/k6Z7YxCSgQdkVfqGAA+zPzjvANoDVvMZoDrQh9J1ZjBOnBxI
 Nm5rSnj4qd0eI6jgs5+wt29zfP+me1NwHeYjGeHCyw28pSI0HXYYszS/NID3WOgaekow
 5g26/Kuza6185OftBFSrtKUgHh0tjFm9Rd8ZyZLYT9WxOpergx13FgdjnprtuWgNs5Ri
 LSFmsMuFFLjzFnG7khlIUb/Ctiq4V95hbB46G3cY+z83QTTiZDuL8V4xZGOGyXBDsFYN
 0A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887973; x=1777492773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pptr/WwqzakJMAPPMzmdFh/Fnek5VOfh7tccpjM7+V0=;
 b=btot8zaxaoS9aa2+SZnfF97VaGs6r+6XWeerjhFPGHKuW7PUHqQQB5DSU0uaz4qzp5
 QKfzJBmzIUad6CdNUERGq+VtDwBqlOTX3hWKTD/0XHWi6OWjWMQouc0kp7m9s1ai8G2y
 Es4hSbc4RS6qGErCJgvsZrLVT0Qjg0YlOlr55PkdYClKHjnyC1oOegJyE+ORIXFg5POU
 tuDII3y5E3Z0dWNsZmKIdKKSjmSPHiumjosvoFO6UMIadreiSLTKSIkMUX2MNB3Aua5L
 ogPBH3o+E89H04dP0r564ZG1cPYTNlKMq0RXc8DT/xlwTqovtdGIMGjs1spGlicQvreB
 sjLA==
X-Gm-Message-State: AOJu0YwCK7MedrZUQhf4qzf3r9Kvho+WLam3GFJiMAkpJjxN5Zgui9on
 1YN8OEEFsfgwYkUJk7Z32Apo0kZr1RVrHvRUpAUHnrG/7P5Fi7RtzbzaxvnMMCIYiYdoFy/Y7pV
 XOVWCOH4=
X-Gm-Gg: AeBDievhoWTLnuUTvJ+/vZJ5hG3TH1V7LocZ897NlcezEDyvPSBEuzvJReS9PTnec8+
 L8B0J9l2U4ES8eBL3ZGaHRvG+fIirWAHXnaeQDjsUVCx9XJZT/W1ZIsbB4C7St3N6iTlGwrNMKW
 +5VpElw2Z3H2b/QuntSWbAaM7iwyKwYjFQi8+/WiV5SekAd75z7G1Vytu4xJqwsA5/s4H0hNWqv
 OXqA+TwbUCc/sZ7Q4FAf5SZ0UWyKDeh7PZQCkH0eqvMwmof2luuqa68CpU+p3fQ6FNarQz96LjQ
 WlMsASRbhMfPJwcM499mPJm3JtfW1ASpijNSVXGy+H2/NO/sFAQ/EpMbRGEQaY5x2fxcx7L67Vs
 kxrzhvXcBr4hUVIO4r+X4jAL0W6QFyJ91A9X0jN/fzHowkjmLYcEbI2AN04aYf/s0F91+dK4ePI
 /pV7zJrg2vAcKY5XUG7eBr1EfooHxCY84oFgg1ES0pVrl5BUzxiwG9ka9iXj10Eqfjunt8hCjL7
 O+4hACv00Y=
X-Received: by 2002:a05:6000:2212:b0:43d:68dc:9ca6 with SMTP id
 ffacd0b85a97d-43fe3dc7b4bmr36739989f8f.18.1776887973391; 
 Wed, 22 Apr 2026 12:59:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46471sm46419397f8f.28.2026.04.22.12.59.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/48] hw/sh4: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:13 +0200
Message-ID: <20260422195746.88865-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-33-philmd@linaro.org>
---
 hw/intc/sh_intc.c | 2 +-
 hw/sh4/r2d.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 16e4b619d6d..0da82f9d5e0 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/sh4/cpu.h"
 #include "hw/sh4/sh_intc.h"
 #include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index acb3fe75a8b..99afe3618e8 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "cpu.h"
+#include "target/sh4/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/sh4/sh.h"
 #include "system/reset.h"
-- 
2.53.0


