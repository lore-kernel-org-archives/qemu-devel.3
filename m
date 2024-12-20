Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04967E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjt-0008EC-TZ; Fri, 20 Dec 2024 11:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjn-0007g8-EH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:27 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjk-00009T-DO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3863703258fso2032840f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711623; x=1735316423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvOlQMApDBDzAhIP13yF4ecCm+qCv+xsSCDO/Ma+hPI=;
 b=Kb1itnsytYW2zYrmUd4If4A/ktwPffgenKgGa6iuXVpZ0F+G3C3njnJgWEHlYKF2rf
 FIsWH/oKi1HX0GioNYUT2a9FtmKABomKwlgcZZSVRH2/W3vMq+Xbbm49XZiovfiOVlPt
 vRhdTfigAZjQTThPYVGbI5SV6yKUm7I2zZJlUiCm3dKZbYf4QgAOMU2Xixhvw/vFssfj
 PL89wGuvhzbFnvM3X1MGcFJrIybFi/9nu+tq3yt9DdRAXpL6ydrLpkF9wokKCWB2XTgO
 dE484TmxSQS8muV+bwjT1Oy+U0EZ5Y5RIfGJ6YMMDtuixtKyo79bgyWDatBjRMl01Qt6
 Vl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711623; x=1735316423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mvOlQMApDBDzAhIP13yF4ecCm+qCv+xsSCDO/Ma+hPI=;
 b=LcotOi22HUKAfOyetN1mIw5pdAiBHMUSA1hHJTH5UOhCLvksWi9htT/dB3w5YW6cmM
 cZOtdSNrh/Z47uMeEZdnZ7Qnxf0B7c7T4i+DfFPhcLsZXg1Oa/sBcUt+OW6GqtiqVSzd
 Zhrqc8GcH57zZNrlwPwl/usUn63Dok6O70tAtEAZ+85VNvug/kDEQkUY0065bcZAUUwJ
 Fe8aA2Y1HeGyXaFQOyn2TevEUdeyKYENDvZCuofcPLvMHlJwC3uWCQtnxJK3pdo6Lcgv
 EktvHzBLcAh9G/lhnMkb0nhUSypJKqOH57weSYN3PnuFF0+p2rZrEtA4x/wn4/nooJvn
 evUw==
X-Gm-Message-State: AOJu0Yw0XOUzQ3oGpD/0pCGy6tkryuioAZlfOrym8sJixmv9XfNE/ka9
 K/FxRaOX1hbCdQkWOyZz4TCr92aAGMA0iW6XzEHNL0ShphL6kSnQfs5bEahdd9UWdkjiJ+wgPXy
 d
X-Gm-Gg: ASbGncvqzi88BeJJmNZedJb4yfcAAHIgriG96DjenIR5gYKCPNWUv7tBhXbBaHKGl3k
 Rk6EU2CmNVrx3ATMstStuXvwA6KIY7/ODv5fRIowlv3eLAYqIvc7BzZSwotC+K78jIxi5CqEN8K
 ppNY4X8dm7f9H4cmsOyYG+mfIe9PZB7Q0EzCKU/os/WO67YmK354baiFq/s5PBFGdWL/+zipy8m
 DQjSIXxpvn3gOhMRxen8UIQIfz3yXa/v0Q7bhyN9Zv9Qa1qQtPZAgFQ7qvDV3UoNwVY3DbPxUI=
X-Google-Smtp-Source: AGHT+IGf4ptPck+zkjlU0RwXwXavGCMpmbIWgvaT7oVUlXPi84+AJ5u6BPRlHYQRP6GQzy6fJfMt1Q==
X-Received: by 2002:a5d:59a4:0:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38a1a2641b7mr6521380f8f.20.1734711622602; 
 Fri, 20 Dec 2024 08:20:22 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acabbsm4363424f8f.93.2024.12.20.08.20.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:20:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 59/59] util/qemu-timer: fix indentation
Date: Fri, 20 Dec 2024 17:15:50 +0100
Message-ID: <20241220161551.89317-60-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Purely cosmetic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241218162104.3493551-17-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/qemu-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 16f847ff983..0e8a453eaa1 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -680,7 +680,7 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
     aio_context = qemu_get_aio_context();
 
     deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
+                                          QEMU_TIMER_ATTR_ALL);
     /*
      * A deadline of < 0 indicates this timer is not enabled, so we
      * won't get far trying to run it forward.
-- 
2.47.1


