Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BD4E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzR-0004hV-F2; Thu, 09 Jan 2025 12:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzG-0004gn-Ef
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:27 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzE-0006y0-Q4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:26 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab2c9b8aecaso130628166b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442383; x=1737047183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mmFjWAfoOONUODYkZWtQO2ol/JE4H/G6qm2dOWJg5o=;
 b=AAlp7CF2ogawLXaWhHYZoAiD4ioyZPQdtodMo/Fm6tbRPEoWWuewV4PNBCLNBmo07g
 2p+AJFjCi+UCyNo9K7Ivsu34HgkvjBWmi8XXmKBTCblS9G1NxD75fbHIhMqRxFzO3PGU
 fWLuCftslFyhq8S90olI6rtWY0iZxSx2rKRBa9B+WQMZBFlbu9O5JhwpzRZnXS3ammb8
 Gz4FHy4SOjMqZD2Uj1kxnPPvJXEdizmYBuqz71dsR8/8bOhPViOeU16wk+KJzPBsB/Qr
 eYs52OG70XZWiExBsH2nWcO0WOeUcWmx0eIBnnbbmT6N7PK6LFMXB9vTOsPQc8ulULow
 IhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442383; x=1737047183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mmFjWAfoOONUODYkZWtQO2ol/JE4H/G6qm2dOWJg5o=;
 b=rCo7GNBHFuicngK+il2i0krEqt1dru7JjP1It/e3RcwwdNrzO4AIhGF88Bh3Q8myDV
 rOXU20hhumoSYUgS+XYqCA748N/jdW2b9WHIwE08uWHqiNu1WsXvdtA1DGn3BV9TVg8N
 +Esp72s4nQexwMWJeI50vyKSLFSLYdqGN74t420cVtUXInKmLaAzISC6L9IoGGfThtJ9
 q2Hv/5oJuJrDd8mzXSHK5GsLhgHWuUVtNaIMwQWo+RFyzlheFtHFFJ/K0chMUeOsf7bQ
 xQsmeDIybmpXn9+0S9dtT+wwKXzuYzWvpRz+ngdqWJ3A8MeA55bl15k5J9Ta5lnMSyKQ
 ujXg==
X-Gm-Message-State: AOJu0YzvfxqAZQyy4HUEPIlvOhezFbBPKHkwXMFh4yDAjz/8kAjEGaKW
 G4fzFTB+RkAfDbK9QfZg9SHFDS1TY4LWztoam2woZxHmSquVs4lTC3geaUOkscg=
X-Gm-Gg: ASbGncvgOjhxhF0jf6u0k7fY8sWIM4LTQijb32dbRTYsIhBenx7E3Ijx4iq+URX5rE7
 e1LDJBPtClz+RbVofS6FlSfs8tGtTCcHKf5P7HwNlxWtedBJd52KC/LYozxeW6a6nshkt7dzQPq
 I5iaeWw8YwT2vcCs8Xl3xY4D1ZVAD8ySpvEs2jglb50jyZ9qgReb3goyU6Mv0/ZNcngRpkn3o0x
 8EYcfrw+5yyYPws1Hg3CsrJtbXWhcI5QDgdBJ4SfO6ikONmfMNFjUw=
X-Google-Smtp-Source: AGHT+IFnxxwGdhSiCfykDiwQ/xPJerBBFa+eQBnG1/lsBZ0tFuWXbUGy9Q0eMxay7ZetWPzQjbe8Dw==
X-Received: by 2002:a17:907:7286:b0:aac:61b:a079 with SMTP id
 a640c23a62f3a-ab2ab6bede4mr623988866b.40.1736442383261; 
 Thu, 09 Jan 2025 09:06:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dcbe2sm88985166b.78.2025.01.09.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0BBD5F915;
 Thu,  9 Jan 2025 17:06:19 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/22] semihosting: add guest_error logging for failed opens
Date: Thu,  9 Jan 2025 17:05:58 +0000
Message-Id: <20250109170619.2271193-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

This usually indicates the semihosting call was expecting to find
something but didn't.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index c40348f996..f6451d9bb0 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
@@ -287,6 +288,7 @@ static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
 
     ret = open(p, host_flags, mode);
     if (ret < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to open %s\n", __func__, p);
         complete(cs, -1, errno);
     } else {
         int guestfd = alloc_guestfd();
-- 
2.39.5


