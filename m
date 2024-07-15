Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21FCC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPF8-0005gY-Nx; Mon, 15 Jul 2024 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPF6-0005dQ-Kz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPEr-0007JV-SB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:12:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70b04cb28acso3593588b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721063508; x=1721668308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaZ8kohlacrwgSAZfsaoX707cOD/zF89IUM4ZLVsfAE=;
 b=gCPV/0zaaD5RmIgDXda5YRcG3ZE9li9+4ozGLpDnm0eoJgY5GGp98xGUuhayAKl06i
 gAAo+MMCGwDussZ7qtaNn4D+FKnKAN2Aq7I1q1706a0N6XvmDa53zO7+J5uusx5QTFjo
 dShYzfn/cM6QVFki53zPulIDw7vCD4skTmouCYY5co81L//zHJormedk++RGa6YWRn1T
 r3W4ZPjeNloFPICxEdVBvd43ZI1iDLiXg8IZr2CA6BFBlgrWx7F8zBaw9kJFlBzA5Iqo
 6rhERnzIVZZ8u/3NegUFMTkfG3a2oCRlcg6SxnjYDAvWxG3UBkz7J2i/05qh9/4rvyqV
 KfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721063508; x=1721668308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaZ8kohlacrwgSAZfsaoX707cOD/zF89IUM4ZLVsfAE=;
 b=PGlY35dCnUx9C6UWkUZ44N2s9xY5f2m2bqkb3P+GLxghlz0Ej2v7MUDJTwtKq66WgH
 QGfRz7Q+y0FnS/RCAh2TRf94E0Mf5JyBTUOiDnix6qvib5EIdr1EELhYuZZgGh//17WX
 FUR67XGZyA0XYa5CSHGThYXCFoIQBy6tul+iwklixNf5ZxX+XULqb0eJdSKHK+bkXOj4
 2px9+2a60+uGc80pauWSz3Mz2ZaeES8TQoJcUqyd90KrGirMuBzulbHM8NapTz7K0EZf
 vYO2+j06YTLUJ6zlTV3CiTPqFqjfBUDPk9xVQMxInrcPZIPu02a/Q/biaKnZ0HIQgBel
 jHaw==
X-Gm-Message-State: AOJu0Yw8BxX/L63y+efz82+rxq4lhRD/6sKAljfCOSG4OfOZyQd6hxFV
 aL3MIwF0ypPIpeTRw5IicpGlTXzguOUgYAB0bla7alLaXu2+kP2Mzf/+P9wimctGwXnuk554gR+
 5akM=
X-Google-Smtp-Source: AGHT+IHHZ5pIPosviKtPkyQEif/hMdfbEGRFuJs37YGdo10nEtGhSuQiBUcNsFL3MFTMipLEiC0hCA==
X-Received: by 2002:a05:6a00:928e:b0:706:5b39:2b18 with SMTP id
 d2e1a72fcca58-70b6c928f6fmr21008318b3a.11.1721063507636; 
 Mon, 15 Jul 2024 10:11:47 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca85ccsm4752618b3a.178.2024.07.15.10.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:11:46 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 3/9] tests/acpi: Allow DSDT acpi table changes for aarch64
Date: Mon, 15 Jul 2024 22:41:23 +0530
Message-ID: <20240715171129.1168896-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

so that CI tests don't fail when those ACPI tables are updated in the
next patch. This is as per the documentation in bios-tables-tests.c.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9282ea0fb2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


