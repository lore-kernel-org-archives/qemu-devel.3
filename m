Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F4CC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgGOm-0002e9-Kl; Sun, 05 Jul 2026 02:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOa-0002d3-2q
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:32:06 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wgGOW-0002Lh-0D
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 02:32:02 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A4833F29B
 for <qemu-devel@nongnu.org>; Sun,  5 Jul 2026 06:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783233119;
 bh=c+Z+kHEatpMr6R7972l+oopM+nLUy5pDbXekO2DUjmU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=esPIa6ikk/tjm7Sro8hDCRlEfdyWazNHpF7kOpt+Sur4/Y5DD7StWgiSg/ldJ+QVP
 oKMaTAS58RGw3I0uwnS9fDERAdfKlJ15D3uJmjGIYISPpwY6ZyIoaEywzLhYJRJjzW
 /+pau/6QVdthMP4UYELtdn2OP655kJU/0dLv13GLD2fh1ynidxKv+J6bXhF1NiLTn5
 o4tU6SJ7Lmx+pN/o7AXkKcdO0zZUtY0prNCbAtRvMRLY23I907JP33YxN61LEFyLft
 xR1VBV+4YG1O/3KBHqSPWuBPzMbo6iy8JvL4fVaC+yiYABl08U+8qWrYnTbnFEvPO5
 lwojb07TdOxLqu84IGkN0ykDPlMYtbo1tacgw+9PN6VIZWYLITkCjLszlzSu3NrXf6
 ZtmF+IFAhr7u4nncs0gNpmuai31yoGveGTlrHIxbEnClkbdJTzIxHaz0NC0hSKbwxH
 w5HuV28z3TigEUUmuLVcE6wSPRkmaNSGXQGN29ygbbSyYQVLcFq32SGu7mAQ3NOBVo
 j1IKf3Ed5fpE/1Ga4sWivOoYHZUy5IywGVyk9yJAlSuwjNAhDTeWc3ZahfrRYO8djN
 IaZghgJYeRkD3+d8jiC2mmLt3euEV2ihZEfx3cpiyE6lkCmQ4LroB0RcN/bP+HuTK6
 Z1EXPQc/zg5BiYZhtHIQROIM=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-472c330e555so803772f8f.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 23:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783233118; x=1783837918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c+Z+kHEatpMr6R7972l+oopM+nLUy5pDbXekO2DUjmU=;
 b=CZR2ASedAYUTKiDLbkzI4EzlmAiyudYdCKg7pnBoO8tQem1zRPuFpZZLS1qPD9Y6it
 VmZDxnE6+fSB+V/XdCfcH8o7Ec251+XOarKUz/41AggPW4U1hrYA1rxaOWJubtRuCLCZ
 5s3ApUrt1GQHivC9arcIC3WD0qcQmTEFrppzvNSaM0cUS8RGCO7J0bNSk4YDKfXCy3TO
 f+1jrimO35siYg111NfS8Agy18dLPEhQuy/DPhGxLpwdeZuP1jfNQc29iVoqasbZqzcY
 izgNG2QDxSU4mnH1F89/ZHdFjwZWXsq27NsA/ihVSM2ItfmCyZ89lPrSj7SbPNPwLjyl
 hYFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzaovIjbiwmJDnOaTgaxFqa2YPLkLHoXYzBuNXGN+0o0qSZlOOTjT1kl1K7ft+Jjmf969gtwufuhot@nongnu.org
X-Gm-Message-State: AOJu0Yy8r0XUKZyLO54FXh3uHcCNMgn5fp5Euxrinl3pT+FF6SB3lrCx
 lAzcEGJEElzKlR9zovBmV3a2Tm84iBxnhuDi8WfJ1ViAuRIutWSmaNLYHi9NbuyrIb8fWzkwssl
 4TYl2jLnRrAlQ+81wdxjna5vtWaQtBQn74jnIU4mT4SWodCVrFJQdsD0WUUTBT4cMcSh7N2pZ
X-Gm-Gg: AfdE7cmk0ZiUKPoVmnojL8E7tdcO5I5k0z/EgDCcXmgAb+4hE4DekkRCxrc0E8hglEq
 HqAtEU7FvXZx+eoCzxcVpapLKJcMPqZHFiL43SVLEIt3Fg+U4q1HDJULv0KRjTjvSfDaImAfwPB
 EM89MQewSII8WUm/ubSAG1uFn9qAyUMO/8FmVXp5bjPRGi4cf+7G8EbxIYaKBIXDLxfg7g4GAar
 5YXqaTPLTL4P3GfzYDhiVfDxdsQhkd3PkfECDcjnY0O9L80NM8Dpxk4JpvREvCfECup8alnnHv1
 N2mjXpIl0DJ1bYCsTyPZHrUntah3m9uSlZPmULAnz32IkrGNm2sgqlLfDZ37lKG9P4bmp4rJa9d
 lTEBvl8Pg7vU15Dz6+2Zq+qDyOOttLol75fMt23NzxVAYbyUJuXgSbj+7iJpcJZYerA==
X-Received: by 2002:adf:f9c5:0:b0:475:f100:3605 with SMTP id
 ffacd0b85a97d-47aabe31110mr5210758f8f.52.1783233118657; 
 Sat, 04 Jul 2026 23:31:58 -0700 (PDT)
X-Received: by 2002:adf:f9c5:0:b0:475:f100:3605 with SMTP id
 ffacd0b85a97d-47aabe31110mr5210743f8f.52.1783233118357; 
 Sat, 04 Jul 2026 23:31:58 -0700 (PDT)
Received: from workstation5 ([2a02:3035:683:e876:a486:6b9b:f6eb:790f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm14293266f8f.26.2026.07.04.23.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:31:57 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v5 3/3] tests: update SPCR loongarch64 and riscv64 test data
Date: Sun,  5 Jul 2026 08:31:47 +0200
Message-ID: <20260705063147.199732-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On LoongArch and RISC-V the SPCR test data contained:

    Terminal Type : 00
    Language : 03

The corrected values are:

    Terminal Type : 03
    Language : 00

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

The ACPI table data was rebuilt with
tests/data/acpi/rebuild-expected-aml.sh.

Remove SPCR expections from tests/qtest/bios-tables-test-allowed-diff.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v5:
	Undo bios-tables-test-allowed-diff.h changes
v4:
	Reproduce the test data changes using rebuild-expected-aml.sh
	creating the same diff as v3 but in two separate patches.
v3:
	Update test data
	https://lore.kernel.org/qemu-devel/20260618124020.640794-1-heinrich.schuchardt@canonical.com/
---
 tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

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

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2c7086d9de..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/SPCR",
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.53.0


