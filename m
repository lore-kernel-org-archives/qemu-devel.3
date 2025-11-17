Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5EECE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvIN-0001Ta-Ad; Mon, 17 Nov 2025 04:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKvIC-0001LS-CB
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:13:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKvIA-00023t-Ri
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:13:00 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so2303419f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763370776; x=1763975576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YaslrgNJ0Xbphvgs70Z+LWSuJdCpZiYoMztNS2RNrBI=;
 b=eLsDLtmFpkz7gxQMaD84WvFhKYjz4v/qlYEfJr8XeuCs1b4j1NKrbFeN7zn4jlTMr4
 7hNmvh6IP2L4oPDcGLbbs8d6Qi8hajqM600+C2FlH2BJSfAOXBWmsDhA/2vO9ri0A6wm
 8+63EMIsWGGRCYq13+xZdNS4eOZDg1Vqxlb4kHoS8KOVERonIZjVc0AEZylbxqAnQKXm
 Hs+x5HW5aAQmXvRSnUuOMP+HZya0okX8RrueAeQXKACNKsZrIJNcgn4OtNDDDhC4h+AI
 F+nzWxatDUY11rakGxOdUdCcNPkow+weIN2Djvo9bI+opk7h/6c9jO221kPfgY0IEysL
 gZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763370776; x=1763975576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaslrgNJ0Xbphvgs70Z+LWSuJdCpZiYoMztNS2RNrBI=;
 b=YaIlAt1b0NpMERlc491bhzkBinOzgOir4IcK3qchGVGOGYgl8CkQhywfGeHgSN/Esy
 0DBxWpGVpgq8W7U0B/QxC/TFyl9IzLOXti7pJUo1zEx8rFT6iT6OHIvSgOLJrbODCZnN
 qKEnt4CnYJUixnCYUIm9Ee15pq2jnJSlmGGt+FGv1fakEz1V8LI4s595t1jhmnlK6YTU
 lkIdPTiBFJL42BJvHEknzeksMU9qUqp9L/twWIB5mog8DZ9GMcxhYb3cjaPHO2vyDZLM
 yHje7bOzb6y+vxG1/sHQkKB7L9rvXZ+8YyscDxV8RP094iaa6/3g1dkCaBY3DCST9LA7
 QWzQ==
X-Gm-Message-State: AOJu0YxNDcxJfd5608MmqlHZg0NLv2v1RNuOMyXyFAhVu0jRbTC+9ZcK
 E1YoDBuqnfuznkH7PgYuZOkgKZOcfqGxVguJwqx+OHj6iJYqmBzjLAmyKFkFXXfas800BCw7ZJh
 Vxcr2TbBp1Z5k
X-Gm-Gg: ASbGncvASXuWNaLx8WoPGwuDt0o3WM9k7C/r1pr/gsD1omWZ91xlwzsnRfVoO/rY2N9
 rNe6q+2MKN2PMi/WKGITdnzZOboX6IzYj2PESxAHQSC5fXH31/XxD+xQjH7TGAHe14IRc5ejS+N
 P517IKnnvdHPz+9MZwlK3igs4TVi1K2AgSRH9yObYehd2x3AI7MnW06q02mFFfZk03Vtg0yH6kN
 bkRn5DnyxGNMN9FeDBHC/jFmx7lqm5PsqmAPPm6BQ2w4tb39GSC3VHmwhsQbz+oOv0GeWAk02zZ
 shGhxUlR3Ip/xqxGlrn2UHDgML7h3c8/w6HgNOedTCrMvhSwwDl5Uq2zFZdrIZ9FtiTzGAt7nTe
 2zBbJyVcQaLXkN0UdISd0pBzspeIZqKWB37WH4YJC2BqYbXCQVWVVoZ4g/tm/T+AMV+FsQpxmD5
 BCdjTBv8JT9hi6Rrph4ek+jprH+pXOmQopNdhyl9D0A6qLQUh2sA==
X-Google-Smtp-Source: AGHT+IFrur2NHsFQpSKkjps7ni82M0I5Z8AAq9XPEnWfO8qL4GAYRpKSJZ8x7qXLWNccB9PwQBufnA==
X-Received: by 2002:a05:6000:1449:b0:429:c4bb:fbc4 with SMTP id
 ffacd0b85a97d-42b59367894mr11291521f8f.25.1763370776295; 
 Mon, 17 Nov 2025 01:12:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm24846817f8f.9.2025.11.17.01.12.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 01:12:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH-for-10.2] hw/arm: Re-enable xenpvh machine in
 qemu-system-arm/aarch64 binaries
Date: Mon, 17 Nov 2025 10:12:53 +0100
Message-ID: <20251117091253.56009-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

While registering the ARM/Aarch64 machine interfaces
in commit 38c5ab40031 ("hw/arm: Filter machine types
for qemu-system-arm/aarch64 binaries"), we missed the
XenPV machine. Correct that.

Reported-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
1/ Review got likely unnoticed by Xen folks because no
   Xen-specific entry in MAINTAINERS:

   $ ./scripts/get_maintainer.pl -f hw/arm/xen-pvh.c
   Peter Maydell <peter.maydell@linaro.org> (maintainer:ARM TCG CPUs)
   qemu-arm@nongnu.org (open list:ARM TCG CPUs)
   qemu-devel@nongnu.org (open list:All patches CC here)

2/ Should we restrict it to aa64 only?
---
 hw/arm/xen-pvh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 1a9eeb01c8e..86a02966161 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,6 +10,7 @@
 #include "hw/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
+#include "hw/arm/machines-qom.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
@@ -95,6 +96,7 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
+    .interfaces = arm_aarch64_machine_interfaces,
 };
 
 static void xen_arm_machine_register_types(void)
-- 
2.51.0


