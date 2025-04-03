Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE1CC36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UV3-0007oZ-Pa; Thu, 03 Apr 2025 20:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UV1-0007aT-Df
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUz-00039Q-MK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso12660095e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724888; x=1744329688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM2BxQyjnLoQLlMglcehWA2bp4eedPWYnDzobwKNiRE=;
 b=JQHcIaYF+KMfcgQ9dcBHBz+UOmgPEX602VgjmOqQqcsUwjfFKXeJ3T0NI4cyMNd2fC
 Z39ollv/mGUKrGTO0V67ipcIEHD23xE8wM1SOskpy+glTN06MBAKRF1Sd3ZBTo9hI37d
 s7JKrpDDGCo1MHPLRoLLExt5kxZDC14NjNW81XgsBVltRmY9TDI1slnmt4+W9nq4Y/5u
 7lXLxu3NjKr4tnSr+14C/fl2rtERvz8kDzjByDVlNwFOGJcCMTI7wLnKzCta2V+gLtI0
 WfhvcyFmmEE9ueIdiwwYVpQdi8CHOr7INHg5GistkJSu94vRgMteTKuZ9SogeCYvVn6o
 143w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724888; x=1744329688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SM2BxQyjnLoQLlMglcehWA2bp4eedPWYnDzobwKNiRE=;
 b=VAnC5/eTSKcFxazcPLvKrrukyybw5eozVsEyEAV2mLjzmJqXwgGD3Igf92rgz3SoO+
 6UupC1J5Mq1Gw4bYzvM6N2tWjJk6cA059yjjhL922/X9eBZ5F3a1aLN3uNS88H586zLI
 m8uFrkGHEytOQi6Qh6J+FA2YpwfpvD2e6ObKVz644raINe/keQbPIksfUIleQxi9qJuH
 JjwhPAobX/6mQPGv+LE+oD2KDoVqU82bKqnl9r3bZ03M30oOj8sNhP739vo3Nou+8QYg
 gsnataS3YzTdXXR4D5ot6w2SJIIh7+ETv/eBfHT4cjm/YIo3lhJZxLqWM81c/nZCycFe
 WYYQ==
X-Gm-Message-State: AOJu0Yz3WCKDYGMJlEMfe5kXbRIxrDOLKeidN1wuBrg1XP4Lh91FxlZh
 wZNGKUkji1kIY2x4jTK7bBBxfJiLC3b7YXRpusQfNj13bImI3IuJgU2HuXgqG2DqI2ZyF+hko6f
 b
X-Gm-Gg: ASbGncvURER5kCbeTAmGCh7q/EjHaibq3kfk/6RooKlZpQV9CwIC/jlnxJrxSLNPYqm
 +XOp/ooQgnjPbYOGkuDwGYmYDex+MucKluBebCi0R1BwGqgb3Dmy9J4RMA44QLfaNvPD+yOehIE
 rXEwsUqPub68zDQRuQR/Pt3CyFLB8NBgbuzwy34Zy7sJC4glz/eDjmDg9xm/vI7wDkBuHsJkein
 hVCr9jSUMpYB1gAvmu5E8sqYC/ItARDO/r34w8d+Bc7Bdlayb2qHgUZp30eEC+2AA/MAK5YntKR
 6yoyoIkxdp8k1Xtsm/zHVn7U6Jdq8BLy5OJ9wusmL9Xs/yzgWU5inmt1IJ6GBENnblmq5grFNi7
 /OP8Uc/OBJDBB6P0PNp0=
X-Google-Smtp-Source: AGHT+IGSs8+dTRiSroPa1Q0Gvv3P2Q4ZfVdDAUjiAryawRq6fipDkPUYcNaEAuLBMDFJBjtlGGdsSA==
X-Received: by 2002:a05:600c:1c02:b0:43d:94:cff0 with SMTP id
 5b1f17b1804b1-43ecf90b092mr7223025e9.19.1743724887935; 
 Thu, 03 Apr 2025 17:01:27 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba2dfsm2999339f8f.60.2025.04.03.17.01.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 28/39] exec: Do not poison hardware accelerators
Date: Fri,  4 Apr 2025 01:58:10 +0200
Message-ID: <20250403235821.9909-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hardware accelerators depends on the host, not the guest.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/poison.h         | 4 ----
 scripts/make-config-poison.sh | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 00aedc41d82..0574d683f6a 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -62,11 +62,7 @@
 #pragma GCC poison CONFIG_SPARC_DIS
 #pragma GCC poison CONFIG_XTENSA_DIS
 
-#pragma GCC poison CONFIG_HVF
 #pragma GCC poison CONFIG_LINUX_USER
-#pragma GCC poison CONFIG_KVM
-#pragma GCC poison CONFIG_WHPX
-#pragma GCC poison CONFIG_XEN
 
 #ifndef COMPILING_SYSTEM_VS_USER
 #pragma GCC poison CONFIG_USER_ONLY
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 2b36907e239..09d2384745f 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -8,6 +8,10 @@ fi
 # but filter out several which are handled manually.
 exec sed -n \
   -e' /CONFIG_TCG/d' \
+  -e' /CONFIG_HVF/d' \
+  -e' /CONFIG_KVM/d' \
+  -e' /CONFIG_WHPX/d' \
+  -e' /CONFIG_XEN/d' \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
   -e '/^#define / {' \
-- 
2.47.1


