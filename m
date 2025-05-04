Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAFCC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv3-000284-DQ; Sun, 04 May 2025 01:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuw-00023j-5s
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuu-0004K0-CJ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22435603572so41132825ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336571; x=1746941371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=DVhXCsLHMHGYuG/uCUmZwwR/viKerqNMs1rL52MCreDWGOBoaboZN0ZUq93U0w8PTs
 38Kiq42fuD4LWEj1jVLnO8hNI+Jpzo3hREJHmIng3e8GxpAWASHBldWKfbkjoUU0INge
 1mKZR5x4pHUrw9DuYmDEzo+GkDExUA8x8AKTmTohQ0ds+VGmc5bQpg/HUnOC6T0JBHZL
 MPQOM6+4avYmcfm/HyZ4Y2OSW8MXnMSSnj7b1H+zez/6eCY1SS/YwrtsZ9g4xNXqu3nB
 Xfr3Zdu/Yi8ArkGx4P6Kc5S2vva1Jz73i++h5feW6Sw1fboJPT4RuoKCqWuRDmBqLeW4
 f4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336571; x=1746941371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=n4XHJ1wiuVaWmqOUaIUXH3o2dBSRKHgUKNSPdFcwtJ29tbYJsed4sJeQu9BmBlHNjN
 fNqLRJpOyaULTZ3qkeI/dyZ0I3sKb51ev9aGYNcJelmKwRsvVx84noNWASiFN49k1563
 k/VoToe/b1Hba8U8HJhrEwcsPBuxBvy6oTcqohFda4RGgZj2q60m/zk2z6Pvwd+oLBVF
 qZV7yUOo9ZV0+XreYSYogyDVsiprhFnmPmSknA1V1sJ6ioR9bzkihKsglD3bQDQB7mPJ
 PgIrZGl0jPp+SghCBTB9eGxapwZFm0DMpFa3BqTLJnxHmKosRzGBeW00yqegY4/qrwk1
 a4Dg==
X-Gm-Message-State: AOJu0YxdsfBr4QcB38ehoNyeuF4NlUxqaYNkdTOV56RWJiCNTyGwLVZl
 13w9zCgvzYlSgXpPKVjfKi8T1eEKs7916vNgZE/1dEtbbNsMraI9LmWoHe+01Q/49CVEuzCS38o
 22ig=
X-Gm-Gg: ASbGncvxj+LrwJwpcSORrBRtTOKRKiqacJzh1nhCdGrSjrQWJnN2U5JrarSX5Rd8/cV
 ijMKksYIoexvGPqUz89xSKxeiSb7tV+HtujgUPxiIG4gI/E1Tj18Ie3ZepRK6QeunkuhJrgegIy
 I42qc9nLuf7uBjty4pqsr/xMFKZ9zizPBL35AKoKqbusa111l36yLHbfKmYrp95EpujX15I/xO8
 NzTid+Kj+eK0KA6RvOkLfexzn6qMmLGHDHyY69yBnJ5TbFtfYpvxIJ5fmPTnea7BI0EjSkmeYnY
 HoBL/PRgpsgKp0q5x+uM5PDWgWajdNnm4YnZRtqd+cNTeIVun/s=
X-Google-Smtp-Source: AGHT+IFH2CPFEGOsr4zP8J4shIfyihEyvBzrlgv7YDD+ddkZeusvCH2PEX4Qs29NQDrJVY0zS9lFRw==
X-Received: by 2002:a17:902:f60a:b0:223:432b:593d with SMTP id
 d9443c01a7336-22e1ea87a44mr43546955ad.42.1746336570833; 
 Sat, 03 May 2025 22:29:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 12/40] target/arm/cpu: compile file twice (user,
 system) only
Date: Sat,  3 May 2025 22:28:46 -0700
Message-ID: <20250504052914.3525365-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.47.2


