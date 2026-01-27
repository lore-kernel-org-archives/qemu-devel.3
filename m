Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17ADCA6CBC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfMe-0001IW-Is; Tue, 27 Jan 2026 04:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkfMa-0001Gy-1K
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:27:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkfMY-0003nM-8U
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:27:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso22012825e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769506072; x=1770110872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ueH2hi86xgh4DGYghv/VIDKKub0Cf8eEMBLNW1erPEU=;
 b=K1SjTGxt1GHNCx+pQPX25vnDHckdBJkIIKfM/KaYf1ZVC5DfTHe7j718OO+56x4rGx
 +dVz4gf5Nuqvkr/Or46jqqI6dlyC6X8P2IfMltVibYw1KKr8VwCQxj1RRKgI1x8cCtJN
 V6v4kF5bp/cjuwurptDJwCFZXLtkUCuTTvpuGqaKGJ145H2ZVQHC/fzUrmrrC0eyaKCt
 ZeM0KV0/P4066/+NFuJ5MwIcbs+3NBwyKl1XZqlLUB0LTW9ZNIMIAWalCrFVZVa+gbQw
 4LaC0CzVfAunruKIsZxi7J7WSOU/GWqC9r4P85zJIV9CXmVncwjaE2kD6OseQfA1WrGy
 tf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506072; x=1770110872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueH2hi86xgh4DGYghv/VIDKKub0Cf8eEMBLNW1erPEU=;
 b=waZMUQmaoMvuXMirOzbBtPmKqiwqypwXFR65kj8wvhaM6qX1Qc+WKiilq4AjfARu6u
 FW56ir+QN0p2QKI96wYIsrj+vcPd8voiL0Nf3X/y+5aze7MgfYVcCF0xwse2wPWNPsJC
 O5lssP1aYB6H6qQCInOeNmpstHU40uHGPNTxCXhxSZkz++7MsUA1GRuZTEQpm+8ALAxt
 WpgysMzVEt4R8/ptmVnQzOPXwMyT4hsSfdexisG6jWv2IvOoYeAQRVZHMx0GiYMU1jvc
 rJSYIDUxJNd7hmEphkdBip392AHu8nM2zR4QpzHSH4yjGkPKKPpWkYPO5Hnr5SxDIcfV
 h96A==
X-Gm-Message-State: AOJu0Yxu2JgIrhjnf8p66zAkCaPnIZSDQQMxR2D2LLJ/xQaSUWwgmCng
 Vh6fHWq99y5b8bcDRYtt0yXR0CU17c7w4q6M+r5gll9b4cuxhjdv33Yv9y0bzYhUh3Q=
X-Gm-Gg: AZuq6aLIoKKe7o/UfgrQNsRLZg+qIUhnMW5wmO+56yHZpAIZzDc16PKXQ5vE/U1qQKe
 tInZ6nj1QE0HyzypQDX+hyW7sOSHN+rxptTbC0FR9MWX/QRbi4JPemoUVJ1wbmOnlulKH/9ms4u
 Fj5wnNS/vlXzyAEK2ODmSbfTV+aYwQi4dHzcPhOoLFXxOm8aIFt2Z59Z0g2YBumC9u6jTYYUM8i
 Ai/dcJFqteInOWdVx+qyhrPAWnuHhE0bIlcPIclJcjzchtgqax10v+Jc/4Yqj3XiMnh3f/uGKb+
 R1T83UK5VCQZUt0UhEG7Ej9gxOfYvi5c76gFVpG0HURENbgyU2bvtk5FwPaXyKaNEaVKou7ft4B
 YVEHwwZvSgKB22mLWvlNjHzLvnTvJsinQGqLQTl6SYtXYik4W2mvQfJTi0xZMrX8lfxMmD38dBF
 jXoQpqV81Y6R4=
X-Received: by 2002:a05:600c:3e16:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-48069bfada8mr12586695e9.8.1769506071818; 
 Tue, 27 Jan 2026 01:27:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c034dfsm48937645e9.10.2026.01.27.01.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:27:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E10135F811;
 Tue, 27 Jan 2026 09:27:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] tests/docker: rename wasm cross container
Date: Tue, 27 Jan 2026 09:27:45 +0000
Message-ID: <20260127092745.2978371-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Now we are 64 bit only there is no need to keep the generic name. This
also fixes a check failure in the weekly container build which was
checking containers based on the expansion of DOCKER_IMAGES which is
based of the dockerfile names.

Fixes: 4203ea0247f (gitlab-ci: Add build tests for wasm64)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/container-cross.yml                                | 2 +-
 .../{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker}      | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker} (100%)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index d7ae57fb1f5..923044e9a12 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -78,4 +78,4 @@ wasm64-emsdk-cross-container:
   extends: .container_job_template
   variables:
     NAME: emsdk-wasm64-cross
-    DOCKERFILE: emsdk-wasm-cross
+    DOCKERFILE: emsdk-wasm64-cross
diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/emsdk-wasm-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm64-cross.docker
-- 
2.47.3


