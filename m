Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6398C36004
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSY-0007Bg-Ua; Thu, 20 Mar 2025 18:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOQ8-0002qD-9z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPT-0007DZ-DS
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22548a28d0cso36163415ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509839; x=1743114639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPkLAbYv8e88J6hBjHHNYCWMiXvm0PwVbqQ15vaNtOE=;
 b=XpNhAU6scci9oW5gVIBB8z/bKhT991hr1lHDxn2lOSKL0ygnAsEkkJyQDfqS6+AtSk
 Rwix12VSdzg8s0Ze0fmXzQZc524ngdBXHFcJDDPj6PKQq1cVmdQE1dcDlxlZoSyS/cgR
 54dL2wfqf/OKu/l1JPBdEIzsQKcDuf9fEf0AwvqtprKqi9sYAf/M7abD4TSqiQRG3/1+
 fRi1WMx7VMC/TRVdSxCYd35IBfC7PMc9UXZgicIWrVVTnpg7eJsD2GTLzCbmBv1DXSfT
 NKbjnrLN4x+gZwSKB7FH8Ne7Vx6tfeXUG83VUxKCe5RrsWSGJ+mQsjMG/p4ama/R2LSO
 EA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509839; x=1743114639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPkLAbYv8e88J6hBjHHNYCWMiXvm0PwVbqQ15vaNtOE=;
 b=KndoZfdWvaFK5rywIbbn5Mw51D6vyTC/ujSteSRm5EUxhKDyeyUPM8Uw7wT3RfgK48
 P5NJAX34CWfI+c7FCAv6nGgn8VjuS43wegzLKu40iY1dx/YOySlwqyysU4CpG8v5LYh4
 bh0SpulE2L8CXqsrZ2aTon8cGRc4MgdM0XPr5z8xhnx2V1+llu2jYtq62Uden6hb1grx
 i7Hbk4GBiPl1ieEDAXGfjpveTbTlR4eds5Qu2f+rpEy35aGWuy6ja5qGByCWe2RKdeu5
 4qFZUEKU3SOeg9Bn8FBqvqScLCGGn7jM/a2aWxBLHojSNSK22zVy7byAG8SQhRIXY56r
 EbNQ==
X-Gm-Message-State: AOJu0YwrRg3IIwC3W7EVuvz971+sZvQAOFyf7vG/tDwSnDsyRaSyn2Ki
 EhrMa5FvfsKgw0YWdVuwaXnBfIGofaVs2pYMi90WqQWJNXpABP5YsSEJ8OcmNcL0KdfvadZddz6
 r
X-Gm-Gg: ASbGncsK1BfGdF2AvHPsWdv0HsL22Y8/GPLMMHXgQ1xWSwCs6ZdyEDqA3hIcBtK9pT+
 1nh+S4mSWarFaEhw0KzqkYZ6C86ubG7fEppo2Re1DJ8kZaAG0bR4DI/ezd6v/sAFA8bQzXg5pSs
 HSkMmT90Udb5i75VPW8jcv1pyO0VOOKnW7+c6n5UIA38VMUTC+aoZ/wtB4y58qLcTdJ389gvfk6
 Bgcw2aPqm2XE8XSEuyRhECmTuMFJYfo9baov+y/+QRzCCEv9MfGTu2IUHATJtj1kZNlR3CJs8nH
 TbWr3Nw4NY945pmIggZKZEoQZBNOcc/yJlFI6OTuDVck
X-Google-Smtp-Source: AGHT+IH1IZNZsqPktc71rFpZr7RFxZkc9846438DqvW/sf3mREIxsV0YuauOBbHxE1Q8R7m7oGcTUw==
X-Received: by 2002:a17:902:f709:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22780e09686mr19861315ad.39.1742509838882; 
 Thu, 20 Mar 2025 15:30:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 28/30] hw/arm/xlnx-zynqmp: prepare compilation unit to be
 common
Date: Thu, 20 Mar 2025 15:30:00 -0700
Message-Id: <20250320223002.2915728-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d6022ff2d3d..ec2b3a41eda 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -22,9 +22,7 @@
 #include "hw/intc/arm_gic_common.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
-#include "system/kvm.h"
 #include "system/system.h"
-#include "kvm_arm.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-- 
2.39.5


