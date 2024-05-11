Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAC6C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 20:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5tOe-0000s3-Kf; Sat, 11 May 2024 16:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sungdgdhtryrt@gmail.com>)
 id 1s5t8q-0006CL-IG
 for qemu-devel@nongnu.org; Sat, 11 May 2024 16:16:25 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sungdgdhtryrt@gmail.com>)
 id 1s5t8p-0000fB-1x
 for qemu-devel@nongnu.org; Sat, 11 May 2024 16:16:24 -0400
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-a5a5cce2ce6so7818066b.3
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715458580; x=1716063380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tHc8jWr6neTfVZis48MOJndabsjYnaeMztjifiW7VB0=;
 b=m+lLi0FTljA75E/yVgN0ZyDpGhSHu6/8aSmSIPzO/aQ2L5aulCITivvSa0hc7lT1m6
 YbMIja6thfC+fZmcHa9vf9U1/u3h02XvOrGkxDt9wqbPc6mmspPeI32bShgkWxwn9T8q
 Pj7Tqs4tmhFAcNfEzxPP+9hknV6vU2LRh3LQiRnVCNC4Y4wnDDmej9ywBE0md8bLOokk
 NcroPARD6EeLUTOZ/7SbrwMQK5XyHUltyXbb9q5FeV5pa22swYwK3QLpBO0Si50vRa67
 lHEjQ84aCzZkxhUAcnsmVck15xKcpXfWycxWqnl3C+V3oG4/A67QUkZ0nHgPiFAA8fzz
 mu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715458580; x=1716063380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tHc8jWr6neTfVZis48MOJndabsjYnaeMztjifiW7VB0=;
 b=WlACKQcTlpXSLLQRe6vibBlEAlvbI/in12QD8Mg5975VTg9YjOg+T6lRMN//SrGlCj
 VFpxvvyykJPC6wOyDDvQeh2D6PyHQyB9ghWJQWpVqylqMKw0jmJCRRaU0MhHIUXv/63C
 DETA114lKldASDU4jY7/ayjp7hhNjB7FbBcz2p7lcjtW4uHSMPBuy8arZiVwLil7xeih
 Cy8QcQJMyVqcFjlneULzNZFcUXgEwAD06yulrOgH5sH7T+pRzmknhee/SJz8h2RKhc70
 RF+6OS7Dh1i1X3ajfjEZSrKBfPqvyBsaCC3IZdiXS64oOMGZXSsRIzRAVhThkE82bCx3
 60lg==
X-Gm-Message-State: AOJu0YwcoKfnNlqeunAEujypuob/dqC7L/jjR7o/Ak/qZFHl6pu5BJdW
 UBKyjis/XWsNPf9lSHyufwBwq7V4ngbHIn13s/MSageHwIslzWSW90ts4Ptl
X-Google-Smtp-Source: AGHT+IFvdzQIwntlxWVQ9ZCxtGdeI33MwYjFl9I1ojz1S7E/u/1A/h8zULJM3EGmW14E3A70vbtFig==
X-Received: by 2002:a17:906:4ecb:b0:a59:cdf4:f939 with SMTP id
 a640c23a62f3a-a5a2d54c60cmr401643266b.3.1715458580245; 
 Sat, 11 May 2024 13:16:20 -0700 (PDT)
Received: from be-Latitude-E6510.home ([2a01:8b82:54fe:b800::4bb])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b014f6sm376143666b.145.2024.05.11.13.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 13:16:20 -0700 (PDT)
From: Hans <sungdgdhtryrt@gmail.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	Hans <sungdgdhtryrt@gmail.com>
Subject: [PATCH] Fixes rtl8139 driver for old kernels.
Date: Sat, 11 May 2024 22:15:24 +0200
Message-Id: <20240511201523.47443-1-sungdgdhtryrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=sungdgdhtryrt@gmail.com; helo=mail-ej1-x642.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 16:32:38 -0400
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

Old linux kernel rtl8139 drivers (ex. debian 2.1) uses outb to set the rx
mode for RxConfig. Unfortunatelly qemu does not support outb for RxConfig.

Signed-off-by: Hans <sungdgdhtryrt@gmail.com>
---
 hw/net/rtl8139.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 897c86ec41..e6244cfd7f 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2738,7 +2738,10 @@ static void rtl8139_io_writeb(void *opaque, uint8_t addr, uint32_t val)
             }
 
             break;
-
+        case RxConfig:
+            DPRINTF("RxConfig write(b) val=0x%02x\n", val);
+            rtl8139_RxConfig_write(s, (rtl8139_RxConfig_read(s) & 0xFFFFFF00) | val );
+            break;
         default:
             DPRINTF("not implemented write(b) addr=0x%x val=0x%02x\n", addr,
                 val);
-- 
2.34.1


