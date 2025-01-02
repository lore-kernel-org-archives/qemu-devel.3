Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5256DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMsx-0007YG-JS; Thu, 02 Jan 2025 10:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsn-0007Vc-0c
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsj-0006Vo-0y
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43635796b48so69502665e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830781; x=1736435581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJKhnsw6sz3wiF8lOKV7uw4NqCWo3JxX8CcFZUizL7g=;
 b=NbYniyuBq9FrWTpjvs576Yj9/lC+HRCsUB1V2Xzd1H3PPFLz091CUAfC4ryXNz4ItN
 ulOoh8QhBEmXXCXa949PWktdiXyGBX5d/0JssP3xB/cByLRbHvgshSorkKCzxtkflOCN
 nYgPztLe9cGBouP19BwX+pUrkJKJCWKBdW7/Z8UEN/iSS4K9PYeffiX0ytnDMCFcCPyx
 RgzdtTZvO5DAea+MwhHVIW8JfIuW/nM83dU3vxnfsn5M8i4pVpwzyImU3kBq8koOqak2
 PklxtWjQYLD+qxkZz0UpPlOwBUILilD63gCqBWJsEHoAZPABsWDVvtOnrS4xvUQFPpMw
 npSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830781; x=1736435581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJKhnsw6sz3wiF8lOKV7uw4NqCWo3JxX8CcFZUizL7g=;
 b=O5mnZHOIs4A2+AbTB9ZeOGwRIvZb5yJGtrnCEfomX/RWxaAyW9J0+nNdkb+/1shWCC
 QDU0gJd6QaEV60OqodSzmiIxiOmx4AyAnT8QwbzHIkQB2qSnsWs4Zoj3krPnynGgB9vM
 NAMP6rhDkpU2+SFMaeK0EMiWPpkvNI5fW7LCThMXKmZ0Wu2+HfMozE8enxW+olYdxYzV
 hmJyGs6LV/mN/5/2dKtVUJuqHlfDuNO+07H91gdoZ24UBDVvQR2z0ZBGTS9AAZb+pIEE
 3bf/ADIswIcwMtcVbFbYKvFw621o+HeUawiy1Jm6rMBUfydjlfF26COzhmunw4ZmJrqY
 jFWQ==
X-Gm-Message-State: AOJu0Yy+rUPY3aK6fY1gDFmCnRtRRyAhfPPt+6vHtszQAkG1OdnKin1l
 Oa+ryr9Jsyyo61v5Nmh01v6h7YvMwYIw9hhKWlXQrxgvUFwvuPqeyuIXLYhRJCPJWEQ06Oy3iLI
 XlgaG3g==
X-Gm-Gg: ASbGncttO37CMF2sagIULDDuXmQbsyBDsy+HCBPQfhFsXnI5MEsrFsQhJeT7yFPnCCU
 KFDs0BBYxUFY6JGJ0WymEGHqwNy95fAj2FwYQnKx8ic92/Ljc03z+PgkG9J0DO0jcG9j9pBQ7iL
 UnwajyiYqIAjHkOFL61UlUOYoJy74hbJkeP43USPe+pzDdM1VgUurgdoL3eyIkuNK3t4R6VrKOU
 P7RigwKLgkOUzqHeNh2JaDWyENQRiy0ldHj1VNUJ6myBT8hJEModCw7KBjRKZV0ZluRwx+6p11X
 6dW53Z2iJFOkQ6iK/BF0l0LqgB1Xs7Y=
X-Google-Smtp-Source: AGHT+IE4JPVuNOMW4gJ/XfyPVyPWvdFnceGsMphKbjXGcE/1kT9xlfZMS9MJwHYvGmXYStd0ueS/FA==
X-Received: by 2002:a05:600c:1c20:b0:436:76bf:51cc with SMTP id
 5b1f17b1804b1-43676bf5382mr337631465e9.12.1735830781091; 
 Thu, 02 Jan 2025 07:13:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a376846sm459330385e9.0.2025.01.02.07.13.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/10] qdev: Call qemu_create_machine() on user emulation
Date: Thu,  2 Jan 2025 16:12:37 +0100
Message-ID: <20250102151244.59357-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For system emulation, qemu_create_machine() is
called from qemu_init().
TCG accelerator always calls tcg_init_machine().
Use it to call qemu_create_machine() on user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c2565758876..e18b0c03f71 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,7 +35,9 @@
 #include "qemu/atomic.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_USER_ONLY)
+#include "hw/qdev-core.h"
+#else
 #include "hw/boards.h"
 #endif
 #include "internal-common.h"
@@ -124,6 +126,10 @@ static int tcg_init_machine(MachineState *ms)
     tcg_prologue_init();
 #endif
 
+#ifdef CONFIG_USER_ONLY
+    qemu_create_machine(NULL);
+#endif
+
     return 0;
 }
 
-- 
2.47.1


