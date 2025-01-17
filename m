Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E75C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLO-0004iB-5T; Fri, 17 Jan 2025 00:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLM-0004h3-Bs
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLK-0005vy-Pa
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21636268e43so39483125ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093389; x=1737698189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dd2Kc7PIJ7W/euC/t6aymQpi5oLNSFstO6Tm9FVxVI=;
 b=C8qV873KZDSYfeDgJkhYbfsum4/1R9gPFv26xbtmReeyRYvKDi3qSMJk9enn42AFyb
 53spRYK6yT487iicYL/dVXThvQYV3+bGEI3MDPbZa4xwf/E7WSZyP4np/qipL6SHGY/g
 mOBnJLWdeNYUud2r1Mwb0gff7C5yib3H7ciYnGrXgE8wag5iKGjeX5r8ueUXmQTXDOF/
 cuxYO1JxmJJwsF02+0q/CmOKGVC6YttrO15QzHMfgr7BExWnUomgoqxZmtJCDLPZVk8b
 V7nsg2ghgi8BaVfRISoBNT1HAINct+CWlN5vqmDzht5hxkVrvV0LjJkp/iC/PFKPnxu3
 VSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093389; x=1737698189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dd2Kc7PIJ7W/euC/t6aymQpi5oLNSFstO6Tm9FVxVI=;
 b=dvkMIGNv9xSpS07HLup3Q7FkokBfRSqmw+rkhxx0rAE8Y9N9MKlGFAvlZfnoA+e5Tt
 7Uibr1xdfAakmCNYlD+FLiQrNzitAIKrPsXEqYXWJeuN18meTnlblbZISfxliq9LyDsz
 cMaMPP79m6yBAw6woP+IeghCX/20ZbZ0wSYIK0Pzts1oxYKsASiISQKM8S0eRv+8qiJG
 T43wAsZYKJSKHdULzo4/03tvGrORGioorIjG/9PE2lKqtP0D+D7+uw1U/c3vmM4oVmLg
 YJvC3EdwSUcFMEVjhGesUO3IyawYER6K3i7/BbxSpxrg3Cm7noOqGjrY6UMJKyHKUfcn
 BqJA==
X-Gm-Message-State: AOJu0YxMH+lVSkZxTBg5mD7xwXOIP93/PIj0vCGLbj/peLdtwVL7gS6C
 41N+xVpMUzsquWsiZAJ3KFE4uVHNIvzzqtGGvTSrkY5DZq60JBPj9VILsA==
X-Gm-Gg: ASbGncuvn7lmdDeer3RZ1OqJ4nozWIY2UYVj1daNPtIgW3q6CM9Mx8z+QxJjh6FbD/S
 knWyZ2hTGMGR671EZkP1o+opH8tDU3rrVMqGSsPkfH/kzbPaipL67bkJw+S5AzVhGO4A2mftR3L
 Fwotr/beEIs+ZoP+mHSz1PUI0TkTZB1WGilJRKUn/xRmNTClnIq0EWC2fMW1Z65I14MsyTVxi5I
 tfRuf2fd+tV2CIrTZb3IBb2dX+muvTKLKWxEkqrKElWecSjh+04KHTFuAoSKkNG1v/upbG3U+xN
 QLDgA72ySI4UrtVdtt5+wapKrpYzl+fcfFX7n5EdMUhfNKWN4eHEws8kJfm2
X-Google-Smtp-Source: AGHT+IHzhPlcfoPxnMz6jvo0mlM5BtNYEc6cg+YhUsGL4lz/m7fHzZW0iOL/g+RhLR0uYTKQMjomtg==
X-Received: by 2002:a17:902:d481:b0:21b:d105:26c9 with SMTP id
 d9443c01a7336-21c3550f10fmr25413595ad.18.1737093388671; 
 Thu, 16 Jan 2025 21:56:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/50] target/riscv: add shvsatpa
Date: Fri, 17 Jan 2025 15:55:10 +1000
Message-ID: <20250117055552.108376-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shvsatpa is defined in RVA22 as:

"All translation modes supported in satp must be supported in vsatp."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 374 -> 382 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 20cbb6b2f4..2f58eeb689 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,6 +185,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 2c7dc6c9ab..fcd9c95a6a 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.47.1


