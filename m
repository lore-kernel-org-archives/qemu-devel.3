Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F13FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLW0-00038t-8r; Mon, 27 Apr 2026 08:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO7-0008D5-P8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0005lD-IQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so73666275e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294108; x=1777898908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iut+4BJW06xHtE0SB3YNoS1Ssi4OQgnXbFlPQro7fSE=;
 b=p0BhjCFX3kUJcX62nWw1P9gSSM9pO2Ulh3LCYGabcPwe9KPv9cCKMU4+WJB0IR3yRf
 9h/P7KUEktTCDP0NECcoiM9XPmJNXfplVXitVSE6R3wdA7t6NARL2HKHo347eM0Tme+/
 QzEZqB4G/Y+tCyCe46JH38/ih37B0YmZB7L6KS3ofQbu3szuQaPGleVxh2U7oKMzeFnB
 SBmARPA0wnq7oXm7uYNhDTSbJ4rXHTMaTOuIGvXPMxCZaKEsyIORkyHqy0dBRnXF0gMM
 08gwYd324ppcz8O/ZG8PZ9w1yPup1TwqRRTXIvOnHH7J9WPFTHYipuusnE/gsB9C4Tr9
 FQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294108; x=1777898908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Iut+4BJW06xHtE0SB3YNoS1Ssi4OQgnXbFlPQro7fSE=;
 b=WPI9+3epEWe9mDGt73Nqd/MrFJ0InHzEb1sdl5x8+Gy1fLq5pcCZEtsbSbhFJ12h5B
 3XB4s8dggKZUplNzT5SSrel+9UYJbcmw1EbT95UpzevkbYU63tW4hvusMLYZO4t5WDyV
 Lr0c7qIYPsLpfYT5FOnxovIRKesg0JknTZf2yYWyXw1k5YhLI1MwEzi5LK61IOavilpQ
 rEsrjo02qLYGWxkQa2esez+gJwT9+/Lpaoe61d2er1yX38+UT0/UkEt2rLOqEE6obfT9
 kuC5gqChiiAbh9N/b5mFJRVtqO57WGeo9KWb1AiMVSUIYY8UtPkB2reaiKRRsc7jio7x
 bNiw==
X-Gm-Message-State: AOJu0YwT6/LtlR7h9R10ylQc/cGZEWucDKh9aTBizalTEfkGaUvBlBTI
 NACBTO4uc0RkZga5Haj2d8HB1gpo0RAdfM8xh2W9Mucw+zQ8JhhfeFKzLjaShbtazK1SEhxOr9Z
 7dvue
X-Gm-Gg: AeBDieuvg0yRxL65eRWtB0yova44Op91bU/ywCjUjimIdeOoXAI6jB04umvUX/idgxl
 9x7qRjacb/Q2luG1Hwn780wbL8XDY5B6b9tJUoxXh9MDnY8jVDG38BcTiDPCt9ItJ6d+HS2ZphK
 vSVBNdIPQSyt5S+Ee/Bvxy8SYdSr4FyNAGOjh7hvZZaQ0ldjJ3fZwfZlxcoNO+cEOPQqno+TX47
 oz8gEjX2v4zXoztSGhpHO51VoZ0hNNHHH4cyMqofqO/TDqybTWUtWzsbLKZSQHGTfdcnfrbyrcS
 3255K+t+wOMeVUUfHK0lxu2g2QbiXjENshIznWN1/A1FK/w0U9nY03x4VSnaYUoIfJw4iZdCHdR
 ajf/JK4wKvDNhDhKtQtYHXQSfMb9XmaQgyxKArDDgFe/b3BZ4jp5gtsiR83PXXA5uBdmLnMTNJJ
 5w1Ripe0u5Y1ycHYSWLHf216ACfatyQyDR+WjxriFOH1zmcknGXGzpgcaTD9chQTcG7kV5Vbad7
 8SwLU+AD2Xj6/F/w8naKWltJ+8JcQ56dSyPDWJexw==
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id
 5b1f17b1804b1-48a52d95604mr449758515e9.30.1777294107883; 
 Mon, 27 Apr 2026 05:48:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/63] target/arm: migrate gcs syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:27 +0100
Message-ID: <20260427124738.966578-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tweak arg names to make it clear raddr is the data address register
number.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-14-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 65d0de63a8..7ff8c30e2b 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -690,21 +690,48 @@ static inline uint32_t syn_pcalignment(void)
     return res;
 }
 
+/*
+ * ISS encoding for a GCS exception
+ *
+ * Field validity depends on EXTYPE
+ */
+FIELD(GCS_ISS, IT, 0, 5)
+FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
+FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
+FIELD(GCS_ISS, EXTYPE, 20, 4)
+
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+    res = FIELD_DP32(res, GCS_ISS, IT, it);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_exlock(void)
 {
-    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
+
+    return res;
 }
 
-static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+static inline uint32_t syn_gcs_gcsstr(int raddr, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
+    res = FIELD_DP32(res, GCS_ISS, RADDR, raddr);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+
+    return res;
 }
 
 static inline uint32_t syn_serror(uint32_t extra)
-- 
2.43.0


