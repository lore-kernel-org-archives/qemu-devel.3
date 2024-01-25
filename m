Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF66C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gG-0006tp-GK; Thu, 25 Jan 2024 11:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gF-0006rq-9y
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gB-0002Ai-Ai
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so87223285e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200454; x=1706805254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3B7RIYSQBA2EJV4QrqnnX0R7U4YmJKg5KsLLI0ApV2U=;
 b=T2rxg3vkySHMQvphLG/I4yaLExBBr5fNmE7/rVutu47xdMZguAVEbSLUEGu++efIoI
 RBS6Fdkj3Tlmc/El8IMLrqCpXw1bL1JScnweShUV668uCiX0tq/OtjHhnifE1kCQMJJh
 BIjUypzLzy9bASl9heFIy7OPsVH2TvDA/Td8Lk10yJt0DY2YszNnK3yM/6XBuU0y+LDn
 3+j/jocbfLh4T3SR+3aa1PcyEwxMCv3q0/pp4FLQW+yHLfkXeo/xjBCCzvWhMm43C7t1
 irBPOCj42nPtEqCNMtZ/rXQyzrteYpwhWyxWYtdc+S4IjBGGb9hYgd7WliyziDY6upe/
 wArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200454; x=1706805254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3B7RIYSQBA2EJV4QrqnnX0R7U4YmJKg5KsLLI0ApV2U=;
 b=lXiwNS2LUTzVseIi65faOGI4sKXFGcTe5PQ6oZXaiP40DZus6sEgQCXAryxpbNoxId
 QS+v25ZXEp+x6BA6/GsfcX15rxPM6F2+aC/C1F7bHDG/ph1a8c3qvzcIw6uv1bWPcU/V
 WDWKlRy949CqO/ASrC5kSVNqYyHDoDox3IMSzDsjdzSUUmC1Q+lD5/c7FeJ9PuFB5mj1
 DMjmoOXHCy6KvZ4a4Qhv/pWXRi8kmW0jceKgTnIeWOwjIlTLdcsfl7c/nGlD1y4vYo9g
 TTJ/xMlcQkIbePo08vHl8PvVaPUWZEe4S4e4r/WwEr2cPy10LcKf7p5UdsVyWCLSOMF+
 xv2g==
X-Gm-Message-State: AOJu0Yyrr1gVQzipXu1YQnIfQIvWPwNsG+xsaXpXF6l1adTW2ITad219
 4sXNKIZvXLUdy/bcjTqaUKofwpTl3zPz10itkkrDBduwzOJZOAmkNov/MTsGzR0xSZSz3v8PtaW
 3
X-Google-Smtp-Source: AGHT+IHAV+HJ4CQw/CsjJbiEyOWODFMOY+687qWqxl57jwwCUCdZivdKIsMtI/O8/EKLE0uSuKwjLA==
X-Received: by 2002:a05:600c:4f54:b0:40e:a0fc:6435 with SMTP id
 m20-20020a05600c4f5400b0040ea0fc6435mr687987wmq.116.1706200453923; 
 Thu, 25 Jan 2024 08:34:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 10/10] misc: Clean up includes
Date: Thu, 25 Jan 2024 16:34:08 +0000
Message-Id: <20240125163408.1595135-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git misc net/af-xdp.c plugins/*.c audio/pwaudio.c util/userfaultfd.c

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
These are all cases where files include things osdep already gives them.
---
 audio/pwaudio.c    | 1 -
 net/af-xdp.c       | 1 -
 plugins/core.c     | 1 -
 plugins/loader.c   | 1 -
 util/userfaultfd.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3ce5f6507b4..3b14e04fbb0 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "audio.h"
-#include <errno.h>
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <spa/param/audio/format-utils.h>
diff --git a/net/af-xdp.c b/net/af-xdp.c
index 6c65028fb00..38e600703a3 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include <bpf/bpf.h>
-#include <inttypes.h>
 #include <linux/if_link.h>
 #include <linux/if_xdp.h>
 #include <net/if.h>
diff --git a/plugins/core.c b/plugins/core.c
index 49588285dd0..ee2fa41af9e 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -27,7 +27,6 @@
 #include "tcg/tcg.h"
 #include "tcg/tcg-op.h"
 #include "plugin.h"
-#include "qemu/compiler.h"
 
 struct qemu_plugin_cb {
     struct qemu_plugin_ctx *ctx;
diff --git a/plugins/loader.c b/plugins/loader.c
index 734c11cae04..9768b78eb6b 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -33,7 +33,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
-#include "qemu/compiler.h"
 
 #include "plugin.h"
 
diff --git a/util/userfaultfd.c b/util/userfaultfd.c
index fdff4867e8b..1b2fa949d4d 100644
--- a/util/userfaultfd.c
+++ b/util/userfaultfd.c
@@ -18,7 +18,6 @@
 #include <poll.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
-#include <fcntl.h>
 
 typedef enum {
     UFFD_UNINITIALIZED = 0,
-- 
2.34.1


