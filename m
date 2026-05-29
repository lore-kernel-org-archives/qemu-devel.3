Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFABACD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxB-000233-OJ; Fri, 29 May 2026 01:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwg-0001rC-Sg
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwf-00025z-1j
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so95881675e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033183; x=1780637983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YM/MeVSaJhwtKGyY3P/aLx+HM4ZWokNZPtYvohXLnE=;
 b=vR7CiiDp/zZYXe6b2x/VnCEijrEvtUpvlMjog80ryXtunH9NXxzM7g/SVhGYgeSAfT
 Mz5MDJQdIMsL7H9UNQ1qaq8OwWaCXccmggja/nay7YwCvG9MSBj0hdYY6eHAo1LypogX
 82fXEzpN0gprtpuIR21s2mn5bIzwXtGVlEKRMgi5GutwT8wVstRWz1oT5zhgx0oYe/U3
 5NKqwOA6L0vu5BnGguAquGH0VwmSzIqjiY5d5VYgLPf/+cxXRDNp6QI9q6+cBReYSlQt
 kitz7Ot72iIzCP5tRsTVNCLQf/oXQ0+TEQxrbdNJgTgTaPORiGT9TkOjHez6hsLFW5je
 AqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033183; x=1780637983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1YM/MeVSaJhwtKGyY3P/aLx+HM4ZWokNZPtYvohXLnE=;
 b=p9rSd23STDfXbnAfzzYFS9IqQ6P6RTpCNRj/hlGhkdZHB+TiqFb6tbML2/sfrj3nA3
 YBe6Rkt+eX1pueOHtmA/dr4jLL/tCODNf6LU+FvT8RNJWgD8pZ2s+i3WA+NYNmbzRQen
 GYLa+HsQULI3Eq/W97Yfi5VYxUQ9IDLdv8yR5rP26Kob0EdNQjXYVR4SnkTIF/0SUUYp
 MJVwfELPFPqdoDy3vzWOFzBuxXnuRKI7KLGzWJukWR7CnGQAqpPYJWaIITAi5NQPAnj8
 phNVq8fzAsiNugcTaqePXLr+AncoZG409/HBupd1CdR3mcHRSHTUNsry4mgbsvr+6mcb
 A78g==
X-Gm-Message-State: AOJu0Yz9i03yQG9gV5voHQBIvdnLNlUikdQVSo2DWS5P/7BmNj9o2FHX
 A+rYF74YHGB7A5fwGO4DVCq/Y6bOJONTByi1H0MGQZc4OHUi328qpHSnTPpR5gr+vrA=
X-Gm-Gg: Acq92OEgMOwt+RpGOtSUco9TR2yL1MFLe5Mk0yr7OOFFnBws9RQzmbEfUerX4MZxu0+
 yF6ss0q0MbLdVJE6kvOaiDgCHfYcvD/GWplljU7aX8DvGW+kxYmv9YJoehJHngOpH3erDPcUsGb
 KYvL/8Y7IjuABEEUkh6zqqv4qVR0+l4FcIkhDMss0G6Ee7sb6QWcXU2kJ5KNm58uyTCuXiJG0mY
 Pq5z8VRRf92M6olUyzkSsJ4W+83Bg9tTKOhWuOGeAcD8kFTkTlx9ruSFve7kb7e9FdMAREoAQiv
 hKQDnu67bYgCGgriORPaHfPGpMWUdl9arXiesU/ffIBYjRuH0UsQYz1LChkItps+jHwxILDMl2e
 YE6lDcVsKD2zGXt2k4rYbXlXJjxqShCTus64bQRHxwfKMzsGlZ2r2TJUHFAPqP4IoUJtB6BRSgt
 066yiNRahcIkG8dihZtECFFe1sYAgWHp2AfQ==
X-Received: by 2002:a05:600c:420c:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-4909c0aa814mr12464785e9.18.1780033183173; 
 Thu, 28 May 2026 22:39:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b834esm1034676f8f.11.2026.05.28.22.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C0A3360E34;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/13] MAINTAINERS: Fix
 docker/dockerfiles/debian-hexagon-cross.docker path
Date: Fri, 29 May 2026 06:39:27 +0100
Message-ID: <20260529053931.283970-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fixes: afbdf0a44ea ("docker: Add Hexagon image")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-2-philmd@linaro.org>
Message-ID: <20260526110243.470002-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eb5823da61..7d7050f4b6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -257,7 +257,7 @@ F: linux-user/hexagon/
 F: tests/tcg/hexagon/
 F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
-F: docker/dockerfiles/debian-hexagon-cross.docker
+F: tests/docker/dockerfiles/debian-hexagon-cross.docker
 F: gdbstub/gdb-xml/hexagon*.xml
 T: git https://github.com/qualcomm/qemu.git hex-next
 
-- 
2.47.3


