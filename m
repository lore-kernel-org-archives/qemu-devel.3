Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C740C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsU-0001Pv-QL; Sat, 18 Jan 2025 20:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsO-0001EN-Bi
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:20 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsL-0003BX-3U
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:20 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso4713893a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249191; x=1737853991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v87WTdDQC8DDzGlvKqDnGwAE9sgIictuWkNEBi5lUJ4=;
 b=Ib26ORRAFkVXqBfjCsO59i5DBiX699lsoJId6+vWeUFZ2w0juOqMCwwcDs/NEs9dPj
 yj1fkHMZ48cKNsQfsaYpYbDRse4oHaCEW5zL6Xjn8skooy4D/YXfw/2Uk2L35Gqm7yIk
 tZRuKab9/jtvIuhXwyKvAwunrrPMt1JXbT/RPLodSL6jvHrVZN2/uHubiWH/JFoS4nxv
 b4l1uWNVPWqr3IPfuGZRnKFsPvBeIE44HtgAGcptS5bOkbFD8P/eKvfMc7Ac3Nrx6HyF
 Kzd/2xxUrxjJSkI2mSvTjl1OKkmixYdNiUz5HZGtZ7YgKrHHf8E6X1qaihA09lvOfpu4
 BSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249191; x=1737853991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v87WTdDQC8DDzGlvKqDnGwAE9sgIictuWkNEBi5lUJ4=;
 b=f37BqHx7MZUlfphHI3e1b/A37FIcKoMMRtGyyICKbxYOReNs+ev8MiLbS5/8x6mfgp
 Kp7DF6zTP69YyliNXnkHaojD/ku8gqTeX4Pcg9i2gtpe6u0n/GHEV0doLkjI28n+mWuq
 mNQuRtOt+4k2qekh1EH219JeVa+GlhBMsth6MiN88lv7WTIuc3lHNVfZF2EcvpkjLpYP
 ol5sB2lo+1sKP3t4XjQlZnr0fhWkyyKKAhrJ0R828iMtEBbWHJdZBfBqg3KqM1qzTL7a
 WSneneqydFOzI0X2HUbl9u7A2e/UZNP3pK77G03YatYBd1Q6bzT42H9wYBtHYa5FA8LB
 x9JA==
X-Gm-Message-State: AOJu0YzZoWV97xaKIHZQEu2Tui11N3c1afWEBa6iMe7Jet9VDM91ij8f
 wvH8qcMy+U5D8S56LmX/jHNLY2Mw95NQotfhYvg3BcRzjmTRSjUgUVcEbur1
X-Gm-Gg: ASbGncvcNnIvn8/cFvvLWYMSEVjbq6FrTuAXmpjUAYnTARIkmhs0DaIhxpPyiEqceZo
 CJp60rtUra0gQud2wMIKb7R1JIKavhMUfE2LOtMwgW2T2ofBKO0K+vgj4NRYfDgP7jB/4qV2e7v
 aVpNbf47xM6Py6ARSbv0uRXGJwSROKtgbX38AQ5ZlZjDDUd7eKks2MraXNDar8IixtOrCkCOXi/
 MUIoF+NnieuInFv3EESQ5jDf4fV1+VO6iwkGjns+KpNX5T9D8haRFNi+p9N6bqyQqvz4ZbEs9pQ
 TmUJdoYWj0+cwojdWi0nax4MPerV0ClYgxgrWSHGT/rJeEiBgt2EnG6Gzvh2KPuhawoFw3VsgQ=
 =
X-Google-Smtp-Source: AGHT+IHyNodN6VQLXrJZ2GQInNzspBuYKOUudc6JI+1WotfXgnfFWCSXTr0K4oV9Stl8gvKcdljfpw==
X-Received: by 2002:a17:90b:2e41:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2f782c71ec7mr13086094a91.14.1737249191512; 
 Sat, 18 Jan 2025 17:13:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:11 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 10/50] target/riscv/tcg: add sha
Date: Sun, 19 Jan 2025 11:11:45 +1000
Message-ID: <20250119011225.11452-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

'sha' is the augmented hypervisor extension, defined in RVA22 as a set of
the following extensions:

- RVH
- Ssstateen
- Shcounterenw (always present)
- Shvstvala (always present)
- Shtvala (always present)
- Shvstvecd (always present)
- Shvsatpa (always present)
- Shgatpa (always present)

We can claim support for 'sha' by checking if we have RVH and ssstateen.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h     | 1 +
 target/riscv/cpu.c         | 2 ++
 target/riscv/tcg/tcg-cpu.c | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a1457ab4f4..fe0c4173d2 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -141,6 +141,7 @@ struct RISCVCPUConfig {
     bool ext_svade;
     bool ext_zic64b;
     bool ext_ssstateen;
+    bool ext_sha;
 
     /*
      * Always 'true' booleans for named features
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3e138572d4..954425081d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1714,6 +1715,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
     MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
+    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
 
     { },
 };
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8b89c99c0f..e03b409248 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -212,6 +212,11 @@ static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
         break;
+    case CPU_CFG_OFFSET(ext_sha):
+        if (!cpu_misa_ext_is_user_set(RVH)) {
+            riscv_cpu_write_misa_bit(cpu, RVH, true);
+        }
+        /* fallthrough */
     case CPU_CFG_OFFSET(ext_ssstateen):
         cpu->cfg.ext_smstateen = true;
         break;
@@ -352,6 +357,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
                           cpu->cfg.cboz_blocksize == 64;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
+
+    cpu->cfg.ext_sha = riscv_has_ext(&cpu->env, RVH) &&
+                       cpu->cfg.ext_ssstateen;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.48.1


