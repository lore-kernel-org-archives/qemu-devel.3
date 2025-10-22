Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2509DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBaRh-00009v-ME; Wed, 22 Oct 2025 11:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRg-00009c-Om
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBaRf-0001AI-81
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:08:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so39464545e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761145689; x=1761750489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1bprD0sWW5+ysV7IuIdf6MtG7ztBPn1NAHgeBdloHI=;
 b=gLsMvEk7ufqpSAUjJWaWskEYEPu2Ir0h5SREivAhqidC4PSmLcj/McT1YG1GOv/Kku
 rTv8AcZ2+ODTpnFlxFFHRL1jDr45R/vMmYQwXjNVhgK4x3FldI7CnBFXVMrH81Y38+eH
 aSDExWQgcJttFmg3sUhBaWKMITqnqF0AFrkHqXXXEFA+JNPmGTCbbvaz9jrq0yIUK063
 E8weAToTOMT9tAkD8QSNuwikCiHhEj6lw1F31szq5/1OO2iittlYG3oZ13QX/JCOT4Rz
 ysjHMlpCPp/L6oG6QRdckG48MQib9tq46MJboHj7zjcFns0EGQIUyi1h4OVqWwJbiB4Q
 hBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761145689; x=1761750489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1bprD0sWW5+ysV7IuIdf6MtG7ztBPn1NAHgeBdloHI=;
 b=i+ZrE3+wpzVyOdsS/yXWh4gciQ8xxZ0wn64BWOKmvKjeGmpIfdr981NedFTAlYsoRI
 0T62MwB8OLzo5rb6CpjupAJvTr4YnwK+DkLgFQFJBmsutrT9OoYzAqf+I4IY/9NyAigE
 fBm4l4fEexkyOIVbwkoCAOT0O1b9KDtfQljJXuaJWD2AidZb8+4z4ADOIxv/PWycG64I
 fXF/kKL92UyY7pYHXQntiKUSj8EX3pxxse0/38iEaBK0I/dkQBH1oxxaqtMpFB/p/+PB
 hsxd3BdkgmjK6GsXM/axT+65ZbVz1WbbI16FdowfnRh1QfFpPRaldI3YNGpF3BvCS1Gm
 kfOg==
X-Gm-Message-State: AOJu0YydoY/tTgxjYghptcph5AXp1zocIoZG2Aiv8r9dGbzWO+7wuMxl
 Ij6lHGfVVzaWXxrKFXifkVR58uXG6SfIr6oD4/0qSUvlgvwILz8tbfDx22Wg7g5jn+VRd2e28sq
 saP65fbE=
X-Gm-Gg: ASbGncsCPjpfLafCz1nerSt/7dNFnXDpUoFXwk3m1GcITMUbU2c7hw0apXUPtOWAA2j
 AZfBTlkbOew5quswza0zXcDYScuOgYIpxUHMZP32rS6iQlsH89Uqniz9JeiLDeI+AxOlKeOqVF0
 gWbbWWv53eF59hdSgkem53qNpxqhWSbsysk9GtkVXRqveTwB5aH6fFmWWrYvc75L60nkBbX6jSA
 oDmPRarR/xqWHHm5pBd/MHAqtIfkhB5uvBwZNkGxLMt9IPM7lmtcESdXkBNYThipMkdWmvRE5Vy
 G9heN3ZlO/GS9p5H8ASso9NrXUSCPI4pOQa9Kpq51rOmaNyDh2gByVmcovCjxAZL4dlH5ikaiaA
 9ungMR0/gRI4TFmzSjmaznyjZU5PzsVU6lD6h4T2LtA1IW5UWBtJwwXxYlqv6+WOlsNe3JXyGcJ
 FjYwuFAjRkWffds80K97ePrUwVYG270/UXX+0DEg6nLv7bUqYIZQ==
X-Google-Smtp-Source: AGHT+IESZiOrzZ3N9YCgVJP41Qo9+EAKNvf4lDm/KAjV+Epz9oAMC0SLLl9Kzl0geUDpIYqtqBiJIQ==
X-Received: by 2002:a05:600c:4e93:b0:46e:4329:a4d1 with SMTP id
 5b1f17b1804b1-4711786d685mr152846985e9.4.1761145689094; 
 Wed, 22 Oct 2025 08:08:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428a534sm56847435e9.6.2025.10.22.08.08.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 08:08:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] chardev/char-io: Add @docstrings for
 io_channel_send[_full]()
Date: Wed, 22 Oct 2025 17:07:36 +0200
Message-ID: <20251022150743.78183-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022150743.78183-1-philmd@linaro.org>
References: <20251022150743.78183-1-philmd@linaro.org>
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


