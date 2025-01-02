Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D0AE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTN4a-00077Q-Q6; Thu, 02 Jan 2025 10:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTN4Z-000772-42
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:25:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTN4X-0000VL-Es
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:25:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43635796b48so69566405e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735831515; x=1736436315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dREVW+inmzYDIXhtWOccgm6pnCxwsq77OsJM76BJ9ks=;
 b=Qx7SM2A8wjOpzmLgJ4+nZITZf67Sp/N+NekRmLMgh8j2Ov0PDrDdtBY0yR5eHTPhur
 Vx3FCEODHQ/Tx0G05Tspvy+fxWjfyhgdJ47V6D51sjTmBhljqRGf7WhNDsVgLAQ6KBjP
 NcF+YH7moYHmhGGYSPKCE+s/HQtN4nK5hKNMMeimu3q5TAIhtrNKfFrkiU/76nBhPLZw
 W8emEYGWoY95ERSgKl/ugXymS8rFrrLRDxvC7AVN5LZMKLnSdETHVPo081syBUZeVXi/
 sZp+6ydeCMVkPvJZa8B/oP4r3UCHAKiBesILBK6/F5AtgBxO19PW9AbIzQ4miqPbSz/7
 3a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735831515; x=1736436315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dREVW+inmzYDIXhtWOccgm6pnCxwsq77OsJM76BJ9ks=;
 b=C0qE9t/68eJ7IdsVbrp3SHS8MCKVx9yapUOOOmH4uhanjpmM1w0N6tLGJKimSUQAfT
 KkQmH43XmJdbwuQ8T8OTwwXWaNkTGnocd7dPIgRBCn1Zg58Vz9Rak7E7w81VZVMjOgx0
 ehdovELuHwppSzlCJZGhK/xK6selQuYapcJI6GxpTyhj3mANtMgg6sCuvyPJVoXoLVfr
 Jc9pxfoSL9VOL68/sR6jRGiYB9S7cV0ldUJIYiG6BxxmS6OAnExzUMtBChJpmooVDI7i
 CxN4YV66PjQu9a0Kifv83dJ/q30xop3QEIiSYovfIf8Sby7kg3lOC3XDohXWSZQNKvr1
 Zmdg==
X-Gm-Message-State: AOJu0Yy2PWGvLuicZqVmkve8wTHxUEdoVj6omvzIm07UAOfwDT3f8IXo
 AuJX7NLiXcPDn58HoWA99PQ9UOgvfUEh/rvR5+Pnsiq4STOcT3Ci3sGzNO1SpnyMNNWuGSyyZ1u
 F755/zQ==
X-Gm-Gg: ASbGnctzpNuZvq8hLLwfvqT8Cm0I8nlI2aJZzuBTAxTicG2c+FzJIqQECWt/fAdaqTF
 ywEt6l2AYMxAIPCpT5g9d4wxwKbFmewhjLe48ZKx61QE5vesfog9Wa45e6BvaM6gwryF2aXMXwA
 ZotaIvVBkSzQvtdrq5CSCdvBWR10HGUnhCEtToRQrpCQzC+YgTXqPlMpGS7r1Z/4LTQp2xdZELM
 HDBTm6uY31jkvEYknLS0CAgFvfapvhZgEJ5QpOrGc50SGfm9Kzf1+MFLbTcyTXtKsHSZK0B1yxO
 AsstUStH3V3rhYhTHkb+hhqa+oEBV8U=
X-Google-Smtp-Source: AGHT+IHo/AuaSr8PW2J3jAOcV0Yw6eI4M/+kztQMn0jVhnhBI+96K1Fw8+F/wg3bLwN50fNOmmS9Xg==
X-Received: by 2002:a7b:cc0f:0:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4365c775154mr417799805e9.8.1735831515475; 
 Thu, 02 Jan 2025 07:25:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e140sm39236063f8f.79.2025.01.02.07.25.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:25:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH] dockerfiles: Remove 'MAINTAINER' entry in
 debian-tricore-cross.docker
Date: Thu,  2 Jan 2025 16:25:13 +0100
Message-ID: <20250102152513.61065-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

AMSAT closed its email service [*] so my personal email
address is now defunct. Remove it to avoid bouncing emails.

[*] https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-service-to-end-august-1-2024/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/docker/dockerfiles/debian-tricore-cross.docker | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 479b4d6ebab..7e00e870ceb 100644
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
2.47.1


