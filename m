Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF2CC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPB-0005gp-UG; Thu, 15 Feb 2024 17:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPB-0005gd-0P
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:33 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakP9-00065D-A7
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:32 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso12362925ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036829; x=1708641629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2nCob8e/9MrOFcmg40CV49q7uI9/BynfYgCCukIYUA=;
 b=Kim9+sthSJR06vc3zSoVq98sqmdVg0VVXXsJPeVqoaStr5tuP3Zr2Xdxqq+xgy1EwF
 LiI5szZEB6aagcLJvfmoW7/dgTWUpg4rWX9d/CtumOd+4AgOde4p6H3NIkjSyIdXhOY9
 UBx2DAVD8j7nui+RodocJzBoL4lQHj2B8oVptXxsAm3a05OAb+eqFCYWSZwiVHto1+1A
 Jlg4g6u/RDTa2nC2+wLBGTRtMCvR1VvMOZhU4e5/xxydC+6DqWZwqSroGZip4aMBxJbZ
 BrdNZYKDKnj5x8O1ZJP9/rVT6Wuj91i1M4enxEJRmTN0fbCyMGpNGcyuLD4uAAtboCmM
 pn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036829; x=1708641629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2nCob8e/9MrOFcmg40CV49q7uI9/BynfYgCCukIYUA=;
 b=wSgaXbNIPVueLDA3U+ir4sKlwQ3cp+MDO1IbKEmWRnhscHqPo7L7gRj467ZOR+GEpZ
 JGw73DVX+pvHA0/ovCG23kBeIVeDJtRQ9hWZpcvE44KFSO1nlnZeQ23A6qWQ1hmVkw21
 oSHJVstHKVkVDpaEU3Q3ZvoxXjt6MCdVSDJ50cH6QXrTtgEtcPCGg9DokEdmlPskD9sw
 BIZHh4lkGEBZM37OmpGwse98rb3YgRNamVSLjGhBx4DcHq2LOlDj9bhH18flVHB4wew9
 jUiC6dx3oPF8W97RSDls8MaXr5YhXYdrW9UcdIMZr9zsOnwgTg7pbEZ4n+EdM29rv5VW
 /d9g==
X-Gm-Message-State: AOJu0Ywc/bDNJ1UdEi6j6WA3m3kFvexWPQkoafsl9+9MrX6agHjgSD81
 Ew1chq6RuwxVjsA1s6BMLgUrlUOt+RCMSeM5QsCLUcEuioPYfuOG3DsG1e4jqvkFZGedKw6zCJk
 t
X-Google-Smtp-Source: AGHT+IEnCYazQ8KlkmqqjJQ3FCbFoiCNy17z4ZTbct4hW7Boeopm8BdXKvTrxdbhWKTClDAhJU4ZHw==
X-Received: by 2002:a17:902:7ed0:b0:1d9:a4bb:29f2 with SMTP id
 p16-20020a1709027ed000b001d9a4bb29f2mr2462100plb.46.1708036829017; 
 Thu, 15 Feb 2024 14:40:29 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:28 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 1/6] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
Date: Thu, 15 Feb 2024 19:39:50 -0300
Message-ID: <20240215223955.969568-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Recent changes in options handling removed the 'mmu' default the bare
CPUs had, meaning that we must enable 'mmu' by hand when using the
rva22s64 profile CPU.

Given that this profile is setting a satp mode, it already implies that
we need a 'mmu'. Enable the 'mmu' in this case.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dd5228c288..ee4c349972 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1075,6 +1075,7 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
 #ifndef CONFIG_USER_ONLY
     if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+        object_property_set_bool(obj, "mmu", true, NULL);
         const char *satp_prop = satp_mode_str(profile->satp_mode,
                                               riscv_cpu_is_32bit(cpu));
         object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-- 
2.43.0


