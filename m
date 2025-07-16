Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642A6C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzos-0003pI-9V; Wed, 16 Jul 2025 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmQ-0007x4-8o
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmJ-0002U6-QP
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:29 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso12531777a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663262; x=1753268062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhgCOgfTbD7UntD+Ov8uW1QfuDI5YjoRWrI6SxQa7qw=;
 b=VR5DeQTOokCk8jCxdyMW/mNeWW0d2TZKr19ws9m+yAcdE1rDGEor6+5CcXRaNYW3TF
 lMJtHzyzlL3E53mzQF82t0ZiQXp1Q37D6UsKUNTN7zXkC4pJXfEdMdXTVxhgkSPuRGm0
 p0wA8p9tAzT4hwjKYcm1RqselmIVgUNozyBq/dZyfpWAfVm3evIWDIRCHCG5m55rhKhm
 7fLYo12wGWE7bl8mV0EA8SXwDyUs6JpmdC8RghhWcTqo1LU2TSvi5xa6tJLeV71YHDVv
 +d57APacIs5d6rzFFIw/7woXodQxYA7DzvNzsM7RTDenvxlqLXyt6HYptqf5ajE7N04Y
 Bwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663262; x=1753268062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uhgCOgfTbD7UntD+Ov8uW1QfuDI5YjoRWrI6SxQa7qw=;
 b=T6XxvmqjuUKA5T2rbmSYC6MkCZt2IArGRTUgLmTM81/XITZeo7mq40CBwJDvwJtMxR
 mE1PyID2ymFdBr/ruWSrkX+FO2EPXHZ7lFPn4O4R/0qIU/gBCIrkmmMP/LKReWaKoHH1
 iAfkGkC2v7yXWdjNN+Tg5I5UBlAIO5CstYIETHcGDCre1ZNWNJVgtDK17fDnlioQMG35
 RlnvnV3qxYoHowD1mytM22tHuNAtQPabWun7/kZlmPGpya1dfl/tI1UnjDlBos9WtJVW
 V4TUpLq0zoH9/+iT8cwMU41CTKr1DoOur4T8i2Ax6JTyTSyllk1ifbD98qzSSUa3i2Pe
 sEtQ==
X-Gm-Message-State: AOJu0Yy2gg/PJrBfz/0snrvacKuUGTvuOdoE5rlFcbMVl+l8dxLu3hFG
 Ax0V9bUYgc9XtxVrK3C4IsoKo161tAtslWLcTAmwyTb6Oysxs/d1TVnWxzHN0vr440c=
X-Gm-Gg: ASbGnctIf4nGaz/m33imoXQzqCwTSQBqIW6AaTP5XIwXKuIHPUE7bA/8g3WdEvBDBKG
 vtXvzhI32Sn0B9sKm9JuSUPxijHoYK6dadjCHz1uahidDjugK8bM6j6T9ORA75byIg532kcN6ej
 TOP/aS7pDnKzGyu/oosTFJ7bRHwSMKGAvSvTLJeEg3tM/ChRBu/gz9WSaNsL6tgmj2w0ySG3kxX
 DnyAVkUXsiYtKEhzvKg+PHoymYuTkxxrpeDkKeVB+8K0Fg7EjzpdDm820wsRA3ygEib5zf2YYs7
 sw6YiFLM/dox238x0bCxjYLFMYpCgwfx8azuDc+i1oN0DXtfTlg3Dvmc8w26+bPRqoQvMZqHzKy
 7Vlu0v7EmTaOHQON0/c5GoOU=
X-Google-Smtp-Source: AGHT+IH0qfqtPU2sEfHn4NeNqbFVhGxuVJ2Ax+8dGfMckcVxsjw9gChrIXLAKafnlCXFcL2UmPjIcQ==
X-Received: by 2002:a17:907:f1c1:b0:ae9:928d:f285 with SMTP id
 a640c23a62f3a-ae9c9b82fc1mr267383166b.55.1752663261616; 
 Wed, 16 Jul 2025 03:54:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82645fdsm1181662666b.97.2025.07.16.03.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59F6D5F8B5;
 Wed, 16 Jul 2025 11:54:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 5/6] configure: enable the container fallbacks for
 sparc/sparc32plus
Date: Wed, 16 Jul 2025 11:54:13 +0100
Message-ID: <20250716105414.2330204-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure b/configure
index 3651cc3085..f187480d3a 100755
--- a/configure
+++ b/configure
@@ -1442,6 +1442,8 @@ probe_target_compiler() {
     riscv64) container_hosts=x86_64 ;;
     s390x) container_hosts=x86_64 ;;
     sh4) container_hosts=x86_64 ;;
+    sparc) container_hosts=x86_64 ;;
+    sparc32plus) container_hosts=x86_64 ;;
     sparc64) container_hosts=x86_64 ;;
     tricore) container_hosts=x86_64 ;;
     x86_64) container_hosts="aarch64 ppc64le x86_64" ;;
@@ -1469,6 +1471,10 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
+      sparc|sparc32plus)
+        container_image=sparc-leon-cross
+        container_cross_prefix=sparc-gaisler-linux5.10-
+        ;;
 
       # debian-legacy-test-cross architectures (need Debian 11)
       # - libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
-- 
2.47.2


