Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8D9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7a-00020d-FA; Wed, 24 Apr 2024 13:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7T-0001zB-GH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:19 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7R-0005Mt-Mu
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so1221315ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978556; x=1714583356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w8fmNK6lWstHDkHAiX3GTp5ypgknN5T6iIFnYWpyosQ=;
 b=aJYTh7RrI9l9gg6BYo2p55gIN9ximdsaeYUriOnIwpjHbFUTMQ0BFpSrmHIH19x8xs
 SmQ+zdaf4ic4FDxgF1oe5S76zPUtgFjRi44yRqIG+Htz5PGckhruplSk2sQHxrH3CcUX
 HUjG7dvWfcBhkoAPBKaat66FVOusmcy3/7P+IQJo110xLYVJh+XFWSP7DIjDz4oaR1l1
 XVCWDWUDvNMeXGCYXiCbrtrgnF5+ESTCmRrEcz1DiZcrIClmM/pr+hTPRqrsXxqnZsd6
 tkx3+iTP5mQDuaODgQ1Yks4Ts95+FGW8mmrGRHcJOSALlXdkKfOEmFswjxYSzFjm2w02
 W9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978556; x=1714583356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8fmNK6lWstHDkHAiX3GTp5ypgknN5T6iIFnYWpyosQ=;
 b=fnspTB5ng+KCViOTxxHnnFXSKAXKQN7k7voALoPto+xy+BF38+3YckjugG0uicuYiO
 ZO/kmqcSH09zsq82VfATR+/4hV6rIEz+9C0osMP73rTGdQU2Uwa320tbcmWN5K6anzMY
 Ktn8oZcW4+8HCLx11uFVHPxXIfT+du/Ejni7VeJtHnZySE85W1Pe1vI+kgSl3tOgHyUY
 wvp8g1d0vQem8QQljE9uh5XyZTJmQ1p14Ih1keRZxNJH26hyTF8ov1jIV5ytkTlPjVRx
 OvkqesmcQWzZDtawYhj9sORSWhwe+QGOaa5xEdRTYuZw+Zk7/1qmEEnuv4xGQoDy08Q1
 QC1Q==
X-Gm-Message-State: AOJu0YyYscTXx/ikZjadpDU5JHttQ1nfOXV8+3Bp5E0XrG2CDiGQECy0
 buBbWHb7kfBvt3uVGQd+nx/tqgGrsVM/Qze5KFuw4wh0TitzYd3GxzcvpjW862Mkd572UvlO9A1
 c
X-Google-Smtp-Source: AGHT+IFzf1W/uabRb1bkLAVqusgu4GqxiBa8/gftHoDHYhBmMqipipZkMapO6iGfHppE1ARhUwuh+g==
X-Received: by 2002:a17:902:e149:b0:1e4:3c7f:c179 with SMTP id
 d9-20020a170902e14900b001e43c7fc179mr294478pla.12.1713978556088; 
 Wed, 24 Apr 2024 10:09:16 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
Date: Wed, 24 Apr 2024 10:09:06 -0700
Message-Id: <20240424170908.759043-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
References: <20240424170908.759043-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

This may be treated as a 32-bit EQ/NE comparison against 0,
which is in turn treated as a LTU/GEU comparison against 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6837c519b0..59235b4f38 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1658,6 +1658,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
                             int const_arg2, bool neg)
 {
+    int cmp_rexw = rexw;
     bool inv = false;
     bool cleared;
     int jcc;
@@ -1674,6 +1675,18 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         }
         break;
 
+    case TCG_COND_TSTNE:
+        inv = true;
+        /* fall through */
+    case TCG_COND_TSTEQ:
+        /* If arg2 is -1, convert to LTU/GEU vs 1. */
+        if (const_arg2 && arg2 == 0xffffffffu) {
+            arg2 = 1;
+            cmp_rexw = 0;
+            goto do_ltu;
+        }
+        break;
+
     case TCG_COND_LEU:
         inv = true;
         /* fall through */
@@ -1697,7 +1710,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * We can then use NEG or INC to produce the desired result.
          * This is always smaller than the SETCC expansion.
          */
-        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, rexw);
+        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, cmp_rexw);
 
         /* X - X - C = -C = (C ? -1 : 0) */
         tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
@@ -1744,7 +1757,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         cleared = true;
     }
 
-    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, cmp_rexw);
     tcg_out_modrm(s, OPC_SETCC | jcc, 0, dest);
 
     if (!cleared) {
-- 
2.34.1


