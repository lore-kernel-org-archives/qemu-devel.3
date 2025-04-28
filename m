Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D071C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1S-0006Gh-Tu; Mon, 28 Apr 2025 03:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0y-0005WM-2u
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0v-0000w1-CK
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFeHuKDiAX8NDQZnVqS8Fkkwi4+2zsns3YqN+D31BBw=;
 b=I/20upchT5bKkW1gJ+xv/QCR0TvgRrSEJtVkGt2FcSZndqoX16UgOJ6CnF4tLhOrbQsB71
 w5vn4i7LeCawrTMazfqfRi/phBn6wyJ0To7s1DMhzd+E5IKo95TpptG5IMMFqqX6p0cfiv
 Af5ayd+P405wi85VyAZEkvJLruT23ZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-DoUMN6F7NhSYLEPB2AbCvA-1; Mon, 28 Apr 2025 03:34:49 -0400
X-MC-Unique: DoUMN6F7NhSYLEPB2AbCvA-1
X-Mimecast-MFC-AGG-ID: DoUMN6F7NhSYLEPB2AbCvA_1745825688
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39130f02631so1396273f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825687; x=1746430487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFeHuKDiAX8NDQZnVqS8Fkkwi4+2zsns3YqN+D31BBw=;
 b=fwbpfyJLpEo/MlvJfpSJX4B4rcS7vNQXIZubh6rOEQJFA1H/a1j8N2qHJxjW8K4BJ8
 qeTKmfBPkoBPbFgv461tty1mdvwEw01mY8YGjevle/DljSdNCXMdGsbOdssw/eePD+Fz
 Y/EpmN/3HGtzeTpYKoMg4wIVJ5g0y7WVdV5QxVkoLJVxhMnxmtf3bMQ76p6KlQIkF59u
 fdyHg0sTBI18DTgH4nByy6X8In8KkExezwOACqL3aF925LoR9EMwml+tSY9J4gNalcT1
 cj52WWfxyhyh4gPBkQ2RlHWTTje16Q809iTAIDF9q7MuZOTdHvV0GLLZ+q+bp4TWRvaz
 r09w==
X-Gm-Message-State: AOJu0YyLaaHIrb9JrnRgqgA63Fav/YqWQHqwJHFnMpq7HnZ/MaZZXeWv
 Mc6dUWvGS+Jo84l/Cf+ZoTjVDwl/ZtltKKwHn87lEKmiZTV5skwVepPOeHLdgMW9PewAC9aIyzC
 YSj+CEXvQNW2eKrJpDCBsCdaLtpdVc5GLiTGdwg6lZ1ihj5Ky5MXyteL1nBlbgR5OqdTUB31S1J
 b7eGJSuTtooZWDYLyQK2pATQMkxt0FC73UOniW
X-Gm-Gg: ASbGncuzhXakSOAfknIgLJevrUHXNCvB0C6UbLJAPD+aWfSRCk9vzH6+8TYCpEeLvAt
 6L9FEhfp2N/3DPxYx3qEL7moxqjBtrbUqSSGn0I86Qef8wWZNu6v67pB0tsetSi9JFE5K2zC7fB
 i0ET/9sNAV2NdY6KE7PMg7bpIV9vbgZ0bEkAFLxV5fHtnk0LHuXUGpDhy5iz3GV6Pc7bBsZkbh8
 KVk5oWa8mNKYVJYVrV11Eue2YuqfiSmzs82dkq9cQixArnzs+t7GMm/0l6v7k8kwkOYQl0T48ZU
 NJgpkL4RqrgPwHg=
X-Received: by 2002:a05:6000:1787:b0:3a0:7fcf:1f41 with SMTP id
 ffacd0b85a97d-3a07fcf1facmr4419535f8f.47.1745825687298; 
 Mon, 28 Apr 2025 00:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsGwq+yLShN/RkC60H2fSjCcnflEJXOa5pd07yiFstPDm8dXEgKVAFVT8kHx7zlsv8FhAn8A==
X-Received: by 2002:a05:6000:1787:b0:3a0:7fcf:1f41 with SMTP id
 ffacd0b85a97d-3a07fcf1facmr4419510f8f.47.1745825686870; 
 Mon, 28 Apr 2025 00:34:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm10132608f8f.25.2025.04.28.00.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 01/26] hw/riscv: acpi: only create RHCT MMU entry for
 supported types
Date: Mon, 28 Apr 2025 09:34:16 +0200
Message-ID: <20250428073442.315770-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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


