Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E61DC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57K-0006a8-Sh; Mon, 05 May 2025 19:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC579-0006On-Tr
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:47 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC577-0003cg-3a
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e16234307so27973115ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487243; x=1747092043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=IEJPpvUEM3qCB62G0OdJCk/JNF7ALKainMQ0sM431ReUHvUcgewrMiUDv07ySkYmJK
 FgL5gyvUGdbHfPmu8cgO/5uaykdSjMOsdXKspaczdWUmAPv1kvu/jpJoa4y0SxiHUp/c
 7z4+CLAHQVHTqxbl/OCnsT48xH7O9iILtrXP4e2ALecty/W40KWvZev6dIhh9qR/Czj4
 iMyVJ+cWg8ruoluO0GkTA20pZayPnQ69OYd4Eb0+RXexiupHLsoTNw35FflmDf1gixPK
 vFPjG/zIYXq8q4V//Cks4O0om9n6dFQtEo1xcFb8Jej7GGON5d/OCqrdbGp1RaPe47Yh
 mKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487243; x=1747092043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=H8D807erziYV8unUUmPW208ZZQ5fT35NTH5KK/maXx9B5CE06tj3SnY/xwMLO8qI8C
 517uNgU0TpLEj7g4bfdDynoWkJVio9MyWyAjsmVxtBRI5GMJtl97W1tNlIfVKJFk7K/u
 gfmp58TkyRW/8tz61MP+B+hB0zyHGaNq7HDBtIi6TnqiXlTzuRtwflmyE0A4RbduQzS6
 QkXngS0ns559Rf9SCZk+ASIBz2hx6nYlX2YqFMI22YaUvqzF7x5QOAnaWLbKrupmVdvJ
 TMFZeEtRhwMqgHkZbyLLgSh3nJ7evPWfYWWVdyEcb7yYaXjN4+V3n8jFGLG6JchjwHMu
 QVEg==
X-Gm-Message-State: AOJu0YxMI7x8dQUldP2ut2ZrGCYk2MoZIoSpk7E0BKPemTRtcSuWP+0k
 lxZw42QCQVk+H3taXFayJ18/MFOfdMBFLzT0RHX8fX2jpz11akNfRou3Ylr3udKP3Oxp6grt3eE
 MmFU=
X-Gm-Gg: ASbGncvViwbyGpJ8wpkrG4D/MoQfCeiooZsx/yBxVQbHOX04+w6hi54QxB2Jstu7F0E
 3Hv1lO01L+LFUOT0Vh7Z1HzRhV9Jw+HlMCc8lAW2wt3bd/qtXimQkBf+UA/cdhgiEFufVjbom29
 Mbkip56t+HQaw96vyswFnGRmtMSbrjCPngo1WyvZbCqFPYXqpbWpxuRT7NOeQD2coY0A1URObf7
 kFDmJWnIWjR3OoLfaMCn+BALpqszx8TvKtMmGFWQltE9ndzJgYHA6uOGX5MJ8Y0QiAXfw6O0lOU
 spc+//NoWnKi4TCctbXD610MP9LR/OIVykfjC4qK
X-Google-Smtp-Source: AGHT+IHCV1/1mp/qT4IZJkCFBwSLPw5Wv839QyIwwKaT5xti1xiNSDzwuFxBUCyW4d3HFhph5x25Xg==
X-Received: by 2002:a17:902:f68e:b0:223:3eed:f680 with SMTP id
 d9443c01a7336-22e3285f33dmr15966585ad.18.1746487243719; 
 Mon, 05 May 2025 16:20:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 26/50] target/arm/vfp_fpscr: compile file twice (user,
 system)
Date: Mon,  5 May 2025 16:19:51 -0700
Message-ID: <20250505232015.130990-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c8c80c3f969..06d479570e2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -40,6 +40,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


