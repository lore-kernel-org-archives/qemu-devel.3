Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D5C282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiW-0007KJ-Hc; Tue, 04 Mar 2025 17:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpahC-0005Sn-3B
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:09 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah9-0006Zx-45
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:01 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e4ad1d67bdso9753734a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127096; x=1741731896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jk0L9tiR8Pw91LWiTI1Z3wlxkKLipHgTcC6b1a+5kwk=;
 b=K4QqxobgGpnRBGZ6VZ1TXgp6BHR/9DGr6hbOX50/vYHJoAZqOFpqMFYWfGPlgOn+z/
 389RiJmV42o0f5wZCtEwkAK3kPBPPRer3fwnm8zDMZK/A3VNxzZJZVFbrwgaxEL06riS
 7QfAmIG8MsH/nILMqSnggeZNx9cdOrF3SK78Rk6M8Xm42kGYoDJw6F7o7Sz6nwbV1ZUj
 BlJ/EyAjxlgxysrf/HINEjnVeeHQtu2peWk16fPTqZNk9Kyyc1ZBoTlf4VVc5h4xlDUo
 xtoX69ybUq1bMcVr5ax8nOJRdYQNaTyEx3DTjsFaew5F16aa0BLh0Y1g38tmjMWrFPxX
 VaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127096; x=1741731896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jk0L9tiR8Pw91LWiTI1Z3wlxkKLipHgTcC6b1a+5kwk=;
 b=WFG3FjyIL73g3abYu4VzPJq5KYD5QMFaN7fZHqOyc84ibutHIJGYa6MHWOMoyQBECk
 Wc7naV2iqEg5Rm+ZeH8mWQxjonLgBw9Imf76RhBVziivwax7R42FJFZR6b7Gv/XXxzIK
 wiYgA8WNW+7rjPZHu/4isiJjlnZBdGQb0m/W0ENcS0AIUKnKZE6WoKAuoWybBXCb/N0y
 z/OrNAtcJnt6qhNX0xAOtNZoMuMoB6dVaifzBjiG2boTWreXfEcIaqJzoNEDziK3d3Nw
 BkHtVUXhhuHbt9wLcpidGAym/U23U6FyhG7uhRgthjrj+6mEHVqikKVlZKGGhquiVvU8
 NBPg==
X-Gm-Message-State: AOJu0YxUYRin4x4cIOJfIGVNQHcNHtOcwxzWXvoPpgLmATwHIR+kmkB5
 NknK13SWs/nXnl9I/T3dUw6xdceXunckpMMmGuCOS5frHZRMX+7GSbvw6Ljs1ZU=
X-Gm-Gg: ASbGnctOtAtKvT8sD1QwZLwcSbMZTABPuklHi2y5UegTov6JLlvLfqEJTe3kbD4Mrcv
 UWZEmwkIOIlyhiRE2fCC41jE93cRUw3kHl6FCyzm3Aug5/mMAcJ+TAY73XD3wNybrwXJmZzugyV
 mmW3YApCkHg3VMHi4+/yjI26eTR25DEKlWOgVevBZD8b6rkUd+5hXekr+d5ghqDL0AGMhZYiFlx
 MhP5HZcEj3a1mm3KCKXtM/USn21weTu3FMVu1/smcLgOfwcKreP8vKRTKG7UlFhI3gGwCb1x9K9
 /R7/9+qTQgdp++LS12CHKZlfT/DVXdpkc+DMgp0zFLrtl3A=
X-Google-Smtp-Source: AGHT+IGzd4q6ld9rSt6nyxUB3LQc/TZ9sahtNbY0Td0uifmVydb/pAO8djsz0D6JUVFlW4mE+bMxcw==
X-Received: by 2002:a17:907:7d93:b0:abf:6cc9:7ef5 with SMTP id
 a640c23a62f3a-ac20db05bc9mr102181266b.47.1741127095791; 
 Tue, 04 Mar 2025 14:24:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1f6a3769bsm164672266b.14.2025.03.04.14.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 561CF625E8;
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
Subject: [PATCH v2 29/32] plugins/api: build only once
Date: Tue,  4 Mar 2025 22:24:36 +0000
Message-Id: <20250304222439.2035603-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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


