Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2289CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 02:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHAkp-0008W9-AV; Wed, 14 Oct 2026 21:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHAkm-0008Vc-UY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:59:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHAkl-0000Aq-Gk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:59:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so33243745e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792029570; x=1792634370; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1gQ6D8/o+rGh/blUQpo+uNlD0tAWG4kIPjgB+m2W6UA=;
 b=QsDsmRaqMOHlElRwUp1MUdqVZ43bEl7fH5eABwaLATUwfDGXY3VhkEAfC+8c5vjJ8K
 MD9ldTFEa0K5uaIZre1M6FF4sQs09IarqolrfMQ+MrML1Sl/Cis5znhU2Nn7v7t4GwQT
 x+cxLMzOanancjmq295CZaYjfFoJVomqo2qPPyDh4e2jnEsv9aAldt0aonYnBZ3G+dcN
 fR4RWRHDgr+s93OC1JhH66aWTY9flCRgD/hKOP2kh8M8ora/D134KDCnxj8WGNnNdx3v
 mkWf8Cu7kZR6PR95gdBujhvUq4VWaD6vuuYbrjOM78ZC5GMCDRwzo2B+ZzxtpWCzrUPb
 IRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792029570; x=1792634370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1gQ6D8/o+rGh/blUQpo+uNlD0tAWG4kIPjgB+m2W6UA=;
 b=xpTEhorvU2iMMGSxMWdm8OCC2UKhg20jo18wwT7CW3ryRh+iCeHduJbrwSr9dN1KIl
 HdH3jzJLXRqbUc9/xNgZqrOyx5YKI4x8+aKaRpgMuEGZ2xbyFNa2+ugWm9H+FNO2zJ+B
 zc1R+KaLOEry1Mi4W6OTB0WZPNwWDDocpRjSqWj7VvZk5P6rUVubcRkiVWsiTo9ZstQ1
 lnpBl9Rc/r0RXtWUZfRXSV6DqSC8oSNvojLEJ1AJR7RxNUdMoYkCIHByK/SDc/1yrUj/
 VfmteAcf44yySVDuo03fGCk5bPPjxRbdg6oXs9WAl9emjjRicfmsGdZQAXBmIl9sNT24
 PgOw==
X-Gm-Message-State: AFq9FYLJ3hh3e+v4dfeoK11tMuSO2XiSA/7Sd4jmMP+Dis9d3AeDQ0B+
 6lOtz4AgH1H3gJeIrIhiSrlWlCTgtnjMiXpU0u9n67q9ezgi46vKb+hihUU+qiJO
X-Gm-Gg: AYBFou0QWTHe/epQaPkkfzw1KFLDBc3joxiChAHwZba0moOFhnUag0HkMTjbH9xAqVR
 tMQCAYe5ca3MGvlOAR9jPMw4TuBYAhdSqMWHxqaz4JwW9x0BY4KqVoh9R6Mw9tUOlvF2CgrE42c
 aUy+N7woZNYkuk3nqT3tew9KHOXxmR/YJHafReQsbQmZsHCPWkxTP5sUuaKj07M+WKse0hORs+9
 7bAQONIbZRWTiR5hgDDDCpvxVeLYto1+JNTyPTs9Zp+cBAklRkeel0tprNrvp25rs/9ref2l7n6
 ryfjlMEq4KfSyF+TLeiJIex9Ek9JPVnKAU+lyCZmIlWmTwZJtdvi7iLdtxlcz5FiNNbiqVm1J/E
 c0u0aevHc3XAsiXffuRT5ZGftMkk+hNEjxxYTYfhPMw5skXGVOeKA3jLCzXN7Uoi51Z5bHxCRvu
 SrGHcJZNHHw8CbXYM0qI8z3y5tFkudgTyVDrsBW2RQZb1VI5Mm//LCvCHiO75y+b59xE1IUnLBr
 0uqRKG8Ymjg+3QSgxQ5j29IvJs=
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a18e4d8bbamr308500875e9.27.1792029570113; 
 Wed, 14 Oct 2026 18:59:30 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4f34sm15901010f8f.28.2026.10.14.18.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 18:59:29 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Thu, 15 Oct 2026 03:58:25 +0200
Subject: [PATCH v2 2/2] io: report a warning when a file channel is created
 from a stdio fd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-fix-stdio-close-v2-2-0f01e6580e24@gmail.com>
References: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
In-Reply-To: <20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792029564; l=1045;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=VLJXStDZV7IrZEpabPG5MYtk+x/LemCkbj7PCvn/55Y=;
 b=4RfG7Cp21bzAeV0Yz4md/DsqZc4ag5DVLLkzRFC1gEO3mTxqhqvkqEL/xJi7gX1qrtaaN5A6I
 TQLa3hPGdZpAQg+CUUIocxwO58JZ4wBh1FUwRmFdzZgVGA034fqwfvN
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A channel closes its fd when the last reference to it is dropped.
Closing stdio fds is typically unwanted, so warn when they are passed to
qio_channel_file_new_fd().

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 io/channel-file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index 5cef75a67c..4c9da6619b 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -23,6 +23,7 @@
 #include "io/channel-util.h"
 #include "io/channel-watch.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "trace.h"
@@ -32,6 +33,11 @@ qio_channel_file_new_fd(int fd)
 {
     QIOChannelFile *ioc;
 
+    if (fd <= STDERR_FILENO) {
+        warn_report("potential bug: creating a channel from stdio fd %d; "
+                    "the fd will be closed when the channel is destroyed", fd);
+    }
+
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
     ioc->fd = fd;

-- 
2.56.0


