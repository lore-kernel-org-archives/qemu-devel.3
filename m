Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0968DE74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZhF-0001ko-Ll; Tue, 03 Dec 2024 15:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgj-0001SO-3k
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:06 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgh-0003CQ-Df
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:04 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29e8a0323c5so754717fac.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258401; x=1733863201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9CTXOrxugfzuYrJxFKkXFLZxqqX/88/ScAMxLj979U8=;
 b=X4/LBCLmeX1yY3NJUwMuAE83mgYKPNtB8AiTYNxoUDYCYVFC5XA7l/sSHtcJ/OsvLb
 KpfW0mFesyruGDxYcNysb9dD6muvcR969dPi2KFpNXoes8zzf2AnFMcQn47N7SBNpSCS
 El+tfNjFnByE2Fs4k6nzurczdpy5CLvw6EsMt3pgUnlBz+Y1YKtxBHqSG8MEuHdH4I0V
 wvbH0FZrXcg9EVit+pPhx6qaVrF2/lORjuWqSva0NbID1fjFowfE7qFdeMeiUUeLG9IB
 Y0bwu/0yYkORp/D8PupqWngsZfSS5jyWAeYdWpyoRBZYZ1ye3FA+I4TVa5SnyWzADwxK
 Fz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258401; x=1733863201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9CTXOrxugfzuYrJxFKkXFLZxqqX/88/ScAMxLj979U8=;
 b=dvdlsXsqZaCSudnB/yoa3iN0sHgarQI/H4Mu/0HOIoO7coVxxBdRiv/lx9dqaIgfN2
 IU7Bf9kE7z+V53zORCqzQj2QNfg0UIwN0ichKeDPlGWFaL40RQmTEvMnN5Y4sxidD0wY
 PPuHHSqdZ7WhiZIGhFjq6m+qLXzVZ66SIlDJ9b1s7S2zzEFZwC/n/BGbNMHNekDxoiPh
 xtMVxdBAVBEemC6nMJEZXF+j2zhYCZtGkeIq55v6omy3RFOy9nx5qAhFZN+d1gXXLPVy
 GugjM2SHx+a8segslF0TKdfdFmcMtdzoWZiYnADFCDb6QnCrTDaUEB3Qo9VFww9uLqpZ
 bfag==
X-Gm-Message-State: AOJu0YwQ39MRV/6WQvhbSfDoPGc776srznuvMkPd0anTqmT5Hda5e0Ab
 fm1q+4dypP26E6j1NXUzVaAvXUzzSkpjbo6xDQc1NZTXLe78s0cF2z/hAEbGvRwnl9p+VRGMvwO
 I/wg=
X-Gm-Gg: ASbGncvPk4g3Pab9RfIapWlO3mN59nAVGYQzbuP+/DT2JKmwyTyZK81wdd5i8bXwbII
 78gI2X2FlmYUaS5Vy4FB2ZyBSjhP/QBWHG63dEp7VOW+lVfyLk3+AsGA/F7U+d56bMIny7LF+gt
 NhZRoKkVr43Tki9fCwvgaovg3xcVlEKHuDCXLqjneuOS9j2jbEkcwsoktww2KD1I64tHwOfgdPY
 V/Pht6ejm8e9mGYIQJk59x/gPrcWkuigbLhgKqGsRWEFmU9Swowb7dnYRpDGZLU7gBcMPBR/5yy
 83iIvmPvEyo6RlBL6UXzKnvBkvy6TW90w2dA
X-Google-Smtp-Source: AGHT+IERUoWYHJbMuZmE3p2MvSK265Sw+xxbEZivqx6xbuCQuxe+JTAlMy3ohxlXsqB/qdpU7B3f2g==
X-Received: by 2002:a05:6870:f14a:b0:297:2376:9b17 with SMTP id
 586e51a60fabf-29e887045edmr4033744fac.19.1733258401068; 
 Tue, 03 Dec 2024 12:40:01 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:40:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 10/11] softfloat: Sink frac_cmp in parts_pick_nan until needed
Date: Tue,  3 Dec 2024 14:39:47 -0600
Message-ID: <20241203203949.483774-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Move the fractional comparison to the end of the
float_2nan_prop_x87 case.  This is not required for
any other 2nan propagation rule.  Reorganize the
x87 case itself to break out of the switch when the
fractional comparison is not required.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 099f1c48ef..9a2287095c 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -52,11 +52,6 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    cmp = frac_cmp(a, b);
-    if (cmp == 0) {
-        cmp = a->sign < b->sign;
-    }
-
     switch (s->float_2nan_prop_rule) {
     case float_2nan_prop_s_ab:
         if (have_snan) {
@@ -89,20 +84,24 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
          * return the NaN with the positive sign bit (if any).
          */
         if (is_snan(a->cls)) {
-            if (is_snan(b->cls)) {
-                which = cmp > 0 ? 0 : 1;
-            } else {
+            if (!is_snan(b->cls)) {
                 which = is_qnan(b->cls) ? 1 : 0;
+                break;
             }
         } else if (is_qnan(a->cls)) {
             if (is_snan(b->cls) || !is_qnan(b->cls)) {
                 which = 0;
-            } else {
-                which = cmp > 0 ? 0 : 1;
+                break;
             }
         } else {
             which = 1;
+            break;
         }
+        cmp = frac_cmp(a, b);
+        if (cmp == 0) {
+            cmp = a->sign < b->sign;
+        }
+        which = cmp > 0 ? 0 : 1;
         break;
     default:
         g_assert_not_reached();
-- 
2.43.0


