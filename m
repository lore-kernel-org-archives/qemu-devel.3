Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F626C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYL-0004Kg-Ai; Mon, 12 May 2025 14:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX2-0002Yl-S3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWy-00008A-CE
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e6880d106so33152855ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073133; x=1747677933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=gysxbtDZzocTuW0u2u6GosEC5V+6H9zBQRwx9GWg05pz4cjNme8KK3vfzdPQsG3MNZ
 wEEyXHJp+qlBK2x1X3+5I/vQ54jn4zAR/wkhzJeJwabRjssKjfXE0j+hPZ2cR5pmIdqb
 JyelN8I0SK04WY1BreGzwg1P+YztXUf6uK9AASctrPibUpMhPHT8SgqXOwVjJ/CqskEE
 0mhH8R2pN1wjOwF3Br/PCzOcznsb2O1a73sRgD9uIl10m1crg0S4IkuH+bE8+km3Tk2R
 DBzZdlQMfp2aCwZK/hwnOhjeVsidi5GEDzuRMRrQCzCJdoK1JG9HTrGwIpH2b92MjSZ0
 RTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073133; x=1747677933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=UYoZ3EcVqaJ+bQsdTzANHKSbPCM4kiIUejrT3Flke8uJDMehsbtaj78gJLULEi4hZX
 yAFs+A5ihvov64RzYnDE7QSYqipXdNEB7LR7IsQHDUvq0ehVWeXf17PjWNk4W5ez1dSw
 kFABxkdPC628A1VhZt0I/tQZlBIzzd1kipiVxESbEogc8W9lcoPp3UiRVXUJUpLJYdsF
 WGXXljS0skYtxjWcR4n3tOuxt805ck0E39YiTqH2UJeFjz0ZqKAJoVjXNb1Wz5etPaO8
 9KphsRbsPjn7iq02uxpIlmnsBHjK9RFCMu9o/oiSwH8oVt0jbqEtsTJdFnrDHNmxDUkD
 5rPA==
X-Gm-Message-State: AOJu0YzctPySMMP10xPbM2PzWqko0k0CVan95fa/9hr7sjZliPyN0SKM
 9yrSL6HWICqGBI6m2YgV0t28GsnOeWV7EuqBNrjFxRh5bQo1ZJHEX0jsk/RFpKdeOuBLQI25zhj
 A
X-Gm-Gg: ASbGncuDA+uL0tipWNHWV9RbBAgtYm11Bknpk4DI7kqLCDb6rY0/HqhzMr93KrtTcIu
 jNrfQ115P29ePk34BH069ro06iRysISEVMv+DAis3dc+HEy7mzplO0fl70axP8tz787pspvW+KI
 zUWmhNSzkWpjB1Rwit5TmIzSSFD/xewjJEA0x+rTdyymVP7y0ptTo+8QsE/VvcQ/dE9kDMwxV6H
 bjL2/nfME7BvNSL1/dNPOYBTWyhUMjhoSENt4o7bD1MiR9nSqz+iOlrdipK7Fj3EJozZ6ErY3Ib
 7v+CuvogscH58orrO3Gkl2aPr0RbNowDTyzPnPKXUSyC5jDvOM8=
X-Google-Smtp-Source: AGHT+IFCFhLetEwRoDr4iaBj8Wtr+2CIPtGJqZ3yk+dZbV8iR0p9eNz87XZ1bPZBW22ghrz1B8yiDg==
X-Received: by 2002:a17:903:1a10:b0:22e:61b2:5eb6 with SMTP id
 d9443c01a7336-22fc8b3ed12mr214319545ad.15.1747073133322; 
 Mon, 12 May 2025 11:05:33 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 24/48] target/arm/vfp_fpscr: compile file twice (user,
 system)
Date: Mon, 12 May 2025 11:04:38 -0700
Message-ID: <20250512180502.2395029-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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


