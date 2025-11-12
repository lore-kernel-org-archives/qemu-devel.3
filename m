Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593BACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBE5-00078g-Kd; Wed, 12 Nov 2025 08:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6p-00041L-Hr
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB6o-0001Je-3H
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:42:03 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477775d3728so7618835e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762954920; x=1763559720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+28mb6/qxZ6eOW2R7gXOmFFtY5bUA8Y2twhmxYKlCbE=;
 b=xIiqlzkFuQn5ZkgDUnI9TRQws5gBd+w7w2bH9EmT0YttrAWA3CvK6tYTfuveEnv0V6
 0cRMdlHq6RTA998fqwJPs9JamZTixV7d7fyzBhAOYg6P9CaGx48FeTo2/qSIDBAJr3sw
 qbQiC1rbZSLy5p2WGXx5nT/dagWKtuKSF9hoFcV1mrJTwHfBdHgwA08557VifbZ+9sz9
 1vrtqG69PwO3x8fBOC73ricf9JeBvjIf/tVL/TtbjGFxBdaqcwF0y4LSvXPrBCD9ZVZJ
 h5OKQeoNCjdve9R0G9Mxk8P/NSepAq1ipyJr52D+l5hQ+Baybwn+jDgH7ocp88YrB+0H
 4JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762954920; x=1763559720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+28mb6/qxZ6eOW2R7gXOmFFtY5bUA8Y2twhmxYKlCbE=;
 b=QhitizA9mE6G1/v0PCW6bVpPAITWZnWhsYCivB4UvmdFRyQgh8AZUH/OGbVm9ckvZ0
 TM5Idlpbxjmc2HHnF4k9ZQDbGgR/a+KlFX72oMFCR59912wgx0jpmhyCwJNuauqHBSqs
 aUINCVrBaT+N4HILZG5uSsjmY876eew3kbHTsXujLHdr1kl0m94VWeVRxAqFhqdqVd+F
 JcfIGmH12JYNYncHkG0l/pjtpWMQhe++l+P7vekj9eIjpFVwndhol9tuGRVHA1oiRzqM
 llwuN4VEYFJpVwB4FG0O1S36in8eW+tlrqchu5K9cZr19nhXrKYUvCSpWemUPNREhkVK
 poPA==
X-Gm-Message-State: AOJu0YxVCB+FIbY8Z4ItjLxqarzGW5+O7nmHa6LsxCNqW4J94Jbr2bW4
 wXNj6BOPP43vrxuF6gk6mlxPRLSJ9f1FfWZ7DvX13obaWYMDn2WHT2HDFFGEcZMQAZSoBrUAPsQ
 VApHL14bM2A==
X-Gm-Gg: ASbGncuSgfJ75/VEzUQQObOqhonqDUghMzoojs4cDlZy6VhvkcQrR/XXQsg9AUhzbtU
 F/hY4gGp8yzl49THMQ1CGGNQ2npunCuqt4yFX2J4QBdhgUS15gqTjp+g7DqdJCOvihoPNBH8HV4
 LO9WIToBai3LsrtvHADRkYncHZewJ4kFH/nMTq/Mfi0VCQIAtt7ygO0Bis/xWpk8trlY72WAGlN
 RLIgoYcbTlLeDXUKQBNSsbRFvuNQvKMX+wPJiVRZwc9WbZPvUqfYTE7uZhHA9ej58SOPBJmn6a3
 ZHyofM3zFlDG9zQSIo1VOVSTWsRYt4+TLcmq+B2HDc5jbCkuhrGu6r45fKOtnbKxS1qygHhYbGM
 g7ZAMjdMf0zd8nG+WFpnDfRrvX74klBeex988MUofZzahavSb7OO3bQx7GFg0uixZCcoOxAJSNa
 M6P6rs0IhVmihaRqWmTBqHDrsfZQlCwo2qLbmAcA1gzxIkIkXSQ62g+ks=
X-Google-Smtp-Source: AGHT+IECmPThv0Pj+IN2TLSZCg1tMWtQ/247+6M4vZaDrhQEPTeNbG+7UqTvBNKcUxCWgn8CSNVN6Q==
X-Received: by 2002:a05:600c:3511:b0:477:6d96:b3ca with SMTP id
 5b1f17b1804b1-4778703e676mr30655935e9.5.1762954919724; 
 Wed, 12 Nov 2025 05:41:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675cd25sm34703662f8f.22.2025.11.12.05.41.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Nov 2025 05:41:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/10] chardev/char-io: Add @docstrings for
 io_channel_send[_full]()
Date: Wed, 12 Nov 2025 14:41:35 +0100
Message-ID: <20251112134143.27194-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
References: <20251112134143.27194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 include/chardev/char-io.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index ac379ea70e3..5b181be6a0b 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -38,8 +38,28 @@ GSource *io_add_watch_poll(Chardev *chr,
 
 void remove_fd_in_watch(Chardev *chr);
 
+/**
+ * io_channel_send:
+ * @ioc: the IO channel object
+ * @buf: the data
+ * @len: the number of bytes to send
+ *
+ * Returns: the number of bytes consumed or -1 on error.
+ * On error, %errno is also set as appropriate.
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
+ * On error, %errno is also set as appropriate.
+ */
 int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
                          int *fds, size_t nfds);
 
-- 
2.51.0


