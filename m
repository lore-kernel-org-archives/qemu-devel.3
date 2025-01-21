Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA11C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFBY-0001Tr-KC; Tue, 21 Jan 2025 09:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBW-0001PD-VW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:55 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFBU-0003Ez-GO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4054112f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469491; x=1738074291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lI4er/UZjcPYTUPzfGtiHhd0qjCJFKtyBNhq4e87GY=;
 b=esQgRAPD/FZMex6GAPmJvaypxjfKid92ezVM97BbSqipCH5GSoODeKHEZfrg76EH7c
 AAkRDUzb4ZC1T9TFyLkVu47S+3h/5szEU5IseAkE1e5xqnrYZQ2QRPZXv4ClI9BnUx12
 RZ01iURINdwZdpuBgU8aq1O9LZGPMV8We7C8wMEI3tx2abXTDsQ1K8uiBJzCb0dZo42w
 FNa6Rayf8cgi8zskhSbxjaM/ILsPF+h9WqKAKJhdAka+OVsnoX7GK7E5+eQrkSXTOVhK
 4XASeYMgKEZZgRwaDjm09ujeSC7+Xz4xXYZy8DqSbJTTytcackWMI3N7G/Z4uSdLTs5C
 YP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469491; x=1738074291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lI4er/UZjcPYTUPzfGtiHhd0qjCJFKtyBNhq4e87GY=;
 b=sFV6KFELp9rf+WuBRH3A6KnCH8F3ZbHP586C0UU6Hi68vJQcUhRo+uy2QsCs49q+mh
 31BFeeV61P7d2jxmVZb5YroVqzpqQ3Radz5Kg+u703MR/ZJ688vljqWDKyW7lkl8eSuW
 uZrFbLg+j2BqtrjLmu4Ywkm4AEKPol2KIDyMcmURWKkHAPsa6vmdPuDjJ8UcgIzygfSk
 O4KG7kmpEjJWce1d+eAmYw2sb+dphJcfVTeNmbwQ8Flw7MFAr5DyTb66buvVcQP9BbbI
 k19wB+3KVEBBH+e9UEgg8xmN6hDwjTnxYdSQAA1CmDbLxlDI88/62mr9emN1rD2gCjxm
 8pYQ==
X-Gm-Message-State: AOJu0Ywl83RFNfztvxWqkn0n7irCAeYUnm4u+3DvxZxc7vV0AvzARh+J
 T4alGlkwAWgK+ShJZPmPg8jHS7OvwB4AwFWSfzYCq3CsuPCH+C2Htwr8hB2Za5EM5rdfcj98HEt
 KenI=
X-Gm-Gg: ASbGncttSOx8u3KefPdy/II6RZg9ZBuDmwayl2TbiF5m/Aff35ONvuvvhbxKmEYjM42
 z2fJRQNENNU+WrqoLp3KD0X0/IQUI0TKMV1ZNMhmLf+MMEzfWy3G8sXlMgF6FvPiA6GNFMwsUaX
 v8659LLXiYBO1nD7LFXU6M34nuqjgjLJBks4qAV0Cw2J3V4c9RUSMIC6YXPvjSRbbOmh7n9FVPu
 P6r10XsShLp4DtbDmJ82yhAw+O+o5GEbVYElh0azZ7o4zLZygDVuc5kGsVh767Ac6RywosOuC/b
 YU9Alr2EinSE8KqP7KN3ux94WSyEo9s+dJZCcxsuDsuI
X-Google-Smtp-Source: AGHT+IH2AmG1H5wmqFP1XWCb9LXlLG+q0ojNMzegSUW2QTBvIadZuNV+Dfb/zpIvofwccr5fOG1SQw==
X-Received: by 2002:a05:6000:1849:b0:38a:8888:c0b6 with SMTP id
 ffacd0b85a97d-38bf57bfcf5mr18396110f8f.51.1737469490716; 
 Tue, 21 Jan 2025 06:24:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275501sm13812644f8f.65.2025.01.21.06.24.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/28] target/loongarch: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Tue, 21 Jan 2025 15:23:27 +0100
Message-ID: <20250121142341.17001-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d611a604704..20aba0e1fff 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -349,11 +349,9 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool loongarch_cpu_has_work(CPUState *cs)
 {
-#ifdef CONFIG_USER_ONLY
-    return true;
-#else
     bool has_work = false;
 
     if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -362,8 +360,8 @@ static bool loongarch_cpu_has_work(CPUState *cs)
     }
 
     return has_work;
-#endif
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -835,6 +833,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+    .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
 };
@@ -860,7 +859,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->has_work = loongarch_cpu_has_work;
     cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
-- 
2.47.1


