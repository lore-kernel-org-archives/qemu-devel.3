Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3014C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kyv-0008O7-PV; Wed, 23 Apr 2025 21:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwk-0004iE-61
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:12 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwg-0005Nr-D2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:08 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22c33e5013aso5504045ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456404; x=1746061204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/mORInhxTSzgm/0P0f5jfysAlwA8buqx+1z5KmEz7g=;
 b=Z5omVdI86pcsUQvUNKAeLHl6EYZJzJAhQ6tPaYIUltNICZMCgPRhj5OoSmsA+eW6Wx
 yXoOOovPcocAuk0kckl24rUsY1qXw6QcZ15aIiqYFjl8c2F8L6PTRAlgSHiFX98e0K58
 Sig3n6Nj69TfsDjKTOfVpfwSMT6Q0F8O1MyjgduOkQmJkxaAIIjwcq96ZT9Qm266vrKT
 R13K24EaNHMlUc3vnEHIr7AJvy0O9x0GXfyyskohRzfHS44Zop3JTPXK1FQPacN/wPff
 4VCi3VqbA+ZaGq5Ui+/KEESgnF8fZyPotGi/RngOEaPsPMpQK9XUbbjxkQvP1ruhg+VK
 8BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456404; x=1746061204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/mORInhxTSzgm/0P0f5jfysAlwA8buqx+1z5KmEz7g=;
 b=KXMmgVViKxCTgTTRnJUOryD6vloVMncqZyI8Oq/mgaRJWkXELBGivxG4Y/29RX0xAX
 TSRhsea/FOyvTaxws4YtvJVoZ3J+LtjJ3QDUqvxYAfT+ZFGDyJn9AIEI98XhSt2pnkYy
 qkQbqKuYB1gn8Zn+JCDjmkMo01SMC00tcyC5H0S1BhyD2Bx8TA/6zQvW2NvIsPZgtpWa
 djzP8qqLxmCU5AA70PnDz/pBzGhjTZXqZcbZB0On5+zUrmh7r+Qv1DOnkYQFNV7Gcz1m
 0DqtU/vVNCqekX4RlnPniC1IP3+hTIHrKgcXM4NJhDclH9UgOUNb0tNKKJvAWDr2hs5R
 S6bQ==
X-Gm-Message-State: AOJu0YxPSvaCPhguVAJBVIXUN0KXyN7zjLzAuv8jdV8QfL/IAZZBaif/
 TxK+pPUCtrZp/MxmCb5TLMgWmnl9lbtjE9UC00RPfWPL5eMz9W4oBfP0BWdy7sf9gzM6PZL/Vwf
 p
X-Gm-Gg: ASbGncuokjGvFLfXxT51cnT47c3V3dSTRynpC8z1fl8dPzb6KApZFtFmXba9lz/xbpH
 DgIDrIyt92uPIIRc4vnSWlTkeJLAqQRXw8ttPe03UW8noFLeNKnny/c7hthTOQqgAjAOpnK4vym
 SwAyxHYKofTEOZ+QO2sRy167yq6TFX4pXBmInFwiSEzq1zpj9rHweC2nI76ObbjYzZ2hH3doCt7
 1rWCF7S3MW3vAOcJ9e4HZw5/MK91N3LrOv8DGT/yFTLLrUo++G5GB82LIaTbzo/Nzcvg3ZNajyR
 VGSICiSClPj/zVwJSxkA8/lZu18RtoyMjdiuGJfNvddlbirFJAX0JiOOG0//S39vhtgG09ZWrMQ
 =
X-Google-Smtp-Source: AGHT+IG9JXt8spFEV24x/8efvNx7p/Sw/+asUkaDCpHTxP657SPHDLI2lhuO6DMtuWT2OxfohYbPBg==
X-Received: by 2002:a17:903:1b23:b0:223:53fb:e1dd with SMTP id
 d9443c01a7336-22db3bb2ce3mr8562235ad.9.1745456404501; 
 Wed, 23 Apr 2025 18:00:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 123/148] hw/arm/xlnx-zynqmp: prepare compilation unit to be
 common
Date: Wed, 23 Apr 2025 17:49:08 -0700
Message-ID: <20250424004934.598783-124-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Message-ID: <20250325045915.994760-28-pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d6022ff2d3..ec2b3a41ed 100644
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
2.43.0


