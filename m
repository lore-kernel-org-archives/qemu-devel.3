Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EF0F94CDC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSZp-0005Gi-5u; Wed, 22 Apr 2026 04:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZm-0005Fy-Ex
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZk-0001CV-Py
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso3494818f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845087; x=1777449887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rpHgR2loldVqC/Prn2vT8EQ/QUtqIS/QQ8Q0KIrU2V0=;
 b=rblosuQxQ9KhES/6YfdNPFfriyS5LhGmlPXsM29uTDfB5u3VicNPtAfmUMbjfgoS2o
 WELfzbfALOjloBfpIx1ueCXJJuPvSamMezqWGlzNUHjKo9Xu0p1V0/6pTSQVPnel/AEE
 Cjz86JfRKsd1GhbpXEGYeEwpFLOKesKsx4YJ5ehz97myaKfxTXM7qeY1hWng6G3jt6bH
 +Qk7ORGdb9TI9/VAXhUkw8a2a/VngfDyaFwnHjM/B0/Mi+G2/nhv/s4zkp4l+/eRYfl2
 3mx+dabhBQ5aZdQdArL3vfXv4s2CryjlR11of1J7Qir3vWIkfNlkfXKdUnIuQABfMwFV
 RcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845087; x=1777449887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rpHgR2loldVqC/Prn2vT8EQ/QUtqIS/QQ8Q0KIrU2V0=;
 b=eo7/S8NzWe/SUKfSbErWSzo+Jk9dmsQC0bULCCLD29pkYORjtaKzP+cB+tndMSX3Ko
 P68OuG06W1pMmOKD8zRyX8jI1QhHjxbddyxwfCQcyBtPndlNGZ+cdncFZMjJp1IhIrO7
 kKgUpaX+5w4xHRLOOHjn/s/c2wz+wSPJ8L6rWhZmASsf9521pJkZozVSm33hgJqo2dmO
 /3vQel50lfmLJBqk11VhJDQLGAiCOlxdSGjyJtAAzThO3G6A7vWGl+coiChk8mSofR7F
 hN9Dy01jwZACZnsdj2E1ZBccz5Ndn0k5oJE8fhUo1gkblawzvVUGtLk08Tezogb8RY7l
 dg4A==
X-Gm-Message-State: AOJu0Yxh8ez21qz1RG2lvjTZjClnIMnWujdEJz2a2RXMKT6+sbu6llWO
 +YdV8BCjZe2cTi8Ru9NSE28HAr+opocJDsSrSCFJQ9h0f8yd+AReCg0XOa7An6vER97UwniU4y2
 5AofkTVo=
X-Gm-Gg: AeBDies1ejRK+oEy3nOm3qzTxqKHnL4K9ihtJZYpufbWHTX6wZy0w+kdyUrrVE90pbT
 AAsKogj2fxowTXVNP3ftaR//U4NxbUES3ddmHByZDSjjaX+8qqYNB+hGgpKz+1SEQzt5yoe4J+o
 4yFoQ9hqdR+PGD5hb2F9aYnGLkO2EW+RWqxj9gcZcRtda8+kh8HUXdV36k8wfkMn/jBaQqvmARR
 xQ73DyHPlblQBArQktiQ6BOPoR78sq8fEKY/1E1eDRKq2eLhQXWGUxeUTloL9JElLc4CQeB6ISc
 QC3wHMZS6mOhTCpxTTX1P14HnEaxUWioOJo9+Olby46UY/GXGA4YMtWmZW1iO4I1kLu0p+u/WL3
 ZAn/X7n62IKvNeHCY9gzIP8TnjlsOT7FcSDMtZZi/KH62HuCJLp7rQWjIgaSa2UhnOlL+7roouV
 2CdHEpMvzgJDawH9r0CrqttXN6qUH8tV5+Yq//Tm5hBIdP/hU+lNhZ1H6gb+eykQ4ozpgyzkTbD
 LvEJwwMeADRkdVw4Q90Nw==
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id
 5b1f17b1804b1-488fb73d764mr294072035e9.1.1776845086641; 
 Wed, 22 Apr 2026 01:04:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d525sm41651278f8f.31.2026.04.22.01.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 05/10] MAINTAINERS: Merge PCIe DOE section within SPDM
Date: Wed, 22 Apr 2026 10:04:00 +0200
Message-ID: <20260422080406.62638-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

SPDM depends on PCIe DOE, so it makes sense to cover
these files there. Cover the spdm.rst document. Add
Tao Tang who volunteered to be designated reviewer:
https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@phytium.com.cn/

Cc: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4dac985b5c..17599636ab8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2160,11 +2160,6 @@ F: docs/pci*
 F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
-PCIE DOE
-S: Orphan
-F: include/hw/pci/pcie_doe.h
-F: hw/pci/pcie_doe.c
-
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
 L: qemu-arm@nongnu.org
@@ -3701,11 +3696,15 @@ F: tests/qtest/*tpm*
 F: docs/specs/tpm.rst
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
-SPDM
+SPDM, PCIe DOE
 M: Alistair Francis <alistair.francis@wdc.com>
+R: Tao Tang <tangtao1634@phytium.com.cn>
 S: Maintained
 F: backends/spdm-socket.c
 F: include/system/spdm-socket.h
+F: include/hw/pci/pcie_doe.h
+F: hw/pci/pcie_doe.c
+F: docs/specs/spdm.rst
 
 Checkpatch
 S: Odd Fixes
-- 
2.53.0


