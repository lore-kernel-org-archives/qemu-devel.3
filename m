Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E9AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0SM-0002qY-FU; Mon, 19 Aug 2024 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sg0SL-0002pd-0d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:21:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sg0SJ-0006Iw-Cf
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:21:48 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo602425f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724066504; x=1724671304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tgmkqD1pvXX6j9fOMELfKRZxlUmd7avVvCvUUWED98Q=;
 b=g9I2CPE9Mato+EkCGfvVz40m+g5oHEVIROYYl+mVMCloDDrOGR0nfDtwTsUdrB8Zow
 cRHFUcfz2fqvltw9vczmuzvhfDX99pL+7lGVgYsbfnXQmfKJEeU1ocGcosXAnkUQDkwm
 JDKaDnMad/RQyEB7BXfyJXzfJpdrL1H9BDgkN0VdBtYQue7CyHP9DcOOxi/DE5zhklPy
 cdDkDGWtMmEJQsQjhAUEW+AFNR9fag6JAa+3oMvq4i9ay0yzzzIFFG0KrRihdYnNEoDU
 WrNRyHmGUs5yZm8ub5eOp1UPRKj0mD9AAgQyOCM3nsWU2lXjFI/q0JvH7DC9r4hWDWjj
 EAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724066504; x=1724671304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tgmkqD1pvXX6j9fOMELfKRZxlUmd7avVvCvUUWED98Q=;
 b=ckgQAyxD7PpQ1H1O2jdKCfMWaVibbz1TVK3R/6woBRyvORJLbZUlcjGA66mDW2K687
 Bb9++67xNl72K6GqI6YGabj6Pwhe5erMyJ58nI8dnbiIm5yEd98oP6khR277K0DI3ME3
 IoFvBPaPHT/FGlZHyW+w1/VkxNTHBwcxpyDc5Jug0v1xCYDEHCaoo51LctgTOPuoi4J7
 Mm8ZbiZpbN4Nx+qlPvdmWbOUXOkor45vnx/3fYrHMZdBfRNX56xZbO2C794eeHMziSuN
 GC+9RXoQL7r51uh1gbwzPjeLwAvRt3uesBTFOss4QzxXiRC7lONVMF8yJhyBzZTgtXzG
 0eGg==
X-Gm-Message-State: AOJu0YzqSvC/KL5X5UYe8uOuVoz17R0lsccp6kMaphXkzRfRfSVUP+4C
 9VTJTczTJWGS4WMbL/FaTI3YwLKitaiHDT6MbOQ90NE1m1x/ITNGv7wv+r8XXIL5dqJElr89Hxb
 y
X-Google-Smtp-Source: AGHT+IH7vFinufbVJdOLpl85My2Z6bUJjltemEKvyNFUO/bXDICq2InKVYZHESpjFSb1XD136N62Vg==
X-Received: by 2002:adf:e8c7:0:b0:371:8cd6:b2c2 with SMTP id
 ffacd0b85a97d-371946a4994mr7283311f8f.48.1724066504418; 
 Mon, 19 Aug 2024 04:21:44 -0700 (PDT)
Received: from localhost.localdomain (34.22.205.77.rev.sfr.net. [77.205.22.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189896a9csm10300543f8f.79.2024.08.19.04.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 04:21:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] gitlab-ci: Build MSYS2 job using multiple CPUs
Date: Mon, 19 Aug 2024 13:21:41 +0200
Message-ID: <20240819112141.13786-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I don't know how to use Powershell do use nproc+1 jobs
to optimize jobs waiting on I/O.
---
 .gitlab-ci.d/windows.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index a83f23a786..35ccb74fee 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -110,6 +110,7 @@ msys2-64bit:
       mingw-w64-x86_64-usbredir
       mingw-w64-x86_64-zstd"
   - Write-Output "Running build at $(Get-Date -Format u)"
+  - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
   - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
   - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
   - $env:CCACHE_BASEDIR = "$env:CI_PROJECT_DIR"
@@ -121,7 +122,7 @@ msys2-64bit:
   - cd build
   - ..\msys64\usr\bin\bash -lc "ccache --zero-stats"
   - ..\msys64\usr\bin\bash -lc "../configure --enable-fdt=system $CONFIGURE_ARGS"
-  - ..\msys64\usr\bin\bash -lc "make"
+  - ..\msys64\usr\bin\bash -lc "make -j$env:JOBS"
   - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
   - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
   - Write-Output "Finished build at $(Get-Date -Format u)"
-- 
2.45.2


