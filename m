Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CDBCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7u-0003VV-Oo; Wed, 29 Apr 2026 16:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QS-0008CD-Fa
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QQ-0007hQ-U6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso128829745e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471081; x=1778075881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CbYkDBPpXawZZfXwyECFDKJfotfIOnbxLhrwBo3n24=;
 b=r6MZzKzs/RFZzPVTtiwcovxiyBxme8QU1tjIPt0vKTzNIYPuV/R2KpSaJ7M+bIQrca
 NUPA2JYPKEXu1MQ0oeD9tV6M9KTnTbNaDk7twc0ZkClFwfrtLf63UM8FM4q1ak0Usxzl
 57074sOyed5a0vMWlztOmAqpgGUfIdBUAc0lMB7/MSGk+/7oadriztTwfC+e2F0HTeJW
 nVMx0irq+ThowISym/THWJUSVvMpsoDv3oWJ3RGZnVQvsviYgn6Ju0sSknuA2GvS/OUR
 WEMIB/EGPxevl+7IzRVFP4ta3FK3MQbtQ4DgwIhFvgbeEgPBMoEKRL5w24BpEjFrpoVc
 pgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471081; x=1778075881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4CbYkDBPpXawZZfXwyECFDKJfotfIOnbxLhrwBo3n24=;
 b=LiOwFcdbMIbtr8xcNfX/aZPAYCQlQm8ZSJmTvPfEjyOHm3EB0A6cycxGwqbAR7prYI
 Gvwgl+G+aeC8xkwFGkmtqgXc1kSHfLBE01KL8S2Bf1vR/5vOlEvC0flA3G6EF/EUw2p+
 NH0iBllavkK/+uFC/oFEZUmQfsoXF5rX0hMDrmmZkFWFrBhwFt2R+6FmUeOrOzexTqmU
 aQ4BIRkB47rjFV8PJNd8ehjmg7I6SF+suZiSxMXkizfkgf5DMf5HNgmAoDvo7vqecHLM
 DAKWCQNHG1foH1y58RAC9j0DJdI4fR9sipwffNaMdHVHaIn8RiWeAkPUyIsxYjjO1EHV
 VYCA==
X-Gm-Message-State: AOJu0Yx5IIFynnspEmqZptoLps6a1zOjbZgR7SD5yxC7i7iObx/5dLLD
 H6UEzE60B63OIUa2gFmF7UWjRhc2zFznRtLDWNO+7u8fW2ZoXTmbVN/h
X-Gm-Gg: AeBDiesAG14OvQHrwrH4fxbWLRabju0+zKMbQo/zCAcAj0DafxN5fHvND3uAsVrKptT
 9OB7E6fRThOeuHxpMbMa0KavAXLk2PKBjOgyxQ8boBwfQU3QjxrcaqOdxbN9lzZiyxosyg0OYP0
 FwY7n0mTxWjZKwzGx6YHJa8b5Ce0V4GMJJxiGxi3FGC6QgkBNnit/kK7rupZ8RCOuf315zJHW6P
 VzIzGz+3doxFIXQk722hvjQPMCaRbeWDboHnLDzDayZ2CSo5fQkFR4OjkvS2pesCuKCFIpX9/NH
 0ZeS3BM3JQDZ+9g7qhV3KEKoVqd/YG/94fHjwY0q3CH/kP+TnVLzRHdThgNl4d0y1CFu1VmBhZU
 GyJ9fayxryP4VrN0POQ5WXroo011JV8TmjbP481//ZCpOYX0zeoZR3LSvJdX8wBzAEHqm4MrATK
 /OSZuATO4evMwOrFuJirmuLFrjMxWE0+EjWngot/pA1zL+sY1hYNmangWnlzagcebQpJz6uaiZ
X-Received: by 2002:a05:600c:528d:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-48a7b546b7dmr72438825e9.24.1777471080538; 
 Wed, 29 Apr 2026 06:58:00 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:57:59 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 04/10] cxl_downstream: enable power controller
 present capability.
Date: Wed, 29 Apr 2026 14:48:38 +0100
Message-ID: <20260429135717.3048713-5-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=joshualant@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:14 -0400
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

PCI_EXP_SLTCAP_PCP (Power Controller Present) must be set in the DSP's
slot capabilities for PCIe managed hot-remove to complete. Without this
notification from the guest of removal cannot be sent back to the
device, so device listeners for unrealizing will not fire.

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/pci-bridge/cxl_downstream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 91c5e6a605..5322c46900 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -228,6 +228,8 @@ static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
-- 
2.47.3


