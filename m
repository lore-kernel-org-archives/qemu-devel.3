Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06A7C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUj-00063g-5K; Fri, 20 Jun 2025 09:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUe-00060Y-FC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUc-0004wU-HY
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so1494930f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424956; x=1751029756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlzGRKm85UWY2+8yyhfs+sQBrY+hIXBP3ETvuuIJ2dg=;
 b=Pht7qKYbs4PNh3+1sfSzreFNcmsSlficbWNgEYaQqnMWJ53RYjmk4ycvkeJn8SnAKp
 U4IKxlgwjv4ppwiiLvNSkjkoWRO0fHrqLjfM+MmYkIgo9q76syP1NOFY36uh2DMksbzQ
 cGyROTZianVReO27rd3vXGy5jnNx2p+aM7LBXJR91LkPPvV0Pfjb4jXcuAmKu5mfPVwJ
 eQUEpQI2sn6gLVMyPjq5G1YNYHwZMAjumEGddl/Rkk9q02NOSjdrZ1a446k/tz0n8kFS
 X81pjBD44jE07f2w7P9DEUzNXOTik9VQsMGaWnB2LHrqV4Gr9P2IdlvegGcyUnoEldhE
 ODVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424956; x=1751029756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlzGRKm85UWY2+8yyhfs+sQBrY+hIXBP3ETvuuIJ2dg=;
 b=oS/udG7MJ4W+88Z5MLtxG5t/uIqC+Sxt1wc0t3JOa9dnD3z+dFJ8RMNnnJZbFVaOYD
 /24bIaDG3R63DWbTJheuGIGuzBS2dI7fApmt6z340tZtUnOPfawbyWZ96o/AYrcST+Hu
 73wHUCy9T7e4nY9+Z4cAg8pgDF4WGDrYg537s8PiEqoyGfQ5DAZMdMN9dfv8o1aQEB95
 it/W9TiRqbT6L4ugmxTtN5qKaSzlJrNrhNAwwIu4RLdfvDeSYPfW7M/iNna+jshwUmP2
 zQCvUqUipfKz4Ef+XT+fS4cnCBA7COI5DZvxhg+mVOp6jGfCel3TeKS+xVRd7cr/VBvE
 bpdg==
X-Gm-Message-State: AOJu0YzM4z5DuwwhLkdIncXEiRW7nHpCTHPumXhwsVY+7tkxxCC9e/Xt
 A0LNAIcZqxRg39ypb7MQsYdQMFtcKb9lD71nKLmtf9xNhJcAJWwbDOppAbUc1kcVabWp3Y99Rpv
 8I+69cys=
X-Gm-Gg: ASbGncsIA83Ym5x+DAYcSMeh4DCF5ozD27RWNsPXZo9zM2/QQ48+FsN0SgfpSMW0H/D
 +lmuC/yct9uWK215F8KoQ0fuYArKFVRuU0LQ3nAsClUymw/e9HSAQ54Jue5bO3ucJ0xColVEE7p
 C6GfLoFKDi1UF6Ss4zYupkTVR/fZMx/eZj6VvuSK72VCsQN1wqhB4nOqp1L/Kw+H6FafrVFhIRx
 s8VvNMgvDrzmBnZJnJLSStCZFyxNuqx91g5ge/vBfWPDZ5Knw1IqjgjyQuu/jEfuLfpIkpyvDJ4
 VxSXdlWUi6JOgChO4VpQ+uhTSeySOh0vfT6rsaDz660YRN4+dQphsROUVOHSQq6BD34FjVUgy+l
 UFGo21PywnP4aAEJ5ygniprKHnis7RgB/8rFB
X-Google-Smtp-Source: AGHT+IF5uD/3snOQ4X+aLRPk1Xt/Xd4ZmVTTd6N1+20oIyEGbROy1hmGwi9rA/PwtOTLyfKem3s2JA==
X-Received: by 2002:a05:6000:248a:b0:3a5:2fae:1348 with SMTP id
 ffacd0b85a97d-3a6d13129c6mr2233188f8f.51.1750424956479; 
 Fri, 20 Jun 2025 06:09:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d2236452sm1791926f8f.59.2025.06.20.06.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:09:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 22/26] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
Date: Fri, 20 Jun 2025 15:07:05 +0200
Message-ID: <20250620130709.31073-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Define RAMLIMIT_BYTES using the TiB definition and display
the error parsed with size_to_str():

  $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
  qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 TiB of RAM

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index deae5cf9861..15c1ff4b140 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -53,8 +54,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-#define RAMLIMIT_GB 8192
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
+#define RAMLIMIT_BYTES (8 * TiB)
 
 #define NUM_IRQS        256
 #define NUM_SMMU_IRQS   4
@@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
     sms->smp_cpus = smp_cpus;
 
     if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
-        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIMIT_GB);
+        char *size_str = size_to_str(RAMLIMIT_BYTES);
+
+        error_report("sbsa-ref: cannot model more than %s of RAM", size_str);
         exit(1);
     }
 
-- 
2.49.0


