Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78556CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeWc-00055H-Ay; Tue, 28 Oct 2025 03:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeWO-00049a-6s
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:53:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeWG-0007jf-Lt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:53:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4711810948aso41142825e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638006; x=1762242806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4d66WWc5Hpw4yRePBR2zkZh6NCjsXXJl36Dw0QUZv0=;
 b=W1JGPHAD9A4f2UXepcV1q+LvNGoGg1gNVAaweokqCfdv8L966916IO2IhMjnZ8Fmna
 ZvUW/+CUqNfnYOk3GAlTQFvDiGzhe2bfl0GAccIx68n0apteqhp9+YsPtpBH3msuZjLc
 vu4lALWk+Hcsov254rLuDyQbTCl9dYtc9G/Yr1wl1CD+0vV0QWi22XGzaUutayS+AINe
 kIJDf1eizNH3hJYtuPQmFHQXMk7SoqVSCBm0u6shajSTZPc0HE5dPJWc1NFaFOiYuyCw
 8wmMowjxgEyAEjd2DFBA/A2enEoCPmXN/0ITcORKP7w/qW2vig+RXuNw8Oszgw8C9iIH
 C/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638006; x=1762242806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4d66WWc5Hpw4yRePBR2zkZh6NCjsXXJl36Dw0QUZv0=;
 b=Zb0WcNB7Wh0fj6Wv995wy43wHypZAsioo/9rP4ZgAhizC8366bAs0Dx2WZApNjnO0O
 oFDWC8ROQ5nJReIaim/FQpaUPY+4QXYGYH3QQxcplQXp/ayv4wn4DPb1s3WbCM+2ukoi
 3Aqg5V75Nxp7XcJf5FC50xAnkXWvJV83Wyk0qQH5HfL4GZVSadbkX4oAPFIGKuymZ5P0
 10FPLhBCJ/iAwhy6Kt/8U+AC5MEfrf4UIA6zgXiulg4vRYPdjuzXpUVifwbHfyi4Lqzx
 Gglj/LhnMQfnO0VOknZwzHqE+UUFT2M/WNnJ1b+HJq3p2s4oRYjMgb83b9xE6UMGGU7H
 X8hw==
X-Gm-Message-State: AOJu0YyruHSF1ab0a9H3H5VbP+Scqn1wu2FSb+VmRXSq+i6DRnRQO7+H
 AjmDkkU4VTxgvJ3vicO7qUt8z8EtDgBripKxDwqw1D7WjG7K0ZmIk18//8pObIMgYzLTuH5eQMr
 ml+QLEtk=
X-Gm-Gg: ASbGncvbcRjNKZnVhH47TbGV9lx0R0bZ+Vq/LKWU/K1QHa+gBcVC9yeJuOJ4W6SPjEc
 TapkyA95dGdcIjWmFZLWizaDcKVlEv6yfp8HYVYPZplm3vvw2noiPLHN0doDJGoVX/5PQmtIoIK
 koM6QUjTK3PjXlSCHVvQdDEZoDG+LQfh1SW1UamJC2WgGQzDOelWikkcYOZcNeam+Qyzhf38uvB
 fGgIbwWjIcIGcpWs4ishfFChQpDEzx30ZETEul7gnT0HjNBywht5mSvexXgwLOR1YSli33jjJwX
 BXHEPFndk5TOGTMChALlDOjDxE7jApPW0a5XIYmztSkV4pqYUCsDPT61pxbTX0JfCNeP4jtmq0p
 3pHGUyyHBOos1fdLwRskKoX6bAlIipEHs6MQWCQX8CsB09QvQ72HvUo1u0Lb243fFeDHZz1m6Iv
 VjGim+7uMQzzIT6SFVsl2XeSewnPmmeajLM6foWQIM9k3y6KVxQ6w7HeY=
X-Google-Smtp-Source: AGHT+IEgT0B3VI/CsozY+rCH2pFY7krDWXhRhOD+8a3+eHkLuQ4iBewIVhAip0Tx/ZXzlS3gQ2o5qA==
X-Received: by 2002:a05:600c:45cc:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-47717df9db5mr20101135e9.9.1761638005951; 
 Tue, 28 Oct 2025 00:53:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd47853csm182083155e9.13.2025.10.28.00.53.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:53:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 12/23] hw/uefi: Include missing 'system/memory.h' header
Date: Tue, 28 Oct 2025 08:48:48 +0100
Message-ID: <20251028074901.22062-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  include/hw/uefi/var-service.h:50:39: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     50 |     MemoryRegion                      mr;
        |                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20251024190416.8803-14-philmd@linaro.org>
---
 include/hw/uefi/var-service.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
index f7ceac4ce24..91fb4a20918 100644
--- a/include/hw/uefi/var-service.h
+++ b/include/hw/uefi/var-service.h
@@ -9,6 +9,7 @@
 #include "qemu/uuid.h"
 #include "qemu/queue.h"
 
+#include "system/memory.h"
 #include "hw/uefi/var-service-edk2.h"
 
 #define MAX_BUFFER_SIZE (64 * 1024)
-- 
2.51.0


