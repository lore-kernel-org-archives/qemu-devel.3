Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AE9C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSU-00080t-H5; Mon, 10 Feb 2025 11:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRB-0004NY-DX
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR7-0001XS-Rb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:08 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso739898866b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204104; x=1739808904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVPkeSXe9XeKHyg9wdlTOD67ZqgGK5EiAy24Z30yFIk=;
 b=wvxefPFKtCS/oI8OqzPgBFaLlHtkNoPu2uJH1VtWeDOLlQ4m9vufcBidroYiPxU7YX
 Pz82cpC12dW0A+lJ+F2YRAIn0voXa6MHAWm7FE2RxwXcVIEKp+LGB8VPgWlPBuljpcds
 6bqwm+GBpO3tcTlgYqx3WP7YXj4ejxb/p/ZnWR6M8os61kQ1fTufjKbO1rHJQNqpWxyo
 ifUAh0azpYWXibrg8THPPi5PH4dJ1k7aCvS/lW9Q92GpINHFW/N4n0Chml6V9g5Vs3DC
 PV9eSWiu9rnSg47d/mKedB6Ia6KW0KgF9aAUhlMcejcAeZK2jCkY+1rEkox7Z4u7NKhL
 6L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204104; x=1739808904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVPkeSXe9XeKHyg9wdlTOD67ZqgGK5EiAy24Z30yFIk=;
 b=XcBKr410ptHCEd87ETxA3HJefDRHhwBGwDBoodjrdYZOYMy3R624+q3Py4DK2rsLXK
 9AABakUzi4KsXt7XyHe8cUvre1yOvDIphEUMJUJbEZ9+L10TZ7TQIlQ3EU93XRoM3JUJ
 GXtRUS7iF0DC4gdB+L66Fu8FzNDfvwHFJV9behcuLc6xv4J0DobMQJ+gUej8YHtzc3D8
 TkdbaZzjcq9WRUgCeZS5ZLzsZUcKQdUp/4MGAeI7tGme/6JPLW7MqeN2gFqGSy9WVRWx
 JPELoenQ8fUzlSgsiE7gLXho1fyEpISKSLaahFb+7ESAUxlNdgO1Hf3hLq9nDAr0Fdek
 7nAg==
X-Gm-Message-State: AOJu0YypN3WeAWgN5fa/LtuhXbj+6iSnR03J7HV+8o2b3duTEe7w5mn1
 lhzaa18Xb0JiNBgV1kC9xporkVDvG2mPxo9yCb++QiARmUiKYop3MweBn7a73iQQfYaFogux/um
 bXAY=
X-Gm-Gg: ASbGncvN7Meyhsyr0Zb6tr0jajuhig1AnPsh2BVOHg1GAz+AOwVXYH6eYiXUPZKDcbl
 yRaIUqVVt/dVsjePVr2ZKmrNHL8ikZDEl44Q1f+mZGwhMfhdFo9VUugyFsb6S9QVqeD72JQR7M2
 q8n7fZcdofghigOgeRpPYl8AdIo2ohvxZBqRkcgu4YK8MYkXAfyyV2vkjiCFWEkEh2INp8jtD7L
 WuDLC32qD/T/fccavxNsZ1qSKBF2TGDG5yWQYLIbNpyX5nO4y/ACI6hfTR7yPyZ8NDxOPmiZwQm
 6oLCQ8RiOFENvHdqVg==
X-Google-Smtp-Source: AGHT+IEwC5FYTYdS5o+XGmQrIWD/cmvBq++0wmQBDEA1nxPyuFOIJSZA5TQZd6HCkgdF8nzGgC9oPw==
X-Received: by 2002:a17:907:7fac:b0:ab7:bcc0:9067 with SMTP id
 a640c23a62f3a-ab7bcc09563mr588449566b.40.1739204103842; 
 Mon, 10 Feb 2025 08:15:03 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7b1a981cesm395120066b.118.2025.02.10.08.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CC4B603A1;
 Mon, 10 Feb 2025 16:14:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 16/17] docs/user: Document the %d placeholder and suspend=n
 QEMU_GDB features
Date: Mon, 10 Feb 2025 16:14:50 +0000
Message-Id: <20250210161451.3273284-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-8-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-17-alex.bennee@linaro.org>

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 80a77f0a0c..9a1c60448c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -54,7 +54,7 @@ Command line options
 
 ::
 
-   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g port] [-B offset] [-R size] program [arguments...]
+   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] program [arguments...]
 
 ``-h``
    Print the help
@@ -91,8 +91,18 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-g port``
-   Wait gdb connection to port
+``-g endpoint``
+   Wait gdb connection to a port (e.g., ``1234``) or a unix socket (e.g.,
+   ``/tmp/qemu.sock``).
+
+   If a unix socket path contains single ``%d`` placeholder (e.g.,
+   ``/tmp/qemu-%d.sock``), it is replaced by the emulator PID, which is useful
+   when passing this option via the ``QEMU_GDB`` environment variable to a
+   multi-process application.
+
+   If the endpoint address is followed by ``,suspend=n`` (e.g.,
+   ``1234,suspend=n``), then the emulated program starts without waiting for a
+   connection, which can be established at any later point in time.
 
 ``-one-insn-per-tb``
    Run the emulation with one guest instruction per translation block.
-- 
2.39.5


