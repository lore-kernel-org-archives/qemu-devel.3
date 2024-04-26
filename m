Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1FEC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RTg-0001FV-MG; Fri, 26 Apr 2024 15:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTI-0000wW-Ls
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:02 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTG-00030Y-79
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a58bd410f92so281666066b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160576; x=1714765376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DE5bQD16xfwEMndgjcE7z1cuHvznf4KEW6ZfSJ0m28c=;
 b=mtLD3cryCFwGKpctZkcO6fJCInvNr+xo6odVYnQX+roWWGoDY3XJ9or/wh5SvLjJ9J
 NPY6N5eX2SB9uKZ6dDCptDxUqjgNn6p395lSeH6YFP2+2NeDIvA7B+mvbGTGV7AXa5ea
 MpV+BBH3w1FJPILlCfD4kW9uThOO+VPbqa0uMvPF0NdC+B8IlipBxCZ4bpnyvNkL3JIf
 v9DbIX/uPwABEXxXinVF+Kji9vKOz4SXLDvR+/NzUiEVDwLGoF40qBVU7VTfsP5pQEbz
 4pTk8hc1zAIXBX7yCm/39lX81kFqxcMctRu7+gbiFxVkkb77hoPYbXampp85NSbJWFmZ
 086g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160576; x=1714765376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DE5bQD16xfwEMndgjcE7z1cuHvznf4KEW6ZfSJ0m28c=;
 b=i2bzVNmz2uN5av9RpyUmaj3u7VveYzpvIf/y8mzw9w5FyYw0ZG7rVm44a7BwO1N9Cw
 vou23Z6WhIocCq1rNDjsZGx/URQuO95C0ccEiDiMB6cRgXJRwhJLjVuqOHA1AnQ56Ew/
 S3+8SS77yN7u9cNsfk8WD9euoS6ep5OISuKPJJAEXIo2nQHtRUWoNwpJlB5RllC2Wb/h
 NskoRrY9ddsWM6mMp4lR0EXOjntH3309fKdMEYKZRjyuW1KM1yNZES00TN+eVV/7X++3
 lHLufL30Xv7CICkF6TxaUsC0wqauhVgyKAd/j8l2zfxO6uIWmZXJsTb7tAlDu7yYZqy4
 aixw==
X-Gm-Message-State: AOJu0YyiaLl6ynh5kWSFjZQVKgZVaPb5FIMevSCVV5wNiwIgGKN/qkan
 +iBUzTrdgQs9NXQMbqHp8gyCPj671d9HBRTq/J5a29c6yIw59uKO2IFe9VqnwGeOwsOn3qt5ifT
 0YqE=
X-Google-Smtp-Source: AGHT+IHuivKhc9k4NJGWGfSfiujJsFGjDjDNF8PSddUqhuzyJQcSFexKwQKV1AGdJzYCFcbsEbYqZA==
X-Received: by 2002:a17:906:b0d8:b0:a55:adec:7139 with SMTP id
 bk24-20020a170906b0d800b00a55adec7139mr2412387ejb.60.1714160576443; 
 Fri, 26 Apr 2024 12:42:56 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 n1-20020a170906724100b00a55bef9ab56sm5775865ejk.120.2024.04.26.12.42.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/38] semihosting/uaccess: Avoid including 'cpu.h'
Date: Fri, 26 Apr 2024 21:41:29 +0200
Message-ID: <20240426194200.43723-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

"semihosting/uaccess.h" only requires the following headers:

  - "exec/cpu-defs.h" for target_ulong,
  - "exec/cpu-common.h" for cpu_memory_rw_debug()
  - "exec/tswap.h" for tswap32() and tswap64().

Include them instead of the huge "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <42c6471e-8383-45e0-85ee-e20ca32ecbad@linaro.org>
---
 include/semihosting/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 3963eafc3e..dd289af8dd 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -14,7 +14,9 @@
 #error Cannot include semihosting/uaccess.h from user emulation
 #endif
 
-#include "cpu.h"
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
+#include "exec/tswap.h"
 
 #define get_user_u64(val, addr)                                         \
     ({ uint64_t val_ = 0;                                               \
-- 
2.41.0


