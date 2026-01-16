Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FFDD4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaj-000569-NV; Thu, 15 Jan 2026 22:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaah-00055l-Kg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:39 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaag-0005GW-2i
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:39 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso1386890b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534416; x=1769139216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCUzcYbtSzERFupJae9HyrfFCPO0z4l1+p7E2IR7BMk=;
 b=k4yDY99JsEyvyJdg/6P9HrMCaVTSVaGQXdWb8HzYpXpwobysEX6yB5ZkqaZ55TDdu+
 UVOs6PtlHbG5fTYAezR6rIRbn92IZi1dOompW3sL8WLs+2EE1/x7VIvQIVaQHUfp4qBM
 khJdIOPxYsk78ow86twn8JOdcJVLLj8u8mOkcHl8rgeRqvzQdMmda+OwAVIwv9YGxVS5
 OWdBSxUMUqwnROtU62MLqnLVYqwH6j9TtcSFu4gJrGxanLHWqbgmJQRYmGKnbPWoGQIt
 HWd88qv//VYkGxB7hBDrbibWjL0Bx6O3Dm1nL4ohmyCPET6Me74cA87RMcOWh1S3bASd
 K4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534416; x=1769139216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCUzcYbtSzERFupJae9HyrfFCPO0z4l1+p7E2IR7BMk=;
 b=BxK/6Y4wYXmm8ZyDkKkGjWqI3YG5HQxRHxxL3ViQZzV58MNeCcEFopLEl6ehSSQLpJ
 fIAEp50k0BpeWXI6DtETSTbH/LGnkFv8GW4zv/Jv+yskoTJV+NX+9m+LIjPEnFRw9Tvb
 uwhWs07aX7cE5eRffEBC+LQlvN40FuuGjCsxeMnos7bI9wBSZcfLt/AQ7Gaiiq+YOAf3
 Sgmb2B8do0Oxb2Nmw/Q2zp511lHVFU29teLjBwZQHRfax6suGpAISiI43LQgAeoJjjwU
 eqpE9blb6Ab3fq8laHKfWGe3Khf04v6DPGsn6pXdwUyI8sARsKniI1Is6MnT3f6yrhMo
 WmEQ==
X-Gm-Message-State: AOJu0YzOv9UVdu4hg0hl9xx3LWjCm0APw9xoAQkj4G8yyu1MxocnbIWk
 Ny6lqOpcbWlHTJukxjCH0n15AHTAtJ2Snn8vsVpEySu1c/7yPq9gSSSLG8pbwxnD23jRQThEfgA
 FRL24kWbudw==
X-Gm-Gg: AY/fxX5Xb/J54ZLeX2KGu9Mga7yu3/qAVdON1V3oflY9LWPA/CafdfFry5UqNpaBuql
 /bDhhXP5ocwaiCmQ4xhi99xrwZPKxsX09g8zPFlb3jE7srJiFUEpn6PdCIT4IcTpK9BhVANcSW3
 cL6ltN2vO6LzVJJv1vxetnrxkNpNHj0EUGr9PZoJ542sVlAcXLjoFz6sNq1vX0orJvf77ynDKDo
 mIOa/IJIlPvUfxlog1Q1dkMi41GylPzF0aTPRpU0EsynLHqGHeEhHIrzhQJOuQqSuvyLTqtruJb
 C09aXELcmyRNjU7OZVj1SbcmSzZC8mGXOhi5MxOLoD2/MSNtPl8YaxeUNo3RwBoDyLXYGikEJKP
 LkSLusEQcioURtyoXwqN5cPJqyahsVj9viptDNdolbHQKZJepPqSqqQbYiIoyG8eZsCrghEYJxg
 /rpNRYNMJxD+0h+izaJA==
X-Received: by 2002:a05:6a00:2e9b:b0:81e:4ec2:da9d with SMTP id
 d2e1a72fcca58-81fa039fe3dmr1539038b3a.46.1768534416503; 
 Thu, 15 Jan 2026 19:33:36 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 05/58] gitlab-ci: Drop build-wasm32-32bit
Date: Fri, 16 Jan 2026 14:32:11 +1100
Message-ID: <20260116033305.51162-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Drop the wasm32 build and container jobs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/buildtest.yml       | 9 ---------
 .gitlab-ci.d/container-cross.yml | 7 -------
 .gitlab-ci.d/containers.yml      | 1 -
 3 files changed, 17 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index ea0f5bb057..e9b5b05e6e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -785,15 +785,6 @@ coverity:
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
 
-build-wasm32-32bit:
-  extends: .wasm_build_job_template
-  timeout: 2h
-  needs:
-    - job: wasm32-emsdk-cross-container
-  variables:
-    IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --cpu=wasm32 --disable-tools --enable-debug --enable-tcg-interpreter
-
 build-wasm64-64bit:
   extends: .wasm_build_job_template
   timeout: 2h
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 7022015e95..6bdd482b80 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -86,13 +86,6 @@ win64-fedora-cross-container:
   variables:
     NAME: fedora-win64-cross
 
-wasm32-emsdk-cross-container:
-  extends: .container_job_template
-  variables:
-    NAME: emsdk-wasm32-cross
-    BUILD_ARGS: --build-arg TARGET_CPU=wasm32
-    DOCKERFILE: emsdk-wasm-cross
-
 wasm64-emsdk-cross-container:
   extends: .container_job_template
   variables:
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index dde9a3f840..9b6d33ac13 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -58,7 +58,6 @@ weekly-container-builds:
     - tricore-debian-cross-container
     - xtensa-debian-cross-container
     - win64-fedora-cross-container
-    - wasm32-emsdk-cross-container
     - wasm64-emsdk-cross-container
     # containers
     - amd64-alpine-container
-- 
2.43.0


