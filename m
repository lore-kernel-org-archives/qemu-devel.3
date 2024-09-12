Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5F3EEE270
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotd0-0004RB-1k; Thu, 12 Sep 2024 19:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotcx-0004I4-2n
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotcu-00087J-IF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71790ed8c2dso1292810b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185207; x=1726790007;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKWLA1wBspGoBsf/BOw/3kLwYELdIQ/tonPN4Kip9A0=;
 b=DGBm++ysgUfQZOIIHOE94XJJ6OcPANrKj0Q328OfJz/pPMmaqyEtHSuW7zKWScYkgw
 ohQKnsRJC04kMPEh6GgsVFICta/CXlLvxrtshwXdfGerfuHWIKh4h0d719NlCElkSnbU
 AlgvMDUR3eJ878UG01WWub2FwVoLbyb1TJE+nyBR8mNINpmwjuONh/bZieErARW4Bew+
 MkC/w0dPaHkjZWF1zJ7+rrGriebMyh6Gorbk4tdWcr8IkhOCG4psYWeB0ufdXW5KP8CO
 iWyuWYegW7aAh+xdyUJ7dC5qfd2TZSVgAxfszDE7uJ7HHsPtKa75yWgzmSK8OCaAdzlU
 wYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185207; x=1726790007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tKWLA1wBspGoBsf/BOw/3kLwYELdIQ/tonPN4Kip9A0=;
 b=ibN88AEW1b+w2BcORVEc8qKWPxDrvaGO89rJC95+hBwGc9aZRc0BYBYw9vvXta/HDP
 7CVtjxpansV+yWcfqwdhx8Yq2V0RoveLhCAVR/fgQ+c2F7IDepJbATExslnWosW0Oex9
 iyFkFr8TFbRoMIBiFQ4cHNKy8zPHuQozVl1uoL4NnSHHSGRB1ldcLOTkGHtF5XUX+j6k
 8/PtHd2B5a1eb0KiKJH/ozE5NH6UpCtzrCZeYXhGHxZgKi3/YB+DVlhTAXIYe2gI4Few
 zfuYnI9GjqgrmPOJwa7qhpfJQx3FzI3LeiImYzbNMnj+95GTQty18vEKx4+7Movim4OE
 HVKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ8kTt8Vjp//2vkQ7J6kXXLhHjMqwFKT9Z59oPj9ykKLFPOajt4cvWXX+qX61vPhl+08AuXV3DKYsW@nongnu.org
X-Gm-Message-State: AOJu0YypBWGudX79PhRztc2aVg0xX0ziE6CKKVwPazflxDL5eUss8Lxw
 yvRM9YXxWdVHhaY6P7mB+lOV7/nW8Scjic2KlkEDcCJkbmGKS/v7d4zJjX/2vXE=
X-Google-Smtp-Source: AGHT+IEVUalst5W/Wq6nXcIIJ0xljO++bMS938YDzA4jtCb2dP+VrT1vs7pHuy7UWPwRAX4ZvZhDXw==
X-Received: by 2002:a05:6a00:14d0:b0:717:9768:a4ed with SMTP id
 d2e1a72fcca58-7192609318dmr7903494b3a.16.1726185206997; 
 Thu, 12 Sep 2024 16:53:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:26 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 02/20] target/riscv: Add zicfilp extension
Date: Thu, 12 Sep 2024 16:53:02 -0700
Message-ID: <20240912235320.3768582-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

zicfilp [1] riscv cpu extension enables forward control flow integrity.
If enabled, all indirect calls must land on a landing pad instruction.

This patch sets up space for zicfilp extension in cpuconfig. zicfilp
is dependend on zicsr.

[1] - https://github.com/riscv/riscv-cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 1 +
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/tcg/tcg-cpu.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3538c2ae2e..ed2d8a90da 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -106,6 +106,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_zicsr),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 355afedfd3..fe7ad85b66 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -67,6 +67,7 @@ struct RISCVCPUConfig {
     bool ext_zicbom;
     bool ext_zicbop;
     bool ext_zicboz;
+    bool ext_zicfilp;
     bool ext_zicond;
     bool ext_zihintntl;
     bool ext_zihintpause;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index dea8ab7a43..963c1c604a 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -623,6 +623,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->pmu_avail_ctrs = 0;
     }
 
+    if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
+        error_setg(errp, "zicfilp extension requires zicsr extension");
+        return;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.
-- 
2.45.0


