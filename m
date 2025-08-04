Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A4BC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 10:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uisrT-0003it-8B; Mon, 04 Aug 2025 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uisf1-0004Ti-Ki
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:43:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uisez-0004Gl-GO
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:43:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso3230182f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754304194; x=1754908994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sNiQC508l+WCc0MTo/DkfVSbUe7AjeA5hWYwdxD/wCk=;
 b=oRKosY43ZSbkMo7g+aFU2NydhzqSIKhasQBcUIB9Mkx4irtBvVGoMemegAlWVqwL51
 wvPloCMaDxjB0zPbOzc2OcHjD1J2CSqZtViZA9re1U0djLtHq7GOgrCWNoKyKT4U8jCg
 U4bNSis7q/RhiadGi1/rBZH5pnIqToi6xu+NgmEG2amSltJ5WkrFqvtGXycT8xH8Wbl8
 uLuhOe+IQsrDRSXBJE1nu6NbLKSzqRTXwWoCwEFEomfYLFxg1D7T2+eTOnVlKCL3PH/H
 3XIzTPRqlvMwdc9o9PvJ6vl+uhBRUe+dKez0QWfgch9TrfN652EvYPIjGQS3SWUF4d05
 eUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754304194; x=1754908994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNiQC508l+WCc0MTo/DkfVSbUe7AjeA5hWYwdxD/wCk=;
 b=PSBfTSyewwpQe60JFoUEewz7UGD7IAQCF/yLIoNBRavcoIA13cG8uTRLCj0aetc2pa
 uAxvo9H9Xm/+ay50orrUC8+hZT/lug1IKsEDh7RmhOCk1lbIiig1gpSvZdtgdim0WuxS
 KHofDPfEpDxMDA9YqL0erkvquHFXowYimBaxSjuqJ+/AXe+5tGXyjNuTde+LTjLRg9Nv
 CXZ3IvKRpJWrXYhppuUm9BkybeFE2hV3Jz8g4AajxgBaEv7i1zRPnGSjAJuZ8yMWr/av
 pOAImfFwx8Rnx0DNL9e+2Snk9vw4ujXYlWqsW10gFz2DbIJbWrUt9gxbutH5KMrb2nLh
 zFcg==
X-Gm-Message-State: AOJu0YwO9LwJz5lC8q0ctgYWiBEEdXDTvXNPPmIzfGR8MpjTdwDWBngY
 4VxsG+JVwFpeD/UGYTLR5Ye6wLrat7fJCaLlj0ZkTjNupVgFTsbUwPD0TiaAu6YKkwtjaPZ8iij
 ypJVj
X-Gm-Gg: ASbGncvk4M9wbwSd7w+q3477Tqju+5bU2lhNDCIHemKMGwumoMeRXTw+B0tRj9iOPlx
 BtowXh046jC7Ssqplnp6jPXsFZndi4fhRifiG5IG+MIrM9T2ALPtA9cISQkjv3NfVc1li54PzZQ
 T8q5GmcNIYdTEwEWdABv28kS9V3k8bm9CMvyJ4WToXwVhRL81Koa46VvKuQjOVFGB6utqW1xoZW
 K6hqZI5s1xQfc3qwz/V2f0JNyYAPfXliofADcwXAigb15piGjxozEsvJGWjZOr4pnjVLYiHTeKi
 I3Wnv0dqfeCumqg09dRTyYvVdxxqw4s8XK6AwmSk0WQtLRbPLCX70vPBUOgTzGW6Cfu7pSgft1J
 BZM2kcXTrkdCUZMjHUYeRWAg=
X-Google-Smtp-Source: AGHT+IGJiszX9On24i1MUJb86qLkrre5GdI8v8JFZpRlGHeAtP5cvfWIhMmwIruquvux2c2bXlqNvw==
X-Received: by 2002:a05:6000:400d:b0:3b7:862e:e0e0 with SMTP id
 ffacd0b85a97d-3b79d7f9142mr13213541f8f.23.1754304193699; 
 Mon, 04 Aug 2025 03:43:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ed0ecsm30531655e9.4.2025.08.04.03.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 03:43:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1BD85F88A;
 Mon, 04 Aug 2025 11:43:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1-rc2] tests/docker: fix docker-all-test-cross
Date: Mon,  4 Aug 2025 11:43:08 +0100
Message-ID: <20250804104308.250949-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

It turns out you can't easily expand an ENV var across multiple steps
in a dockerfile. This meant we silently dropped the architectures we
should have even on amd64 hosts. As the updated AVAILABLE_COMPILERS is
only needed for the following apt install line just merge them.

Fixes: 6da616bb170 (tests/docker: handle host-arch selection for all-test-cross)
Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index ef69bbc8a51..420a4e33e60 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -62,9 +62,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
   fi && \
-  echo "compilers: ${AVAILABLE_COMPILERS}"
-
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
         apt install -y --no-install-recommends \
         ${AVAILABLE_COMPILERS} && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
-- 
2.47.2


