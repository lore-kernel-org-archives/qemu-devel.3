Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DD7D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKC-0006xR-5Y; Thu, 04 Dec 2025 14:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKB-0006wN-AX
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:11 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK9-0007Ld-Jc
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:11 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e33956e76so734937f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877748; x=1765482548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhHJnAdbmOoGkjvYgsfuojFx2b+1xRYWP+wFHhpKRo0=;
 b=jBq/GRXJATl+BSugGwzgafgV+Z1NMN6iLC/Fxvm9QWeJN7FR5jMXYDHcRKwsmUePA9
 2ZOmk6LQ+05DYtQxoOsY69Wo+ycE2SmCKqUvyLDPvtuoqV/vcBlrd6grQHe0pgKVDhvU
 LzELiblSZ6oTbTTOFXGkRTollGwgrIAt6MDpOLXxzPYqXt7L+8/AbmBE37TbC2XS6Ghu
 XNAwTy7N8F10T7WRSgzo9WzI5rTy2a14Lg6hUHyBPP4lbg+WGwfVNNB3Jt1Nu8nf4v5+
 Uy8jLF955frcirrHYr/8DeoE7dt+O4ZvqL6b5nas1XZ+3GGq9KgexpaeDFO+Z64bPVTR
 loFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877748; x=1765482548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LhHJnAdbmOoGkjvYgsfuojFx2b+1xRYWP+wFHhpKRo0=;
 b=pij2SZrm7elU4NhrIyGV4CHfLUKTy1I+ERvRQT5zuqoT78opKauJDeEs5NBRhH9R+i
 SN93eXe2YM499ctixBBbRdpWcEyGWSYPlj/hD86La4eFaU9N2/YJisNp6k4unoU1bJkF
 KulRjGDoDvau3q15dLLyjUwcWpBihuqFZsD5Va9i41ZgZUTdXGd5UjZ2lSoK9pIqc/tu
 yX6zopTQfpWAZKn7mObGI5DONiZ/deYoNw7Ea+431QzGpGN7LQInj9E5zKAxFTW05oJV
 nOa8gVHhz4su/fvwiFvfRc9aMxkpqFSSaXikrp6JMAsP7c/y25nRVDliwyF6XoxQ7L2I
 o4Bg==
X-Gm-Message-State: AOJu0YzSbIGgctCPPm6Dcx7jeNEye+nm9v0ITNiHwglyYbQJCVcGMdAr
 CLThemUITWtE9pMx1pV5zP19hgBcB5Oc8kdtRjYgz64nckdtSXOYWr2rVWys0eACeu0=
X-Gm-Gg: ASbGncs4YEStwdyxZ6TPi14I/zN2UERE01k5xOlGwMPOWifaSndjWmJu3snfUrFXVOm
 AztWJlUe5i2QuPXEFgsTTWu8/ZN5pz8izfrW2wk59g6f9xsiH8CAALSeYdGXFiXY+B6a584Pytp
 7X6TDldae5kgINTf+mgzsVUTUH8dcimA/Pj5TOcq86+U1m5P/e+Z77TQ189TyISwxP+HGEwYkIa
 Sb7176Vpn0mm9yM+C/TuM6UAAmzuONfKij6qac+O1CpO8AcUPY46dAB7Hk0vn0S1QXM1390m1Ll
 Ad8vXVekXHJPFJyWPsFEyk1zotcYJUaajnwsYsG7rGPxgTeUxStxHZvPoOsZL3Xt6yGqM09t7bT
 hSRiO10iXbv6NBzi+lcdcr8MLX7aipRZsso3tGyYV9gZDse5uN0zvipPUuHWQO3BntekBCzKH+z
 gAZFiK3Ii4XEs=
X-Google-Smtp-Source: AGHT+IGqE+eAcyyOCCgo8+l6a7rhkqIk0/0kjo1FRkcIFoG5V6jzpkvRmaY41osl4xol+EEk0+UMTQ==
X-Received: by 2002:a05:6000:2dc2:b0:427:2e8:fe3a with SMTP id
 ffacd0b85a97d-42f7317cdd3mr6564361f8f.13.1764877748072; 
 Thu, 04 Dec 2025 11:49:08 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm4997234f8f.32.2025.12.04.11.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9552C5F90B;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 10/11] MAINTAINERS: update the custom runner entries
Date: Thu,  4 Dec 2025 19:49:01 +0000
Message-ID: <20251204194902.1340008-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Fix a number of issues:

  - update the ubuntu references to 24.0
  - add the s390x and ppc64le yml files
  - replace Works on Arm with Linaro
  - Also mention IBM (s390x) and OSUL (ppc64le) as HW hosts

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d007584b476..63e9ba521bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4444,12 +4444,13 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
-GitLab custom runner (Works On Arm Sponsored)
+GitLab custom runners (HW sponsored by Linaro, OSOUL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
-F: .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
-F: .gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml
+F: .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+F: .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml
+F: .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
 
 Documentation
 -------------
-- 
2.47.3


