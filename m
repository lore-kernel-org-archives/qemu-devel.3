Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B324AD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1njb-0000yI-81; Fri, 18 Oct 2024 10:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njZ-0000wl-E0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njX-0006xp-G2
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so2132829f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260818; x=1729865618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4Yot1tudtAAArP4Zjr4rYhpGE+rTwWWEjyjmd9wPl4=;
 b=z0rAhZrY45VWzrz0Gqp02uZR1rf4f0XIrNPBUWN8ykz40OOx+ZHnyuu05IAk2zvGJa
 0748m4tjAuzHnbSL3QZ19VDS/ABbw5G+hh4PiNP0OhPjvWWeb/o7oaX+CydFKtVpFeoK
 JQiPoLTV1LoySzBfVP7z4hIPw9I4BJpjEDgkS87fh8GYDirrwKoWKxhH1d8NVzagQdKB
 0o/onCoowykQhazThsMtUxpZnNyfpYFewTH+DAsiX31uw8wPVTjKf23zc3SCzfDzD6Nk
 fqs/eOeuEpaW72+UATjH39A7ll9f4JRawYk5xGeAyxfC8O0jOjLNl/ywPGtqCkBl/sEu
 uH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260818; x=1729865618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4Yot1tudtAAArP4Zjr4rYhpGE+rTwWWEjyjmd9wPl4=;
 b=ub0JPVE80G+7RP1NXQJNPUhQI3+5e4VbtjQUewQam6j39Af3ATY/meRTtIob4z7R5Q
 Wa+MQpu5ciZc9enXoO3xJv8t/0Sahs2cAUuIeQsFpNCjfN6X76YckAzaHK+XgakDufai
 /bdmpHN/KYrso2ve0qSQ//seqfDKzhbUa1fmaa92frIg2Lur1RUKkBK2XL1d9L5q8E09
 FUOObLcnz4dZxNK+9iP6kUijKDxPwHJ+EOSxeQO1PMVLCXOOrZI6p2Cxmg9NhlBgZ8HS
 zCMm/UCgicS9lH47XqjCaXRkeQ9AJWVOEdcp+bUpTNlTMDsTP+MFkOgIMQM09QSK/NkE
 k41g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGw7Z/Qaj3N8Wb5QxxgbirvK9Y6lZf/gg1cXWIex/TMXQa+c8qFMBjWPxChLKlei+Oo9WGzVcHM3hq@nongnu.org
X-Gm-Message-State: AOJu0YyUZv4eebqt29ZrdlccJ+rwtN9WRdYARdNRg1vV+8LnQRuhuB8k
 gGYeOgk4aU3fey6VHvCYtgb9TQuz12nM58/RUwovXzCycdPQJu9FFpS2Bp4qo0A=
X-Google-Smtp-Source: AGHT+IFkUxXxHLkwxWd5Nv5sIUakAP8w5Ir9VJ85a22y+kZbOjN65qOtcg6z3PnclNvCvVwvRWhM2Q==
X-Received: by 2002:adf:f251:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-37eab4cc04bmr2783674f8f.28.1729260817644; 
 Fri, 18 Oct 2024 07:13:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 5/7] docs/system/arm: Add placeholder doc for xlnx-zcu102 board
Date: Fri, 18 Oct 2024 15:13:30 +0100
Message-Id: <20241018141332.942844-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

Add a placeholder doc for the xlnx-zcu102 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                     |  1 +
 docs/system/arm/xlnx-zcu102.rst | 19 +++++++++++++++++++
 docs/system/target-arm.rst      |  1 +
 3 files changed, 21 insertions(+)
 create mode 100644 docs/system/arm/xlnx-zcu102.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 031b117a3a0..7c3325628c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1016,6 +1016,7 @@ F: include/hw/ssi/xilinx_spips.h
 F: hw/display/dpcd.c
 F: include/hw/display/dpcd.h
 F: docs/system/arm/xlnx-versal-virt.rst
+F: docs/system/arm/xlnx-zcu102.rst
 
 Xilinx Versal OSPI
 M: Francisco Iglesias <francisco.iglesias@amd.com>
diff --git a/docs/system/arm/xlnx-zcu102.rst b/docs/system/arm/xlnx-zcu102.rst
new file mode 100644
index 00000000000..534cd1dc887
--- /dev/null
+++ b/docs/system/arm/xlnx-zcu102.rst
@@ -0,0 +1,19 @@
+Xilinx ZynqMP ZCU102 (``xlnx-zcu102``)
+======================================
+
+The ``xlnx-zcu102`` board models the Xilinx ZynqMP ZCU102 board.
+This board has 4 Cortex-A53 CPUs and 2 Cortex-R5F CPUs.
+
+Machine-specific options
+""""""""""""""""""""""""
+
+The following machine-specific options are supported:
+
+secure
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Security Extensions (TrustZone). The default is ``off``.
+
+virtualization
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Virtualization Extensions. The default is ``off``.
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index a7f88c8f317..ace36d1b17d 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -107,6 +107,7 @@ undocumented; you can get a complete list by running
    arm/xenpvh
    arm/xlnx-versal-virt
    arm/xlnx-zynq
+   arm/xlnx-zcu102
 
 Emulated CPU architecture support
 =================================
-- 
2.34.1


