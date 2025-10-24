Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD0ACCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNZN-0002sz-5C; Fri, 24 Oct 2025 15:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNZK-0002rr-MC
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:35:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNZI-0002Ev-7p
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:35:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-427015003eeso2256338f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334518; x=1761939318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBgrmxISukx2phyh25lifUJ0WsSDdFWGHFqh9r4mLPo=;
 b=OZ8AVjsMAeVhniWSat1X4qZ+wf3tp0xh54xiKUfvU0iN7s8QIE+8yi73xBRBJ623NT
 oIDcgeKJ/fjHKT1ms8f8OFgTiNPd1Z/sQZ3U3x4nk7ij2GqlKpjnGCHkKcjNkt5aHGar
 X6kqWBpCE6SWUmrDivis1qqI/F35F5ozY/B5OosZ4BQ3bZMS0awIecyzQ0PrHS/QQioU
 uedWqRQIC8YvwrMboRRSG6R9/SoRHMFSmqk4BViX/PzZncNZn93/PBeb0LNWfZ+oJ0bf
 YYY5i05n/S4tzlSAWQ1SqCsnpYIHdOjlmdz4VD64cSRf0Ha2kH0CrZGDYt+YkG050IPo
 o21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334518; x=1761939318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBgrmxISukx2phyh25lifUJ0WsSDdFWGHFqh9r4mLPo=;
 b=MKQKSxoQtXOkydaKbLXKDyy5AMzJypV40RuoeLHvRFj9JT/ZlO/EN7SRIe9At4WTXm
 oNsqSSDoEbCVDsuX46uKbrEtiMmj4VtWXqXqcXQmRBgUNhv5ns5TblObWnjZPneuWooc
 jCvBIM8sNhFRX3fGuUep1GEbQ2K6mt5mMvm6JyTjU8v9kWuNtHauOwEyKrvMQ65IINGN
 sNpNGYtpBx3OuDWbXn2nfVpZtSiz3j6xYYkkrqABKQxCSyXjvn24rDLgg+KT0fSCFn3i
 k6u0VYvTbNflXRoAr2oY9rdnGodWUVlKCh07w1vwXoJEMEk8pjIJtPNtJCgwDhXLMcPf
 oSlw==
X-Gm-Message-State: AOJu0Yw27ye8ghDLhoQ6CTqnsv4zpmjAVJGJjoNVkfTPh/R+af2X0++6
 9ErGHHcA4cTiVXGUfi+s8KtjRqZox5hGcmfWyX/kWqqnLAHSY5dOn8NcMnOHDwVt8Yce6LZXUcb
 8r2Qr8Q8=
X-Gm-Gg: ASbGncuE7mOIWs/qTPjz8Dls7eJaPC5l/uvgHKAsjq99WMtKdVNN+L3WJLULgD/S+Ys
 VGWON/2DrBnyqNjRUv6Q7D/Z755fj76O1BEXSqT1Irs4FDh+/Z8uIBg7MVpo9iVfY9JfS6X1bUh
 KJ5j2xFmmStcC0T89x4rvs5k9VhZXnUs12x6WDRZjNp1YN8nrUARgF+l0+HuGRDuWR24PDK1use
 DXFi1JPqbigfbpa6XywTNrxiqClxQx80C8hp4miaUuzOd+obWtWIFlo0r+lqA7fZAQAH29Uy/aF
 1wbAZN1JrAZ2UTCp38wKwNyBbTzrhQiEJ/cDgy00oQFNXkoQ8acaHtxJM4pSFyDQix1LUfeE/fh
 d4HKJaGLiQXzZlxw4bhYODKSIAqYBkD2pECImhtUqrlvSXepUCnFwJscFwgxF4pWG9eGsEs8ctu
 /VSGSPBmNJvnwdfSjFD4A2LGbim0ZZLvU3ytEcltrWTCppYv+QeQ==
X-Google-Smtp-Source: AGHT+IEV4OMSIcqrrZUp/PLoSTv+oEYKatypcoz+g00LHCca0FFl5wOaR3GUGM5GkDydxJfu3DuZCg==
X-Received: by 2002:a5d:64e7:0:b0:429:8bd7:774a with SMTP id
 ffacd0b85a97d-4298bd77939mr6244458f8f.40.1761334518282; 
 Fri, 24 Oct 2025 12:35:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b79cbsm27584f8f.4.2025.10.24.12.35.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:35:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH 20/27] hw/int/loongarch: Include missing 'system/memory.h'
 header
Date: Fri, 24 Oct 2025 21:04:07 +0200
Message-ID: <20251024190416.8803-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/intc/loongson_ipi.c:9:
  In file included from /Users/philmd/source/qemu/include/hw/intc/loongson_ipi.h:12:
  include/hw/intc/loongson_ipi_common.h:37:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     37 |     MemoryRegion ipi_iocsr_mem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/loongarch_dintc.h         | 2 +-
 include/hw/intc/loongarch_extioi_common.h | 1 +
 include/hw/intc/loongarch_pch_msi.h       | 1 +
 include/hw/intc/loongarch_pic_common.h    | 1 +
 include/hw/intc/loongson_ipi_common.h     | 2 ++
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
index 0b0b5347b2c..01bb1e465cb 100644
--- a/include/hw/intc/loongarch_dintc.h
+++ b/include/hw/intc/loongarch_dintc.h
@@ -8,7 +8,7 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 #include "hw/loongarch/virt.h"
-
+#include "system/memory.h"
 
 #define NR_VECTORS     256
 
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index c021ccee0fa..1bd2bfa07fc 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -10,6 +10,7 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 #include "hw/loongarch/virt.h"
+#include "system/memory.h"
 
 #define LS3A_INTC_IP                 8
 #define EXTIOI_IRQS                  (256)
diff --git a/include/hw/intc/loongarch_pch_msi.h b/include/hw/intc/loongarch_pch_msi.h
index b8586fb3b6f..ef4ec4fdeb8 100644
--- a/include/hw/intc/loongarch_pch_msi.h
+++ b/include/hw/intc/loongarch_pch_msi.h
@@ -6,6 +6,7 @@
  */
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define TYPE_LOONGARCH_PCH_MSI "loongarch_pch_msi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHMSI, LOONGARCH_PCH_MSI)
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 675ba96e64e..179361eb567 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -9,6 +9,7 @@
 
 #include "hw/loongarch/virt.h"
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define PCH_PIC_INT_ID                  0x00
 #define  PCH_PIC_INT_ID_VAL             0x7
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index e58ce2aa1c4..8b51af83e8b 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -11,6 +11,8 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 #include "exec/memattrs.h"
+#include "system/memory.h"
+#include "system/memory.h"
 
 #define IPI_MBX_NUM           4
 
-- 
2.51.0


