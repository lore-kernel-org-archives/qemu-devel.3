Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FBBC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5cr-0008PJ-Jo; Fri, 28 Jun 2024 03:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5cq-0008P9-AA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:28 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5co-0006b0-Lw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:28 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52cd717ec07so323065e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558144; x=1720162944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FehxPMt54YZs4mKlk2O0dDcvxQwBqAiau0Ry18uuTzM=;
 b=YkdUKSZvBxlzCL2FhxtSNN1rZURbqWmgiKM6w2CnlmdIEiWBz5wg/FPY9/eUEZO9aI
 ilVUequ2ML/u42GoPc9uXGYJpOSr0AZWsdUY+Kdx+rIEQyC2C9G1UOnHdTUFzz7sZYZy
 BwIRHZJ75pwd6+hBulZbpowuD6bRNkq8aSJC67c8InhZGSW3oX5LeEOSKeOv+e2RuXm4
 M9M3C1wSEaxVrzyHEXhDkhbzFrik0Ml0MOVQXQM+DVHsr2C7eKmbEa3iLCIpUVPAXqSx
 zbaP4hCNFZPAV5u27XfsU8uqKshSJy46ow7aWW7DtiFzRdzUynY4kbUhy9ilcm7R8W5K
 gTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558144; x=1720162944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FehxPMt54YZs4mKlk2O0dDcvxQwBqAiau0Ry18uuTzM=;
 b=m085V92FtKpdiqv0acxqdp17zUCvCPTUFdsvoM/Be/G2y5MJ88iU/FK+CcoU3+zNX9
 uzunD26FsdAWF963GYlmmEiNlCoDcCn9v0dq8j6pOuAfyMoEUqhbdElj17K0QmWKJF+V
 DcdIgkXLour+G/Ic/U3PNpEMkzfPZHCCL7x5qUB7iit/nc3w82rUxV/RKkNbIna+kVXm
 8XjrP8NiPvJLVJVD3jDyp23iBJOcTicqHKghecrTf4iq+9O5Y8SUoyGfzdB2Kz4wcz81
 lQzLp2Hv6za5uWrBD/u3alSzoz3Nb2Pgm+FxNZF4GiIaQ+6Q3fzTJiLAD5L3lKnJqu2C
 x4FA==
X-Gm-Message-State: AOJu0YwFzbXj1Kfsw5geQ+BOSw1ljrN8HyAc/lihGQurM6/rjpMdH4aX
 iqqCcx2cKGNb+XhnFB8B7PaDf9bTsSCDwduk+X8Tq2QsX21lTSm5ssjl9GfymnAemGviWwp0WNO
 tR5g=
X-Google-Smtp-Source: AGHT+IG3J/+xtSr5xFPRTNnze0Hl9nrQ88+TXxJPB9lrroo7a9QDZBPeqNISxPQAF1omr52k6u6cGQ==
X-Received: by 2002:a05:6512:a8c:b0:52e:7496:596f with SMTP id
 2adb3069b0e04-52e74965ac0mr1875211e87.60.1719558144165; 
 Fri, 28 Jun 2024 00:02:24 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bcbsm21297625e9.35.2024.06.28.00.02.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 01/98] hw/sd/sdcard: Deprecate support for spec v1.10
Date: Fri, 28 Jun 2024 09:00:37 +0200
Message-ID: <20240628070216.92609-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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


