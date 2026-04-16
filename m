Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4E2F8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrj-0005uE-Ag; Thu, 16 Apr 2026 05:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqW-0005ET-1T
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqT-0007ku-2o
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so71620715e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331026; x=1776935826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y3LM1lbuxmGdzi6o+DG9T/YX7FfYZ9iqRQW/xxFfDsQ=;
 b=J2ooAz+NkjRxW3gqVmdBI/mByCf47k9bSuWZPQoD2ftWdafXvBpl3flG0UpXqyB0G0
 Aa5No3lBylCpH4ci7EnfjOGcM3BVQzXZQuL2g+0MuWWzZoV/nusIyDtXGG6wQiUz+4HT
 DVlFYreLnGDEcEK8ZXdeQSzl917RhQcaikVLfNKh+5IwI8ekxW+KXJ2lcxMKne3/EFqx
 KGRBvyud61LkKExADtUxFWaY/4nkNvA3IYFXAnSiE/JLwfHeyxSQbxO/5h+UgzSRKgqy
 20+K/t/iXZCM/uVk4YGGYg9/VMsNAqUCMTwGyeK0RuQy0xstmwxuSo8vFopAYmadOt6l
 d8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331026; x=1776935826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y3LM1lbuxmGdzi6o+DG9T/YX7FfYZ9iqRQW/xxFfDsQ=;
 b=gByYx4ialPLmudW9+JyJm5j4pDw2xNKU7qmq15eQkEbnLNlwIDbKIPf+vXEfq33W+A
 Q3H1f1FD2jgF7dionENBN8UxDZr2auMGz7OoYWG1B1CDI64W/2/GjSVDMtXFuFX5OHB/
 GIFwB8HLZ8xYI5r6zVaHcumUbDk0ucceyLdykZz4QWpO8Na61Qiq3aWgeCl75gaBjkCk
 KcllI4q3WYqjZJNEd5qr/Brzu8vSnUAa4XZU3CKQvDfaapoQRaRd6VjhwzEFJ2tZpHqD
 qMFIG7NgMu0cqRV6ryNeEfXGprIKRpxxqBSNkX4PLMqXfM9q0BsLqV8wfFHuKfiKWCzn
 xS0A==
X-Gm-Message-State: AOJu0YxEsi7eaNpL/v5OKuRkHm2+wdfYkv2PeF94pL4BvNChDzwwMGpm
 xh5DobdZKEh1+6GRg1Ax2hSqxQ+Expn4Tg//m/tbv5+qX1yfcCk6RZjQlIoGVJdr/sYJp5EYR96
 RIsA/COI=
X-Gm-Gg: AeBDieteagBuJCQD3Bl7l/8monW4++US/Xu6p+B80YRKZ6rhOuvbD20gLJE3GKiL83J
 Ox6Yamxi1a+9QyKCoSHydGOzNbNe/lBfTmKPRLXADKKpDHmB0tU4RSUB0ud66+LSphRTG45FE+5
 FJcCyQ8qJg4pIEeLmI2c8P8WMUSzHsWbZoQZeR0v3WvtxJEvVh0iqQU6eO0YWKoNm96WMcQQIIA
 1DFBV2dYViX3QXnQ3jOTnhuTysi4D2maQ73JAipCmnM+2kJOEVgsuwPqDZJ2pAx+EanOCohAwS4
 6qUrHTLfZgdtlkJeoqiyGgpC76CFvz53mG39WZZRzPZ3V5L+NhY3F5hA4kIeXDiIVaqyISCC9C0
 UZ9nkgmsx38MW1Fnqvwf19h65b4T1vrRGsZxos3YXvGS4REjqjtXC9iFktmabuEDbb682kLqnjn
 yJXGd7XQTNUPsyFXQuHL5XW5pib+XeEvdbiKHvOPTcZI1u6eTuEnvVgV43mTg/LPrg4RNgddxwU
 HAr5wWE1jFsZsOmLrY4DlTfXPsgJdlCpklk8nfsVw==
X-Received: by 2002:a05:600c:34cc:b0:485:557d:9fe with SMTP id
 5b1f17b1804b1-488d67e65e7mr332021475e9.12.1776331026382; 
 Thu, 16 Apr 2026 02:17:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
Date: Thu, 16 Apr 2026 10:16:36 +0100
Message-ID: <20260416091654.316158-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes "PCIE DOE" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b2adbc247..bc7c9b61da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2160,8 +2160,7 @@ F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
 PCIE DOE
-M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
-S: Supported
+S: Orphan
 F: include/hw/pci/pcie_doe.h
 F: hw/pci/pcie_doe.c
 
-- 
2.43.0


