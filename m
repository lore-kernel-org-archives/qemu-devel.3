Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50151CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yQh-0001a6-Uh; Wed, 01 Oct 2025 11:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQR-0001Ks-3u
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yPS-0000ii-TH
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:07:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so29897475e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331178; x=1759935978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXiufQH5EAW3mbZqGPR1CdCZqjBiKmbzGv2nAPHWxfY=;
 b=pXhjnL85IyKt+hGjHeX6IAZANq3pAU5IPQ/uxm2W9DrYfqV6ZJ7r/iAUtC6csAmOnI
 s0Wfk4ligFfyKxl1lvxCjewflBeNjpXbrKo2MLd+3Mh7lz9csV14xGyEbRmKp3CfOUGI
 2utrXljI6Ww+VP/iypLvYmBQul9Ve9uKpEdAZWhx2xI0oiUkRbeBoz0wAIUIuuPyVjGT
 Nyb3NMZzEuaSbFThXl+AOOyyZW9KyBb1LIAokG+W4HLg5xLD5q7nUTvit/5VvJlElJSa
 1aHbZDMz7vKCgBNHfZG1Hb3ZgGE4EVSo2L8DS95SU1oVds+AIvxveZpFiOXB9o3qw6zR
 4b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331178; x=1759935978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXiufQH5EAW3mbZqGPR1CdCZqjBiKmbzGv2nAPHWxfY=;
 b=l791/BcEf6um0D90deYOYi9TgJVZBorHD0J4iqGE1zmKaCpMDa3OcY9RIeLdFeosbb
 y1SB4urztXKXsi1YoXMEfRt8mv3kKgCc+h5DufuuTg/FIt5nroX4LR1UC9m7gATu8qyF
 JQmAmvOHGR+aYRlJBfhHkhLXvamY9r+HfKeOSt58T0vpa8IwfK9yLZ6/q6kcWe7W6V+3
 u90f6Kx8mtM34XjLzjA7HCoY1Bh1EKQe3Tz58diTcEFWtAVZaygUmcEgDAqh0wGQP+vc
 6H1buNjAkygHbfD+3F/a45Q3sVWzryhp3+P/ghYfBKyQ1KZ/7Ex1IvT3gBfdxiGXg3pf
 uN0Q==
X-Gm-Message-State: AOJu0YxxNV0c3jvp+8WxRpanqMG6+ejIbz0QzlhNAaXjky94emZ0+2U2
 1vA9jEK8Gy2DYQS0GwqXN+vDsEx+jP60nzrdnYLdW68OR9x3C8J9y0lmZ4jwziC96J7XL/beKan
 lqU+0tklCQA==
X-Gm-Gg: ASbGnctDFvuI04LsfEY0aOyUCJDbgA/0viRKdYLLyWEuakC5b/ylpAonIvPABLzAWk6
 p/3af1FIguIpxRmBF7+1lm10rMfxgjSTc91bJboRBWR4qNxdVyEivCi6d2CjALo+TxUfxg9MBsW
 oVzlujaWsbc9eephecA8EiNFioo8/4GYkD6KWvdQUyoe9p649fDv6bR+4edlDEItoedsY5br3Dv
 8LePWu0LV4NiRDrF35J0OZb9rZSobjbE0KnJY65kjIi4PvloygdTbQR/WIr9nRHCfCS71Oz4Zcl
 qqOYxz543VHpBA1IDp900IOYvl+GoeK0tGK0yYvaX+9Hu5S7D39hiAhCYeQ0BaTazbkpkc+VuwT
 F3pU4fmJ1YD01Ggr7sNQ8QgwNwmLZ8g0VIOA3jB0HA3AxZQ+qHtqlOXXZpcYxZoIpSMNdaJDQm+
 m/UT8HJM95WRJ6YMb/EQYV
X-Google-Smtp-Source: AGHT+IHBUXklOX5Spm8syYkMk9ISyumF021Wa7HC8KxhD0Lb2XRrKY7V61vtZJg6R5cgGsRJL8zBcQ==
X-Received: by 2002:adf:f70a:0:b0:3fd:3bcc:c239 with SMTP id
 ffacd0b85a97d-425577e4affmr2382604f8f.5.1759331177796; 
 Wed, 01 Oct 2025 08:06:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603161sm27834537f8f.35.2025.10.01.08.06.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/22] semihosting: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:14 +0200
Message-ID: <20251001150529.14122-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/arm-compat-semi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 61001267965..4c282aea5d6 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -149,12 +149,14 @@ static bool find_ram_cb(Int128 start, Int128 len, const MemoryRegion *mr,
 
 static LayoutInfo common_semi_find_bases(CPUState *cs)
 {
+    AddressSpace *as;
     FlatView *fv;
     LayoutInfo info = { 0, 0, 0, 0 };
 
     RCU_READ_LOCK_GUARD();
 
-    fv = address_space_to_flatview(cs->as);
+    as = cpu_get_address_space(cs, 0);
+    fv = address_space_to_flatview(as);
     flatview_for_each_range(fv, find_ram_cb, &info);
 
     /*
-- 
2.51.0


