Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3021CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxE-00024n-PX; Fri, 29 May 2026 01:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwk-0001rN-2J
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwh-00026a-GV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:48 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso49789385e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033186; x=1780637986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBnv0zdOKWTOEAJ8eqVii/Y5IF0gp7TLyklv6cp4NJQ=;
 b=JNqovfCzoubuYekELXXjDxw/Qjq+2J4S4CWG1A5MpXgL2jzC+6gvIPPXvUiFKb7n5/
 ZODXyoXtDGR0IoYbtkFy7qQbcsjyqDVv9nunK94mrx0NP+CMIagQj8FPG9OoE3JGHfr0
 YQubHSBPIa7NMTjqro7axp6jHv1amsD4ress6V03Kxz8cf6l/3ugotHuswnu/n4KvGu6
 mSwR94J2OGe7p50R1dzar3M7Rdz+qL7Sm1KpMYkNQJAayRAzE6eaD4QysR5ojvwQrD3P
 ICt0niW8HuSQqL0svf153DnbBAEpRSKTNiMJvD/vG1fRxGvHHSWXKOkbKrxXKrjCeuXV
 9biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033186; x=1780637986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBnv0zdOKWTOEAJ8eqVii/Y5IF0gp7TLyklv6cp4NJQ=;
 b=KLScLATqGkjqNOVDGV+79fVieONIX/o09pgAm1X9ANirgujRKp/wELXEVeMh/kJjSV
 uLB1i18eRxW+GFUgA9BvyfhE0BScR+1K5VDBToKsGD8VUQCoJ8y0X2XVL0slgJj2Zp5S
 8sp4vyIiE6sfRkJlxfgKy720pWozt4Fc1zUd/RrtpRKkIlz6uN0VTBwuewwK5+JD0YB3
 3LCpFLFp9rzjtK/6u3uXeSeNiI9y0HWJvWnwWdG6P8uas3s6MSNE7H9S/hXglxcC/L9f
 TljrGnpCd2uKvZPJF5xzbX32gZIlCE6vnjlU1oIP2DTGsMg8LmS8k7ueu5ciVvyhF8hL
 0ZnQ==
X-Gm-Message-State: AOJu0Yyb39h9jOeX2FKiRmmrZd2A+Enfjo9jD97/JeqyGDVY8eG+nJzW
 rVu0yQlAIR+FpWhc7jywFDop/cTUjyEIlkeR4QViTlwF57uBIquLy4TFUBWifvxfQ2I=
X-Gm-Gg: Acq92OGuhki51/8joRucvVZmHhwhaudLhO2QwxJ/8xxjja6V/QuFJ8X+ZD/3Du1PR9T
 O1hGAqUxOQzo+l6HTd2lFjC11Su0bz5btEmyz4UdV8PY23zNOgCh81ZF2ORLXrloweZu474E3jL
 5F3xdhiG5v5khKWZPLAi/MBLzrgOxZq3nNxJl/5zm5qO5z98Yf9HZKaqfDSS3AQllCGprIwLfhz
 lJIlRswUBCTAwU8T+QrlZuSQoXGRaM07FONwFcw2FbKOFjJq9mrCdwqHSJABOmz7O1iR2DpB6Qq
 hPiUdntSXbtp2g148jFvwmXCsFfxs6pGRtIWsR1nZY5fmMIJDx/lld5wFJQRgkkEJ6p3dyuYrAZ
 K1G0wjbAQImvXlWdLVgc28nbNn6vVEfWRbSRSKxXs73IOsEGxHnjrpAVxC5P8zNGWVkMEDJgLAL
 fnVOe/qj4pgkX+2GU38RM9SijvNCw483XHAA==
X-Received: by 2002:a05:600c:8a16:10b0:490:53d3:4753 with SMTP id
 5b1f17b1804b1-4909c0c30a7mr14980965e9.31.1780033186082; 
 Thu, 28 May 2026 22:39:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6f3612sm14221785e9.12.2026.05.28.22.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F6F960FAB;
 Fri, 29 May 2026 06:39:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/13] MAINTAINERS: Cover python.docker with Python library
 section
Date: Fri, 29 May 2026 06:39:31 +0100
Message-ID: <20260529053931.283970-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-6-philmd@linaro.org>
Message-ID: <20260526110243.470002-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 225bc5e7910..e1c083b3900 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3478,6 +3478,7 @@ M: John Snow <jsnow@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Maintained
 F: python/
+F: tests/docker/dockerfiles/python.docker
 T: git https://gitlab.com/jsnow/qemu.git python
 
 Python scripts
-- 
2.47.3


