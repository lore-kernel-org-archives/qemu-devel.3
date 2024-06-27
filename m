Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40233C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrtn-0003Tb-Lu; Thu, 27 Jun 2024 12:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrtj-0003SJ-4n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:22:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrth-00076G-LJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:22:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so5411588f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505376; x=1720110176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FehxPMt54YZs4mKlk2O0dDcvxQwBqAiau0Ry18uuTzM=;
 b=tDFYtmbWqkrkRQSj7AT/JOWFHicHmCzy7N04rbm154RPu6cFhptTVevzdysOCGGshJ
 ircp88kDwVFM3b+X7MG0UhWwp89iv15ZVmtzO6ZcUvmpVDAFxyOe3ImPdL5c7rC+V2st
 8rOd+M+BeQbM53UkeNtv2oj8ttiHNNm2Um+MypHhc5VmkBbyDfM3QhZ9LoDHWKFcHs4d
 +1W5DGLIcwo7kMhObEGvopmkQO3I1gpmwyA3lP43nEcT8ojWJ/q3Oi/qJ3eKiAcrfQgn
 Bl95HJSxWVgmsVN1Y6pcbJKE5CD1TVaNByAge0z5wwCNO5/rwkMArVw9fyBK1DjyXybs
 Ok1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505376; x=1720110176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FehxPMt54YZs4mKlk2O0dDcvxQwBqAiau0Ry18uuTzM=;
 b=eOnNe8qm5bp5a1YEQYLgcbUdksxVOtW9TjsJlw39hcJW+Ux6f/1HW/cnKxcsa5XkOj
 2/BlurJiQEYkw+IyvW6yFY0uCIaZFq4OdZsvh5Hh9SlDTm1YtiAsetG2zAswxfn0elkS
 1+GiXGQYPJEbicQlMDPZZSqklk1k5i54isXknU8Cq6rllUrxQZIXylTT7CG7as9h91d8
 UuIcpnzr4V9mEqIwitzP6AGq04ihm5lSPl/ewjpUCRnX6mtrFWvej1D4dgF6RWz2d5WW
 im46Xnr8+Y2FEHsjY5WAqvGjoOE+HnPXc3vqY4WGMja6UlVq/k+FS4jjWu+wJGHx6CiE
 r/gw==
X-Gm-Message-State: AOJu0YzzekxuNfWmCyOkM9HJEJ/PCRBBu9oSYUYFCfGHixfhep9ezIJv
 1G4cUGgxNxMNsmZVsCbZMqm8tdF+FkB64D+uJPYaLUeu65sB0B1dUa62i2D4ilwarf+KEF63tzW
 qNPg=
X-Google-Smtp-Source: AGHT+IH18bbY1784vwnyJimBUwrB0LfuvZaWWzWLuq5M+w4p+pGq2ctXLO3iDhzmIIWclM3IqtZXDw==
X-Received: by 2002:a5d:4047:0:b0:362:590c:84cf with SMTP id
 ffacd0b85a97d-366e4ed3b67mr8850061f8f.24.1719505375971; 
 Thu, 27 Jun 2024 09:22:55 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fc35sm2384182f8f.25.2024.06.27.09.22.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:22:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 01/17] hw/sd/sdcard: Deprecate support for spec v1.10
Date: Thu, 27 Jun 2024 18:22:16 +0200
Message-ID: <20240627162232.80428-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

We use the v2.00 spec by default since commit 2f0939c234
("sdcard: Add a 'spec_version' property, default to Spec v2.00").
Time to deprecate the v1.10 which doesn't bring much, and
is not tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


