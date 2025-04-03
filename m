Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888C7C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKF-0001V6-16; Thu, 03 Apr 2025 19:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKB-0001ND-20
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UK9-0000hJ-7b
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso7108195e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724215; x=1744329015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDF3v2bQG3D1D/TAN/dJYz9MV3sitzpGTqOBdLUJDgo=;
 b=sczgrsPaxlXTm63KzPiXNcxxA2uVgNDjbDusMx/qF++Xs0JCDyH4NHiXXkORX6YKZ+
 ghemcSwgp/98jWv5HQ3hqJCHxx3u8h+py85KuyPlUfcxLLbdv6NPLYli4tHB+3AmVGRv
 pvsZsFakkxONewGlvyrZHJooOgr5f5yUcuOJmFjllJ3XEl4sjDfJSlFM9KuGqZcIIewL
 SlXYcYbCocJ/ps8eXlU8wbwot3T3fkVgGlnLeRLNOL9pa+TXX/4CXDWlmNKyd+wOCdiz
 KS71OglZwl4/4K+ZcRvD4IeC4X/2m8r82w788TM9Qi1jcyHFFFKwJDUN4Osrw6m/y2zX
 SYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724215; x=1744329015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDF3v2bQG3D1D/TAN/dJYz9MV3sitzpGTqOBdLUJDgo=;
 b=bKNw/gTa5W8xLh333SV8Rt9kDMjfUj0+ZCgsYHbLw0zi5L/K4bDbuyJpFtwMVUp3na
 QeugAMjoM/g0z3xJMczVM1WRXQFjNIvS5eb3BWhThuVJZ17mQHQ5Cq41YKfpftOKLWg5
 zekAIK6YFpCtv0Mo5aqBCHCDEvBlPBBhutF/7zb9vRBCMKi0x5lLtusJQKMcIoGbWlkM
 dwY21Mzd64Vq6xaJuYSosgsIo2FTzYpaqaGka724oE78CEiSgxbbN9uB+/xBg53OrMYL
 jpE332FM+accPdJpTrDeUX207k4zV88v120pt/J9p2XKbpDdLhv+UtjGrmTO3fOJ20K8
 kkPQ==
X-Gm-Message-State: AOJu0YwUmrCst+O36WrG6ieU1CZ/dtFMpSV8e2TJUUhMAPRtByFeIKRq
 FkDjToH2JzNIj6H0x7RZpFIGwhEsqPG5Yu1uZdhyesRDU2ioZoxWU5GCeZh17Ru9V6CQSjTirSj
 +
X-Gm-Gg: ASbGncuaICY9qjRf5Ah91aroWqbAAzQhATk5OqI3lImOdh8bWx5cPJIvc1B5DIJ2K1b
 5zWfpr+ojV9XC1WxLfypNeDbVBMluSoI9qBLGQ9PJWVQ98FYzLAi23B4TF7mw+0Q6QKhEPc6e4R
 mw34tg2vwCM+CMxiLuCxiaTjt62Co0Fi+Yi9kugDBSntrT3qNe+eWExo1AIETAALaE+ASvU5gzJ
 PlqTeKQzxXMfMo/pFi4j2isfCiSA0il5WFyHdJB5t4pcoIuJrFq2RsAsHUqVynqP/laBQYeNNXI
 yTsDx/DMtonkC8W0xN0Bb/o7UwElQv8b4k8B72xCwDhKzut4ZG74kvoNWWQ/ky5Om4P027xqLyB
 HyJ2dGuVHvSPXKnHieNQ=
X-Google-Smtp-Source: AGHT+IH6VzX2CqKWpfEPEV+geA0SbkppmehUfV8m2k1croxwKzPuZNzifpmxYAYV2SmJY9Htfaj0UQ==
X-Received: by 2002:a05:600c:3548:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-43ed0b5e285mr4871085e9.4.1743724215280; 
 Thu, 03 Apr 2025 16:50:15 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226f2bsm2980657f8f.96.2025.04.03.16.50.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 09/19] qemu: Introduce target_cpu_type()
Date: Fri,  4 Apr 2025 01:49:04 +0200
Message-ID: <20250403234914.9154-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target_info-impl.h | 3 +++
 include/qemu/target_info.h      | 2 ++
 target_info-stub.c              | 2 ++
 target_info.c                   | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index 8fa585f8138..d6d671a03c0 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -30,6 +30,9 @@ struct BinaryTargetInfo {
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
 
+    /* runtime equivalent of CPU_RESOLVING_TYPE definition */
+    const char *const cpu_resolving_type;
+
 };
 
 #endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index 66c43b329cc..407ce328e85 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -34,4 +34,6 @@ bool target_words_bigendian(void);
 
 unsigned target_long_bits(void);
 
+const char *target_cpu_type(void);
+
 #endif
diff --git a/target_info-stub.c b/target_info-stub.c
index a5374caed6c..7d21675d4c0 100644
--- a/target_info-stub.c
+++ b/target_info-stub.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target_info-impl.h"
+#include "cpu.h"
 
 #ifdef TARGET_INFO_STUB_NEEDED
 
@@ -17,6 +18,7 @@ static const BinaryTargetInfo target_info_stub = {
     .system_arch = -1,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
     .long_bits = TARGET_LONG_BITS,
+    .cpu_resolving_type = CPU_RESOLVING_TYPE,
 };
 
 const BinaryTargetInfo *target_info(void)
diff --git a/target_info.c b/target_info.c
index 2fd32931e13..4ad205636c2 100644
--- a/target_info.c
+++ b/target_info.c
@@ -41,3 +41,8 @@ unsigned target_long_bits(void)
 {
     return target_info()->long_bits;
 }
+
+const char *target_cpu_type(void)
+{
+    return target_info()->cpu_resolving_type;
+}
-- 
2.47.1


