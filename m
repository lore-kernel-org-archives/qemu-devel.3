Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04275CDE010
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcyrS-0007rc-5t; Fri, 26 Jun 2026 01:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thecharlesjenkins@gmail.com>)
 id 1wcyrQ-0007rK-Tc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:12:16 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thecharlesjenkins@gmail.com>)
 id 1wcyrP-0001Dj-6z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:12:16 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-139b914bab6so896631c88.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782450733; x=1783055533; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MM1wiPMMziCXVDrO7BiWHDZXH2jQ6x6N7iE8gv9cdEY=;
 b=Ffy5H5/XqlMxbel0EYIAaOSdBSujXiaraf7T8bglmQmN6Cnm+6Ajxua5EKXDwTspKp
 i8E7UneSLPKsf0VlhJsbVBf/y325JR++RhOByvcEalbUbubizHhGwC5Fjptud/EC+VLL
 0m/JbEbXKlmxELTGA+9jVn7SIWIE8xPa8Gq1vAaBXrTsFLDXGbZtMJCGSrS8oHjUILhn
 3zWpYxZdBaEe2+Sjwa9wthl6783nrpkieMmbWtWtF8B0IbFYaGBoSELT6Cnf/QvQThph
 n3EEdErSCx1FphwGtAfG9IEuEd2FDSnTk/arB/o+hzk2lJtG1gx5/Soe6u+k1jHaRlx5
 J10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782450733; x=1783055533;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MM1wiPMMziCXVDrO7BiWHDZXH2jQ6x6N7iE8gv9cdEY=;
 b=oAa7jPTVPaZzjlFuoGiu4RmjaeAucdyrAycM92KLsEB5xE+bCQUOV2oAkiDExpjOVn
 169WxwubPPTHL4hDjB7nQAg2T2FGu7/bprFyoDTKBnBr9S3fdZFnzTAy2r08WabFTsCs
 LduKQXy9J53w8sfrd92ePygv1yLbsLEuHn8VEM9hhnr2c8NZbxMba/UBstmc7vRwTV15
 1ChY0UBFEzUvelYPIKOWdXhePl5lkwBdDq+Oz0YaemdCm5zVKGPdt5ehPjosjK8Xfx3+
 Z/wZ2HFUGNHUKaBnR3JPbtvtsAk9PoyEjG2sF9Tg3CrQhkkhCjheZ7poP+UJrnw3GTe1
 r0Gg==
X-Gm-Message-State: AOJu0YwZ650ZFNBLw53d+P1H+d960cOEc9IWdvfbKAgpuO5Jj6i68jbW
 INjb8054K+GSxb/acacMeiyHlWRiaAL/liqpfcT7LOmVO7Ip0vBVPf5N
X-Gm-Gg: AfdE7clQiIug84yqlbzu+5n+oQtbyv7gd3QFN0rkow6BVFfjeVFSfTasXn1hKSFVBDL
 FKTzas+Zz8R/mskFDmgqJmKeIoROcGgEifJwiDAxLBBtq+APSNo5PEgV2q/2AAJ7zu5k9wDcZA6
 7ptKBLjmXNr9ckd/juFeAbVylE1ARPivljJJKhTrUp9jKgvmzOUfvk3yDJ2TzAcfUNoTM3enM01
 cw50uXepuebFhex3lFraH8/NudJA1KYSnlS31Fms7b4ZpHeDQ239WCNToJWbCtoCtzp/E04aKLQ
 UE56Yn4/nV3xyvZwFwff7WqQxbXdGFwcNSYp/yytdigeXpgeRDIb9mtU0D+BRqOTua5cBwVtyBf
 8nlrid1AawokLROIMJcS+3t4i9e7PsnkV/fxcETFvV7LLdqQNqKLdr9lhnywsoczlQ0SpAEYQw2
 d7E3tNmXE=
X-Received: by 2002:a05:7022:611:b0:137:f001:fce2 with SMTP id
 a92af1059eb24-139dbbc564bmr5064493c88.33.1782450733356; 
 Thu, 25 Jun 2026 22:12:13 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::1947])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm13982430c88.6.2026.06.25.22.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 22:12:12 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Thu, 25 Jun 2026 22:12:02 -0700
Subject: [PATCH v2] target/riscv: Report QEMU CPU archid as 42
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-marchid-v2-1-3821c351028b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ7CIBQFr9L8tRhAU6gr72G6oEDLN7YYqETTc
 HehLl1OMm/eBtEGtBEuzQbBJozolwL80IB2apksQVMYOOUtbfmZzCpoh4ZIaphoBylORkKxn8G
 O+N5Lt/7H8TXcrV7rvBoO4+rDZ79KrHr/1cQII4qqUXSdoIKN12lW+DhqP0Ofc/4CicF837AAA
 AA=
X-Change-ID: 20260624-marchid-80d176b873d8
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782450732; l=3222;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=uZOfbuZy0m8/ljZTlYxED39bWhMad3LiJsjUokNTdLE=;
 b=zs+D21VtSLAZPVOkshjlHDPeWtbnS6dQl7B1ni3tbUiSd/kwy0QGvqWr4/oFQnhGYgi8R7Kel
 o801QcH+SaMBYgF3QkRbnZYhvPfq0nOaWVnZULze5CbhpgcxR4A0Ewe
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=thecharlesjenkins@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

When a non-vendor CPU is used, report the archid as 42 which has been
allocated for QEMU in the riscv isa manual [1]. This can help software
check if it is running in QEMU.

[1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
This series was original proposed by Palmer Dabbelt [1] with a follow up
by Daniel Henrique Barboza. This patch implement's Daniel's suggestion.

When booting with a non-vendor CPU such as with the qemu arg "-cpu rv64"
marchid will now be reported as 42.

> qemu-system-riscv64 ... -cpu rv64

processor       : 0
hart            : 0
isa             : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc
mmu             : sv57
mvendorid       : 0x0
marchid         : 0x2a
mimpid          : 0x0
hart isa        : rv64imafdch_zicbom_zicbop_zicboz_ziccrse_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zaamo_zalrsc_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu_svvptc

When booting with a vendor CPU like veyron-v1, the proper marchid will
still appear.

> qemu-system-riscv64 ... -cpu veyron-v1

processor       : 0
hart            : 0
isa             : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt
mmu             : sv48
mvendorid       : 0x61f
marchid         : 0x8000000000010000
mimpid          : 0x111
hart isa        : rv64imafdch_zicbom_zicboz_ziccrse_zicntr_zicsr_zifencei_zihpm_zaamo_zalrsc_zca_zcd_zba_zbb_zbc_zbs_smaia_smstateen_ssaia_sscofpmf_sstc_svinval_svnapot_svpbmt

[1] https://lore.kernel.org/all/20240131182430.20174-1-palmer@rivosinc.com/
---
Changes in v2:
- Added comment linking the spec allocating 42 to marchid
- Cleaned up the id setting
- Link to v1: https://lore.kernel.org/qemu-devel/20260624-marchid-v1-1-a0af7997071f@gmail.com
---
 target/riscv/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa497e5e8a..94946d335f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -47,6 +47,13 @@
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
                               RVC, RVS, RVU, RVH, RVG, RVB, 0};
+#define RISCV_CPU_MVENDORID 0
+#define RISCV_CPU_MIMPID 0
+/*
+ * marchid allocated for qemu:
+ * https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
+ */
+#define RISCV_CPU_MARCHID 42
 
 /*
  * From vector_helper.c
@@ -1183,6 +1190,10 @@ static void riscv_cpu_init(Object *obj)
         mcc->def->profile->enabled = true;
     }
 
+    cpu->cfg.mvendorid = RISCV_CPU_MVENDORID;
+    cpu->cfg.marchid = RISCV_CPU_MARCHID;
+    cpu->cfg.mimpid = RISCV_CPU_MIMPID;
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260624-marchid-80d176b873d8

Best regards,
--  
- Charlie


