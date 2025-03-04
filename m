Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E85C282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpamS-0000gI-Qx; Tue, 04 Mar 2025 17:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpam4-000899-W7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:14 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpalx-0007mD-Na
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:00 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e4b410e48bso9316494a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127392; x=1741732192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MUzqz6FU8Y/M1Y0uPwJOCVPftv09cieoqEpBt2LY4U=;
 b=gOrHS6IcnjPMtnDeVDxf+yUEFpK3E+x//YOm9KKdMdy3jkjWUuE8uXRfLWAI2L0r3m
 YWqj9i3Fik0hQC6OzXvm0/FbxuuGsB77K9Psk9xvXcrC/QW8LHz4qdE6EadMgAwMuPqP
 opiUpMz5yJqZPcVvxlLY95BT0S+n0WtCIgCFlAcMdM8xfc6cxyCVNplud3ep89Rctd1V
 LQTFLYdU8iaS5LEwrk3EObc7j5aRBDLZ4Hgr8SzcjoSp//csaa9LJESj3XeNNHECQHQ2
 L0BIDd/9XptFp7qTK3pH9ZGSMm+1sovRL/N0dZqWOFGQllJz1D5d3ks8c1gFuhXPXjEE
 n/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127392; x=1741732192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MUzqz6FU8Y/M1Y0uPwJOCVPftv09cieoqEpBt2LY4U=;
 b=g6c4Ren53AeIuW6WSmiJH0/EY1DNu5RK1KI1bYOoJq48GJLizqcCbQ0vZPJ7Z7ALpm
 CQCGecKs9IgwMnLp+REE5Pnry4g8XM/0efVwp9l4PAH8vepYrcH/jCQipqknm6yF23uh
 R/yO41sH8iBjVuGuhY14kC5xJ37rJ6C2YdseJHLwnUgjtg4F5b2bgdSWT42t8HqX/Rrl
 FeAccAToUI67FSpRlNaDaMIXXDSBuSlrpHCriloefHWIC7zAc0aLwlh2vKeHbhnW6hBd
 MsakqvJgU64vjYAm6aCR3tntxugqw0+PIXPInAd/tBkCVuq3OMrgjKxqDQBZCqLk17Oq
 eASA==
X-Gm-Message-State: AOJu0YzJMilgEwBLddEQQOpaThAWW0ITZ086brrakKE0DStWQJX41Ncf
 YTKSgayMRxF0TxbLgXXJmHr6nJQXf7+t6ebkvmy3LhgW4ziDysmAaYGtmM4WgOA=
X-Gm-Gg: ASbGncvk17NAxgrbtXXm7MlHmI86vPiu4n8OGAuiwPlEDr+Ko/r2UQQxaA6fsUVyp1s
 D28EjpgEHJR2xSci4Jk6H1ZUy2L7OR7i+JIklpemvQeVm6jwD/vXvCRLaoC3eNgXWDhXYnSTfrp
 54OzeX3SfxoElD2bHLm3fS5s4359mmRenhS4yreWMylAaPIY0F4VjuWZZQeHZNJc+FNg/tr3fDK
 XD0Bp2bGrgmjRyj+W+nelTMmGGFP8YsNGjcmomGaGbtAdnhIuo/m5Hqk9fy3FnmXtYdMlAj+Ix7
 2xmOvrgySyyWW+t04gI7pl0wWlBoG60BPDLv/b2gImytTBo=
X-Google-Smtp-Source: AGHT+IFx7WoyZIFi/Hi60hpxy6n5v8dzpQS3KPFarlJ9FYinvav0z9Ev12XjhWqazU0R05TgbtlN4A==
X-Received: by 2002:a17:907:7da7:b0:abf:6b14:6cfb with SMTP id
 a640c23a62f3a-ac20d84494cmr79356166b.5.1741127391992; 
 Tue, 04 Mar 2025 14:29:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e2ced681sm283977066b.1.2025.03.04.14.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C14A2625BC;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
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
Subject: [PATCH v2 24/32] plugins/plugin.h: include queue.h
Date: Tue,  4 Mar 2025 22:24:31 +0000
Message-Id: <20250304222439.2035603-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Headers should bring in what they need so don't rely on getting
queue.h by side effects. This will help with clean-ups in the
following patches.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-6-alex.bennee@linaro.org>
---
 plugins/plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 30e2299a54..9ed20b5c41 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -13,6 +13,7 @@
 #define PLUGIN_H
 
 #include <gmodule.h>
+#include "qemu/queue.h"
 #include "qemu/qht.h"
 
 #define QEMU_PLUGIN_MIN_VERSION 2
-- 
2.39.5


