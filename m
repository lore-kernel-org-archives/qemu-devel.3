Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5A9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1a-00007h-TK; Wed, 01 Jul 2026 06:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1Z-0008W0-5J
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:33 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1X-0004Ut-KH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:32 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso823523c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901110; x=1783505910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soYI5TVeX+17aAz5qwaBIk49PPjVJULHAxp+r7Nze/s=;
 b=BrHk5wOMbYp4mwdZtOv7gKPUF/Agaq1vQ/g1dVYuO9Ga61eoXW9CSd4ziOwUz3/ENj
 H82VhLn9ZD6m42mh9Xz4f5pDXilWT+pv9+5MuZiTQxVmWUAHuCILS5Ts/bZe04d/LKm5
 XdJvXEWggJ1Ugx+p4CZTjq/QAFK5L9fK9qSbUPjXZAaf15EUdiUS2AzBqRjYVoCV1rGq
 Q6MJBSCXjTCUeAiZ2kspdGuyklq4rjAunLL57/dF0BLCKFQ+LScSbfzyQCzD0wjK8tPi
 EotHQOA7FEIG1uMHIk0LlaiiU58PQpi/QqVPv4YDyZxYOmhquIx3g6CBqAvNpQ1BMXWI
 oaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901110; x=1783505910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=soYI5TVeX+17aAz5qwaBIk49PPjVJULHAxp+r7Nze/s=;
 b=WGKgAJEJ3mO8d4hZ+81yW1FuHUDoW3s6LCmDJCxajpQT5HM8eZKBxzNhjb1OI43koR
 y+juJyZmaFbGtC+12EMCG12f7XR/ZNhvE/KyM9cmD4XOgRjCKkAVxZzenHjPhTet7bbU
 seVTSRMh/lOY/LCCHPdHo21UnjvOctiu9uj92XXTQ+kKgXiElMuwcCSpEKTewJdDKFFQ
 +B/8eWHkxRvd3aKfEdug6Qkatoq7XQYYZoIWuHfdAxzqCjKlvqebOewxXTFNpyJraFTg
 8zifmr7+/edhxLMih/8CC2u0mbOqj700MOpHvOwrBKEhqV7prX1u+DkkjWTNRrPBxoVC
 zr5g==
X-Gm-Message-State: AOJu0YzFFtj5dY8kIjeAf+yGAqsv4ODhLiT7NuKB7m6SApx7LveO662J
 zD/RviRqF1NVyY2a0Zp8rZjHChZNyMz9PALJpBvGBYNCGb0tX/jPXPgL/CQRNA==
X-Gm-Gg: AfdE7cnHuEII6aWQBLtO7ymsdOc/Sp6LBPk8Op5ADzUYCioN5gy+8hrX14oVhp7iGBa
 fqoukiKhl2T0nXXf4q+xWCVsPGVR6BvuFVXuDFLGcdxw4Mm4vUgJq/woA5u3uIZLwebeVrjoqu2
 ANXQKsHBsFEgpzof8KTnJZHg6AmkM2MAyxlY5Smrvb95tAHxsjcdSZjTTyfaUGRTPFfFMWbqKc+
 wP+LkaGY4GjTAUP5+WPC7Q9WprgcibL/eBYPIAazD2Ty3uiO3aKz90hEQ68GDVso6bNwAfA6O0s
 M4pRtHPnieccrZU1f2z52oNa7tAP6S6LJXKULvRQ3/mb8jYKtWkBDvdS7EbuM6l1OMafqqdPe/v
 yGSjZNBry41QWNR0oYNEWkFRMzjrleZVYDUu+NkeWtIL12wam4GzBFitQYWYM3ubQC7dBXhf9sV
 lVoQA5NiQDRLze02a+i3ZNeOyTcXAR0Lw=
X-Received: by 2002:a05:7022:f90:b0:139:fb1a:7717 with SMTP id
 a92af1059eb24-13b36e2c80bmr1082773c88.47.1782901110139; 
 Wed, 01 Jul 2026 03:18:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/39] target/riscv/cpu.c: add 'svbare' satp-mode
Date: Wed,  1 Jul 2026 20:17:20 +1000
Message-ID: <20260701101752.2522962-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122b.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Seems like we forgot to add a flag to set satp-mode=bare.  What we're
doing instead is to set the CPU default satp-mode to 'off' to set it to
bare ... assuming we know the default satp-mode.  Otherwise one needs to
do -cpu X,sv39=off,sv48=off,sv57=off,sv64=off to get a bare-mode CPU.

Add a flag to make this process easier.  The name choice is based on the
fact that I didn't find many references to 'mbare' in RISC-V docs, but
'svbare' is a flag name that toolchain uses to set satp-mode=bare.
Might as well use the same name to help with cross project compat.

After this patch:

$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb -cpu rv64
$ dtc -I dtb -O dts fdt.dtb  | grep mmu-type
                        mmu-type = "riscv,sv57";
$ ./build/qemu-system-riscv64 -M virt,dumpdtb=fdt.dtb -cpu rv64,svbare=on
$ dtc -I dtb -O dts fdt.dtb  | grep mmu-type
                        mmu-type = "riscv,none";

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260611162223.2361941-2-daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e16608bbbe..bff3ed5de1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -418,7 +418,7 @@ int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 #ifndef CONFIG_USER_ONLY
 static uint8_t satp_mode_from_str(const char *satp_mode_str)
 {
-    if (!strncmp(satp_mode_str, "mbare", 5)) {
+    if (!strncmp(satp_mode_str, "svbare", 6)) {
         return VM_1_10_MBARE;
     }
 
@@ -1063,6 +1063,9 @@ void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
+    object_property_add(obj, "svbare", "bool", cpu_riscv_get_satp,
+                        cpu_riscv_set_satp, NULL, &cpu->satp_modes);
+
     if (cpu->env.misa_mxl == MXL_RV32) {
         object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-- 
2.54.0


