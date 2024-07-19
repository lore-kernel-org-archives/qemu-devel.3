Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EEFC3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpLe-0006px-91; Fri, 19 Jul 2024 11:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLc-0006lM-9e
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLa-0005vG-NA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266fcb311cso13872325e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721402197; x=1722006997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x85t1oRdkXPj1jKJlZTxTgRAxr541dTWHBTkbfm0IzE=;
 b=JMU6qQBjtX1bJDbNDxBDtxT95y2760ZkAE5G1JQQ71gS331uJroiWIGrVarorZL6AC
 hN5KKHzQq3HtwIcnzlcO5oRb7Ek5ZerxVVlRr4MNuP+Yx4WEtvTq90pYijcfkp9prcte
 RXPn26zNhiV64wI8gjJ8nRI64lp1VQNiG1IZiJDvoEIKIjxlL73B+FEJzzFmJwwMVcsL
 JaS30co2TSVgqXHoAZIA+C3n5+jvQ0rQ1E6fSXL0FVKB1wFM3NZfHsMgQmAT0SeWTULI
 QiJk0q+ixhQaFoV7p3EAZMUEzsMSCXdan6i7aWbVleCbAlOC4JM3hFDmx5d02UTFfCxf
 mrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721402197; x=1722006997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x85t1oRdkXPj1jKJlZTxTgRAxr541dTWHBTkbfm0IzE=;
 b=ImJs9ImN0Eex90MqTT7bVljoVjDwiCcsTFaJgTUs616WjDA0hADcY4KdkczHPjR324
 Dfe+3dxvqnsoIq4oPmGmhc5alvP1ql2q0S4YzJqi+xNmftVU7eKwVjoDgmfK0Harl8bS
 ZaSYNS4KnFeqwrQzu0D3VjEeI0Pxt3w4wsihG9/tTfP/qUgA4z4+HezFbFyN0nTPmnXy
 7fIWxm9HSm50EqDlrTzO6a8gXcXvmHZXvV/wT9WbO+Aq7eINJbs+K4wob1N/vdFf4Sd4
 OorEtMqqvFeLqYHCSj47hHRvG6HNJMM4R3bhAVo4UHT9jJatNdtDLwIeNg2ILzvkg/iC
 tevw==
X-Gm-Message-State: AOJu0YyN5r//M4n4QR+YPsZqpb+eLTnRvUgqY3Zn7cX/b5u3dEUt6TgG
 3bx3MVbwcpDi5Gp4fIMWA6p0vaKAl9DM3ZHmTJ35JcHq9C+b+qHVe9SK8igAccpIcM0+dWtWzkP
 v
X-Google-Smtp-Source: AGHT+IHbK9hmdDf8RGHcAP63tiXMoRkoYAndVMLXnvWKHZlFEVwvxfKDsURUnfo2CiMyjASJAnu9Rw==
X-Received: by 2002:adf:ed43:0:b0:368:4def:921f with SMTP id
 ffacd0b85a97d-3684def929emr3705972f8f.11.1721402196934; 
 Fri, 19 Jul 2024 08:16:36 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368786848basm1873766f8f.15.2024.07.19.08.16.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 08:16:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] chardev/char-fe: Document returned value on error
Date: Fri, 19 Jul 2024 17:16:26 +0200
Message-ID: <20240719151628.46253-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719151628.46253-1-philmd@linaro.org>
References: <20240719151628.46253-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

qemu_chr_fe_add_watch() and qemu_chr_fe_write[_all]()
return -1 on error. Mention it in the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char-fe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index ecef182835..3310449eaf 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -228,6 +228,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
  * is thread-safe.
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
 
@@ -242,6 +243,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
  * attempted to be written.  This function is thread-safe.
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
 
@@ -253,6 +255,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
  * Read data to a buffer from the back end.
  *
  * Returns: the number of bytes read (0 if no associated Chardev)
+ *          or -1 on error.
  */
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
 
-- 
2.41.0


