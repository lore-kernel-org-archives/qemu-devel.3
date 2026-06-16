Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD585CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAf-0008BT-9U; Tue, 16 Jun 2026 15:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8a-0004n1-VQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8W-0001Gk-N8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4624c1409c9so80360f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636867; x=1782241667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YZz7HH0GB8/vK9KUD+19bLJ7tmE5IW5AABeSFZsxDV0=;
 b=Wxtk3m4+yxXaRujtwhwFrHofVAysUz45FRTQShrbxPmI8vDk3/3ohrWZpKmwutQVgd
 2ChOYhCm4Jwab/P/SZYsobPRxk73a6Wup5ZK70jQ/aIxGiEPkQQeTssz+CUZ1vPpAmgw
 XIG8Jz7BoXoSQHsPMeTgxs8YFm9XfpYKjGYTFXyAk9aOKLr4YRY3fRZo5QbQVbBeggB5
 bpTEN9O+AhhwUD3s5aF6YBmtY4j34dx2vINXsOmWm/Jpp5IwMRN7d3RC3yww2QJiPRIS
 CAimoAQ+sy30Mxw0pdUR2PhRhprGxB3T/lz92HXL7j9JlOgIJWGjVMfd3mNgdYnF0H5O
 hEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636867; x=1782241667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YZz7HH0GB8/vK9KUD+19bLJ7tmE5IW5AABeSFZsxDV0=;
 b=hMnIbVE+Otcpx2xPX8w8Mss0DO8EZwTFkR5OSKuty8xu9DebmEEzYzYeq2P7tCm833
 8YNCrxFo/sFtcMtQNtiw0rng6tnYAUefG7kHdwObPLSecg7RBvUHeaq9/7kkBA3mQMJW
 g+DEBNBbqARd/pQbDV9XV9YrQAiXyyDN0YHjijhcZiPfDeROeLGw466AsO4tAuu9NP7B
 +9O/D5YnrUZz64DYTZnNVEE+ZF3NSUyLRabBUzbdqkHx5WUGn1WASE/6SBFZwLi3z/ev
 t6teUFu88uLPb2nxrS7zr+bOZ5Soyko1w6zadCRyzzVUm8lJYw8s4JJW44lh5y4k8You
 07TA==
X-Gm-Message-State: AOJu0Yzred7Jrl3nT4w0KvOKOjGUaksxmJQlklPgI6yYbk4v5pWHOTmZ
 I8xcHBbQveh1DNIrF/IaICA6TV1VRKrZuYSTU0/VrdR3F4oFxjQyNlvYZxvcXWS3sM/rAhSAPvc
 7bBYy
X-Gm-Gg: Acq92OHEEMOTdrrWRiZ2GtRMDems6Ct2TntdWgmSlyt6jRk3Sxss8R7UJd/gQb0trv6
 rWDCo4kAsvj/sklESCZkUN2nm7PwcfvM85v+ck8wQTs/yoNs8PHNdB8QcnjMTz5SpLx+mMcFDvV
 2Ijhh4XtqYl5m+ybWgJb8vpxMDCnM/7tdmbj6Ff7GFZkvkHAj7iNq2W1T3mNdWfJ9A7FvUdyG8M
 YCsmZ9gAObKDEP7Kiaq6R4QQdrjzh3M5DlSrnvKbf85uuVxxeOkMHSX8jQNZDuhN0pjhwFUiA5l
 G6Rc/ATbVqGyIpd7wnrdA+TJuEXQb6TRYpW7V5AXybQEA6zKW6GsFBjEtpED3MCgvjlcPFV6TUW
 JP42Z6kGVsseQLyOdQqCyI7kUkqZmiTulqMffT1cQuKtJ+n+8JW/1dhNMHH48Uz5Pwwi8tKCHGo
 QACNhYOomTnBvP1OBChLLwmf3JOSbtG2frSHupV5klWtE2kLvXCkA7TZEG74d8AIgNBICvLxyI/
 a5OoaC0FgNcPr5aOWwaKtPTBJcmUulrUfECMSESD2o=
X-Received: by 2002:adf:f883:0:b0:45e:ea9b:edf6 with SMTP id
 ffacd0b85a97d-46238acb28bmr1183462f8f.36.1781636866932; 
 Tue, 16 Jun 2026 12:07:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/61] target/arm: Enable zeroing in DO_FCVT{N,
 L}T macros in sve_helper.c
Date: Tue, 16 Jun 2026 20:06:36 +0100
Message-ID: <20260616190639.3462006-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Use the low bit of simd_data to hold a 'zeroing' bit.
The simd_data field is currently unused and always 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f8e62cb11b..a0a189eb1e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -8595,6 +8595,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
                   float_status *status, uint32_t desc)                        \
 {                                                                             \
     intptr_t i = simd_oprsz(desc);                                            \
+    bool zeroing = simd_data(desc) & 1;                                       \
     uint64_t *g = vg;                                                         \
     do {                                                                      \
         uint64_t pg = g[(i - 1) >> 6];                                        \
@@ -8603,6 +8604,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
             if (likely((pg >> (i & 63)) & 1)) {                               \
                 TYPEW nn = *(TYPEW *)(vn + HW(i));                            \
                 *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = OP(nn, status);      \
+            } else if (zeroing) {                                             \
+                *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = 0;                   \
             }                                                                 \
         } while (i & 63);                                                     \
     } while (i != 0);                                                         \
@@ -8617,6 +8620,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
                   float_status *status, uint32_t desc)                        \
 {                                                                             \
     intptr_t i = simd_oprsz(desc);                                            \
+    bool zeroing = simd_data(desc) & 1;                                       \
     uint64_t *g = vg;                                                         \
     do {                                                                      \
         uint64_t pg = g[(i - 1) >> 6];                                        \
@@ -8625,6 +8629,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
             if (likely((pg >> (i & 63)) & 1)) {                               \
                 TYPEN nn = *(TYPEN *)(vn + HN(i + sizeof(TYPEN)));            \
                 *(TYPEW *)(vd + HW(i)) = OP(nn, status);                      \
+            } else if (zeroing) {                                             \
+                *(TYPEW *)(vd + HW(i)) = 0;                                   \
             }                                                                 \
         } while (i & 63);                                                     \
     } while (i != 0);                                                         \
-- 
2.43.0


