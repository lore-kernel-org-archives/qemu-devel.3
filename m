Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZO-0007T3-Vx; Mon, 12 May 2025 14:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXXB-0002lo-CS
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX9-0000Dk-2I
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22fcf9cf3c2so31881985ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073145; x=1747677945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=AZZ2rEq9xC/VDVAMuKFpvlE5nUSHqNctw3na30/Ziuos6lSRrJ2Ow65qJpT5ZGX9iW
 FyNfiXR9kYVCYPhJ8N/pSz/GXUlPk6FD2G0l71Uq3STO6s4CLULc1Ltxj6MukbV/Jzns
 vG69rkIon4R91hL/R15xxMlAqQ46plDTC4XfZff0VVhtp8IK6FZKc1dBDmMEINHLGx5Z
 e9X7TXPgU+LDatrSIA9VqcOJgEsIPEfddsPVCEwibpZTsg0LbTPJLaGkUW2hy9O+WLi5
 eErInwyotjWyaswu5JFC/lbBoCOc7JqtC8XjUTZ8Hl5xnuTUKneaB0L8HSWp0R80MsPD
 A9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073145; x=1747677945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=SXVcZgTkbDZH3OwF5x1h+qWwoL4/Mzau7dYjxdL5PxK8qOF66dL6xSAfMqTiEXDNEz
 tQBrVS0fhBO9gfQCef16F0PhFQJ1brFO+7NEItq+iLnc+EggaPxxlyXH3PDWcBQEQ8JO
 MNohTqjeLSqr9BaBMURPa2nvHjcwBVjbFWHLNV//ZpFTIx5KSxGoxxzxS1Ujexr0Gi99
 /ssGyQLaPZ6heqcbd0vflz7vZXd685wpW8JQQG61eQGkBd9qIDK/1ukZ3ml8v0aC+wpi
 HbuLIgzfA8cYC4WIyyqcquPMBzF/m42krZZP/q9jI/VApcUHEQ5tvosqxaLqy78s7QfQ
 xVFQ==
X-Gm-Message-State: AOJu0YyFwlcDrirIUL9rQMJxaIGR8kSijE8gwbcKrUYqs6It5VATPkyz
 7OqAu4VKirhBn/ufUnkXWlOfXTWEhwUW7BzduFThV7+v6NsA1b8UxGyUsgNBXQcsqDVLSkVSEQy
 5
X-Gm-Gg: ASbGncu2n5wFGA22fVGAxCt0Qvf/hpSA62ctRlDh+Ia7C9fY/PF4qQ05APsPepZDGAE
 Mw3WfKIjyGMkxI81umWfw9yhSaLEMPKCYabk80VhBefQryJtxVSdZlPAlJTtAkk42ql4pOwEdlx
 7oAmBZOpRAZ0DPL4s7zpHX8CpjXYQppg10GAblGzr4fef58RKMeoCbFECX7xBSeecCOz7ZObrj7
 yL21G0MYHXLL/kdB/PwmxnG16gOtMXz+MN6by4JAcI8XJEe6BcSF5Xj9Uf4eHV8vJlSqFFFToax
 s1OedfADv0rLK9nkco6h29cpO3U+fWViepStLor+/ud5wuh3UYY=
X-Google-Smtp-Source: AGHT+IEQctetiUpc2QcOpW5CX99/3QsW0wYbokv3zI/2EZN1Or1hGsYawLA4NLCdijZxTZnCyTjjAQ==
X-Received: by 2002:a17:903:244c:b0:223:52fc:a15a with SMTP id
 d9443c01a7336-22fc91a1e42mr167593605ad.33.1747073145620; 
 Mon, 12 May 2025 11:05:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 38/48] target/arm/machine: compile file once (system)
Date: Mon, 12 May 2025 11:04:52 -0700
Message-ID: <20250512180502.2395029-39-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index bb1c09676d5..b404fa54863 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'machine.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
@@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'machine.c',
   'ptw.c',
   'vfp_fpscr.c',
 ))
-- 
2.47.2


