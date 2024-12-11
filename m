Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3DBE77185
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPT0-0002K1-NN; Wed, 11 Dec 2024 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSo-0001SS-Gv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSm-0007ua-DT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434e69857d9so5486745e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934082; x=1734538882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1xX8e653UqvPhJfMFTssKOZTmDKSbqOxXbCRuKU7FMk=;
 b=tnes/nuGgLsyQMmNqwS190Plf2AhfFK+/w2coH1UEo+kkPNkpsgFvvvjOKAq88K8gY
 Xkw9n4M59GWnD+XtiH4zbpNMYqbq39NVZuVWoiAf7rry+n6ETaVSlG+ZZUTzBdD/4PmA
 w3pLMAducC8lF2gjHxcjM31a3QOB5zhfgDUmXM3O38MWygoZmuLkpIN/qiNe8HcaDrTb
 tATBPVmhd/4KgwjoStbLt191a4MSrZhdMi49D3aATlqK1jsN+qAZoJOLj34/bqdS20pa
 VvPLdy2m0QkX0ufS+nIozYxw4AyItuxtlwdzVNrSbm3ma4l6HH2uMlzH7BkeQ467XWsS
 esoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934082; x=1734538882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xX8e653UqvPhJfMFTssKOZTmDKSbqOxXbCRuKU7FMk=;
 b=HeXlD9Nm6krHrddbS7CAwbXBLdeFbCop6pNyxuZKdmEdhxHVjL1ryiCjX9rAqjHdsU
 VzdGtE5Ht7jV0ZIPHgDuSafbQkcgwSBxvy1liApUH3D3ukLfOVAsiFZbA7o97AEIcmMd
 x8gM0qf/cf3tLgPJxbhA0EXWUrc6T8Dbdm95Yc7UR9ndrd9W+qhpdiCgwq1ysCnO6jeh
 Eqg07ZupwhViULLDHgAAE6pTDrguriodrEyoBGIqM+DYpvFyK5H4DCN397rwAfU3ruB/
 CVwJU/o4jNoEcvzBKg23sMhXUO2L+YIuWN3HNIBlD1QWUXX+i7pZQOcm9wVjkvG0ypYL
 /W9w==
X-Gm-Message-State: AOJu0YxD7H8EQkqDlgwcxopVeG2yNdOrokNaEAIUmcfeM7+aRcUWYaHk
 LjxFVxRDyFSXyS2ZWCSAUEZ4IaFpOGzup4gF+gSNgEPfe9HScQ72KXlJLTJIzXzQWtmmjPnFhcg
 3
X-Gm-Gg: ASbGnculf20kfr+DHVhWgPHbTigEyJr8H/VP+hjiP5h29Y9c01Fml+rHbT757DzVDuQ
 oSkR/7lBZZ4PgE34RUh+NWlm/OjEFQ32ASc17WxdARwJREhWBAkdLduTI+gtJGUlMe8Z4JkDR+O
 yBJlFC2ySnoSwRDeai+VDMgmpMm7HzFRz0F8vZP3LIV460buZrrW8t62NAuIFnw6wFLWN6epCvx
 uKP337fuDXz1gSoQqitXcrBrQRqdvu0LMjmBoCF0ei6w67xkKOZBBtzOFVo
X-Google-Smtp-Source: AGHT+IEiTMHt2U8u3uL+OcmHkA0mZMo+NbFE6U1FJ3+6vgzw/RgXs5wsl8KsrFv+EmkSq5hFfIDH+A==
X-Received: by 2002:a7b:ca57:0:b0:436:2155:be54 with SMTP id
 5b1f17b1804b1-4362155c09amr11155535e9.1.1733934082324; 
 Wed, 11 Dec 2024 08:21:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/72] softfloat: Share code between parts_pick_nan cases
Date: Wed, 11 Dec 2024 16:20:00 +0000
Message-Id: <20241211162004.2795499-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Remember if there was an SNaN, and use that to simplify
float_2nan_prop_s_{ab,ba} to only the snan component.
Then, fall through to the corresponding
float_2nan_prop_{ab,ba} case to handle any remaining
nans, which must be quiet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241203203949.483774-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a1b148e90b9..3c77dcbb154 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -39,10 +39,12 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
 static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
                                      float_status *s)
 {
+    bool have_snan = false;
     int cmp, which;
 
     if (is_snan(a->cls) || is_snan(b->cls)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+        have_snan = true;
     }
 
     if (s->default_nan_mode) {
@@ -57,30 +59,20 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
 
     switch (s->float_2nan_prop_rule) {
     case float_2nan_prop_s_ab:
-        if (is_snan(a->cls)) {
-            which = 0;
-        } else if (is_snan(b->cls)) {
-            which = 1;
-        } else if (is_qnan(a->cls)) {
-            which = 0;
-        } else {
-            which = 1;
+        if (have_snan) {
+            which = is_snan(a->cls) ? 0 : 1;
+            break;
         }
-        break;
-    case float_2nan_prop_s_ba:
-        if (is_snan(b->cls)) {
-            which = 1;
-        } else if (is_snan(a->cls)) {
-            which = 0;
-        } else if (is_qnan(b->cls)) {
-            which = 1;
-        } else {
-            which = 0;
-        }
-        break;
+        /* fall through */
     case float_2nan_prop_ab:
         which = is_nan(a->cls) ? 0 : 1;
         break;
+    case float_2nan_prop_s_ba:
+        if (have_snan) {
+            which = is_snan(b->cls) ? 1 : 0;
+            break;
+        }
+        /* fall through */
     case float_2nan_prop_ba:
         which = is_nan(b->cls) ? 1 : 0;
         break;
-- 
2.34.1


