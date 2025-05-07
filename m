Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED586C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQO-0001Hp-Q0; Wed, 07 May 2025 19:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPw-0000Fl-Hb
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:12 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPs-0002Z8-Vw
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:11 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e331215dbso12817005ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661387; x=1747266187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=Jy7DNpniFcXgUF9rON+UDqGMgLTPOQ+gbJEEW5kifQSRoRV1zQmZhuLyOMkKl4bUPk
 YbyZtmADf2cWlGiV0L9zEdj0Jh7faydD4JS8KnoKcn1kjVDdXClGytXHg0rRhJTyMp4T
 7TazfhN1hshn6hMaVLXUqLegzhY9xJFUMbbU4bt/FYnwq2G+X/pt9jTGpfv7Uc/9tOQy
 rlBcsH9I0YvmLLu+Awoy2uzgP/85LGzZ6t7vTpJNo/rgcxX4edYIAJREKlhl1c16R6N3
 DLj2WB+SpL6ormSKYItgL0of8Fy6BSehDpO+GANS1m7CsPFqL39eAoAQYk4kvgfG6o9n
 OcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661387; x=1747266187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=MRBB0J8Br7TPSt5zd3mUeIrZQFRWG4WB7T1UwUcqjtBYtzBvuOEOF/5W8sE+eFetXs
 TYlnLd684V7TMfb0EsBDYgpVB3LdVJMxFjdxGY16yBWfLyZZK7vt9wroAoMXJgul2yBo
 9kjse9CWDn+yWLiSEB+1BzeBFX+aqL7+Hw47RV0h3wO6Ry9xdnyEaCuWOHfRI1s5UHgr
 OX/ItvNvAC8D2LoXI9UKQ7gIa4acABrUSBxDu+KGnkqIxBSJDGxZV8tcpQQZbMM2Oge0
 Idbd5ye9NZCEpqpbOTVinS3af6CDX98THywUoiq1vtimKwVIz0PAA6swCX2sNJ65yzDv
 jGOQ==
X-Gm-Message-State: AOJu0Yy9t46aPOgvoNQ1GTyZi0fXKHDS76FGxUpeIqP7XQzyYotVE6vJ
 c/rnqkantlufi+t10Gbo0YDLI50Y6YNklDIA4o6of1jYYhW9MJRQ/QjCUFyxzchMS7E3BiymOAA
 5iVlmvA==
X-Gm-Gg: ASbGncuUiadpKa8J805+Pd3nB65h2xgi//MTwmRwDh+AUeWnm/v678ZJ+dB+Ob4rlCL
 9sosYa0G7wJIx+NO0aBmKlgh6qgYj3SNHc9UdeTr5F8Bo/hCPSZFscE8zXO193+ZexDKqiJD9xs
 st2VOZiaYDwUg7370WZ8a/CLILEEC3nFas3GdIeFQQlwJi1lJzhC6MP/T1GiZEn7+jHf6MRF+FN
 ChCFN5DmAdr4uqKZ9xX4Tmn/kqn3eheLbrwi3M+jVAB9rOgaPMm5WwvLa8mUJq62ItNT0Uc/BYe
 WzaH5bDw/gnmvLmDTVYXJoZuH00yRKu2V+9aLs/7
X-Google-Smtp-Source: AGHT+IEYPXXe9Sd9bJoXec6MHpYABc/insXv+r6ni87IqJm+3koI5Clcb8DyzO39kuVZq+4ZV+I75g==
X-Received: by 2002:a17:902:e803:b0:22e:50f2:1450 with SMTP id
 d9443c01a7336-22e8476efabmr20725095ad.22.1746661387529; 
 Wed, 07 May 2025 16:43:07 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 28/49] target/arm/arm-powerctl: compile file once (system)
Date: Wed,  7 May 2025 16:42:19 -0700
Message-ID: <20250507234241.957746-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


