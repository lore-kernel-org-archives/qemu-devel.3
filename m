Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC8AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXbx-0003JO-5j; Mon, 12 May 2025 14:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXXB-0002kc-6W
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX8-0000Cr-DK
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22fa47f295aso31235625ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073145; x=1747677945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=S4yiKwIBiXJGUspKMDMdlri48ubu3H83wQkWesI8jVA849di97QnwYAe5mcg63HkS8
 01zZOFBJDRqMVv7DXAZWUnLJCWID4Ap0BCTfexojBLyd6npSrJL+L/A6tdD+AMVame7g
 k+dx9hpivfnkBFi9hz+5YA59g3ojgGpH8HffTQUaLq5X68q6AP2x6+wd0R454+Q7FHGm
 NOJsJj3agXpz1gIOJICxviWL2gg4iiU2Ykn+ISHwyZy5+dalQibDawq4aBIhNtr2L3FU
 w3tXPB+F+DrlH3hXaJ8jgIDvQFUEZ3WTWuW+q8Gnv+2QdIS/6IX0bCqKN0PIVmEVo4FM
 Bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073145; x=1747677945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjvN9GkUlSXmzEXtUb9+tptKE6zBbBhkZRx0p6n3iY0=;
 b=WJNdaa67MSk4r9ikJ/6JePl0RcHdyHpnrellHH/E8TTHmxIqHbJfbAO/77G67e/IdU
 DS63/FGc16iCwnmJo8YVjBnkxhla24coVcJ9mgzABYPiVeqJ1qSea+TEedjpx2AVDY4f
 ANI1/FUadhvRfdcpedJkojygu0oXg2WsmSrvz5wz0OooLEwhsT/S44QYPA6ZQ3u7PpfQ
 NqSbD7xgFtfpcw0WCiWJg0iRF7NIifFydTNheo/jh+hXN6/WB4f0NG5Zq4rU+vofc/ic
 WP1DnzLE9PyM+JYGWITaQSuFJSAK/fBZNp//Hwwlvq1T9HZ+AOhURf7C3h3XRM7XZ4AT
 PIHA==
X-Gm-Message-State: AOJu0Yy7wlkse/2rYak2nWebAvNqLpiBPwm+HUbJDJFejDaCU4Vs6BuC
 VoQEysjSuw0IyZPr3Y8Mqra1tF6Llh6aii+nMcPFeeL4IOEvryPMG8YkuNF3ZsTCGLRr+C22F3u
 z
X-Gm-Gg: ASbGncu69G5dggg+05P26XEgRnlUo3noFbIVgRCG800L8HfY8t+/AlVNhvCV2+kQ4DG
 lM/7o6n1RbL3IPgJNCycEBX3QFMcUL50SsDSlb9tqV+wqej4ONOja1utg9VHsAoacQY2jn8ZrnE
 pd59hVTb9khJAqOLEIJHgtSOKhx+UTWo9+kK2Gq/vhVxTb16U8GxPcuulNx07RmFpRX2dfdgxuj
 zzuaiXNdiB8NnBQd+uBgPCHwBxfUOMiNkmUnWnAJqNHA+0Q3i7wy2yznv6tPjmysj+pnOK1rKAa
 4Vjx/wCJ0TrH6WhtTSLcoXY0ruhKLnMkK4BaHkkUJjss19lOsKQ=
X-Google-Smtp-Source: AGHT+IFDzqcaX/0EytonVdOMQTT5ip0rYF097hL95/ujsWihHVjpJwlVBrnlb5Xxz7eOAPoupInNqw==
X-Received: by 2002:a17:902:d4cf:b0:22e:60b9:ac99 with SMTP id
 d9443c01a7336-22fc8d9c6bdmr231746335ad.34.1747073144748; 
 Mon, 12 May 2025 11:05:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 37/48] target/arm/kvm-stub: add missing stubs
Date: Mon, 12 May 2025 11:04:51 -0700
Message-ID: <20250512180502.2395029-38-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Those become needed once kvm_enabled can't be known at compile time.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4806365cdc5..34e57fab011 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


