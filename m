Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C5AFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwN-0001iJ-L4; Wed, 29 Apr 2026 20:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvi-0008IW-SP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:07:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvg-00020E-VA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f943870baso166971b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507613; x=1778112413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evIVo9pnvW/9sfTw9IqtjENxooeS3G0aeAGVgjmZkec=;
 b=v3OTeXFcAI2YsSjzsX2mL8/tH+pkoNVtZml2UmLUu2XVG5RmWJK1jhk3PHzVW0ZwG8
 dmKN2QrGTE7dZshIGReucFSvNUnT23x+oEL+tQQTUGzaMpGXR9XbzLVWyrvAfjGh8T9c
 6eVinZBwdF4mV+aD7+0yQdj8/e+aD6gaSQUDnqIt1dMFEL8SFKhiLrTBy/0xCI7izp8k
 SoKKOAd9r42NxRhs06j+zqH/h0e2lozTdXyfzc0y6dfNqgXP7kqmVQ9vgWPh0xE7xCRt
 b8N9YZ8zhEaH8MdKPUZR3OKvYnlVaJhnVo+roN2eNvhXZBdfHBVlKoPiL6MrG0GkUmZM
 2+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507613; x=1778112413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=evIVo9pnvW/9sfTw9IqtjENxooeS3G0aeAGVgjmZkec=;
 b=SRxEu2oiz2T5/OmAL+lxNT/xIoVrrwzVuRxdkPArxiHjSakAsLeVqyzckkdP/H/ooY
 dqMAaqZHi3GS0S8DaXCWj4Ls9bd2MvZuHDsWgBPvQHMnAioZb0Ae0f1oYzlPEW7MyfPG
 XD5r5zs8qu65l6v0mIMferPk2t9fJroStUnKSLSoc16WDmw5ERltjGZDn6HLBa9XP09w
 gfILtulxFMaN1v7FkimLq/KSpTSwFXWbuB7PigXbW1Gx8UbkF/WIwb9HUtea/7Erp7Sk
 wtAowJrKHkRHgXiYZDAkS8hhDc5RpcFqGw/pkIaHiT9ZHpGSxkdNIHlJpaV7JQOGP7VK
 rZ+g==
X-Gm-Message-State: AOJu0YzgMHHVg8O80xpvW8agt6WNJCmtKFjcx81NAp8aKIlB2VouoCZT
 Q0hFAakq5uWQygplcYyzYBXZEASh19KbQalvbywpy9ORSjXDqHUpgOA943SDrpcw5VkuD9iiltF
 bCVjl6xM=
X-Gm-Gg: AeBDiesBPeTkYH17b9CLaYX/iO0itpaBb/H6F2QQSux8RojZZnqJvb7Ebdq4Z3mEluS
 nrZ951hIFtJSBMNkFv5uTR78PAUv2BGL7o9zciO6DorCYWLD7XxA6KxQyzqKqvOki+/wqWXCLpz
 8YpZaNQsgbKU4SrVhaNtmflk1XABdiMSe/oSUeBda7hfKAMSwh6+fsxWwomFvU6zN8bad0dp8uP
 jb2D6eU/WbGGC4TNdAULUrXDQSl8OsCZGI0QA9fkYRWO/vHv8cajHY6bbJK7S0NR03AjyzNCwr5
 qfHBTdhWgkTRjJ+cKfG/LgOg+wJkMOWDnrbOc25ph6uuD7ftiaP/HhubB/fOM4CDBPD6mG7+g9S
 NqGOThy63by/W9TBq1q5RwDRJfKbbudt0IQk1/r7j8d8uYrl6pbllRDe8G20Q07Eucu2hPcCxKp
 7dRgK/3P/hbnYvykxKEJ7Irro7HlM0Qpo8rJfMLuii
X-Received: by 2002:a05:6a00:2e04:b0:82f:238f:b5a8 with SMTP id
 d2e1a72fcca58-834fdb95979mr818181b3a.9.1777507613310; 
 Wed, 29 Apr 2026 17:06:53 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 37/40] fpu: Return struct from parts{64,128}_scalbn
Date: Thu, 30 Apr 2026 10:05:20 +1000
Message-ID: <20260430000524.56046-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

At the same time, export.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  3 +++
 fpu/softfloat-parts.c.inc     | 14 ++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index a24678ea2b..7170cc7b6a 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -223,4 +223,7 @@ FloatParts128 parts128_round_to_int(const FloatParts128 *a,
 FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
                                   const FloatFmt *fmt);
 
+FloatParts64 parts64_scalbn(const FloatParts64 *a, int n, float_status *s);
+FloatParts128 parts128_scalbn(const FloatParts128 *a, int n, float_status *s);
+
 #endif
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c380f30fae..6df98eb5fb 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1607,22 +1607,24 @@ FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
 /*
  * Multiply A by 2 raised to the power N.
  */
-static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
+FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        *a = partsN(return_nan)(a, s);
-        break;
+        return partsN(return_nan)(a, s);
     case float_class_zero:
     case float_class_inf:
-        break;
+        return *a;
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        a->exp += MIN(MAX(n, -0x10000), 0x10000);
-        break;
+        {
+            FloatPartsN r = *a;
+            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            return r;
+        }
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


