Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D50C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJq-00025u-MI; Wed, 19 Feb 2025 16:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJi-00021f-VV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJh-00007O-7A
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:14 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso1672195e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999351; x=1740604151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhwkxvyKpTQZAt9mirHnFUfpe4JfORLzfwmDQNOghTo=;
 b=UKbdE6q47vKyzx8BxWVf2/iEOXagu9xtHPhXkyT3a5o/87nMVkTbKXDdjHcYcLS0T8
 rgfT5aRd1PTaw5q6xS/csfWIJvZmo++9zsvM+nQ6PrpCxI4UiMIGczr3x6bvQEXx/u3T
 02cQqQwW7XpZyuBD7bGlNxfgEKiy7aMq7ITfHVtiEqL2fZnqDdgb1yVxc+FXsr/cdCe5
 7pO9nuSvYKzbawcrXUApdxr+owcUwe1dnbc3jV6YTGJRaO8hvFusnIPV0slBo5tKP+So
 cB7El1n/POo7rVW9LsjswKN/xrX8sI17W0kFs22xl9OBrW7NfXLQM1i0CS1KK9vJ1ow+
 H8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999351; x=1740604151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhwkxvyKpTQZAt9mirHnFUfpe4JfORLzfwmDQNOghTo=;
 b=DDkNfZPXJgG7OR3YjN5+X75ShuJPXrRB3oFNoWfbZjp/X4zcg09ffug5jIxKAWg2lp
 2mDfCx2P/CxOEUaKsbA873k4ejs4bML784jPRkdHI8M0pslZh/0lSzpaeGTzHqAkR77n
 +qhPZ5Iw7qJ1rU2i6Ta9GjGjHqtulDrNPKoPTrw0ragCoX27Q0a/wKZD9MCvxj3Ve4J6
 +Fymrxv3b2lUSqJCIH2mzmbJFamUcSW4jnyd4nbm943OEWBQebD6QdZv5SYFdhqyU/l+
 Akeify96nQ7VR7wJ3r1HhLcQN5DTZX57rY6UT4QXRNp8BtJr032lT/cvF9o+fkuLG6MP
 xX/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU1s9N2wKPoZY7V79hWvpZUiYpCcbsHawF97imkFo11y/z2njhPwD0+msYgnr5IZw+VMplH1Ih2J+W@nongnu.org
X-Gm-Message-State: AOJu0YzGZ7Bxzui/ohrmYhgU3qYn2l0uInToFdTyVhYHfNKbkV1hKK3U
 OawPKScqEZaDcA/O0fhosjXCC05pire+ch5TfcMx9/PYn+qsxaXLnzUGofMLlkg=
X-Gm-Gg: ASbGnct2W2QzSWJyct8ybNZx45K2qdFSBy7cbOE0Q/iQKQV0NqAmpIStKeiNl5lXwdT
 ugct6ZBL/iSs6MazFilB7Qj3DpOczuj4j/2qOf9ld1ik+aciruuyN9XV2EcSEyOJ/2sY7hzmAsZ
 R/LQH7ys4QrRZlhNscMmhhdu50zcUFbN9pn0ejy7ZZvpVQqDHhuGHXVBiDCZpgqoFUpvLuCRH2d
 Rk8TdWmsM6f2IvifCCg7miJaYn6GcNZTCbGe84tvR4H24l5xhM7hdSf3/AnbikIJp5prsh069o4
 AIf5nBFMbH+iuDzVbby/QNTlJO2nF1b7uDYHj1fYg2qYPc7zBKO0M0pBIy0L40nubw==
X-Google-Smtp-Source: AGHT+IEI16QFgqjS4YLiNsbF7FC5EAyrAmAmr5Kq4LgCYvD6TfwsSDQwGj/4TwXMSh/XFWbKXqJFiQ==
X-Received: by 2002:a05:600c:4e8d:b0:439:892c:dfd0 with SMTP id
 5b1f17b1804b1-439a30e91femr5924815e9.14.1739999351505; 
 Wed, 19 Feb 2025 13:09:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43986320899sm93060315e9.38.2025.02.19.13.09.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:09:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 5/9] hw/char/bcm2835_aux: Really use RX FIFO depth
Date: Wed, 19 Feb 2025 22:08:37 +0100
Message-ID: <20250219210841.94797-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
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

While we model a 8-elements RX FIFO since the PL011 model was
introduced in commit 97398d900ca ("bcm2835_aux: add emulation
of BCM2835 AUX block") we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/bcm2835_aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 73ad5934067..c6e7eccf7dd 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -221,7 +221,7 @@ static int bcm2835_aux_can_receive(void *opaque)
 {
     BCM2835AuxState *s = opaque;
 
-    return s->read_count < BCM2835_AUX_RX_FIFO_LEN;
+    return BCM2835_AUX_RX_FIFO_LEN - s->read_count;
 }
 
 static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
@@ -243,7 +243,9 @@ static void bcm2835_aux_put_fifo(void *opaque, uint8_t value)
 
 static void bcm2835_aux_receive(void *opaque, const uint8_t *buf, int size)
 {
-    bcm2835_aux_put_fifo(opaque, *buf);
+    for (int i = 0; i < size; i++) {
+        bcm2835_aux_put_fifo(opaque, buf[i]);
+    }
 }
 
 static const MemoryRegionOps bcm2835_aux_ops = {
-- 
2.47.1


