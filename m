Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5036DCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waC36-0000BG-TR; Thu, 18 Jun 2026 08:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1waC34-0000Ay-LW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:40:46 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1waC32-0004fn-Dm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:40:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0CAE33FA6E
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781786438;
 bh=h/dll5m2ZlmmcFRmjOO08xtsyIvO7hQLHQZVFkqhTZo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BNHX0gf/kS2LQtXKWlVHV26Y9U3XVUXLAycQAdvwSsKF4+E3A6A2k9T/fG/+KbjDI
 BxnpmmbDhpbLodCPWd7ssbPzJC1EA0ZxLWbM97+RlrElhfBVqnwogVL2iaZ4iu3VPd
 hX1hBdezpB31FGkYCUDStFpvMtJO4ANZMPzaOxeg4Nf7ENDS6YzuPCjF4r2Y4udWDC
 mSbE7gL+KOrhDJ0rI5nDzuQDjt2caiWzVmTmIAuQ22QFLRkEPMeBYF0QDyE829fKlo
 QpdlsQsqlpJRtcA5dq/cU/087x66RUSBxsRL8Pp11bMPmbUSeQnjQtoAmujMn32bpq
 hdUBoRLApPqdfIy1LsPRcF60sLJ4MaTtA/ZrcB4fhpEw4crwhWhVq/RlG/FemdLbIM
 jW9zDMvRdn2LdhJVErRt+b5Vm/XCWaojwwDNDCBSSXCwg7pmIPSM03s5+C69JaruWm
 PtSXT0komnu9OKnbcbW2axN6XndMBl0hPSwuqQkxDHjkeV9/nsvvS0E4IO1hJVdQ+l
 VtFVdeXT0r2wTkPt9AvbYo8Lp2OIlXadd13IGWrz6uGBgNXOSFOgyBYaUOyipxFOyU
 YcsbwnAegJZ1G8dpLLmi+I1a1P+Bs8IeT7qwtQdSaHwROcJK6Z/BCJa8mhRdwIrSDG
 6ZO7YsF97ugCuxEoDCu7fdjw=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so488254f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786437; x=1782391237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/dll5m2ZlmmcFRmjOO08xtsyIvO7hQLHQZVFkqhTZo=;
 b=J9PMRHli+6O/ymmvf6A/EXstaVuNsobFh9cGsDcQw9AjCDVwMY3kC2RfPLllWph2yB
 Nx2AXdzF1lvQqkGQr6rF+Aov5vOiAxxAMStG5efglPEqLHL620gKQpT3j8rXsmRU1tjF
 egUquv33FCWUdCVY+uwOHhKmKQaR33/ozThDc3NpvoMODJzeBXJElOC4Az+o9zcOri1t
 hkqWAu7+OD8MVIUh+sOBtWUHimh6esWBq16yJxA4o9tOhN33ghOeijIUe2VwtGlHoCmB
 fA5r60qnyWI7IHdDLwCQM23tdrC7Cs6737fME4CfTUvx7n94fzHFvLHxqwCyLZptZ+++
 xr7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DalYSQg1C0fVFsA54XtN5GtM1KBlhagYk1P6UpTw3NLP+YP6hHcq/WvZ8GvC8u8gbNQkaHVWFTkNv@nongnu.org
X-Gm-Message-State: AOJu0Yx8O2P8k28hKMyG2vmHhU4P/mEh/s0QEH7y2FID05juc3DFPElA
 DyYVL9C1GM2jKXCrFgrxabW3Of7vhEDGMJ5zIOqq/JsifrKZ2uwhPuU3TSEBZZ5of737HnqO+VB
 v8zxOfYjX2JADBzAIDAwrvk09YKcwpIdmAPoLpFTxhvLussR5MlzPmtLuNxr6n36SnU1cxHMP
X-Gm-Gg: AfdE7cmDaaekTZM6CJ+mlzuGyYFYfR1qBtii8iAsp9qOI324nKp/zT1YC5t0GpnlaqA
 4cBZzPp4jWQSAjuMDILOvTFRjWYsmcJc5HBp8PeYfOpFn10Kv16mTnprN7SjW8CVesX6nE2ike7
 63xfT37B2WshPTvbez134vcjfrv438q0/qab5tR3HkX2Ynjo2DdMfRYz7GxuGXw4dPeq2HUlt+D
 A8/UOw7TJRbMi0X3D/fQHhWSIbpSrZFCCYXrU6PcUn5LiAul+NhihJuoTzhOqnBvtvENFdboGDf
 yzmJJ5FS4YTAqwrgKrETsVWFZKTPuSz2MgoKy55mC/tp2Acv4Ui5tgnYeSU8eG7GIlpFxORZx/r
 OeUULlp3kh7EaFsPZ2Kfcdb+WJbf4OEGju+QPeqq7s8XA/yXTn5nu8Jsne/fHVYDsDQ==
X-Received: by 2002:a05:6000:310f:b0:463:d9:5b35 with SMTP id
 ffacd0b85a97d-463ab328c3cmr5550940f8f.1.1781786437635; 
 Thu, 18 Jun 2026 05:40:37 -0700 (PDT)
X-Received: by 2002:a05:6000:310f:b0:463:d9:5b35 with SMTP id
 ffacd0b85a97d-463ab328c3cmr5550886f8f.1.1781786437212; 
 Thu, 18 Jun 2026 05:40:37 -0700 (PDT)
Received: from workstation5 ([2a02:3035:61d:4f84:7003:6a6a:d834:66f5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm66366755f8f.5.2026.06.18.05.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 05:40:36 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] hw/acpi: correct field sequence in SPCR table
Date: Thu, 18 Jun 2026 14:40:20 +0200
Message-ID: <20260618124020.640794-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=0.645 autolearn=ham autolearn_force=no
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

On LoongArch and RISC-V invalid SPCR tables are created:

Terminal Type : 00
Language : 03

The correct values are:

Terminal Type : 03
Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	update test data
v2:
	Mention the different specification versions used by our code
	https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
v1:
	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
---
 hw/acpi/aml-build.c                   |   4 ++--
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 9b3cdd3781..990abc64cd 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->stop_bits, 1);
     /* Flow Control */
     build_append_int_noprefix(table_data, f->flow_control, 1);
-    /* Language */
-    build_append_int_noprefix(table_data, f->language, 1);
     /* Terminal Type */
     build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
     /* PCI Device ID  */
     build_append_int_noprefix(table_data, f->pci_device_id, 2);
     /* PCI Vendor ID */
diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
GIT binary patch
delta 23
TcmWFtm|!Qw%<vxw7?1z}S|J61

delta 23
TcmWFtm|!Qw!2BNw7?1z}S{?;}

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
GIT binary patch
delta 10
Rcma!wnqbGo%rMbG3IGpM0&@TW

delta 10
Rcma!wnqbGoz&z1G3IGpJ0&@TW

-- 
2.53.0


