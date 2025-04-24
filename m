Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9BCC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837y-0008JN-EX; Thu, 24 Apr 2025 16:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837w-0008J3-Nu
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837v-00051G-0Q
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so10399525e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526293; x=1746131093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaHx7PNN69uqV2de9T5YysFFHIzKyvP4EvVdC8GWNAs=;
 b=cu/cAm0e9IwTxEFJ6UysS7WYr0UTna4izpqTow6Dwkqd1Dezt5wnM4qrdMBEDdLCWh
 DIff0TEXZcuJiHBFOiFvjay4Hp0NjEGyf56Y5bLGDtGrg1dOvYMCBcuRDr8tAhYlTUP1
 3ku80s5bRob5hYaFosIhGjUuP13FJQbJgQsFveGMPCzkF9opze66UxzVs01+1omiXTyq
 TNDBTWWk3NLb1NR+L62u43G6yBvKXexjVm4N1aunaRMQ20Auu6U20GH0TsyF84q0FoVZ
 6Srz6oyjbGN2njDXpovUYCzuj7nHDAW7vQMg/MCzd8mMWO7AxAu6uh4F3p2iyOpBJxEc
 sPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526293; x=1746131093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaHx7PNN69uqV2de9T5YysFFHIzKyvP4EvVdC8GWNAs=;
 b=KrvyOv2juFGMVtlqRsTfbWoGND6jAiypMdZc2MLHHb0nOzPbbrzwo4KO8kQkPRqSBI
 BpGQffsHfFbBt7d/FGdFsxXHzsWKiREx0NkfO4SFrWS9SrabnJKsXBMnCuluSkyAx3rm
 464kbuW69fFuoae2gpJuYP2nK/hR6sRuWl8ludaVKKoVf3ejnAZvbNXIdFyZ177ExgzG
 dz6Lg3zodhwUkYYcRkMadPTr7YCJ6/jArgF0EX+m8pUoWQYmmAndhJFDqQIBTcRQ4pRZ
 MkoLpCDl3nH+V7JsA3bkGTf0Hi/sOpexhKP6egWOl/YHi0iJ0vEmQUpZjV+2RQppsY/3
 OSsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO5UkBZnTc5iwikERWVWhbVYUf/sSVroXxAx+kc6/4uO83p0lbuu+SOl4DLZgmOvgJB+pQ9ADKQO9G@nongnu.org
X-Gm-Message-State: AOJu0YzAyREiql7EsGGhddEcZnGGc6/WZnuPgGqTH45VnTdNHJ1v37Ih
 7MU7KAbnH/grenqgpeWadmIiH+ixKmzaszMH7DUycEzwqQZIhbaXYInw2FxnCXg=
X-Gm-Gg: ASbGncupoVyWnyDf1aWSH1T+XmICvLkti2wSHmHc+lQRbG9KhKwBA+rTUaQStOyPbjW
 ldlEDWdipeCuZqDvI0DTcw0U/Ra1hOA7nCuJhdxNvO3sARHjNALzwPXBFN/JZt8VYZIcQE2o8a/
 ZYznmAct1nUAwUY6TvQMAc7Dfqw5TZV/2i781w03luXEMUIqU5H2iREX+uxSNBpj2bgG/6sreqL
 Sw2/xkMy+noCJDL93uYun9wmd2KTU7NhkrQJKNfP2YJnjJTTqChda6bb/yb3yOelWi+ejt/O4+p
 3JiI8tV4VbVNUU5ULtCoEwb6BLGJjAaATm7BhXCEEzhFwdqOy6eOfRDssAXku7AdWDoKjxJ/G/T
 PTeS0sl3C3A3gZ2Ec9zipixf2RQ==
X-Google-Smtp-Source: AGHT+IElUpZnYDaGRaHAEa5jjcLfMkJ32QiJ1+OX4tGAXzB9cqy+qIFX1iCKX3YMe0FfsZOCmv8pwA==
X-Received: by 2002:a05:6000:258a:b0:39c:119f:27c4 with SMTP id
 ffacd0b85a97d-3a06cf6385bmr3375891f8f.30.1745526292987; 
 Thu, 24 Apr 2025 13:24:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c9ba61sm300067f8f.9.2025.04.24.13.24.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 08/13] target/hexagon: Include missing 'accel/tcg/getpc.h'
Date: Thu, 24 Apr 2025 22:24:07 +0200
Message-ID: <20250424202412.91612-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since the macros.h headers call GETPC(), they need to
include "accel/tcg/getpc.h", which defines it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/macros.h       | 1 +
 target/hexagon/mmvec/macros.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index ee3d4c88e7b..6f82277a415 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "hex_regs.h"
 #include "reg_fields.h"
+#include "accel/tcg/getpc.h"
 
 #define GET_FIELD(FIELD, REGIN) \
     fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index bcd4a1e8973..c1a88392c05 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -21,6 +21,7 @@
 #include "qemu/host-utils.h"
 #include "arch.h"
 #include "mmvec/system_ext_mmvec.h"
+#include "accel/tcg/getpc.h"
 
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
-- 
2.47.1


