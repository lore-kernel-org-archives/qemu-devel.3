Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96643C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvD-0006fa-Ls; Tue, 18 Feb 2025 11:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQv8-0006ee-OP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQv7-0004OG-AE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yo9wBigNypiIruDRrEWTfqKgN+tlFR8pJq1aWfyIoRQ=;
 b=AUY5F9t2LA/NnHn5bQMVBC1SeSzsyXMv3jnhFmBetoMNlF6Ra0/SOGrJb7C14spr9yygJg
 ZvCiWv9P7GaMPb8E2hX1aiQi5Utb8sDWtE+zKuY3Qw8WFAUARTwVZmAW9BEmqOGi1J111m
 KWyvM4QylVmJ5f73nIxCxQUu1MZeW14=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-S9DXrx8DMP2q_sNhJ_gmgw-1; Tue, 18 Feb 2025 11:58:02 -0500
X-MC-Unique: S9DXrx8DMP2q_sNhJ_gmgw-1
X-Mimecast-MFC-AGG-ID: S9DXrx8DMP2q_sNhJ_gmgw_1739897881
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f29b4d4adso2636909f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897880; x=1740502680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yo9wBigNypiIruDRrEWTfqKgN+tlFR8pJq1aWfyIoRQ=;
 b=UzXzTCpItCMHpdLwqCcbNf9gqyTILDkFAgaTE4PBOnCZHeQLmFtmCgX099RdR1e7Ge
 nuL+WiiTHI9Qgztbbyi9YZGgY/cpNCc6OTXtgj6pTFI72FfMtzuGy8OQzPIzoB4kEfOw
 1bJVAwnmjAkJ45CzkIX0b9KTtdknx7zjpT5BUSUhCOgfjKi7A4HYdd+faOGY86mUp5Bg
 MnYL3scW+TIRuUco+S3z78F1JrwXqwioXhbztQRDEY0Hvy+XCbxDtFk0f+6neGZC4UuO
 F2mAC1n9S/cQGTXwO5qmkFzngdl7W7/XYyV5r7o7kzU8Frf/AKloNfNhMn9oUYnwBB8x
 S9yQ==
X-Gm-Message-State: AOJu0YxUn4go/eVwFdSzRstmBv/AkG39EBl4DDutnSpAUyGiryzTxk9x
 8rrgZJ/80R6UVGKf3MZo+JuJNDBpGPyYf14L/2FZrWAamJ+yr03LJlMNQFHltLgCYcP73SwWNEI
 E6vbrxnS8nt2ISvBKj9+GJXeOqu/lV5nZz3ySCIHo8xTrl8bd8EUoSDNN+0FjdjFglL5Bt/BgHH
 8SW3en0OwdExfH5y8tI0pXlIHXvRfdJURENCVFk4E=
X-Gm-Gg: ASbGnctATqYaGcrYHoNU07Ay9MDwIOP+ohIeUiNuX9NBhkzItPhf7JoUdfOU+qxFop4
 y29tpSFqf9IrlcdttfYXT7VLH0331wkf4kLZNME9n09Fp3MDG+ej82ZUkcfcxRCAniw2fx2PyZV
 gDCQJx/D+KLpP2+qdBV23eH8JQ7LYXZQ3T5SHYqqHhJRSgeYu9zw4/c5JLn3uOD8vYmKV3/94Pk
 bLum5YKRrxsoqD0GHGvav+cIjq8yIwzVljR8NYRZt6tuninPmextLGNjcDuSDCYcvBXfbfAys9K
 Nq/JkD/otfg=
X-Received: by 2002:a5d:58c6:0:b0:38e:ba3d:cbdc with SMTP id
 ffacd0b85a97d-38f33f4e424mr12219351f8f.39.1739897880536; 
 Tue, 18 Feb 2025 08:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC0wJ243+ID6ImWwhxQLLaB0Sxb76CuQxTyvNqHGAqmAmRwgfJqeAtVIitgRzLLYwS/X1GfA==
X-Received: by 2002:a5d:58c6:0:b0:38e:ba3d:cbdc with SMTP id
 ffacd0b85a97d-38f33f4e424mr12219334f8f.39.1739897880074; 
 Tue, 18 Feb 2025 08:58:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd95sm15469285f8f.25.2025.02.18.08.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:57:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/7] hw/riscv: acpi: only create RHCT MMU entry for supported
 types
Date: Tue, 18 Feb 2025 17:57:51 +0100
Message-ID: <20250218165757.554178-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218165757.554178-1-pbonzini@redhat.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Do not create the RHCT MMU type entry for RV32 CPUs, since it
only has definitions for SV39/SV48/SV57.  Likewise, check that
satp_mode_max_from_map() will actually return a valid value, skipping
the MMU type entry if all MMU types were disabled on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1ad68005085..2b374ebacbf 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -262,6 +262,7 @@ static void build_rhct(GArray *table_data,
     RISCVCPU *cpu = &s->soc[0].harts[0];
     uint32_t mmu_offset = 0;
     uint8_t satp_mode_max;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
     g_autofree char *isa = NULL;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
@@ -281,7 +282,8 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
-    if (cpu->cfg.satp_mode.supported != 0) {
+    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
+        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
         num_rhct_nodes++;
     }
 
@@ -341,7 +343,8 @@ static void build_rhct(GArray *table_data,
     }
 
     /* MMU node structure */
-    if (cpu->cfg.satp_mode.supported != 0) {
+    if (!rv32 && cpu->cfg.satp_mode.supported != 0 &&
+        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
         satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
         mmu_offset = table_data->len - table.table_offset;
         build_append_int_noprefix(table_data, 2, 2);    /* Type */
@@ -356,7 +359,7 @@ static void build_rhct(GArray *table_data,
         } else if (satp_mode_max == VM_1_10_SV39) {
             build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
         } else {
-            assert(1);
+            g_assert_not_reached();
         }
     }
 
-- 
2.48.1


