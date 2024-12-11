Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB75E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSS-0000pa-GN; Wed, 11 Dec 2024 11:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSQ-0000eL-9u
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSO-0007o8-OZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2033562so59606215e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934059; x=1734538859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2r0htTAsE1i09Hw2gTl/jAfOrYRUikK5HNqJfN6jEc4=;
 b=EeXbrkHz9M2cZDkTlKNI0j0ea905Hj6Q06yG1/YdZv2XOrh03FHbzJSwIUvfZ8Tk+2
 lMeh0aDnhpJez3zM5vmdZt5x8CBe8tPXhs0eGfSq5Kbkd0fAmEh+onCnjTwnxAZ3DfgM
 AqCsRe4QA4zsKLXaE6Pf5R4DvJVkld/rxJiQ8gcxcawE/XoSXOGRoH9BBpdIofbShOsd
 a1vFsFXW49iUHRcIWicQEOiG57HGA7Tio+Mgqvr8g9WdMW9CEqic+quU9r8FYudscmXU
 KpXVD7pZzKA8eLh2Zqusu0dM0HCEBJ4SEVN+1tZgfrhx7AoP4KAfIhBmsWFl4X9hc+se
 C1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934059; x=1734538859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2r0htTAsE1i09Hw2gTl/jAfOrYRUikK5HNqJfN6jEc4=;
 b=QKsfiPF+mNHV6iEXQka3/QKH7Vum5r/nBdLpEWqJDFgC5grvG19pt3uLuvjKSyPp3t
 y0/SnYMrZbV+2M7ltJXad2Z/w95wKulwxtLe06ODjQ5FMooJRzmx/40lf2K38fD+bHrw
 C1sQ+f8ttAIBHMIVXxT6yAb8+ls4i/9TdL7LWMphyAE1pmzgWwFW5NgSTE85nHD7EutJ
 4jWGbFLo+0CK0RsQo49npq9I5FC8yRyQc7AEujW/EcmRL/n0BdAnkwH07Zi3+wicri8B
 221pRAVjzCBUF89NEDv4AtvLNSf2+odrYmS6o8A8eImClbWUrFU+p6hqs5wK7kieBju3
 X0Kg==
X-Gm-Message-State: AOJu0YwgrtohC2dWGpofE68kqza+f8/Or/wwmGSDAxM2mo9vP0i0o7hi
 6gZCPPKqcbU+BmOSq4AOhhVzCZ0zmgYkZFUMVAvfmF2YO7Fm5D7msck8b0jHeWNvBRrZrbw17yi
 M
X-Gm-Gg: ASbGncs8NADYYmLuVPj1dUoQZqfsZpqRU3Q5lfGBw5EFoQxpFHQDnpx/vGx0KY2ygdP
 LxeyjpujsnRHzqRqQHkU4yBviFR6jpsqlzD/Tu82DjisphMV19TH9ujfcENSE+RVEnqHrKKP62c
 1FHFgOtyHeKnMd76t+HVy358OctVjN3u0SxA0/BBdpNjsLfcwljQKpD5S9NJYrt73BwMM1Oa4O6
 8KGChijxU4bJNLAOObS2wqQ7rEh6bd2m8in2sFW0QTDo1ePXCZRaThqCn5P
X-Google-Smtp-Source: AGHT+IGicDoON8JVH8qMnUREn/zOv49DSlfdqE5T6ajVKh/yLOQV5Agf8aplpG2SMQvO7JgCWMxkmg==
X-Received: by 2002:a05:6000:1f82:b0:385:fb59:8358 with SMTP id
 ffacd0b85a97d-387876c38b0mr161289f8f.53.1733934059340; 
 Wed, 11 Dec 2024 08:20:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/72] target/arm: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:38 +0000
Message-Id: <20241211162004.2795499-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Set the default NaN pattern explicitly for the arm target.
This includes setting it for the old linux-user nwfpe emulation.
For nwfpe, our default doesn't match the real kernel, but we
avoid making a behaviour change in this commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-41-peter.maydell@linaro.org
---
 linux-user/arm/nwfpe/fpa11.c | 5 +++++
 target/arm/cpu.c             | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/linux-user/arm/nwfpe/fpa11.c b/linux-user/arm/nwfpe/fpa11.c
index 8356beb52c6..0f1afbd91df 100644
--- a/linux-user/arm/nwfpe/fpa11.c
+++ b/linux-user/arm/nwfpe/fpa11.c
@@ -69,6 +69,11 @@ void resetFPA11(void)
    * this late date.
    */
   set_float_2nan_prop_rule(float_2nan_prop_s_ab, &fpa11->fp_status);
+  /*
+   * Use the same default NaN value as Arm VFP. This doesn't match
+   * the Linux kernel's nwfpe emulation, which uses an all-1s value.
+   */
+  set_float_default_nan_pattern(0b01000000, &fpa11->fp_status);
 }
 
 void SetRoundingMode(const unsigned int opcode)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c81f6df3fca..4f7e18eb8e6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -179,6 +179,7 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *    the pseudocode function the arguments are in the order c, a, b.
  *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
  *    and the input NaN if it is signalling
+ *  * Default NaN has sign bit clear, msb frac bit set
  */
 static void arm_set_default_fp_behaviours(float_status *s)
 {
@@ -186,6 +187,7 @@ static void arm_set_default_fp_behaviours(float_status *s)
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
+    set_float_default_nan_pattern(0b01000000, s);
 }
 
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
-- 
2.34.1


