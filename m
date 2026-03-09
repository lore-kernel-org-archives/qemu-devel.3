Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB244FCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeja-0000qK-Jw; Mon, 09 Mar 2026 13:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzeis-0000bH-U6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:49:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzein-0002pI-GL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:48:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so18847275e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078526; x=1773683326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX6U5804XBxhUOM0jVAkZj5LN38FPZyQexevD1dDtcI=;
 b=xQ3DFVDG9VQNW2PmhAFbkHAk5YV/UwqD9iZCIKD/xeoSOmR63GjUOZ2TqiZRKjawCC
 vBCta5qrBOsZw1kJGLSBVU3Sn/aSHkxAtc4tWC1c96D1xr5mMva9uJKAAy59IiB6RoAd
 NBnISDlWOcyrpA0dBcRLSOUB1D9YC4ndRYpWkg+nTfNLYupzwLAlfF11Y/zZE8KZn2NW
 rdMEKm4EE1kXTZlENeTxRbT85knswV+Ac8+Ao/ZkQz5nlVcFu51+EJDArlv8wVKulXDe
 ubcy99dJq9IbLl3OjI0/IJ7B3FHBdvp9ypxWmGll+lQydLXAs5jr7YoumXhCLLBbDQGB
 AD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078526; x=1773683326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cX6U5804XBxhUOM0jVAkZj5LN38FPZyQexevD1dDtcI=;
 b=SBKEFMefUgpxbi+tAFntI/5uTBTC9kPYaITnfVwO+Qi7oB4+44/HbMo/v13RCQSQUN
 O9c6r5tYh8rEaF4/69omYBSjjq3HVwf+fHkfnau8TcW/W0xEA2C8AVEjyN/1RKcdWsQe
 dB6HNCv4PVLd52WUz8eLCTx+tL0nohJgZEsTAXQqtzd4o3F6GT0Jar0qc5YMPHFDZUJB
 LK18L7Flqnq1iePnwWu2pJWm6JmoRHu4yyD1+BFPyc4wsV6NyU0Jkt8/xHDVTqdXvXvu
 8kwfOveuhyjd3JKDdvuGR8G+x7gCbvJHnfaXA0rqp/X64NYesJk45GASUD17ryNt7QOg
 /Nig==
X-Gm-Message-State: AOJu0YzKjxKTeZfYstMV0nkT9wS0VAsEz4/8vdOdOw7RonPe5zlnV6M5
 oZQy38h77WNRPgmR78+50ycGH2d8VXt/AF5OfNl4ATd1gWK6ytakG8YNn+Xsokh3+qI=
X-Gm-Gg: ATEYQzwiQpdDU3duzQ4woe86rryZryxwj129yLaasXAtIe+suaP5cLD/SFykMa+Duox
 9r/Y1dQtwiDwzrSFbVdBmlbaQEf5wbiThfBncG7Qus21deP71T+HS661oAKd6stxTkk5JEMn7bE
 r58uDrIPSOiR4VgeVQnEbweul7V5zo6ns6CrU/LPGv73c0IkZUcAqeQrd3cu151WpFIhS5HhCP+
 q4ovk7wUQKvMpQs2Oz4hd5EOrDO4il85PdQDWNt1YklyPKyKmUrHh/vqXaKZiRBQQIFQrhZuguQ
 4XM2gpMEoPuQ7c3wyta2OxLxHQ17u6KFKU0n9axZj5lveMFOqqb4rgr9WxXrIVcKF7h5Nbw68DE
 JSQceZW78lHHf2imjonRkFQsjJoS0x3aCj+mXGd5KSv995lpnvixLKYNLxSNvMv9Ln6h6uSoKvL
 qWMNf7ZSGp8zd1/kiH/o9Lt3k=
X-Received: by 2002:a05:600c:64cf:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-48535a4a174mr104580995e9.28.1773078525750; 
 Mon, 09 Mar 2026 10:48:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237f354esm94164175e9.5.2026.03.09.10.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:48:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B64065F894;
 Mon, 09 Mar 2026 17:48:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/5] tests/docker: add gdb-multiarch to all-test-cross
Date: Mon,  9 Mar 2026 17:48:37 +0000
Message-ID: <20260309174841.4184117-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309174841.4184117-1-alex.bennee@linaro.org>
References: <20260309174841.4184117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

This allows the gdb integration tests to be run as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
 tests/lcitool/refresh                                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index b73776d95b5..287770a995a 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -59,6 +59,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
+  gdb-multiarch\
   libclang-rt-dev
 ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 3e4b026035b..259e6ea0729 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -167,6 +167,7 @@ debian_all_test_cross_compilers = [
     "  apt install -y --no-install-recommends \\\n",
     "  clang\\\n",
     "  dpkg-dev\\\n",
+    "  gdb-multiarch\\\n",
     "  libclang-rt-dev\n",
     "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
     "  libc6-dev-arm64-cross \\\n",
-- 
2.47.3


