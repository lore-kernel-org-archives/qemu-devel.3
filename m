Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B23C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWR-0004jY-Dp; Wed, 12 Mar 2025 23:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW8-0004gJ-Vm
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVz-0007ns-5z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223959039f4so9368705ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837543; x=1742442343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzbzPzlNd+PWpDZmz+vRGOcXw51DO2ZIhjrLL9kjlLw=;
 b=FhPJKs62CSks1DSO9MNQ/0zGmlhc9nWLPFqbbWqkx/w1jf/GKNXoOcxZd/TufEFWAR
 iTq56eoDVjuoVg8MvxLn+EDNFwdPwWI37Lv4wpRyhaJ+I4abioc/332LcriFxemQc5Kf
 OiXcaKcJkQWwGrYseMXaM669jKfsTkVH1oDcuZ0dY/uRuyk2m9gOIA4S0vhoPl3DaNlT
 wtmbU+GkLI9vvkbQ2fQ9dodQ6S0K0SDh73gGLi75hgVfLuFEHjiv/vTQJ0lUioEYjbe/
 8/S5aMLTOittkJlDFKH2N3WHrK/UWWpzcjEsrGlYVpD0X0SzsasfldIQqlUUhn3QIzKe
 VdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837543; x=1742442343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzbzPzlNd+PWpDZmz+vRGOcXw51DO2ZIhjrLL9kjlLw=;
 b=VoNWrnKEXw89PFmojo5f9eAcogXKnmJ7L/T6GLCiKMdJHGo3H6Z6qdZVXoxgRJm8vZ
 US4so4/9Inw4CP7KcDnIvffFEXeiOdiGu0a31Fwm8dN1lwNOJnESmE0lJdAzGyNSw7pM
 OYHGf1SuhT6iXKjzyY+IxQ2LN5nctUh6Nr4Ae8wXltoZisAnKXYp3JGtq7YPjRfyjQzu
 vxZqfLH8VyjCLWVD6bnDlAjwYzxAe03sjuYNH5kGcYOfwUSIObrqEL5ohPLX2eHg6FHD
 7S4KNo/IPrUskkEw1wefZGSwEws0qsMaXpSvtyVezXa41gKRak4froZj0MfyrgWFhbBa
 PouQ==
X-Gm-Message-State: AOJu0YyItmNEJwwopX9p+VuzsDqLdcrY7mh3V6hDRCDbDl5UhJTlTCwU
 nYz/wjqL3hz3cqIEFm4OuiB6XmCJzcZuSnPT0q2z4Q2bNuE26IrxH1+GHMsY6VROWsWl0eLPj5V
 D
X-Gm-Gg: ASbGnctT2NV8HGBsaEw2ofG+ZJWPd7UayBZaN8hEWE6qXK/cAKxzDvyykvEYZHThceA
 HRF66h+dTqJzfTvm69fg2UXX2rk0Sxm+8RkQsSe+9WDUGxEs/q0UwXAq+6YUvhTRboFFLsXLTtX
 WkgsYb9X84gqDzHyFIaC/g+ukqTszfPv0vOrD5HhPwasyU1XrY47oTv73pBBlgEIJSHiuqvVvzF
 coH0MjjzBKM4TPp9ksJYp3OXdS31fnwDGQg+YwGzPir+QUEaVW/SbdSUGQBYJk+nQpZU34JByYs
 FpVxlPuTuWiWq65qNt33I1cDSJxVp2uzDQ17tzE1yZ494LgdMmQhtLbmvQWMNIt57inL98ojBqa
 d
X-Google-Smtp-Source: AGHT+IG2ofcjK7KBPizXvoScrKlHtc3ulAh9SUibvAZ9MWd25ndTVl9NyLgZbR6CU3jYJMb0VskEnQ==
X-Received: by 2002:a05:6a00:8285:b0:736:fff2:9ac with SMTP id
 d2e1a72fcca58-736fff20bf3mr5140582b3a.23.1741837543271; 
 Wed, 12 Mar 2025 20:45:43 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 21/37] target/xtensa: Protect semihosting call with
 CONFIG_SEMIHOSTING
Date: Wed, 12 Mar 2025 20:45:01 -0700
Message-ID: <20250313034524.3069690-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Semihosting is not enabled for user-only.
Avoid the test for that case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4f02cefde3..d13d05878e 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2241,13 +2241,16 @@ static uint32_t test_exceptions_simcall(DisasContext *dc,
                                         const OpcodeArg arg[],
                                         const uint32_t par[])
 {
-    bool is_semi = semihosting_enabled(dc->cring != 0);
-#ifdef CONFIG_USER_ONLY
-    bool ill = true;
-#else
+    bool ill = true, is_semi = false;
+
+#ifndef CONFIG_USER_ONLY
     /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
-    bool ill = dc->config->hw_version <= 250002 && !is_semi;
+    ill = dc->config->hw_version <= 250002 && !is_semi;
 #endif
+#ifdef CONFIG_SEMIHOSTING
+    is_semi = semihosting_enabled(dc->cring != 0);
+#endif
+
     if (ill || !is_semi) {
         qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
     }
-- 
2.43.0


