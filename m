Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03C3C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgAG-00035R-5u; Mon, 23 Jun 2025 08:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgAE-0002zD-BF
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgA9-00012n-FZ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2273007f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681235; x=1751286035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1avEvgULJGN3+NnzgbjknnR4xz+wRJgrCM6KmdqT58=;
 b=g7xN2Jh9JD5r8vncUs94H1lrNpok/40FDBWsrrf31XC/ybM59haSL5kM5QXja8LN3j
 y2xcNgtBQfglw+XTn1GOZNVrrh1dpJGrK0J6WtjY2PcG84NjBHPGTIl8AuEKNzzaCGK/
 NJpqEY3zxuK2BMY3O92PFoVXWi/2DjFJO2hRh2nSUTjx48JqjAIZjylbS05sCZ9uW8Nh
 NMlzr7HPnNzpC7GDhok+kNZC6GehcPhms5dtg/lnC3Fpc1R7h46D20cS2xxZ7EITDN2z
 ZDHD/STdI8hUIyB9HxsJEStjUmeMTLv76j27kBB5+QUcDuhHlsDTxOx120W7eZHnQR2G
 sTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681235; x=1751286035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1avEvgULJGN3+NnzgbjknnR4xz+wRJgrCM6KmdqT58=;
 b=EZd4Cqz3eADvO+Ol7MmTM5ExhbNxQwV6ro9AzN+6ovQO+llQTGnTRfLhp6TcNbT14p
 pwEQJplUlp0cpsuSeIr5ilw04m7hQRwQQ95hcLAIqMjRoRYAegQI3yz/VVPqaswGogjB
 ICIHcqUP70egywMxh2Mpfy+cz/Xro5GUYub1cWfEzjUpi7zHhMtdFWZ7TY87371c7i68
 hY2u0oHMcBuWtg3t7A4hHyvFwXqdtXfctB9LAmeyBltmc7O/rDvsBAD+a0gPwydWPjJD
 R4xYDkSvxKc4Odk46IP03jsFQsc3vDL/KCSL3rellYT/IUehpd6AXoF+M86TXdqOusBj
 iK+Q==
X-Gm-Message-State: AOJu0YwluIUnHsHxKgEqfyl6bPbJ9x5mwdKF+h2G4NM2WRPmI/YJTKY7
 YlRLeSa7lOH7pFK423NMc+qc2HA/nHTInBecyispyILjg8+j4AQbimWR2TjU0xCFGSzDwXpIlvR
 +SGXq
X-Gm-Gg: ASbGnctfTdnE3wIP3bpASbK5K4QF6eqsX816UR8s7onfkcNVT8lu+5c4cUYm4IIfeiR
 Hx5F8IPwmJWGaaTG5A5qJytXjJ1Gf5nXnD/bYjQCHX+eRTFF3WiqCYPXEzWaRHQwD/QaiCmAkkz
 Cz2jpdRfPB7R6f9IXD3GGN6FxYJ8o/9BM1kt15UFQ1hYaOqoRZz9gG9MYbrOtVxUBt4qD8RBPYp
 uA9au7zUBM8Z3B4NVAhwFcYkklTs8aKmOpidBetNaXUlOTu9PhIx0/xNcsVieF6Z+ZzwAyMiO9a
 s1K9LinUzT5U/ZjQsVo+wzR4KFI8haIi2vuRlA0uhP/fsaND2a2lNNx62TI6UaqjI0ebhx2TS1x
 CKGl8Vyu5FABQ8W0lA/bKHCrGOuFATRQqA1pS
X-Google-Smtp-Source: AGHT+IGfmWKuPWWupTZ/ZnEeVOjJmb/p1NM+3sPwfupLNJuwEpOvWNKETdLlJnkiht7JLvtuJ9EAAg==
X-Received: by 2002:a05:6000:40c9:b0:3a4:e2d8:75e2 with SMTP id
 ffacd0b85a97d-3a6d132fbfamr8548741f8f.50.1750681234897; 
 Mon, 23 Jun 2025 05:20:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f18a29sm9449877f8f.36.2025.06.23.05.20.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 21/26] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
Date: Mon, 23 Jun 2025 14:18:40 +0200
Message-ID: <20250623121845.7214-22-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


