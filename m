Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91B3C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYU-0002IN-UX; Mon, 25 Mar 2024 08:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYS-0002HE-Nt
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYQ-0005dF-BU
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4148c65ea45so148045e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370153; x=1711974953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hzj0HVgtYH8dljqUEAkMRgJehd1werpG8tMX7PZdRLc=;
 b=ac2MfBHYIZalnEmXb7K4Gy1LENJmRojpjcykyPygvY+CeXGAx0OZlf4b6tJ/4CV3MA
 balzCfRm9DoPguLF64SkzjA2msqIwN8fNPUIi9KxfY4COXThlMSuf1kGyofrHTMWDIyh
 T7VUptJYtz9nPiMZLVmOOVS8jylCz9ugeZwufH1oW7OFmZ1IWC+XMvFE86T3m7pUqWOr
 4i9FF2iFpn7tQc4TBGVv5iePd8S2645DWTFomDcY8THuPB8zFKvtFpW2CBWp5XDH5886
 Y2G7iDT09W3dhcbX2A3B7Dduv24j+q7ye8p9hkiWBdwqraAyY18R9IWdCE/B17wipE5z
 D8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370153; x=1711974953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hzj0HVgtYH8dljqUEAkMRgJehd1werpG8tMX7PZdRLc=;
 b=SHSwkh9zYlNJvXaBZIvdO0x4vJBPFrlOF8Wmg25DjIDJSF562l3FHKLr/ZYxdrzJZw
 Fv7sHn/zYuH39YCvUupuGov0xODbQshMpWK06GtXjtPUM5aR33fkzhOw+Cs0OMPfnEo4
 Uf8eh4f4BBzrye7vsSKL94TwN7FM61MEfhiK6IwIQ+5IDdDkaw5TH3jXsa3ESvMIxbqM
 ynmEzo+v0yhu3x0UT1XgSCVvgJEjapa0TSiNnDFdAZGGST9v9Ju91SAutruP6q3NZn3v
 lq9RSqrMqafOxt+SJh343xQP85P2YKVDidkos2fB7O6o+3dGu7T+Gtwif8AqHKHaaJQd
 rzJA==
X-Gm-Message-State: AOJu0Yx9mRKkxnRnGaRxtUA2foXC3LxQT3s/Hcst7Isu/lABd8H7qlxr
 hbxnkIGJj2w1/cNTZuGfQ/Vve5kpTkT9UyRnD2RFFEigYus5pOy2RkvIQ8DNrMftX41h3CZUWH4
 Y
X-Google-Smtp-Source: AGHT+IFIQWrZfOAHdyaeQqvk2kZnE9gBZkoj465GV2nYPvZDZvGA6zjAdCWpbv7i/l4VHUmaNZ2fMg==
X-Received: by 2002:a05:600c:560c:b0:413:2c11:f795 with SMTP id
 jr12-20020a05600c560c00b004132c11f795mr5735095wmb.39.1711370152910; 
 Mon, 25 Mar 2024 05:35:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] tests/unit/socket-helpers: Don't close(-1)
Date: Mon, 25 Mar 2024 12:35:45 +0000
Message-Id: <20240325123550.1991693-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

In socket_check_afunix_support() we call socket(PF_UNIX, SOCK_STREAM, 0)
to see if it works, but we call close() on the result whether it
worked or not. Only close the fd if the socket() call succeeded.
Spotted by Coverity.

Resolves: Coverity CID 1497481

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240312183810.557768-3-peter.maydell@linaro.org
---
 tests/unit/socket-helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
index 6de27baee2e..f3439cc4e52 100644
--- a/tests/unit/socket-helpers.c
+++ b/tests/unit/socket-helpers.c
@@ -160,7 +160,6 @@ void socket_check_afunix_support(bool *has_afunix)
     int fd;
 
     fd = socket(PF_UNIX, SOCK_STREAM, 0);
-    close(fd);
 
 #ifdef _WIN32
     *has_afunix = (fd != (int)INVALID_SOCKET);
@@ -168,5 +167,8 @@ void socket_check_afunix_support(bool *has_afunix)
     *has_afunix = (fd >= 0);
 #endif
 
+    if (*has_afunix) {
+        close(fd);
+    }
     return;
 }
-- 
2.34.1


