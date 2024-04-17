Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAB7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1t-0008Tr-8W; Wed, 17 Apr 2024 14:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1o-0008EK-LM
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1n-0003P8-0Y
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418c0d83d18so421295e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378541; x=1713983341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlDIlSZfoByeUVHG5RjMJLlAMS8788/zBZZra99rGV8=;
 b=qfjEnzYi7aD1ajqa5SACCtHgCz0qE8UouotLgHvRT/xOwEDdHgLIaOD+fI9zN+Yqul
 NItBd80J+vKnZfH6L9Xy3eY+qZH58EjdzB+4HCNoqF6r59UXpM2MxbuNJYTixY3L4lCQ
 gl2AbxK3iLqXOkLj+q+KNLRVyi6ij3cpoz6KlN8JWJ3A/jf8uvhhLNFMwL8pN9GwoyfH
 vFF2IqmkOBnUgzWP4Awr0GaY11hSxJ7sjyWCtHdgoNbE9GrivA6+5cCw55O600ho6v8n
 sn5EQrFdnrq0wKxaf/G680jqxOPH8qQdDl6iXXUK6NrI7cg2iy/paJRTQ+fzOrZ+a7xo
 DGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378541; x=1713983341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlDIlSZfoByeUVHG5RjMJLlAMS8788/zBZZra99rGV8=;
 b=qZhSQ8rOGNsW+AWzBYDJX5yLjzO/d4mCKB++5zK7xeAuQkQKHiw5RcvYj72WwOdKER
 XUQGF/LPGP1w+9HU7F+lLrj3Cv9f424OZFdAnBMCt4112xYBpL2VSMpsILwbkS5d2sMB
 mBtKkBBhO13Oh94/yokyGbPOKntJA7vnTbRO8kxRpUup9Zt6WP/mpVJLW9Z/iGokHpbm
 sjTjNz6hNV8Atnsx8wVbAl0vSM8e+BcSwwzNNo7aMzQekMA46xbGptQ1sohjP+VyBP1n
 6qHjXpSutfibbPUr2VoDhm3kSBGhaZjMWbAjINFZzp6cxmLOZHzB88QOnltnMZDljVCJ
 RYrA==
X-Gm-Message-State: AOJu0YwqagPYVRTFkN06RHmuJvUht5vExKueWoakhGuJO+MshIgLT3GG
 2dR8S+pKVFIDHNpZhiTRo/96c5zI7UwX5LQeepeKwrUAjsoF15+RIklAKuUoFhxqJGoSQdITsKV
 /
X-Google-Smtp-Source: AGHT+IFpCDR1im0pL8miSE+XAVlwllAQsWIrDhZaXJ777ZA8z3G2y+sw1Da52CKJfR8A6Tr50eGtlg==
X-Received: by 2002:a5d:4049:0:b0:347:f7fe:135d with SMTP id
 w9-20020a5d4049000000b00347f7fe135dmr74713wrp.18.1713378540796; 
 Wed, 17 Apr 2024 11:29:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 g4-20020adfa484000000b0034330c9eccasm18314606wrb.79.2024.04.17.11.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/21] semihosting/uaccess: Avoid including 'cpu.h'
Date: Wed, 17 Apr 2024 20:27:54 +0200
Message-ID: <20240417182806.69446-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

"semihosting/uaccess.h" only requires declarations
from "exec/cpu-defs.h". Avoid including the huge "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-6-philmd@linaro.org>
---
 include/semihosting/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 3963eafc3e..6c8835fbcb 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -14,7 +14,7 @@
 #error Cannot include semihosting/uaccess.h from user emulation
 #endif
 
-#include "cpu.h"
+#include "exec/cpu-defs.h"
 
 #define get_user_u64(val, addr)                                         \
     ({ uint64_t val_ = 0;                                               \
-- 
2.41.0


