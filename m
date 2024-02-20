Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F56C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTPi-00054a-01; Tue, 20 Feb 2024 11:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcTPc-00051b-HK
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:56:08 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcTPZ-0005ZX-Pp
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:56:08 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d244b28b95so16134761fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708448164; x=1709052964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCb4mU2T1mew1e/gu166tvVjF8lZaY8QpK0I7/eWwzQ=;
 b=IF1J0jvatC7zE8x9T6yXnJwSDJUBbeueoIaWoPhNLut+m5GWv8/SZEVlCMbqRM5qJr
 fxPYprJE/QOzq7/GoR3Wh0DYrb+lye5j3dXrlaozeofv1O3n5T7rzaK75YFrdLNAn+/a
 3fz+lhcrmoMiYeHsjecAZC4UCONrKK7ZTuHVdE93pkIv8RbHTKsoZPsMX8gaSOrZLahU
 +iHeyhFawPoYMQ2OxY8PKEfdVFUmsjF+TdiaL2EU46Pyd2BzV9B8gh0mJyKcDaAxqFSt
 lyycO/G4iPg7PRBYrBE173rSIaAWR6kK8mAYJsyLW4Y7wJpvYJQeFMxK1XEu+iQZ13S/
 wJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708448164; x=1709052964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mCb4mU2T1mew1e/gu166tvVjF8lZaY8QpK0I7/eWwzQ=;
 b=U/qtjjP4P5bvlHYMJG13Ix5dBpnNqnFvDerLDTVGlDxrTxKWdH/if+GEta4lnvBtd9
 T7B9JhCLqKEq85+nd4aM/DIj/zG6oayLB6QvX2x5ii+2UMrSiy6+T+WL/5yk257e5zGb
 UWc9eQjv1bGOR/2u9Vjslok9gH8YEOf4ejR5Y0yZYuQYeVAUQ+mQV7wB8dCV+KKEFofW
 pXzpORz4FpnrHY3bjr66Q3vNhy0pGfZq7rXO81Z2SUuMBJeyvidNLxK5TYqJupj/Gewb
 +MEm2Hi5UKqkendc3mS6Ipf4bR16mUFrx8GPxEUEgdtlXpCkP4ByoyoeaCeICQZRx2R4
 5UXg==
X-Gm-Message-State: AOJu0YywtwBp5g/mLI/2BhccrBcDSUtUl8X/rqxvzUO3Cg6xzadiAfxS
 A6kVqnEtrcM5ng8Dtbp0J30tt68PgctUCszH0weOdkct/kr4ioqL5wsTje5F5oi/YLs19hrMlDi
 w
X-Google-Smtp-Source: AGHT+IHm6zLLnnXwzCdhBbOjsKLA7tpKp3m15erLhmmWTkBfcivZTLSZZ8bHCT2HkP6Dd5qcozN73g==
X-Received: by 2002:a2e:8057:0:b0:2d2:3891:b43 with SMTP id
 p23-20020a2e8057000000b002d238910b43mr4523422ljg.27.1708448163692; 
 Tue, 20 Feb 2024 08:56:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o21-20020a05600c4fd500b00410ab50f70fsm15259581wmq.15.2024.02.20.08.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:56:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH] .gitlab-ci.d/windows.yml: Drop msys2-32bit job
Date: Tue, 20 Feb 2024 16:56:02 +0000
Message-Id: <20240220165602.135695-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

MSYS2 is dropping support for 32-bit Windows.  This shows up for us
as various packages we were using in our CI job no longer being
available to install, which causes the job to fail.  In commit
8e31b744fdf we dropped the dependency on libusb and spice, but the
dtc package has also now been removed.

For us as QEMU upstream, "32 bit x86 hosts for system emulation" have
already been deprecated as of QEMU 8.0, so we are ready to drop them
anyway.

Drop the msys2-32bit CI job, as the first step in doing this.

This is cc'd to stable, because this job will also be broken for CI
on the stable branches.  We can't drop 32-bit support entirely there,
but we will still be covering at least compilation for 32-bit Windows
via the cross-win32-system job.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Minimal patch that disables CI, for ease of backporting.
---
 .gitlab-ci.d/windows.yml | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 5c1e385dc89..8fc08218d28 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -131,12 +131,3 @@ msys2-64bit:
     # qTests don't run successfully with "--without-default-devices",
     # so let's exclude the qtests from CI for now.
     TEST_ARGS: --no-suite qtest
-
-msys2-32bit:
-  extends: .shared_msys2_builder
-  variables:
-    MINGW_TARGET: mingw-w64-i686
-    MSYSTEM: MINGW32
-    EXTRA_PACKAGES:
-    CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
-    TEST_ARGS: --no-suite qtest
-- 
2.34.1


