Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C0E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPl2-00018U-68; Thu, 02 Jan 2025 13:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPl0-00016K-R6
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:17:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPkz-0006yE-7R
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:17:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2165448243fso190727745ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841836; x=1736446636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=v86gR3SAdMufn3eEIhZPHlvSKJg4zdVzu0sUwjBXQko=;
 b=vFqHcoD1yKSCbecBb+Jwe60kPlOzihgLCstzQzYvA2axShKRRIKrJclMwGmYPv7BKq
 IjysaXmRkBYr1rr2dxkCGLgLD3xNlYrkHSSy+KpJEnuUYpq+pIZBayUu1gD/9sJmIAyH
 nKS1tFhWGJUVK5zKQjEqHvXg6RxPwhPIdxSbUTcrY/NvLqTnry3mGKnCULP5KgVun2pD
 BDllXDvlTOq2YzQOxxNIWLSVdxcaj5eUdYKegLguQPrAzxAIQUMXMNFF0A9hmsIGKj7a
 YTqH+6GKvM892CLPYbIZo4zn9znod6NgPfBoa9mER/0wsK9YmrYFaEY8Ni6ScP0uzf1J
 rmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841836; x=1736446636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v86gR3SAdMufn3eEIhZPHlvSKJg4zdVzu0sUwjBXQko=;
 b=VIXq0Sojbkb8Kqp4fQHDjOwuEKWR4MmseWQH4fLjakuyBTl78DywZmfG/ZK7DCB9Ot
 sJ5mOrJExZpUxBj3PQd4lVxu0QYzfeqsxYpHvuvXup3Wzw0Elt8rs9QkVsR0L5rXSOQ+
 vun1IVXlUtXgDVKKR1lffBjdqkmjWVWgXZ+z+wSaFOwWFG1mqCI9ug92zWu7COsOMVSO
 6G9/l7ApI+U6Dxdkgo6/cYJ9Ap3FiZTdQFlId4mKoyS+FFMwY1a2StcjEUaQXzuPwO+l
 /bGRFG6xmTvlf7eZ5bmeda66fYpI5p1RQadGSYbnL7tVUtDMAdnXwt10/r3SvPbY03XU
 YODA==
X-Gm-Message-State: AOJu0YzOCZO1JDwO15ndHIgs1m+4mgStJfZzSO/8SHHrdKDkNBrWke0c
 MhWnY721jLMuUj1aft1ZuupvJOQ7Wvs3zZNpZafYHWY01V4QUUNIS6vYRiDPiWkgxS8XtbwfCrp
 u
X-Gm-Gg: ASbGncu6QrFnenmLHQngdgKory7LKl+z4r5svIodu2zh3pL/fhh7IP/fVbNlLTSG5Y2
 kXNhGNoyfVxf/Oc2ukU4y2U/9KNkoSzNLgXJPzllja2F7JmtGG1+/kWXKVirci/vvFwaOT2cY7D
 2l5r1uK8Bbvq5GMlAqvyXzhZpQozxiW3mJGtnBTFWGff2JhsjskbYBRVxHaci9tJdukGkTVDk7w
 B8dWVLty1lYK9tDoC9Jc33RPRyIUVuQrUeQCOWjUPwxc0XLaL82He9K4jf3dQ==
X-Google-Smtp-Source: AGHT+IE9wjtr182CavrXH+dG7XOtjPHcaZElhrQU+C5iwsOpx7KlCZ+XXhvdpVzdx9XigXTQ79JpUA==
X-Received: by 2002:a05:6a00:392a:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-72abdeb7855mr74508679b3a.24.1735841835713; 
 Thu, 02 Jan 2025 10:17:15 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad815842sm24713605b3a.7.2025.01.02.10.17.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:17:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/s390x: Use ARK and AGRK
Date: Thu,  2 Jan 2025 10:17:14 -0800
Message-ID: <20250102181714.1421137-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Since c68d5b7a6af, we assume the distinct-operands facility, and check
for it at startup with HAVE_FACILITY(45).  While LA, ARK and AGRK are
the same size, the latter are more exactly the operation we wish to
perform, and ARK may have a different register rename path through the
microcode, ignoring the high 32-bits of the inputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Based-on: 20250102180654.1420056-1-richard.henderson@linaro.org
("[PATCH 00/73] tcg: Merge *_i32 and *_i64 opcodes")
---
 tcg/s390x/tcg-target.c.inc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index c35676434b..8bb4c8dff5 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -172,6 +172,8 @@ typedef enum S390Opcode {
     RRE_SLBGR   = 0xb989,
     RRE_XGR     = 0xb982,
 
+    RRFa_ARK    = 0xb9f8,
+    RRFa_AGRK   = 0xb9e8,
     RRFa_MGRK   = 0xb9ec,
     RRFa_MSRKC  = 0xb9fd,
     RRFa_MSGRKC = 0xb9ed,
@@ -2255,12 +2257,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             tgen_addi(s, type, a0, a1, a2);
-        } else if (a0 != a1) {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
-        } else if (type == TCG_TYPE_I32) {
+        } else if (type != TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, AGRK, a0, a1, a2);
+        } else if (a0 == a1) {
             tcg_out_insn(s, RR, AR, a0, a2);
         } else {
-            tcg_out_insn(s, RRE, AGR, a0, a2);
+            tcg_out_insn(s, RRFa, ARK, a0, a1, a2);
         }
         break;
 
-- 
2.43.0


