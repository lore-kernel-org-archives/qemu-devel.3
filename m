Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEFBC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLl-0005pk-W0; Wed, 05 Jun 2024 13:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLk-0005nR-DE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLi-0003nH-Im
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:00 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2bfff08fc29so54698a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608177; x=1718212977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QyfYhcDz9GxZwfZD6zLLHvsedkNWvuKT9dIKJJP5Q0E=;
 b=eXK00aHi4NDl+8yUogLgcCKTdEYgw7ZdkfUbYjrCE8JcfXTo9riINwxDvuWUTxbMAf
 kVsWwa+xBHCAhMBNLZPjy/ReFoiOZVArjeomqhDnxQO7Zwfq6Y6mGWG3ZrNJrFHq5zVm
 0MmrLQY9/Z+Z19Tr7DqDaQyEiE2UJY0w7BZbkaQZDWYZHKNkLRh1jMhWyR+c0r+1nzah
 RYHdaMDk1Jf0PtLZO/I4iv3urXpFMkxElZLr/DM3Znx0Aa3lGVEcA2TbkVFcMTvc3WUI
 hiT2uO6UaIC7KZ2RA+/iKO4IXAPetOoEEpxpwPXSt3/bcttRcx7fBUsgoPGQdpI/hcFB
 z4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608177; x=1718212977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyfYhcDz9GxZwfZD6zLLHvsedkNWvuKT9dIKJJP5Q0E=;
 b=T90M8kQ8hkHHMq6NfwPBCvhHqCYbwkvDPJrmKwyEBr8jrRJpE23Ngu6T/855ABR/eg
 dl6Y0+IlYoUTfFhoRs+K1j25vBMSlpba71NqazZoTfVy1kY10avJDy19xGR693PUlLj7
 nMKwIpq45kiBe+OjoxIn0+0LIpeGvBrYAkDBHpYKPjQ+eK8GbP9PumdFL+w1LsVbppu8
 Toj2bEdNs/1dbHIfKl147CeVdHUjptOI5plDIw6hh+/sMpNsGo5Aan21cBjuvjpNV6Cn
 kuYifFYZqnb7rhKbTMcQjT12SxedyjA2TIxK4yOcSIgD4F3dgfXJWobABcDEgQKMlcEp
 dpQg==
X-Gm-Message-State: AOJu0Yw1w1YwkrGXNGC6EWMeirCw1JVI34mlj8hM04kMpN1KZnSFi0y3
 4UofTCuKVUeLyWR+/3QVM8poi8hwM7OfhrsJ/Xnz+0Vqx7GAthkl1WkVGU+QglSSrlY2KcSNiUS
 x
X-Google-Smtp-Source: AGHT+IHvjKhLm2kfYnWFjQPOHh6ib/otYCEMQKaDFddpzivkfwO6RGVbl3EUiYbJuUlMt+n+lmuuMA==
X-Received: by 2002:a17:90a:590:b0:2bd:d42a:e071 with SMTP id
 98e67ed59e1d1-2c27db58ee8mr3175942a91.30.1717608177097; 
 Wed, 05 Jun 2024 10:22:57 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.22.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:22:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] target/sparc: Fix ARRAY8
Date: Wed,  5 Jun 2024 10:22:17 -0700
Message-Id: <20240605172253.356302-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Follow the Oracle Sparc 2015 implementation note and bound
the input value of N to 5 from the lower 3 bits of rs2.
Spell out all of the intermediate values, matching the diagram
in the manual.  Fix extraction of upper_x and upper_y for N=0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/vis_helper.c | 53 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index e15c6bb34e..f46fcf1f6a 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -21,25 +21,42 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-/* This function uses non-native bit order */
-#define GET_FIELD(X, FROM, TO)                                  \
-    ((X) >> (63 - (TO)) & ((1ULL << ((TO) - (FROM) + 1)) - 1))
-
-/* This function uses the order in the manuals, i.e. bit 0 is 2^0 */
-#define GET_FIELD_SP(X, FROM, TO)               \
-    GET_FIELD(X, 63 - (TO), 63 - (FROM))
-
-target_ulong helper_array8(target_ulong pixel_addr, target_ulong cubesize)
+target_ulong helper_array8(target_ulong rs1, target_ulong rs2)
 {
-    return (GET_FIELD_SP(pixel_addr, 60, 63) << (17 + 2 * cubesize)) |
-        (GET_FIELD_SP(pixel_addr, 39, 39 + cubesize - 1) << (17 + cubesize)) |
-        (GET_FIELD_SP(pixel_addr, 17 + cubesize - 1, 17) << 17) |
-        (GET_FIELD_SP(pixel_addr, 56, 59) << 13) |
-        (GET_FIELD_SP(pixel_addr, 35, 38) << 9) |
-        (GET_FIELD_SP(pixel_addr, 13, 16) << 5) |
-        (((pixel_addr >> 55) & 1) << 4) |
-        (GET_FIELD_SP(pixel_addr, 33, 34) << 2) |
-        GET_FIELD_SP(pixel_addr, 11, 12);
+    /*
+     * From Oracle SPARC Architecture 2015:
+     * Architecturally, an illegal R[rs2] value (>5) causes the array
+     * instructions to produce undefined results. For historic reference,
+     * past implementations of these instructions have ignored R[rs2]{63:3}
+     * and have treated R[rs2] values of 6 and 7 as if they were 5.
+     */
+    target_ulong n = MIN(rs2 & 7, 5);
+
+    target_ulong x_int = (rs1 >> 11) & 0x7ff;
+    target_ulong y_int = (rs1 >> 33) & 0x7ff;
+    target_ulong z_int = rs1 >> 55;
+
+    target_ulong lower_x = x_int & 3;
+    target_ulong lower_y = y_int & 3;
+    target_ulong lower_z = z_int & 1;
+
+    target_ulong middle_x = (x_int >> 2) & 15;
+    target_ulong middle_y = (y_int >> 2) & 15;
+    target_ulong middle_z = (z_int >> 1) & 15;
+
+    target_ulong upper_x = (x_int >> 6) & ((1 << n) - 1);
+    target_ulong upper_y = (y_int >> 6) & ((1 << n) - 1);
+    target_ulong upper_z = z_int >> 5;
+
+    return (upper_z << (17 + 2 * n))
+         | (upper_y << (17 + n))
+         | (upper_x << 17)
+         | (middle_z << 13)
+         | (middle_y << 9)
+         | (middle_x << 5)
+         | (lower_z << 4)
+         | (lower_y << 2)
+         | lower_x;
 }
 
 #if HOST_BIG_ENDIAN
-- 
2.34.1


