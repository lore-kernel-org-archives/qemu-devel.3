Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B4EF99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtc-0006PW-Fs; Thu, 23 Apr 2026 06:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtb-0006P1-AZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtZ-00024B-Ij
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so6632982f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938572; x=1777543372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/KhI2g3bhfEcm01HHOlbYe2ghCpZdWIHzOLcY0WdhUw=;
 b=VbWJA5yWq6XshYNGYm1W9I0JXnYdVlKxVZO/W2gtKEJtqfm7D+cUzhEAbxx5IzTrx1
 wrHRpXmkoTIkaz8I6Rog91oA/l6E7TgK+KrzP9rXE/XspP5BCqPP3JoZpr2H/kDF1aEI
 +f0eK8jfMFNI0WarJAaO+cp8qHjhXC4Z7zITwGnjjOzgBmPdfLzUUhd8PmJOXXNJos3v
 ke9xJzQbA+0kWTK3p0PvOKpx+oLrscl3pWm2A+DcUdXCmFhqeY4R0hdI0yKe55mGq017
 L7genz0p6er9wANrDbbQvKGTX56+MzHy1PDDrbCA3ftMx0QBenv4MPxwjQpT7qxP4TcF
 1MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938572; x=1777543372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/KhI2g3bhfEcm01HHOlbYe2ghCpZdWIHzOLcY0WdhUw=;
 b=Pu75DfwKcafKLoF+svJ0viQzk4oIIm9Bhx2yy49WZooTht+QbrwdsmaDE+12P6giiv
 UXNcrQpoDpGyjAEA+QPnFijYl9eWcJ6J08vwsi6ko7AONVEOvIPtxo+DLG5eaaQD+Yjm
 p9JidfMxIuNMYYXipWP6JlM5dG2XphsnwvGdQ0exwH4jVIZ816dBDuZM/pc9N9+i1Sqt
 pwYE/VmGZuu730s11BoNf+pDu4teansgFa6DYjmjLxaNYTqZ+Ixq4SPsa7ALMH3479XY
 G+MwdaERjMfWuhrY5eRr8yAzagx8cR486swQ6ah2JC/3jb9msS+eTNySTdsE4Y+/5t/k
 h6Jw==
X-Gm-Message-State: AOJu0YxgLjYc2TlZHgnBpfP+e/UvuMN9dmewHWDgsWyCB6We1n/YiNw9
 Y1/CmAedq8T1nPQWrqoau6HFIyMV+IixkcFgrPJB3vMl3ZGS8ZyGz0+qPVq4ri5TgEoyh5BcH09
 sO/S3
X-Gm-Gg: AeBDiesyJXl8B9RilvuUhWrV7je0ygfXtOj+wOHxvdz7HwrwzUq6Xmh46tL3Ja6Hp0J
 81LJiYBqWlQbBMbHi3sBOGOfvNS0R75spTyTWB0EnOtchcE/F2F5jCfBrzj4gDKEIsCQ0DNiVMt
 Zroq6niXoSUBQrS7cR+dkK2rJSCrmpwBp9Zn9Ve87cqrHN2UxDLwZ1vpbb11jeSFPFe4QsDYMqm
 wm6h9G8LBoSyb2ftXZj+tYO/47eXleqxCldTHQlgVYKj18FPZX/Z0jCKHCFJ5z5R7DwwAmunCay
 izA1KYAf3UppOsbbBRaMyj9o3WgB8cruBJXGyGQIVWRg8ijFThJXgbsmvGN0Sr4UPinmok7dTwB
 FS2pXFw6ZzhEBGnysdT6NwEUuGD1ahPvBGurluYFL4SUSKTi43INchFloaDUzWrUrf5vMDqeUCf
 RRrP3dnPCBtJwKlD0mRooPsu4rMXFo5lNjCnqC5szg4LWyk00dyk2rV3rpWpY3z72i7Qu9p45x8
 iY+SJbRT0Vywm2JsZaqSfyYXWVJwWpmiZPeX/cBwA==
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c70 with SMTP id
 ffacd0b85a97d-43fe3e14359mr39939184f8f.32.1776938571857; 
 Thu, 23 Apr 2026 03:02:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/59] target/arm/tcg/gengvec.c: make compilation unit common
Date: Thu, 23 Apr 2026 11:01:49 +0100
Message-ID: <20260423100229.2941820-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-11-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1fa2667058..0740de92c1 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -72,6 +71,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -91,6 +91,7 @@ arm_user_ss.add(
   vfp_d,
   files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.43.0


