Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B46C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIAu-0001Co-1c; Wed, 26 Feb 2025 09:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8e-0005Rc-FY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:12:01 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI8b-0007aP-0e
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:11:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f325ddbc2so4951130f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579106; x=1741183906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NyoI+xGCkLBfsyhs9LhZ95ONl5hcFB5ViM1AJoAqTc=;
 b=J5s26S+osGVZWOccXmiLJk6IXSNgFEJJjOP1wPdfyWGOaVPnPMvKoC/Y+0YW8xxXDR
 YCNUR/luhpS4M3BvpPPJQyc/ozFwn70IgW9CV9WAFNXgNskKv1p6221pm3D6AHyaJM3Y
 HzEaolLlJ04sbgh0JWjUaDRrpm9IvAb6AEj8HHLUbJs7+YXgFENimxtwh6F0nkJRwJAD
 UHqbJCMECKlqDph3b43LfhlwmWvw3Q20bewgPEN7kI0I8yxa+7ssin0ZCpA7x7aU6JlZ
 tavKJOj6nJg2dHHkb2vI6YNb2sLyy7RFLOvnZq1y7SryD83VbOk+xONHR1MzMR4FAQWw
 azFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579106; x=1741183906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NyoI+xGCkLBfsyhs9LhZ95ONl5hcFB5ViM1AJoAqTc=;
 b=wO4FO6TKamnhSVIjVN+e72QcU2U+cFuoKoLFi6hl8M5XpktCB6PCq5gCBw4kJIaiep
 MKYigAB40uDeXbJWFL1FoeZb5l//xWeFr/0D9xBK3DOXxxuwrMnabeJL7uQZ6tVA16dW
 qSsdYZ3l5QDhym8ozs1iAex1Kqx37sGZY+po8JMNUG6Ipepd2UIwt3BYv9aZeYkPxNbX
 G52GrPSutcA1bTOI5mfs5WN/jrolKG5wOLWupGvpsBaNaCgueGrHDR8wxKmRLhYB+u5f
 ndhml/SfnVJgbpw/hOY7EVLVGHgvuoqBc7EXSN/1aoDOdR9Fe0HUYNFCrnoSabT5AxLP
 FA0A==
X-Gm-Message-State: AOJu0YyHaF9zYi2m2etwdTAK5EU7OuWmoovYUB1d7SeJ86MUfUgaApI/
 3SvHHD8mcE1eGp8FrIJD9oFGc5fPEEmwUx8j2VQeco6kvHgEOtDdOk/pYMmJEqU=
X-Gm-Gg: ASbGncuGzXbv+dkse5z6hVlDu8ZSABiVvkqromaGS6VvP6RFoudx1k5AMCf0z4odxEZ
 JXbqjHeILHgJef61fyQmLaIo9UpD3JggIvcL81+I/zO945+Uy2T+r4fX+rDjmy3fvTZUa9FAkDO
 RPfZbE45VX4yepEU5bAAXeXBSxZBAGEMVamVez/LRfR3RSd4mrw8w2ey6Gh5YlI3BdxRqQZUGJ6
 sziJTkqDH4ueVxEbISl1n3+8duKRBXVak3JdYu4vIt3KzClebpl4PPX+59Q3/fEsO2GScG8+yvt
 gWntA571SBuMRjebbFi6H7EgxBRC
X-Google-Smtp-Source: AGHT+IFxNELsls3sumnBY27mPCqDSaPL5EAYDn0T+3jPurXwp6kQ8SYsZejxK6xU4mQSFDypCxs7jw==
X-Received: by 2002:a05:6000:401e:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38f7023e7abmr17955383f8f.0.1740579105933; 
 Wed, 26 Feb 2025 06:11:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e7322sm5923166f8f.64.2025.02.26.06.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:11:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A633260624;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
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
Subject: [PATCH 18/25] plugins/api: clean-up the includes
Date: Wed, 26 Feb 2025 14:03:36 +0000
Message-Id: <20250226140343.3907080-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Thanks to re-factoring and clean-up work (especially to exec-all) we
no longer need such broad headers for the api.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-5-alex.bennee@linaro.org>
---
 plugins/api.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index fa4d495277..c3ba1e98e8 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,9 +39,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
-#include "qemu/timer.h"
 #include "tcg/tcg.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -51,7 +49,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "qapi/error.h"
 #include "migration/blocker.h"
-#include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
-- 
2.39.5


