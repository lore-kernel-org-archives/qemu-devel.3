Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF3C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXG-0002MZ-27; Tue, 06 May 2025 10:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVS-000298-Kd
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVQ-0002At-Ua
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so53798355e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542567; x=1747147367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C/arDs4a2PREB5GkJNcLf5nVqZ2+fR+wYKKH36Jhrbk=;
 b=eN7OGZq9kOeugwquBNackTCb7sC51ryGE2xlYIceA3kV2427mOJmLJHkcSVEMLcg9W
 fYixywBuStqMnK8aYY/6YsqlVIIMtCKZqknOe1nFAHlnJU17va/Oc9g17YJpNwCLA5er
 OAe6PakUDYaTA+ykbmJ4sCrsdw7X5CGoZhr7EsohPtefd/4Gcnj22Wc6ClpbZfjPuFUy
 bjSIusrWnw00kFRxP764zCh2iWmrEoarwEVEzU3sMGeVEwF4Gh304Gtn9AUxIcezSOaJ
 D0bz7mRUqbMQFLm5Y984kKW466FqshIUaDRmJe5DHWIJk5dZUUGdTzxS75uCQqJZhckv
 tNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542567; x=1747147367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/arDs4a2PREB5GkJNcLf5nVqZ2+fR+wYKKH36Jhrbk=;
 b=GCg9iIaxZXyX/01Nzo/E1LMgF+QNV64ipbmg/tclkyBKn2Fou3fhcs+AD/B87mW2eH
 jvWJ1ei1f1bOBxirTSKEAeByZD8On6qcyYB6gPaAOVsPY+U2Yf+NRyk/N2Ql0waVjGlY
 EQAU2a6sVOiZPPpONR9LaalW3PhTaBaajp5rPWcDSKHUxpmUHIZtbnEQ5PX2mzQKazFe
 uj2fUNYf3BvhMjLaKtpWpXKCJeJKQHuqzSmS/sCh1Ldt2/YPCRldydiE4TPsfYiUwbgy
 AM/UDyv5XLIbKvUbAFs32DSwncYStj8U0QSO70honNA7ElY0eVgN/nV0zAxTv3NkeP0B
 cOAA==
X-Gm-Message-State: AOJu0YxjvaFsmnWojY7hL+d84KEI2ZXPBJ/NhaDo4J7uuviJYatkoaBV
 y26hgOViAQygo4y3MZabld2/SDSa1Hpd4APG8LnESeY10uGJghC95YTU+Yv+1c+zHKkMBShyw0z
 r
X-Gm-Gg: ASbGnct7ea99o1X1+C70ZLQyAUjpxrLNa9oUIUo9Tg+W2uXuX+sh0LmXDmqmwTCqHXz
 4KBmg3ltDb9axlknHVBydU/zxSEMeZSe5AvMVHm+cxws4YNCHt3SEwpte8Y2fKfo2dBYjWrCk+g
 vOuvKKw8UaxywBQjzMRIXHNIQbnK6Vei9Bc9ZvPCLncVcbpmv1kcYe+8p+SDkZ8gn/ex+srVV1B
 dR060qq8W6yuCNkue5kO6wgfA0B5ouWbTdYlm/IuU4vUEBcIL/OrX4w41SjBhgMFkoEgdWLJ0Em
 lClb0R5U2vYFgUwoMIfWizwuhzXDWOPuZH0j5esJy9IvDGM=
X-Google-Smtp-Source: AGHT+IF3cHzYCabe2u6raDvFFfMaMrZXRpzs9qqGlYT0R9RLInd3SkQ0keguutCoE3rXOfhr9iQpbw==
X-Received: by 2002:a05:600c:5285:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-441c492376emr88401725e9.25.1746542566842; 
 Tue, 06 May 2025 07:42:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] hw/pci-host/designware: Fix viewport configuration
Date: Tue,  6 May 2025 15:42:09 +0100
Message-ID: <20250506144214.1221450-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Commit 6970f91ac781, "hw/pci-host/designware: Use deposit/extract
API" accidentally introduced a copy-and-paste error, causing Linux
6.14 to hang when initializing the PCIe bridge on the imx8mp-evk
machine.  This fix corrects the error.

Fixes: 6970f91ac781 ("hw/pci-host/designware: Use deposit/extract API")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250501183445.2389-3-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index b4bff145794..f6e49ce9b8d 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -348,14 +348,14 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
     case DESIGNWARE_PCIE_ATU_UPPER_BASE:
-        viewport->base = deposit64(root->msi.base,
+        viewport->base = deposit64(viewport->base,
                                    address == DESIGNWARE_PCIE_ATU_LOWER_BASE
                                    ? 0 : 32, 32, val);
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
     case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
-        viewport->target = deposit64(root->msi.base,
+        viewport->target = deposit64(viewport->target,
                                      address == DESIGNWARE_PCIE_ATU_LOWER_TARGET
                                      ? 0 : 32, 32, val);
         break;
-- 
2.43.0


