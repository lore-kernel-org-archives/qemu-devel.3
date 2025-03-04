Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB882C282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiW-0007Ju-5R; Tue, 04 Mar 2025 17:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpahC-0005Sq-77
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah9-0006Zm-4R
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:01 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e4cbade42aso456265a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127095; x=1741731895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NyoI+xGCkLBfsyhs9LhZ95ONl5hcFB5ViM1AJoAqTc=;
 b=kCYVQHYLF4yWt6gTQLN1cPPHOT3EhV2B7SdtM4ZJqkYy35skY8aD2coMAltoY5LiIc
 +cYLjg6t3QRV/7mPWN1GveHe7QLyQkUZAomiBzQyiGA5xif5CcLYU3gLzALUV6jnJoT1
 OY1wGkrw2jwB/+z5Rlt4hmNS4Z0o0gbAUMC5cURRqmGazpsXZxyYVcv8yNVhcFfdP7H6
 ShK7s9DGLm4nCF5HW3eIWuu6+cIlx7KHLNO1+RdcU1dvaQehqLLXbagtIl5w55sIp4FF
 tAsajpGM4j9FLjrDwOs36Cz/MkReMJ6Mvpph9+liWqRH1gSwpn2j+FvZ3K6PN0LuTb8c
 WStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127095; x=1741731895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NyoI+xGCkLBfsyhs9LhZ95ONl5hcFB5ViM1AJoAqTc=;
 b=vtFTsFtSM4j1lbYfDtLdaNgDO50Gt773QUMWQADJPukzlaoapcwjx+QT1ITQm6MN+z
 LwiT2DPdmkx5zooBpVEyTXdUNSC8rWHInqgVqgIWMwA8BRPyECs2tuNnj+hvg+NjGeLI
 VlVSAtOFnurcGx6Y6QL81UgkGrJQ3IBCaXwUdSY50jr9fRNXRcoxapAsKT28aaoPvBtE
 cfcw2yG/Uh9J5w4s6Ts/Dk8+ULq0/8GKV5O9zUGPBxjoRjjKyb1sFsX2dYK+JP53651j
 Oucu2LO+o0fPZ7+MOEJMNmMse8D5YuvEhtLf+JyE70l2QzCp86P6LBFllX9Sq3q5uof3
 1qzg==
X-Gm-Message-State: AOJu0YymrTRvwMsPjG356Pj1KbjB+Nspw2Z0RS3IBu832Td1IGHMLwfz
 yNAuaAh8LvFFgg/mzlDLenxoc9mUBjRuBCnX2OOve/6pwBbkcHBO2FWxAaeUbZw=
X-Gm-Gg: ASbGncs3a/dSFBGRancIO0ysG8rkWPny1JdO05KLbyMPwit9+R+TZgfnai3LbBdXOM6
 miqjh6CdrcpmgaAbsVB54uoaISToQcoWg3HsDn9ukZHbc7t2rA4jWEehnKOp32JuDgtV4ArzCeS
 K3njOjvIaVE0SEAUp60Lq799LOQB5RSfY4DsY95/zfmbcvritj1DbB3h1MRkE95WUbUQCHjI72Q
 UUeevTeAkGvzrPCBA3w/9I74kMJtgtxb8aEvyYPOggAyaZV4EoUTBVrXuU4mK9md8s7Z5eBa9SW
 P1a3UhNdcTRtvzuHuOdRr16O+D5iOqrBdeyANa0NwMMIZCw=
X-Google-Smtp-Source: AGHT+IEoLkaUqahPuiTfsnd1AlpK136vtD+YDnjoyfwB2GSr+WJ3k3p+EoLXGHf7yEkzSxv4fXRPEA==
X-Received: by 2002:a17:907:3daa:b0:abf:6d1c:8f4a with SMTP id
 a640c23a62f3a-ac1f12c3464mr527854266b.18.1741127095167; 
 Tue, 04 Mar 2025 14:24:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf3f3bbfb3sm777192566b.77.2025.03.04.14.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A9AF8625B4;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 23/32] plugins/api: clean-up the includes
Date: Tue,  4 Mar 2025 22:24:30 +0000
Message-Id: <20250304222439.2035603-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Thanks to re-factoring and clean-up work (especially to exec-all) we
no longer need such broad headers for the api.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-5-alex.bennee@linaro.org>
---
 plugins/api.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index fa4d495277..c3ba1e98e8 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,9 +39,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
-#include "qemu/timer.h"
 #include "tcg/tcg.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -51,7 +49,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "qapi/error.h"
 #include "migration/blocker.h"
-#include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
-- 
2.39.5


