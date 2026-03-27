Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3138510ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Bp-0006Te-9o; Fri, 27 Mar 2026 07:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bk-0006Q6-Ml
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bi-0007qB-Eh
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so18914975e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610233; x=1775215033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPzosEGuwhk6i6RHzymnZDkK3KDFX6eGqZn4vO6SwyY=;
 b=mz0jMaK6KG6dpc+eABj71fbBfcWDfmkura4CKURzdMKBr7TiWcV/ROxzuTlzOLiGQw
 fslSCafzNIFoCJbEQ6o80jI1g557Isn6WL/8Lg/ZMDXFWPtlGS83nk9NSSSRmak6e+5F
 BCwnxLzBh+ZmMVaZdQrKexEKiFeF7VLRbllLegKR64JQ0fNS6r9mDhhotrHxgijyNPvz
 UXl2VhgiOqfD78L1q88e4ubf0i2NJfrt4E/ldsJkgtbiHhN+/CwOW0rwA+XHKX5tfJgR
 9RfgPGe1TmbDfT/bq8rkG4iMZkzuRh4GBzx251aYecaPLqG7mcnWrCON2q4CwCVDdljd
 qiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610233; x=1775215033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sPzosEGuwhk6i6RHzymnZDkK3KDFX6eGqZn4vO6SwyY=;
 b=NS9dX7wVyBYr4QbY7AkyVEml11N+PMbH7+roEHE8hjQHdlKLdzquZG6nlvjGNZgDky
 li/17MDau/Gn+cmFeEsj3ARSDe6mjHUQv6rML3FsNxzqQT++8oqUiXGqhQtqYlkWmyGo
 fd7BSPh+a9/dqSSocfkiL78fvXYnf/zXNZT8Z/4a2wwHf458MpUUT/an/Oftnko8hJjm
 /vblrBPrF5zCVKPF+XfO63jdbR8FdcMqMVDDS6TfZY6Y6OSEhkNSJQ8t2CrdvLIcaxwW
 RXnBmabFZOklIscq2pOAcE/uxadLxTsFO4Chi27pdpi8CTvGIyn/fADwM6iB9pfKc5G6
 H4Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3/7pTd0JpxvUtkN+by4gVFZoRioIlKvxFYRp56DrNxj7Dg/gqYIRpDYTP1cvqqhhZt/CqZCr+YPxE@nongnu.org
X-Gm-Message-State: AOJu0Yx8reol19LDJW44rnF6EWqAHjsV06vgdUFcIH5zYVrOXcvNXiHN
 PcFFQ+4w9GfRKnuia71gKfQ1q9ZH36aCjbvDsuKy5zNXFswLPQQLHjpPQXEFz+7lJBvQkgXmF3B
 PBJMjH8o=
X-Gm-Gg: ATEYQzybrDpE2iG5DF9d6ckGsxUNHs5xlE8CLd7iMCfb4k6noeqVEpwW7mMqw5hkYz2
 DPkdialqG2ugP8qIL7Ks548i4N+jcHto+bK47cxrc3v0s0plp8kAaRhZMvAb4IgYCuTb6Nv2qQz
 0o54OPTzDH3pe50EBD1O0LJsQaUUCLQUi1WYa3yF5JkP42166tDnbNuy07+fEVoQc+6G2rSExRD
 pyGl+2Cmv6Rbfj3zx4ZCJ/1YOEHPxLMRmP2dh1rb1ryS9mg4FCKPmL/efmmTc+dDMBluDLJDPmI
 OfMziWQAx3NOT2FUGLV/k3dtj5sJeQ8RYfJA1n0K30T2HDvucUoGAx5Y+vTdcrncAqKK6bCd0qm
 4C8dP7rdNW0rgSTMI1o7ZCqmmkUx7b2RVpWLjGeqbQZtsBlqzIcOz8y4gCTbySAAwHjB+ycQVTt
 f+kvokH+2Bhfgc2nTzC2oEc90IbrAN9NYM+6VynZMHRH1DkRhgXjQzyMiGj0d6XhEzNd0NZhOSe
 gE3S2K6supe1zh3LxsLt/rHvA5xhok=
X-Received: by 2002:a05:600c:8b4b:b0:485:3fe6:21f5 with SMTP id
 5b1f17b1804b1-48727f0e5f8mr31326645e9.10.1774610232749; 
 Fri, 27 Mar 2026 04:17:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 11/65] hw/intc/arm_gicv5: Add link property for
 MemoryRegion for DMA
Date: Fri, 27 Mar 2026 11:16:06 +0000
Message-ID: <20260327111700.795099-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The GICv5 IRS keeps data structures in system memory.  (Notably, it
stores per-interrupt configuration information like the interrupt
priority and its active and pending state in an in-memory data
structure.) Add a link property so that the board or SoC can wire up
a MemoryRegion that we will do DMA to.  We name this property
"sysmem" to match the GICv3's equivalent property.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5_common.c         | 8 ++++++++
 include/hw/intc/arm_gicv5_common.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b58913b970..29cc96917e 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -122,6 +122,12 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
                    cs->spi_base, cs->spi_irs_range, cs->spi_range);
         return;
     }
+    if (!cs->dma) {
+        error_setg(errp, "sysmem link property not set");
+        return;
+    }
+
+    address_space_init(&cs->dma_as, cs->dma, "gicv5-sysmem");
 
     trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
                                cs->spi_base, cs->spi_irs_range, cs->spi_range);
@@ -137,6 +143,8 @@ static const Property arm_gicv5_common_properties[] = {
     DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
     DEFINE_PROP_UINT32("spi-irs-range", GICv5Common, spi_irs_range,
                        GICV5_SPI_IRS_RANGE_NOT_SET),
+    DEFINE_PROP_LINK("sysmem", GICv5Common, dma, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
 };
 
 static void gicv5_common_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 906870e49f..900af53b0f 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -83,6 +83,10 @@ struct GICv5Common {
     uint32_t num_cpu_iaffids;
     uint32_t *cpu_iaffids;
 
+    /* MemoryRegion and AS to DMA to/from for in-memory data structures */
+    MemoryRegion *dma;
+    AddressSpace dma_as;
+
     uint32_t irsid;
     uint32_t spi_base;
     uint32_t spi_irs_range;
-- 
2.43.0


