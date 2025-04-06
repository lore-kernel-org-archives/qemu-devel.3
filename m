Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EB7C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2X-0002uK-0a; Sun, 06 Apr 2025 03:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K28-0002rd-7j
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K26-0001yl-N9
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743922985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFeHuKDiAX8NDQZnVqS8Fkkwi4+2zsns3YqN+D31BBw=;
 b=M3aQMzi+mmQCTLOCWNcdqIgzzBydnHsQW11afs7uoC4vg3K0wdOL/A5UAaKI0odRY9XChd
 LV10YIREN1GPZASeWy+IuGzdW+EbjvmZGxy0T3qDma2f0er55os8fXXXVxAfR3aNOleapB
 4LjXArZBGlL5w/6c4fc4xdULie30EZE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-WHEz3YEDN8W2sm-xg-QVtw-1; Sun, 06 Apr 2025 03:03:03 -0400
X-MC-Unique: WHEz3YEDN8W2sm-xg-QVtw-1
X-Mimecast-MFC-AGG-ID: WHEz3YEDN8W2sm-xg-QVtw_1743922982
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so27357235e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743922981; x=1744527781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFeHuKDiAX8NDQZnVqS8Fkkwi4+2zsns3YqN+D31BBw=;
 b=FGMARu2X2+gD5EjwPlVVSEjimCalodH+FnvNbm8cbHKVLFNApYOiPcOcHa80T9SEpq
 VYEmtBh/2qNUIry+2tMozG2OozbUXOMuxOzxOEePdDli4Weo0ktTd4DKq+mdqkfgVOUq
 hk7St+AxuGrpEkZkkCNE2IJghgwA6GnyrQKV3GbHcQzoUFmDGwrYyTpt2OOOCJ17SMy8
 3rYdwc1+IfX+n++IjsPJI69NJ7yLorX0N8ldf0rhEY79RQ82KAGOxgCJMlmUi59MGFxC
 XLW5QscWofU93itThRQByqMcB5xPvfG6qFEeqmFzk/KHaVccPfddYinUr2BCvKxgopOy
 KtjA==
X-Gm-Message-State: AOJu0Yw4WrC21Ptr0lstbCo13R0r93TRrfVNI0nP/7jFf2lFuqgMSNII
 WAY/m4sqHko9iW1H5KnmHtwQOr5sSe6Nua6ZIgzhtTtuzEc1eUXn+ztMMFR0FkxPKc36RznU4Hc
 zIKJeeD09pW1rAHYoc691ev02UZOcvoMOPC0HQcGUOnziUw94BYeEW2aA0SnAvB/FHp8elmxShj
 ovOwHS5vTiBxaMPklFBQ0rP61Hp6yx99czUMg5
X-Gm-Gg: ASbGncvOEJpw4xXqjo7hdjRndXwpmon+XZmzgtplEtMO6E+ZN4XpF+HN3MtPE4x7cwn
 XtVBMK3WGwR/qernev58EmESwJNUra9UAUMaeZDykrZUxCVsSnz/mrXIfy9EOzuCQorQDZPNuqN
 +XtfQRmjmbNEEKLfrZEjcvWm80adLpu7Q2DSerQiMUNB4+Rb5y180oyUQ12S5anr1XtJnmszWtm
 Hti91cElZx2EDuIzZ0eMEzPkOiejhkrSR49q0yO45vXDACw0o5Mm1pC5xohQvgNztO/dXnpw4dg
 3VkqUwJPI+cxpinVyg==
X-Received: by 2002:a5d:5f4d:0:b0:391:47d8:de25 with SMTP id
 ffacd0b85a97d-39d0de67a0bmr7482140f8f.41.1743922980943; 
 Sun, 06 Apr 2025 00:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+mCpgP2O8Vcu6WGZYxsALZNrEhNnimHDEFj7qwU4xOwE1ATiJ0f8qaO1/qwGGRwLjLaf9Yw==
X-Received: by 2002:a5d:5f4d:0:b0:391:47d8:de25 with SMTP id
 ffacd0b85a97d-39d0de67a0bmr7482121f8f.41.1743922980555; 
 Sun, 06 Apr 2025 00:03:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a8952sm92047685e9.10.2025.04.06.00.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:02:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 01/27] hw/riscv: acpi: only create RHCT MMU entry for
 supported types
Date: Sun,  6 Apr 2025 09:02:28 +0200
Message-ID: <20250406070254.274797-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not create the RHCT MMU type entry for RV32 CPUs, since it
only has definitions for SV39/SV48/SV57.  Likewise, check that
satp_mode_max_from_map() will actually return a valid value, skipping
the MMU type entry if all MMU types were disabled on the command line.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
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
2.49.0


