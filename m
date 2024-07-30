Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46864C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 12:41:06 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYlwb-0007ur-Ap; Tue, 30 Jul 2024 08:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYlwE-0007tM-7k
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:26:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYlvd-0004kB-O4
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:26:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3684c05f7afso512264f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722342286; x=1722947086;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZadAk3fRT0RL0HiFb35pVw+CCBNLGILEP7kV4cE7OA=;
 b=PTgFDjdCXvm9+SAgyfgSV6fJI+4ZSNLDyK8/Wgsnu9FWYcPBf54IieGku/47nm1txW
 /ythVRJq0dSkh0dt04/PgzpSaiCeJD+XPCzIsydmOgArQH6etg5YGmi6W6HQYrtp4nLe
 DimlM+h98WQHLNQN/7uyI0oDFRygTSGxlN5QzwcWfKX0JOieXLNk6b/M6YfsxJGTqSoL
 YEpEj460nywJpkChcKoy+KDSZELoz+kuI9bIZmmFEbAsiPUgLxBHc207C8wyPHVNFtVv
 cZLm8R445h/ZN0pzGH3t4PTD4Xc+uICG89KH0mXXXDFlQGvCeozEay1OzgaB5+GZH6I9
 G55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722342286; x=1722947086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZadAk3fRT0RL0HiFb35pVw+CCBNLGILEP7kV4cE7OA=;
 b=nAYYn9xH7tgv2xfid/x5gIruUJksJsxvTeQ6WnXPzZLgUTwraJCclyd00Rdss/WRg5
 eg0J+6VAEUAnA64Z00SPg8XGvAIoYnobP+aeCE7B5KjQh6yl1+5bi//cVV1xGmU5IvOq
 X2xhCFrtgORIITfC6w0Ec02mZiZy7Se+eknCbKyXx2YdpXJjmZgs6nAf57yLZ+qq1/1L
 MS9uWUw42fEEG0/chkqKd/dmp//tCLEZJ6oRN4wWiM7cT7UAtTvTzk9uO/KzSQQ2hKUu
 S5u6K+cp7bc5FsFD+UNDnMo7K29O+c8BoobxKuSfiYSvxC5GQ9s5vaQS6qpVOSa22xiH
 lkJg==
X-Gm-Message-State: AOJu0YxWwL4yDFKcLO8O8nTNa/2CSIBovOW7k9nvQfravK1jVQ9fvEKV
 F3yUJ45eJ318bE3m0Rf2SGvCktNpKQBu+iZPra/XW1e6TOr+Z2W6Z/r9L5FvA/2zdMew9Aa/by7
 DRL0=
X-Google-Smtp-Source: AGHT+IFkn9lZxu6El/M+4N1dNXSCVOgkw+7QGXdLiqhLVF8fsQoSVj1CBAL9j5bEoE7vA0JjE0bDog==
X-Received: by 2002:a05:600c:3b87:b0:426:668f:5ed7 with SMTP id
 5b1f17b1804b1-42805700160mr75947875e9.2.1722342286030; 
 Tue, 30 Jul 2024 05:24:46 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14577757f8f.106.2024.07.30.05.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 05:24:45 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 5/5] net/tap: Use qemu_close_all_open_fd()
Date: Tue, 30 Jul 2024 14:24:28 +0200
Message-ID: <20240730122437.1749603-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730122437.1749603-1-cleger@rivosinc.com>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Instead of using a slow implementation to close all open fd after
forking, use qemu_close_all_open_fd().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 net/tap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7b2d5d5703..3f90022c0b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -387,13 +387,20 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
 static void close_all_fds_after_fork(int excluded_fd)
 {
-    int open_max = sysconf(_SC_OPEN_MAX), i;
+    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
+                           excluded_fd};
+    unsigned int nskip = ARRAY_SIZE(skip_fd);
 
-    for (i = 3; i < open_max; i++) {
-        if (i != excluded_fd) {
-            close(i);
-        }
+    /*
+     * skip_fd must be an ordered array of distinct fds, exclude
+     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
+     * range
+     */
+    if (excluded_fd <= STDERR_FILENO) {
+        nskip--;
     }
+
+    qemu_close_all_open_fd(skip_fd, nskip);
 }
 
 static void launch_script(const char *setup_script, const char *ifname,
-- 
2.45.2


