Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28150C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeNJ-0005RU-F9; Fri, 04 Jul 2025 07:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMB-0002jy-LD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:38 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeM7-0003YB-VE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-235ef62066eso13493135ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627602; x=1752232402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wVtmKRoiqYUXx5KXTyHSEPgvf3O8R5eArt39DWc1Ag=;
 b=eF5z5D+Uwgf8W+/3w/O2jJMHiqKRD2d3inmxAMHWwFUw0L2nZuB6+Co2AK+zPB4nVV
 3qOuNkKx4DjA+N4TNFusocExKyE1RyM7yhZcgaXlJHOPOGseTttOzdVYxweKi/IKlmyX
 HFZs6OX3gCXODltks62Axm65rrjh5BxNwWjHWALuwNicHQmyf/C6zHAU9LoH1F/hKJBR
 KQLhFLrV/KGFgoHAfTMbPprzZv0RA8Rd7xL+I3h9wfxoa8LWvqhusJvytYagInwgG6oj
 MY+f1qwGfyK7syTVtVFKwRISjj54KtJxmkn3SJlpsTX0yWfWf7iVZcBElmQpRkd1K+79
 G0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627602; x=1752232402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wVtmKRoiqYUXx5KXTyHSEPgvf3O8R5eArt39DWc1Ag=;
 b=taOQL6A6KUkXSKcizjo/0nWvTx369VBh5oICMHfN/YK63BI8BW0idYcjWnrC/M33ch
 02cqqnCUbSgcn/xmCXnEAENvfG2gz++HxYNU7aoX3C7XfeX/BGLNyykwSZdnM7wayIJk
 EtRvjyxd3c7w6lkUzIYPBbHa9NaZcIOkHtEdQUKj4C5XAfnFjQAaciNTm++a9MN+IlOx
 98qVd8ep2RqVWprhLcBpwYK1nDsne2JB1Ho3dZsWJ5PqjoZJ4uG6OGLl+bb1H51HExYL
 cYqM1DHJIXehMYPSc34gSq91BIr8ycyiChea7z+bi7YOUWwFpU3d49/CtNuqe898K2eX
 uTaQ==
X-Gm-Message-State: AOJu0YzCxO0qo3otFvwLg9jnanAGWPo4GiKkbGOrEdaiiTet8b529ue/
 cRFvKjr0vSBhOgBZGczouJE5tpjdPXnYEzXKZ70GBJy/vxeNeaKh2NZdE7f/FA==
X-Gm-Gg: ASbGncvSF6WxjqhACjTVZsvQyvz4Ka2diE4TsqnKtJOLY39NwbcnHwMwgKz0zkrZSDe
 OhWDFzqY3v6Czi3eqf8vo18IAzkZRETS2cRvlShN1lRz63Y91HQX5UxQ9EO2i9wxBo+FHmWHvQH
 gsdqa2etrH1Yw1bvmCL+XroKAmftsTrSWDXiq50RZYmZWGB+pTTr4MwUo4P/dLHts7c+wifV/AL
 Gri+67CKPTZtsiPxFOxXg3DWKG9fZnuBgQ7nziD/8iolR7WXqpM0q9yTM/aWk0fu0qDWciffrEj
 BKJ82seLGFy/21XG2XLp6tOs+9gKjyCYCfO0kBpqcBSAwdZgUnmg75jBuUF+tVKJOZknXpM/VEM
 ONNuSYEtpycmQ2gI7pVif6FYu5bhBT5vmUwJ5xkZPnfACO0Y9MV0seNzUWUGCfJE2tak=
X-Google-Smtp-Source: AGHT+IGO69hgrMc8dt3YwIvRSu+9xL3eHDPga1I+5gmPhECX3viFJOgBjLgX/FyOpZKZkfEF88XEhQ==
X-Received: by 2002:a17:902:ecc8:b0:235:caa8:1a72 with SMTP id
 d9443c01a7336-23c860d3c4bmr33062415ad.30.1751627601777; 
 Fri, 04 Jul 2025 04:13:21 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nutty Liu <liujingqi@lanxincomputing.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/40] hw/riscv/riscv-iommu: Fix PPN field of
 Translation-reponse register
Date: Fri,  4 Jul 2025 21:11:44 +1000
Message-ID: <20250704111207.591994-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nutty Liu <liujingqi@lanxincomputing.com>

The original implementation incorrectly performed a bitwise AND
operation between the PPN of iova and PPN Mask, leading to an
incorrect PPN field in Translation-reponse register.

The PPN of iova should be set entirely in the PPN field of
Translation-reponse register.

Also remove the code that was used to clear S field since this
field is already zero.

Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Message-ID: <20250605124848.1248-1-liujingqi@lanxincomputing.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a877e5da84..d8b1cb03a8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1935,11 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
             iova = RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault) << 10);
         } else {
             iova = iotlb.translated_addr & ~iotlb.addr_mask;
-            iova >>= TARGET_PAGE_BITS;
-            iova &= RISCV_IOMMU_TR_RESPONSE_PPN;
-
-            /* We do not support superpages (> 4kbs) for now */
-            iova &= ~RISCV_IOMMU_TR_RESPONSE_S;
+            iova = set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(iova));
         }
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
     }
-- 
2.50.0


