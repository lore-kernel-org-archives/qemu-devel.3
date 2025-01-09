Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884B9E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzh-0004n2-N4; Thu, 09 Jan 2025 12:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzT-0004i5-6a
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:39 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzR-0006zd-Cc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:38 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso1781462a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442395; x=1737047195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0SipZjZSJ8RGOzW6wWIIrmkUJqEseFLNGa6w4kFsPM=;
 b=F4l/QF1kwZmBWiJ10uYOKqvAH27v5Q8KA2bmLN2FNSjn6wTHnz1v9WcY+7sYkWBFcY
 g+IMBAjgDPlvvagp+Pu+uxL1bZ4isBVXTDA09iYkTk+RdTJWOGJk2gpLlvqK5G2YawBg
 nOQBnYSNhm4Iiy0GwOwbPDhvoiA4MhqwT8gOsdCWlEK/Fv1HFYLuAzBKLd8gW4V411pW
 usAD3+XHAaPbGsy3KJixTi+pAQmCBDDu8Pf+YD/tGW7H9DWkd1NkhUUt5lDEQaPsfxjM
 S6aJvo3d35lylIwX8F3Qn4gXDz6hvj0hpuZBQVQHVxPpx5yAvtrMy+q5Jtsl8CKdqIPn
 Sw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442395; x=1737047195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0SipZjZSJ8RGOzW6wWIIrmkUJqEseFLNGa6w4kFsPM=;
 b=Czu7w+QtuTFi5zt9y0VxNOpdurZw9g86tEqtv8kmYyIL3JUMoSv67zki7eE0EEH7IN
 1YPeS8Hxhc1zQgw4x9Rl6MRd0r7VY1FVRhYVQ23IC07uiWFVDhgtRpvCHlHhpaFl+oLe
 8UuopdZNiwOLiG0NMS223dl+deF8cwspWJYgTBvaegz2YxtHrk5zgCC3HqaeC9WW+FTU
 6zPQF9Lch1ra+1YclgSjNND13KkE85zsdv0yciOHcTDYo4h5TyjSP2ITRlXLXlCYX8rI
 j2W3EwawwkRVSz0U2VfT1qSquddtbh5hf1/hljLJrkoWI14PNfwb+tE37n9222/sR1sx
 KZ0Q==
X-Gm-Message-State: AOJu0YzuUi6GMrOZ566smfpRiIZEStVhxGBzo8e+fj4AnUsq+5JkpSiJ
 Ei8M/jMS4hT2jSSRYpUwFpmM5FRVeXHMP7mCcZtVDMD9+w4uwTvGHZhVbOgRddg=
X-Gm-Gg: ASbGncui5Pbp6x7aLcVCyCU+Y5cJssd0y07stX27TkqyC8ZUN2Udv3UvHaoHdzq36Q3
 GwawyyuWj+0rZBhIvN9VtpizmzO9YO35dHhOic8Xcv9hqgpHwNsH66cK7TI6THxb3nDW27SiU05
 JlHNKQkQaWhc8j2LCfz0jLsZt3qOaqWMZ4FfAM0klKcG8Lar2zmHdw1dYvcQVLAYZxgQgFudWyt
 mUkflT+RUx7DtRHJ06IEYA9NdGLiVUK3fOAQ2qk4OYkn9HCFeV/G+o=
X-Google-Smtp-Source: AGHT+IGCoZGeTLQWVKJCeam+vTMVITw34eOjUUYEySBRQ7ywMcTrL2ayqJql3fpF34y1Csgrk7iglA==
X-Received: by 2002:a05:6402:3225:b0:5d3:cf08:d64d with SMTP id
 4fb4d7f45d1cf-5d972e6f2d4mr6960979a12.32.1736442395025; 
 Thu, 09 Jan 2025 09:06:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d995985a6asm571183a12.37.2025.01.09.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F4B05F9F7;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
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
Subject: [PATCH 06/22] semihosting/console: Avoid including 'cpu.h'
Date: Thu,  9 Jan 2025 17:06:03 +0000
Message-Id: <20250109170619.2271193-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The CPUState structure is declared in "hw/core/cpu.h",
the EXCP_HALTED definition in "exec/cpu-common.h".
Both headers are indirectly include by "cpu.h". In
order to remove "cpu.h" from "semihosting/console.h",
explicitly include them in console.c, otherwise we'd
get:

  ../semihosting/console.c:88:11: error: incomplete definition of type 'struct CPUState'
     88 |         cs->exception_index = EXCP_HALTED;
        |         ~~^
  ../semihosting/console.c:88:31: error: use of undeclared identifier 'EXCP_HALTED'
     88 |         cs->exception_index = EXCP_HALTED;
        |                               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-5-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/console.h | 2 --
 semihosting/console.c         | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/semihosting/console.h b/include/semihosting/console.h
index bd78e5f03f..1c12e178ee 100644
--- a/include/semihosting/console.h
+++ b/include/semihosting/console.h
@@ -9,8 +9,6 @@
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
 
-#include "cpu.h"
-
 /**
  * qemu_semihosting_console_read:
  * @cs: CPUState
diff --git a/semihosting/console.c b/semihosting/console.c
index 60102bbab6..c3683a1566 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -18,14 +18,15 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
+#include "hw/core/cpu.h"
 
 /* Access to this structure is protected by the BQL */
 typedef struct SemihostingConsole {
-- 
2.39.5


