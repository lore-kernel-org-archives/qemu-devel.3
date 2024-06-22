Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FE7C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWI-0007xg-Iv; Sat, 22 Jun 2024 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW8-0007lP-Ah
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW6-0000JZ-BB
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso1973553f8f.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058008; x=1719662808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DVbTZOyZta6M5LkIwrmlcuQhcUPezx++RwXTce04VCs=;
 b=SygzxSMCAIocIudRMYZM+Ibh6ZkGV7IeIshgXqpyIfX038E9WdFdIHlRk4Wxec1+Gz
 qWNTWXCzllv6l4jSr6hPqpxhLH/kY0BpnGYa2D+4JWM6gJamr1rYHq0tYq68IDYMSJf1
 R1ZBIK1NYQTGSMy8/jq1CVUCTqJuHb6xF6BIaCqR/8FUp4Ttp1K8Fc5lJa17DxQUaAtJ
 9aIPjo6C27gjFAot2w4RyaP3kgIXUNRCAgjEGJm6EoJ+OfsnXCx6g7c6cUrZ8AWdWY/7
 ptS0rbLlJQPGO7SYWbX1c4rdIsWuei1vfwbalI86h4+NBuilVAilAh4xUI0xYqnQEwe9
 1exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058008; x=1719662808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVbTZOyZta6M5LkIwrmlcuQhcUPezx++RwXTce04VCs=;
 b=fHPTATB49pc/KJMSWMF21wsV7KM5DuroLTkdGmvXNBSI5MVXb0f0SazjWcj5d4R9An
 5L6LjoZ+tYthezRAJXQbcYELU2dHlsQjG21u50hIMwBRG4Jz9x31vJmFXWqBXONZMiAM
 QwZ1JnYvG6xuosSmQZoCgmZQu5KT8Gh+0cN6mssZY+tAqZn0RFcBI/lbEgovf/sFPNtg
 we6iUVD9FO6c1eOwAciw6aM2NzmEcYtBsytMyr2mIzbDK5rPT/a3jVWR3rSAtcuSlwbP
 7HdA5YVeff+O1y37ym/JItiw5gLBJjgqy0EeCUbNSzxCcREI6Arcuj1780NbZGZSJ++4
 SUuQ==
X-Gm-Message-State: AOJu0YyIY7ZFg68SG2VofoJwgndWpCFu3JIpPB/2DjAIbGfhYAJxX/4A
 Yn19j8OciiL6dhdHLh5CtIvZlQuZWdnnmiuEBJDTVtTtvCMPqLH9SyTdH9bH6Fg1GnvrEAQsoM5
 qunw=
X-Google-Smtp-Source: AGHT+IH1PB/xu5GeslIrTU6A+aC1/z7/7RZ2uDq9Gx6Hj2qXOv6H2ymw9dCSGf+SD2YzNZ7/y0AMUw==
X-Received: by 2002:adf:e383:0:b0:364:3ba5:c5af with SMTP id
 ffacd0b85a97d-366e7a63425mr243570f8f.61.1719058008226; 
 Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] scripts/coverity-scan/COMPONENTS.md: Fix 'char' component
Date: Sat, 22 Jun 2024 13:06:31 +0100
Message-Id: <20240622120643.3797539-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The 'char' component:
 * includes the no-longer-present qemu-char.c, which has been
   long since split into the chardev/ backend code
 * also includes the hw/char devices

Split it into two components:
 * char is the hw/char devices
 * chardev is the chardev backends
with regexes matching our current sources.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240604145934.1230583-3-peter.maydell@linaro.org
---
 scripts/coverity-scan/COMPONENTS.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 98d4bcd6a50..fb081a59265 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -73,7 +73,10 @@ block
   ~ .*/qemu(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
 
 char
-  ~ .*/qemu(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
+  ~ .*/qemu((/include)?/hw/char/.*)
+
+chardev
+  ~ .*/qemu((/include)?/chardev/.*)
 
 crypto
   ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
-- 
2.34.1


