Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE4BC3601B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTv-0002Li-61; Thu, 03 Apr 2025 20:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTs-00027k-MO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTq-0002xA-Fr
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so13750165e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724816; x=1744329616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwOev6P4Yow8Jn5q9PsEhT1CQP4v/3jic2jASXzU5CU=;
 b=Tyn9QVV5jN8XQCO9xVOy4obhcmN7eAsP0iO2zIjP41VtqUanQTTXVGaO7mjOM+0RxD
 aVKr0y9lcQ9qLpnIj020EK3sclpcqcguvdQrtBD49OOW9SeOeuGkkFwGha8u9I3bfD4j
 zpDdjFdEV8RobuUtOwn6RJl9oJPNHGSibnCCxRUZUHIT/u6XSDsZz3Fe4iO2UtkfMUOl
 j9AKVFVYiJ7cQYsAklyZ9La60VLCrEY++8C7h3DVB8VaT3stPaIFFxHV356ZwUltB6U3
 MlniadNlDM23iviSnC0YkDhle7LrsM9rnzis1kHOVyarvrCCh6vzyuYtroGil4s1eQ7d
 tU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724816; x=1744329616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwOev6P4Yow8Jn5q9PsEhT1CQP4v/3jic2jASXzU5CU=;
 b=Q5xkvL+jyiej7Dgg0xdfXX1jAE7PVOqHMyLtm3JpAFULth4gFohsQ2/E2z49vFCWSA
 ZzoEJgHySs0wf7YhA28sdTzeHO2E0WKquUl+1c1ND3gYlNHOFn2eggHRd7Y9+NgpPFMR
 rXLl8aX/WfEBOT5aSM1TFfEUnk4V+QZTohWPCe2npy3g3A777Sw8Da8zJh+IUtFfTbvz
 6U/L23p7nHSN6k4Y2PweYJGwspAuCtd1Zq6KHa0ulxs2bEvCqV0cr15sgzAleHWYht5p
 xpxZWwE2mhegg/kBcjkuoCy42mBboTYKZsKMe44wkcGrZLJN8QxYREEET2pQ3Z0N83/W
 tT4Q==
X-Gm-Message-State: AOJu0YzGRw4Ado9GKwk4LxD2sFkU7vOEwYLqgIpO7GvEfItCVLVVE62Z
 LFXA6e9onDUsYbR2jt5PDy+6L/65Add0hPhI9Z49F2zDQO4euh3RZDvc64Qe8ERlMqHO7ssNu5K
 g
X-Gm-Gg: ASbGncvjfh5Y9ml82zavfYqHfDlf6RQLDwZ9n7rQr7wqhFgZQdp8nGOsOFBDynmvEA6
 8Ut5ZWSGl4uAXh6KWBnWE3YwUG1P3A8C6kFHRzIcQtLzSROywLzP1kfGr8jZI9J12/F0hay+ybL
 N+GIJAKhjM48E4Ln3RHP9FwWd5R5cL9Dbnfh77ILgQmKD5i4ySPg95j51bgW4RAtk+qtxVaxybV
 9QOr+BBMvSpncZ69LxbABlg3wCMZEicivX5+O7fXsnPSYqFDsQRQQezzsLOBrkmQ6pXhACAi6fT
 mG1lO3My3EU6+CeEkzIkjtmiJMpxfXWfR0/lEsjt7RVM+f0VcT148OdNRDfisjkKjoIvlMKItXb
 +hYTD4LkgI/dgz5LDvK4=
X-Google-Smtp-Source: AGHT+IH/k8vX4W3YTcxTJkf5HmxAYk5wm4jnsFhfY84cUbVn3ObVkQeK18YQU35AnRD64PuDGPcphA==
X-Received: by 2002:a05:600c:500a:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43ed0da06f1mr4398285e9.29.1743724816532; 
 Thu, 03 Apr 2025 17:00:16 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1630de9sm34052135e9.1.2025.04.03.17.00.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 17/39] target/arm: Restrict inclusion of
 'multiprocessing.h'
Date: Fri,  4 Apr 2025 01:57:59 +0200
Message-ID: <20250403235821.9909-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Only cpu.c requires "multiprocessing.h" definitions so far.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 1 -
 target/arm/cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3705b34285b..1a1ae229e1d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,7 +30,6 @@
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
 #include "qapi/qapi-types-common.h"
-#include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b1aa482c726..6f62745d7f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -53,6 +53,7 @@
 #include "qemu/target_info-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/multiprocessing.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.47.1


