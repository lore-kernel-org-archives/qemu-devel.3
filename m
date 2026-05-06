Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C4CD3445
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvr-0004DN-4E; Wed, 06 May 2026 10:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvh-0003vq-1q
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvf-0002AL-97
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:48 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so2797524f8f.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076525; x=1778681325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2YScFuD/G2yULe3kqslcvrkPGjbEWx3inHxGy7MRNZQ=;
 b=A26Od+oTsMSf3PpO0ePppc8jQkXtfep/sHZIdZBLPCq+JxRa2HzC1f3Z+uJaaNHf1W
 +w8pKz5QzIRlLeQhXLO7DqAyHLqvnCjR5dFcY5SUhaajUhfY0SCglTJIm1LM4sAGpzLQ
 YnfbqhANSnT0W8zQEzA2JsIKunjDKTPcrLZKPOcXwlxzSb7gnI2Pf6LiObmOmqUS3bTY
 ZMdnQNnIjqePQ/Dud+IM8e4v2tR0O6TO1MOktNbNs9+SqjHwQku0v5p9F2X9auN9itin
 IfB5+RAxas0zc3Ik2kU9LSDn1OxaTRAWys4cYxDuLIyHu3pPnfxP1NWm8mqLLh4SV4MG
 zUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076525; x=1778681325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2YScFuD/G2yULe3kqslcvrkPGjbEWx3inHxGy7MRNZQ=;
 b=MPPaZs7Cl3/bhuSBdiqpc4ELXbcgq9+KZp6F9jP18yb5VzI3JiKJMB63I2u6D3dpGS
 zCHGtED/9kxuj6B/StieG1a6XzrhPK83flmXsf6IlkDTWYa4zW8jOuimWr0IsO+F7z/U
 NholaGPtTFufWTh+jDwAHcwQ0PzBsC2WUgdal19sr1yyAk+/iwJw6ZWfJ8MmUVD0NMRR
 a5xqaGIAFaKh1fKDSro465+Z+VRSg+7/QyjIKb9YomWllVRpeZhV0fbJhw0Tdk4+Hr/+
 6lchDL/7UPez4KDdmYxJEG411lZr6dEdDoTzrnm87vepcQszLl5gfjg80IMaw9mcz0fP
 zH8w==
X-Gm-Message-State: AOJu0Yx7EGS0mibAVVNLTmS4PPT+NljLrP06oDSAFmYJ3pIiaeH/iLrl
 EXtOeH2uCvYUpIFwX6jOy+AppdV49YriDus67vA513PMRgQMnsGcjBrept9K8BrO8CW960R6g9f
 V4IjcqUQ=
X-Gm-Gg: AeBDievy0ZrgNvhqnqDB7SVtoECZ6CoAZ+iihJRve++bjJ/dO3XjciyaeCpqPSKJtPZ
 r9yH65XV5C34PE68d0Uap6twgjiSJZfoa7IvdWf0//j3FQodYu9g5fnb89oobK9BM2lbK7fx9zb
 HY6NST50n4qU08wHrgFTMh3cEtZMRy2r3yNHrMU7PceLtsdYtmEn4qQEEBtjhieQCWjDVikQmvI
 qX4UuazHa6x2xkY5onH114Ko5q6WNEddaFlPbkghaQBrOZIqnsRDtINS4Uf6y92QgCyUN1v7AQB
 8AjDCEhXJSRDrp3yEEHfamiznF23xxG+7FGlZ7HgsQJK+YmZkRFS7S9YwA/SVFVAw5fCPQWb6ll
 2IhGDlpYeADR5Ae79wGYi42+dWEJjXgQtzUAAGWMY3pMzb7UCigoqc9j92/HQ1zt666Dr26QJdY
 XCm32i5agIQ3i+xF4dvymrVUKD0nwxxhFoZprB/xKiB9EB1+clN3Vyf8PbVQSTOUigxqu0UBBod
 xSFFr3Vfn0=
X-Received: by 2002:a05:600c:4512:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-48e51f539b0mr60021525e9.7.1778076524626; 
 Wed, 06 May 2026 07:08:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505285e765sm12365586f8f.10.2026.05.06.07.08.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 101/110] io: Clear dangling GLib event source tag
Date: Wed,  6 May 2026 15:55:13 +0200
Message-ID: <20260506135524.20617-102-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Following commit 34aad589019 ("hw/char/virtio-console: clear
dangling GLib event source tag"), prevent stale tags from
being reused by clearing dangling GLib event source tag during
the cleanup phase (finalize, unrealize).

Inspired-by: Matthew Penney <matt@matthewpenney.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Matthew Penney <matt@matthewpenney.net>
Message-Id: <20260408100605.66795-2-philmd@linaro.org>
---
 hw/usb/redirect.c                     | 4 +---
 io/channel-websock.c                  | 8 ++------
 target/i386/kvm/tdx-quote-generator.c | 5 +----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index fda5bbca676..100afbdb06a 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1494,9 +1494,7 @@ static void usbredir_unrealize(USBDevice *udev)
     if (dev->parser) {
         usbredirparser_destroy(dev->parser);
     }
-    if (dev->watch) {
-        g_source_remove(dev->watch);
-    }
+    g_clear_handle_id(&dev->watch, g_source_remove);
 
     free(dev->filter_rules);
     qemu_del_vm_change_state_handler(dev->vmstate);
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 85b22a8822a..617d79c351a 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -950,12 +950,8 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
-    if (ioc->hs_io_tag) {
-        g_source_remove(ioc->hs_io_tag);
-    }
-    if (ioc->io_tag) {
-        g_source_remove(ioc->io_tag);
-    }
+    g_clear_handle_id(&ioc->hs_io_tag, g_source_remove);
+    g_clear_handle_id(&ioc->io_tag, g_source_remove);
     error_free(ioc->io_err);
     object_unref(OBJECT(ioc->master));
 }
diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-quote-generator.c
index dee8334b27a..002bc40c8a8 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -74,10 +74,7 @@ static void encode_header(char *buf, size_t len, uint32_t size) {
 static void tdx_generate_quote_cleanup(TdxGenerateQuoteTask *task)
 {
     timer_del(&task->timer);
-
-    if (task->watch) {
-        g_source_remove(task->watch);
-    }
+    g_clear_handle_id(&task->watch, g_source_remove);
     qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
     object_unref(OBJECT(task->sioc));
 
-- 
2.53.0


