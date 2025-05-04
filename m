Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D22C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRuu-00022T-KB; Sun, 04 May 2025 01:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRur-0001zt-5n
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRup-0004Hb-FW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:28 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7376e311086so4875214b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336566; x=1746941366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=OQmMbwRK9Ko9fPxsPbhpquBtUkZMuymeDCP8YpuuaMS7CombAAVKb10FE1p5GP7ZCW
 5zNebRqp+NuHasuFuuEoTVP2m6E603YlDAcoqLakLpgQ+yb5htRNaHR2zGdtr3gSniEw
 J+7hikQQdNuDF+26c1jeGBtjIoaDp6vR1MxekGZ2bdf5LU3SntJpDGSBwkRjHfw93VIC
 ToNQOqnHium+bgjI0GMWWLPjwHXr+wfQ6l8BL1YNgAbbywh+IV6WQcw9+KuR4YwxtVzg
 lIJeb5pCBDb4C4JznaqpUliSEM4uguxClrdAgnT2P6qb2r0bKODU3forSzhVbV+wQMzk
 keFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336566; x=1746941366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=YJCE9onhUIUfmZWpPwEByA58KVZiVX7PX1LqswEimFbx3n6gIf4kVOUNXN5IGBq9gs
 NUSpTSMyzbnwrNYY34PpoEJ14p0Nzv2T/2/du4x9L4sxUYQjzV+s0f8juQA+P/GaAPrV
 TEhw5IrDUt8SxFfYl3kqZ/IfZI41j7Kr/Ilz2/8A0zTI+cowYQy39zCJ6Lh8sJLoZyVP
 1lVWOqKen/z0Snsh721cXnmdubX/yTM0clCjku29oQ3ar6Ew1PbvobpO793V3QCV7Cie
 B5o97aMD8WqFkT7rQswyIuAcqQhpBnG3IZ3VTqEOg9qK3ANz9SVB6nY8NO0xEuxtvJG6
 /JhA==
X-Gm-Message-State: AOJu0YwggrzETd/UhnY/9cqnwl50xa8rfo+CL4HEg3uN/4b5T7nvUYiB
 4w7zCUCYyolmY77IL9q9H/0DJHgULudLN/5VDxzLoDopxbIOiL9wvpNUmu2CvtnmbjlClMziKif
 O7g4=
X-Gm-Gg: ASbGnct+jdQaPgBuActCi6WNtXkAgTmKJ1HENWYecN6vorhlScFCZncSwVx3iDlBFjg
 YoPISzBXvzBFI3zlmiztNdciH2Abtq89fvCtt3rVFrNF0duK1iKToK0LpquKecvd1CWZEG0ITjJ
 Kkb2IiRmjYs6zmJKTLPbnXvqVBochAmBYWkOiwou7rdCvKyyLnHK3rGgWcrPDx6Evgbsk42krHr
 KZ2OwSiEsJmfo1xyQVrpjhjzrKRwiHkke6jTM5YRxpSr5n0xspE3a0n2C89z1hcuHQG5AAf6LW5
 19LM8oGBHI82/FcDmfNkJ4/2ql9UWdmCMuI2vJvq
X-Google-Smtp-Source: AGHT+IH9DqCwqIyT/DBCwqtOTq25mvsgeqw9qLrc719PnyccXJW5Z6fI1bjRjbsEjGhKSkyNrtOGcQ==
X-Received: by 2002:a05:6a00:448a:b0:736:562b:9a9c with SMTP id
 d2e1a72fcca58-7406f18768bmr4045118b3a.18.1746336565824; 
 Sat, 03 May 2025 22:29:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 06/40] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Sat,  3 May 2025 22:28:40 -0700
Message-ID: <20250504052914.3525365-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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


