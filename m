Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2903CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 16:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD2MS-0006Jm-Vz; Sat, 03 Oct 2026 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xD2MC-0006F5-G9; Sat, 03 Oct 2026 12:13:08 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xD2M8-0005nS-Qx; Sat, 03 Oct 2026 12:13:03 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 2C2CE242D2;
 Sat, 03 Oct 2026 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1791043976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Vg2eFyEfr9E0uLjDSKUIsSk2zmZA6i9+RlkDVvZPK0=;
 b=aeJVX7IrCy4sAuBeuLoN/9l9Td/mmV/HWNbjRp7qM1H5bKr3pngQTa5SVtFhxIskZ4SvuT
 EhbF1Od0polrQAz5wEUsp2xmQF3Z3tSeAstHE2a48tgUFhh3GFWHvSQSQtm34JitDQ95HJ
 6H/2zUzYyo8bEasv/tt54Pw6x6XdBd8r1JBI4t+lrvwGSCVDeVo3132nI1gJU3/YNrqntW
 OlGjkLcDyMI1IlQqKbANMILpsH94aSOCdtID6lHGgJfB1JfEy9aR/TUYcfy0Bo9IzHGVAo
 Xy3eENETyAbeoHXPWO9jFg2m62NMmuLf60BJjlaWNJ12HwxxnCVYTTtzK4dAKw==
Received: from ollopa-pc.thinking.duckdns.org (OPNsense.thinking.duckdns.org
 [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id 8DA8D1003;
 Sat, 03 Oct 2026 09:12:55 -0700 (PDT)
From: Rick Richard <rick@sloservers.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH 1/3] tests/qtest/bios-tables-test: Allow changes to riscv64
 virt SPCR
Date: Sat,  3 Oct 2026 09:12:46 -0700
Message-ID: <20261003161248.38903-2-rick@sloservers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003161248.38903-1-rick@sloservers.com>
References: <20261003161248.38903-1-rick@sloservers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Allow changes to the riscv64 virt board SPCR -- we are going to fix
an error in the UART description there.

Signed-off-by: Rick Richard <rick@sloservers.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c..aae97304 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.43.0


