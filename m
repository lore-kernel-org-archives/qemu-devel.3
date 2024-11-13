Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673D5D637A1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 17:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBH0g-0000E1-DM; Wed, 13 Nov 2024 12:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0Y-0000Bu-Bz
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:22 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tBH0X-0003m7-0h
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 12:18:22 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso7378154b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731518299; x=1732123099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDSyRePK0ZioZyeNhXDT45o3z8pIP1oRwjHKVCbyFfc=;
 b=SprwXX6lTL12KO1fwZTVrWORfDqGC0pThz1qRVbfr91UXlzyKbwQIdTnXua8ZdH6Oe
 rtgXSyBHrEktbcpTkPiFw1QxizCAN1fT1b1xq5f8I/tzMMQX5SXajzP5oL002oduSJf9
 0w+QtvT8q89z9KCq7xGCaKT1Hk0JrDNUa0p6SURAyDS7kFk/pPmuZsJdhQNsawyYpwfU
 2inKL/GM7AjwCcGtFZ8RhLtr5zHOr1iqBfsC0y/o/h+KO7jqzRUBZwmB0glVf3bS9Ogl
 2+z6DEaT+pAzskW2Ghiz4x/YjRjs89inv9msi7s5MrJdcMEtX6v+zP4L97yXHErrea0O
 TePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731518299; x=1732123099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDSyRePK0ZioZyeNhXDT45o3z8pIP1oRwjHKVCbyFfc=;
 b=o2SjLrYKKMjYwifnpYYx9yaKWYw+cMrSSTuVoTUs7rItrYM9gIcQtyHmV79IsI6nUk
 7l1TjQeDigbVMFpXwAXiPzl5s2/3le9GSp8qk52oWKN1Ea+51d/WwtOMDYB6V6riiAE6
 aLR1R0fQi6LuDMMKGfNCnmM9/mP5p1Be3nRfEHTZnGDL05dqdzoq502WWAe3nVmpvl8W
 o2j+2qnIAVSDfJEuiGjIXQjBQc5D3Vzvx490TjzwdfurvVDSFEtH78O9r2dOpdHpHHrz
 QHdyolEKw12l3OVopWPYZaU/rz32nI84vhBXPdPdpHT0xhsFQNLQaMehanFcz18gGt1y
 bMCQ==
X-Gm-Message-State: AOJu0YxrM0EjjvTbXi5WowDXe4u2p6Rgl/RSnsfN8qfhcBQ4EoYSGCku
 +reqbGGdITtQS/dTjRLzbO9Z239cae5xZcZlOY0fN8pfYdj3dUC7MPFx7ktRms8RG9y1tXu+D1v
 r
X-Google-Smtp-Source: AGHT+IHJb0RtUnogiD3Wf4efT62Rwq4GmsCPMhd464qj9dPqTkGPhHxvfC787jAErNqllYGVzzZDAg==
X-Received: by 2002:a05:6a00:398a:b0:71e:59d2:9c99 with SMTP id
 d2e1a72fcca58-7245796a1ebmr4371542b3a.4.1731518298988; 
 Wed, 13 Nov 2024 09:18:18 -0800 (PST)
Received: from grind.. ([187.101.65.72]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9063sm13392889b3a.75.2024.11.13.09.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:18:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 5/9] target/riscv: add shtvala
Date: Wed, 13 Nov 2024 14:17:51 -0300
Message-ID: <20241113171755.978109-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113171755.978109-1-dbarboza@ventanamicro.com>
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

shtvala is described in RVA22 as:

"htval must be written with the faulting guest physical address
in all circumstances permitted by the ISA."

This is the case since commit 3067553993, so claim support for shtvala.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 11a0d2d04a..7b54c50794 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
-- 
2.47.0


