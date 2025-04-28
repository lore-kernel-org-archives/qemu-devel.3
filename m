Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA5C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1K-00063l-IJ; Mon, 28 Apr 2025 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J10-0005Z9-9B
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0y-0000wg-DT
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W30Eto45WIcEnU76fZ71M3IVQ4cR6MU0RlRyO0yA1sY=;
 b=Q4AljbNsjPdlpRts6ku7c5myvMmQhZF0mMIONl7WmfRxbNlDbsDYQNucVw6nEHjxhKhs7/
 rQw+Z4T8zUBu5P0wb1rZaMxLuOjU5SOnIyVZCk5c8wWACGr7znOXzU1Yu9uHGX9H/Y/7dh
 sfcCvzFqdUqRGU9n37diVVHMnY7fNwU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Pvj5A31MNFev8ja-RQ0guQ-1; Mon, 28 Apr 2025 03:34:53 -0400
X-MC-Unique: Pvj5A31MNFev8ja-RQ0guQ-1
X-Mimecast-MFC-AGG-ID: Pvj5A31MNFev8ja-RQ0guQ_1745825692
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso2228320f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825691; x=1746430491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W30Eto45WIcEnU76fZ71M3IVQ4cR6MU0RlRyO0yA1sY=;
 b=OABqgsi8isE00bMZx2R+5/eEbR87vhcDxOwDVXk/ufiVmRahDYF6KRj7Vbb6f0gyin
 URB3PGGeiPL5puvtFuvaY3fM6ZCybaT76HEIOORUeTNd5Jm/MiqCygf8rDZd5/XYA20N
 e9Lm7F7cqyKcq16axMOqgPo3vZ3tbF1s46hFUdeJ1IEzChf7Vdm5nWZ/vxZoSQO2zrl5
 3oisMI0YJ9Ah9qALd9s/iYQWQVKjppXC7tSEjA8KjlEbe3f5+TbI6637v+nBweiDGbjJ
 W+iCGxBqilabix1+u9iVolbo2fVg9x0jf5Tnh1Lb5xgk0af4m5k/evB7GfTz/U0Pj1lJ
 u7gQ==
X-Gm-Message-State: AOJu0YyTAQsOQ72pLCpv2kWS3QC+jXupkeIPk755rf6W2r0ETe8N0hhy
 8YPZZgvLv4Ge6N9l7mVuyTi/xCTKWAljUC86mJ6aqHrZxELhv+iTnhaM7dS9CpIosF45uDAGVZM
 2G6F6kJp0edax67beTKb3WXwi0zgnRGblOT629FTLCxSBr14YBuFaPGkpM0Io4dmOcMeE0BMg8o
 7ARj7wRhPSi7wFpSlQ4Jb9cSBsF+5KN0vee64z
X-Gm-Gg: ASbGncv6Xyhiz4n8yebu3aNEzfIoyiF3W7/cfE/4OwqoV/DqRQpfWWScQGMchNGLWOY
 Avi5LW7+7O1wA3Pkd8C98cwdNzGrkBWK6nz18MViol8kv5cBIdIyiLhvKx3dVwN6iDQkcjf6tEb
 xLMKRxfLheOgGPPhDRt+sHlBGiIXuFG1cUZW6G8rii75LL+kl5jB0wngp0hjX2N5tSAjeKEtmYp
 SmkT1a0l7xZH8TgqYpkzKDogjTujVBDOVU6w2w26gBLS95INsrhc2Wbj1QD2G4AUtLzlPlVICFZ
 kG4pjqC3SUKfFAM=
X-Received: by 2002:adf:fb0d:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-3a074e6a9d6mr6880380f8f.34.1745825691353; 
 Mon, 28 Apr 2025 00:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWN3J9G7TSB7NtoROv4fcqLQsONrvW5mGFDe6PWcGc8at66IXoA0dyokNKuQXwcxUATVgQTQ==
X-Received: by 2002:adf:fb0d:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-3a074e6a9d6mr6880362f8f.34.1745825690958; 
 Mon, 28 Apr 2025 00:34:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da02sm10365097f8f.93.2025.04.28.00.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 03/26] target/riscv: cpu: store max SATP mode as a single
 integer
Date: Mon, 28 Apr 2025 09:34:18 +0200
Message-ID: <20250428073442.315770-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The maximum available SATP mode implies all the shorter virtual address sizes.
Store it in RISCVCPUConfig and avoid recomputing it via satp_mode_max_from_map.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/cpu.c         | 11 +++++------
 target/riscv/tcg/tcg-cpu.c |  3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index cfe371b829d..c8ea5cdc870 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,6 +196,7 @@ struct RISCVCPUConfig {
 
     bool short_isa_string;
 
+    int8_t max_satp_mode;
     RISCVSATPMap satp_mode;
 };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e0e70a2227f..7ba57685a66 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -447,6 +447,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
     }
 
     assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
+    cpu->cfg.max_satp_mode = satp_mode;
 }
 
 /* Set the satp mode to the max supported */
@@ -1173,16 +1174,13 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
-    uint8_t satp_mode_map_max, satp_mode_supported_max;
+    uint8_t satp_mode_map_max;
 
     /* The CPU wants the OS to decide which satp mode to use */
     if (cpu->cfg.satp_mode.supported == 0) {
         return;
     }
 
-    satp_mode_supported_max =
-                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
-
     if (cpu->cfg.satp_mode.map == 0) {
         if (cpu->cfg.satp_mode.init == 0) {
             /* If unset by the user, we fallback to the default satp mode. */
@@ -1211,10 +1209,10 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
     satp_mode_map_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
 
     /* Make sure the user asked for a supported configuration (HW and qemu) */
-    if (satp_mode_map_max > satp_mode_supported_max) {
+    if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
         error_setg(errp, "satp_mode %s is higher than hw max capability %s",
                    satp_mode_str(satp_mode_map_max, rv32),
-                   satp_mode_str(satp_mode_supported_max, rv32));
+                   satp_mode_str(cpu->cfg.max_satp_mode, rv32));
         return;
     }
 
@@ -1474,6 +1472,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
+    cpu->cfg.max_satp_mode = -1;
 }
 
 static void riscv_bare_cpu_init(Object *obj)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 54ac54f2e15..1192b4e1545 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -717,8 +717,9 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
                                             RISCVCPUProfile *profile,
                                             bool send_warn)
 {
-    int satp_max = satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
+    int satp_max = cpu->cfg.max_satp_mode;
 
+    assert(satp_max >= 0);
     if (profile->satp_mode > satp_max) {
         if (send_warn) {
             bool is_32bit = riscv_cpu_is_32bit(cpu);
-- 
2.49.0


