Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F288BFC9EF9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyqA0-0004zL-Ch; Sat, 07 Mar 2026 06:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyq9y-0004zB-5j
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:49:30 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyq9v-0000ee-TP
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:49:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso68951465e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772884165; x=1773488965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s6KpcxbIXeN+QMyvxZ1C1nsc9/84b21RhzyjzemLfV4=;
 b=tN4GCAL9jJwCO0APc/uNlnSEfwtEnCFdFxcCASI4xHh1n5UQlptgNTnmuGOXxRPXT+
 7lKiI7LLn4P9Pz0MZYFU714Kja8k7WkxDo1h0ftw3sM0qfRToJFeRxxngydb2T9WsdYh
 q4I4PAxQaz3tZNLg0Qk65TBt6bNVN1BhG96Xc0jGMTn1SDFPZDnp1G4gn5M0eO418SsZ
 qfOzx8h2egQNjfyF6gYR9QCuv+BD5xY6NYohVxwv7iDRNzGa6Ed6SiTXZsx1/oiKMYdq
 FpY0V1fA2gjbOfR+kU6PM7xNOPfKTYSWEhDqim9CqLp5IZgEyH49m5Bi0/Hmk17qmoXh
 8QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772884165; x=1773488965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6KpcxbIXeN+QMyvxZ1C1nsc9/84b21RhzyjzemLfV4=;
 b=w+42P/5AMZZmTRxP9rEB0Fq3SZrG8ZMCExmB5rSzFUA8aQrIrLIg4GhhVjXZ14MGhy
 sbjRxkMLPWXpfbjN3kT4AXTjrVDpZiDyo1G2SQ8ajhsUowueAL+XUt73DU36Uo7QNm9l
 +e+iXAik0pSHYtOlU9iySGs5Fr97K1s7SJ/+wTTbZfq5wXWt1WLvGcTaAH832MF5To3T
 hgp7cKeMXJNx9ukWEac6fCHZD3HPQ5l+r+1Lvcrq9v6I4awcd8qkuQaqgmbkjWXk2xAR
 GpiDqTqTTraDelPs4vQaWf1tR/ZFi6gawnNBSlr8RNB8cWbdVolkkYDcTc1nNPsPbpLq
 A3GQ==
X-Gm-Message-State: AOJu0YwrNFx7PcfRrFpWIldAcHP1k3nJjBOc2nTiHKT3aS27y+Bbl7NM
 rvEkxroCwkYhgtLhLqpEPiVObxKMFx2UwaJQpDotTla/uqz8mPMFo/8EINmCV1Yum1kYfk/7bz6
 4WGJ5jlY=
X-Gm-Gg: ATEYQzw+0/zazgm8idZDDKs03asmwuGW/ma/+k43IwAt9jsuI+sh/5dcKp2XTEMnpva
 EKcFSQVc2UcqEVmrwpj8/Z4AzISWhhA/P7kjTpOCfICHSxktg0PkD6iR/m46LJYLbk2uzBm8yBW
 C+86IU5mPCQH7Gz7FG89O8QnBxMWi1QnjsqIzwAdrk/fVjCTr2mfq2r/QflrUxXN147oMXuBTb2
 hq7CZryGZSmJjvGKbkGYOrLbulFWF9lsM816VD8JUmqM/9Fe3hNrlyvyuNxHV2AogO0jqyokqB+
 EV5rFkoUQ3aqwcbwKxpM1QdoWI2vbDBmGIXfzwUJ6dpZ0iQaPnByBYKjBHznMZp2qbGPnsCjF+E
 tCOGVoGaB6xnYb9TpOddycyVsuGpwZyBd60M+nWjYDGmkfSVjITQ+LRqH6Agn9AZ8t+FQjYXMT6
 jUWaealr7m+yh2XV/Zf66Ev1vKH3WMXvL0l1tzLXxmEuipED4dm6fOf01bvDTAxHWbLve0t4je
X-Received: by 2002:a05:600c:1e88:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-48526759d12mr98347065e9.15.1772884165346; 
 Sat, 07 Mar 2026 03:49:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb3666asm164506655e9.14.2026.03.07.03.49.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 03:49:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] audio: Fix macOS JACK Audio Connection Kit
Date: Sat,  7 Mar 2026 12:49:23 +0100
Message-ID: <20260307114923.75394-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Since commit 8f68a33ad46 we get on macOS:

  Audio backends
    CoreAudio support               : YES
    PipeWire support                : NO
    JACK support                    : YES 1.9.22

  ../audio/jackaudio.c:654:12: error: unused function 'qjack_thread_creator' [-Werror,-Wunused-function]
    654 | static int qjack_thread_creator(jack_native_thread_t *thread,
        |            ^~~~~~~~~~~~~~~~~~~~

This is simply due to a missing #ifdef'ry change. Update
so we can use the new qemu_thread_set_name() exposed by
commit 46255cc2be9.

Fixes: 8f68a33ad46 ("audio: make jackaudio use qemu_thread_set_name")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/jackaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index be6fb378f72..589aecede9a 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -712,7 +712,7 @@ static const TypeInfo audio_types[] = {
 static void __attribute__((__constructor__)) audio_jack_init(void)
 {
     qemu_mutex_init(&qjack_shutdown_lock);
-#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
+#if !defined(WIN32)
     jack_set_thread_creator(qjack_thread_creator);
 #endif
     jack_set_error_function(qjack_error);
-- 
2.52.0


