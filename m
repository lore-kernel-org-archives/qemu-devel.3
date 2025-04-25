Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577A4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2g-0000jK-IA; Fri, 25 Apr 2025 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2M-0007xs-O0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2K-0004A4-69
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so10620065e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595138; x=1746199938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i42zncYDJj+7V6lhX3vVncwg8neDoexdB0xoCfEn4dg=;
 b=LqisazSAZe1ifM8LnenafJeG/2pT2+wEFWqQEX9Mnyg2NqsWhG4OFtbaQR49JVWBop
 eZC6t5aW+8CYMoEqMno68pjlLGhp78Ldgk6443HBWfsuLoR8pcHpeI5mz5TpU+uO8i9Q
 I9QNkwnzCg6fZdw/Iiyly7Lcz/c3lmZrQLZ0sBNu/BJAZa8ZutPGqSnARK9GAUtkqMzo
 uZqVYbq47JvvhyH7JJcdOwD/LTihYmz+U5AjW+DtQriGXnsHFsoy1lWON2can3q0JqOu
 /OBdVBPxzwkyVoyzfXyez+HO5r2SgSGvRudcftG/64KlnDieWTtofrAlp6yMeKQ9FJLx
 ecEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595138; x=1746199938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i42zncYDJj+7V6lhX3vVncwg8neDoexdB0xoCfEn4dg=;
 b=lV+S/HB1h/xtrdE8V1pNK1wU/Yu435BkX5iFHfLlM/izMwf280+t8W2o1n/6dGYTnr
 cPaNd6PTri1ISBB/NgBv3SE5AMAorYlavBhlLL+NQXx0UFsVPIFRKhzATPp+DQ3A9uC8
 WuIqr0hD6PkvAf2aTNoUUcJet+g8kfcLhJOIRYmzud58uhT0ZXondVmALRLCBLynSvA1
 LwJRbZFk6aLfiHKy7F2LLbgjNU0m4aI57vB57a8Y6NRy+HJ9iz8TDpq7ld6MjoGvGpYQ
 g0l5lCCmxuxtpQif95rpIRi9dIk8qmTxlQc68chkovghmyynfULlAJTc1qgtg4mHcGRU
 YVsg==
X-Gm-Message-State: AOJu0Yw9cpH+PzIqAH+7aUwZSxqV8Ud6qPIK+Yq4Tny3IobiIxFerzYr
 d4g+ic8msbXD0xQ10npTpqUmz2t4cX2PG7hfLiUA7gnr7tBGdwepWzOHfhvk4O9mkLls5CkrZuL
 X
X-Gm-Gg: ASbGncswF/Klja4Fisel3kIo99pZphqtoe44ees+FUEUI8zyIOGb9Qefz5e1WCa6fn1
 ZuV5mq57O6t6+pm240Y4nAuahOw99gJBA0aEXh8KyVdezVe4jcS3UMKxwo3tNGAYVLoUbXXwrdY
 XjAAdTEsZ0rVb0NhGtrgRVptV15nRUAriC9SB/cdl+T7j3ZRYShclItVQ2CDc/J5GXWonQwyxbc
 EOyr+j3IEy7zI1+Kdtk/ytYp96JLunZlrqxbBQnBgcBHoj/1Z0XoaZ52iZgohBeBFFz+MmV+2TX
 gc7H0i5WpSYqsH1tPRu1Rd615NLtSREe254Rrwgf3FzCrvJJAdJ4APhkAqzwLEGY0GqxUlnNM4o
 6K9IOo7pCWV48sus=
X-Google-Smtp-Source: AGHT+IG0Hjq56q+5IZLsrciCszqUlUCpwoK9mNgijXqpvti6VhQdIRxsg1qNJsz8ok3GhepIKwCa1w==
X-Received: by 2002:a05:600c:510e:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-440a65e500dmr22623265e9.8.1745595138251; 
 Fri, 25 Apr 2025 08:32:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b990sm63845385e9.4.2025.04.25.08.32.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 43/58] target/hexagon: Include missing 'accel/tcg/getpc.h'
Date: Fri, 25 Apr 2025 17:28:27 +0200
Message-ID: <20250425152843.69638-44-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-Id: <20250424094653.35932-9-philmd@linaro.org>
---
 target/hexagon/macros.h       | 1 +
 target/hexagon/mmvec/macros.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index e5eb31e6711..9ba9be408db 100644
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


