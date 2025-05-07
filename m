Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D4C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPt-0000AG-HD; Wed, 07 May 2025 19:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPa-00083g-PY
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPZ-0002Qv-0v
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c3407a87aso5732995ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661368; x=1747266168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=V6GhH57rNqUAPjxf/kfwhbEj7V/vewBEyLPxiet9fFJTW1QMAbnHFDxyJXTemmpqAP
 DARzYe092/ltHzzVNqJWJ/nc+KQ1YaTJ0CNrtveXbVQvviofsh5ch3/VDIUSjducvc1B
 qZbn4vA88cTsYUGEfsersn6AdrCMZQMTxm3DBUVsrriEoZgQYernv3iM5J7/zcT8YWzO
 QZDyfLXVPYCJG5LGvdVFFbxTN6YNZlQ7Z9zZXNf6aP1ZLo9LpwRpJ8Zps65aCzxi5C1d
 9apjl1bb4AUZovVTbAXJGhd88avhNv6JVF5xZ6xaKK6P248ZEmj35qY3Z7/DCUj7yQT4
 hveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661368; x=1747266168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=qpdD+PrPaSZI1t7KYMUFkZNjoPdP7R9ssYMmSQR2+TJBhhVgw1Jr3mVHf8tgtBMJrJ
 Rc66svEXMfC3lhfM8Afv3fsTbV1C3/UhhEGVtzw3IEaA+qHn7JjxkubSf/7+udm9+PmD
 thZSRy2Bpql17zMPfLNoB+iAYVJF2NYB/Kl1lne6/MmXpr/S4tdh8ckMtCzAWxLekTwd
 5tTwhJ5jZE6h6kVOZSSzzRczLxky74VHM4/fsC3CS3wr0SHymuAozod26Y9NC7/Utuxw
 9ip0PMlsS++gQXICEWc73KiPlCPZlRyijkZkP3K8ccZjftJqSWRb6mcfM2Tw1XgK0NpC
 oi3Q==
X-Gm-Message-State: AOJu0YxBYjk+G04FDQjwLN+3RnJB6U8KweaUiZs1aUHNRATrSsd7D44a
 DtNQ/tiP/ZnNIUdAcFGH2MjmrUvsJjqRQxz3wHqFW6WnbGdPYDqe1YlXRRau2oDO1zTqAdtd91H
 Uwc9mIg==
X-Gm-Gg: ASbGncur5dnuMIKI6cfEJBU8+NezMiOhNWQ8DHADGduzKETGlPIj9s1ij7QgNTDADin
 UccY+SgIN/zbsDUbtvJfhUFU3K5vnBPfTkEHUTnewcVGmTIuykMB+4SgXiBuOs9mhzapFen1WKK
 mbsjZoZFRNrYGyCppK9WfCS2EUhrLPzPEGiBkrdk95DwcWSoikDb3huDZ2hCilvMSBJwHiPf23a
 35NRwDiKDS4kQDowo6UogxmoYjiGz0XVGrnnQ2VHkUa3/LmARO9NCVc6YhMPcVeUKYVdf48UcCo
 C+aKBzaA9wyxpNFnRfm6XdStcSvxdekqTZVqgNzl+8/73J4kFgg=
X-Google-Smtp-Source: AGHT+IHhqOsHNXPZF4TnzOtAP6h/+c55CQlBQVlH/8L+pGzc2viJ6SxyDzkoMnBGSlSBqkYi5ON24Q==
X-Received: by 2002:a17:903:d1:b0:224:194c:6942 with SMTP id
 d9443c01a7336-22e8dc8f2dcmr14656095ad.34.1746661367784; 
 Wed, 07 May 2025 16:42:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 05/49] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Wed,  7 May 2025 16:41:56 -0700
Message-ID: <20250507234241.957746-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Needed in target/arm/cpu.c once kvm is possible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 2b73d0598c1..e34d3f5e6b4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -99,3 +99,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_reset_vcpu(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


