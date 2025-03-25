Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84590C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0b-0002sm-BU; Tue, 25 Mar 2025 18:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0K-0001km-KE
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0I-00075K-BA
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224341bbc1dso120713455ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942653; x=1743547453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fPwSz5GvcZ1Wj62YV7bWBMY5Lb2GJ48t6nbamWgO3Q=;
 b=ocRikbaxEWCtd+AFga/lyUo/gpyxwpTBEj6z0kQcOF9a4X10hhRO92983EhQpcoJM+
 /E2gpLffWfGQkIl+3iR/gLrE5ySTINq2xE8xjvejydLCP0KO/0rqdiFjLcTqCj6ed54B
 x9T1WgGcDL0Aq/5+mUmB9L9ogi8X3S0LnShKyaWi7WlsdWWtT62H0Eg0QwJtnKlDemS5
 Au/EHFRbTRGtBJveXqJi141qK5MbgcFlb9hJiYiFfy9SEIbv/JR06TcwTa6GgAk5YN2z
 2l6IGYz6G/Of5XPacpc51fDKKhhiZRpQX6kmobbBRc7ca/6cLf2Y55zdabnxbgmX2hO2
 CGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942653; x=1743547453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fPwSz5GvcZ1Wj62YV7bWBMY5Lb2GJ48t6nbamWgO3Q=;
 b=UNb17CJGtUdO1oOX5q4PnnEckaCIWDfJePx6vd49KOShxl3vf7h2bf8mplTUtjuNuk
 z9d4uIqJd5Q/ISSf7KRuytZOFuPRRnQ05ypLV3IjxZF0JbC+E4BBXvw8MFJQIdcjMY9n
 itHz4Mz+SFEYjEazHQNRscVZhZFOof0WDsoABcu+1c7/uzLPm64mF638hACBzdaJW6Cg
 txCOGda3qE/dWYFJlKu9cd55BDQ4g1r1G8Fnn+ru7LBCbSAfbz1jO4U+KVuyoM2Vaa3e
 yZiau5WhiJRMlse+yAEqPWQ2K9DKXbq/jfuYI+SRPhdM8PeUHDtDu2UGdEiX81n7alyS
 GgOQ==
X-Gm-Message-State: AOJu0YwwRQ7M7jbavZzSx+sYt80uPC5T3IigCCR0UaTx5N1d8pbN31fw
 iImsIJ5zKoeCw64MFQsWemDs49JAjY134b9gyiZCt7RcjhMvaw6Ia38aV7ak0h4outJpZnVJP7Y
 b
X-Gm-Gg: ASbGncvyeASlAYctHZmYUJ6wjkM4ZiDwezU2m1vgNhRN5FIuNvsgERC3uMVkSxtprH0
 7oWGa1Pa/0nf1ZvUlK19heVC0u8FtVbnnB1swL1k4JkCgWKx9FPlpS2Kp+lfM+hWO5S/9hFNqyp
 bTb/MKIq+WDGLxtG3aU8LxlHTpQ7RDReYprIOzrQ0rFaAk18vwM+8eQwDvcAJoPIUkOdiBXm/S2
 gjl12S5IuQ0Li0a71yzOww5/Cj0G5AIuqNzJ8XeCi7EGn01aHNwID78Wrc86FI1lsSoku9CZ2yN
 6Bzi/o1RUqa4N9FXVWv2wH0h+yB+wuF0c81aCA/q3jgEuw9CNulVFTmyQ69nLoi43HjHGwP8AQ2
 BHiV45LuNHJM=
X-Google-Smtp-Source: AGHT+IEn8+sU8CpFQ2NuIKfaB+YMFzhBDTbw6HkdVOvQrNXUHdgR26cnN+BHZ4EbS2CESbdr/0YTIg==
X-Received: by 2002:a05:6a00:ac4:b0:736:4c93:1bdf with SMTP id
 d2e1a72fcca58-73905a275famr27519160b3a.18.1742942652681; 
 Tue, 25 Mar 2025 15:44:12 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 11/11] target/avr: Increase TARGET_PAGE_BITS to 10
Date: Tue, 25 Mar 2025 15:44:03 -0700
Message-ID: <20250325224403.4011975-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Now that we can handle the MCU allocating only a portion of the
first page to i/o, increase the page size.  Choose 10 as larger
than the i/o on every MCU, just so that this path is tested.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu-param.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 81f3f49ee1..f5248ce9e7 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -21,13 +21,7 @@
 #ifndef AVR_CPU_PARAM_H
 #define AVR_CPU_PARAM_H
 
-/*
- * TARGET_PAGE_BITS cannot be more than 8 bits because
- * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
- *     should be implemented as a device and not memory
- * 2.  SRAM starts at the address 0x0100
- */
-#define TARGET_PAGE_BITS 8
+#define TARGET_PAGE_BITS 10
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
-- 
2.43.0


