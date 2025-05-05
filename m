Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A091AC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57C-0006Rw-R5; Mon, 05 May 2025 19:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC575-0006Kg-Bv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC570-0003aA-TN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c3407a87aso74553305ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487237; x=1747092037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92Ra51BscJ7plqFLljDp4Imt4ck5QTPqHgH4Y/GteZ4=;
 b=edBBpE7CLIPQUwNsRl7XpJ4i01E1ejs7yCoeNTiVUhOX4fm+21Ue/9uN0/BdDVirV0
 zrw1GVi0Qiw1LYV1h92euw58xfBj5Tvgr7iJASIs0yHRWAKTtMiDZ/l2gO7tU7szKZLD
 cuAx48DZxbZMzgZpDfrOVI5B7jMDDsaT+IG8Gcl0ZM8pvygsd2WWy1U7qmLXEUH8xwqD
 bAelVLdVNyvAcZynoR7nUkyEnHLUmYn1yomTqMN+hiv38/UbGwJadWdHucID9YqOIAyT
 a0sKyxHD2cM4qv2kYmW7d/YYxNkwpjR8X+RMEC2Ihoy9WKRpI3TgGYdDJ1bNCJb0wHkC
 TXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487237; x=1747092037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92Ra51BscJ7plqFLljDp4Imt4ck5QTPqHgH4Y/GteZ4=;
 b=SVEDk95k2zqmw4AHUxLVE8vN/0URjUGFgI8DmyZenUH3sEwTUjM5KrXZddMJhGDJcR
 aB7FBEBNashy2QLTk2gZfszNa78kH1rSnddb22xpgMXfUS/gFW5Hw3rGSQt3sIoOmA7E
 Vc9N9+JAXeEzWAet81x0QUvMCvoiiRB1FMMPghdNytOw+2aMoGa0kgcMFnKefPm5IlTe
 biuOn+AphNl9pJPpV5zD2tZkp/QszCpSMIcKRYojykZh5F3u0zUFOZ2X4cmbobHnkHAd
 PYJ5CoHVAtZsMzZSodCv6i4I7R1dRmvc8B9p6BbadHK0OxqpTgqw1CpbtkN6YGZ/6i+u
 7BeA==
X-Gm-Message-State: AOJu0YzaTnKZy7VqONz0gn+cXmmBg9HnPAjEJVPdi4KLPbb4nYSYe/ZY
 PnOFtxJJvmYYmE8cKCahzlutnTlf4fgoMPp++goWAo3eZfjlGrIP9gF75qyKnBv6Kbn6LeYGhhe
 hLb4=
X-Gm-Gg: ASbGnctrR0lVMcj+gmdl3a5mxfG1lBC+mo8dD2VrAWwlJhqsxfhO6nRAO9mFLOw0r7F
 ApYDn0YoaDq8F3min06mij4d/b6MA3E6hNUyt6TdWF/2jiN4/i3Ekg4FGS+EL2CWnue894JvCJp
 AvzhjMvc2UQS2++s/7gXQ+6CYzXCNq0quOaCxZ5O4xDmj8dthjdRaRtudPDq2KjQRVZG6VZyOmA
 4o3UOer+j5k8Vq4PPqgqza0IjPYtxOcijdyzUR/w/RsUNzXRSZSgeZTM36+wI9BvSf6ny+hFaJY
 F+K7IY7ZvfGX5z5nA8stEaFL4X4AaVvyyf0Epo1K
X-Google-Smtp-Source: AGHT+IFM1gtQ3Hr3DrzoVupUyM2ejLDN/ZtwY19Upapy3xbv6kMXCNmsmDwbwB0aXMOyoEqCYaGquQ==
X-Received: by 2002:a17:902:d2c1:b0:224:179a:3b8f with SMTP id
 d9443c01a7336-22e1ea583d3mr125469395ad.23.1746487236721; 
 Mon, 05 May 2025 16:20:36 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 18/50] target/arm/debug_helper: only include common helpers
Date: Mon,  5 May 2025 16:19:43 -0700
Message-ID: <20250505232015.130990-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 473ee2af38e..357bc2141ae 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -12,10 +12,12 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
-- 
2.47.2


