Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7790EF99C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxJX-0006Ja-4d; Fri, 13 Feb 2026 12:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJV-0006J5-Gi
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJU-000690-18
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4833115090dso10777565e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005042; x=1771609842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdOrr20jFZY51Y7mXxgCHJFVkE0DMi0TRk23lW75Jg8=;
 b=zYe+1vTQPARf8iijdgsQbrDrC7VoNz6IXFyqN+041N4qTzP6+UEVKgEHCoy13aV7g4
 RXO6pcrYZKdZilBQ056M4nxpU49NLiAnjaHiu4gLxnfpC0gEHtI6gsHfzGcaEWhBPNuA
 rMp4OiAQ1UdgSr5F6U1cI12gk1DVyj78onZ325j9fn1/PTQc12aY6P3rFW9d1JnmN1Em
 N/qYvQsMX6m10k82INhhh2Zdwy4j8YxPC43UmbqNyDnUez5bG+EMfO3qq98DyKSrgKoS
 VWXsqkoVL5IK5KckUpt8jvX9wkcpw/ZdRupy9YsdXB8scAGFiRaYnuJbjLLG29gttnIA
 DQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005042; x=1771609842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LdOrr20jFZY51Y7mXxgCHJFVkE0DMi0TRk23lW75Jg8=;
 b=K/uX6czHr+rUEyJWQD2np1B16323Gr0rd8Acgw1AA2rpTT97kMEskJBqsskLErU0On
 XK+fRvdpWHQ4r+NdlxbvRvAuuoal2WnXtyQhcy1BSoqhYiLeXGUrbDUYTe/KQPoST7lP
 O/OZl/cCDtC+3jS+HHXheEIn9AVr9uRlqxsR+ODkhvwuPplnnuROfo64HCHl8NYXsCGu
 /MsxtSsjHhYoF2kKC5CuYiAoT/9DLVSaWS/Cs11GpjYtYCGZ26BCAZi3IT9ZpwWDxFup
 45a/qV85eWtAspMXlqxek4BWsC+m7gcokVJem66FBdqYeEoQu2HESOIv+NsTYPjKECBL
 n3mA==
X-Gm-Message-State: AOJu0Yz7RYCeVupgSBG9M7xRka8/u34rWtv5XSOHR9vAAtK0ZAbFHsH8
 GaBtqQ/TtRY1yrgNGDIlS7n4vf/X8QySDlVNJmWkRTKnd1B9xp4NzQt86lZ/KSsmFdgnih/gn/B
 2Ye/GdMjJEg==
X-Gm-Gg: AZuq6aJDGE1Y6T5d7uNL4+Gdr4sFM3udYEecUIcDoqFAWzyu+MGRWKrzZXq18w/iHD2
 zKdcAW8lLIK/iKzWZL8gJpxbxNNHKgnb3//EqYKdEnDFIGgQw+3ppA/cO/HJhdzq/O4zs+flGWc
 OnNuTk9ajdd5eIWJJr+9siRWzBib3VpQJ52SbiEygFzXYZJKBwV/R97BfHf4wVuph0KuU8knRPW
 7EOF8OmhUmDM4OBX466F0vBxn/L2hciTSA5Pky8JOUEdeL3na03dve2NYUovUiNHTdxqIR4plG4
 FiFO0Q0zJm3iugv0FhMQCNxySDge454kPDvJ1FgXjsgfyy1fRHzi+vpAM0779cc/ZYuyTPb7fxt
 LTzuiHjs22mwXr1H4HVpWmSEN0b8GQxjTQ3OYNqqEAcA58EdjXIshSrBAejGZ5RiD5W9vxojvIh
 OA8jRtSiTOQXHP7VFe0O159R4vFyesCs5gWSFTH6WnwN6qsdVYWPa5jWVF62S4/GODR9B+B+bTE
 SLAiMsX8vQ=
X-Received: by 2002:a05:600c:8714:b0:483:709e:f227 with SMTP id
 5b1f17b1804b1-48373a749a3mr49827495e9.31.1771005041999; 
 Fri, 13 Feb 2026 09:50:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm265949645e9.8.2026.02.13.09.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:50:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 1/5] qemu: Document qemu_arch_available() method
Date: Fri, 13 Feb 2026 18:50:28 +0100
Message-ID: <20260213175032.32121-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213175032.32121-1-philmd@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qemu_arch_available() is used to check if a broadly available
feature should be exposed to a particular set of target
architectures.

Since its argument is a mask of bits, rename it as @arch_bitmask.

We have less than 32 target architectures so far, so restrict it
to the uint32_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/arch_init.h | 8 +++++++-
 system/arch_init.c         | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index f2f909d5406..92d50ba8d63 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -25,6 +25,12 @@ enum {
     QEMU_ARCH_LOONGARCH = (1 << 23),
 };
 
-bool qemu_arch_available(unsigned qemu_arch_mask);
+/**
+ * qemu_arch_available:
+ * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+ *
+ * Return whether the current target architecture is contained in @arch_bitmask
+ */
+bool qemu_arch_available(uint32_t arch_bitmask);
 
 #endif
diff --git a/system/arch_init.c b/system/arch_init.c
index e85736884c9..d7ec6e69c79 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
 
-bool qemu_arch_available(unsigned qemu_arch_mask)
+bool qemu_arch_available(uint32_t arch_bitmask);
 {
-    return qemu_arch_mask & QEMU_ARCH;
+    return arch_bitmask & QEMU_ARCH;
 }
-- 
2.52.0


