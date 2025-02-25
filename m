Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259FCC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoE-0001aZ-FY; Tue, 25 Feb 2025 06:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso3-0001ZD-Qe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmso1-0007li-Fk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4398738217aso47551285e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481732; x=1741086532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6nrshHrtPOrifsqr2VPAodIduwL/dsvQHP+KKR3e9Q=;
 b=Qd+PHosDoUPTLA0LrrOg88tAwOlRag5Gdeghxg3TJp38cYHvxdm2JjeAASA/h/+4bV
 eWM/8Kfg2ZLZVyvI5JieyyH0aobqgnKO8m7MlQDIXw10tlbYRBdphfSBJY6JZjmFyuKN
 PD9Sal/XsqIvSTrLkCxVC3XFhOeMUqIAmyHX6mEtuNhzxDBmUaUtFx1sTH/uTCYuvDO3
 lbf0RJS4OWxlkeY9EDjKus3r2SpPxEEiYF18iQddVtdM2Jdpbxpo+s0OOBm+nTQvPnKg
 Bk7Lb87CJp3+J11GjaU/Vl0I+FtVLKI0KnQYPdQB1x2iOixlTWazOB/2P0ZSqmwq8tbs
 3RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481732; x=1741086532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6nrshHrtPOrifsqr2VPAodIduwL/dsvQHP+KKR3e9Q=;
 b=N1DZafL8hcGaSqSVHfO7Bm5SWX1eWZf4uaoSWRHijPq6bl2GTKS91/6rxjgkVLy/DE
 bWPGgs0dvUAv8QSIIHCXT9tGOp0XNKayL0Bl4WOJAUuP61XHmazBCTFWyZ4DJFFtppn+
 Eg8l1Z3W1tPt5BTLrtnHFsWlNeNJoSzmEWiGtlmGsTIZyu+Ea/MLw2AKtexZ7CBLc4w2
 nZQD/LnSC0HSJKix7r2U4fulvP3E498C9xVnVznXvX7TX53rXKZ80daZcNPL53IndH4C
 iA//oXAS0eCt2WXls95wfziZ9DbeCo/u9mQSSU7ya3wlW77MNDOenh/3fMFndMq1PcLe
 e8Qw==
X-Gm-Message-State: AOJu0Yw8x/DnF1CaMSnp3ki/y+6WgE5b13sPBLlBp7av/1PtNYQani4Z
 j0dQZabHe9+hsNc6zlcBoaELw0uGhDuVbi40IDdXZ/bKButKb447jEc7ydhg910=
X-Gm-Gg: ASbGncuPZDUBtHGKO4qg38vNBkL/2ZFdEjPm2CNpg1AvE/naRt37lgrx7VCL5xfxoyt
 dlv6fiZeb1pdpHUrGeOOlHpReKgSVoQRlk5dRZiJncGma7mVbcvvEJMdXjOPmvm7tBe925xU6mY
 WJzG43hlg1YkWeNFXwreGnFd+dI5zR7eqRxcr7P7Xd7x905G2942qIMO3X/CAc6wR5aO6q0CKmk
 O9YfrUhMLy32sZkqpFt/Hdb2DGAAUDKvCJUV2IfQOf4JHfYwOYH2QGwAiMM65pvxdGbHbzqc7NG
 HHbeJNJkOs+UQS7CUEwY40YStLaT
X-Google-Smtp-Source: AGHT+IFnqMOXSdK5At0p4ylKCzzCcWorQhf6UEgx2/pvCSED9HGox+7amtcN1Cb9mjbMnAHdJmbfqA==
X-Received: by 2002:a05:600c:4451:b0:439:8e3d:fb58 with SMTP id
 5b1f17b1804b1-439ae1e6dcemr155006875e9.11.1740481731887; 
 Tue, 25 Feb 2025 03:08:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f24acsm138006895e9.21.2025.02.25.03.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E24761A5E;
 Tue, 25 Feb 2025 11:08:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 10/10] plugins/api: build only once
Date: Tue, 25 Feb 2025 11:08:44 +0000
Message-Id: <20250225110844.3296991-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now all the softmmu/user-mode stuff has been split out we can build
this compilation unit only once.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api.c       | 11 -----------
 plugins/meson.build |  3 +--
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 61480d3dc1..a292b5bff3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -45,17 +45,6 @@
 #include "exec/translator.h"
 #include "disas/disas.h"
 #include "plugin.h"
-#ifndef CONFIG_USER_ONLY
-#include "qapi/error.h"
-#include "migration/blocker.h"
-#include "qemu/plugin-memory.h"
-#include "hw/boards.h"
-#else
-#include "qemu.h"
-#ifdef CONFIG_LINUX
-#include "loader.h"
-#endif
-#endif
 
 /* Uninstall and Reset handlers */
 
diff --git a/plugins/meson.build b/plugins/meson.build
index 942b59e904..d27220d5ff 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,9 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c'))
+common_ss.add(files('loader.c', 'api.c'))
 
 specific_ss.add(files(
   'core.c',
-  'api.c',
 ))
-- 
2.39.5


