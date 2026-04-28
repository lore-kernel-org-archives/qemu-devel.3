Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0FFF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHm7s-00041P-P0; Tue, 28 Apr 2026 13:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wHm7r-00041D-0m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:21:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wHm7p-0002oj-Ee
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:21:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso80851205e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777396890; x=1778001690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1cPbAMl8P/PHQADbAv6Bo8nBq564FcOK0Gul+d1/lg=;
 b=PB5HN+CHcYgVIIkiIeLre233fLOG6tp1BUXKzlZoWBiLM+4rrEKxE//16rV8uIR3Dl
 hq9V+xWQ5oSII1JJHGN/qhsgRziq+MGEI0KlFhO7owcQvnCQykZL+ouBWfCEW/qiqop4
 Kbzx5Le/zv4h2aEsSHzXleXR4xlnWKGsnZrlAobOjxXm9rh4/R5DlzYDeNCD2PcLeAkK
 2JIHRBcYGr28P2V4+gENsnRH3DHO7Jsv6Y14I4ONUx8RcaTQSvjI+OlSxp98vYQGXjwk
 QZ8cA/vsHGwn9X6p3vFPoGVNgOs+Zpv+R5cI9fMwGSmOtDdc9idfYdRZNmAlDkwvYPwn
 3Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777396890; x=1778001690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v1cPbAMl8P/PHQADbAv6Bo8nBq564FcOK0Gul+d1/lg=;
 b=V9u5DI30qKd0UPf1PuAZb6yCHM/fx5lU2gsk4yDkoKXjv835zEll1BGsKq0OnwVg5z
 Gmmm2JL2Kopn6vT5mPVNRZ2dVkgGHlpTgS2tiMx0NUVw2RxdVXZIC4OCHMwbSsGvoRbv
 E69HbkHjJY6kpil69Q6ExrGlIx2cidDFLPTDsJOSIDKfSKKKkJpW6tS2RZR4ccqOnEW7
 VCnecUaEh7XwLr1uJ0DyTqhkZ3wjdZN/ORnopXYDbs5YdJKw+5lm1YSxrUvxQpEV7Lov
 WgmYF7I/dj5xj49mMMmxYluudE2SdY0Fk9QUagBPKpQ868nd7+UDCy2qSpGXI9nL+Ahu
 lRDg==
X-Gm-Message-State: AOJu0Yx512bRfSl047ZpyQpmAtop/pC1RP75hiCcoBYlmsoPGia7KC6k
 xWTb60tdsONleQA/EzL3Mm1NbIw/TxSw5Eqswm/Jr0qdfrpZdAXzosIT+wQEwNdg
X-Gm-Gg: AeBDievX+OKNrAXezg4Eu7z/WNumFXeBf39ETawCi/U0hqHkdwH3iQaheFJcXJmbL3B
 IDoBCvIeH4uk0+F3SCaiOruWpKRYSDfEgGyVfibyfxfiiSl2Smi9Bh1ITgGIH/ouTZLF6/B2+0z
 55jxQ6f7BVL+lKfJcr+LC5ZYirsaQiuSbwn7Q/lLWQKR/2wVxtiJ43xygY0DPI5HTNOSiIBa3QK
 Qs+cHiR+vJC2fGFcDHEIWRIzSdldbcBrL3pPsaZYGSmA9SzNh4lRpXH8SwyvKAclX+zGnteB//i
 Xm0lrb0b8ZTmJKcY3e5Y1zidApNNI3Se5/QTa49upuKmbSP0H/DIz2HkvEhoEGtX066u2o3RJVD
 CsmCvg7f36sfQ0O2XP6tdMWQJswlaG8K9LSZvEnSTmexE/AAU6msbY5NEh/dHSyKFRFWGtU8V1y
 e13Xh6EBbxswT+Xyn3cWiOHlvxbbkLzr8j3+cdgwsA0UpVThVLJF6DS4YxcqCLYaOyVx4XOECwL
 j58tSI/FS3Orjg6
X-Received: by 2002:a05:600c:c048:b0:489:1ae1:4eb9 with SMTP id
 5b1f17b1804b1-48a77b233e4mr39882815e9.28.1777396889798; 
 Tue, 28 Apr 2026 10:21:29 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b91285esm865315e9.5.2026.04.28.10.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 10:21:24 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: Add myself as maintainer for or1k-sim
Date: Tue, 28 Apr 2026 18:20:54 +0100
Message-ID: <20260428172055.1525176-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
References: <20260428172055.1525176-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x336.google.com
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


