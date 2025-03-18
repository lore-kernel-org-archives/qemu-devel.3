Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5B5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZe-0003iW-DU; Tue, 18 Mar 2025 17:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY7-0001Lj-Ex
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY5-0000q5-Qm
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22401f4d35aso116912635ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333552; x=1742938352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IARoCxxf8hO27tnX4lGMuLobcNn2YYTJzhiqo5c0EnQ=;
 b=nAzURhds7mgVQTwll8G4QPr+2jOZvAx8W675Q5UWiM3ItnsrLCoKoBi7LLxgRWRaum
 eYTGld97gFMom24KNACfZTuvupJIlmYRSWy3kxuKD1e2Xc8jXnmJvj+V4Xd22eerYPJm
 ECI2Ey9/cMGJ30oUy5HQ82rdxX95muY792Vmp1tdo/vpZX4lsKfUy3IxzTRiB99Uwa7d
 ojP8V1SaWqLeun01Is00u/BiE9fIDGKhRCa3LjJ9PgMgTXIeE7/eycA47cM/UZkstJ4f
 T9LZfaamunlMsCnsKaKvPVPdX+sgib5Cvze40tFoyfIR57HNKuNQlYfHKnHuLTlxrrZ9
 h3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333552; x=1742938352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IARoCxxf8hO27tnX4lGMuLobcNn2YYTJzhiqo5c0EnQ=;
 b=KwdEqltTsIBwRi14D4h6ENMgoZECQohxQyCZyDpmSmghq8IvXS47x3+rcuK3RORnWi
 zFPxSALhDF1eUHCH1iZxme2lb7P1/JTGWeAfHQu22wOaFEZUTTkaJoeo9uwHuIuha/l2
 2lMe7VviKh9Ia9/0gApkSwLe42SNMwrAmJQh5/JdTkdEzcgYaFRlvI5JM1RNCm3AU5Hf
 k6kdr1s9S2uVYARppjOfLmG88pNAu2d5zUFnmRQYnqHPwjBBYW5PY7BvGm0qJ/G0QAS0
 X7PPo0IMnzWrvd8iCK5CEDdf+yh5hR6yoIIBM1Rip0HZAfWEp4Dc73Q9qIsaEyWkE+th
 Vt5A==
X-Gm-Message-State: AOJu0YyrjfRWQFtMh2OqRQyMBO9IU93VB//pwQgWscRav+rMEJLhRNL9
 UzRWZUT9Atej5npg7kJiM7RHLXApxmKfnnVjgpKo/ujidS8gvm6ZGi2aBypn+mPOISdjSRDc02C
 N
X-Gm-Gg: ASbGncuwtx/vme4fmHLT93L6jZltCMEr1zl2PIrX5KnGq0lv7TF4t1f5LMWjISnICh+
 ZxdMIGg2y624Ihbw32rTq5fNt2GwzteMhgKYdIsNKqBNXF3RA+EfRiFXpQF43+sLLtOVfDfd/+T
 jVLSGfBtJveNeL0nQAG8RpuBqEfvHmcAk29JSCM6hfJVAAF642Y3Xpf3B7C2RZhicofusuHBUdR
 HLDtncS7bGjKcOX11mTNq1X1h2ltgrim7VQbBj88oFGvw+eaxAoY51o+Qxj16BOqNW2odPnQh1T
 tZsPNvauzaapT1D+/xiwOH+3VfWcORMnCPVRWYWi/OAQGBOwwY3FYX+QoFf16CFy5AbdBk0G1Q4
 u
X-Google-Smtp-Source: AGHT+IHudU22UGQukuLyf9WSwfIr5wwWO3BzLdcQKTTSrDe99kwLFsc3kg7zHFus886hbuXsx0H9eQ==
X-Received: by 2002:a05:6a21:6f09:b0:1f5:8754:324d with SMTP id
 adf61e73a8af0-1fbeae91123mr346443637.9.1742333552450; 
 Tue, 18 Mar 2025 14:32:32 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 31/42] system: Move most files to libsystem_ss
Date: Tue, 18 Mar 2025 14:31:56 -0700
Message-ID: <20250318213209.2579218-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Some of the headers used require CONFIG_USER_ONLY.
Do not move vl.c, because it has other include dependencies
that are present in system_ss.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/meson.build b/system/meson.build
index 063301c3ad..c2f0082766 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -4,6 +4,10 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
 )])
 
 system_ss.add(files(
+  'vl.c',
+), sdl, libpmem, libdaxctl)
+
+libsystem_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
@@ -23,9 +27,8 @@ system_ss.add(files(
   'runstate-hmp-cmds.c',
   'runstate.c',
   'tpm-hmp-cmds.c',
-  'vl.c',
   'watchpoint.c',
-), sdl, libpmem, libdaxctl)
+))
 
 if have_tpm
   system_ss.add(files('tpm.c'))
-- 
2.43.0


