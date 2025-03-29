Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1533C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 11:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyUey-00039t-SI; Sat, 29 Mar 2025 07:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tyUet-00039a-GC
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 07:47:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1tyUer-0006st-OO
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 07:47:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2264aefc45dso81266095ad.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743248843; x=1743853643; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DBC++iFuHsZX2D9R+yxDdm9roY9FY47Hp4azZV6NYAc=;
 b=CfJNTNplTbSW1k4hYNcm0sErNPp4/m5wF2x4zZH11Q6bIRmyQg8/FJejkvrNRbOKBA
 +qnTOuZteaGXPn2KqdJte1e3GZrZo6j7Dr29pb8ZmhsY3d3jAyLStWqjWLghZQdq7Jv6
 zEi7A1KqnmitCDj2Nh7wcM7ZbjFUruycoqPlnMhQNPZF1dzZRA34OYVMhwmYlYhJ+fLf
 7nLHJvDniJ6fhrqG7IRs8SSnO8NNB9N4By7ETYv0hriTsCUldXo0PeFssZ4NviKk6Amc
 ggyAG+xYeEqWllDwgDEvTfd9JgAQtejUjyx82sEA/Fh5iN/OI+wXwAKmzwijkbtLUI/j
 sq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743248843; x=1743853643;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBC++iFuHsZX2D9R+yxDdm9roY9FY47Hp4azZV6NYAc=;
 b=pm8Dh+qObkfcjJ5WjRpoTpMt5Hl0D3FWFyhB3++0xhPFLwSrvexdia5Sx33HYJPUuL
 ndMNw3QNlDVmOK55vnMahd944qZKviQ2QIwZtz5YwEbIATONKTEZ8iz1oLqz3ViSjvXW
 DLu00uT6Sc5m9XlqzphV/LZf/dETk63iAnqBdtKHiBsLIWtr2QguAsvSNTKTT0i5sNZr
 6NAMexS4wcX+tHk8jwytUzA9VeaMhkvEzoHjoy1Mu/G3sibKo7bXlEvL8589FcHNu3IO
 eVD3af2rELIEwbrnY8w7ps0sZWwrikNvYihB+aO5vilCXX9emZXjYu/ZJ5HZiDVpSngP
 Sw0g==
X-Gm-Message-State: AOJu0YzpdJqyb/EZss/hDINGZsGr4BjHBu8zl2/eUOCNIFspmCoopZst
 vQvdB+rr7Gs2VvkOQtAfu1N91Z5RvN0qzPdjQrjQuC0llVp+EY4Mk7HAFA==
X-Gm-Gg: ASbGncsJzM9pfzjC9z5o7gPJKAlTGcV3euQOfa4IvdQ+vkDQvDjERuiyA0P8BkXJU90
 OGFw0xues1bJRArmo4VPdilzpXe+caS+EowkT8ChAbZWRpaCdfFgbabwddsRwQh5eLXn0sRDsse
 51EItE772gkDqbf5loxKem4ypOgXkygG6d1Qoijn1zJLN7cTfg53BVZagAnaRkEv/WpePXB1O3z
 y2Ev7kx4WiEBHpjUJi7lAEhR9ug9KYAJsc3XaG93+i+M/tiPQFP5UaAfKEwHLG1ZGe5r3aARCyf
 Maewa4zk/QJqDyXDTFAxYq2k3lFmeexLLeXfj5f9GDUXDIXMeDrPakM1TrcEZnzM
X-Google-Smtp-Source: AGHT+IG39S3FVrU6/+32HDIEWh3ZR2Jr7fo5xBKtAFNEqeEoAINIAfucgoR5ZxCh1xEPK+7Jy2I5tA==
X-Received: by 2002:a17:903:2303:b0:223:5ace:eccf with SMTP id
 d9443c01a7336-22935084a88mr18089035ad.25.1743248843234; 
 Sat, 29 Mar 2025 04:47:23 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710ccf1fsm3386950b3a.163.2025.03.29.04.47.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 04:47:22 -0700 (PDT)
Message-ID: <43ceb427-87aa-44ee-9007-dbaecc499bba@gmail.com>
Date: Sat, 29 Mar 2025 19:47:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/ufs: free irq on exit
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x62e.google.com
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

Hi,

This patch fixes a memory leak bug in `ufs_init_pci()`. `u->irq` is
not freed in `ufs_exit()`.

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>

---
 hw/ufs/ufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 1ccd6f88b6..e80e065fea 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
+#include "hw/irq.h"
 #include "trace.h"
 #include "ufs.h"
 
@@ -1732,6 +1733,8 @@ static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
+    qemu_free_irq(u->irq);
+    
     qemu_bh_delete(u->doorbell_bh);
     qemu_bh_delete(u->complete_bh);
 
-- 
2.34.1



