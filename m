Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBE1E8FDA3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 14:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ8Oa-0005Zc-9j; Fri, 26 Dec 2025 09:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1vZ1Xi-0005vH-TF
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 01:43:19 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1vZ1Xh-0008Mo-Ew
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 01:43:18 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so101956625ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766731395; x=1767336195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8UqSM7Cdrp0m+S5aTDcKcvy6okhbuaqmG7RZGRZff2w=;
 b=VsLO5MHb5iyGo3CYSM1mw1g8JunlnwW9xR0LGd7nnasGz+eMs6WYPkZ5uTBLuUwgky
 ETBfb4td3kQGOGaesNgmiklFM1zBzxIhfWdg76xTaabeqHnUrQ/IKVWkbRP5TpZ9Lknk
 XNMAIj4bt2XhmWw6afD93X0BWy2mvQidtvyCjSurnOnWdjWQCSFaIjSxGKtGaYEwSotC
 Jj6W5ENCqBD463eeZ8UvHv9ICFVAmypEIS5SncTINkh2NG8DRZS8jZx/OK0OqEyE/XUx
 fa+4PLNryRrucj2AOLJR2PG1Iw+1pLXDulOMMIPBK7PqBVEoPKp14z1DHwkn+a7GwZ76
 mB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766731395; x=1767336195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UqSM7Cdrp0m+S5aTDcKcvy6okhbuaqmG7RZGRZff2w=;
 b=CnNYzpSRQYSiuQ+J/6XhlHWADN6ZDXoRJMRQNBlmUTfeWQtv/wXthXYvhNKENozLuN
 HPpgZeSYOe8w6lZH4FGFfLrwmWuZk9SZ5GcHnUwUqJmhk2lBkkHgy2vtSZoDdqtqPAQu
 XKLIIlMhdh9EmiyUlc+yTXJwgCoI9pywA1LmpbzK4+0zqIbe++1zToPKn3Wd+4ZOqd4T
 cZq2nlluvve2rFrWgZxbXBqR0yc5Fw/6/+TPGJAhCOLeyZW7z35w9sVbyr8bEMphfZDR
 7+bOU7Z8iGOgD/ZchePy5QOUPGG2lvDfAFPqmtucPN+7nwkJB8L66KYVN0XNbjhAYQbV
 ig2A==
X-Gm-Message-State: AOJu0Yw1TLNVYo4q6Yak1BCyWrA+OmnTAVMUCPoq+3ALvybCHmKjvLmW
 AaPnHRv2x3rcN7JqhC2gVxYUMW8rHItwfgIvKIf2mL6fLosTeCCBtB1qM67au6bd
X-Gm-Gg: AY/fxX7IDJVzf0+awh95kVbodtp22zm7LPOLCPLpx2yPjLK1/LqhN+NusplVtLOhPmR
 2ZhtmgzCm9aPJJepXnoF3VJdM6OXrHkZDm7auX0TaGHFBYnCjlArzHgVgNhSt/Lzomxq2dw5IrL
 5zF86WGmvdRJFxlnQI/mXuxo0/63IqiWaUKqciTIg8B/iBvbzq74vUlgiop85CIYCmPhngsXJUy
 k+HvFDHIw9cECg4NtDy8SLgqH0gKAmFSR+Raskb06hq5dos89ByZOQ64WyWayd2yGcUQ1Go/KM+
 xJyONkhWOoHiiJ5OmcanX0KlWqyXL09iiYOMrRJC9qXZOtaMej0hlXOOXQGELNWZL21Z4aZZayB
 dZl1TxU18364IU8oxkfQWnLu4PIJeEZdy8j7fzwot82yIOfaqGpSRmAq7Q1ZAL72TjCbB82xltw
 SnURFIW+ZMaNPID/9g6GyPifXctBDHkdAhqXmLgg==
X-Google-Smtp-Source: AGHT+IEyCloyq9pElrZo4wzt96RSvV3CDMRZk20BXmlYe3q/8kZLcjIFkWhUvkfT3Exd91FszWVDtw==
X-Received: by 2002:a17:902:cecb:b0:29e:940c:2cdf with SMTP id
 d9443c01a7336-2a2f2830f73mr207150705ad.36.1766731395167; 
 Thu, 25 Dec 2025 22:43:15 -0800 (PST)
Received: from leeonlin-linux0.corp.google.com
 ([2401:fa00:95:201:2ce6:21ee:93a0:6263])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d76ceesm198125235ad.91.2025.12.25.22.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 22:43:14 -0800 (PST)
From: Li-Hang Lin <lihang.lin@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Li-Hang Lin <lihang.lin@gmail.com>
Subject: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field deposition
 in rsqrte_f64
Date: Fri, 26 Dec 2025 14:42:25 +0800
Message-ID: <20251226064225.791454-1-lihang.lin@gmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=lihang.lin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Dec 2025 09:02:14 -0500
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

Fix an error in rsqrte_f64() where the sign bit was being
placed incorrectly. Specifically, ensure f64_sign is deposited
into bit 63.

Additionally, update the comments regarding the exponent (exp) bit
width to reflect the correct double-precision specifications.

Signed-off-by: Li-Hang Lin <lihang.lin@gmail.com>
---
 target/arm/tcg/vfp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index e156e3774a..60188b2c7e 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -1078,8 +1078,8 @@ float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
 
     f64_frac = recip_sqrt_estimate(&f64_exp, 3068, f64_frac, false);
 
-    /* result = sign : result_exp<4:0> : estimate<7:0> : Zeros(44) */
-    val = deposit64(0, 61, 1, f64_sign);
+    /* result = sign : result_exp<10:0> : estimate<7:0> : Zeros(44) */
+    val = deposit64(0, 63, 1, f64_sign);
     val = deposit64(val, 52, 11, f64_exp);
     val = deposit64(val, 44, 8, extract64(f64_frac, 52 - 8, 8));
     return make_float64(val);
-- 
2.52.0.351.gbe84eed79e-goog


