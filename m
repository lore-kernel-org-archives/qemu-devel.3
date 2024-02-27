Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E205EC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaU-0000mQ-3X; Tue, 27 Feb 2024 08:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaD-0000gL-W5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:22 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaC-0002q2-E9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4129e8bc6c8so23956285e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040799; x=1709645599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9IFvga9TEIpbS3l7g132YG09cqdoQ9m/RM6KmiHkvO0=;
 b=OFVaL6APoHlGUG5oqHrhrlKGAWH4UuKAVs7Y58nRs5jEV4rIFYCjpvb1n6Ry1zF6F8
 l306yvAAP6aQI8EGBkiZsAiUlRMFKJg+o7jwMyr2eZ3QbL+NiZSJ0pEfHrlH3E5lP3pA
 4n/h9ytTGUPdwp43ntB4qYi9lywEiExEjSwE9nAUKUSFx036ST1xo6TdJQ6bR7MG4PNx
 fgp0MZdCyOvxJnqLSUDm3FY0HvmZWuYOklOPSo2mc/Mn2cvsCNrpAoXYhWLe5lLGJySm
 +57UCrwciySfynlqJnbA5gI+dj/98Bim4cFpqJ/WzHn9JN2mhdEapL4aFaLg6Yp11TDn
 FcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040799; x=1709645599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IFvga9TEIpbS3l7g132YG09cqdoQ9m/RM6KmiHkvO0=;
 b=ryH02KfHF1uPx0kyV+jrPYnXgBMmduZnCgwrW/kyS2EKhln4ku6FywfSy+AQW9nXwP
 ygNT6MLSpUT08DOqDkvzmjNUs8gQsmLtj58UoSh7R5jycPizqYMHi1T4iiZOmae/+maf
 2FPIiFipVltwAn5JKpzJ//1hVU7gs03u6FwC6T8qZynRDQdkSX0QCKTS3sNSywCVq8od
 IaqRn1BtakyE65vKrmTL58M0ijEIaNdTPCi7ieLi/6S1rGjdWKb2Fw5JJBNPIzyU7HIX
 yX4KzWSziYTN5j0qFUOGiQvdpNtDNOVhV27O8NKKSh3MonNfBhtbLloNfD6tAjdLTUSb
 GW8A==
X-Gm-Message-State: AOJu0Yw0NUOVVl4IhYDwK/hRNaqIeiNrK5KHphptfo99EQqOPI/ijyqA
 Cp4XwRRDBf3kG+/Jbygmc7MmFn3YlxyAsv1LAr/y6AnOE4wYFkrYvdHXo9igYjQTgFILrodObG/
 D
X-Google-Smtp-Source: AGHT+IHdYFYuaNfL8D2Gz3WisRs/wgXDEAlM7KwJXZj+scmrh7Ks/ZjaXohiaVyJm0p5VkLi7AQQfw==
X-Received: by 2002:a5d:6d85:0:b0:33d:e174:2232 with SMTP id
 l5-20020a5d6d85000000b0033de1742232mr4022367wrs.6.1709040799121; 
 Tue, 27 Feb 2024 05:33:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/45] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
Date: Tue, 27 Feb 2024 13:32:35 +0000
Message-Id: <20240227133314.1721857-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

The OSPI DMA reads flash data through the OSPI linear address space (the
iomem_dac region), because of this the reentrancy guard introduced in
commit a2e1753b ("memory: prevent dma-reentracy issues") is disabled for
the memory region.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Message-id: 20240219105637.65052-1-sai.pavan.boddu@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xlnx-versal-ospi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index c7b95b1f377..c479138ec1c 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1772,6 +1772,12 @@ static void xlnx_versal_ospi_init(Object *obj)
     memory_region_init_io(&s->iomem_dac, obj, &ospi_dac_ops, s,
                           TYPE_XILINX_VERSAL_OSPI "-dac", 0x20000000);
     sysbus_init_mmio(sbd, &s->iomem_dac);
+    /*
+     * The OSPI DMA reads flash data through the OSPI linear address space (the
+     * iomem_dac region), because of this the reentrancy guard needs to be
+     * disabled.
+     */
+    s->iomem_dac.disable_reentrancy_guard = true;
 
     sysbus_init_irq(sbd, &s->irq);
 
-- 
2.34.1


