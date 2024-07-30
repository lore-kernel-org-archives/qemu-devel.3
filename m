Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2D2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCw-0007Bn-64; Tue, 30 Jul 2024 18:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCo-0006yL-Vi
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCn-0006pZ-3r
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36865a516f1so3532784f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378027; x=1722982827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Lc+azGwkwuTK4hgApgrGG827mAv+IHvwoS10S2KQ54=;
 b=j2trGSpOycL9mTldfJLKyX/GXcQz0c4t01TWyTjTBIoPxQW09HnJFNcqtlTtwwz68C
 reNJQWo6RZaAOP1ziBO0lKE/gJiZGe+ubU8DNlLTBBn53dx+qSuhI3fqAkIZ4gZ4QK1O
 f4LDT3qL6mKfzeMBwwHUElFe3htae0d+Fad+QwIrS6WF4SJQc3Gwdf7v0Nu6C9B9H553
 aOGu135RP2NUBaKpdf/M4PES37C6Gi9bK/1XMAAXeW/Vvb6rk8f9g5vTqn0UFP6Pum4A
 z8GPvFsGhkyKvxZjdQqBwHSr+Vw/BqYSGeVbAM1o92bSMHDt5MpM+3lf44o2IUGT35zN
 16tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378027; x=1722982827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Lc+azGwkwuTK4hgApgrGG827mAv+IHvwoS10S2KQ54=;
 b=nHHuG6kgr3E0v5w3VKPfXp+yJOayxSNTERx61zLFB8R4GU/6EaeBjvCFkCycqN4CYS
 nVvRcdawN2WPphnC8qCDQRcbg6nvlsmtOUaPXx6nFfMvSDJDt0uGDcAHmxEy5LnujJW2
 bxo5AfpRyew1cbXy7chpGwk8NLuWU0DiiUbdlYC5F46RmRxU3fU/NNknsAHYL6Yg4l6V
 2hVUgSxEtB0FkxQklW5Juwfld5OXvgHquyYHWp2uZURySZTGEBBK96upTojZPm2lWy4m
 vkXBOuJDynrRmPti41rRlnMqn4hyXAlUmFqJr7QOWIE8tufSGaU2CDWROo36883/07+d
 27fQ==
X-Gm-Message-State: AOJu0YwN1oJWY8YdzxBl6E5sAfyfWAnG29r0sM4kBOwazZCF44Lnrvvr
 cXJ7wPLlPTqbo5q5pBS8/lw11GpcYfjMWo26z0BmrkZm5QzMOo64aozjgPyet6W5QRm1Y8vZaVd
 DY/c=
X-Google-Smtp-Source: AGHT+IH3HpUUmQdxX4ZT0HyUVDyxKukpgKgfDlrFZ7mwt6QpAGf634G4j5Rl5g5/50ZX/o2kDQVONQ==
X-Received: by 2002:adf:a31d:0:b0:368:7868:2d76 with SMTP id
 ffacd0b85a97d-36b5d2c9df1mr9009505f8f.51.1722378027088; 
 Tue, 30 Jul 2024 15:20:27 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b29sm15559499f8f.93.2024.07.30.15.20.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:20:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] osdep.h: Clean up no-longer-needed back-compat for macOS 10
Date: Wed, 31 Jul 2024 00:19:57 +0200
Message-ID: <20240730221957.34533-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730221957.34533-1-philmd@linaro.org>
References: <20240730221957.34533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Our official support policy only supports the most recent two
versions of macOS (currently macOS 13 Ventura and macOS 14 Sonoma),
and we already have code that assumes at least macOS 12 Monterey or
better.  In commit 2d27c91e2b72ac7 we dropped some of the back-compat
code for older macOS versions, but missed the guard in osdep.h that
is providing a fallback for macOS 10 and earlier.

Simplify the ifdef to the "ifdef __APPLE__" that we use elsewhere for
"is this macOS?".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240730095939.2781172-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 191916f38e..720ed21a7e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -786,8 +786,7 @@ size_t qemu_get_host_physmem(void);
  * Toggle write/execute on the pages marked MAP_JIT
  * for the current thread.
  */
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+#ifdef __APPLE__
 static inline void qemu_thread_jit_execute(void)
 {
     pthread_jit_write_protect_np(true);
-- 
2.45.2


