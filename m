Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90349E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSG6-0001q3-FZ; Thu, 19 Dec 2024 20:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG2-0001bL-3W
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:50 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSG0-0004jZ-A4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:49 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so1287701b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659807; x=1735264607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oo9albpqZecO7rjAPj/A5+mIyg1TEhQK/19ldiN/n/Y=;
 b=EP8EWVoW829RagkfMec1OWAZh+lbHxcn1+zOhwMmgPHIswVYA1CZQvvpFvcTIgaTjY
 LBYV6ju3H6gp/9TEmC4l8CbQ/VEPpBoKTUPo8oXXLLo7mOdOXXVtPdI7NCyesP+ToW/g
 w2HInZzZ0WBMgXhmtopAFHVfnLIH0bscSLQiZ9RYjhBEV7gy+8WT2iIBcANWffg17upz
 f5xuQKezfaylV3uVjvW8Ir1rxmBL39VGSU6G2SxdertVp0DQG4UpphXsgCBxEVYvNmYa
 7BLrTg/v1sdKSxMk1IFuzH87ziLoFP6OpPCT199PklqYRiPkmkmVgh8Gm6UKPYS8wWDM
 utIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659807; x=1735264607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oo9albpqZecO7rjAPj/A5+mIyg1TEhQK/19ldiN/n/Y=;
 b=SR0dV0K63OavMJG1udAgPootGCOJroWlwvlomtyLDGbXnC04p12o8b0oATgGrvi2AG
 3aBAMRijRpipYyQQKOXcZXk2+c9i5JNgy+wF7z+nyoIjh5GY0Ss7AFeRIrMvbEje4jwY
 LS8c6ZW2k5+u5qRoJaPxstF4Zwduj9ogniNr/5GlXI77NEsDP6x3jJcbxlcWYwPBctod
 PTtQgWLD5JmpnSwym7zPvv39XkN3nxaRnJYa6+KBFjPGSO+LcWV/BblIfGaZRtaLzrLZ
 9xJVwHL7GtezAiJ1gfm5qFJvXYUhVpHsaa3Wy5pCU/MsCrJXechkYzUsxR4MeMULsQhT
 MDrA==
X-Gm-Message-State: AOJu0YxBSSXFxmO+57g2hBf3s7csNbe6kbst0p0KjM2r49HuaAVfG4YT
 al983ZNB4MsBVoKVdQ2VkFwfR7E558Y+pTI2X9uXu4bqPo4wvPBZBgD4+n+N
X-Gm-Gg: ASbGnct3IE4JacInXctHm8HQJTfkYDtTWUIb5n27/jlm4pGi0TbF4Xv+5Z5KIZX88Tf
 Azp3EFF1DLLc0XmmLVlniEkxasNWX4flGoS1W8zhzbzDfjHVREnT0VG6gneAPooNRmduTXEs30P
 qJcOxHf/K2xu+Gcte5a2329fvlR7w/9I4TgxZAzT4jJcC78w+YS7z8PCdDaTY7dUYCk8yI4GrBW
 8qrEXAw7HNGZTd708BaSktOTolXQnmZXp/TgauWjGQXL6Mvw/bPAA1sUfbBBZlJbCr/RKYIckrP
 CeFhiPKJTMSIzgLEeU3z/9/uHcPtVMOD+sOwTCstKx3Mwm1IEnWL+sS23dqaUa0=
X-Google-Smtp-Source: AGHT+IFSfnQk5P1jCoqHlCcSPmG3mNR9MoRZT2rYG4HLSSQEdrDF2wJ+M2B6RYulpBEtvQI69Puwzg==
X-Received: by 2002:a05:6a20:e68e:b0:1e1:becc:1c9c with SMTP id
 adf61e73a8af0-1e5e0802b15mr1826349637.28.1734659806583; 
 Thu, 19 Dec 2024 17:56:46 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 37/39] target/riscv/tcg: hide warn for named feats when
 disabling via priv_ver
Date: Fri, 20 Dec 2024 11:54:37 +1000
Message-ID: <20241220015441.317236-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

Commit 68c9e54bea handled a situation where a warning was being shown
when using the 'sifive_e' cpu when disabling the named extension zic64b.
It makes little sense to show user warnings for named extensions that
users can't control, and the solution taken was to disable zic64b
manually in riscv_cpu_update_named_features().

This solution won't scale well when adding more named features, and can
eventually end up repeating riscv_cpu_disable_priv_spec_isa_exts().

Change riscv_cpu_disable_priv_spec_isa_exts() to not show warnings when
disabling a named feature. This will accomplish the same thing we're
doing today while avoiding having two points where we're disabling
exts via priv_ver mismatch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241113171755.978109-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3b99c8c9e3..48a55ba1d8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -304,6 +304,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+
+            /*
+             * Do not show user warnings for named features that users
+             * can't enable/disable in the command line. See commit
+             * 68c9e54bea for more info.
+             */
+            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
+                continue;
+            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
@@ -331,11 +340,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
-    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64 &&
-                          cpu->cfg.has_priv_1_12;
+                          cpu->cfg.cboz_blocksize == 64;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.1


