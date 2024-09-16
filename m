Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9A5C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 13:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqC6X-0003Vy-37; Mon, 16 Sep 2024 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqC6U-0003Uq-IE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 09:49:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqC6P-0001zl-D3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 09:49:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so26551005e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726494555; x=1727099355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1q9G7Rw8B9MCD3mkcgSuqTdpXBuYdcKNXELJWROaM60=;
 b=A191bwqym5GbOzCu8cGFxw1DuZvjuzYbyPP+z1Zvti6ugXW4UwA238ptPdNVKoHu/C
 VM0OUm6wO88pXkVg8COrtxGhAZEmE1Zbh7CcS4BuQ4+Qvl4MDZG9djaR6YuZ3YyFnO5H
 uBJWTAJa8wi3Ya26IxXBjTqcL4wleKMMJ3JpRysG7kT/Q2qwJz3IGoFheKeAhdVD02eh
 vP6n5z3gYm3TtqGJbqMDePad+0YBuioybewCfJi31BZ4acE5U7DXTg40XRDYU0pPneAi
 NuZPZyV3xEPhCvrU+l6mD4+1l2rAyhqUqOdixBA3N5uOv2+qaJarNsWzl/56ATlVPNuQ
 4bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726494555; x=1727099355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1q9G7Rw8B9MCD3mkcgSuqTdpXBuYdcKNXELJWROaM60=;
 b=pYnCNv4x8Ndjdaw16ISQ3zcZ1fcqMLGGH/mp7mbZ8i20y/XViXTMzU2kZINj/1QNxh
 nx/yhkJhd7dvnxQElFP3q//5XZltZnA34YTLPpXn1/ff4HguGptPAHnUchjAqwi2p9gX
 eLJgXtlLIKvOG4taXTyNPYDiIBrgRlpzQ/P4UuYLEDNOAIYW7BMpEmWoKM6fMWJwIVoq
 quNc5jW3vcgIFL+6Zh15+GWZxG24cw6fiBHgAZi5FlDlgvsn6BbONXtFqRTUkZqOWMu2
 spadJn0kiSHTA7XmBHJ91dI9ScBwo1nirvekZcIypBmpLev0EqRzFOoObAGd0OY3BGwB
 b8zA==
X-Gm-Message-State: AOJu0YzOeRJrl3IfOsBFInW6WS5+D5eMZ27xvmnUvEtORLzzE4I0Q+la
 dg/bBBP/6G5e4H27cicfZnKknHHU6KnPasmZt7xCfasa6WUkAGsshxX6jB8AVp1cv3V5Cwkjoc1
 D
X-Google-Smtp-Source: AGHT+IHeyWn9qdoKxU5ca6/Lu8x8ox3t6eVHnhf2DnHFk/1psv2on6KEGYPSyBsTvbw0RHMkOIhtOA==
X-Received: by 2002:a05:600c:3b92:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-42d90722043mr68856055e9.8.1726494555198; 
 Mon, 16 Sep 2024 06:49:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78054absm7321914f8f.106.2024.09.16.06.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 06:49:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] .gitlab-ci.d/crossbuilds.yml: Force 'make check' to -j2 for
 cross-i686-tci
Date: Mon, 16 Sep 2024 14:49:13 +0100
Message-Id: <20240916134913.2540486-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In commit 1374ed49e1453c300 we forced the cross-i686-tci job to -j1 to
see if this helped with test timeouts. It seems to help with that but
on the other hand we now sometimes run into the overall 60 minute
job timeout. Try -j2 instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 1e21d082aa4..95dfc392244 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -62,11 +62,11 @@ cross-i686-tci:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
     EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
-    # Force tests to run in series, to see whether this
+    # Force tests to run with reduced parallelism, to see whether this
     # reduces the flakiness of this CI job. The CI
     # environment by default shows us 8 CPUs and so we
     # would otherwise be using a parallelism of 9.
-    MAKE_CHECK_ARGS: check check-tcg -j1
+    MAKE_CHECK_ARGS: check check-tcg -j2
 
 cross-mipsel-system:
   extends: .cross_system_build_job
-- 
2.34.1


