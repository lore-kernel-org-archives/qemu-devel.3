Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55288CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wgl-0007dq-Aj; Thu, 09 Oct 2025 15:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgc-0007cR-5H
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgW-0004Us-1I
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso12235815e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039538; x=1760644338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxWAsS37uBxa8uB/swtNWJZYSgAajyJsOi6jGi9t6N0=;
 b=E26ObRmfTzBAMzWUJ29Bp9SKNwCpSjEVJ2rS0P0mxBVFNYE9uGT5PBb30ypMwgR2N4
 kVJqUWPrhxpqnOh95Em1EmLCKfSgbq4ze0dcSeYQgcPquxqZUv2OVYn/kZgK6tvYtP41
 vi5sOntaXShpsf8Yrd2aqAiuLUxTfB4gKBrZHz3M10aj/+kDYu9SpSiB6Nz9bNVDm92f
 UK7FKE3gaaBRcCGQ0Hc9G+Qqcqo1JppMrJeiRuE8kZj6juVhjVddeSTnpI3tLffWi2eS
 fo1wMh/AQxKmdSce4SlXG3TXXdzKY56wPXHY8XMAMYbfh5LNHCLyIsLL//iMWn9vFV74
 koVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039538; x=1760644338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxWAsS37uBxa8uB/swtNWJZYSgAajyJsOi6jGi9t6N0=;
 b=d7XLfjqQFW/eAaFYgHmJqyq+qG/gJNtmPtSvyOoYbGyVwTilbEPk8XT7xW5Uc8jPMv
 ToLmBcmGwpdlM3+RJ9N98LqHNHpliru6s2piQQ8c2TLE+q+CBmrsNJvwsMbyKlEPNv+d
 Kxja6ijX6GNr9fszmeWPw3Fa1yN670n4yAQhJIDpRIkqMFrte9HoCXL20zqT3NJrs3Tr
 UcQlE/IAqsUEh+Ku94xjljraVa32O69DNXDE277DYTaxbhMecscNzdt/S3BLDijaLmOq
 oYx/FcQ03NsL0GjGasxNVdDTmv8cY+0RZxi/QobwXwRueETCWPIbENtix5hxPz/stsdU
 HKlQ==
X-Gm-Message-State: AOJu0YyjDzNnYU6xKhLq3eWduWCwXmJ4rur4LlxLMTwZ5iFrxvqjQGZo
 Nivi/SkOsCrROTM/oATvrmLLdnXlKF65hKQ9MlrzF66P5spwEnKMz8ZWyX0sjTbs3dyclSlHF14
 8Odl8Sei8Qg==
X-Gm-Gg: ASbGncvjaMDENzja4fGhtyxjPUQULsZBHqyy7pdoHjjthIOp+nH+KX9w+0Jbk+NHxEN
 CRtQMTlE3hGDCoM69nQG8LHFFLVGKvvEFQdzOnv0KnxEXFeEgdDkgnczo7TR1bI0XgYQ6X1Whjr
 pgxEusKu70JPbKD7s9fUFSWnrOkiS41m/JHgTiUoGSvnEg9pQTzSE7Yl33IJFNfZGedhoaoRKJP
 KCuuqtRK1gL4nFuOdlqsmJz2AbUmv6HuPwyd2mopf8NKwqtWNyek1qgWnq0wyngLsCoBszBgOPD
 m1agI/tTZJvJ3ye+8IRjS0M6YM26drNjasU9Pnh/G4UNcVG0CXPAhoaOSCWgOYJpYxZM1FWps2V
 QgIVaqijIH+2xdIeLD3fYh6/cARhwW/+jnJi8Lrc9Mx3vzNMDBzWGdr3qXOXhpB1zhWIt8vnWzw
 ydVL8oc0AoA5gENx+iiyeRyWskV1BPVJIzjIQ=
X-Google-Smtp-Source: AGHT+IFleEDJ47lnmMD9P++DZLd/NLA+0ISTztxLy9gmZfzjRvuA4jhH9KVtftqHa1Zjhgj4fuK4Eg==
X-Received: by 2002:a05:600c:6285:b0:46d:996b:828c with SMTP id
 5b1f17b1804b1-46fa9aa1cfbmr72016455e9.10.1760039537713; 
 Thu, 09 Oct 2025 12:52:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d3desm561401f8f.7.2025.10.09.12.52.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 1/7] docker: Remove 32-bit MIPS toolchain from
 debian-all-test image
Date: Thu,  9 Oct 2025 21:52:04 +0200
Message-ID: <20251009195210.33161-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

In commit d3322023bfe ("configure: unify again the case arms in
probe_target_compiler") we lost coverage of 32-bit MIPS with the
debian-all-test image. No need to keep installing the toolchain.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 420a4e33e60..bc74d65a634 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -40,14 +40,10 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
-        gcc-mips-linux-gnu \
-        libc6-dev-mips-cross \
         gcc-mips64-linux-gnuabi64 \
         libc6-dev-mips64-cross \
         gcc-mips64el-linux-gnuabi64 \
         libc6-dev-mips64el-cross \
-        gcc-mipsel-linux-gnu \
-        libc6-dev-mipsel-cross \
         gcc-powerpc64le-linux-gnu \
         libc6-dev-ppc64el-cross \
         gcc-riscv64-linux-gnu \
-- 
2.51.0


