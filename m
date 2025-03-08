Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9861C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Ir-0004XR-OI; Sat, 08 Mar 2025 18:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3IQ-0004JB-2z
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3IO-00016u-Ef
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so17689545e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475366; x=1742080166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qxj25K64APubIeBFvAOvHKODmgZUFRmHVHXhc1AU81U=;
 b=mFm+hlkV7kVoVtihPK7yyQCerPZMyTjZi84w+PAMYPtWjnlYr/SqszWnv2yA2oPUn7
 UOgOqvSe7XB/DT9JFTjzyNFGfOJ4iv2rLTZFvg16PRN48zBbzMq5uugNbAd/xlJJ6wf3
 ulDm8A7Delme43J5JqeIBlmgSk979OHk5hCPjsrBxX8tFlKX2XayygZAidMLG7fa+Zcf
 huws9LPjdxAYNsu5/tSQ+EK1IX5ZIdCBT5T29aOSoPJHQS8TL52HwQtdG9P1fcIrnGB8
 DkWKmS3QHcyZe87bhbbF9K4zzpXX/hEjfeOUE35vzegnyQAAcuz/01sgkpdkeU42Go7q
 yVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475366; x=1742080166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qxj25K64APubIeBFvAOvHKODmgZUFRmHVHXhc1AU81U=;
 b=tKPG1VPgiK8bwJZNsPrwPilhRJEuJ9TwgNrhW6kuj8qt9pmI9wrlhmK92rn/JTtpWD
 tUazZtocvqCIrU8Rs8pCjgu4JdAeNiJ1aqXfeTpY5bUUltnsfe2GskVlhsydb6pw+T3f
 u8XnBEO/oWK6af+mjV0Jv7ev3LakM3GpacbOfaDau6QXlwV2+3+X18w+olBEs3y67NWP
 ag4gVMXEXkLWyfqCP5sT2OO/GB0j91LSMQNeuVdjEoTbJtGRyTQ2MyCAEIwqPbhpthxp
 CApOPAWC0ZsewLW8lbGdV0F0ddnLnU48AuSnjPPJQ32/lQszu6q8X/cuazaIkLe14XO8
 dRhA==
X-Gm-Message-State: AOJu0Yxz057tfVuEWxPJwn5Na0ksW+I/JnZeDV42knqWAdCkKHjkCfcU
 zRSGh8fkD3YZZhEJm8iBPbrPRSk36sE/IfkWkE/wkYOeHKToToYGzMOO6Jd2DFvwU6m4y8DwmJ4
 dxHA=
X-Gm-Gg: ASbGncu8o8us5RyA5++7r3BzIsLl/+WG+t704Kewayr/D6q3UhaSVd+ThKhajph8c6x
 k4P/wJ/MKUSbP6YnaimOW6anYiEMIXJA1m/biqRM+4tSNJ/4fEU217LRqXlmkyJZ04RrMqidvrf
 a4fQ8wWXDzrCodSMGMPQNNEDmtz6q5S0PtugNFzOk8z+Lcbt14YnukHia6O2TQ1yon4ZTKzGH0o
 Kx122kkdRNWpSw0KLz15jUUn07CcgUpbobYudC4keLOzxrFJ+eQIz7YrEONqoCu5qjhYmlnitA7
 TyENkq5CBfjNlpFsYC/+3pv++EqAOibY3PzTAiXxOdteorAIDRtMhHn3e8QVvzVPbmohMAf6Sf8
 Gec+ynlrEYplpYc8dMaE=
X-Google-Smtp-Source: AGHT+IHJ0NS/FfGXlmf4jylNvapCrpoM4pkS8c5smWzHWxpj3jWgC5iW6aWgueYm5DZwov9rUe2K1w==
X-Received: by 2002:a7b:ca53:0:b0:43b:dcc8:557c with SMTP id
 5b1f17b1804b1-43ce4dd640fmr29552115e9.13.1741475366165; 
 Sat, 08 Mar 2025 15:09:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c324csm96428385e9.12.2025.03.08.15.09.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/21] hw/vfio/common: Include missing 'system/tcg.h' header
Date: Sun,  9 Mar 2025 00:08:57 +0100
Message-ID: <20250308230917.18907-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Always include necessary headers explicitly, to avoid
when refactoring unrelated ones:

  hw/vfio/common.c:1176:45: error: implicit declaration of function ‘tcg_enabled’;
   1176 |                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
        |                                             ^~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7a4010ef4ee..b1596b6bf64 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -42,6 +42,7 @@
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "system/tcg.h"
 #include "system/tpm.h"
 
 VFIODeviceList vfio_device_list =
-- 
2.47.1


