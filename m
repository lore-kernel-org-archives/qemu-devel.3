Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2509FCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7c-0001nT-Ru; Tue, 23 Jun 2026 06:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7b-0001nC-Kc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7a-00074Q-4N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46255b269c2so4109867f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209564; x=1782814364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXzDY4utHKIBDOi85XqArdivahwjfqST0fCeGtTbvGs=;
 b=Eq2x/1Fbf7RF9wu4+Vc/eGKATpgkyx7sUC62Nk6dYqoaKUtjD/9Z1K4J2ZRxmwNdWS
 9+XgcJQvwsJ/M0we0uS/IH1QLg4QrvS3Bs4VSE2KJcucf/uejR3WdmpGxASh0A5lv/9j
 fyI6tf+37aF+GWNQq3K5eqH1tW7DkZ5727IZtf0AjWeosD+5Nh9SmeVy1WEtG00GT7qe
 FPoHV1vM/RVeu3JZK/u2bu1oltI2L9HqnW39jH4wh5aEAaJCU2KK8RMGkbR3xqVFKZMZ
 NYoAC0ZBGoa4s67pGshL6dtjFfDS0cM9iXyBAZBH2ngmmy1gMtgW02tM6NvR+2Shl9Ja
 wdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209564; x=1782814364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MXzDY4utHKIBDOi85XqArdivahwjfqST0fCeGtTbvGs=;
 b=h3pWNI2TT1LEkKhSd9glLU7Kg0fxV+ilZwEibbPNOmNSovdMAg1uRjetaZeSWos7lw
 rWJKOrEsUwuBMeFNK3mVW0Ur2MyexO1HCEMoIVNmfu045u65PA+6V4NIH2fKYLatxEVu
 Cze/azrY6x+zST3IUGWbu/30hYsz+NwFrwOJGeOTMjaxAE2QwSn2XP38FSvQW2ai94x2
 8HwDUGVjSMxtB3EgufNpNiQwhwJPIJc1hsgCiPHJ2j9zElUWBneYhg663QMQkfsiKX1e
 6eHs4lfJulEqmkEVsZvTDAOjFKhS+MyIGJ40+bumBGgXxrBe1p1GYQgJ7ZL04Z/MGwA9
 j/Sw==
X-Gm-Message-State: AOJu0Ywdva1ChArBxXSz7/skUUY5Vi3uR6bhma3++lG8gOgnZG2dPnki
 xxsmtqyQXsXZmI8L2fXwEIGz3tJ+C9Z6UHKwHM8/Kx67VjI7J5TAV8e8oOWdBANSVsI=
X-Gm-Gg: AfdE7cknnhR6f0AArpgt0HLJpSPxWX67RyczeLosn4lAULrN29zZRDHaWVj5jzJVCuE
 Nf/nq2X+CmlMnpOqkCwGh8M5LKVuU/KiB66jl0/c0P1Tx5OehbTNMcfN98Drf9BLxYjsAMzGhNK
 entnvpf6HvObGHs6NjSQ0DB+oALaTPiFQOYWccpJ5ve1IQbhMJZyfYFm6f5o9Ughq8PyU9fIoSZ
 1bfVlY/TqxpI+l+AhTpy4oH1kfdp28yQ8ccrJ8XvXQ2nmF1OqwwxI1q+nz4djaKBmkOWN3NHMAp
 DA8GQV8CjDmEkrWYXrhylHP0iQcVDeb+WHe/FP5tym4szrcSpy4itK1icHqGGlB6qCmoQKLf4+g
 bLXc2EiT06NjbbfR1EuhqdxZP8mp+M6e2zwLJD0a+0vcWMdTcWOsRcqliJZuPqV+uF17f4Y0d/n
 lYIFxJBVQktwqUTo1WB6vqImI=
X-Received: by 2002:a05:6000:2908:b0:45d:3aa3:7f76 with SMTP id
 ffacd0b85a97d-46add184080mr3118998f8f.33.1782209564086; 
 Tue, 23 Jun 2026 03:12:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4b8fsm33527025f8f.2.2026.06.23.03.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1ACA5FC90;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL v2 6/7] gitlab: remove build target hacks
Date: Tue, 23 Jun 2026 11:12:37 +0100
Message-ID: <20260623101238.3806547-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since eef29e060dc (meson: build macOS signed binary as part of the
default target) we should be able to do a plain build and everything
just work.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260619155657.944220-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 8366b4ad564..efa0fb666e2 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -29,7 +29,6 @@
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - $MAKE -j$(sysctl -n hw.ncpu)
-    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
     - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
 
 aarch64-macos-15-build:
@@ -45,8 +44,7 @@ aarch64-macos-15-build:
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
-    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
-    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
+    TEST_TARGETS: check-unit check-tcg
 
 aarch64-macos-26-build:
   extends: .macos_job_template
@@ -62,5 +60,4 @@ aarch64-macos-26-build:
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
-    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
-    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
+    TEST_TARGETS: check-unit check-tcg
-- 
2.47.3


