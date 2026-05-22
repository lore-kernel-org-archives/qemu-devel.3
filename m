Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A16FCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUap-0004fi-62; Fri, 22 May 2026 14:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUam-0004e6-7h
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:28 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUak-0005MQ-FW
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:27 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso4036492a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474445; x=1780079245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXEFjIA2Rc2Ly2XJsgxo/zPmqwc6w9LU/oPQ8iHupDk=;
 b=jHj5bquY0cq90bX4Lgh86t3Rh+hTCXo8c30fXZo/zWVN6aadbw21UURN6CyjwqWQ+H
 YEffA2y+LxI4jxMKlmSYlEkU0ulM9wgI1sgZU4ouwsMG6sn2C3WAL18km/u7NVoKjYZ2
 1BsPTC4sz+haRQ+B9ZRdwHekwaxff43d8/1juyEB5NO6sKCe2oKIKRJf0ORqibqdHsEG
 2MCVy6TZXZ4jC9zVMs/OAWIfyIuTL6Lgj1S7CGmWt7yeQurOBdnt/Tx3KL1tvZM66pzt
 AUl04PCZASgBy7SrTswuaXVzcR/8phWgO2fmg/fDTR+lRhOCcq3y30FgPOsZe2huLtSp
 wbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474445; x=1780079245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXEFjIA2Rc2Ly2XJsgxo/zPmqwc6w9LU/oPQ8iHupDk=;
 b=YtKjjJBSZ6eqE70lIQQOMNgqbEx0JfwljaZELFCVS3zenD8N7BqKfK22GlOGxpP0vS
 UQH70lYEY//vybTGU+qB5YOWRzlQGZYjwFmZTRoUddsDSFQbsjyNPk3mDnqzuR2Nf8SY
 0L7t4vjbzXChYjbkvl7YreL1NGa9lZiBVBg6G64qEvJeEm4LskJSftQGrXLUZMRq/7FU
 Qe7c0u4DDEeI/NoUtfjB9BxnfnXL4cLaswe1nn8hFBz2LnwkrCy0jHxEx380lX53gWex
 GNmRIQQH7aDE+4MQI5xdpSkvLBcAgCInuRUbpHiTDMcrp8P2BRCXL8smR0TmCJPd2FLH
 0dlw==
X-Gm-Message-State: AOJu0Yz/0j+pHVTE03B3VJiBiprVuI4hXYtqhRuCCDTx9vLsxqC2v5/R
 cRVvpHe0+AKCmthOfNT/sw2XLJ8v0IAcDyCZlmDPBP8CAYPdBwbllaS1jYzPhuQ/rwcA1cgUDhY
 IW0sL
X-Gm-Gg: Acq92OE5iZ5NnnrOQVy/TWBrj8YWOLU/3cmfXBQzI7ms78Mfmy3l1AC/30KvzocovKl
 hxokHgji5iNrRvb6DiQpEaFs+393RD2Y8re+zgmtWQNLgD980K5I+R7TuVsDo3JUQ6/Ff1bgmH5
 9GT3Y1PTxkQgJEMWHL3XLAfytz+xh4xfzi8i44wII/3OBmsY5uKtcodBok3aG5o1Y3NRXLqtlv4
 nLgiJFFm9nC88Al2eZYSLfZYs+ZWN+xFYbpZyB3ApH5Yq90ED9nxZs1ae3Ov+rp5tQmx4790H5R
 O6+UKOPuQhL+haD7R9aq85V+Qn4zXh3OFCMdTpDKLfTm/NzJAYaA6+fTGXtAZWGV6Mjjq++IXFA
 wz372mytPqTaubXKjbGT+h3gEhQBTLsnDs6SlXh52UCBUJB6N8v5RSd6yM9DzxsP1H5FHZHeYjQ
 iDS0f1LWxqgSJi0Zr0dooiHf7TAFmo
X-Received: by 2002:a17:902:ce92:b0:2bc:a52c:c8fa with SMTP id
 d9443c01a7336-2beb076ead2mr50178885ad.26.1779474444810; 
 Fri, 22 May 2026 11:27:24 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/30] fpu: Hoist nan check in partsN_addsub
Date: Fri, 22 May 2026 11:26:32 -0700
Message-ID: <20260522182658.184604-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

The nan test had been down below because it was unlikely.
But if we have to have one anyway because of denormals,
we might as well take care of them right away.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 437b333341..3246702289 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -530,13 +530,15 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
 {
     int ab_mask = float_cmask(a_orig->cls) | float_cmask(b_orig->cls);
 
+    if (unlikely(ab_mask & float_cmask_anynan)) {
+        return partsN(pick_nan)(a_orig, b_orig, s);
+    }
+
     /*
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if (!(ab_mask & float_cmask_anynan)) {
-        record_denormals_used(ab_mask, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     FloatPartsN a = *a_orig;
     FloatPartsN b = *b_orig;
@@ -558,10 +560,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             if (a.cls != float_class_inf) {
                 /* N - Inf */
@@ -586,10 +584,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             a.cls = float_class_inf;
             return a;
@@ -604,9 +598,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
     g_assert(a.cls == float_class_zero);
     g_assert(is_anynorm(b.cls));
     return b;
-
- p_nan:
-    return partsN(pick_nan)(a_orig, b_orig, s);
 }
 
 /*
-- 
2.43.0


