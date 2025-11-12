Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFE5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBFj-0001mP-0l; Wed, 12 Nov 2025 08:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6j-0003yX-3u
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:41:59 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6g-0001JA-SE
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:41:56 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso4355825e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954913; x=1763559713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apexKtUJRTnb9NQkAMbfIqDJeSAiNfnmujGl4iNTzpQ=;
 b=TCmN+q250mnSj7igGavKC9x+dl2qoxFKe/Zb1iuKamnQR5sDdoY5DkFoM1sdmnnFkE
 MTViA276uSX/96f94Ek/QYGyVFRFiHN5Olmj7lDEfXz+bQFBkfV8zn4+DriCa7CQmdUK
 ZhzFmjEGSVjrXAg2/95vHad9Lg8eQcHfbGheaL7TucDtvmHCBmyMye9Kn5AkQOARcFY1
 jCC7OLY4ULK8hZKAjdBdHYcM4sfE3zd9iXq6wdYPoRjgZT0raR1KXXTyVhpXcwwoMCza
 Gkj6itQ5Brf9cZQ6+2QhdI6/cjL+qHO034SW8XmxdMMpEY8HrA5DC/Myjpvl+B/JWl8j
 Hc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954913; x=1763559713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=apexKtUJRTnb9NQkAMbfIqDJeSAiNfnmujGl4iNTzpQ=;
 b=gHuifjPVFJVz0SWNyU+ezkUukJjDMxIps4d+4QCDNQud6YF9WWyIeF9Pef+8a0BVml
 QuetfFzFkXbpCwrAcKkikY67fTHrq5MSEtvd1WHEYFaLhlZmZHwXGtp0JKeMC/3TL5tv
 B2crPTm8rH+qgoHlxTQyXNpAtE7hBKYF6gamMNjH7DBBicl+5oxAuhJg0SZlyLV4ZFlM
 2Hte91GXNnW5WR6J2sjoDA2omLqSZWpe6tTfC2637aWAttVdO7oh3cqGlm02erPvQSPn
 X5K/18OSr+bE+/4pvgKLVOjVtplBlvUM7VmH7rjHYGC5xITQwh1eA7+9Y4YjJxfKlHi5
 hD0w==
X-Gm-Message-State: AOJu0YyxiwWrwQlT4XQQIvwFDwyjYSm9CN12ajyhOdcXjNgh+dyBUCD2
 f2XsJwDkBvb3dDX6cLUX2R4LHVUh74ZdZMr6/Ed4tA/9KUgEZacOlOENabSG1635R3h4chY5ev9
 aJt9iGGFbXw==
X-Gm-Gg: ASbGncscd8EX/KWg++P3Z2MQkd9eE/7+9+ApoPpCPQ038pxr43CGHyqvgJ9xrc906LI
 rbExEQNdmp4IqhvCFv5nrMAkMagOlSfPB7+ohpqYCMfWo8VKJG6lBTG4NWJFm9Eq+jphmJgoorG
 4RFZzMZCJnAsuR5+eqwOeMS7JsBrz5Jodnqhowh9mLqh8+FLoaPtWShUz/5Dt+OKY7G+eD8ZkiY
 XkGUqY8a9Cb7ncSveW8Enl02U5CA7+tNmG2aNHNsNQONrEoECcUA2JDl2/MxCTcRsfCr8z68+C8
 gmYUWy2O3jIN8s/Ae7heMCzOAPR3OldQyZGDd37xVvYH9wp2hBRlq0HlXJUAD0NuKKSPAklUSnB
 0/nQQq/3Msh7whMJpuy3+LNGFD8t9T7+ORKX7mRQTBg7Ahn8zUK4TOsA1sW68NTTh87zrwFAk/K
 JEYdoJrVcZwWKAWR65lYFRon81/JvSamx7w+uzjqs6hd3IKbfN7yif4H8=
X-Google-Smtp-Source: AGHT+IEMelvSB4VGymHm+7CGO6Rqhr9OAJdxfZfXcW3qNERuWkFv0CvxmAdzjSH+obz3PCD6hbASgA==
X-Received: by 2002:a05:600c:3587:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-477870c653bmr29946385e9.21.1762954912740; 
 Wed, 12 Nov 2025 05:41:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e7006bsm34341315e9.12.2025.11.12.05.41.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:41:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/10] chardev/char-fe: Improve @docstrings
Date: Wed, 12 Nov 2025 14:41:34 +0100
Message-ID: <20251112134143.27194-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index 5f8a6df17dc..36bcf1f88a6 100644
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


