Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC4AE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBwm-0001Lq-U7; Thu, 05 Dec 2024 08:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwN-0001F2-Mc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:49 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwI-0004al-Kb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:45 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7258cf297d4so888539b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405413; x=1734010213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAiVT2nm6HtlwAXt1fBj3C0Ia1gR1mPhrbi715hhO7g=;
 b=bSKljGuz/XTd/k0/aLpCJTdgIs6EuyiVVBQiedsSx0gpX5wrCw1P44EqfBFQ9COmns
 6aeLa6ci5lZvZzOUR5v7n60PskGVo7wMkBWwMgbyKngI+d1h6XQNMdEGOBcHdYdLIbrm
 EMoBzSuQAJSgMHeC09cayrfQUDDwB3VlrNLLEhA0uS/xTTVbXhYPE3G7AMFv5108ZNJd
 5z42S9YdjzvW/JRtHAB08neoNdFcqq4SPs85MowhIE8PELDYoQRmdgRtR4kspQta3SEe
 0fxYrASY9dkG/cgqSQzVLkw7Hid1oeR0989MwNHUP/NvMVgbULaM/6N5f9HdV6aC9mXs
 qZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405413; x=1734010213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAiVT2nm6HtlwAXt1fBj3C0Ia1gR1mPhrbi715hhO7g=;
 b=qCYrD5N99XrDQmziFzWniJE9pJPbiBnKNiU1EmmA+4XPbZL8oCHP0jKZJXFoWGYjUL
 oUGRiQ6SRx/UxMXSMPaYvXV7vkl7lAlkkcQkpvGQvJ8KP3NkvPasiF1n0XDjMRJnQ9pe
 LmaLCzfgUmx4RomCqgiGFpd79CT55kinTxW9GeaXcYp3k6sTi0ekWZeeckWnpATVco/T
 Dsw1wXY23jSJvldetcrdMbbd6UYzFeoy19NgZ+DdCJ99J7Jq8OPOtbQTOJV0mzLTTJer
 FJhd5eBUwXsittak/LGW5wbK6C9YvV3nebkOf/FiJguSNXxg2yin41PkjAC8AWXLzQwb
 Xbgw==
X-Gm-Message-State: AOJu0YyLnsvc4I0jJquyCx25NJyMRzXvYyziZF1DASxDHwQYCmDN4Bho
 JkEjLUkHZ5vnzAAI2FnjaEFUuv2mXc00k8/iaghvVzwq53W/aWPvutJUX/LRg3SP3/A1lsUPz6D
 T
X-Gm-Gg: ASbGnctRBatOwgsKw7dgrwUF/slB0Tec2zGdqqH+DvV+s1Gu/whDoogMw3WowmWwVrX
 kXUsHYexavHwFWImfiFnxa71GwdnusJtteZVzumtObAibhTld1whnKdQfJc5xxXyrfbB0Ao/DIk
 aOxBKAJ2c7FGNYdIIF2IYfTp1I7K5PAgnzuIASDNo6yTrVug/OjzJzXcGF4IV80GeA2NwFujFqd
 nQSwnwUDJDrJbI68tw3oJ3UtpUcxH4/srGpfhLoAHJwSQKBXKbDMNaVZ6Xu9itrthvJuMQutVDt
 w4ZZ
X-Google-Smtp-Source: AGHT+IFAAYaRWtJ708oeHHk/Qt5/oond+zrVpgmlPPzGQfEQeO1kXm2eJcUJrJGlHoEmO3ZO0qvHIQ==
X-Received: by 2002:a05:6a00:92a3:b0:71e:573f:5673 with SMTP id
 d2e1a72fcca58-7257fa7afaamr11315797b3a.15.1733405413003; 
 Thu, 05 Dec 2024 05:30:13 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:12 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 01/11] hw/riscv/riscv-iommu.h: add missing headers
Date: Thu,  5 Dec 2024 10:29:53 -0300
Message-ID: <20241205133003.184581-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

This header is incomplete, i.e. it is using definitions that are being
supplied by the .c files that are including it.

Adding this header into a fresh .c file will result in errors:

/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:30:17: error: field ‘parent_obj’ has incomplete type
   30 |     DeviceState parent_obj;
      |                 ^~~~~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:50:5: error: unknown type name ‘dma_addr_t’; did you mean ‘in_addr_t’?
   50 |     dma_addr_t cq_addr;   /* Command queue base physical address */
      |     ^~~~~~~~~~
      |     in_addr_t
(...)
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:62:5: error: unknown type name ‘QemuThread’; did you mean ‘GThread’?
   62 |     QemuThread core_proc; /* Background processing thread */
      |     ^~~~~~~~~~
      |     GThread
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:63:5: error: unknown type name ‘QemuCond’
   63 |     QemuCond core_cond;   /* Background processing wake up signal */
      |     ^~~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:71:18: error: field ‘trap_as’ has incomplete type
   71 |     AddressSpace trap_as;
      |                  ^~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:72:18: error: field ‘trap_mr’ has incomplete type
   72 |     MemoryRegion trap_mr;
      |                  ^~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:80:18: error: field ‘regs_mr’ has incomplete type
   80 |     MemoryRegion regs_mr;
      |                  ^~~~~~~

Fix it by adding the missing headers for these definitions.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 9424989df4..2de0cdfc56 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -20,6 +20,8 @@
 #define HW_RISCV_IOMMU_STATE_H
 
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/dma.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 
-- 
2.47.1


