Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF56C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlk-0008A4-Oe; Sun, 26 May 2024 15:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlj-00089h-Lg
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:42:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlh-0007cX-Ry
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:42:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso1324795ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752576; x=1717357376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyfYhcDz9GxZwfZD6zLLHvsedkNWvuKT9dIKJJP5Q0E=;
 b=NW5SmKS+mx3nr8EF/p2dXGCHrz7oyxF+p/XM5q1XAkwpmTeAEI2AmISN2WmGc10YBe
 uOna6uh7HjN0B95zIylg0AbJLIJYdoMudwR6TWzN+NKc/QIUnnhIqsP6JkF5mIu1HryG
 kw7NPxrPPSwwnSn9m/OGEP4RrFm+iS3pHxMmR2ZCoqZE7WFWo/IYRDO2F2WAmdsvra8N
 CG7qHTNn4jFJYIHDTFf80by6Rpgy5yoWQrPPh0YXCnKbE2FWqV0IQ1gqzZP2fXBjmUTF
 pTMPV+NpWZ1Dl/Xm2mKX7N/ulWhyZ5U1epHlphOlg79KEpoyu1q+BohKZmHK6JrqOSGj
 8ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752576; x=1717357376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyfYhcDz9GxZwfZD6zLLHvsedkNWvuKT9dIKJJP5Q0E=;
 b=bhPlh3uUVa6/AnysUXPJa/tvuVDE0srvzdUNN8050HBSGeLyVpxP84hkOwMzoQs/2s
 b7VNbDrwtlTdoC/RkGfxwNYLcPBEYTxAcFC8HOhMbs9nC7kWOLl529NulNyzLS7wV3Mn
 t4Sxm+7id3vWCPoW5R4uhc/cY2eVK6er4gHElJC7tayfG0PBy8EtQLTyoMPDaRKf55Oe
 e2W3N0P4Anma2uElXjmdYcgChgGKKjB05+OFc598ZHfpc68SpaFn0plxrFFDyqS2P7hT
 yRhwJAj/agqynbQfi9CohfU50BAFR/a0WjXD1+IeSDOBZKg41kccg0R1LsE8rkC8NKk/
 ElAA==
X-Gm-Message-State: AOJu0YxWhI3ap21EDj4wAi0iCZy6k3WXwDZWiJAu5NT363YpE1XKXnGZ
 EHtcVN8ok2Ocx+iCUiUsYKurxL3txUUBB77YNjH1l1RBu69fApyM4o9pDGLdz1DSiWyWAf/s83J
 H
X-Google-Smtp-Source: AGHT+IFP3t4op3u6JPOrG8yYwAm3/CBbeGyR1hIM4RlvTxWv53PnT4hMaUZeyJJq+dk8YdxjpqbmRw==
X-Received: by 2002:a17:903:245:b0:1f3:903:5c9a with SMTP id
 d9443c01a7336-1f4497e5d05mr85622535ad.58.1716752576243; 
 Sun, 26 May 2024 12:42:56 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:42:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 01/37] target/sparc: Fix ARRAY8
Date: Sun, 26 May 2024 12:42:18 -0700
Message-Id: <20240526194254.459395-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


