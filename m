Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B10C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaqv-0000Zu-NY; Tue, 04 Mar 2025 17:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaqj-0000WW-G5
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:34:54 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaqh-0001O3-Np
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:34:53 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1131455366b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127690; x=1741732490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gbc4xRevNcxKhPTEVM7Uxyv/yl8OruDV/F/XzKp644=;
 b=PsNLfvJ5CXXusCN22XmWgrLRLAruiaxVSkYJV59D/3WtDj/MB4ByA8WeF39N+VxgK0
 wlJiUp9ELrO/iCGtE5jbgLZT/gOtlW3NvNLALE0f464qwoxdIa1kXAu+Hva5BX+YDuoz
 rp2FPiSY/240jcPBJZGl3ij75EloO5dZhRdd9HAbLJ56+uk5j9cKrfza+uxHDZ3gh3mr
 cp4hNALDGMwAQWVLVMUDrsvLJ8FpTXI/84EKsI2ni+bXDkyT34LB6W1mHqW89fUYSI9w
 R9PBd60Dl/AI7GJVP8f7SDl5lCUR92U+3DkW9gGlg6aT/MAN4ZLDtWBv/701xk4noJhT
 EG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127690; x=1741732490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gbc4xRevNcxKhPTEVM7Uxyv/yl8OruDV/F/XzKp644=;
 b=DCvu199/gicVGXLGtYEVwy98ksh//FYtNsg2+6TII0Wz/NouB9hvT4GBh5RzS0L557
 A2bkWh8N1DUVuuol0/gDrYrE6uictvmhgod79pAlPmMM6b6q8zOhKJsivypg4OafIPDn
 0CY7kprpjVs2sbI1xNmixTtQltjL/w68NgXqpzeMhi0+jRkkgCMFLaa3stG7IQ4PWHMP
 ekzfuAiGVNr9be6Z8EwUj6uYndFTHbysg7d5PpqezDQ3e/dH5hazZ2JdIr6xIUGnO7fk
 NSoSRRCH+asFF6NMdcySN+AKxtoDDZQkOb6RD98uyoEyFfegt1Uq7/N0ITd3UJUjAvD6
 Q8gA==
X-Gm-Message-State: AOJu0Yz8BKkxoFrKbQqmtE2Dilk+J7CSC3CR8RQDulTpKZAWXrE+TiSv
 VLl5JB8JAj1jeGO3V3Qm4xPFQEEZURKdRfHodk9uKcMbv1kx+HCznAD0K9EDvXo=
X-Gm-Gg: ASbGncsneEbCAoFluw9wQ3vnMpo0SBQegRr6VQ4cP/7iKxV37Q2jnHPTPUUg0vLcJVQ
 vvQl3+GbrUWL03E+pNdlc1f+B6BvdnExrlNoo3khC+vFYEvK/R36/gV1FeS9dMoPBuE6gx5tvpD
 rloyGrz175wnNLrxMsirSmJJMDErtaVMRjkZQz90vd7+WuS9QpH8j86Kfl4Bjg82s5QbXWNXarM
 6nnySuahIFBeYmNMs4piAEGORVAxoxmpa4TJs3hP8We38N97bbktelBVl4CdWYYRYouaTjf5Mtz
 jYnUTiMnE5tMd/SccY54ZdbLoLqWKRM2e2oXBO0VubRPMEk=
X-Google-Smtp-Source: AGHT+IHoHX0vn54s8jHxEZ8M89Qre9WyOjWPfB145jEjcBNE2OH7vM68Tgon0I4aKTVNGv83huE8Pg==
X-Received: by 2002:a17:907:d9f:b0:abf:6424:79eb with SMTP id
 a640c23a62f3a-ac20d8bc9d6mr98437466b.20.1741127689626; 
 Tue, 04 Mar 2025 14:34:49 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf7a9306a3sm397112466b.90.2025.03.04.14.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:34:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 702AB625FA;
 Tue,  4 Mar 2025 22:24:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 30/32] plugins/core: make a single build unit
Date: Tue,  4 Mar 2025 22:24:37 +0000
Message-Id: <20250304222439.2035603-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Trim through the includes and remove everything not needed for the
core. Only include tcg-op-common.h to remove the need to
TARGET_LONG_BITS and move the build unit into the common set.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c      | 10 +---------
 plugins/meson.build |  5 +----
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index bb105e8e68..eb9281fe54 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -12,22 +12,14 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "qemu/config-file.h"
-#include "qapi/error.h"
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
-#include "qemu/xxhash.h"
 #include "qemu/rcu.h"
-#include "hw/core/cpu.h"
-
-#include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "tcg/tcg.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "plugin.h"
 
 struct qemu_plugin_cb {
diff --git a/plugins/meson.build b/plugins/meson.build
index d27220d5ff..3be8245a69 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,8 +61,5 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c', 'api.c'))
+common_ss.add(files('loader.c', 'api.c', 'core.c'))
 
-specific_ss.add(files(
-  'core.c',
-))
-- 
2.39.5


