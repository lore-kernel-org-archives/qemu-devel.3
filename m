Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF2C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLG-0004g1-NE; Fri, 17 Jan 2025 00:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLF-0004fr-BF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLE-0005vD-0R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:25 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21634338cfdso42880625ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093382; x=1737698182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw0F5NxVLxmv0lhVgXxeNw8ye8aJQjxMkOILJxaJ8Cc=;
 b=CL4yJ8kJqi7H0sJE0nQ04fe4MsmW9l58Yu1eAuHCGDWgCzE1sS/7SUjaKEMcVlGb8b
 PziEXofX8d0qpYc0INfDq67lkgyOWA71aQVVxRjnKGYX+A0H4NtCppoD/p0Wx/m0q50s
 x1F/M+nQM3BycnKlOQDKlLqegba+i91yypKgfjZ2Mf8B3vm3v5Rhg8O7IZArSv0ZZz32
 djetKa4J+dVsw98DpbGEizPsFCPC+iiGibAnN6HRuNBYBtqRHpMFr8imCDGrVdslRbsB
 g0dIQSeoBIMTcYZs/a/OyBPEKwaLnycIHlRlZRMIP1w0sucmK7f9ZPKQtEajErbW9/qG
 3UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093382; x=1737698182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aw0F5NxVLxmv0lhVgXxeNw8ye8aJQjxMkOILJxaJ8Cc=;
 b=dMvpowEi5ml5AHK26PPwRvecsWiw1XOrQnqV/V3/pvuVRTk8AsS45KHZ4RiJBRbKuW
 XwMMrgMzf1zIsFNxbCAQYoZZqaKGkQRrBTCVVVayb3x7ki0Your1Nhf1ISTgiNgtXBD+
 V5/ZVAHGbh98AN4dS9TuPCxhK0O1FXvvn6ew2eFbZC0Ovwe4xcLEjsFTZMPYSj5xl7CW
 wjZP93bjJIjYnx+f5JdxoGkJs1OCSxNwfa20+zt5IIzdCmJKo0s9uCTw5ydx6emRETOq
 e8pFtoQu4w7HW78NBVU6MEa0k5cBoUt/c4j0FFa2ozVuvbjPdOQ7l3l3IvyX+D0x1nUW
 017Q==
X-Gm-Message-State: AOJu0YzG0NnIiPNeZH+8jw5Z/u3qgfYDzXDKFxSOoXLUfbzeytrHs08n
 9i9bi/zvP0SDipIaG8SyAS9kPSMgAzLvTGB5mWrycxjSCJYOIuAtjn4KbA==
X-Gm-Gg: ASbGncuIbD539bTdM85V6Z2GeQF+k4st7KdjS5SkgSVHsRIUiIp+KGIBd6ZHM3xeJO2
 BdD5VZgmpIvvlCsxnxTSgDh8Uj56AXtSpDV4dMBhWkCRtdvnwA1ElGEPpgL28ggjv7n8QfWNO05
 8QY2Zz81p3N4SvIVpU5Z3oNwAdhUckJAenPlzcwn7Vo8MUyCbKtqNHKPxlkJfxX9+rfPYKVgmvg
 Nyz7Q+VxT4JlEH/JdomSCGxVuuwu7VwwRk1PLH9lisZyPmioFYoG3967h2c2A+IPx1fx04PVy5e
 qEJD7gnA3A3JEqWMZK/KIlz5Ga+5Cg2OYPYBYKbHSRxEjtDZIGW9JkFdZJnR
X-Google-Smtp-Source: AGHT+IG0sNTywKcnSaolNQf1re735uXhVTCgQs9cx+ce6WDq5D1qmYPt1HZ4h5TUsjfhFZwStSDBMA==
X-Received: by 2002:a17:902:e746:b0:215:97c5:52b4 with SMTP id
 d9443c01a7336-21c35631dd4mr20540135ad.39.1737093382572; 
 Thu, 16 Jan 2025 21:56:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/50] target/riscv: add shtvala
Date: Fri, 17 Jan 2025 15:55:08 +1000
Message-ID: <20250117055552.108376-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

shtvala is described in RVA22 as:

"htval must be written with the faulting guest physical address
in all circumstances permitted by the ISA."

This is the case since commit 3067553993, so claim support for shtvala.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 356 -> 364 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4f76efc298..fe5f7b572f 100644
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
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 15b82b5bb1..065f894010 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.47.1


