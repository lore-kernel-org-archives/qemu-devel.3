Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F18103E161
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oQl-0003aQ-Dp; Wed, 18 Mar 2026 06:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQe-0003X9-7a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQc-0003Lw-K1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso61622475e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773830825; x=1774435625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwNzQtxUIpOJ3mykV9HQnVdMQ33xK3MaNnp/Zcfgj3c=;
 b=f5brf6l4LsXP9WOi9BpcG7FIC0yWtqOz5WKnz8TCB7WssKcq/di+qsJjBPFNI8jpAE
 DUkCnWRGJzM9vdIUGKJbIsukBgECOdiDwgYkkAFnFUDTcmUnHSBLRPn206yFrteEjldY
 P7QSeiGFktloqs1IWgKW/XariEsp3XRWAWeWOtHN0qkXRmR47wDV+85CVt/IXVdwJ4Rn
 7MwvyCDGhaGO686sohv1oDnO1oWr58kGy9wNfyeAA3+fv4bBA37kKud6NE8/yV562VCX
 hBChJ3kEYtaU4XRDui6Dyt4/pKzPIHPCYJzZzKwiXA/NSexLioCgs+VZx2xHCVF3ZJdd
 9XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830825; x=1774435625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwNzQtxUIpOJ3mykV9HQnVdMQ33xK3MaNnp/Zcfgj3c=;
 b=r9vGiIIOsvEMkwxqQyRka9frZ61wxFx1do49rYYJO0XR2maGcAfAISkzpY6ddjw5rN
 h5BG3gRJDexCTTrQvVmUymp9MIR2KjMMir4Pv2k2kcgcFGIyktPYfv961NK9OVX+BFJf
 236BcDILKe/kwVU1/yEmJ296ruuZYcI35ZvPnDjHkoNjBfKamufR5JqyldvXUHXyzmGZ
 82MbfdgYZCluOor5bFC5N9Hno//25khy2l4fGKE6PnVqI9EBJ5huSrI84uo0mbeHEZQw
 HP6z7dIC/HD5N2+ydv+fm+EgGB2oF/LGr5o93dVF3Sg8TwyNVrvB/k24Ydtj+MNH0gov
 zH1A==
X-Gm-Message-State: AOJu0YzdFq6E58NGKU2PwM2BP1j2/l2N1y5Y35jFEhgzazZk0yiLA2fa
 B/UNNSzTDZrIK/YIuVWOTcvq1GhroNMloefxhwhOrRzFD4MY7AkdnpBgmPusYXu5
X-Gm-Gg: ATEYQzxTPZy5RuNkRhNCNN+XVEPTVtvCysTqp4sqEVJQJ+senQn8fyNvuDtFrFYYGmP
 7dhwhoSeVpthEwmpvKxz7OmqZV4VklxoI63247qWrIn1msC0j/YhLc2SUmzJPkIBohaHIQOwZnL
 tuImgdtfDw/rq/VE4nuUPVNXb92zNUgmaXMYulS639BcIvrD1cpAmpvkwUIVw2pWC8Y/l7f5zkc
 I1WbFf8vKSq6QGFTXwTkyLl9wdsvVypQB8maUwG3b6EubgLuiA9YdobFsT+cewchrQGqdPVN/tt
 lHzohHZEqsyy0qm8IGo75MSJLe0JgQvgzHPsVABcCjDRGfQlAfagpYZsw9VK468Z/mmS3MGh5oV
 StoAtUVTd1thu4HnTzqTaol/Y9hRP+rcE3zOBF6/z63668tDZb81Lcry2pFIEIgQuoXAS787mjK
 dLyynV+4GSH22dFyfzgZePQlkWjxSXxfzpQYTxKhU9BY5QY3JwBnU1Nbo69LHXM0UuLw==
X-Received: by 2002:a05:600c:a4b:b0:485:3f17:425 with SMTP id
 5b1f17b1804b1-486f444863emr42876605e9.21.1773830824761; 
 Wed, 18 Mar 2026 03:47:04 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-80-194.adsl.net.t-com.hr.
 [93.143.80.194]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm56471095e9.3.2026.03.18.03.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:47:04 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pierrick.bouvier@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Subject: [RFC PATCH 5/9] system/memory: Add plugin callbacks to intercept MMIO
 accesses
Date: Wed, 18 Mar 2026 11:46:36 +0100
Message-ID: <20260318104640.239752-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318104640.239752-1-ruslichenko.r@gmail.com>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add plugin callback to dispatch memory_region_dispath_read/write,
allowing plugins to intercept MMIO operations before they reach
device models, which enable to spoof read values and drop write
accesses.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 system/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index c51d0798a8..67a59f6e0a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -35,6 +35,7 @@
 #include "hw/core/boards.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
+#include "qemu/plugin.h"
 
 #include "memory-internal.h"
 
@@ -1448,6 +1449,10 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
 {
     *pval = 0;
 
+
+    if (plugin_mmio_override_cb_invoke(mr->addr + addr, size, false, pval))
+        return MEMTX_OK;
+
     if (mr->ops->read) {
         return access_with_adjusted_size(addr, pval, size,
                                          mr->ops->impl.min_access_size,
@@ -1533,6 +1538,9 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
+    if (plugin_mmio_override_cb_invoke(mr->addr + addr, size, true, &data))
+        return MEMTX_OK;
+
     /*
      * FIXME: it's not clear why under KVM the write would be processed
      * directly, instead of going through eventfd.  This probably should
-- 
2.43.0


