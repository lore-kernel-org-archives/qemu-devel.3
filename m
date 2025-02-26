Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAF0C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI20-00023M-1S; Wed, 26 Feb 2025 09:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI14-00018p-It
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI12-0005lt-HQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso60067455e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578639; x=1741183439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jk0L9tiR8Pw91LWiTI1Z3wlxkKLipHgTcC6b1a+5kwk=;
 b=VIpwlOdsIQjLe6n8GQZ0VPukngFEWdZeDShN5R7I+3aKM0/nt2MH97yq+G7HPb5s3t
 N36p4fE9ghvJfS6T3684+FxQhl5X0deQhVwbQQK+lann9SOcEeqxhi0IleSK96Jb5HVi
 zgjoeytI3K8rB2uAQHxqAbTKbEAma0CReT7kCYOgaIYxa44AbPbJQHrzE5v/Fu7e813G
 gd+Yaqst/3gF9rgYuBCGXV7V8KS/DV3zpKV1rE3dFfECL5Rwxh28KVI3kBWmQc7PkFAb
 yiN+JqydKJtSyt1/Cl4A6ya25GwWS1X9lHckGf7x6QTI2kfVgpvbPvRI0C9cFYTWDCaU
 865g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578639; x=1741183439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jk0L9tiR8Pw91LWiTI1Z3wlxkKLipHgTcC6b1a+5kwk=;
 b=HrdkUmkH/5qomA3HPi8YcLpI456WQUJiLebejBdDD9wft/4QhUV/u1NW/2s6/e78Vb
 MoPmuQR8MhrRB9Y7YFPBFBom+rlc6QC2/S5lR1U+aTPnr1twUvE8sy7vGxmJPhI0HFwL
 n9UiV+4vO1WHK3wiZ77tNm5HHqf90befPQkQUVSX8zBAoglzDSkUvIMz/uKm1CYmYZNX
 7iOWAzsK8G8KcTcF36eluL7t991JChU+VOpAfAyPRFrcGWJ3Cvp5ncVpik8sUbpPAc/w
 vUKpgsgashXUgzP1MsprP2djCVuUFboQ0poJFAStQfr3UGTlc9tiqwaKy5xJbWGmdcI4
 sCqg==
X-Gm-Message-State: AOJu0YxCFWcS1POr4hBi4YLTLXCk6u2gnz8g12X9wxSiLe+kSlGIbFR8
 vRd2e3aoICZqWMpeV1a/5EBIiUVvka6XZIaWD1yIpf81U7egGMqgWDhsCWm77vg=
X-Gm-Gg: ASbGncv4lhiosbz82lqH9XjPcaKD3zzfVLQ7Izc4k9aNOa3z4AENNxhpYkGMcwQOiWD
 wfCjfpW1kzYFd5RZXh6RYCigayteRTyNp2arJqQ217g8pPsaWPPAM3mDXDMUkop3rY8HtR8f2pc
 03Vrg5I6jILeSBM284VQqnwFLDhmJ2++elsSGnc5mbPdbe+OcX4/FWi5A6AXHYrJm6j1XVgK/vU
 ZXb7zh5oZBad9uM85m135vje5Gr7PgQVrr34aANBRCusgrOXDpLQI7LPVJuFXLoTFMRwzwbE4GR
 6qQT/xzMwM2Um+MmmIDksTTsYhlp
X-Google-Smtp-Source: AGHT+IF2S/46ddaGkbCFrC/nFtvPp4N+60pIBssQ0PTdgKTjFNv38cgtY2NZGSdf3l4GiBKeEZC9Bw==
X-Received: by 2002:a05:600c:1c06:b0:439:64eb:67cf with SMTP id
 5b1f17b1804b1-43ab8fe027fmr30468845e9.13.1740578638944; 
 Wed, 26 Feb 2025 06:03:58 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53961csm22477935e9.17.2025.02.26.06.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 507DD608D4;
 Wed, 26 Feb 2025 14:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 24/25] plugins/api: build only once
Date: Wed, 26 Feb 2025 14:03:42 +0000
Message-Id: <20250226140343.3907080-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Now all the softmmu/user-mode stuff has been split out we can build
this compilation unit only once.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250225110844.3296991-11-alex.bennee@linaro.org>
---
 plugins/api.c       | 11 -----------
 plugins/meson.build |  3 +--
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 832bf6ee5e..604ce06802 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -46,17 +46,6 @@
 #include "exec/translator.h"
 #include "disas/disas.h"
 #include "plugin.h"
-#ifndef CONFIG_USER_ONLY
-#include "qapi/error.h"
-#include "migration/blocker.h"
-#include "qemu/plugin-memory.h"
-#include "hw/boards.h"
-#else
-#include "qemu.h"
-#ifdef CONFIG_LINUX
-#include "loader.h"
-#endif
-#endif
 
 /* Uninstall and Reset handlers */
 
diff --git a/plugins/meson.build b/plugins/meson.build
index 942b59e904..d27220d5ff 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,9 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c'))
+common_ss.add(files('loader.c', 'api.c'))
 
 specific_ss.add(files(
   'core.c',
-  'api.c',
 ))
-- 
2.39.5


