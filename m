Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95956CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeWm-0005VN-E5; Tue, 28 Oct 2025 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeWk-0005Mo-8P
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:53:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeWh-0007mk-1J
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:53:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4298b865f84so3036273f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638028; x=1762242828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN9+o1MHirw7CB9gDKCqT7ChD79lp84JZH+uUf/YZy4=;
 b=aaKnZGcHFMD7Xvfh3ODusj6JwHej1fvr+dV8KkVuUP8UVBUyrqa8KakBNwHXN9gsOM
 C1Q3mksG3AU+oOsIX24ALVjqwuax/pKVCwzjwuJMJ7naw26q6rDc8aKvZB04o7dM1mmX
 Gk909NgcSgGzwTt6KqbmGey1GiImf4P2vyDbY0/NLy4HainnGgAFMeKfTwiEzgIzgLWT
 2kfJzxhmoqWVypOJlNmFn8knJvzROC2ykxtn2zm4KOx+fAJbccGjLn/k18h4odb8mI38
 X1DFYI2n+siHd7SscZCkH0Bmbo4PH8Mma450qQAF+5bwqSEFyPhrcY8JKbmpN9qN8dh4
 DdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638028; x=1762242828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tN9+o1MHirw7CB9gDKCqT7ChD79lp84JZH+uUf/YZy4=;
 b=mFHSpZ8lHn7qIHLIcf6rtr5VUcWyBBu6gI/ldSF+Rg5upq6lKC3LdEGK8T9roZ4yKQ
 CpzZNyrvGuEXSRb4JTE5qscYQ20yYryG1CMdfIUqe0zAijGMMM9gOjzBk/kLFJcGq4yi
 VRTDHGZpuISpB99dePbCbOPAkSKVjnM6EpBLgfAUez44KcC4eWUejDtgJ4QDZzHf3nNV
 1iPWlFCKBy+EPuLzOgUOf2Gpz66UEJvteUsWjldba/T9UP4Kd83zeLHPxiVzsZ6ga9dv
 hBkQLJdVQDzsQDdnxG/hV1fvexBKmh2bYJ75kTK26JJX1uabfDw4i3wZhooZ8JtRTkp/
 D8ug==
X-Gm-Message-State: AOJu0YwbyxNQCFeIpjsi8Ukhk64aRq2nPKvUWL1p5XdIuxgyTozACsXd
 nGo3HBXzXY5WMTAYFOqIx06cemC489bDOs89DxHlkM6sf0jD6lxN/pX1TBxU8IhTLjgG72RVugk
 zzYSLwjU=
X-Gm-Gg: ASbGncsmACERFcj3H/lejpsl0j5zuRtKSfVjOz1P2TUe2jrlcfnTM54MpNiz1ah4Gfd
 zbCM8km4fL6FEaSnCQ2bfphz3QVLTwFiIAy4IgHQozkRbQhqByEa80WNNNt8uHkMFJ8jTDP4Qki
 y6H2LfyLYpJ8uB3yOYAK6IGb5Hoi9VhzS6qaAzp7mglOshLGm331rbbFYFttG5IMBAVkfGYezVs
 4J4sEbUiXFM7r/muoK3+Qc677I+13N2+gdmt6HfJqCnLUI0oEYFT5cu/gdgaj5yfvPa5z1iDd2H
 zyJ38c3coyoF6uvN9sSCuHSOXb2OUrT6LV0VWaHzrfhhmywySCx7QXh5o+oDjSs9Ee8I/glrxEO
 rKrmFpn8zOf47vC7/kfoJ4RQ1tbRgOhncVW4Ytt2F/O5d5Qhmxm9iJH2gaLRxORqqMjIE34i2bM
 M8v3Tvl1qhbOv13JkwnokIpgMOcK4x5wqZNJIzf7sWo1ejMRYESN+00Ig=
X-Google-Smtp-Source: AGHT+IHcABFnH8jE6bCqVHBwVQZ1rbYW7Px8FRvCeLCO0Zc/zDrPxji2Ec2Ao+VKZr0F6rkIZRrcGg==
X-Received: by 2002:a05:6000:1aca:b0:426:ee44:6d9 with SMTP id
 ffacd0b85a97d-429a7e52be4mr1745993f8f.21.1761638027701; 
 Tue, 28 Oct 2025 00:53:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7d1sm19038498f8f.16.2025.10.28.00.53.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:53:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 13/23] hw/int/loongarch: Include missing 'system/memory.h'
 header
Date: Tue, 28 Oct 2025 08:48:49 +0100
Message-ID: <20251028074901.22062-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20251024190416.8803-21-philmd@linaro.org>
---
 include/hw/intc/loongarch_dintc.h         | 2 +-
 include/hw/intc/loongarch_extioi_common.h | 1 +
 include/hw/intc/loongarch_pch_msi.h       | 1 +
 include/hw/intc/loongarch_pic_common.h    | 1 +
 include/hw/intc/loongson_ipi_common.h     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

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
index e58ce2aa1c4..4fa03bc351f 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -11,6 +11,7 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 #include "exec/memattrs.h"
+#include "system/memory.h"
 
 #define IPI_MBX_NUM           4
 
-- 
2.51.0


