Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64E1CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuAJ-0001Gr-2h; Thu, 23 Oct 2025 08:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8o-0008MR-K4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8l-0005FD-IF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so1265386a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221397; x=1761826197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+0U4t7TJx0pQHp17q8cgNldMYGi3quYhnb/lv6Cse4=;
 b=pVVcc+lSaVTqdNcFNmgKEz5KHQv/7EZdo1RYGqXomiKNWUIR/hE/j4PTZGJtdxyKk6
 hXDtixIuoiT5IO+bIXPWvN8PZlXC49N0XwUE/mZRdHBVU1mTgYV+jme/lhirAESrwT2X
 LAC0AkrpEk7m3Iuuj58lLYIC/T4QNwWN47WbU8k7gM6UXWTx0fY1ewdE0EP0d6DI+cbM
 J9X51FGEWvsAj3Mb0MicTUFYfB8ICYeKwWl2fOP0aKWCAGGBH9Jq2p9HJyI72b8570BX
 3JVh4oADNxi/msHGNcwJ9EIwRdSkQHUpuIWOHK9wNDP/JoVO3ypVT50YbOeyYsIu5XAg
 LzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221397; x=1761826197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+0U4t7TJx0pQHp17q8cgNldMYGi3quYhnb/lv6Cse4=;
 b=JYfDiv1K4gcmmw1+xCEIkXczAs/g9aZgEDZffZpF9UBTcNyLW2lJOG0VBYvwH8xLST
 S0f//WleheqIkOnXaW7oL8Pz7nParzIVm3Ojp4C+tKijxCz/ksXlQT1kz2qXWjb6bjGW
 heKz6UrfOGodI2gWTt96z0n00UnEiP6vf4OF5dR8bTNymhhT6oWrE4PMcw2iGGuQKaUE
 q7uTY+BcOn+NNU+kEOUluJwwt2vdkuW4yG4MFKGe8PQOcsPSo6RkL3diZGyh64BDPQ05
 d5NLrQlLwOYRgMZtXT9v36ojOBE3mFnUgdbCbhm/hytnMQ64PUmQhM68qBavRiw97DzM
 2Gig==
X-Gm-Message-State: AOJu0Yw8h3F4z9Ir7cqWkrlFVo3xh9y3HInZxIRSwygvishoewOd+bR+
 Pg2amWhMxa/hGpRvN7loQGEByjoh4yRxCXVzzaMnTqET9xq7Nghy2Dw4OwWDfnAGR58=
X-Gm-Gg: ASbGncsCoSqTSCROVDE1xpvjzUFhslJd4JpuFn61mFLaKxnN1mNJF2S7moYd3jakyhL
 uRAeOTCUj76ABRFnwMVQkPG2gHfcBcs/+SlNfiGVdsTorsKIjCemK3JcNwTD40VeoNTYBDHAc/W
 U2lYRRtnj90FiDslMYyosVzpO1Q0OQ5BBb7VP+Dqbf0iuAOzbSEIkTLys4xtgyx1kbkyVsSFjED
 aKoSGz+0fhOPq772deWcztSEt7lL2DHZbUYsRcsRATH+HIN0o6aRYu8qqtwgxvnEKgwJKYZesJA
 yVPmn0x3dxzqoAO/sgx0A2SV6VE2IwWz1nqUus6UxYfIJE3V+s1yXQbiTQvSpXTnwIMZoY//gbz
 nCMpfsRLnFeG+ZegxqWb9cUa52J5fZ/cys44HiNc+RVIQdCjJer1Cyjzxf4OKf4g2zsCUjm1Hyr
 kH
X-Google-Smtp-Source: AGHT+IGYxYTBza0UK+fad1RIGV4aG5m25NcQ0rxVC3BvIg5L0VkjF4a8JVKWyklfghiIlXAWgrrBuw==
X-Received: by 2002:a05:6402:35c7:b0:63b:ea47:bcbb with SMTP id
 4fb4d7f45d1cf-63c1f64c996mr23288766a12.8.1761221396978; 
 Thu, 23 Oct 2025 05:09:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3f324628sm1531832a12.34.2025.10.23.05.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:09:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 062D960E36;
 Thu, 23 Oct 2025 13:09:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/7] scripts/ci/setup: regenerate yaml
Date: Thu, 23 Oct 2025 13:09:48 +0100
Message-ID: <20251023120953.2905297-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023120953.2905297-1-alex.bennee@linaro.org>
References: <20251023120953.2905297-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

0d4fb8f746d (configure: set the bindgen cross target) updated the base
libvirt-ci project which has resulted in changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml | 4 ++--
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index ce632d97108..70063db198e 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index f45f75c9602..4f1a49be34a 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
-- 
2.47.3


