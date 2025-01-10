Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771EE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEuD-0004tV-Pk; Fri, 10 Jan 2025 08:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtt-0004gb-Nn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtr-0004kp-MZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:09 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1104127f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515086; x=1737119886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3O8tgi1W8PBym6iehaSEHEmNZA7RrFrVsm4HiG82IU4=;
 b=smuVaZGa5ycrEuRo/tQNXYB08MSf5ODBTMJe71E+fhn5N81awbXJ0vc0uzBU44E25w
 momq36VkzRA8WxwyuEMlq6sceCZ+L/l2PHHgX6Cr0H8Y3PqVUHWy36woCml/GOn1taFA
 5c+U9gnlruE2pClKZ/4JDofuLqjnxQkLv2OVmhDJhIPVaRZbE5LSsnIdD2BzRsJ3Ey7k
 3xVNg27epoO0yx2Jm3pLnd6JD/nDpQA68LxF/fWeBB58yLn80BGG2TIAxWC6RL+ktw4T
 pwP0zqt9yL60k6te5nM/ryhBtacai0gvvl6LgxapCjPs3O7SlszQ4qOQH2dSqVc85e2/
 Zrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515086; x=1737119886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3O8tgi1W8PBym6iehaSEHEmNZA7RrFrVsm4HiG82IU4=;
 b=oX72kxdRZ5GMyBlqLK5r2f1DQbqgJztXWyqklDmDiEmfoZ5caaaZQKIkOUyUzFE3g4
 hms0G1MWHsF9v2axRndFp2U/5Gt8Mfu6y68hcRVhxcNmSt1qKvh3F9mjffypDC3Zn3tH
 jfCN4u9xcOQyyXfQd2yXqgv9vGvtjbIAIZWZ4wL40RbOpaKOeTgZexeBQo0PfDuvXmMf
 OL8jiodg5TVkZ86BLhbxYgMNY1o5LRq0+sVTWjR/wHX/HEqaMP3GU9YxthxYyQbADqMr
 xM3uFEuBMgeH4exfoq2gPT3iU+IYqUX1czNs2aiZnLqyMRhrLLHsv8GzWj7x6Y/PsGQv
 AmTg==
X-Gm-Message-State: AOJu0YxKd5wc8bYA3eFkY9yC4CHj5oqgfT7fJ1BlvF96/gjJAey07YsF
 Ua/sUDxYOXQF+HsFJXl6PhrHseapDFvH9loayGlGnHuvfL8TR91AWNg/HC9AOsw=
X-Gm-Gg: ASbGnctap1abK9NcsaM9dTleDO+NU8lDsDH/EkJCokdxVdQrpX5vQI8jpp6vTe/FZOO
 miaFnZPKtBmuA1tLXgVLz91Nr/z50bmzkSRbS5p8CpNd/9/SRMu29Verr89iVXVwa8d2beCfFT/
 7PeDjfm0ewQmBUyvA9ygR9j2CDSMdBIQXb4xDl1lmZB3KdhhddH6BTg1BoYY49A8ztgslt+B4oT
 Lau1VE4+4mNRWkEfTftIVSkEZm4e22aOfSCCwvi8abyqlpTXjtNdxo=
X-Google-Smtp-Source: AGHT+IFe0SelStSaN2IM/oeBAi0qXvlpfjdwGX5HTsst0DPX5+5D2UkDdfy42XM3cTKbWR9BJyJDaQ==
X-Received: by 2002:a05:6000:1a8c:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38a87336f7amr10085098f8f.44.1736515085867; 
 Fri, 10 Jan 2025 05:18:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1f2esm4540149f8f.98.2025.01.10.05.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DEAC8618B1;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 31/32] dockerfiles: Remove 'MAINTAINER' entry in
 debian-tricore-cross.docker
Date: Fri, 10 Jan 2025 13:17:53 +0000
Message-Id: <20250110131754.2769814-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

AMSAT closed its email service [*] so my personal email
address is now defunct. Remove it to avoid bouncing emails.

[*] https://web.archive.org/web/20240617194936/https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-service-to-end-august-1-2024/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250102152513.61065-1-philmd@linaro.org>
[AJB: update URL to web.archive.org]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-32-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 479b4d6eba..7e00e870ce 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -11,8 +11,6 @@
 #
 FROM docker.io/library/debian:11-slim
 
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata apt install -yy \
-- 
2.39.5


