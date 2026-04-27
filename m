Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9BCFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQB-0001vS-2O; Mon, 27 Apr 2026 08:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO6-0008CD-JM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0005l4-DI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ba840146so92713485e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294107; x=1777898907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5S8KAeqsmRZutxtlUklwlTBbR8y5t61ZVgf6mLUnAUU=;
 b=mHPzjCYfmqYUVg25M0XqTyl9MDrAOJ64QO6N7BzZiduaWvdOLWYFTMs2caEubv0Oer
 a9s94kHjXYq5mMWyd7fJE78TAlbv1ulTF6cB9oOqH5Hhb634N7qh1WW8UYIO9/zsD3zP
 DL40E3MyRJvl0XcBtu/QxyhSGsUZzh+zRtpvifeSjzvhsWvmvHPQm3Fz7xt3bLQ1p1IF
 E2Bz3lbQdibm3B+eDBQETaQ3tBbbPIbigqRX5twTCxgB6U8/NYbNzA4Vfxy1kj5KCvaK
 VWzy6Ip5/7S0h3N91O39GF6rCrs+sAF9ODPfecJBsoT9sykYilr/QN9qT3F1l39KFXOu
 GBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294107; x=1777898907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5S8KAeqsmRZutxtlUklwlTBbR8y5t61ZVgf6mLUnAUU=;
 b=FH11o84D5j6iHAkp0lZKFer+zRRU29x8fRRbSBqiINRVaFiYRO56QpXyVx+HcRBZ3r
 emctQUmX9xHxmRbzUAz1BKPO7gDSXTf7zK1eTAL7vktQIz6k1F9x83BdQ1hPqF2HP1ch
 DO8faqoa47XohooCi+ync+726j6yKO842CjkdVsKUKaeHvp6yDF1HNVroTbhpuydbx5N
 HK9MjLix2VizfH14Pxc5hR8MbjIoaCRGscU37RZGfFtVoKY1ON2KZOFf7ThCMsIbykxY
 eyzeJ0dpdLOT7lcpb0W3tVlpFlStRHauPCxVnv45ECnLxeNOHSDwTrKEBJ7jT3s6q9Rx
 IH1A==
X-Gm-Message-State: AOJu0YzVnI+DINmAqYD0SOWZuxWktC71SbpzTwR5RY3msSa5Miu5dnby
 ZkGd7yRRUyTtOGAyrzM8w1qcPjwEo4Y9PC2hn1ZPDYO/Yunn13/DyDBAapZQfnz0uJfC0qDeMRa
 7PKyj
X-Gm-Gg: AeBDietPhgPNJ3wBIasZ0e/6ITvfxXYfT5Y2I5dKWo+UcVvmTg6p6HdY5KFwLt88A+n
 fABR3rC5j+c47nT9zCXI8yOLBqHhjUJ8YT9FsGp6YhakbamTmhDFZQxQ5qZeQNi+kIvd4eXTnLW
 8LiyHqjhVzTUbFNHGeXP/YiMcbOD9ks3VIrvPD59O01bd7i/Sp2yZT6+vxZcrq8Pd2fjioiD2hN
 LEcmH07dBSdqwO7tGUKpLPLnq6FNTJB2HjsXjNeq2enlh5i05VMOkOQI4VktYgDOaVqDOmjbUP8
 dqx1SgxO4/6zFbI4QL0Wvyed9UUMFO4lvCaQ3fFsoijJUHNkMPuAQtNPnYikW4p9ym+esYJ+jEb
 UHUl6t8doJY4tFIExoVAsmR75NdZTbNtnfGk5NKJ0JpMjCuKXW90qoeoAQ+NJsBd0AhaVq+O+BS
 0c8y8wUPkgeyVN2BHnE+ndI83YYXOP2+tL7ZTgLwlvtxFJaWIYlhJYEvI0A68DvlB3GoI/cr8ZD
 s6nWOlVm+Hp5BboFeNhsjecZCKcjEnYnHZo+Dnh/g==
X-Received: by 2002:a05:600c:a31a:b0:488:b241:2c5f with SMTP id
 5b1f17b1804b1-488fb785b7emr459072625e9.26.1777294107076; 
 Mon, 27 Apr 2026 05:48:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/63] target/arm: migrate wfx syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:26 +0100
Message-ID: <20260427124738.966578-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This will help later when we expand the fields we report.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-13-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2ad6b97aea..65d0de63a8 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -655,11 +655,25 @@ static inline uint32_t syn_breakpoint(int same_el)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a WF* instruction
+ */
+FIELD(WFX_ISS, TI, 0, 2)
+FIELD(WFX_ISS, RV, 2, 1)
+FIELD(WFX_ISS, RN, 5, 5)
+FIELD(WFX_ISS, COND, 20, 4)
+FIELD(WFX_ISS, CV, 24, 1)
+
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
-    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
-           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
-           (cv << 24) | (cond << 20) | ti;
+    uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, WFX_ISS, CV, cv);
+    res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, TI, ti);
+
+    return res;
 }
 
 static inline uint32_t syn_illegalstate(void)
-- 
2.43.0


