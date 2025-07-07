Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69451C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpPn-0000XQ-0P; Mon, 07 Jul 2025 13:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpL9-0004RC-D5
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:09:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpL7-0003Fc-Nm
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:09:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so27994535e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908147; x=1752512947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzYBiXGBkeYw9UopV6mUMGy7OUJhoF9XwGPWfd7ubgo=;
 b=cl75LTRFK7hD3VnRFMdfDCQoJuAIuF0jFrV1YbIQRcqhWUjzfjROSs41qq0S0CEQhZ
 /v9IowTqIZkG9BdNE60w6jzlMFJjhtioiOl7MEZwPIdT8hfSch3v7XcIwzkkGw6ouXgS
 6F1dmq+xgaaU0YQFIqYynTeK49b1pKUL2j+VJWAVEckXinwXHTQ6q8cpdYz81VyVug7T
 OBeEOfRgD/ZexLrh5APm7sJQxiX5pj/Av4AWYj6U1SjocoM1+FO1oB4t7Wwru2yFQBvg
 /Yxue17cFz6fIzMMtgWRw+xz9zyKqQBzOIjtSwxefN+mE1Oh8ZBO3afdVgymZycpB4fW
 MBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908147; x=1752512947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzYBiXGBkeYw9UopV6mUMGy7OUJhoF9XwGPWfd7ubgo=;
 b=teKXqnsEXjxN3k5+uW0VdeUh0GcYHDEsro5Acws84OSEaMUHBaKrPCX0eGksm13uia
 E9DBxEwdhSHjvnn0sPIsVYOmV4QXDsCOYd9+NwiljVaXxeb+ptmtMzN4ge4nYa0cEwxo
 j0QBCpBObgDi5OiuKeE/kV0S1OhBshAiZqBZQHHeliTNONpo3odl9i71HzwOScLwISIi
 df3C0ma9dUef3I/f9MVlYmAzrbFOFcxHUgp3wod/mZLv2D9TkY1YucXa9WqbwVyLfVhO
 DtTr4/4/yInk70C0eYTHfKbMJhmZWl0IHobFHMFzw2OSKSFkZwPYA7TSe4lSNkQgdouE
 dPcQ==
X-Gm-Message-State: AOJu0Yx43lr6yYcjPe/YlOjpA5ZsJTmPEotTnrQwIk/UMB7XQgL/pMzL
 Sb7XD0oSu8EtHNVUyxghmZ8QMf0fnBYBleHgQ03H8qPntaRo1JtY9LPXy37wlvVilX5gfP4arux
 wTeF4cWE=
X-Gm-Gg: ASbGncucUjovrXEoQWNNSAW3GERC6ilvW6LNAj9N9p4zGiMc63sLKF4Xf56WUqEzPhS
 P8c5IIHfpiJ81/PyjGmz9y/MCkX+1XZOv9sygFfe6b1I0LVlogue5YE9DwZGErcQIDEjUVS3koY
 AddiUugVQ5b8wNWUjjNgLd8eyUH9tzI1tKMJoE5q8uVZe3xNKEsas7HXp+eSgVZ97/QPxMqdzpE
 FChrbUMzz2hS6+yb4fnjoZdHMesvUvaESaURyVPiKbxatLsFcI8fi8zbSPfne1Tj5q6pQjej+6h
 3qHgMP9gKUZsV+ALQSmY1drvwe+RzjGq3xAu7n3m9xqXotUSOQGQNGoLQa71fq1GmDbvwx3FVJY
 yd8NAHxF2Tw8P2l4L5cCzofkaQzPTLtV6UB2/bBUd9+MhanI=
X-Google-Smtp-Source: AGHT+IE5+n+DGtsY1vwwdhb7OmbeIE1Z/IwjSPsE5vXYqgDBDMgNe93gBpYRxZXUl5gefCqpcmiUbw==
X-Received: by 2002:a05:600c:3b01:b0:442:dc6f:2f11 with SMTP id
 5b1f17b1804b1-454b3169103mr116487965e9.25.1751908146607; 
 Mon, 07 Jul 2025 10:09:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a642sm10624995f8f.80.2025.07.07.10.09.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:09:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] bulk: Remove unnecessary 'qemu/typedefs.h' include
Date: Mon,  7 Jul 2025 19:09:04 +0200
Message-ID: <20250707170904.2908-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

"qemu/typedefs.h" is already included by "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/vfio-migration-internal.h | 1 -
 include/system/os-win32.h         | 1 -
 hw/intc/loongarch_extioi_kvm.c    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a8b456b239d..00e2badd889 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -13,7 +13,6 @@
 #include <linux/vfio.h>
 #endif
 
-#include "qemu/typedefs.h"
 #include "qemu/notify.h"
 
 /*
diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index 3aa6cee4c23..662cfabc5e7 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -29,7 +29,6 @@
 #include <winsock2.h>
 #include <windows.h>
 #include <ws2tcpip.h>
-#include "qemu/typedefs.h"
 
 #ifdef HAVE_AFUNIX_H
 #include <afunix.h>
diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
index 0133540c45d..aa2e8c753fb 100644
--- a/hw/intc/loongarch_extioi_kvm.c
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -6,7 +6,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/typedefs.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "linux/kvm.h"
 #include "qapi/error.h"
-- 
2.49.0


