Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE404C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Di-00023B-Cy; Sat, 08 Mar 2025 17:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DY-0001sR-OI
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DV-0001wL-HW
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1067856f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471218; x=1742076018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqDlQYCqhupxKJJPtcmqNG7tXptPuoxq/pLFDrIkSjc=;
 b=l/ST9DRuVinHqEM8YlAXpndo0+z4kzxiBICn6LvwuXFZ/6DiFS66NknhHbroqB1342
 7yMpt7A3xpRj9A7zqRdvi0Vwik7h8yzaHKS5h210fbeOQkZttSVtT0Cp3NSr/SusOJsB
 kzqu7MxFZJcTwtA6xRYb5w5rQWhA7ysDn03UUSBPcVDJudaNzq8+XCO9DLjTV671lElZ
 +YX/h8Sh6t+KpoJFGh3J8XhNXTyzIsuJM6cj6Es6AiUIA53n/3GMFGoD7aQJvzk3NNHg
 rrAUiR2w4aLix6Mvn1m9GOhwe4nYDJObDYAQWWysA+8lWNskzm/rucYPZRU3v8YrBEKL
 Z3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471218; x=1742076018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqDlQYCqhupxKJJPtcmqNG7tXptPuoxq/pLFDrIkSjc=;
 b=B+elSzM60gTN3SW3gqvJQepHV6Ey6eaWi4X6tqhPanc2GNhNtUd6cTny0Er/jk5pl+
 FJrysKerGz8mkZXbZ12NCAsri8FM5FxujyGng92KAJnDSsY1PDt/x+F207IzARGA84rl
 SILQZMIgzrrtlyv0mSz0qN0lI4TH3I225ktC0pd9BlPgxq+lh5BQCdFz0DzAMLrCgCXM
 KeO6gYI0QbN1zRZb1Ye6C3xbnSwlOhygW8PQQGAONdL88EVe7OJppxjW9qjyFlV7ntI7
 XRV/FJpT9UilwoK2ggPXfyVkIhPMXWT/z33F3+VKk5vDF3ZpK1qpTdchxkDpXPHU00DB
 tZnA==
X-Gm-Message-State: AOJu0YzZ+7g9IGUcuyBUcdJGbtn+MzSBlqcOFT8GFrLpd9tXr59PlNT0
 45inG7vzlNpJfsqkwt7rhERcrPhd8KfZobmnS4Q/5Uqr98/7uqpOkMHoQ/slnsc=
X-Gm-Gg: ASbGnctv+6bZzBQXQoyexgu5vXKEMBRhp/GThDK+WEw8rHPUetE24XVEpUnZvcMIM32
 I1OkCBxa1OuLX1nDuFS0dnySX6EVX54AmFcyCimQ7Xm8lfksrAXfgPpRjEHgXgsLzj7dIGg6Y79
 0aJEvo8lWlQvNuknz5go7USI99NCAMV9xQbWbP6o3Rln61XJXaueo0cU6Q37dLvBzih6NW2WTGe
 qP6hq5yNrsIvh/VzaxG+BIyMhHWq4lz2lvcRhtea/8O8+fPqEoaS6UKG6vp1bb+95R6n5ojGSoJ
 /qldIwUDUemb9w1RUujRtV2aaDCGiGvlHcTVHig5m5+xvu0=
X-Google-Smtp-Source: AGHT+IE70r5QY9IFyqqk61IGscweum2nEyZO7A5L9TobNUdGg0aI6AE6Pu2EUwh/xg3F4acLeo+LzQ==
X-Received: by 2002:a5d:5f89:0:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-39132d671b9mr4912145f8f.1.1741471218410; 
 Sat, 08 Mar 2025 14:00:18 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfbb4sm10130791f8f.30.2025.03.08.14.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0B6F60925;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/31] plugins/plugin.h: include queue.h
Date: Sat,  8 Mar 2025 21:53:19 +0000
Message-Id: <20250308215326.2907828-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Headers should bring in what they need so don't rely on getting
queue.h by side effects. This will help with clean-ups in the
following patches.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-25-alex.bennee@linaro.org>

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 30e2299a54..9ed20b5c41 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -13,6 +13,7 @@
 #define PLUGIN_H
 
 #include <gmodule.h>
+#include "qemu/queue.h"
 #include "qemu/qht.h"
 
 #define QEMU_PLUGIN_MIN_VERSION 2
-- 
2.39.5


