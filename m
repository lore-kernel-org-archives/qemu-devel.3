Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E36C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgH-0007MH-JW; Mon, 29 Jun 2026 08:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tI-Ok
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfW-0007NQ-JT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-474303f3c72so434826f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734451; x=1783339251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ij0GPUbz1ZykJj2qp1NXd9LdWM0AfY20p8Pi5WYFrkY=;
 b=DiDGvuZ8oQmMOjhQwHa/bKE30mMcw16qF2KhJR2BIKL15Es/UjJ0wVt9MW0jYf+zr9
 7CcqsAmKOvaZ0RXlXF4P6fN7KDdf0U52OhH8kcsn04s7YRTE8xRW2z9YvviRhqCk0aX9
 cHk6R/21VyJvBncJjN4BDLE9In7WgSYmS3SGDYq/qOSe31SmEypFu77ttRy8ps1yCXdN
 IOylKU1lm+1OIJO0XjbUgnRVbkX7Ba9nSXp7KAyRqrk7WOzWzBcgmllRZf+5h4OGHaBw
 ykdH3iOt6sxQWKWgOR5aGSc8ERjBHm0hSMcWL2p04zDQ7lAQqonyCobXXvv2j8IvsD+4
 8Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734451; x=1783339251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ij0GPUbz1ZykJj2qp1NXd9LdWM0AfY20p8Pi5WYFrkY=;
 b=GckCRBo7eUdR5RcL9Zq8b1LpndmDgfrwYHy3okx4lj1BGrvLYpozVFWsK4bkakK2cM
 hUhNEX9fvnqOohsHjmFvLK7WPp7KwakWNcTUlgS5vF/Sdl97OfVhW9Rcscn2A9eOVtYs
 VyR+Zb4AmMiL6W2WgR3UQ88hTSnY+k8a0tQXdrc9Nuwe5pqHrldeCU6fRAzHV+jTgtwz
 uJIw/2I66HTB9kgZOsgOPMf/a+YBJWnotFzpOBnqdtl93vfuuAaGKKozoIp2E7Ysl6O8
 X1kJE78QrTJSKWir+Y3DeZI+qFkHQeQVau4hWP/ahmFCBcSokWyMNoisuf5NrbO/AOc4
 0fkQ==
X-Gm-Message-State: AOJu0YyHsCuJr4I0/ASpSJVgRWD522eSYT99Axv/sy93NlAk1Jy03Oaf
 8N05LnBL14Y5eBXnNV/r/pqv9pVlT3jTXgAtrGE+px1MNce2LE3IYqMk33aycFpTi+W/D/Na5dY
 cBn3b
X-Gm-Gg: AfdE7cnedHV4m8Il8FtECJhQhUW3Gk4b1kL3KupLsLEazQURLzwNegRv/OoeIZp8OYn
 QMHcO2ymnJHjwkqYYAEtROgZHcDldow2RmCJPzj6ceZ8FKtjKQPJGVHC0d2A+KUgaVGpwbyKOXY
 6snrTPi5vtV7EBWsG2gymtasMyjuDVAdfNp3PW2BLzxOCd1ud3glXzDlj714Vbyc/JWed3FvaQv
 +pwnxRrTPAAPeEikj8gCZSJG6QvRQfsZIXi6dHzYIEEL0xG9ui5rr6y5h/5snCvtPN85mzJ+8mU
 7LF5HH8pEcLNkHi7YaBv58G3xiAlSZ3prgY2ephJUDN2WE0ITbK8UMncoDvg+M63rpodoglcWvy
 MizF0xZ5ugxnauvfd90aLWbzgHqh6dXzqIgx4rBXNSH8T9h7JDx5cLirI8e0sVSETDnPYK/WSCc
 bYQer+9Nlz3DXum8qHpOjcg2kzXc+dTsq2BQwD93kGDhJj1G2lXn38mEsfZYzp7iuMXG+Nztplk
 C40l0aZ8KkAvPg0WVw+Lw==
X-Received: by 2002:a05:6000:2410:b0:472:d154:fac6 with SMTP id
 ffacd0b85a97d-472d1550355mr8042750f8f.35.1782734444486; 
 Mon, 29 Jun 2026 05:00:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/54] target/arm: Use expand_pred_N for helper_sve_not_zpz_N
Date: Mon, 29 Jun 2026 12:59:47 +0100
Message-ID: <20260629120032.1645265-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These is a bitwise operation; with expand_pred_N,
we can always operate on uint64_t.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618040718.572950-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 43 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index b2875a559b..ac96b18784 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -917,12 +917,45 @@ DO_ZPZ(sve_ah_fneg_h, uint16_t, H1_2, DO_AH_FNEG_H)
 DO_ZPZ(sve_ah_fneg_s, uint32_t, H1_4, DO_AH_FNEG_S)
 DO_ZPZ_D(sve_ah_fneg_d, uint64_t, DO_AH_FNEG_D)
 
-#define DO_NOT(N)    (~N)
+static inline void
+sve_not_zpz(uint64_t *d, uint64_t *n, uint8_t *pg, uint32_t desc,
+            uint64_t (*expand)(uint8_t))
+{
+    intptr_t opr_sz = simd_oprsz(desc) / 8;
+    bool zeroing = simd_data(desc) & 1;
 
-DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
-DO_ZPZ(sve_not_zpz_h, uint16_t, H1_2, DO_NOT)
-DO_ZPZ(sve_not_zpz_s, uint32_t, H1_4, DO_NOT)
-DO_ZPZ_D(sve_not_zpz_d, uint64_t, DO_NOT)
+    if (zeroing) {
+        for (intptr_t i = 0; i < opr_sz; ++i) {
+            uint64_t p = expand(pg[H1(i)]);
+            d[i] = ~n[i] & p;
+        }
+    } else {
+        for (intptr_t i = 0; i < opr_sz; ++i) {
+            uint64_t p = expand(pg[H1(i)]);
+            d[i] = (~n[i] & p) | (d[i] & ~p);
+        }
+    }
+}
+
+void HELPER(sve_not_zpz_b)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_b);
+}
+
+void HELPER(sve_not_zpz_h)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_h);
+}
+
+void HELPER(sve_not_zpz_s)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_s);
+}
+
+void HELPER(sve_not_zpz_d)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_d);
+}
 
 #define DO_SXTB(N)    ((int8_t)N)
 #define DO_SXTH(N)    ((int16_t)N)
-- 
2.43.0


