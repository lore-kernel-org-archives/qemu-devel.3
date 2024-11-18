Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D9BD49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD19f-0002xl-Sj; Mon, 18 Nov 2024 07:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19a-0002wr-Mq
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:46:55 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19Z-0005N2-7P
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:46:54 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38241435528so937771f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934011; x=1732538811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T83eivt/vSoGlflCpjNelp/9rr9ILqKefhCT6i7Xuwg=;
 b=ZDe7FS/m7dVGLzDVi9InQBFshmcSamru3ErZviG0TX+0DWPpJxvu9MCHPq4+OcZm65
 mBsZKm9T/5I1j0/9f9HKC+blNbWX4QfJa0dD3cLuts6l70PTtV2rurEZ7I8uyKws/QCm
 qTp4Gt+yCV3GOia42C//U6eqE5tDdnb8UxqOcdxBCt2mOcKhOSjcXI2OFzx4NNEotrK8
 iwFdQ6U3u45MdB3LxnL7balTUy/gw5jgnE288uJHipy0iQpV+02pxxl517MNPblg+X8h
 yCtkQNEpxosrlk11CcC9f3Fdo2t5VmK5PVAlaGNzytfkW3KBzAReUZ1QZreyUBaonQ9w
 l4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934011; x=1732538811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T83eivt/vSoGlflCpjNelp/9rr9ILqKefhCT6i7Xuwg=;
 b=lziW4dptPTUtOiZVFXJtD3Hw0XTWGzqWW5imPIvKWmJrLVEMZiLD1vHzevFu/E3Iu2
 IBs1OZClP+r6XvoAlAX7InxQcR9rB1yCATYcc3e1T/O2QziKkmDMsBQB0KSYOyxDkGMc
 aBiev/hjZoiDYJaHMfsNgLI4w7fcny3mwiVlIdHGPJ9s+b4yzAcFdRWmSHTmGVr21bYi
 F4JGAI5xnQvYX3WQhO8vjs2vwrcOv5J65wCRxWAWf/tlSRml9AqJVD47d/DaWI0U9ehJ
 9UMpo+iUurckgwlk3xBsLV3p0YsixRPLH3bP7nRxJrXNdk6rLTLIZDOWkrQL5k6KzNUx
 hJHg==
X-Gm-Message-State: AOJu0YyMrI2cO23Wix3XE6gAXKX5m3ekJVIW/Xf6bkwDGP8vMTbm5/e1
 f7P2q3ZI3GuQqQKefxGJ8JA+AkfSdXNrrF+l84P7IEb7eZF9qF9/0f7wtqIDGTCiNMgfllk8mbC
 m
X-Google-Smtp-Source: AGHT+IEm84lNylibTJlCyQB8g1q4Y2jIYuREQNmC4L9EW4l3v/2lIyiLpTrL01g6xiV5R056sQxmRw==
X-Received: by 2002:a05:6000:782:b0:381:f595:fd0a with SMTP id
 ffacd0b85a97d-38225907a2amr9456944f8f.16.1731934011413; 
 Mon, 18 Nov 2024 04:46:51 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da298760sm157802675e9.37.2024.11.18.04.46.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:46:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/15] vl: fix qemu_validate_options() indention
Date: Mon, 18 Nov 2024 13:46:28 +0100
Message-ID: <20241118124643.6958-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240905141211.1253307-2-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index d217b3d64d..3bb8f2db9a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2427,15 +2427,15 @@ static void qemu_validate_options(const QDict *machine_opts)
     const char *kernel_cmdline = qdict_get_try_str(machine_opts, "append");
 
     if (kernel_filename == NULL) {
-         if (kernel_cmdline != NULL) {
-              error_report("-append only allowed with -kernel option");
-              exit(1);
-          }
+        if (kernel_cmdline != NULL) {
+            error_report("-append only allowed with -kernel option");
+            exit(1);
+        }
 
-          if (initrd_filename != NULL) {
-              error_report("-initrd only allowed with -kernel option");
-              exit(1);
-          }
+        if (initrd_filename != NULL) {
+            error_report("-initrd only allowed with -kernel option");
+            exit(1);
+        }
     }
 
     if (loadvm && incoming) {
-- 
2.45.2


