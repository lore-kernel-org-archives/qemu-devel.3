Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6605FC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtH-0005VL-P3; Fri, 04 Sep 2026 09:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtE-0005TU-OQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtC-0008Hd-Cv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso10864755e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528209; x=1789133009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SvEt8Hf8LMw1pvtF6NguqXUPwe1nFKcM+ugRFAyNtFs=;
 b=C1AXw3Jzgmy5/se5NnXk1fq2eM2lCB8na4Gu7CqGT5OqbPRxn+eIgtdIx4qfxs3zbA
 SIc/GOj+n8M47MmhS16AiH5cEEqA9uVQlTRFtTbMTsugvRfxxX/gLNvtOI4BhlXMO3bw
 myFeHgfi+RLBw45g0cwVOT+wqBoeP0TP6A7r+Z8FrAJ49BetQwnfRvNcjWqfON4mpmWN
 +yXt+umpdUhkgcR5aAW3+SOqUxiun9w4tNlrhx6oL7TXaNCG+nAK+pXmLd+eJD4WzpiG
 9ED+/vd6hcFfhR8bKmaiRg+qBJp4EnPcdFCtup7vTsB4T9Z/oY4jr5hTisNjparZy9i3
 J0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528209; x=1789133009;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvEt8Hf8LMw1pvtF6NguqXUPwe1nFKcM+ugRFAyNtFs=;
 b=ilPI4sewbieegqj1I3D4K6wYOMVHA7wDGUYzbm2CEJCtNkm3DIQYRZZ6XFBTDVIf7c
 x/DMBUtkOWm5c7nrWvm9B2vATdt4RRAAsUMquLWlSsejPVjam/8cJ4Raq+Nyq04jzlX8
 WaOajrSUsAsM9jOcBUEcc43GmOE0seC8jkWhhWgLhGt08lOOsZOSyDyJgiYcYPSvN9wK
 Cn55z5+5emC/tL7rB6j+1/koI2nHoWQwZrjuow4hh1IEHXT/uvcLbOEcxdTa9SfW1VaD
 2JmWGvbDemR98QHuxeWLlyzSWXpzCw8DZPmZYFQm1jFa8I4Q4tepZobh06EYYZc1Eyvc
 jVlA==
X-Gm-Message-State: AFuF++n7nytJUzbqo7pFMun/fN59YSUkGgvCJtX6Tj+hKUjK9a7/CHI8
 ta6ImohRjFT9JqDhmM8kM9yGbQsyzGBkvtl7yhzLop9eLom8PTuhQBQvIYUKHF4PeIY=
X-Gm-Gg: AYBFou1c176N5iLpbLnWugR/MMKN1AjdzHresX6mKFIxdZf1XkWRGd1E0C9fZgwyXtc
 sbnfww8Z7DMBuv9oH4kDgQ5rXvmrFOffRb18mVQPjGh/XND3qSRjmZg5KW+ODOb9/eCuNsai+3b
 eoy0lhPcCLU1T0IdS/tH5+3ueByHnu4pniZAFb1AKjtjcYrmiwKxtPhxYmnKhXQoHvPdRg4uDst
 NEur5C11D3Kbm5qpTfZjQV35WiXGwzBmrIy3aRfn+0d2iHy4Ad08j4mGq0vsx7EtnFKfqIiBgbB
 n9Wy86W7E8gzFvH5Wds/OWWwtQTIyjfiiqXT0so1xOEnwFHyP/4GMCW+fPTvFNZi5ugKkOGpCEh
 zKwWGRiE7bePOyvPQpzCw1bvPScLKKhKBpoMVP+roub0oP/6+tyRDWZ/pdP5GJW/e29XaxJVujG
 UUGtN5DdixpXCgG1sde5XeAli+XRWTtibx7+CbO5JRNy6+r0CaZ2y/PM2jBhLo
X-Received: by 2002:a05:600d:4452:20b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49cf81f1542mr78618725e9.7.1788528207426; 
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cffdb2c40sm594215e9.1.2026.09.04.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B3D661DED;
 Fri, 04 Sep 2026 13:46:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 094/105] tests/docker/dockerfiles/debian-xtensa-cross.docker:
 add test_kc705_be toolchain for xtensaeb
Date: Fri,  4 Sep 2026 13:45:48 +0100
Message-ID: <20260904124604.2207440-95-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-95-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d9130fc3378..0eb6d98cc75 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,7 +19,7 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400 test_kc705_be"
 ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
@@ -27,7 +27,7 @@ RUN for cpu in $CPU_LIST; do \
         | tar -xzC /opt; \
     done
 
-ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-test_kc705_be-elf/bin
 ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.47.3


