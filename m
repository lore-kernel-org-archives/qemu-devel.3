Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE72F4368D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh1r-0000PD-EI; Fri, 17 Apr 2026 07:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1n-0000Kw-HC
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1k-0003lf-QC
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so8722265e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423982; x=1777028782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kkK6SH8LUtlT/ml+uU1J6eqO7qp6PRZ4PrQ0Ifd1i8=;
 b=v9kvEZ2CQsC8nYa2RtlodoNuLiO90UqJnU58I7KLs9201tnxBv7OnZsYVTUGsvl9Ii
 d6LZybzpKUSnKZFM3rrRpx7JUjKwXm35P+101HkO1RbQRlJ4fKoFPngM4KixQzls3icy
 HMbcqVznUtCP/rx4fk/eyioITC6V8A1v2UR8q0TYhA7GFYBfsvAE7gXyqdC2pG8EAIAn
 LnfJzQJzss4Og2wrM9O7+R+QujvA4BlT4myWdUtulfuWI5/cR6tqFCpuDJaz7aKfZU4T
 xaz41zMrzmoDPrTHLgV5bUXXCps2IU9+EK9MAWQgU2u8AGOq9aoE1hO98l8oRn4Ij3JY
 jf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423982; x=1777028782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1kkK6SH8LUtlT/ml+uU1J6eqO7qp6PRZ4PrQ0Ifd1i8=;
 b=MHEMwyjFNKlt0/ElVr0u0enASYfyAtRu+M80lmd4K3vMpjjC6NVYKNyLmFw8RX4gCp
 81CIXpdPec5vFRGco4qjJ1bAp9Ca+cf9nrF2OMK0L2/2CGlMJn170ECYIqmw5DQHjXnl
 PVrtPKXxWUktCJstn6oEyUFcLECnPDlvrz+Fc9YxD49riPUlZJ9sIXSts3r0MARsZeBE
 W8JYyUihGXcDCmI8C+GxWJ293RGGvjwV4q/Mbru3Vdr/4q9OxgqZolyCJ0n3UrhwI6fc
 9MwFob7yP9KiWpuULjoeyogDZ1/cMmG9w48meFgc8eaZY135tVsVAp+xGhnK9yv/UZqn
 LUXw==
X-Gm-Message-State: AOJu0YxxFddCM7pF+VwdBel7r/SoxTlRjQGWA+e8YteR//gZaoq8/Xbm
 ksOKsaHD3JbMYTyeKQYH1h7dDcMxslvd6SZYUq5oSP4bYruCdyZIGFajjIf4ce/p434rUfkFPso
 Ue9i45bM=
X-Gm-Gg: AeBDiet3X0zs1Bg2Ltzc77beILuoMadLMPDpHhRtyOVq6CaLqbVJ//5IpsASlA2anyy
 jG4HaELxBGS2UuWV/XgvYlaEDApCh6WYpllthGqbTkGyniSw69lf5J1HJIgoQrQlSF0qMLtrjT2
 7Am8wUBAG1Ras6u8ba3Q/m/2hmocJ6oWtd5cHib7+E17X9cB25adxi3428a9nRc9WwbWYJbbUEY
 fW8uEv/3TF44rt4SnG89jjaLKHuaqbjs1UVGAjBaB9LeCeD8qiLwflYPcJhSa75Wh6eTh0CPTu1
 21waKevwu4EpM2lanyVw6eWcfBsygypwvvByKLpUoblpT6cpAoYgKU4e38cYX9sxcBzagJIuTK3
 7DL4iJaXymFp8SGVjJwmi6bw5yMOgv4z/EuByYwa0kE0I02jGxpqZGsj3XhfVIRiCbIhX1UNp3f
 t9A97Muzt/gaPDhdtfFLSevjfZK1otPzxp7cwGwYgaz/ZAFwR7Mrzvrd0tmrCbjHwWILuLg4T0f
 xTbKdBFWhU=
X-Received: by 2002:a05:600c:621b:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-488fb742e74mr36826755e9.9.1776423982415; 
 Fri, 17 Apr 2026 04:06:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c796sm14474935e9.6.2026.04.17.04.06.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:06:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 4/7] MAINTAINERS: Cover hexloader tests under the Generic
 Loader section
Date: Fri, 17 Apr 2026 13:05:46 +0200
Message-ID: <20260417110550.70068-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Drop the orphan 'Intel Hexadecimal Object File Loader' section
but keep the tests covered under the Generic Loader section, since
both loader.c and generic-loader.c calls load_targphys_hex_as().

Cc: Alistair Francis <alistair@alistair23.me>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eccc0d64331..d5e766ca6c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2701,6 +2701,8 @@ F: hw/core/generic-loader.c
 F: hw/core/uboot_image.h
 F: include/hw/core/generic-loader.h
 F: docs/system/generic-loader.rst
+F: tests/qtest/hexloader-test.c
+F: tests/data/hex-loader/test.hex
 
 Guest Loader
 M: Alex Bennée <alex.bennee@linaro.org>
@@ -2709,11 +2711,6 @@ F: hw/core/guest-loader.c
 F: docs/system/guest-loader.rst
 F: tests/functional/aarch64/test_xen.py
 
-Intel Hexadecimal Object File Loader
-S: Orphan
-F: tests/qtest/hexloader-test.c
-F: tests/data/hex-loader/test.hex
-
 CHRP NVRAM
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
-- 
2.53.0


