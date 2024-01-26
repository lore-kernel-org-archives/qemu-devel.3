Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C61C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHG-0002IQ-5U; Fri, 26 Jan 2024 09:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHE-0002HG-Vu
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHC-0007ub-Hx
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:52 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so5022765e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279629; x=1706884429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ELkpfpUcCpMmE/EyjZLsfEZZ/g6NmNI21NxV4ntMPM8=;
 b=dsn1n0rjLl0ZSjjm6e02XTjlBQHZvC2lYqnOwtdflfldMS3IhFuCAo7q+G7O0Hrz5/
 Mxi2inFrNUDAc6rjLLzW6SDyVi+MGaUOOAM/mhHb74BCPEhvylCBaMH7nuRQjeyDin4P
 UdbsJfBp2w+UP6LD6WR61VR/BBwcJ9rMCYb5nW+69reWoSq1f+ziZMWI5XKENkgeQCjl
 q/sSNfdjObKbaLBYCfyersNOk4TWIhFEjbAtgZ6goBCZuQu/1RxYZbmO4+XKtNBDdpoT
 KNjfTpNf785EsduvR/BrDhFFnsyZghfa9WKebkz0ghNOoo6CFGIT7g77oQIEiDQ1yf/7
 ZOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279629; x=1706884429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELkpfpUcCpMmE/EyjZLsfEZZ/g6NmNI21NxV4ntMPM8=;
 b=Q6r/tj7qWOoaxeCfx/39Sqde2p4/VDIcxqDLmXlrvnIOKOfRYcmHz33gTicbxr5qJU
 nlruzic+Sc2XU6M4ZVZQB2eF7STM0BTh3Yy5EM0TYt3J8au0C2g2KxEQBoSJGPHGtnwC
 Z+U/gRXN2Tlr6FOZamtF8X+bfs19pUilzRv6IRX4gOkBx//KYEA3XblWJ9ioGgWBvO7Y
 wYJzAxD9uVV8ER/bVOHUkxzq1o4pF9lpNF+C/SOWXYPTr0fP7rpyu4Q1NxJiKinp7D1f
 AALyOG0LwBrj9PiW8s276umBkDQYACrftczxZ45/jdJhbmtQ173nvqZqfdJu22QUsvJH
 xUqg==
X-Gm-Message-State: AOJu0YwdmCIv0syv/0A33lZLFZuJ1HKYskx5gY9HMxCA0zYREyXlxm+X
 IAFY0IwW3VlDau0qKq6rXha+1YKAXkQ9GTqu7yBxaSk5yPUErTcWfA6nzdA6qD5iNDO/NJ8SCz0
 O
X-Google-Smtp-Source: AGHT+IE2DRpTBRDUzkOT4eRSlJ2PkFL5J6ij4vlcLTyt9HQJoHtz7n9OkvVLxah9t0pGvfpI/V446Q==
X-Received: by 2002:a05:6000:389:b0:337:ac00:9e64 with SMTP id
 u9-20020a056000038900b00337ac009e64mr2632417wrf.44.1706279629188; 
 Fri, 26 Jan 2024 06:33:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] target/arm/cpregs: Include missing 'kvm-consts.h' header
Date: Fri, 26 Jan 2024 14:33:21 +0000
Message-Id: <20240126143341.2101237-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

target/arm/cpregs.h uses the CP_REG_ARCH_* definitions
from "target/arm/kvm-consts.h". Include it in order to
avoid when refactoring unrelated headers:

  target/arm/cpregs.h:191:18: error: use of undeclared identifier 'CP_REG_ARCH_MASK'
      if ((kvmid & CP_REG_ARCH_MASK) == CP_REG_ARM64) {
                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index ca2d6006ceb..cc7c54378f4 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -22,6 +22,7 @@
 #define TARGET_ARM_CPREGS_H
 
 #include "hw/registerfields.h"
+#include "target/arm/kvm-consts.h"
 
 /*
  * ARMCPRegInfo type field bits:
-- 
2.34.1


