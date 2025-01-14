Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A080E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFs-0005By-Ah; Tue, 14 Jan 2025 06:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFd-00055I-J9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFb-0005P0-Ta
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:29 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso2950287a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854706; x=1737459506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0SipZjZSJ8RGOzW6wWIIrmkUJqEseFLNGa6w4kFsPM=;
 b=j1MvElZeUnY5BwersMfw3EM9OI+PtBEKPOBcPyfP947evhGxFILu2qmugHfBZr2BOS
 NO+8HzM18D2CU5oUyJitYc2cwSnbWLGwj18Iytg5mic18CPC3rlsWCcMU+kXgfUS6FC/
 B2CjdVIT1OzU2DJM7TzN4MExdPGL5VuaAXAdjY7hwVzqBbpg2/ucKXq8osmu3ERtkZTS
 HQ8DDGmK3I8xxPBQEMslOPHrHepK6JyumqNX1voIYHxaETeS8KbX7mDRZEGyO2XTvovL
 /ETPPRQDucfaV34FW14DMhggIXAwrg3r48lABfzMoJtWEYIiBnlRVHFE7efSeuIrotpJ
 yf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854706; x=1737459506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0SipZjZSJ8RGOzW6wWIIrmkUJqEseFLNGa6w4kFsPM=;
 b=V+DLz6phcrIYpOvgRNR7pxc4++NEX7m2M9Je6Z0nIbM3t4PEhi8APPCenSYHFTVy2a
 JpkMbZH+XYuHlSQLv/q8tA9Vg4nQyzqp4eZClHPDN2mbwokU72tsnfYJk4geZXSvljBF
 /lNdl7xS1pRqu3iXyH1pAWnvpMWSwXsKjRPztFIedW7PrK9fbDC5G9U6tJBUugcMivqn
 pDwq87bDJjuDH/PmSaNGawCmcg0MSkzw2SgBKKHrx3+uQs0JMGTKtlKwfDaZLwh4W9sB
 9Iw5TQcN0EUfAeoOkPIUF8Hyq+fKutZE7Esc7uwvJhv5QPwyAf1t4MhakAxhbwfj81Ux
 C+QQ==
X-Gm-Message-State: AOJu0YxRrr7MxT3q36Fz/a7eyuK94TEm8GvJHlfJeC7/JJ4ay+oRMVmR
 Qep+1eC8tGERu57/3hM+6NbwwxUkDk+B2Pbz9+CwKaLgIf1vxFNt2Lyi0Yn+6hg=
X-Gm-Gg: ASbGncsW5J64gIZr21cGnqAZmWwBkJ9Do5ArM7foMYZHWLDyjJjCYB/QvTK9wsmA11Y
 t5WYNYm8lC91/XQV8VQQDpFjGzcauNo+BwjcvZh7ULNHADZ9OB8r/z6RrxzKHmp7b7Kv191qDUq
 pJjxTeAWtiotJd8s+SkZAUeGEhnqfWgU0VZBYHttZhWdhWKHgpoko5Ks65PfLd8gX02FQVN1mE7
 kmoebnYSfoaph/ZViEK80hzBSNNctGr8QkJU4JKJMYViBgS37zd4Ug=
X-Google-Smtp-Source: AGHT+IEsdf4iZVC3apfhiO0ODtJgm+ywWlh0cRwM9wDem0JxkPyAtQ/tsbOCVAfRqqc3sqITnHMYAA==
X-Received: by 2002:a05:6402:5250:b0:5d9:6633:8e9b with SMTP id
 4fb4d7f45d1cf-5d98a10660amr17120511a12.1.1736854705477; 
 Tue, 14 Jan 2025 03:38:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4b2fsm5959449a12.29.2025.01.14.03.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50F485F93C;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 06/37] semihosting/console: Avoid including 'cpu.h'
Date: Tue, 14 Jan 2025 11:37:50 +0000
Message-Id: <20250114113821.768750-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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


