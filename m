Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315C5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBa9e-000309-Pg; Wed, 22 Oct 2025 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9c-0002wq-V0
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9b-00078Y-5B
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475c696ab23so3618975e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144569; x=1761749369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1bprD0sWW5+ysV7IuIdf6MtG7ztBPn1NAHgeBdloHI=;
 b=QQynBKG63El5bw38fAzM94/2HygvWZMsGwQ/KZ2AhFhDmtzqI6xyYcRiC4p9Yus/tv
 c8Owej3Oa3uvLHRlxgTE2A/3UviuCHI/khtejHZXfgoJEhK0mQa4A8YtzfUq2p5AsA5x
 uGUF4GhpbAiac+1I+3IFWhm2dJZzb57XPnVgw0DT2yI5uDI5+t1P7Fp4WGlCtvRZHqeu
 zqTW1voSK1Yo3bxBUf6neQRblL1ecUiiB/9teCDIZSvqlgOYa5Rw2AOl/CBKJBka7lXi
 PweHqQuLBRkSqzR3OskSuQ/kubX8+K2MjUCQLjH9R3jWNcqoRlsaQcVRWBpYwULFOdD6
 UYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144569; x=1761749369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1bprD0sWW5+ysV7IuIdf6MtG7ztBPn1NAHgeBdloHI=;
 b=Xu4w9Y6+ZwonB0Jqbi10+UgGLbx51Z5thG1k9XKyr+86nyaaFUEz50G/AZsjcULr7S
 a93UT0o7RBSSUqPgFMtZu13rp4jvT6FwDy/Pezu9mRt2Z13wx14lOhHpg3M59szosgeF
 dPOHNtf185zg2L0a0nvI8yCnO3+CGyp7YT4VAE9XIxtTx1fbjWfCnk0wuX7fzcbNckur
 ZiZR/XXRyhCYt/VaUppOFDYG6J3jWDzL+15hdOXydtA3MfwkHsk07JFvxKyfvOR3e4n4
 QQt6eFmr3D094rRZsT6UXWZd7Bw2DuvG+kCj4CjF0pt81hCUs6fZAtxbWngxUtqn672o
 lYQw==
X-Gm-Message-State: AOJu0YxIeUTKPh3tT8yieF9huSutBmLg8853ZyNsLGlWa+5xCc4cQ2L8
 L0u2AhqiXu2w/xAhmZx4s4fhN4NewSHSuG7SD5DtElzvdWiSozYwn9fxQUpcUqq/x6/5fjOPKxl
 SQi2605Y=
X-Gm-Gg: ASbGncuSfkL3B/Yp1GlzrDFmYsOaiiHFG2OLhaQw1JVaB5a04FHQQGlM4JA5F+fChzG
 8V+4ovQL+mD7uPTtW3zE8fb0hnmrkLRrq7DSLlULmXza2qci9WlS9VJJE0DR0M/2kRx0JKPGhli
 /a5N2cwhnnf2GWQiAWdvBe11NKulUInaCloF+VQz0ytFYnIlDRRHNS9U+nGTKwF1AOV7dNjhH8d
 KeqdZCSxzTPgjOYVxVnLwpbOMW8GfubVS1Hnm1rSK4pLxawCKfoDe2N6mjD8bmh0OwrlAa/UJyb
 cLSBbO5UMF8i9ioPdbcaKOZzlXjmwSg63vvFcy/qBzFw4xOQReO99ZvbSb7kP7+QO/h6L5jnd33
 NGyA8HuOOyAGfj6Z4aa24Jt6pGj0Gdt8YRm0VQhOPZtr8WBYFN/3IyhALWxfDx8FS5tUBFB2Fx8
 BwtYXAqaBiJSV+cJ4pUFQLrQiGUrAWgUbLP15q8gHmRvbgQ35UYg==
X-Google-Smtp-Source: AGHT+IGNf8Kp656x5OmBwRdg/t+gUU3jiGTwi+4wedQoGoLfIJaaz3b/6AK25d06d2ZbBXQs0s7FTw==
X-Received: by 2002:a05:600c:34c7:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-47117931edcmr154038905e9.40.1761144569142; 
 Wed, 22 Oct 2025 07:49:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3casm47262065e9.4.2025.10.22.07.49.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:49:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] chardev/char-io: Add @docstrings for
 io_channel_send[_full]()
Date: Wed, 22 Oct 2025 16:48:57 +0200
Message-ID: <20251022144903.74612-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022144903.74612-1-philmd@linaro.org>
References: <20251022144903.74612-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char-io.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index ac379ea70e3..f14d1d7ef00 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -38,8 +38,26 @@ GSource *io_add_watch_poll(Chardev *chr,
 
 void remove_fd_in_watch(Chardev *chr);
 
+/**
+ * io_channel_send:
+ * @ioc: the IO channel object
+ * @buf: the data
+ * @len: the number of bytes to send
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ */
 int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
 
+/**
+ * io_channel_send_full:
+ * @ioc: the IO channel object
+ * @buf: the data
+ * @len: the number of bytes to send
+ * @fds: an array of file handles to send
+ * @nfds: number of file handles in @fds
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ */
 int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
                          int *fds, size_t nfds);
 
-- 
2.51.0


