Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBBCC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvR-0002Wi-Te; Sun, 04 May 2025 01:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvF-0002Kx-Mp
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvD-0004SK-Nk
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so34678285ad.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336590; x=1746941390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=MfLTwDfMsVDclLkfUccRIoYu6cgtTjO/E2ZocKgdRAjZxG1CIXLKdz8udkGtwDTYLE
 SbYQ0cL9YtiFFi5oTB0uyyCs0sTekwKSyu5ssWUWbjtZx7WQpXK/XVvjX8gTY8OtRCJ4
 /OmeOkIX2vsEdnsRNQKRAhZo7tTZ8l2uIpv2niee1fXjkOpq6kQaZsDV3FL8+QUegZiZ
 Q8DuvUMNDppnBszk6fW1pXVGEGu+n/kviFLSqk+gDMWjIKVzE7WDXNuMza5zHJTCUbwa
 MsztfcihkDfZ+5FyJEY54L7GxTbYOhW91gd07WcpyPSKZhkakSxIbI/KLZBRHQ6mQiVp
 McyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336590; x=1746941390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=hB4oVm6wq7Glj5wnFY6tluTPDSI+mtBcC8Fvcvqy7YJ40nlsV+WdkvkqMBjshF1gzo
 P5uXb8ujUonrXOmt8MBqQwckyymG2vULOcIx/JbYu8zqSyKQWF74flWoYXueBSFYPSNE
 q6RKLslHT+6WMsDsRjL+FCBMHmFs7GHm131J5+1MM0S6spKIS6G9PTxEz3x6pNJDXkDl
 6ppyZnioQoUt9BsiAIigRgUwaAkWC+44mTnBeVStLUbMzlihYZrwxDARiR6pEiVv9EBB
 sjDc8P28ZxkC4WquTLR6FZcGZy3WfUK3fB9a+62cxtHtRTblcbnI1frhBJCRReKQmRTM
 zHrw==
X-Gm-Message-State: AOJu0YyYuVbjVxbRdWrFvJjXqIafQhN2Jdwjz9fFBEnklqSjkOU/xcSd
 FeupisTOFXm5aKxeNtv7S00VC84oUpoagHg3MoXd5jU91q2s09c652iuDjcP+wt0VfeBOMqWWTE
 /G4Q=
X-Gm-Gg: ASbGnctt/5fhtw3Pq/+r8Q8wuiGJWumyC+2P3NDMM+eO38E8xG9dJNLTp6XNhSHP2Zw
 cU7VQ7FJr6sOlluHq+EYNYKYT3GvjaFuLbVDNkPBJKTConQEr46WV1mUwBFsbe1f8C5tv3TJuUf
 ps35vDmc77gLHhe3AqFwD2DZM47occmPYQH8wvt8Y+uKZbTIfaoe57iN9ZRbi4zMbOnxwOru9PQ
 8QKhYvftZrhqhEwLQ7NHklQr0DuWlBTgTLvZncZLozoE97sNqYC3GBVW13UzmltzTf5Rc7qt+3u
 ZRXTJfLdBSkzZocd2sRwYsbqGdqdKxnVjug/pGOH
X-Google-Smtp-Source: AGHT+IGp1Z+ingLQ/zaY5mlWqvBGcOfRi5+H8f3dhypRIFBlvK+ozmXQgUbNrGD1UrydKARVERewBA==
X-Received: by 2002:a17:902:ce89:b0:223:4bd6:3863 with SMTP id
 d9443c01a7336-22e1e8d5f5bmr45403065ad.10.1746336589950; 
 Sat, 03 May 2025 22:29:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 34/40] target/arm/meson: accelerator files are not needed
 in user mode
Date: Sat,  3 May 2025 22:29:08 -0700
Message-ID: <20250504052914.3525365-35-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.47.2


