Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5561C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weUsG-0005Rx-FL; Tue, 30 Jun 2026 05:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weUsF-0005RT-8D
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:35:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weUsD-0007jy-H2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:35:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso8441715e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782812120; x=1783416920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lBv48mWGG9CLR02Vrgkp5vRb8jfCgsvJ/FbDc8SdOkg=;
 b=MofwSYF83hGjyqpWHvTyNSP9Mk2loA9WMY5g9mHcLbHBiAjEbCBHRrMaVX5xUgAHmL
 uyODRkEzxKxZANn4wOZk0rv3DN0/hWg+0fxOTCMOjIVMh00lqQ2Wd9FhOzvDZKkeTEtf
 dQx9ZiS7uGWKhHUvI1K/08LXthjvSQ3J1BNIR0UVw5z4XXZYxmwg5E0Q0JPQ7Ax18KjO
 nsYMchuQ30qOCwIrUvyOw1XOrbCUjiVs0VBqgME6DOo9Z+v63jbYCwyKDYysIMz0W8Cv
 9qsr9NOYdHxPvoZTclK8BGKQCnqNk9Ggvz/bWP7UPPurtIkgii/92qCnQIodfS1jm1hY
 LKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782812120; x=1783416920;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBv48mWGG9CLR02Vrgkp5vRb8jfCgsvJ/FbDc8SdOkg=;
 b=Y5WjT8fbsShHFKMytHZpJJJhxIyEXvjEjC/2IUo0o2Z3delAGNU/XINyA8eJCDaoQK
 meNTmA0QAjQw7jYzRCjfk4yB72WWVHfPmg/d3rcXzVp4s1ULOgjERwxurQcOErIOzHJw
 qGsIQRqzi0ogzE0cNRC3vCyuelNMUEJDQUQdLHfnmOFnpKMTsIB7OZlZH0lW+UuTzzGw
 geuo+PS8shfUb2vTArSN2e846rvs5tFZrpZG3mQoWvVE/vgXkHGI/MSV4kWZ8KVp/dxC
 5iIIb78mm1IhEFNNORFfql9sZ2AoTKBs+e2M9Iqhj77CXgJMdPxLRS0PyCF37jT0X+J2
 BlOg==
X-Gm-Message-State: AOJu0Yzbvo56nKeewXz+UfBz0ts8vovkc59x3r1ziRloKxE9GK9MT0oI
 cs40s8bAFhpwgMjvy/aoo1UB7uPehhJAJjyYG9LgeA6zIa8MDdkpfU+SXPYXqQaloOBxLu9cApN
 +BTUv
X-Gm-Gg: AfdE7cmR7QkrUD1DzgtIRK905z6zsCoICB+tEtSNdEVM5hqtfn6NJSeYkpio+7QMcAx
 v7mtuOQ48NeifYyfBUv4YIQ9hb/kWhk1OLZcU7Mbn+PAdz6RIEjfwKK0bN2V5C9EhSffrRUbRgK
 0JyfsvDn5ArFwd/BkYjYdi5XMlmdqyEMfNJ4zZyUGnVw/nQAn74FjwC5ZVsDYiEr396jgylsw6U
 lAQb+eMApFFSLAz3mFxrm+k+iDh4NkYYk2gnuULWJzASnuPtLO5TQHonhb525S+6RnxTRUbahkw
 gyJ1MQ4WyjkBAU9ZBkwgICKZWMVKRRIJn2V4VY6N1ahPfs8NxsuLn82q9uZ7BBCGjwEaQgjLH6e
 zZjEwCtyEpLJ7j8UdPunElq0dMHv1RHcT1FHm67naonyPAIkQ4i4CbsICc01itpVIiF3aj+sSWb
 e0/l+bcj4W/FOJCdCD49xT1foHIwCL0WXRD5BwDKv300L0nYM7C7lUC2AiIEprG4xM0ToZOcKVl
 yxDp5Ngp1j7n+6iHwaOKkVnhd8YekRL
X-Received: by 2002:a05:600c:c162:b0:492:3e69:a86f with SMTP id
 5b1f17b1804b1-493b827fc33mr43965735e9.1.1782812119694; 
 Tue, 30 Jun 2026 02:35:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bb1b2b9dsm24559495e9.1.2026.06.30.02.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 02:35:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] io/channel-socket: Document why we can ignore
 socket_set_cork() errors
Date: Tue, 30 Jun 2026 10:35:18 +0100
Message-ID: <20260630093518.2325304-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In qio_channel_socket_set_cork(), we call socket_set_cork() but
ignore its success/failure return value.  This is OK because we are
implementing qio_channel_set_cork() here, and that function's API
documentation states that the setting is merely a hint.  So even if
setting TCP_CORK on the underlying socket fails for some reason, this
isn't going to be a problem for the caller; correspondingly the
qio_channel_set_cork() function has no error return.

Add a comment in qio_channel_socket_set_cork() explaining why we
don't check for errors.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2254
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted by a static analyzer; it seemed to me worth adding the comment.
---
 io/channel-socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index ea2ec84108..12773b832c 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -946,6 +946,12 @@ qio_channel_socket_set_cork(QIOChannel *ioc,
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     int v = enabled ? 1 : 0;
 
+    /*
+     * We can ignore the error return from socket_set_cork() because
+     * at the QIO API level set_cork is only a hint, and so
+     * qio_channel_set_cork() can never fail even if it didn't
+     * actually do anything.
+     */
     socket_set_cork(sioc->fd, v);
 }
 
-- 
2.43.0


