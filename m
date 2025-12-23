Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE7EE748FC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 22:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAqb-0005a2-V2; Tue, 23 Dec 2025 17:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqZ-0005ZJ-9R
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vYAqX-0007OL-UT
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:27:15 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so78630355ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766528832; x=1767133632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwRSR0ZKIOyzQJTFyNymlZJZGKDFvR8rJCkk+W5rX+c=;
 b=MxnvKsyQauqR+iWnkGMmoNtYi032jUKgkhAvNvIaq0L1ymf5CiUqCgxVTSLxalQl8T
 0P41vl6NYH7KMbCKqKYn1IdWiQwRxC0ZlPBh7zYOE+lcm/zR1rqw1n/P+eRi3Kk5DjU4
 dZU0TX9ztKutVU25XnKf75bzd6wzE08l2oin1OAip2Wk7KOCAIZ1jvmyuMnlz7ETuEEh
 kZrPCZ02Q7Rd2gqowIddeF9UGa7F19skr17l6wSI18hVCbMZ8O2MTOyFl4LSqOXuuYPE
 ErCqv0jwDt/YNH8XjgyGJ+hhLtEGDWMbdOeyZh2qbWilJBpx111kPnsw1oVdk2EwQ0Ow
 WMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766528832; x=1767133632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IwRSR0ZKIOyzQJTFyNymlZJZGKDFvR8rJCkk+W5rX+c=;
 b=NCQfL7jTh0QoHD2X3HCA8LNmFInWFn2qLgZN+oo0cUZ0ZVAWVs5Xra9ib/W9lH6GPR
 gdZjCRoxrJR53+DNJnNxGDyJcanhf4wDaih7x3ji2NC68DXiYaIbBEH+6VusDbsHm2ch
 YSRicesaRsFABQHnvVGSHk9STw7pgsLX5iJ7ajBdDqEeHXxX/2Mx+ZwI5vmhiAHg+Pwc
 t90sE+KRoAfk6gi7W5IZQmjjynQ6A1bRkMASlASLC439arw9zf2O8OVB/qdqb6/Trxx1
 Uxs2ZOfF+vkjOez4RYAi7SLUInFluoQYkqrogb5HkAG4yiD+lQ2xL/BH9az508kfOT95
 qSNg==
X-Gm-Message-State: AOJu0Yw9ip3YcqGczUzZLGXB/b7wsJdw3H8r2oOZX0OEaMW5aAxW9pYD
 LmN6E6gaNnynPrqbtb+03d8uA9mFxTJtliIkXFSdYl2W+lpHbXaAMswbZmzYNp66E7w5t+zXnYj
 hO2tn
X-Gm-Gg: AY/fxX5cicQOAyFixWmP5YLf8PwG2fQbLLyE+5sCKADHFgHT2I9fHSbHpiDNBAp+9V4
 i7s5jzrIQNhDzk2WJQKBUL7Dl7klMo3Er+SFH73UiB2cvG2ukUqbSyM83UvRzyC3rkyqhEzALOI
 dcN/AcUlSoIM/aiAGliiG4rc31vDP3c6C0+6upxFlnvmxaEsazBeVwwvqYER09FI+Q3zZSOGwKB
 zWd1PwXLivA3LkBimUqjTn/qhZxWZeo3bH3ZcyRb6QW37CLO4v41jpeY3P6sf554qQMhbJj6HAV
 hqE3qSSHqCM/vEwL31tPQZBVTSiwluBYxI+NBSuH+j3Sy1ykxdAlp+3/bEEWSVXWOm5s4nv0Q3x
 phCDMXnv9GboNxTSUNuWgGQMdb3sjDGkMxb23mdAnQwOYWAqOeEapYFyK9yQxv4/8WvfRv7br7y
 Xqn4BuxD4rbWtjHzB5OVWFg+UQOwQ=
X-Google-Smtp-Source: AGHT+IEO3lREqjy9+6Sn4w54oXKPFg3D7NA3MwlquGvj/YDBBtmHGmNjCGxSBI+6U73zaB4/h7cXtw==
X-Received: by 2002:a05:7022:799:b0:119:e56b:957e with SMTP id
 a92af1059eb24-121722ac244mr22058709c88.3.1766528832235; 
 Tue, 23 Dec 2025 14:27:12 -0800 (PST)
Received: from gromero0.. ([179.93.129.179]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217243bbe3sm62803123c88.0.2025.12.23.14.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 14:27:12 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 3/4] target/arm: Add a _MAX sentinel to ARMASIdx enum
Date: Tue, 23 Dec 2025 19:26:48 -0300
Message-Id: <20251223222649.187935-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223222649.187935-1-gustavo.romero@linaro.org>
References: <20251223222649.187935-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Add a sentinel to the ARMASIdx enum so it can be used when the total
number of address spaces is required.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54d..718d140712 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2336,6 +2336,8 @@ typedef enum ARMASIdx {
     ARMASIdx_S = 1,
     ARMASIdx_TagNS = 2,
     ARMASIdx_TagS = 3,
+    ARMASIdx_MAX = ARMASIdx_TagS
+#define ARMASIdx_COUNT (ARMASIdx_MAX + 1)
 } ARMASIdx;
 
 static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)
-- 
2.34.1


