Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0804EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMn4-0008P6-CL; Sun, 08 Mar 2026 18:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMn1-0007yb-A3
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmz-0003of-RR
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso5627075e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009595; x=1773614395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+6XuEcNraxH7BH41Yk9P7HZEnHj+sBykaCOA3JVPxYc=;
 b=i968ZE+b7WGRDEThnNOwDgvJMiztYuXKznp+jibHGtYUDPR2bPXcQTtfvztkn4D1ez
 jlDzv2GaB8J4bDzPpucDkT+XouTg/izjBFaOB+RkrgW4/H7EORwDxkFG8yDt7Q29K4M0
 8Cp98x5s++PuwqxhxK8+vkIN0YX2w7+pZkhMoWGc5jEVEfyJIZQrBMo4P/as0BBHm0Fe
 o/KmUwZBdDfa6/NeuoeouBDzJhD7TlIhk/9c5KWtT25GXjhGjIRetretXMF0v0GztvBA
 G73sE5kFwGa9jgvkuJAANRabm8o4fWoqQeHIMQ2HXcecWciCUXiz2mJqzZT4j8vZob7J
 czDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009595; x=1773614395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+6XuEcNraxH7BH41Yk9P7HZEnHj+sBykaCOA3JVPxYc=;
 b=gu5xgfGzB2u1fa4INfeiD3S5kssfTrJAiKprW1CianeUqtWAIyuuoP49cw8EiLtnr/
 ve8y4NmoXm9apOmOnnmSoEx+2kYIlUD9/C1q2UwzZiUessatWscS9+zp0KUWvvxU/0Y2
 KbSzx7IRyz8WkF+NI9er1Qaee0QCwq7mpz8v0QyUqHJ+WnyyLkBDYfZZKFfUjonLfGwA
 EaLaK423sjryx6q3MiwyFku25OfFWXNG9AhSmF8faKcazcz2enhw7svKQ4xiX3X18hFT
 aIvIzNUgW18uoGNK963tTALBnC1NyThCDXa/uBZ7M33SujUjPuDg903r4/i4PsOct/B/
 fQzw==
X-Gm-Message-State: AOJu0YywzwnicukdbMTPIINx7exsLPNMRBZ6nnbqjBvy/aiW9UWy9HF3
 3LNMjQNA70vqNxGpXxhef9aziehUw0cMKdP3CuirCIvURDiYpQDP4a+qwsggfihYOB8L2v+afuZ
 ZMxt57bc=
X-Gm-Gg: ATEYQzz+JO1MW9d+ockFJ2k+Sif5CvsomD6CROJMJNW4q3wQumSzgxifLL3tGxYUIDA
 0ADLXhA9Fh/02NtJe6jXJYDpzUC1p3c5JNmHdDivIEYl/3RhqvbMlE4ET1nnPDPgPScibL+AJf2
 0pPBGt4T+MeKJpKrDN01UaGWOz0rKQBY/srW0IgzR/NDIYKQpzxzaq7vGJPqKevYbOmM7HkhCdf
 cSuL/R0G8MTD8tOBQ6eGtKWREDgi9Xxmj0448KkFJGVOuGPtp6qtDiWXiB98qmqbfH6+NSmbAmt
 lFpUOp05uyffRrmBhGpf1aum5EFbERdqBJIA4OXR2HLMVSb8w321QrfuJe9ky4z27KZLnbWTinp
 KIH4xY5WukQbCjR3pZ6s9PtaNOyKQulE/umc2JzkGYGnfx8E9sfMMVikVaF35WGd/Pet3uGZMWB
 Emh27niKbhex0r1j+EjViGtLzHUQoW2r0vuTtqgSPKgKfeyu7sbQ/Yy6D/bnk6/H80RusOGbyju
 DMBI8RjRBD/smX+
X-Received: by 2002:a05:600c:8b2b:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-48526715213mr136501055e9.3.1773009595151; 
 Sun, 08 Mar 2026 15:39:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853438017bsm139026065e9.0.2026.03.08.15.39.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/49] audio/jack: Fix use of qemu_thread_set_name() on macOS
Date: Sun,  8 Mar 2026 23:34:31 +0100
Message-ID: <20260308223433.25503-48-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20260307114923.75394-1-philmd@linaro.org>
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
2.53.0


