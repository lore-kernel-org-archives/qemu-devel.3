Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5F6C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyS-0005UW-Mn; Tue, 28 Jul 2026 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyJ-0005TA-EB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyH-00037b-D6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47640541585so2451012f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241904; x=1785846704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HaIHRX8D6+O/vM0awli5v5WdN5nd4X+pGymcCAc0deI=;
 b=sE/4RCQV6V0gzc+OUiJFGsxmhr7HTfHCEFQ7OTeirvOdpO52NzweUe962QQKDNMA8s
 qriHKuszWxUQu0gZOH0y6juiwdJ64+qGY6h8YyZKS06P4JxcK5JjGnK1PqNhu8EyzFbL
 h+vNQbhzxNFAz27bDSSS6RbA/5c5BsxCDUOtCB9zyq24ueVzG9UP96evtDW7WEb9UgK+
 4NKF3PicUYyXrbCG0Og88OvpPMDDJsCZjQRlp0UCKhUWPj9t7SCsM7KTLfJkAyfJ/Fqu
 lxUaTGB3lcybCy1SokxtNa0/0scz47DdGwWuynJW50mogbhTGwvGMHl+8FEifdQVs5in
 YUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241904; x=1785846704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HaIHRX8D6+O/vM0awli5v5WdN5nd4X+pGymcCAc0deI=;
 b=mLSpf/hRCZFS3cVLlmgfkiy9bBbRdDW0hYJb6v9c9MWk9FKcDEGH+Yvkc1iBx6AxR+
 zrO4Y4i8mZ1IXUOsa3qDbFg7XIVvCaQawED2EKjXB0QKGEGbknp++HP0E8biOX8BoGoL
 adzirYP8ucGH8JY2T7dLmqoERnl1MGotwM91llJk/vKt5ZjGt0LNoaGjft66+Q4QHj65
 zh/bWiK+qtWjhGPmYZP6N1As8BavkC1Orjqn/+7XU8itrfd+qiIBjeJNQafRnQIObWuU
 wlrt6K341B94Uplp5BCEC4ZJdAQ8mzoPeC1kLRUXbIo3mmMeSD4EQd708donF/WkD4uH
 XNmg==
X-Gm-Message-State: AOJu0YxL3GMLlSoPlBsGkXQjsozMgi+7EL7SZCbphn5oWBNu7aX+Frmc
 QWo3w9NzCg7g2vi5Wx+JgL88ZhJKGhrJ/IQ1QlxubvUHz5Z9wmhF/PCGIVpWi5q0V3Pqk58AHYe
 zde7K
X-Gm-Gg: AR+sD11ecD4Eoo3cJ4p+XG3oemQMuCnAZTUmxVV2fDBLfMYsolbfjTvYLvaZlKdYfnb
 gx/0QZvEXQYyZPkeSQECXNCq4eKvNl1rlVuaBhDg1nsbYIzqmh/hRwSyj/3HHh1e3Y+NTrFtw/j
 +rU5fNeTStg9IYwFZK9NSv9tbemFI1KSwKG4XbHvQafT9FI5je4GOPXlCBcX8dl7pUyrpQw/WQ5
 2zyTy7T94Ct/wanpkx6wqo0cbfJHwUO1W6fSGHQDBQKKYRchF8Jk6F+2VJBRcDNLZirfNAgyV2+
 Lf5LPvR+ZcVa9KedKgCSI0tpIOI7/hvVkg5/YENZtTWiz1JD4l01arPS+af8nSfF7K/DPzgQwgq
 kdWxvLvRFZC28Vzo3/QQZx8IvOtdm3iGVoXTK3hFw4cA+CiwNtCVsaFwxDGaGdds4HuDT7gGtbu
 nDTQcfRasUV73TLRzMznYJ8j0vUoqtjyeHanB1oKgviDsJBFFTtkh7mzz626kBEEvKAYyZ4y0r6
 dP4Om57EaA=
X-Received: by 2002:a5d:5d81:0:b0:47f:854b:5c68 with SMTP id
 ffacd0b85a97d-47fb1f28197mr2540682f8f.55.1785241903864; 
 Tue, 28 Jul 2026 05:31:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] docs/system/arm: Update Nuvoton OpenBMC image guidance
Date: Tue, 28 Jul 2026 13:31:21 +0100
Message-ID: <20260728123127.1711653-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Bin Meng <bin.meng@processmission.com>

Describe the current OpenBMC target naming and release status for
Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
so point users at older 2.14.0 sources and explain how to find
Jenkins MTD artifacts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260627063208.33642-1-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index e4827fb43a1..51d36b2bc0b 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -94,16 +94,60 @@ Boot options
 ------------
 
 The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
-a kernel using the ``-kernel`` option. OpenBMC images for ``quanta-gsj`` and
-possibly others can be downloaded from the OpenBMC jenkins :
+a kernel using the ``-kernel`` option. OpenBMC machine names do not always
+match QEMU machine names. Check the OpenBMC supported-machine list and Jenkins
+for currently available source and pre-built images.
+
+Known OpenBMC (v2.18.0) target names for QEMU Nuvoton machines per:
+
+   https://github.com/openbmc/openbmc/blob/2.18.0/meta-phosphor/docs/supported-machines.md
+
+.. list-table::
+   :header-rows: 1
+
+   * - QEMU machine
+     - OpenBMC machine
+   * - ``npcm750-evb``
+     - ``evb-npcm750``
+   * - ``npcm845-evb``
+     - ``evb-npcm845``
+   * - ``quanta-gbs-bmc``
+     - ``gbs``
+   * - ``kudo-bmc``
+     - ``kudo``
+   * - ``mori-bmc``
+     - ``mori``
+
+As of June 2026, the latest OpenBMC release, ``2.18.0``, no longer lists a
+``gsj`` machine. To build an image for QEMU's ``quanta-gsj`` machine, use an
+older OpenBMC release that still contains ``meta-quanta/meta-gsj``. The
+``2.14.0`` release contains the ``gsj`` machine:
+
+   https://github.com/openbmc/openbmc/tree/2.14.0/meta-quanta/meta-gsj
+
+Some pre-built OpenBMC images for QEMU Nuvoton machines may be available on
+Jenkins:
 
    https://jenkins.openbmc.org/
 
-The firmware image should be attached as an MTD drive. Example :
+To find a pre-built MTD image on Jenkins, start from the Jenkins home page and
+open the ``latest-master`` job. Select the matrix configuration whose
+``target`` matches the OpenBMC machine name, for example
+``label=docker-builder,target=gbs``, then open its latest successful build's
+artifacts. The MTD image is usually published under
+``openbmc/build/tmp/deploy/images/<machine>/`` as
+``obmc-phosphor-image-<machine>-<timestamp>.static.mtd``. If Jenkins does not
+list a matching target, or the build artifacts do not include an MTD image,
+there is no current pre-built MTD image for that machine.
+
+The firmware image should be attached as an MTD drive. Example:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -machine quanta-gsj -nographic \
-      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
+  $ qemu-system-arm -machine quanta-gbs-bmc -nographic \
+      -drive file=obmc-phosphor-image-gbs-xxxxxx.static.mtd,if=mtd,bus=0,unit=0,format=raw
 
 The default root password for test images is usually ``0penBmc``.
+
+For other machines that don't have pre-built images on Jenkins, build an image
+from source by following the OpenBMC build documentation.
-- 
2.43.0


