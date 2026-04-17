Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB632F4368F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgye-0005qr-8T; Fri, 17 Apr 2026 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgyc-0005pw-Bu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgya-0002oa-Mk
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so268781f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423787; x=1777028587; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UDFEW6fwmpghtmkW04MY1hCYr7BJzDg/aTfYbw5Q600=;
 b=qQhz107s0uM/qeJdZk0JTRwE5K4w0pfvxOSHw0VSwuxKGQrasngUiBZNiYU0xyyyvI
 1kXsVNVwrhVGVxwa4zZ8fqQTMAU2IsXBCY2FWZBD0uPgwRp5ZiW5FG6AfOL6dyJGCZQ8
 X0kpUySOxVWLWc9HwXKx85jTD2woNZu03HbOaognRbaDpXWMX8PmJrDAc6DfritpwtF8
 aAqRZhxJcoC4gePP1PjpRD/3s5lD+1L6OYkF8prwMwfS8xi6LOX01CunE79KEMA1TdVF
 hjAxULCrs1dWKntni/FPHqjMdbsShiXrqdFMMBJTpEjYGMUEY+1zQq3KoMtFvtvg1dSo
 W+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423787; x=1777028587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UDFEW6fwmpghtmkW04MY1hCYr7BJzDg/aTfYbw5Q600=;
 b=rbpluIgoodhLW9KsyaGu1NUnGEfxNypsJ4lZtoTPOSh4O29NQh3vop0aj5lZId9ATu
 Y4Lh2E1KiuIFp5MnCuuFiAj+jGfSgo9/g8yXibRerAfUgGw/wXp99C3MzJyUzhcYKTHw
 ZJLS8lrgFGTXO0sb0CcYIs0dYy000qYw9YAn2sc9tyeSuz3n4aszd8eC3W3dRNDF7baF
 CzgUtmg9CDjAckMwG4SqdePfUk6Gw+FDpuuztVuWel19Y3DvxzGrRMAbMJGSPCJsYmH1
 X3xNRknMXwE44pnzT9XAccfv0wYBO1rYSE8loIkAovS9KpSawLUmFHnB5uMelJ5y+DAs
 +Y5w==
X-Gm-Message-State: AOJu0Ywu2E74H5uuDvST0qQ+EVG1int3cyxnFwpr3d1ecSKc3jXYN8xr
 Nv95/68Un5wP93/rLyQVXf5z5BLZCmhg+i8v7tpbGRn/v3n+4LVmzqdfT1ljD7bOd6fCek4jWLF
 v3XMb
X-Gm-Gg: AeBDievJJYKc5Qyuyu6G4JnTE+yGD55ZU5x4ANeLvE+ioVUeu7bJD7fJJUQz/QTsRC/
 aCPRWDr3/7SM5knjbZtV2QvDuHluTFE2fJ4v9Z61MzjE+Go6LviC488Kp8ZKGJeKq5+/Fw7mIbH
 c8MKzcEgXf7sWt/lKGEGIX2KYB4/jux7htpnb+50bcMbTPQMMtv1GZG6xECvZRFGt90LxZmTMA3
 QxeL4/KvST85QtikePAgGcVrPGGi+g6tiJU+PsXGh45SR5RE6I5xMCImhh56/ckb6lQyy7Hg2Qr
 wwR2k/PJKOF+4NTZLNqKb1vMgxliS1nQtYw8UgbquW7l+lMZQUCqVWNfnZxJdxgqllRkY1MLqlk
 ZMYZGKFAtNacxoxDURczVEww5R58tZzOKnByaIiasN0jZy9x7tiyJYAhHxdz6HLE8OPIEGKNlar
 MLiwoH+VYlSp5yJJ0Kb2FnKLBNcVOcfW14lYET1w==
X-Received: by 2002:a05:6000:2511:b0:43e:b0b0:629a with SMTP id
 ffacd0b85a97d-43fe3e0a1bemr3462691f8f.34.1776423786798; 
 Fri, 17 Apr 2026 04:03:06 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d023:c0db:d3ea:590d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm3811934f8f.37.2026.04.17.04.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 04:03:05 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 17 Apr 2026 12:02:55 +0100
Subject: [PATCH v2 3/4] target/arm/ptw.c: Add GDI spaces to the granule
 protection case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-jmac-feat_rme_gdi-v2-3-7cf5131aeb60@linaro.org>
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42b.google.com
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

System Agent, Non-secure Protected and two other GPI field encodings.

These are explicitly denied access for any processing element when
the relevant GPCCR bit is set, and reserved values when the relevant
GPCCR bit is zero.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/ptw.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7b993bb5b3..316e201cfe 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -510,6 +510,26 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         break;
     case 0b1111: /* all access */
         return true;
+    case 0b0100: /* system agent only */
+        if (FIELD_EX64(gpccr, GPCCR, SA) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0101: /* non-secure protected */
+        if (FIELD_EX64(gpccr, GPCCR, NSP) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0110: /* reserved if NA6==0, otherwise no access */
+        if (FIELD_EX64(gpccr, GPCCR, NA6) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0111: /* reserved if NA7==0, otherwise no access */
+        if (FIELD_EX64(gpccr, GPCCR, NA7) == 0) {
+            goto fault_walk;
+        }
+        break;
     case 0b1000: /* secure */
         if (!config.support_sel2) {
             goto fault_walk;

-- 
2.43.0


