Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56021CCF9E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBa9Z-0002pL-G7; Wed, 22 Oct 2025 10:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9X-0002lc-1f
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBa9R-000752-M1
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:49:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47495477241so19245415e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761144557; x=1761749357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZKU6hQIClGvtrfJAuNwgzsS5Iba6xqxjP2d0zQb+XM=;
 b=lfTqIM2YsUXPYUX5XKKn2/THJRA0ncDFCys9zEgzMsLOR4rcYT/josCN/+mVDIFNN9
 X8gc1lyq0hLEQ0kOEYuJ4OiMXHgbiskGpGwqHO38kjHWesiUj5D1j3DZr16fM04R35Q3
 916V+MF7/REDg6ZBHwEBrsgl0c5c+7pX5iQV3FVN8Ww79WmWOTs4VuXIIAgvxiX3MbT0
 LLN2ZBDKnZY6FUbrnUM+GwXgPwug2Bk0xN6E7TnDVC91Ra7RFeZw1amQT3zeKn2jEBkq
 RbF1ViNtCoL0lwJpcgS0+V46Gb8YQbMNYnW2ZOceEMjFeKh3fq7Tu7klLkPEaxca2heL
 X8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761144557; x=1761749357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZKU6hQIClGvtrfJAuNwgzsS5Iba6xqxjP2d0zQb+XM=;
 b=b2TaYyhfHbJnofsbIqPus/0Q2gJBO2GLEeDyF/BgvFfwDoWnqbXZJ9YJknMqzwYWzx
 FDEhFTU3pHYcFFm+O6J2ezRwLRaGW5TzCvl3jQccbvmKCwIUl2UKFJJlYhgbJ50awUtV
 sEc8179jtjebST/2BTkLcTwLR8aaD94uX3CtyG0iQB7Nl2VIqTr6ib0i2KD2hnqQ2h0S
 5jSdRdvif0VyJJTjZbHXsRuOT9TPEGoxC/QR3xPpAtysS5HmBGJ9G5ZGVHTbk/40/2o2
 5bE/Hhbar6EJdpPro9Pm7ChbC9Nvrxhg2bzT9n9+4i8b9y8g60N7BEz53MnvsGm4G8S+
 1WVw==
X-Gm-Message-State: AOJu0YxO9LPtxTLdPStJ4LHFQNMKoGPbfH45m27ot+HNBZx8weOLAndP
 hmZp+9qjVPDM0a23yo5CLEdq0RzMEH8rtDBmUCzV1Zn97TikRYq8GlQvTz3a5KYTY8AxQIvrnc0
 oxQtbcNQ=
X-Gm-Gg: ASbGncs1fsIyPAzS8QvXMujiT3NfWIAKM+Txiy8RR05osNJdBF/5UX5MTO8kpeUuajb
 yKF9JjWmeNmcwp/88xr37qH4z5TkgqX83QYQrIB0HbezCKOEXuenzQXrHaRlhFOJjBZliHX4Bog
 BXj2Vb4VxIFxcyWfkkifl7HatTIjJK/pvtIIHlswyB8vDgiluMbbd0Hf2Mzu0DS+AwVCMx6C7SA
 4tj/YqRIQVcNHTtSOBiT6Q+bIwslCWp+0YKmhaKrOUqyl2IcsalUsxVNcMCci9AMQM/HHltLZi/
 5cvn8NgO/qJ4j2OvIgT6Os/1/vAeojofkrIy0jcxTZ+TLYpx66CfSOIdsYrPyXCD+31HRXr41IX
 Xv8n9ZgnkHq/fdUxWlAo/QKlxAIcu7DzLsSD97zHSKFAIvkOWfZxeYekLmUUcB/8EyHZ2DxEOsQ
 VvQ7NjuDc9/ApkgEljO6lyTVK7oSuOv9J350QPmEil5swTgPjzkA==
X-Google-Smtp-Source: AGHT+IH3uBIYKZa7z+Nz7+8Zuf+Bvl32phe0dV0tvqbyK5bNHbNyORPPoZamSRDiVMQqTf3HHoSnzA==
X-Received: by 2002:a05:6000:430d:b0:427:8e5:39df with SMTP id
 ffacd0b85a97d-42708e53c54mr11138214f8f.21.1761144557150; 
 Wed, 22 Oct 2025 07:49:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce08asm25413646f8f.44.2025.10.22.07.49.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:49:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] chardev/char-fe: Improve @docstrings
Date: Wed, 22 Oct 2025 16:48:56 +0200
Message-ID: <20251022144903.74612-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022144903.74612-1-philmd@linaro.org>
References: <20251022144903.74612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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


