Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C44FC3DA41
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPkty-0005en-DX; Fri, 05 Jul 2024 11:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktq-0005bf-7M
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:04 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktm-0000He-Fm
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77c2d89af8so164664066b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193455; x=1720798255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opDNu+IupAr1RipdhERW7M7QO1kyIP56AngvVE3Dieo=;
 b=zy66lh6uLtmbnHP/7GB2SmWSjqa+OiLRrYsMM0M1u3fvjvYFKYjuNoyLFlk+iyVAU2
 hoLvVmPJCA87gmBcyrchAi54jsStxfhIGBM8D1RzXU1/VYFFFoR7mh2AYnc5qZIdEdgH
 GSVKD8sYKt3QnoStqBFfu87gHuKQZzpbehUUvYlUnb5CE14ySaR9vSbhdxjZRuDW5Ptm
 3hz1lg+mFNnsrvZFAHeNA6Sch79EeS8XSkzviCHdtr1w6Wzoe4GWQrMznpuQEuOOxDhm
 n4jhO8jvGoyZNlwUW6KUgWZepZORdPfj3aK6CB97VzCv25/98FkKCA+8qKL7Su0Yvlu3
 /RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193455; x=1720798255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opDNu+IupAr1RipdhERW7M7QO1kyIP56AngvVE3Dieo=;
 b=GGNKt0P9uGwfkC1nukzM+ju294sLyn2Ya9mBnWBo8WAC2ifOHxPtF+XcC+yK5wdtly
 q82xs0C+CETiGSM2C9HJrqqiVUBRjf5A3a5oKjQlCe0hKbk8OncNCEu+Rfh0yC2L1sxm
 xWksaXxrEVqHHN3teEmFIgkdKhSW4oswlF/RrvcSWbsAFjbxo6e8mCxkpjZtkUQAPLfY
 6dxbro8Ko6ZRmMs/TMeT6dbLWXECHM2QBxV7jdY8LyTwbuLa34LgKJ7oX3UL05t8afZv
 lKvqoI2VWwXAdyQHxKyckqdikibOVXPHc6HyIqztKT0/ZGPhxQY5aF8TsGPZpRW+fGWM
 qIqw==
X-Gm-Message-State: AOJu0YziA+qKGzj1j0epip9RlfaEYPnroNpMX5SZwb2Y7I5BC5cg+jAW
 tZN7EW/qVfyr0ULLZ9R3vulr3TyAaNIHG1zrJSTVZjZSIoxXysTOY+jHwlAg1ss=
X-Google-Smtp-Source: AGHT+IFdFfDntMmeleKEXO7dviAH5wDdhVXxOdrsqph4KadIA2NIsuPc/TUSUfKvEJb7cehbksl9YQ==
X-Received: by 2002:a17:906:228d:b0:a77:c314:d621 with SMTP id
 a640c23a62f3a-a77c314d83amr209266666b.13.1720193454631; 
 Fri, 05 Jul 2024 08:30:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1bd30sm698297466b.12.2024.07.05.08.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37FCD5F92A;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/40] testing: restore some testing for i686
Date: Fri,  5 Jul 2024 16:30:14 +0100
Message-Id: <20240705153052.1219696-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

The commit 4f9a8315e6 (gitlab-ci.d/crossbuilds: Drop the i386 system
emulation job) was a little too aggressive dropping testing for 32 bit
system builds. Partially revert but using the debian-i686 cross build
images this time as fedora has deprecated the 32 bit stuff.

As the SEV breakage gets in the way and its TCG issues we want to
catch I've added --disable-kvm to the build.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 47bdb99b5b..3de0341afe 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -37,6 +37,17 @@ cross-arm64-kvm-only:
     IMAGE: debian-arm64-cross
     EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
 
+cross-i686-system:
+  extends:
+    - .cross_system_build_job
+    - .cross_test_artifacts
+  needs:
+    job: i686-debian-cross-container
+  variables:
+    IMAGE: debian-i686-cross
+    EXTRA_CONFIGURE_OPTS: --disable-kvm
+    MAKE_CHECK_ARGS: check-qtest
+
 cross-i686-user:
   extends:
     - .cross_user_build_job
-- 
2.39.2


