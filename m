Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3900FC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ixm-0006Zp-Ta; Fri, 04 Apr 2025 11:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0ixj-0006ZL-Nl
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:28:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0ixh-0005VV-WD
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:28:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso20526435ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743780484; x=1744385284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQu6jyouFAgpBczhXNW7NzWfPtB57yFgISV9X0wgp1E=;
 b=EPbgb9JRBudewrUPtsGt7do8qH+vyZw/OXJnF3PsNscwEYrJ+sCk2k31VDCJ3/YFst
 /zcFyEQUKFUDkaL/TwrzttU0rcUSUySAFIDAfCSr06EBCgOFFX0HHc3ZOkG4dDZMXQjM
 lUtvT9VJgs/tqwyxFj6TznvLbJZ4tWXMmHIWBdZQpq7euxZCvY8sy2COy3fntN6wMyID
 /IeGbCZq5Am4/9TEO/O1i2DXkqFAmoopoqQGHTqoNe+etV6/aDG5ieGNb43D+Fq6MAH1
 xWwUtXb9iYxYAwoJCE/tffKgqY1p14xcvmCwTrSkGjYy8JCNsq1O+cClEbruVMeC14jj
 FR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743780484; x=1744385284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQu6jyouFAgpBczhXNW7NzWfPtB57yFgISV9X0wgp1E=;
 b=U39TxzTNvDc89DKdaOyPRITAcuEqapxBaYlJAboEjSH272qcB5EDV9OP3jjJLgE9Ga
 89TBvzYjp/4RWhQ3lD+jjOWDBI4h94d6jGT1mZZNRwvC4jh6VovspaC9qCfRDhxUGkY1
 N9sypdEwg5mK7TO5ZGFtiS69KSslR+TrV4HApDacLBubQV+SFqh4GM8/U69nxpWoAhyu
 gdEwvGIS/LRHBPz1V1ys5FtA3wYHbEBkqX3TtxgtkTdWEp6d05xl492SvBG4jvxffFqi
 eArFy1VxdUFvSL9hMumdLZH6zlEbGM5Q0ozMNG+THQrxrxMvr17zAphAqH68Ddwbxzkf
 uOQA==
X-Gm-Message-State: AOJu0YzcOINo/R6lXjYD/FVU5c7Cjm7ws90FoZckIQhFl+muSY0xUuO4
 yWPsPz3YK0Y/du9Zz1q84OiUMbNyk7Tk/68jBj2x1HZCBvpsXvIUyBh2veF/XbASQOrF5AGaZ7h
 q
X-Gm-Gg: ASbGnctLDEYqhby8WssXZJ5Hr8VTgdt28gsEITwvm1V80uX9OkSiNVmnskmBUAmJMi8
 DaGB908q15VMFgSkBrKmj0MeGvkqHegUP7Rg8djhBqo9egyr2biwmeSuVhENzVuZ6W3POKHrtCM
 wVRifvF+bTQfv8Ptxxr7u5DKGjYFHt+fgnZswO+KRozfjHohs+JHWVwEK/eoAfdyrZ+vaZzVNCu
 WsYtxZ5uqqu5KTTI90eBlYMNZLBFNsCaTE2TdIvCRM5e6lYa04Yvo4nGpoB/M8dVoWaLxu/otX8
 GFAT53xvm/sajmQS4CfdZyZ/PgWIRenfIihBjndPra54bylskWPS8S7htZCeASPiCOSa0dCjtsM
 fs4tTzDLx
X-Google-Smtp-Source: AGHT+IGJEFE59SlGuC6rBGPBzqv8Off8Pe0UCzq2kWr2Ks+IPG6nYmAajGtdMCVD+rCBmRkYaZZCjA==
X-Received: by 2002:a17:902:ced1:b0:223:fbbe:599c with SMTP id
 d9443c01a7336-2297660f416mr109482815ad.19.1743780484385; 
 Fri, 04 Apr 2025 08:28:04 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866e3ecsm33570655ad.198.2025.04.04.08.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 08:28:03 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] hw/riscv/virt.c: change default CPU to 'max'
Date: Fri,  4 Apr 2025 12:27:50 -0300
Message-ID: <20250404152750.332791-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404152750.332791-1-dbarboza@ventanamicro.com>
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

In [1], minute 44, we have a hint from a Canonical kernel developer that
the next Ubuntu LTS will be RVA23 compliant. If this really comes to
pass, the 'virt' CPU won't run it by default - we'll need to either use
'rva23s64' or 'max' CPUs instead because rv64 is not RVA23 compliant.
Other distros will follow suit eventually, given that RISC-V profiles
provides the most stable ABI to build a distro in the RISC-V land.

This exposes a long standing issue with the current rv64 CPU: it doesn't
represent anything in particular. Extensions were added in it as time
went by and we ended up with a CPU that has a random set of extensions.

Changing the default 'virt' CPU to 'max' gives users a guarantee that
the board will always run with the latest features/profile available in
QEMU, which is the intention of most regular users. Using 'max' as
default CPU is done by other QEMU archs like aarch64 so we'll be more
compatible with everyone else.

Note that this change does not affect existing scripts that are using
the rv64 CPU, e.g. a command line like "-cpu rv64,v=true" will work the
same after this patch.

[1] https://fosdem.org/2025/schedule/event/fosdem-2025-6031-risc-v-hardware-where-are-we-/

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c9d255d8a8..ff7a122bef 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1920,7 +1920,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "RISC-V VirtIO board";
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
-- 
2.49.0


