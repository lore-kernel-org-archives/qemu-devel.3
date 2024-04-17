Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18A2C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA3B-00050V-0d; Wed, 17 Apr 2024 14:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2p-0004T0-7I
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:07 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2m-0003qa-MZ
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:06 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5565291ee7so67397666b.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378602; x=1713983402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBfKa5T3GDZ4GDMPsL3PnIky1YQxa2I821vkb85I41c=;
 b=nmR9IEaG9vO4U+3UZfNf73oBe816hzShXAPcvGXbpmFtTxEIn4UQF74MHllEscZIZ5
 0sttTn1w7Byqde8AwrhzvnLG545AkYakpe6fqmnHPKXdNBA0MyYe+CI4Wc2gCGIjnfZT
 6WJyXuI7tlU+pxDwXIh/z33cpVNsfStRkORlk7GPmCrdl0RdpOYeAxVroa2Lt3/zJbiC
 NQHWWgcwGizv1wUDivRFmO5qvH4xA7oE3nDvEEErEja8Z8zkJftceS8cxVnJKF3/Gutz
 ljiss+esnuiX1hs4yGFyb7QiIVOiaNYHtDgHzkfO9ihIlUHgJFZOWcdZkoCX9lxp3AwL
 q4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378602; x=1713983402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBfKa5T3GDZ4GDMPsL3PnIky1YQxa2I821vkb85I41c=;
 b=hJcTHTrG2M8sND5b11tGjrtufl44Y/lIKNBlh1O3Zl16a669+RprcY2oRKoYgBznRg
 fjuzPZXxwMgLJRH/RKIEZtwGjuYIVlf7QgPPTLtXneJ3g2vIqPuey3WfsmTS2VIyrD/5
 Zr7mFFCCZzamY1I3uTmK9MCQGP7fsLTKeW8QJSxNU++Lun7+uYzMAOfGorO+oG71tIgD
 X8njIO4k+4KUr3baPjxaJZK6uQQAhJvdUjDJMvpPnu/Mji3f/O66a+JgSNXi1ld05NQs
 91FYVdqnmAegkVEAeIyIlg5iWsqHevAeRnQXmkAtCngBKGXaomA//S5CsBlYElla8tY6
 Lcow==
X-Gm-Message-State: AOJu0YztnunEOO56egfRrQsopMum/yAhThqR+T0Qar12ne9GyfDIcNz9
 rbxw+dYDao5BAb6vYaWt9sfzPoinrjLCb11Jwc0tTjJNyj8jijQD+Wv9uVxsDinkNzKpviHkr9G
 L
X-Google-Smtp-Source: AGHT+IFV1r+V1FeKw7LfngvF7zK4bYJVhlwo8o8M2P2uNa2hIpNlhbvYwbTjbLjxhZhIJja8ioopgg==
X-Received: by 2002:a17:906:e2d6:b0:a52:54be:dd8a with SMTP id
 gr22-20020a170906e2d600b00a5254bedd8amr199140ejb.15.1713378602704; 
 Wed, 17 Apr 2024 11:30:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 js7-20020a17090797c700b00a51db8c559csm8415307ejc.178.2024.04.17.11.30.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:30:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 20/21] exec/user: Do not include 'cpu.h' in 'abitypes.h'
Date: Wed, 17 Apr 2024 20:28:05 +0200
Message-ID: <20240417182806.69446-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

"exec/user/abitypes.h" requires:

 - "exec/cpu-defs.h"           (TARGET_LONG_BITS)
 - "exec/tswap.h"              (tswap32)

In order to avoid "cpu.h", pick the minimum required headers.

Assert this user-specific header is only included from user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231212123401.37493-20-philmd@linaro.org>
---
 include/exec/user/abitypes.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 56e96fcb99..b5c7ad4d1a 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -1,7 +1,12 @@
 #ifndef EXEC_USER_ABITYPES_H
 #define EXEC_USER_ABITYPES_H
 
-#include "cpu.h"
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+#include "exec/cpu-defs.h"
+#include "exec/tswap.h"
 #include "user/tswap-target.h"
 
 #ifdef TARGET_ABI32
-- 
2.41.0


