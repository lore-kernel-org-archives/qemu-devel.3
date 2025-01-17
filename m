Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06483C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLK-0004gd-9w; Fri, 17 Jan 2025 00:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLJ-0004gP-03
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:29 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLH-0005vT-7G
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:28 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2156e078563so22179545ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093386; x=1737698186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEL++LTKUtraOSCcmSaWbpHdJdi25N6TVrF6VlE58sk=;
 b=IaLsaF6e5beTv2KMArNIm5tHFCDcIyf1NeZVySOQ1Aqrm+aP/hGvcCG1uykMBHktyL
 TZpOrAWgR9OLsZy+3MwEhysKJHhUPoY5qkBHzwLhdijN93nHx3fg0qitlg1p4KrynmYs
 3K85eb41CLb6KsEoueuDCiK45ka+ScpTRAy+vBqF2QSuXYaP/6TUTTYdos4Fq/qMhh3K
 Uc7hb4AvfVAI2XezY6ZyfUVtQmJYoYCFIM29chK+2S+AgoZcRQJrHwf213Sqjp+A4eTU
 mxUkU7wtllSKEs8v088Ehav7dnIYmrUXU0HsfyK0Jb1+wXeCyc/95uo8nMJsQdqmhLuf
 edmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093386; x=1737698186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEL++LTKUtraOSCcmSaWbpHdJdi25N6TVrF6VlE58sk=;
 b=lLP4ALF/fBOkiq9o3wmVtncBrS7a8wKOlMPvfafxaeKg7eGW9WQbxqK+YinDgB8EHG
 ojknK7a5vtczRXYpNnEBPYZbtLF0KERcZkaHDPlTOOFiUJ8AHXRRG5uxp59D6D80k/5V
 MZiPzb9YkVsxOr4HWwxlWmd0/XcZGYhOlzMtNl8uoaNZovrx6Fhu41W6JitbI4DtNRjG
 V+v3uQT8b4up6wvu7Dh3OOA+cWk0U6oASgQtJTeuXIrf6yB1fG2Jmxv6vxs0eDAT67Vw
 bz3v4r73QgPhyK4MMF3YiHCw89bWa4P8U9YTzpgAX6eaWZUXRPkbxqlmADHjU2Zsv+oD
 dDzQ==
X-Gm-Message-State: AOJu0Yxt1Opu8ufVKZX75BjHaM+axdiEUGrKN/7MGUuUWfg92J2d87uf
 ZdDi3qES+777zuFNG2bSxJVUU6BR3GlZ+hOchFrhOQgFvJDpD7Yq1QpHgQ==
X-Gm-Gg: ASbGncuICY2PVdJaIiyusu/kTqPgU3lz2gcypVOOywrqf/ScA1KLiguvcHQPQNx6q+L
 OnBo4lBc3JSPVZYfVyk6xAIOinA1R73tuGPGX3dG3KUZj+IE+Sg34IPgX7f/cm1RT4YC/9lenQq
 iqsD0ZAh/kFz4Kt6qbfzy+eiOeZgx8Kd53ULjY8Ai+ckKeqS10X+Cx3V4oofrlQzobXJFS/CMhG
 TGz4frKo5nIkB29o4VzJrH7zBJRt3nyzrpK5vhWsotAiRc8fTN6emZfX9GiToZ5KmWJKtI5WHa5
 Q/MvSe28NkYEXu3YZO0QAtJkA3AaMhsCzD5iF4CcD8+eFnGDLaTDjsTlnVb0
X-Google-Smtp-Source: AGHT+IHYqWqaHj7YxpbckSNBh6RmdhbnSmE2tsydlFXGZNtSqfjkKFC4yDHtqhxuXO3sdpNIoLBXdQ==
X-Received: by 2002:a17:902:d511:b0:215:75ca:6a0 with SMTP id
 d9443c01a7336-21c3555b09emr26344845ad.29.1737093385596; 
 Thu, 16 Jan 2025 21:56:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/50] target/riscv: add shvstvecd
Date: Fri, 17 Jan 2025 15:55:09 +1000
Message-ID: <20250117055552.108376-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

shvstvecd is defined in RVA22 as:

"vstvec.MODE must be capable of holding the value 0 (Direct).
When vstvec.MODE=Direct, vstvec.BASE must be capable of holding any
valid four-byte-aligned address."

This is always true for TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 364 -> 374 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe5f7b572f..20cbb6b2f4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 065f894010..2c7dc6c9ab 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.47.1


