Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1E3CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaRW-00008t-I6; Wed, 22 Oct 2025 11:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRV-00008W-BE
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRT-00019a-BS
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso59251245e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145677; x=1761750477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZKU6hQIClGvtrfJAuNwgzsS5Iba6xqxjP2d0zQb+XM=;
 b=jPhndJ/vpp//npU6nBWY6M9Gonw5kMgnabKQAG+k19r64PDtvFndi5pPJtJcxsRD+b
 N7Vx+V74KnyTkJr8LiQuf0N9e97Yl1ZC/mXdWeyT3N4nEbDSApuJaqzov/9km06UjQBp
 ffIB4XwyKPRRFaVWU6pk/8SRzXmFXCgfX4rKWSBcZ5OhiO4NIcPpDX13v1SC+qjom374
 qNjuiK/xCE51tfiO1Onkm2gMtIoy6/rbKDqoTNFgSmSQ5q2lHQNVsjHMCMX4NGa1A3AH
 yxBc9UaSW9C7dwPPkm8UWtg2Vt2j3szkeFUcAr11uWRfH5FafUhDndof3c89FHJsIclg
 Txeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145677; x=1761750477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZKU6hQIClGvtrfJAuNwgzsS5Iba6xqxjP2d0zQb+XM=;
 b=SX7Av4WiKMB2qnyvbH6wJmd3KtGxaGCOc3a16N5oSEF4Xn6gsISMko5dqFgD+MQ28e
 TjZa9Yf1fqbdbSfEAbbB04fFofmNMrDsF7KfVlRaAAKFOJ/ObRnFnERWLe1krRFYU5pI
 9+B+7ZDbE5F8OWEcRXDRcBsaoUE4T3EJ5yGCzkVtSB2pqVeIqcoa4rXoqcK0HYeq9gPA
 gUrJxfoN2TK+W2Qzkq3fWZM29+urafAjS8Wbw20XzVrkrZNqyOsOHU0GLNULojdTlC1k
 LhApSyFLfrI5uQPLM3Zk2Gs0qa7/DhqafChUFT5gWTP1mC3ObbpxAxpHPduZUJ7r77N/
 EIbA==
X-Gm-Message-State: AOJu0Yxz7jwipO49PsTDz+bDVyZP1YebB3Hx7M/evh6Qfn6FxKr4R50F
 lEwyYU94yQ0g85I4tTYPl05akRqCMY2Yl6PJQRrgfb16VzRFtEBPfETweAZ6orfgGMGUGdiaD7m
 jP/FfuIA=
X-Gm-Gg: ASbGncvYZ+HFTZuEmcaQnjF/r5FVZfCBRm3cKLCObT2am8w/nCcZbv785sLVK2NtD52
 j00elmdsfex7jd3a96wa1UdH8qnD4J3eGhzuytTQRtY0z1VLqIxKw69cVMMwIlQp9wkSphMxZ/i
 ewamBBDSVmDpbcL1N/7vG5iv+UFKzFfo+mZr14a9GtFkK6FpgSCo/e/kqsSDt0U7tF+yAfU/znI
 LbW4Ua8v69dZVH0/NrAU0p7vJmVM3OcjojnJPldSH3LlHHBq+OXXThSMaq0alKAgH/jgzRVes8v
 3WZL7vvdNjIC83F1U4QMq/rKfh6YH0r6gHT3Z9NI9jCIBHx7E6Xqz6iI1FZ3+C/DKeGapUH3P2J
 9d/BooY93hdMwGzsGty4dxM0+vfz2ndNEjkljwPIQL0MzzFiQOA64RwoJC/S4U3NUIaKCBHrHOH
 mgpSWVUjnIMz3aNe+75vzGwSOm6Q147wzfF52WLzfFAYNlxrWy9g9bhnwEyqr9
X-Google-Smtp-Source: AGHT+IFHZjDIJVPW+NYgPV4I8tz4+wgdxvpS6R1G/GZ+Ri+IqcQQCWbE3FrOhDJ2dnLeAYmQCzfdpw==
X-Received: by 2002:a05:600c:1396:b0:46c:adf8:c845 with SMTP id
 5b1f17b1804b1-471178aba5bmr141017705e9.16.1761145677128; 
 Wed, 22 Oct 2025 08:07:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a96asm26012893f8f.31.2025.10.22.08.07.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:07:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/9] chardev/char-fe: Improve @docstrings
Date: Wed, 22 Oct 2025 17:07:35 +0200
Message-ID: <20251022150743.78183-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Describe the @c (this is the *frontend*) and @s (the *backend*)
parameters. Fill qemu_chr_fe_[gs]et_msgfds() method docstrings.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/chardev/char-fe.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 7901856f951..c183432825b 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -26,6 +26,8 @@ struct CharFrontend {
 
 /**
  * qemu_chr_fe_init:
+ * @c: the character frontend
+ * @s: the character backend
  *
  * Initializes the frontend @c for the given Chardev backend @s. Call
  * qemu_chr_fe_deinit() to remove the association and release the backend.
@@ -47,6 +49,7 @@ void qemu_chr_fe_deinit(CharFrontend *c, bool del);
 
 /**
  * qemu_chr_fe_get_driver:
+ * @c: the character frontend
  *
  * Returns: the driver associated with a CharFrontend or NULL if no
  * associated Chardev.
@@ -58,6 +61,7 @@ Chardev *qemu_chr_fe_get_driver(CharFrontend *c);
 
 /**
  * qemu_chr_fe_backend_connected:
+ * @c: the character frontend
  *
  * Returns: true if there is a backend associated with @c.
  */
@@ -102,6 +106,7 @@ void qemu_chr_fe_set_handlers_full(CharFrontend *c,
 
 /**
  * qemu_chr_fe_set_handlers:
+ * @c: the character frontend
  *
  * Version of qemu_chr_fe_set_handlers_full() with sync_state = true.
  */
@@ -116,6 +121,7 @@ void qemu_chr_fe_set_handlers(CharFrontend *c,
 
 /**
  * qemu_chr_fe_take_focus:
+ * @c: the character frontend
  *
  * Take the focus (if the front end is muxed).
  *
@@ -125,6 +131,7 @@ void qemu_chr_fe_take_focus(CharFrontend *c);
 
 /**
  * qemu_chr_fe_accept_input:
+ * @c: the character frontend
  *
  * Notify that the frontend is ready to receive data
  */
@@ -132,6 +139,7 @@ void qemu_chr_fe_accept_input(CharFrontend *c);
 
 /**
  * qemu_chr_fe_disconnect:
+ * @c: the character frontend
  *
  * Close a fd accepted by character backend.
  * Without associated Chardev, do nothing.
@@ -148,6 +156,7 @@ int qemu_chr_fe_wait_connected(CharFrontend *c, Error **errp);
 
 /**
  * qemu_chr_fe_set_echo:
+ * @c: the character frontend
  * @echo: true to enable echo, false to disable echo
  *
  * Ask the backend to override its normal echo setting.  This only really
@@ -169,6 +178,7 @@ void qemu_chr_fe_set_open(CharFrontend *c, bool is_open);
 
 /**
  * qemu_chr_fe_printf:
+ * @c: the character frontend
  * @fmt: see #printf
  *
  * Write to a character backend using a printf style interface.  This
@@ -197,6 +207,7 @@ typedef gboolean (*FEWatchFunc)(void *do_not_use, GIOCondition condition, void *
 
 /**
  * qemu_chr_fe_add_watch:
+ * @c: the character frontend
  * @cond: the condition to poll for
  * @func: the function to call when the condition happens
  * @user_data: the opaque pointer to pass to @func
@@ -219,6 +230,7 @@ guint qemu_chr_fe_add_watch(CharFrontend *c, GIOCondition cond,
 
 /**
  * qemu_chr_fe_write:
+ * @c: the character frontend to write to
  * @buf: the data
  * @len: the number of bytes to send
  *
@@ -233,6 +245,7 @@ int qemu_chr_fe_write(CharFrontend *c, const uint8_t *buf, int len);
 
 /**
  * qemu_chr_fe_write_all:
+ * @c: the character frontend to write to
  * @buf: the data
  * @len: the number of bytes to send
  *
@@ -248,6 +261,7 @@ int qemu_chr_fe_write_all(CharFrontend *c, const uint8_t *buf, int len);
 
 /**
  * qemu_chr_fe_read_all:
+ * @c: the character frontend to read from
  * @buf: the data buffer
  * @len: the number of bytes to read
  *
@@ -260,6 +274,7 @@ int qemu_chr_fe_read_all(CharFrontend *c, uint8_t *buf, int len);
 
 /**
  * qemu_chr_fe_ioctl:
+ * @c: the character frontend to control
  * @cmd: see CHR_IOCTL_*
  * @arg: the data associated with @cmd
  *
@@ -273,6 +288,7 @@ int qemu_chr_fe_ioctl(CharFrontend *c, int cmd, void *arg);
 
 /**
  * qemu_chr_fe_get_msgfd:
+ * @c: the character frontend to access
  *
  * For backends capable of fd passing, return the latest file descriptor passed
  * by a client.
@@ -286,9 +302,12 @@ int qemu_chr_fe_get_msgfd(CharFrontend *c);
 
 /**
  * qemu_chr_fe_get_msgfds:
+ * @c: the character frontend
+ * @fds: an array of ancillary file descriptors to get
+ * @num: the maximum number of ancillary file descriptors to get in @fds
  *
  * For backends capable of fd passing, return the number of file received
- * descriptors and fills the fds array up to num elements
+ * descriptors and fills the fds array up to @num elements
  *
  * Returns: -1 if fd passing isn't supported or there are no pending file
  *          descriptors.  If file descriptors are returned, subsequent calls to
@@ -299,6 +318,9 @@ int qemu_chr_fe_get_msgfds(CharFrontend *c, int *fds, int num);
 
 /**
  * qemu_chr_fe_set_msgfds:
+ * @c: the character frontend
+ * @fds: an array of ancillary file descriptors to set
+ * @num: the number of ancillary file descriptors to set
  *
  * For backends capable of fd passing, set an array of fds to be passed with
  * the next send operation.
-- 
2.51.0


