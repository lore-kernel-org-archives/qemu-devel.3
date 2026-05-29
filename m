Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE48DCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1IS-00037M-3Z; Fri, 29 May 2026 13:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IL-00036T-TG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IJ-0001ef-QN
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso91763975e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780076810; x=1780681610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOQ7vNcaCw6xZYXJJvrs64VkT0GGaKVzx/wu1YpO7OQ=;
 b=WAGo7D8sK43nH1sOvlLqteMeFuGWBJclv0O9OZWjF3vvKb8TDOk0BMoU1kRb8b6B3o
 bWLnty2yQ2QdFN5XQez8J5CWSoRF3YQHELzNcUXREiAMeRt3axHCqI/PPuht3rvUDe7V
 qxn7vchtet68r1SSCvmJKkWbFcnwOE7heCVS83Iue/0cUHcYgGFMZ+TgHz/kxa2snF4R
 /yBaUOEF3HhSgZuXQs3qOMsgBFvo9+1sPlwDHx0ayKJ/tIqw0Yr8c2vE0VBBIMMTmrvh
 S6U/HSq7J1gK+7TFJNOUKdJwO8wp+nwWmx0NpTfAKEy20zXEfzIOK9DqNCAc78WJDSs8
 wesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076810; x=1780681610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rOQ7vNcaCw6xZYXJJvrs64VkT0GGaKVzx/wu1YpO7OQ=;
 b=c8a/VpGxLYFvB3cn4R1aX1EH1XrT6KAXrtSb/E7XmCVxOWfW6oQJUWvEe5IaBy+4l4
 mcZGIHwSoJELETKVPRAjTj4CE7Yr3uFl0bFtKZ8/EYrYpnQXfereueYuiJX1pH2iBDeL
 J4N+BR0z+DpKeJqPEeOy6etmCA7o8hWZL8gMM4x2G8j66OxC/28Kj+mHwhQV9w+mU0Xs
 BKcwcJ5lt/aR62LzU0g1/b4Zw3orkn0ORFOr/GlcApBjDXMcnlAu5jDOU6IlIPy6PTXK
 q9uL1KKueU9EKPpoO42q7lz4benFSk1PcFNQ7QjQ0Acm/qBFr6Rxs5HkutNCb0ribs2x
 UMTA==
X-Gm-Message-State: AOJu0Yy8DZcgopjziz7ji1EaLdHUFbKS0O9og3ck6KxXzgaZgRRFLKV1
 NtYvH5j4nPJEf+qp+9iqshLvT3yBOB6vQj5pODy122pE9K5lIfFoMfhwvlSFjlRtiTGYjSJuMdT
 l8F87
X-Gm-Gg: Acq92OG4rBviZ2qgys4cDkVKrvjvZJqpZMR+uxy8e0iu+HNeJd7uQCZJtL30lQqJcnI
 O0gFyqGcN/iS9of/xfL6WivrwwDzA2zLujIJwTFAq32eDZQzQup1VL8CHXcueUPWyBI1orf7T8Y
 p1NIw2wgtb50K7h36g7RHxvQCOzICGjPnscgtyq2EuSFth8ehAKMdhzcbc+GQRsnuJj2RL+hyr9
 hJKm6WvoOMDJFh/KLqaDkUs8m/Bt7dSJGS4GoszHlYGQylAI48N3GSmfB8+JMT6bxLZ3iO+BBNe
 pR+xCeNcxd6+NbSlBaYxQfdm7PL4ziCaWTdMCHpBW+FNvt9qxs2hyO3TJ5XoeSRPcwtggk7qq3+
 URvdKh103eRIyQoKnlTUCWOoVNaq6J3lEnMyQjCI2K/s3Ex6PQ2vDTVaAhd4Lgl34++sEDL4m0F
 6nRfPMyFcWsLK7eKX6HDZeXYgqU2ym2l1nDqc3VkjUNUigh4KZ50d+2+tGkCF1Caqz0ImGX49rM
 J8ifTAW6Pz/7Pm2biz2lZDz7RZeWOydFQl9MlyAtzU=
X-Received: by 2002:a05:600c:4f89:b0:490:4717:970f with SMTP id
 5b1f17b1804b1-490a292ec27mr9193275e9.14.1780076810248; 
 Fri, 29 May 2026 10:46:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aa24bsm18668895e9.9.2026.05.29.10.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:46:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 4/5] hw/nvram/fw_cfg: Remove support for I/O port fw_cfg
 without DMA
Date: Fri, 29 May 2026 18:46:38 +0100
Message-ID: <20260529174639.451353-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently fw_cfg_init_io_dma() allows the caller to pass a NULL
dma_as argument, which causes it to create a fw_cfg without
the DMA port or DMA support. None of the callers use this
capability: they all pass &address_space_memory.

We don't really want to leave the door open for some future x86
machine type which doesn't support DMA for the fw_cfg device, so
remove this, and instead make the function assert that it has a
non-NULL dma_as argument, like fw_cfg_init_mem_dma().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/fw_cfg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f68191553b..a9d45adb2d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1026,12 +1026,10 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as)
     FWCfgIoState *ios;
     FWCfgState *s;
     MemoryRegion *iomem = get_system_io();
-    bool dma_requested = dma_as;
+
+    assert(dma_as);
 
     dev = qdev_new(TYPE_FW_CFG_IO);
-    if (!dma_requested) {
-        qdev_prop_set_bit(dev, "dma_enabled", false);
-    }
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
-- 
2.43.0


