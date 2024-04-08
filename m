Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE70C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 21:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtwcj-00053J-S8; Mon, 08 Apr 2024 17:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtwcg-000539-TA
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 17:33:50 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtwcf-0007Qr-B3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 17:33:50 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516c403cc46so8891929e87.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712612027; x=1713216827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Spf4Zi1bBqXxf2Gm6GK4HE1fTrLcNzSmKtfAQewlYLg=;
 b=zZq8b+GM398xibWEvmyDRH2Lh4Q2D/1sbkbHOEGlv1EG1lvV8wZAxm3Eah9YM9SlnA
 zuO3zfitzjAwdfZvbo4cNBL20YXaGW3BhBvq+EtlVnNNL4xO75hKCqB6WKXy7H9Auk/v
 lnyNav/OUbXqor+AQUb6rDHDz4oa0PS3bC7htLAy/T/tuhzQ4dKyYpNJNL/44CRQYCxi
 Pn+3moG8fDYnF/hDCUva35UOLr2+szv2lkpavotC6h1jZkxupFexCGh7MQJPE4nKR9Un
 ZwyhEmQ0App/MHK6DkqVLi/l1Mg0qdk3Ek5L5TDaaEc+VM0yURbfwTHs32SJGAv/Zt5p
 9dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712612027; x=1713216827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Spf4Zi1bBqXxf2Gm6GK4HE1fTrLcNzSmKtfAQewlYLg=;
 b=C9ZaopZIRCLzNY28pK5DQwiYVIBGFT9N/Cozx5uN0y/RCmvXz65UALcHt6dIhVhoOX
 9jAL2WysZqeOmIDMAvrvTUiWCHUxeiD6Y4UD65LTWm+709sot+cOeqY25aYYxzo2MTqb
 reskyTIfxT9MDo1WWn2HCFpzPuirEWg4qp52WzNKbGgTiY/XOsW8HvADW89tTU5gSdAD
 Ajn8LeRDsFiKx+FPE6Ynf64Zf40xfeskPR1j/oX/VgFvGk6eiNW1WSKW2ebLgu9G5Wb0
 qk1lCEWP+LPBvb9ZOip97kqbSnQllv7qRibZ1Xz3HThWSiIrsDdji5ob6rU8tbrARh+q
 5alA==
X-Gm-Message-State: AOJu0YxMNlJNtBafQW7OLe21VF1Qx9jH2dtSG7I50brOV+B0pscWo9yC
 FnY85lO8EtnnSKYtl7kRsOUTStKuFPXUmaM7cNgWBecsHeMQm3KVaGV2D35BhUeAN0Ai7pF5SR/
 K
X-Google-Smtp-Source: AGHT+IFSn5GrYWTlvD5hzzmq6QuNZ7dEsyMpgIRGj0GQF2G/yXMFEOs/2h4qvUPuUpEKM9gzGHS5Yw==
X-Received: by 2002:a05:6512:3e17:b0:516:d250:91a7 with SMTP id
 i23-20020a0565123e1700b00516d25091a7mr11695998lfv.12.1712612027249; 
 Mon, 08 Apr 2024 14:33:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a170906091200b00a4673706b4dsm4891513ejd.78.2024.04.08.14.33.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 14:33:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 1/4] hw/i2c: Fix checkpatch block comment warnings
Date: Mon,  8 Apr 2024 23:33:35 +0200
Message-ID: <20240408213339.83149-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408213339.83149-1-philmd@linaro.org>
References: <20240408213339.83149-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

We are going to modify these lines, fix their style
in order to avoid checkpatch.pl warnings:

  WARNING: Block comments use a leading /* on a separate line
  WARNING: Block comments use * on subsequent lines
  WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/i2c.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2a3abacd1b..c18a69e4b6 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -4,10 +4,12 @@
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
-/* The QEMU I2C implementation only supports simple transfers that complete
-   immediately.  It does not support slave devices that need to be able to
-   defer their response (eg. CPU slave interfaces where the data is supplied
-   by the device driver in response to an interrupt).  */
+/*
+ * The QEMU I2C implementation only supports simple transfers that complete
+ * immediately.  It does not support slave devices that need to be able to
+ * defer their response (eg. CPU slave interfaces where the data is supplied
+ * by the device driver in response to an interrupt).
+ */
 
 enum i2c_event {
     I2C_START_RECV,
-- 
2.41.0


