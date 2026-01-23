Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428C7D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIns-0007XZ-96; Fri, 23 Jan 2026 10:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInR-00077k-3X
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:09 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInO-000364-CF
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:00 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso17973475e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180997; x=1769785797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h9XoevUjmVvgSA/1RTS8XxR8NPila3khvNmpvFgd9i8=;
 b=bGuH4Qe1PiYunZkwZO5pjYoaE0Uot1/xZc/TmcFAtGnNZpDfb9hVdLusV756RO/VXX
 WXoupXJfXWzFmrH8uxGp7l9AQ2M3/iH3Ie1pO+/JvdRso0RHpHeLAYly9x18SzBD4NcI
 7TBFEIT1y/wy6P4v0JBhk1oyJBaN2zsJzKoQWnl9hMZLFTAzhjcqN0T9rJmhZtVLjTMS
 /dHnqMeJBoae7IQC5YqAOkIQcF2d2TN04FI0tuHdZzm7QHAiQv2DCyz0EuuB9jzEz37c
 ZjTHmMa9i67bSU1JchwJl19MKSkG57i1Craa0loLIy/wi55brY9lOap3Rsx0b5HqSemk
 7V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180997; x=1769785797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h9XoevUjmVvgSA/1RTS8XxR8NPila3khvNmpvFgd9i8=;
 b=U1M8W2NsabFR1MjGSvXfx+7KUCxmZaFBe2n7ssWlhbgnYxi0UY2MO6l4hDfWn8A5U6
 8JIoNfHAZ6J97C5oxJ02/LLu6Akxqzw31Q5jcsaiGyyJ1YD27MUTPVaQdOi5fnoHYKAe
 9P/S9TLWPpbC252cG9WBgD2Zk3/0SfDxBfhFYuC9CyVsqwCFPSim9DBhQPocuYvvE9PF
 WcHmxAf119dlpv4b0VKZolwjIu3mNQK7qIYmlVXFWnICAtQQiOC+Kvgz3G7pIsvuI6qF
 yERyGanxDj7bjCg4svRRTG7N3aSYMZcpeW3XRkIlJDYgfm04LRUuXgCessSyesLclCtY
 HP4Q==
X-Gm-Message-State: AOJu0YwkzVGYxSO2bs8fAGLIzAX5Re8+lo/P4djlG2lJ1XHu8vlmwWmg
 AvozMJ4f9sFBFHdpPnV1jUDponTzfxy0PoxibWQ46At4mhbkkm3Awxh5HygDjqoCHX8gJUwN8Oa
 Lknnd8SA=
X-Gm-Gg: AZuq6aI0/PpVPnCHYq3kKIt1y7Q0zfJOuW8rUCUZ3bbyPqh7ggyXezI6QR/kY6XJyj/
 BsUGtSYJDh3VvXFXg5xsebb0hsGp/ENN/Dth+g8P6N0Ft7yieYXDNbcGe49IpBjSpJChJuJ5ec6
 q9EUZnLLflnqu06291/LfcbJ4rGwppwCllgmAvKv2lrztgrXFfP/QxqvWwtejuKttPyyKKHTtWn
 YxBxtUbkx0whp59Vkp9BqVX0dh025XNEhDJD+HFawvHPQd5JxzNDzyWUZHb+fvySnzewq61vNDN
 RUgpSui+u+UV/WgNro0n12esHdgxXwXq4HOjc+rIGGk9ZvslCVtBy2505TybE3DrtJKQCNjN/dE
 AO2rCSXGaYNTHlsPyPXOfQr8xZwW0eFG4f7i9KoXf2wuKPNClej3Y6F3KXO4/kndtYkTgpXKIW8
 uQeZHnhK981NqwmS4WP6GytcKU9fSm+SBDzc7egx+7mlz6I+u5+GDK
X-Received: by 2002:a05:600c:8b6d:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-4804c95caa1mr61219255e9.15.1769180996657; 
 Fri, 23 Jan 2026 07:09:56 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/22] hw/intc: declare NVIC regions as little endian
Date: Fri, 23 Jan 2026 15:09:33 +0000
Message-ID: <20260123150941.1877768-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The NVIC should always be a little-endian device as big-endian
behaviour is a function of the current CPU configuration not the
system as a whole. Indeed the Armv8-M architecture reference manual
declares:

  All accesses to the Private Peripheral Bus (PPB) are always
  little-endian, which means that the PE assumes a little-endian
  arrangement of the PPB registers.

This should have no functional effect as the NVIC cannot be
instantiated on a BE system but will help the single binary efforts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260121105932.135676-2-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 3a31eb56f3..28b34e9944 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2467,7 +2467,7 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps nvic_sysreg_ops = {
     .read_with_attrs = nvic_sysreg_read,
     .write_with_attrs = nvic_sysreg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static int nvic_post_load(void *opaque, int version_id)
-- 
2.47.3


