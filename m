Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C82CCF9E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaRt-0000De-G7; Wed, 22 Oct 2025 11:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRs-0000CR-Hv
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRq-0001Ah-RY
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:24 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4285169c005so907341f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145701; x=1761750501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJZa9EWzfH63QR1kP5dXrAuFB9IIUaUXKXo7sPTXUC4=;
 b=NWnLXiqSmwIgoaMVDmsvX2cUIXA8VuieT3aFU3bzrOytXHGSDzQqp15N7gXZ18WckB
 xnwueyH6Zi96/PFvflIwQ9Tg7V1SqvPYNMDJFP5YOmr+ZfX9z5A9h3fQniViwobznxSD
 oCNEzAM0zXLVK8c4XuJ7sSKqqSjyf3Wc/tVpwz1YbayJUW4udNZ/Ik/AVr7EzdnLVb86
 ujVxg49r7aCGrKPe+QkfuHfmDUyCp0h2Ig09QiamJ5JHQmT7T/tfyIbm7eEhXN8xqOGv
 LhiDiYdG2zcym769WpskPDCTYJz2CNo0mKxkHFqXeZgIttuceZ0ftK61RD6d04Glqa0z
 4u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145701; x=1761750501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJZa9EWzfH63QR1kP5dXrAuFB9IIUaUXKXo7sPTXUC4=;
 b=Miz9ZmuftRsroDrbFgjehZyaHjhBVACvsm6+BxX5c4Js+5FXGvxfTFZOp//iEEvIrK
 TUgZTxbsRistDH/NDi4AaM/Bbf0IR9ti1emQ2KBq+PabztBwk1fU0gPYBmfz0V+WeQ/l
 21JUZ5WhbueU8SuUfUwS/rmJVhSRSqGkwFtVvBLQh/cExxk6pTttHssOElIBUpXZmRoh
 7gISX/oaaiAaM3YyL+0fjvdineiTciyo09Vl6cs5LcuGvO1XMwIksMCHyUkQLlbniZwK
 w0hQMzE07QnUHDNYwSeusFAQ6vizlEfcvYSi7EhqT0dZOnR4+0cXn9O67jxbK3OJWv0q
 5/Yw==
X-Gm-Message-State: AOJu0YyOrScVW8xh1DrS1zhmH2PiyZfQrOCKG0KcAd/CXIUhUF7XSZIC
 yv2g7KKsGioLl0GSxwS6n46KM9RgupbSX4dwXCqw8WNBJHXu3aICY0b+aM8wuriuqIHtgbwului
 fbLSRUD0=
X-Gm-Gg: ASbGncvVgmmXYTr69otbxU2gfSHlUBEXkK4asezknDV4DoC2HWgXu6Qmy5gz3VCFflN
 3qYHQKGQvplArQYZiCs5pZSphdD6I9Me32i69ziFOXO+5aUkVFcbobbM4zHh0rvStC/glrKggM2
 ywvdrJ28pTb7vVDfIUsWoy2MHmxPUV1h2IGS3szz+sOhQN0M9iV9peTRK7JcfkPDJfKl5CfA5SM
 LCKbxBnbtyLCvgNgAXPAIVSZ1tKuK6NrLYb9W52q/A+A3zzCncJvejKHu5P94yA5LiJjMh1M67g
 L/p5UwTk8ZXqeGlcC6hU6oyHSI05QpSGy3y4o1vcd8pBZ+VxjlnyUIbvV+oTkxq+niZR+fTdVm0
 Iya+w8cyJi9HKe1dqQqpW7SC6rU+xj9m4YeLIFej6kQ4A23+IIGD4bmVStL3hl6j2noi1NAK0lE
 ucDEtyHApOF5vWB+a8mYA4Bdnfl8d2ghwUBFHJWKqgrT9tyJRWCOcwxU4SDt4x
X-Google-Smtp-Source: AGHT+IHwFfkGqlAHitJKvyU4seZ3kaGaAKyYYFl6d2Nf1+tOxWYT9DEmuqnQSurAtYAySbE9TloWzA==
X-Received: by 2002:a5d:5f82:0:b0:425:8133:8a89 with SMTP id
 ffacd0b85a97d-42704d75729mr15308210f8f.22.1761145700879; 
 Wed, 22 Oct 2025 08:08:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce08asm25482189f8f.44.2025.10.22.08.08.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:08:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/9] chardev/char: Improve ChardevClass::chr_write()
 docstring
Date: Wed, 22 Oct 2025 17:07:37 +0200
Message-ID: <20251022150743.78183-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index b65e9981c14..d809bb316e9 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -263,7 +263,16 @@ struct ChardevClass {
     void (*open)(Chardev *chr, ChardevBackend *backend,
                  bool *be_opened, Error **errp);
 
-    /* write buf to the backend */
+    /**
+     * chr_write: Write data to a character backend
+     * @s: the character backend to write to
+     * @buf: the data to write
+     * @len: the number of bytes to write
+     *
+     * Called with chr_write_lock held.
+     *
+     * Returns: the number of bytes consumed or -1 on error.
+     */
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
 
     /*
-- 
2.51.0


