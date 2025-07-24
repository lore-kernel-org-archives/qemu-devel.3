Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E067CC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg8-0007bQ-1o; Thu, 24 Jul 2025 07:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg2-0007TL-BU
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:54 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg0-0007zm-KC
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:53 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6148e399effso1443286a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354791; x=1753959591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwK6z7gwuYm5iLJbqUdg/uNr1mj7hUY0ANK848LLph8=;
 b=F+rPH7angDvLin8aYJCbBQ2c8LVxs/XOi034J2gKSz8z/dcgx2CMm9UGgVAnLWpoxh
 FIdNCAMUUXDLzzpT3+Yhb1L0+L0z77/Z9rC1zsK+GZ2hYdcc+HY6i3DJJWS1nkawJSds
 21s+JKH/3tVwIxCSXD8Bik5t2kuDtzYXgzFMG8jW4vBpfi8mcNF6QZ+8o8Ne945NSaiD
 e+Nk0qWiD9W+YhWEC/TkuxbLhTWwY5uA9NSSS7STKHKEA6YzWLI//WnbeHs9zl6QyZlf
 jfzGWVbUjSsHapxiGkrrLEbEg0ygXKO4B9hzWUrwSZ63I9ingU91tOq5tDG46/rjTss0
 JtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354791; x=1753959591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwK6z7gwuYm5iLJbqUdg/uNr1mj7hUY0ANK848LLph8=;
 b=bcNPwdgvtLyRmxbr/s7F+ji18w8EnMXE2rJ2WuCAe6NljdgLfxu3b3aEFloi/kBCvY
 7rAIGxo+vKTbD8EL1a3/xFItYnqWYGUJz6XxnXIQ5gSqqk+UYQUax0SxXTbabEUWa+oG
 rxnepv82PfgivR4O6aArIXU+Hrm/5Tl5uwTmf9W4zOPxY2gmE7AiA4MTYsvQTdJ5XL7h
 QbsjkjzBCtYxHoVWVnmseMhClj0O7Bx+F/TXedNJC0+87KTIC8AT0bwEtPNOQmGXrm6O
 yliNKULKaS9C0aX6jVhkMyr37SdOdEmMk826FKnxkCLfbE0Pi9ht50vDSUoEXKH2nxNt
 vD6A==
X-Gm-Message-State: AOJu0YwnVZn/nXIPT02afAjzrM1PnZabu7qHvnT76evLSISNE4l3sYiD
 yi3FQKT9uQDxCCvVnOZDuPK/A9R3cKHWHzCM3xdSO4tbChZCsCVuxvttmCg3GMTmeLw=
X-Gm-Gg: ASbGncsz6aWLsQ9KWUEPyNBR5iEdcvINAHnqf0xBeHP/B8aB4Xot0pkEV9Q//oB71PS
 cxvpe5og0mkRirtAFVNHCo6tEVTGh7loNrAttzgqkfJuoItA+Mhd6zpKNDy198w7CujaVc1cWZu
 +l4t/eXbHJG+VsV8Q9dbK8Cm82UD49Lwc8Igl8BP32VSNPrmL9spgmp4OjLZlz6Fd13wvwPzF0m
 SJGn+6I24GEJzaImOdlIQpqMb6us0Wt/YcH9h1vYHtWUyp5IYEECiBcIL0Q5tO/AiydRKPPWxAR
 8ceJOXTftBVNbEnR4shD/qMAj3Ouu0nI0Uco6DoEPwwS/arkycXkc0KgXwAG0x6hC98BLpPVaU2
 yUZwCayrDrpofmWbbu0DJi2Y=
X-Google-Smtp-Source: AGHT+IF6Im6qd8yiIZ2R3tC1v8p8yFyfaAWr6D3g/JhTxskIJ+QWHqIJXuJFeSZ1skvzR07+4lIGBw==
X-Received: by 2002:a17:907:3d12:b0:af2:80c9:7220 with SMTP id
 a640c23a62f3a-af2f8859ec6mr705453966b.36.1753354791160; 
 Thu, 24 Jul 2025 03:59:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47f85eba9sm96118766b.97.2025.07.24.03.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0429E5F8F2;
 Thu, 24 Jul 2025 11:59:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 12/13] tests/docker: add --arch-only to qemu deps for
 all-test-cross
Date: Thu, 24 Jul 2025 11:59:38 +0100
Message-ID: <20250724105939.2393230-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

If we want to build this container on non-x86 systems we might not
have all the cross-compilers needed for the ROM blobs we don't
actually build. Use --arch-only to avoid stalling on these missing
bits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 8ab244e018a..5aa43749ebe 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -15,7 +15,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get install -y eatmydata && \
     eatmydata apt-get dist-upgrade -y && \
-    apt build-dep -yy qemu
+    apt build-dep -yy --arch-only qemu
 
 # Add extra build tools and as many cross compilers as we can for testing
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.47.2


