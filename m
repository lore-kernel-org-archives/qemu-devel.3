Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F458C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1w-0001sl-DM; Wed, 26 Feb 2025 09:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI13-000176-7h
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI11-0005kE-1L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3910702f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578637; x=1741183437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MUzqz6FU8Y/M1Y0uPwJOCVPftv09cieoqEpBt2LY4U=;
 b=xz6O0gKLw/VXIgarrIxeeO+DihB/0DDA8ZOE4267oykmDm+siJuCrvA2XBEHpF2rz5
 cE0+N1J6DTDsPmehD4WgzWbvU4rwsDkyptC3+nBv9ms3lP0lC0j19Pn8kzuJctNuSGbn
 T0Oz0cL1kd3KohaXJGAjqnXl7RcSIVDeUrMUhdqDfDXPjYbeooJGlcA7nCwC1sep4qWQ
 TugNQ4/S4t+amGh9kGRzDjSX/wiXAI8vpO4gGtbTwRkvh8gP77obcTCkk/xiuNXseVVW
 qomX969MIwZc/ZFWhkJJMSoThg6EizUM4Vn4Zg7k4YSXB7Z8KA6MjgPF0u3h0AzhuyKy
 Ydww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578637; x=1741183437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MUzqz6FU8Y/M1Y0uPwJOCVPftv09cieoqEpBt2LY4U=;
 b=MdBDh3nHLlmpBp79JyMNcWOqkrQCOCZbGmhz8/ZWS33633Cgn4AKGhmbK26YdZ+qsX
 ekK8G9nnCLSbiT+q5FevmxPi+3MCpqEzNhXwLj/L/jhJ1kzhs1aYd8p/bldky+C5BQz9
 6dnk8vQHiGeMK3RtOznFwqZt997UjIDXFh5YiV4yc1yYqiiUs+U0Uvzh2PkYX/Il2tqP
 Ls8FvyXQRLoV46POqZA+HnA/UvZLl+UN8srtOBtOV1BuQyR7YnQuIeIgGfMz1ZzCgTax
 6/juuU2f8TdDYvOWy+3aCWl36n+vPiE8r0X0Xyv0ShIbZFYUafpgNSKWQ6JyBklyG2d0
 /qLg==
X-Gm-Message-State: AOJu0YxER+rBcj2C3YsgTLO3xM+FwbLr/oAts+C5rU+gtPtqiDG/pz1i
 HlixpT30PbdaAh3p2qmNPm5nFgxM1v6wwdVeM2vCGQP7WH5oQv4iCuGebhYl3+s=
X-Gm-Gg: ASbGncvopz6cvgqcDf2KVF/Q4Mk468Wi0b1/PmAayNgAvPw575AT+edHuX2xgiiIZCP
 2IyLF+k7EernDiwMU2d7xbKftR9AjgmPeKrti+SkZLSAb+nH1VJjxcvsP0BWtTnRRaEpMYtA9jl
 UiJSjZw9QH1YF6gYVF3fKCPGnZLQHfwp1DoYCcXHx/YYb4Hmh4TWraFUF40C/Hmz3BdbyogNz7E
 QpeflE7Ik0QowJj3StTNW6zXe4f8nlZIvSVXnxfnPTcC2ZGMnMblK77X1k8XbOrxGAQ+l3jVH2V
 UwGjZ5iTD4zs32WyO564lJNuQNzC
X-Google-Smtp-Source: AGHT+IEUcvdw1IaTUoKCYFEgx5PnlVjkTybddnFs1rMJ9kJQcWghkz9g9m7ZnxN31fMdFuSJxA641g==
X-Received: by 2002:a05:6000:1a85:b0:38f:2403:8e98 with SMTP id
 ffacd0b85a97d-390d4f3c49cmr2884906f8f.20.1740578637431; 
 Wed, 26 Feb 2025 06:03:57 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86ca0asm5841115f8f.32.2025.02.26.06.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBF8C60689;
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
Subject: [PATCH 19/25] plugins/plugin.h: include queue.h
Date: Wed, 26 Feb 2025 14:03:37 +0000
Message-Id: <20250226140343.3907080-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


