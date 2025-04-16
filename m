Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0C4C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xzN-0005D5-1V; Wed, 16 Apr 2025 04:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwo-00021l-OC; Wed, 16 Apr 2025 04:16:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwm-0005ti-5Q; Wed, 16 Apr 2025 04:16:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-739be717eddso5044949b3a.2; 
 Wed, 16 Apr 2025 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791396; x=1745396196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXW9TkBOCeygIoZUCLTmx3/WoYw9rEQTC6TItKA27ak=;
 b=SY4YoePHygCuqB5g3LPZxmx2fWWx4u5GXGqiDogVJMNwWA4RB01q5VXsHEPjaNB4pg
 qUCDY7z0Q9WkgKVE7x/xGI8MwO1z5gsS8ICm5/5FBtfpsQyWzLd/hSsoiTzJWQjSMo6p
 fJIne28AhGW2YVMPFoZkYUHHZ8jDZoT3nFChgwBxlSO6sslKogrtsIOPpPjPwRBFfgae
 t/Zvwf/mCVxCPmb7EKy9TWBWJ1VaLh7kKTrtiS4+drymCTE/iLiZ2/4wo4pn0C2ByKLU
 66rZGeR0QA73AdbbZrQ99L0DVOUEYnm6oJVNCwpnqY0q0q7zchzFow5JKqp+4VAiJSnw
 0Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791396; x=1745396196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXW9TkBOCeygIoZUCLTmx3/WoYw9rEQTC6TItKA27ak=;
 b=aod21WUJNsPBV37K4rU0xZWlYcRB3WRBqbboAE2R5KLwULX6mxdWRG60ZhLQWCBzdf
 0XfUOwny2lZpzZ5ogpsi+D9iBfgKVzfcGua0vlSwSDsi05z9yuV2XUILZ9evF4OrwFYs
 wQPcul8DIDzbjfpmHfpqUqFo3HVreBqwP0HEKaXmgK0MkLjs08WxgFgrqLCz1Pi67hTP
 qcqk7Yc0Gp5Aa0jR1FTDwTfGoNRvFO982RFMSSrf4wub3y6AbfUVI696y3svAvSyUmol
 xbPhb9dExHohrhsPE3glfau+jeMaPvmKHnCY9ah1OuIEkRnIiV0qNjf1p8PNUZqBF+Nq
 YqqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqUPnSiChDEVgMK2yaZs5lCcnotHPeT5TmBtsBaV9aLqzLmHiuZFd1IS1S6kDilQYgDT1gTUFskVx5HQ==@nongnu.org,
 AJvYcCUtujKF8Mj82mhUkT2nTdeiAXm7PjjCat8jJcrFv73K1VqZ4s+6re62Yagl350141RJUHAlErbRBD4JKg==@nongnu.org,
 AJvYcCVNiqNJk3NK+W/ifpPT5dCNGwfDcwgZDspAgNEwjH1S4kc45VYUlNQ/qHItJ8ufyCwMud4/iftm7SA=@nongnu.org,
 AJvYcCVpJ99hmQfpjCrO/h3o+ewb0KBeK1BbEXURdvyZU7foU9W4gTPYscrsLNxQk1jt19GxJKBFbRLvTw==@nongnu.org
X-Gm-Message-State: AOJu0YynJPqySq/LjjI+PxKwQY/gnFLyoHlbWUa3uS46aLAGF3WCLK0z
 W/vQE3fSkUcyHPg7CH4JMoW/ymtMe8f/rlNN2bGz4G20ZpwyEJZht0cOmgyY
X-Gm-Gg: ASbGncuI6/0JcMKHZI2PHNJZ8NCnqzjYBlZ+giSDhoOGIWZWS+7QQoMjNMChQsTjlBc
 aSFU2wLrvoTuQFLi98n8RxgXYYFL02dj5zG0EAXZUTaM5q/lzZwFh4ffGINazPmhNrMNMwZi96y
 AgJS2EvVFXvT7k1eFIFjsJHySZPQVwf1XgQj6ntIX6eEPvKtb4oL9ijssMO5nq40yATLod1//6D
 qKFfZc+owgxi3hGNQot+Hbvf4PY0jzi1tXzk4EbNdFF1XGTQnSVhGz34jmgmxhMeIOA6TSsheaE
 Y6Ilm4UijNBM0g+Qo7mZaChP7549a6Fwqvnj5GbwDzTPZrVotdoAq5tRww==
X-Google-Smtp-Source: AGHT+IFot2Prutev9vQh238P3Y8Qu6FWMP21RaEkJWIAAcrPZLBNFGYxFnfgXEoks8g52jfCfyjKGg==
X-Received: by 2002:a05:6a00:ac2:b0:736:3be3:3d77 with SMTP id
 d2e1a72fcca58-73c267c9faemr1430041b3a.16.1744791395895; 
 Wed, 16 Apr 2025 01:16:35 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:35 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 12/19] block: Update block to compile with Emscripten
Date: Wed, 16 Apr 2025 17:14:17 +0900
Message-Id: <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
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

emscripten exposes copy_file_range declaration but doesn't provide the
implementation in the final link. Define the emscripten-specific stub
function to avoid type conflict with the emscripten's header.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 block/file-posix.c |  6 ++++++
 stubs/emscripten.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 stubs/emscripten.c

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..22e0ed5069 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -110,6 +110,10 @@
 #include <sys/diskslice.h>
 #endif
 
+#ifdef EMSCRIPTEN
+#include <sys/ioctl.h>
+#endif
+
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
@@ -2010,6 +2014,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
     return handle_aiocb_write_zeroes(aiocb);
 }
 
+#ifndef EMSCRIPTEN
 #ifndef HAVE_COPY_FILE_RANGE
 static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
                              off_t *out_off, size_t len, unsigned int flags)
@@ -2023,6 +2028,7 @@ static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
 #endif
 }
 #endif
+#endif
 
 /*
  * parse_zone - Fill a zone descriptor
diff --git a/stubs/emscripten.c b/stubs/emscripten.c
new file mode 100644
index 0000000000..2157d6349b
--- /dev/null
+++ b/stubs/emscripten.c
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+/*
+ * emscripten exposes copy_file_range declaration but doesn't provide the
+ * implementation in the final link. Define the stub here but avoid type
+ * conflict with the emscripten's header.
+ */
+ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                             off_t *out_off, size_t len, unsigned int flags)
+{
+    errno = ENOSYS;
+    return -1;
+}
-- 
2.25.1


