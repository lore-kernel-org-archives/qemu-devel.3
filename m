Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2902BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjHa-0006Cp-4r; Thu, 27 Jun 2024 03:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHY-0006CT-NG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:11:00 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHX-0004qD-1Q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:11:00 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ebec2f11b7so84186811fa.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719472256; x=1720077056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMACaTJ7ceKy98vN0dAl3R2Aaxm14mffc3kVkXfuwRk=;
 b=Lij/UNTtSlk7ZbXqBOQZD8MKtBDg6kTA06hnxVFZ4bHlxtaJvp4O7XaAxrn5sLzncG
 BxaiEEsaCPc+J+ur50+Wr9fUIE2vrSqr4z5wkJB4oXW0mmR5zD1f1NOI9czN2tWYuIOL
 03YWVFUSZmigBMJBGBoAYKyeTA6fEfFdhrGpzagsCadF8dLQ7GoX7DCmRv3DSVkYLyAa
 A28ly5yONWh8hKhvk1v0wR+QdR+JXWRf+L5HVmn0EIt3yGbLQ/vpm/Z5CCvaZEio9WK3
 uBD7ttJv3KMMvkt+duZiRNWsMmN9Pn4zyT9rvHouyhXLHBnlT3fVGuyf5ZyVvnvDbdoP
 CuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719472256; x=1720077056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMACaTJ7ceKy98vN0dAl3R2Aaxm14mffc3kVkXfuwRk=;
 b=RBvr835bwK/AXqmt0AQQx/zEM5mWINrlH4k4lmv+/jPATvPacP9yYsIwYqEtb1rzvW
 uE1Z683tEiPD+NmdMNNUCd4kPyMq8YQuSk774R1uP/IknrqLi2Z3YCvwou3xYgnuxFqM
 jeWBOcGo1/3Rv/QWj1EgWcqYOPLb5wdjq/3tGxlwFut1xBJUI1Etu2sb6TaI8X89pQua
 u0CH0lvPdIhqf7SR5XVkt9+XZ9qTCWfYSVOMZHh05NISDTRLlJlCwwmsd5Datho+/FuV
 5S5FRuq0JBqB/0Rx5E6gzB56+7RLYSI4OCJDC2xdlIFrcEOrvEfGrow2q5GnZpHDaqCu
 j95A==
X-Gm-Message-State: AOJu0YwN2bJziW6Q2Q98ttdeyQMkyY22s2P64AuNAN34ZgLdZL0pasvN
 OrqwJsW1jUsir3efcwFQyr/grRabedxl9AhnMjRew0FOYFlfopSwHUL8LLSHwZCCaunWmR/NBvE
 btWI=
X-Google-Smtp-Source: AGHT+IFQaxY7Rzvlk6/HeiEQJyNeUwjWgeSvzwoFLf/+d+DpsR4UxloF/xxwq8NSvyniNK8Wis3S6A==
X-Received: by 2002:a2e:780a:0:b0:2ec:5a6e:777d with SMTP id
 38308e7fff4ca-2ec5b39cdbamr66685641fa.51.1719472256315; 
 Thu, 27 Jun 2024 00:10:56 -0700 (PDT)
Received: from localhost.localdomain (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c82519bdsm52155165e9.13.2024.06.27.00.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 00:10:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/3] hw/sd/sdcard: Deprecate support for spec v1.10
Date: Thu, 27 Jun 2024 09:10:37 +0200
Message-ID: <20240627071040.36190-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627071040.36190-1-philmd@linaro.org>
References: <20240627071040.36190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

We use the v2.00 spec by default since commit 2f0939c234
("sdcard: Add a 'spec_version' property, default to Spec v2.00").
Time to deprecate the v1.10 which doesn't bring much, and
is not tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ff3da68208..02cdef14aa 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -362,6 +362,12 @@ recommending to switch to their stable counterparts:
 - "Zve64f" should be replaced with "zve64f"
 - "Zve64d" should be replaced with "zve64d"
 
+``-device sd-card,spec_version=1`` (since 9.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+SD physical layer specification v2.00 supersedes the v1.10 one.
+v2.00 is the default since QEMU 3.0.0.
+
 Block device options
 ''''''''''''''''''''
 
-- 
2.41.0


