Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD04CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU4E-00015L-Nx; Mon, 11 May 2026 13:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU46-0000tM-F1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU44-0007oC-4G
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso1092657f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519106; x=1779123906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmRozKMVNlBNQT+PxNUbxbWDs9Xv8pa0X9SBBpzgdpo=;
 b=Qx0rPYNxJfVlQwrGJmMWJ8zbLrDrIt6MlzUPE/hL6s++P45hHvDHFjvft4iLElw77b
 xF+5QazxQzk4+wmtDYpKbekINva+1Erm15sgKfnze2oONLwcdLdmGXGtougZMjzTXHIB
 H9KyLyPM5M9N4OekuERDEurYW9oGkI+sixUpTAOIKoNPMW5lyaWeYpQNsQsUMxVGJALW
 C4+z0iJJp3QWqapS7UmJdvgID6BdDTkSyeImo70kjdZHgZN9MFCki34hXLXIsSXFMyNS
 ZZJ7mCgPg7iI/ae4NxPB2wkI8b3CZR33ioh+fTiyeufJQEtf6zTOWSNIMs8WpXd5Zw2b
 Z1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519106; x=1779123906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vmRozKMVNlBNQT+PxNUbxbWDs9Xv8pa0X9SBBpzgdpo=;
 b=nP+RBSXLjcE+AUfiMKhBI39gK2caHq1dYNLwyD6DIwNvk038vqgWgD1kUjlae5uF26
 aDymQrUSEvnOcwhv6tsc+L0pV4+Zdw1qA4BcdA+mAVLKf3cmF6El6zmTHhhsBEWO0B5X
 WiFt+IViRvlnJ7nJupahjrlDhOPrHk3rXjIb/AdsD2ovvPO8/2KbdZSBNIHE8g0IoKz1
 pM2OVAJa8g5RWA6Rj1k1QueJxkAvN6eJo/ZzXtkb5ocjAwtcD3dXvYSerYx71e9GMKSo
 +9GgrglTu+dgAg/fHjlErIaZsV3QZuL4tSon9maMV0Z/2FdrJ5VNe4ynM3w2laEfApwu
 r8RQ==
X-Gm-Message-State: AOJu0Yz0Ml7/ufdKX/xyKTX9e3RdSSYVaYA4mJukVe3620STYEOTCpuA
 93pwa9R2jar08U15XaL3xV/szS9O6Q0kSdHzFkB7ZCM5RtPBYfucvXP5xhsrMPpsJfUV2ScU6+8
 zqBUIpSU=
X-Gm-Gg: Acq92OFM7YGxet+f9buxVcTeGm/D5EMt5za3XgrrpdDfyCyqMwm/NTRQJBt1QiDRCbc
 sXFZOpNwOGwY2XuMXnSJW63iol8qoA8kS22sxfGnOpNYfRpCTqLTP8SptzXvDtnJmFjZ0WyTXAj
 8/fsKM7/C//Oy8dU4yonUYhvgsc343pMLrGBemKf3hjsCC/uDwu9Jkp3CjwUnHvnXwof9I+nQGk
 sSdhXaXnbZ8ahw6bF2jHH2ctgnuycjHQ9O74OqIiuCNdWPJr2oevSLBKkEV5SXvUo56XbavNTa+
 dW7UmcxxPA3BCCWqLlLo4FhaOM56pjtgtoJ83aUPZI07bM2ySykE+Vbv50hBnJLuydP/QLlK0cn
 8m9dSupKnnG0veZolKD9uSTheEkgHrW/JcbSCFwlEHfIvylO2S3bBd8JWYqnFfPX1/fhDo4pn/j
 pqEa289zrhiOiJvqld0bZotN/TieGUuk8gUA==
X-Received: by 2002:a5d:5f90:0:b0:44a:8c10:40dc with SMTP id
 ffacd0b85a97d-4515b9f3c74mr41712432f8f.18.1778519106211; 
 Mon, 11 May 2026 10:05:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b071sm26227233f8f.14.2026.05.11.10.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8714E60F76;
 Mon, 11 May 2026 18:05:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 10/10] MAINTAINERS: add a section for AI agents
Date: Mon, 11 May 2026 18:04:59 +0100
Message-ID: <20260511170500.124211-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

For completeness add a section to MAINTAINERS to catch changes should
we decide to merge this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d6459537..6f98db096b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4565,6 +4565,12 @@ M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
+AI Agent Skills
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: .agents/skills/
+F: AGENTS.md
+
 Build System
 ------------
 Meson
-- 
2.47.3


