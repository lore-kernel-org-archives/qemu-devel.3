Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587D9C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKrP-0000jZ-S0; Sun, 09 Mar 2025 13:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKr2-0000Gj-Om
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKr1-00053t-6o
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f403edb4eso1848102f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542861; x=1742147661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lcTIwAjoTMB8eVBQGCbaNsn82UFv7iyVqN5YJu8k8FE=;
 b=xE3hFTP3avrI8pEAVGd7vL+EiYpFKogjGPej+tJHUWpAf/UmxnDgp7E3q2juG7LXGB
 NC4Tk8HSqc4UkYVu2MtKmuO+NHMDyqWpsx0+1jQSslHRQRNPH6fUi8gB8w6UqNqZpJrp
 A6Mybc3U7EFeUc4ww3K2fmqWy7OwONSxWFZ33kkdinOnl2ctiTbUCe1AtEsNCK58Layl
 mfhuxlG9eYxvLmG1HxZmgbo2HNV6dUPpBO0MCx391WOGHlsxl0lScG4sZIdIcSDycYlN
 JMYfuBugG7QlootbaylGHbcit5ryyvUMpn7vr/ebTdLOSjoNOyZONzqgDtx5P4izXL5w
 ZaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542861; x=1742147661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcTIwAjoTMB8eVBQGCbaNsn82UFv7iyVqN5YJu8k8FE=;
 b=VBpuE1XE4LEwnrKXI1xMCHY+IrEXmF+AIZRwBHkTvFB+JW1ImZHG3UyiFqYbEk4L1I
 zIwlFFCpC3xyvjIc3VrhSqGU0OT86YgzRqYiCwwqnEsr+tCcCN3rRfi5l41QlfKnHe5Z
 GCeIbquGUJfMAimzsvK3wv8rVUKHL65fqCDaBIb70eoxbcGmB6VLcHqhgjedY5t/QbHv
 LJfsyARFc/DEPAD0kmfzF0cOv6R62bnI7ifwPZm3oUnkF0d/9s+YTqr/iN5UWq+yiOuF
 RRXeCYyksOONnGhk9GNbm1VZH42njDRFhhQYZXctGDFp/jrnizgjuJ2TddP68Xvt+lCp
 2/rw==
X-Gm-Message-State: AOJu0YxhmhTTxgJaqt2PKNRYYAWoIhRjVeZHcWi/YndHzVP+KnvFSB4N
 iB2IpaWSGJzBLmKCj7wobx3HQ9AutSfGVsZVK1lVzp/qx3+H1Vir7JZFkCel5zAiqEMcM9GY5gO
 zidY=
X-Gm-Gg: ASbGncs5Af8GEpNALDBdBzDaquhA3LW1QmU3oGKWKCyS8gX0Um9p0cwoxpM+3ag5z/V
 IpGqLec5ul4WkE/O/PWFWa5WTeBaNhJDI9VQQBCh+jCp635IhlZV5LomPJkCcHDiwD7A4PMVmY6
 OFQ1uyBv326tppBu38XUL96Nc4gHzKUl6/NIcNLdsC5b+LcFKBso52bUYj0vkKyROqqvJTpZcsw
 h+MrmqlRQ+XxRPwESwuQEFhV8k/HLAYBS1bkyTHey4Xn29Rk7DIm67Nv04BU96RVzdOo9bf3mFM
 G5DizjmFtfJAbwKpOcpiYeDTyyOyHV/CPRAtkDQu1Zbchr+xJaQxKZ26w3qcxkyEB0zfCZSPT5c
 piMltT1PXqGdeo/nLmLg=
X-Google-Smtp-Source: AGHT+IHBqqVIuCK8fW3BE0WMwv8XAzfRk00o0pEuIpitktdpYJ5QJ+6dTfNJgYg9MujF52wBbZ2SCg==
X-Received: by 2002:a05:6000:18a3:b0:391:2f2f:836 with SMTP id
 ffacd0b85a97d-39132d334a0mr6220101f8f.17.1741542861367; 
 Sun, 09 Mar 2025 10:54:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01567fsm12236402f8f.41.2025.03.09.10.54.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/38] target/ppc: Move has_work() from CPUClass to SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:57 +0100
Message-ID: <20250309175207.43828-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-16-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b9772c53ecc..1780cabfc6a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7177,10 +7177,12 @@ static void ppc_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool ppc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -7423,6 +7425,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
+    .has_work = ppc_cpu_has_work,
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
@@ -7474,7 +7477,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


