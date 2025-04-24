Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4714C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kxP-0006Sy-P2; Wed, 23 Apr 2025 21:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwk-0004je-Bj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwh-0005Qg-2V
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:09 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so373050b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456405; x=1746061205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bSiUWMeDx637+k7z1EFvgbFx6ukAHC68XCTi+/msrI=;
 b=kECSFTCLSrH6r9Whxv7Akj/COfd7ECJs7F1jIJuOrDbnDpu1KhXtpJYlNy2WZxm36K
 TgSWiO+4ALEqMmLPPGQ+jOffY8ouCO5uZ5kASi8jqOgeAZLlPaTW+z/aCsCiyFHUFtn7
 qjyJ9MNt/B4Y1zx/S08qgfZsTW1xVWBcgfND7uSLmhPX6e6PKu2Nnjjr/qhMip+nnBr6
 ilURLSU8BvCh6YrOaZG18DQtfcPHvifNiWaL5TwKXnmnPTIbRXQ53maDMfx9Pnrcy5Vj
 zvOuzkRlW1/QULsF69nirGSvJgC6lN58CgjrllekRazJdCCXNVEDo+E87LMZa2t2uFdB
 SRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456405; x=1746061205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bSiUWMeDx637+k7z1EFvgbFx6ukAHC68XCTi+/msrI=;
 b=KgqQLTQzWiOW64mCkNI8vnPCuS/Zvqy5+Pxy7qaZXI+3R22smAzk0sS0E6Fg00dx6F
 Pf9UlBLGszpdV9kX+U1OmL/7TYlEKA9hlL0EJaE/b6tym8n106s49dW5MSmUzc9FmxaM
 zBSRXsOYBSUikO0SvEG4vK6v+vywGCvQdcMTnCcHwZSMRBOjX2xH4Rzq3p+hqfm5zICP
 7aZQG1cKEi38+OCkJ9aDV0QVUKtOvLe/XRgfIV6GJVO1xOGwzKp4+GenjYgZGGjN51pg
 I+xNKUXY9tSrylMymH4WL/wQva3DNFC/87TzFGXQ6/HEAXbRbYcRw5ip1wuhRNTJC69b
 gTYA==
X-Gm-Message-State: AOJu0YzZamt8sZb3lIs3KiA3NpJe0xbDmwnWHhyxR5Ts5KsG/tAGoYLb
 lyfvxCdz5/zp5aerNWJaUK3S8voUI7Jv6nPl055pQKYk/QEjtS9GFBBSffPOywxoFePUVEVNyWl
 Y
X-Gm-Gg: ASbGncsmjbm+EWxgL1CFrJds1bpR0xabT7FOL38GYEyd7b9r6Td6z/tR1VjWhN8ysY1
 /VLAI9HRA7Y6sysh3qmGSi+0caND94pw+08CzxYtwkUO4OzQwPhU5GgFviuwXLMf8DRvGoT7HvT
 nxkM7Rt7sNEDWwdRQ8QqQj2XtKXcCmOIO22QLY9GEURTh7aORHWHcGXIt4ArxyYAiS3RLYyt69L
 /LTEBm0+E6u1gF+eVusIZ0OxFzRX/dE8nzuK1DlhnN25yATYTVLJEG+8NijSloWCL5TWFzVylu/
 vaPuseL8VaaIJOenWr/G+5aSzBlG7aryIsFN93a++Z4NRwyoGQjrE+NkUu8hQkBl8sX19Dulaz4
 hWk9I7iUf6Q==
X-Google-Smtp-Source: AGHT+IG+j7od/4qHS6Em6dxnO7SIctLp6RD0JNnAVYtRc3mbw/joz54O7/D1IcZ+hMVHZGklAZDxwA==
X-Received: by 2002:a05:6a21:6da5:b0:1f5:7007:9eb8 with SMTP id
 adf61e73a8af0-20444f0503dmr861611637.16.1745456405358; 
 Wed, 23 Apr 2025 18:00:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 124/148] hw/arm/xlnx-versal: prepare compilation unit to be
 common
Date: Wed, 23 Apr 2025 17:49:09 -0700
Message-ID: <20250424004934.598783-125-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Remove kvm unused headers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-29-pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-versal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 278545a3f7..f0b383b29e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -17,9 +17,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "system/kvm.h"
 #include "hw/arm/boot.h"
-#include "kvm_arm.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
-- 
2.43.0


