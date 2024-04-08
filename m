Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65134C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrBN-0006MP-6k; Mon, 08 Apr 2024 11:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrBL-0006Lm-QS
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:45:15 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtrBK-0000Ud-28
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:45:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a51d83fafa8so130563566b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712591112; x=1713195912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZKStiwR5JhBWOERg4EH+miKSZdReZnGSFSeeLdG9Iw=;
 b=QZPwwNsJTkZqLsM74/tm4mENAHc0B0rIcPY+4wGErClrNooMr8bZckLB3VguO1qP3y
 ah6S+YDOwgUUaE5amjNeXPxEQOl7+F/03yuxvc6LtRBw5p6EvjD67aZPTfffdprEFTYs
 3aJQ7Lv9Mkai9GU2igDEC1bovd1hOhodDRvwhwRhBUh52C9V51/uuw6wRaomw5E9NSgy
 5qst80GjoPKg7/iuRkUJR/PnrH0CkVnCpnNblm2uWJeY+NLPRXNXT+rclMj2IFyq68+J
 7bVSKjREAOs3eCEjinTInaTCtyWYsg6rAQvA9/QzaupXB8qowP2CLKzambdOyj6I2Zi9
 musg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591112; x=1713195912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ZKStiwR5JhBWOERg4EH+miKSZdReZnGSFSeeLdG9Iw=;
 b=hiArUsD2kyl5xp7f3wLZFn2LqcekQCuFCh2fSCHET7jpwcl/unn1wu+v+njTy5WrRM
 fTQ6wapUjS5t/w1jLnb5c954xaUJXdXfzHLhKFEeLzqsLnJpSJL+Sla6OWWM6Lq1y1Mt
 DUDsZ1+y3KZ1wNjLNBjHJaKyRzCfnj3GGmfyR3h/9BCATw/vvSvh01Mv0FHZXDfwjQ64
 iK8RWbvQgwHBttb6SLUxVqvg3NOWb0v3pBtsbrHuyd4O099KLRme0Pva7b+Z7YK72zfv
 tXoBt6nbS0by2uwpG9K7AaALkyHcypchzQtSOMmZUbTX9lRO8BkyR5rJx0/tNM3td8n2
 tfBA==
X-Gm-Message-State: AOJu0YzBv9yfi+Q3VSdetxJPfuSLKr/LJyqxSA7Tw40wpY9K00/wkbLI
 7NPc3KeCuW9ZjP+lpWmVbQvLSgUNrUqipU/Ll7u9orIL6gmpT4/6TMKd2yA3JFN1HW3m5K23YF/
 f
X-Google-Smtp-Source: AGHT+IHwTYm09qOD0t8n4RliQLlzEwTXj3cIAmoC4xhFsBbhkTNU47wj1zhNQCX88Tn6RhSQJNGMeA==
X-Received: by 2002:a17:906:dac3:b0:a51:cdcd:5141 with SMTP id
 xi3-20020a170906dac300b00a51cdcd5141mr4567291ejb.73.1712591111505; 
 Mon, 08 Apr 2024 08:45:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a170906844b00b00a4e23486a5dsm4542256ejy.20.2024.04.08.08.45.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 08:45:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>, Zhenwei Pi <pizhenwei@bytedance.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH-for-9.0?] backends/cryptodev: Do not abort for invalid session
 ID
Date: Mon,  8 Apr 2024 17:45:08 +0200
Message-ID: <20240408154508.67307-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Instead of aborting when a session ID is invalid,
report an error and return VIRTIO_CRYPTO_INVSESS
("Invalid session id").

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none \
     -machine q35,accel=qtest -m 512M -nodefaults \
     -object cryptodev-backend-builtin,id=cryptodev0 \
     -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
     -qtest stdio
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  outl 0xcf8 0x80000820
  outl 0xcfc 0xe0008000
  write 0x10800e 0x1 0x01
  write 0xe0008016 0x1 0x01
  write 0xe0008020 0x4 0x00801000
  write 0xe0008028 0x4 0x00c01000
  write 0xe000801c 0x1 0x01
  write 0x110000 0x1 0x05
  write 0x110001 0x1 0x04
  write 0x108002 0x1 0x11
  write 0x108008 0x1 0x48
  write 0x10800c 0x1 0x01
  write 0x108018 0x1 0x10
  write 0x10801c 0x1 0x02
  write 0x10c002 0x1 0x01
  write 0xe000b005 0x1 0x00
  EOF
  Assertion failed: (session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]),
  function cryptodev_builtin_close_session, file cryptodev-builtin.c, line 430.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/cryptodev-builtin.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 39d0455280..3bbaabe86e 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -22,6 +22,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "sysemu/cryptodev.h"
 #include "qapi/error.h"
 #include "standard-headers/linux/virtio_crypto.h"
@@ -427,7 +428,10 @@ static int cryptodev_builtin_close_session(
                       CRYPTODEV_BACKEND_BUILTIN(backend);
     CryptoDevBackendBuiltinSession *session;
 
-    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]);
+    if (session_id >= MAX_NUM_SESSIONS || !builtin->sessions[session_id]) {
+        error_report("Cannot find a valid session id: %" PRIu64 "", session_id);
+        return -VIRTIO_CRYPTO_INVSESS;
+    }
 
     session = builtin->sessions[session_id];
     if (session->cipher) {
-- 
2.41.0


