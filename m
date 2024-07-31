Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9D7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9ud-0007y0-IB; Wed, 31 Jul 2024 10:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZ9ub-0007sk-UK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:02:41 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZ9uZ-0003CX-Qg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:02:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5b01af9b0c9so4801553a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722434558; x=1723039358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nkvUdugRpVvDrw7pC/cziIe8qAM/qKrQ6sMHawoV5g0=;
 b=terH2MLHw/OuDYFRa8YKUy3moaHrFhnWR4ot8OGk3pYe6RFKgz7aget51I3ge6AGx/
 eV2OBHvsaX798YCKe0VKz1+i466x53PJa9F3EJDGs+/gUO1gHNd6EOLQRSSuyMVtAz2+
 ZTUVTKyCfC3eyIGbVx49EHHcOxZlFfeFplJ0SMDYzaMhwe+EZ7YM6VEgj/Fw7R16/C5b
 8EQcbwwZBighUrF+3E/u/Tqy9OXi2EPja7cw53pMs0SULhQBn8E8x213qcXWMtzwd3bR
 nz3H1EaB2sS5Yc6xRdHJQ+D1p+qj5GkzutkVtPvk5jKhqFoLzAhitgehmecNqao8JhDB
 tv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722434558; x=1723039358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nkvUdugRpVvDrw7pC/cziIe8qAM/qKrQ6sMHawoV5g0=;
 b=X8UB7NYStHfSKjptdDdjvj2q4nhD7nS/sqo7fU+cyQHpYQcwmiUpUAJig+6ZcXtb53
 dQmIMgJkWku2ut+ZLi5IaoHwNmpGFvDBmUtEaXTw+eW+9XJko2FElAkrEM/CsK+1dP/0
 taotUBKNrQFl0mlHRk6F9gfXF6AvI1ePIhhwWmcPC9O8lChotEGezqAZU6RVEwF+ZcYw
 H22Rl+9exuIgKr+WDQsTpQi4Q6WGaIWuEPjDddKeJr2JzDUm1qp/EyY6mHz+dvTUU5hn
 /yuGWDBJppKekVpzHIY+Ep9p/ZQ01yGzRZEp4FmXTKW6xWwmpWCaEtuAknxY8pKizNxV
 0EwA==
X-Gm-Message-State: AOJu0YwqEoSZFuy1F11VPRZ0yzmTi2RL7VucAj25Pbli7KyLRSJH3yUE
 5r5i08LrNq08hTo4zUrpsIrU7VbmR1xDc3ybOdDCyuadGGPn135RX2ZDhfzT37E=
X-Google-Smtp-Source: AGHT+IH52nFoxMkqNLhJ6fzexAGeS0scErBbY8VL74buEZosOSpgGz3kZlij931wKzO6DZZj0P3AvA==
X-Received: by 2002:a05:6402:13d3:b0:5af:758a:6934 with SMTP id
 4fb4d7f45d1cf-5b01d37bd25mr12968981a12.0.1722434557607; 
 Wed, 31 Jul 2024 07:02:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac631b033fsm8786963a12.1.2024.07.31.07.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:02:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1722E5F8CB;
 Wed, 31 Jul 2024 15:02:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] Makefile: trigger re-configure on updated pythondeps
Date: Wed, 31 Jul 2024 15:02:32 +0100
Message-Id: <20240731140232.22193-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

If we add additional deps for meson we need to ensure we trigger a
reconfigure to make sure everything is set up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 02a257584b..0281a883a1 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,7 @@ x := $(shell rm -rf meson-private meson-info meson-logs)
 endif
 
 # 1. ensure config-host.mak is up-to-date
-config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/VERSION
+config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/pythondeps.toml $(SRC_PATH)/VERSION
 	@echo config-host.mak is out-of-date, running configure
 	@if test -f meson-private/coredata.dat; then \
 	  ./config.status --skip-meson; \
-- 
2.39.2


