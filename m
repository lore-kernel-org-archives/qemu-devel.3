Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DC8FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJae-0001vt-Ry; Tue, 05 May 2026 13:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wKJab-0001vk-Oi
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:29:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wKJaa-0002Tu-CM
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:29:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so62337475e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778002181; x=1778606981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/t6JUfYa2nZid8K5f02rFeaT8IlpqWngp8IDRPDyi1E=;
 b=TZvSSMTScnGuikMcvlFnZuZRaGOntBjPB8aLzj3jPDbNZ4VrIv8/POmk/hs8tRDUJQ
 NVK/Vh+n7QtHWMbYYH183cSYe9t/DP+YNcRShv23tLWnP+Dbfn0XrOZ+R+jXVVLbonTL
 0ZeP8iJyf/88hHBRTm9hYJsxsYilvCOytD3KXUXm8pxQDOt0seCczdvSst2PWuxu7Rf2
 nrLgK5Ft7sH8e8CCbO6/Zmi1xngvDit/EDv167K9UewVdxKory7ktMXbNg7fNWEvL7MN
 h+ALjDvO6/iJqB67i5ZWHAlnAwEM3Mx/HPu6UA4TSsE4NQLGLfrgcv4UJPJt+qtB04vZ
 lvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778002181; x=1778606981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/t6JUfYa2nZid8K5f02rFeaT8IlpqWngp8IDRPDyi1E=;
 b=ZEJ7PYTxzpdj/XoDrnH9GGLbUnGFq1Cxuk5V/NnapsXQEh49VMKfwecv3eyye0St7J
 Wj+2db9/NXZ5/i6F5dcl/7iXkf0lDOEJncETqgfrFHo4pSirNaulgFXfbhIi2NjU0lHM
 vdq3ALLLqtVoql9F56E4CnNYR9zB72gFdVxA7KoJZ0i+5PrSBXZGo2W1QjwVVNhHQy49
 W69/ra4Jr+9nM418/zp3h9r3MF9nlQ53DLoplxyN3Jnd1g0P7xXL6ywqQymBpuhDyznM
 DaJ08OkKd6F1yik7g2/m2GPbIlX2A8Rx3lB3eYDyi4neRRaP1C8Hgsu2r7yNyYJ1thAf
 lN/g==
X-Gm-Message-State: AOJu0YzzgQRqmN0t1PZ2jpcBSy9b49LhqyiRjr731zY/4fJVa6cth+bh
 PpzxafZV2dS9Udxf4Tn/M81D+eunUAAJ45V8mdP+AOC+Jq5Bmj3YYefirhIufQ==
X-Gm-Gg: AeBDieudv7IfH87U1DMoyYqxLxdu9ot2bZioECS7MnsbydbnVxeXc62BwXXmc9JBnPZ
 YCnsL2D9V31OyoZP2Mrp14a80ApPWj2MNxAirLmAUWKBDbRyF9B98Cmv6vwYdQbwnFsIzOR9/N4
 ZfpSIMu/onEZAEGYjozm+XEdPA2c6CBwemQ0xRhdy34Lh+uskWeytqVm8X4z8M2nUff9+BtpjNt
 stgPbULikvjlEbWdfeUvDVm0lSZncyHqWvd+hjHERXOKurRxzhB6CecI1iDmvW3+j3EARxyuqQg
 yClSc9994ZmX8CgQNc/4BDZRjIQx8JnLfJ5NaDHNR3O54jHnWtT/m0ZYqtF+XHLNu73yVj8jsyw
 ol6EFOygEWvFRHD+zzuiJ6dpSJHKLwZOYIKedfqPomjpHjQNrr69PJPe3QzRsGKeIhlrLvR1jeo
 T0+HsHRasnwyIE9p4wGLT2vDjakj0Gih2gEml5U96xHAJy5giOCXYPJkACtyk3w7vw0l2xzyhfR
 dwyQc+qO805gbMr
X-Received: by 2002:a05:600c:c096:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48e51e08fedmr2450175e9.3.1778002181132; 
 Tue, 05 May 2026 10:29:41 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6ffb7sm371662115e9.5.2026.05.05.10.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:29:39 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>, stefanha@redhat.com,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] MAINTAINERS: Add myself as maintainer for or1k-sim
Date: Tue,  5 May 2026 18:29:25 +0100
Message-ID: <20260505172926.2235826-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505172926.2235826-1-shorne@gmail.com>
References: <20260505172926.2235826-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This was recently orphaned and since I have been handling the OpenRISC
odd fixes for a while I'd like to list myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49f9bce818..44207949d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1509,7 +1509,8 @@ F: include/hw/pci-host/xilinx-pcie.h
 OpenRISC Machines
 -----------------
 or1k-sim
-S: Orphan
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
 F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
-- 
2.53.0


