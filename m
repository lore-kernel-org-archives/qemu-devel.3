Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D72CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 05:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ZMa-00085Y-Oh; Mon, 22 Sep 2025 01:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v0ZMV-00083H-Hl
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:45:19 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v0ZMI-0004uV-DM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:45:15 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b54c86f3fdfso3655990a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 22:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758519904; x=1759124704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8uv1IOkBodejatxXR4c2fUFX0VB+sboU5kl+xqzijE=;
 b=ySPzAwIzuR/+xB51nS3i+3lYMpxdk8BGl9vemwj5rsA88sRakJK7PiRV9yYHx3TMqa
 5keiO3fF9Lr5TXQDHf5xXAQorjFLN4ld02ph0Yy+seBXLsaWhrDOj/ZvPJch0W+1k3cm
 F1BBJtAOo85WtoLRaU2ndxbKQIGry6+qjPc0fEfQ65Vijh8IadiXqeQA5sOlVZAMkHuV
 KXAEQVm9Gr3ddI5ZIVpYobtIUM5U6u3/tA7y+ET1844wnXlt4Ea6JlV5H9FhYSbb8OY0
 SF4IEVG6o+hHYtHutca3JH+HsN5DD0kEiDisjhpVSuhrQoWU1eOJN7o5ZRDBV40Po3lm
 lRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758519904; x=1759124704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8uv1IOkBodejatxXR4c2fUFX0VB+sboU5kl+xqzijE=;
 b=KsuVwm7bpeDe5GMEj1M3Q9CEjqx6jGfaRDZgCLJuB3en5mbPB/lnS5HuDkWQsClk68
 L0J+VC5qU2n7EjVvMaJgb4Hc3/PTlF1/gwWwjmRHWiBPoAU0RWuR545FTmtzFShsZsBx
 Wd9MjVPi8PaCkXF8VosBxdf8i+Wy5llfhs/kvp1yrktaTIy7HefqGCPfC+fgzd/gyfKG
 x+C2EAHtizggtUtHlsfaoRcnIqi3nOt55EYEoLUq6rQU6tV7aJUWA8AiAJxUw7e78GBn
 laMAoOpG5gGZQIwHDQsouMHYXK6cfHKS/62LQSK3F3az4RtYRPD/8NAewXPOSx8YgPt2
 TvAA==
X-Gm-Message-State: AOJu0YzOPHhaacs1HmAYhbDws5Xxzyluyu6ExmW0J3GB8Y9gqeHL8oaY
 ANCTaJxCO0HoUi44m7M8IemCgHJGgJbpok8mS7YMnEp4+KztwM01zQR9dxfaGC7/CX+9tIxhU/L
 KU8OP
X-Gm-Gg: ASbGncswyp0khEO9jB5TRTu9G+8bbJ65vdm7tgECm+JjKlVtOQHYI/UG3FQ7y4ddLIA
 h0MrYxL606lEJ6vOoQchORsSE3Bxt9tQwDT7AObhaghR4e82ZG3A7e5z/ICIGaaay76eNhEL2bM
 2+H49tb4k03o0l7G23ncNHF54B7jshm6Y7x4KtAP+hkwuPmVpGOcTup4lN8iSocgGAE99BLqzDJ
 gtj/DERiO5i4HI54deri3p7VNxMRdNTCJjqMhjlfy8v2o8XshYzdLlpsnii1wJxKoqAcPdHjJpC
 Iwd6LSdWtStNYErTqpT9mEgCi64R233AjlONyBFp6/ax6ZcCQbCVx6rwpAeZAz0AevNR4P0Sdud
 8vqbNb4XoIRtTWbq9fPbOZKd0qaXZDOg6bveeAkzwFyAdUzHGfhnqREBQPsDya3UXtGrxyCaFjq
 OPYIDwJ24=
X-Google-Smtp-Source: AGHT+IFepu/JwIb0/EhfInczv3G10RcU2NuZb03HLCnT/mEcKSN7UsddnrD1YLCO2NJWaN0zGHfgDw==
X-Received: by 2002:a17:903:2344:b0:26b:3cb5:a906 with SMTP id
 d9443c01a7336-26b3cb5ab33mr137917895ad.16.1758519904046; 
 Sun, 21 Sep 2025 22:45:04 -0700 (PDT)
Received: from gromero0.. (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b551c279cd5sm7691377a12.3.2025.09.21.22.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 22:45:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v3 1/4] python: Install pygdbmi in venv
Date: Mon, 22 Sep 2025 05:43:48 +0000
Message-Id: <20250922054351.14289-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922054351.14289-1-gustavo.romero@linaro.org>
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Install pygdbmi in Meson's venv. pygdbmi is required by functional tests
that interact with GDB. pygdbmi size is only 21 kB.

The wheel file has been obtained with:

pyvenv/bin/pip3 download --only-binary :all: --dest . --no-cache pygdbmi

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 python/wheels/pygdbmi-0.11.0.0-py3-none-any.whl | Bin 0 -> 21258 bytes
 pythondeps.toml                                 |   1 +
 2 files changed, 1 insertion(+)
 create mode 100644 python/wheels/pygdbmi-0.11.0.0-py3-none-any.whl

diff --git a/python/wheels/pygdbmi-0.11.0.0-py3-none-any.whl b/python/wheels/pygdbmi-0.11.0.0-py3-none-any.whl
new file mode 100644
index 0000000000000000000000000000000000000000..3009f180cb802312ad694494a60660b53ffdeebd
GIT binary patch
literal 21258
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

literal 0
HcmV?d00001

diff --git a/pythondeps.toml b/pythondeps.toml
index 16fb2a989c..89f2f76545 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -21,6 +21,7 @@
 # The install key should match the version in python/wheels/
 meson = { accepted = ">=1.5.0", installed = "1.9.0", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
+pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
 
 [meson-rust]
 # The install key should match the version in python/wheels/
-- 
2.34.1


