Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB5BC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC579-0006Nr-3Q; Mon, 05 May 2025 19:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56x-0006Dg-TT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56v-0003YK-RD
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2260c91576aso44836235ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487232; x=1747092032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=JyAGOqazj9HVxVWkbI4o8I6RFvnbUzxz/znqzYm5w4M8lRq+24Ehgdr0e53GoAdeAY
 7cWBa01V//NabCWwo56B1Fk/deRLIIncYqmsinQ9ilO97R1pmryecgQhB2lqxJOf38IC
 3ayCJdZ3sNYYAzcz9JVz0Q3//+a64qBCDrzwvgfpIPVYyRPAFFIjvxRNJw1PLCv7yz9w
 61v3KzFUzt5sDDPQop/YocnAZ6pg7blx4mzsBr2yJ0tCKVvK5dzIvzbWu1/JwzvkgMHU
 ZMZYqGol6g3Xj1fZPHnhMwE8XusNlhWja6ITf1v6vCNvwayk1JsTSP0dQuTLOfH6oSJx
 Rxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487232; x=1747092032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emf7r2NlJCGBegzvSaP4+YNHnVcvC5KK1KGZi+oKRes=;
 b=FQsuhC9OKzixVDoPxdDM0YKvSVDerubslaMLbl+mnX1VYZSvJ3bTmu9mrtDiUxNJAS
 8sFbqlx/4srduXjiReSNf/c+vsFugCk+Y2rpH012NOeWuKETM0yy6xcU5QEQw8aoQBLe
 qvuW4mt1y3UDVy5zaWS3JwVQ3Z8gzqFARzXq4W+zCcBOJA3MrFiPtjV1qEZvGSuCvk1v
 mz9buyXk7kygFA8NS2oZ9quUkI3LGc4aczfBVUbI7/UUDDThAqDM+AEXEoIR7SzwkfCR
 Y9RlZAjYsYETnhjjyXflttBR3Lc+1nCVPpiBIgfCuVyMZ2Umfe6fbgP+ZZvhptRwmE4P
 gKjg==
X-Gm-Message-State: AOJu0YzpWWg2QlS06o6ZtSQz5pJ/DLwJSql2Vqjz6xKwPPRzRcWbdmt1
 jvq/o9Hifgz2IuXFLiUjoxYXmwaAQ7DzbXJ+y1oL0K3tNdESBUJ5ZaB7l4b2jWvshsNFAVxtp8I
 JbZI=
X-Gm-Gg: ASbGnct6OdLxIIPIOGU0cNeUqyndjO+7ceKvY1gPVVEMgKTgIUwAHMeu0Jxb2XICgA1
 fv7z/FDAbwDI3eFZC30zEAGt7lGWg7z7kCWQqq5puplunmMTatNlhU4HAuR6lOXUpTIitbgNrEF
 1Bxbz7bSyrynJt4tvih/IImKFJsI7pl8CVwScK/Gzg4DOTpC25SjWOmm04iwZo6FHdOWBYv6ZKd
 AdVTQn5LmEvEcde6zTmo6VFbny6uNVkeSVXMaIvto9KVvA+ltPEy+G4eLO28QK2EUhYEYu31bR8
 HFFom1RoYcnlEfHS25nRIh3D+2Q3n1iiPWJw54lF
X-Google-Smtp-Source: AGHT+IHhb5KrNk4Mgz8Jm32CJdaDgHXvMSFxZLzvYea86hfhE5UdJkPL9MIT+4Z7L5B0TwCmGOQzrg==
X-Received: by 2002:a17:902:e750:b0:227:e7c7:d451 with SMTP id
 d9443c01a7336-22e1eaa4478mr136820055ad.29.1746487232193; 
 Mon, 05 May 2025 16:20:32 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 13/50] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Mon,  5 May 2025 16:19:38 -0700
Message-ID: <20250505232015.130990-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
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

It could be squashed with commit introducing it, but I would prefer to
introduce target/arm/cpu.c first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89e305eb56a..de214fe5d56 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,13 +11,9 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64',
-  if_true: files(
-    'cpu64.c',
-    'gdbstub64.c'),
-  if_false: files(
-    'cpu32-stubs.c'),
-)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c'))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
@@ -32,8 +28,12 @@ arm_system_ss.add(files(
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 subdir('hvf')
 
-- 
2.47.2


