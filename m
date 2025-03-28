Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF1CC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 09:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty6LP-0001SU-O8; Fri, 28 Mar 2025 05:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1ty6LN-0001Rc-Rj
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 05:49:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1ty6LM-00038v-6y
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 05:49:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227c7e57da2so33031625ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743155378; x=1743760178; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=tBr83Su0bPW2dy6+buxXNA6Aof2irb39upIAHZ/HSAk=;
 b=eKzm1DbUn22v2ipfhPWiZoZ4jA6trwsjMPCkNSjXQIXlFo01KkXv0/M7Qatg+9Ahro
 BBFzOgDILlXtTj6PvA1TrHTDZKzPE4jJlZznkvJs8k6wnGMLqvDCJbHDZ9BgncjV9pYe
 3DSPiW9dSHd8mn2f6SZd0zMrN9aKXQXkBa8sa/rAfS9GAPlIEFywncDLIZSQPdmvJZUz
 ziNN520O5ER2T59oNTZ2vmNyaHBxAvU218e2Ynny757Zgn2EAM0RPZh2QYob5TGchaBP
 D47hQmKJEvmFsa9QKvBUXOTv8Vxo4YDTYOJ21yOjxhXV8NvwthrVdfUyaggZE2nwx2AL
 y9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743155378; x=1743760178;
 h=content-transfer-encoding:subject:from:cc:to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tBr83Su0bPW2dy6+buxXNA6Aof2irb39upIAHZ/HSAk=;
 b=bL5POLYrO0kENHAnQq+m8OorM2m+Hg51tysh/V9u7AuLDoca+YtKjJx5rFNIvNNV2Q
 OgZ6tcpfXAiL9L+db2QCKDOLjd8Kxic4Li/EAqDA+7In/YWLqnIJgWls5h/6zPFtzWKo
 F4b2pHfNKdtFtEfpxARqty+ymyoWb6+aLkrxhMipb7+QerZo3XLDb49KhsBvrOrJvM6m
 1EynAU9jkgOmNzjBHrxZ1XD4Sue84mW7l3OjIxUjAB7YzVQejzvXYwwOnEwUwybcAt2x
 uMgHxryacIY9QBAvNlKyaTJ4WHMCE4+ppChPFnMOmaGqHEX6qjfr3NZNKrAA9Mo52Uyq
 m9IA==
X-Gm-Message-State: AOJu0YytxDz28R94gcDnDstrJEMhiZaJc/QhcxYyNwybLFJWVxefVE1q
 UvmJp98xTPGmRnYZFXejIyM4PFwdyEVD7OLIJCKECdxd3DpyQCMO2QRFag==
X-Gm-Gg: ASbGncu45K59Dr37pf5Y6hO1kParzFFfzMeVRyTbKPIZg6GBoW5g+2QOaIA49eGN7EG
 fROGNYA9e2s/krD2+7WMYUsUlOgyVcZExQubQdzHlz2DBVMmqLv2z7YIXVJL1v6p4Uc+FlcQ48M
 NWQELuM4X5T5cx6jkpSBECtJkBpOFBnGbBibpMwPYsPNbqae8jv0Zp37WQstUNW37koc881Gj9I
 Mp3Nf1IfvMjd37mUgrMdxN17ChErY/LbRakFvH4BmfAXNWIgu2TYQ0X5GO0OKfLOtZ19WHrfxaV
 FusNnccxp4MJd8IC41+Nn27edm94QGsVVY/JZXFHyetHA/yEWnIThjr3VxqUjTc5
X-Google-Smtp-Source: AGHT+IF9fQxSRG6X5ulkc0vffvRp34qsClatJJiefMHYaOZW/NviD6M8cTIU5DuNp9/ydmd4uGKZzw==
X-Received: by 2002:a05:6a00:92aa:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-739610e35bcmr9819969b3a.20.1743155377923; 
 Fri, 28 Mar 2025 02:49:37 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e1f8c1sm1353402b3a.53.2025.03.28.02.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 02:49:37 -0700 (PDT)
Message-ID: <09ddf42b-a6db-42d5-954b-148d09d8d6cc@gmail.com>
Date: Fri, 28 Mar 2025 17:49:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/sd/sdhci: free irq on exit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x62c.google.com
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

This patch fixes a memory leak bug in `sdhci_pci_realize()`. `s->irq` is
not freed in `sdhci_pci_exit()`.

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>

---
 hw/sd/sdhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 5268c0dee5..f5296d58ca 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
@@ -50,6 +51,7 @@ static void sdhci_pci_exit(PCIDevice *dev)
 
     sdhci_common_unrealize(s);
     sdhci_uninitfn(s);
+    qemu_free_irq(s->irq);
 }
 
 static void sdhci_pci_class_init(ObjectClass *klass, void *data)
-- 
2.34.1


