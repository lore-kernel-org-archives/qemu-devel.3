Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87617CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 04:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO6HK-00048p-1u; Sat, 16 May 2026 00:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clintdotphillips@gmail.com>)
 id 1wO3Jy-0006L7-Us
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:56:02 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clintdotphillips@gmail.com>)
 id 1wO3Jx-0005Hn-Ei
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:56:02 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7c0de780bf1so464637b3.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778892959; x=1779497759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=da3szSDUwOYqQhr77HC4pHnahJxoJGL01LlgERUugSo=;
 b=ac7AwGeYK/29aE8FSXdj333mtZaSyOFaznEbrDjffCvHGH29/k9Kh5jF114PVFYWbK
 Yx5n15i0jOLQ4K/XeqaLqTE5gp2RGxFyUHcU7BeIiRJfj3slV+4ee6HL12A3carijgRd
 b9W6ggeateIVB3BpVsX1quXXFZfaj8gU7ZJGfAqeBN7sHp4h7eRvDf0NEy2/+RiKxWcI
 3b/0Ej/Y3S8j1HLkRN6Pe6QjyRhlzmiT1FEdTdyZOJ68iQIi3+S0jrQzHDNbvNlIDJ+M
 aF3+Lo0tlGGFQ3rN07mAAwQ9HXvWOJcXCdV/Ie43nZ41bDU/BAkML7Ywsb08/ZYujKTk
 SAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778892959; x=1779497759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=da3szSDUwOYqQhr77HC4pHnahJxoJGL01LlgERUugSo=;
 b=q3B9kbsVZjMbYN1SW62/psRs6ihbbQt4gRYYKdufGZVDI6Qk1Vx8hOy+YDOcRxujIO
 HF2Tyd4hsVNvdU3Bx2jKAvFpWrDixQfAl67vtV3eYoiOF1eHiwzMTv8UoXqbbQ7wtMgf
 KudI2YgAr5ZWJYdGo6t3/qkTsQspI475ql49vzWnKvxPkAvcqzdUe2qmHHKqCWBlsIH+
 0edHZBoQGxbspluHnlHBW+8O2n6guTjIFvHfDgyUJ8b9zOypYLgpcYVyO9AoZPN0mvPh
 l5YcYJi/9vMsp6lRdcQO9ErSZH7TH59qut3yEN4Sjhixq7QXbKLPYCEInA6z0y7cw5ps
 rRPQ==
X-Gm-Message-State: AOJu0YxwmNAvRNAkVnnHXfn2GjtU3Cbrn2y1mP6cTZNZo5g/cjslPlTC
 jrQzmuQD2duEXiC2c0nnvj7nvpmZWNIN5fMGFdANRKEOSxLCfcXvT+4Vvvdzu608
X-Gm-Gg: Acq92OEukfR3xWj/FL2zIrRQlpjrhUHYZJtxoVObikkUozlENKrnXJJVi5skVG2Fs26
 a910PpTCtreu4JzirJd9x6+t+tWGjBBJ3IbQAgXB2EFBvQqsrErTOebi12XJuY6Vyov5GXeIE/S
 e+wORLzWKD3YDep/TmIqmOz+CaFwVpTnjFwYDJvDrC3/qFQ7juKvvv50VwLLiNUf9S5r3JIgY+W
 auBKHLnROj151SCyuQFtsyR1B96cZrK7Rcp9U/BK4DFNmMT7fngMLgzfUWZOQjMaHIFn5KVyjUj
 qCZ2GFO8qEFh3nnsrygKyAhGzdKrX8SKuiPtAfXqTVISPP8F+DPm8pxz5D+WqP+NzAS0jsphFja
 K8K8ORNjOIGOkhMA2l0WRltySGBDMg69z97G0tQmrr+PWOzal0CGTG5TOsapb83K3QB5HkCxq4O
 3Rdw5RfiAFiFwHKdCf9ud+BrHDCxNBeja/cPTGR7ORp92CkMJJU+vxnYKCZXTzGg==
X-Received: by 2002:a05:690c:e3e8:b0:7bd:d4f4:261f with SMTP id
 00721157ae682-7c95b33ccdcmr69649317b3.27.1778892959538; 
 Fri, 15 May 2026 17:55:59 -0700 (PDT)
Received: from localhost.localdomain ([24.196.231.228])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7c7f55bb29esm38163097b3.37.2026.05.15.17.55.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 17:55:59 -0700 (PDT)
From: Clinton Phillips <clintdotphillips@gmail.com>
To: qemu-devel@nongnu.org
Cc: Clinton Phillips <clintdotphillips@gmail.com>
Subject: [PATCH] docs: fix doubled-word typos in user documentation
Date: Fri, 15 May 2026 20:55:58 -0400
Message-ID: <20260516005558.92136-1-clintdotphillips@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=clintdotphillips@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 16 May 2026 00:05:25 -0400
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

- docs/devel/style.rst: "assume that that type" -> "assume that type"
- docs/system/arm/aspeed.rst: "how to to boot" -> "how to boot"
- docs/system/devices/can.rst: "supported by by drivers" -> "supported by drivers"

Signed-off-by: Clinton Phillips <clintdotphillips@gmail.com>
---
 docs/devel/style.rst        | 2 +-
 docs/system/arm/aspeed.rst  | 2 +-
 docs/system/devices/can.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index b8edcf9..6b9544f 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -341,7 +341,7 @@ but only for RAM, it may not cover whole guest address space.
 If it's file-size related, use off_t.
 If it's file-offset related (i.e., signed), use off_t.
 If it's just counting small numbers use "unsigned int";
-(on all but oddball embedded systems, you can assume that that
+(on all but oddball embedded systems, you can assume that
 type is at least four bytes wide).
 
 In the event that you require a specific width, use a standard type
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index df2f539..3f1222d 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -195,7 +195,7 @@ boot mode of machine: SPI or eMMC. This can be useful to boot the
 boot the ``rainier-bmc`` machine from a flash device (default being
 eMMC).
 
-As an example, here is how to to boot the ``rainier-bmc`` machine from
+As an example, here is how to boot the ``rainier-bmc`` machine from
 the flash device with ``boot-emmc=false`` and let the machine use an
 eMMC image :
 
diff --git a/docs/system/devices/can.rst b/docs/system/devices/can.rst
index 0912183..95ee3e8 100644
--- a/docs/system/devices/can.rst
+++ b/docs/system/devices/can.rst
@@ -10,7 +10,7 @@ The concept of buses is generic and different CAN controllers
 can be implemented.
 
 The initial submission implemented SJA1000 controller which
-is common and well supported by by drivers for the most operating
+is common and well supported by drivers for the most operating
 systems.
 
 The PCI addon card hardware has been selected as the first CAN
-- 
2.49.0


