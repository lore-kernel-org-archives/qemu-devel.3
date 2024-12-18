Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB4E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwLc-0007WM-HL; Wed, 18 Dec 2024 10:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLa-0007VI-Ih
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwLT-0006LC-Cb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:52:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so43471445e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537133; x=1735141933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43o9dEO1jQoTM4ynX/IY3hHbA9yVH/+x2ZTghLcMeMM=;
 b=olHJO3Sx/i01QdRhLt+HQLXs0JCTFBHlUp0nljMQAm1pRoI7dXLzVLW1TyfJTPDsKv
 3dC5ihedAADI/9DKlV42cZEmmZqg4DbCZzNRKhm/oBaT9MeKe4d7L9oFdaZhRXwCYgnP
 kvudIVALvh7WE+qHIP5rnXACXGYXHQMm27Pt+nbRSTr/8scPq5PVzXZtV5ODxsvqaxXO
 t3n4jEdlyJqD7GXMIIytiTeHkc01TRoEplhjpokSASO/V9EhO4qL9Ee0Juhyoc40EGjX
 sfQW5Ll5hs+u1b4iM23HRtfMtKfAQAu45i2HDcEVlPeLUVceXNb7NRnEPcQ4Ctqlwhyd
 9a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537133; x=1735141933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43o9dEO1jQoTM4ynX/IY3hHbA9yVH/+x2ZTghLcMeMM=;
 b=fs0ET3ahrC47U5Oj3++hvgCrMUFjaaBLy+UmWgu4hrmTfxEMHh37xmUJsn4bgxzXRT
 fkVOJnDPFb/Uj8XHVkRhGp8cn90EkdtiuAe/S7PC72rhQ1t6tABLQvP7uSpOrabAztBj
 iaAwytfSNjGGAQTsb6+N5JENrLyU1H1Brlq9ll96PIoV0T6uvbvNW4Rh8kzNxi1POAD7
 Vp1JLiUlx69Ix5/d4AuS9tXVOLePnWgO1Jh5JgxY7YNvckTybj1ikrrxtdClOpDto7r+
 rLdZCf0LxRymgZf6W/axNSZb6Xf+BNIIuV+Kos4R9e8IO6vgEyBTzl3GJlp63/7aVHKC
 lVXQ==
X-Gm-Message-State: AOJu0YxsTsdPxc6lLbb8I8XckgZos9lpVSGmQf5HrqiTUvKQVeFck0Nr
 xSstGev/PFMjJ5F1I8bplK3f//xawLpC3+lFDy0lLugYjoZcj8Hvw1zOAFqveaUpej3ICvDjiKd
 Q
X-Gm-Gg: ASbGncvYOvlsempbvSsknJRt/AU370A0RYDbciTecXB33KKjnbVEQ+6sT/V/EU968KN
 /MMmTYS3yhKYC8cNEK52RhiXOomTodmfi3bbs2FC4RuaAq91SUacWsCYE0gfYcKmGYUZ7hhu6sz
 XCm5M0ipMQTTY/Tca79oitfsMUgrVLMUdvfOv/Mh/nSTR76nyBZs6Fkt7rMJ5LTM/jG2WtWgirC
 es5cvIhmCYoZRW+sgmHW/q1TCxe5XIJSAMVYa1J1EF6EFPgCFHBJe/gTDxU7mJsMa8vDA/Aa9DN
 SWEO
X-Google-Smtp-Source: AGHT+IEsaC6V3GYn8cY+jQ5UtKyHo0/kS6vyBPmxF3hRbh6FBxgYv+uGh72kfs4SbFGav+LHBgHjWw==
X-Received: by 2002:a05:600c:468c:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-436553ed055mr29615055e9.22.1734537133598; 
 Wed, 18 Dec 2024 07:52:13 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afd57esm24251025e9.5.2024.12.18.07.52.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 07:52:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] tcg/tci: Include missing 'disas/dis-asm.h' header
Date: Wed, 18 Dec 2024 16:52:00 +0100
Message-ID: <20241218155202.71931-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218155202.71931-1-philmd@linaro.org>
References: <20241218155202.71931-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"disas/dis-asm.h" defines bfd_vma and disassemble_info,
include it in order to avoid (when refactoring other
headers):

  tcg/tci.c:1066:20: error: unknown type name 'bfd_vma'
  int print_insn_tci(bfd_vma addr, disassemble_info *info)
                     ^
  tcg/tci.c:1066:34: error: unknown type name 'disassemble_info'
  int print_insn_tci(bfd_vma addr, disassemble_info *info)
                                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 3afb2235285..3eb95e20b65 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -21,6 +21,7 @@
 #include "tcg/tcg.h"
 #include "tcg/helper-info.h"
 #include "tcg/tcg-ldst.h"
+#include "disas/dis-asm.h"
 #include <ffi.h>
 
 
-- 
2.45.2


