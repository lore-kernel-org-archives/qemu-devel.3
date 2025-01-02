Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D5CE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbA-0006x9-Um; Thu, 02 Jan 2025 13:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb2-0006vl-SO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPaz-00056w-TE
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:06:59 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21634338cfdso227776615ad.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841216; x=1736446016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqJGVcj4WVAzQUDTHqtmH5ZpB1qepIgknwutcY6cZjw=;
 b=i3er0YOhcUueO+M1IdXZ9Qn4G87T8JVP32cNrL+cgbAN3Evf6HbFehWwrYWiv4ZIey
 Xn7FvN/oEe40om7nwVEWsKC0DHC8FJNi+6RpVCGtO/kg8Vnvs9MDqCQq31qiS1zcRv/6
 Yc+6C6oHa2RLuNlAiBKP5214A2BQQ9+brONQYYt/lmTSYCkTXUToB+Q2JS43+J4+1+w6
 OLn4mXvcXAVY4sCGI8cGbV5YaJou69+uNutUgsq5d7FHKm85es3yqriVB76xT7EtRR0n
 6cNTv4d0Y0DdsYXxuDnRX7NS5fOFQA3yffve+OO0hi9nXcBDUf4wYlHBn8kYLBM9fs6A
 o9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841216; x=1736446016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqJGVcj4WVAzQUDTHqtmH5ZpB1qepIgknwutcY6cZjw=;
 b=YrgRzTn4bKAfyl8CTSwbTLukBKr81I8oVpO9BwgsLyKd4ewQFNdAFQ4FqoQHh8BUDJ
 0aYwFlcvChXyESK4RQ+UqgM3hP3b3S7GrWh/bN8Xj+p9cfvtcd/j9xU1sgo4uSfZC+3Y
 xS863UhzUWY4jajNU1yCileqlzvlK9OvJhBIZSmqbYhlgKcMIlTpXK0LUE5c7CxArndH
 yk+M0ekRMm/itisi/G605WKVV7rawfiJGYHhbW+sfEn13bz5d531qwqSIFseS/iI0djk
 OL4rzjLCBT9LX25/Peoi5+4zazMvJQsRP/lS++8/U4sd7Qorf1515l64AgmAWA8GFOT+
 ix8w==
X-Gm-Message-State: AOJu0YznPOM6mCCDJjSnZG27RKcW6H7lvj9+YRerOmd3qXoPMzSlF0W5
 /3a7mTINfyd2YMJ7526WcRP0q4mcUOi3RNijzNG5SXxJH9AShwfIkTJJ7hknIxRhtS0YFVXOrkr
 O
X-Gm-Gg: ASbGncu/26HW0BifnAaYInPnvZbSfZh2z8Sq8Elvpy1zUukpDL7bqe76lhg9Oop5msK
 MRb8CagZ0uPiBl1y7CDyP64+49z8Ty4htUJlcEaSzULmrn5FV6NwYhQOZP2FX7NfKpwouy8oEdd
 kZyfHDZUt+BUThYR7DXQUEEvOQ2Qsql9u8sgv0r9qLVxuwYMdVyzLDbbE+51/i9w3uG8WPMtFs6
 niwNdP5G7Xaq0TeDoE0WgVn3t2Myh7+4yCIKEAihx7wtARZ2VGNBAsNII9Kfw==
X-Google-Smtp-Source: AGHT+IHdcWN2KZw0xTv9QMok/gOYjRP3XySRhD12NmtAtJipo/wj/dEzvq+3b5zkkq3fD9mIx1KA3Q==
X-Received: by 2002:a05:6a00:3c84:b0:725:4615:a778 with SMTP id
 d2e1a72fcca58-72abdd7a148mr52824931b3a.7.1735841216489; 
 Thu, 02 Jan 2025 10:06:56 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.06.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:06:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/73] tcg: Add TCGOp.type
Date: Thu,  2 Jan 2025 10:05:41 -0800
Message-ID: <20250102180654.1420056-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Steal 3 bits from nargs to add type without expanding
the size of the structure.  Move the build-time asserts
to the top of tcg.c, so that MAX_CALL_IARGS is in scope
without exporting that detail in the main tcg.h header.

So far, the type field is unused and memset initialized to 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 6 ++----
 tcg/tcg.c         | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a77ed12b9d..f2ffb69c0c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -417,7 +417,8 @@ typedef uint32_t TCGLifeData;
 
 struct TCGOp {
     TCGOpcode opc   : 8;
-    unsigned nargs  : 8;
+    TCGType type    : 3;
+    unsigned nargs  : 5;
 
     /* Parameters for this opcode.  See below.  */
     unsigned param1 : 8;
@@ -442,9 +443,6 @@ struct TCGOp {
 #define TCGOP_VECL(X)     (X)->param1
 #define TCGOP_VECE(X)     (X)->param2
 
-/* Make sure operands fit in the bitfields above.  */
-QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
-
 static inline TCGRegSet output_pref(const TCGOp *op, unsigned i)
 {
     return i < ARRAY_SIZE(op->output_pref) ? op->output_pref[i] : 0;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4578b185be..f8c4394e1d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -60,6 +60,15 @@
 #include "user/guest-base.h"
 #endif
 
+/*
+ * Make sure operands fit in the TCGOp bitfields.
+ * For TCGOp.nargs, maximum physical arguments are constrained by
+ * MAX_CALL_IARGS * TCG_TYPE_I128 on 32-bit hosts, so 128 / 32.
+ */
+QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
+QEMU_BUILD_BUG_ON(TCG_TYPE_COUNT > (1 << 3));
+QEMU_BUILD_BUG_ON(MAX_CALL_IARGS * (128 / 32) > (1 << 5));
+
 /* Forward declarations for functions declared in tcg-target.c.inc and
    used here. */
 static void tcg_target_init(TCGContext *s);
-- 
2.43.0


