Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB641CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQt-0008T0-Uc; Thu, 09 Oct 2025 03:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQr-0008Sn-3w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQl-0004Qr-6D
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybg7xeLuE7xqCSx05hiU1cBvGy3lci2b+snhEgiPC5w=;
 b=V9PhQoO6vEon4UXaCRWI3skbGPmwxBaQ4E6rMIGxo5wvi0yZesvDBjRGnSpU8AbH+E8VJq
 bITVcvpbFA5pEHtaBvmnNEI0QmMYm930mHbDZiz9gvStpJSFjJjl5p37N7hiecdz3yrlIX
 cNl8AHTCI2t7qQ+8d0gNlKfp4GSxZM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-a-H9N710Na-zYiBnhbFAGw-1; Thu, 09 Oct 2025 03:51:16 -0400
X-MC-Unique: a-H9N710Na-zYiBnhbFAGw-1
X-Mimecast-MFC-AGG-ID: a-H9N710Na-zYiBnhbFAGw_1759996275
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e4c8fa2b1so2946735e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996274; x=1760601074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybg7xeLuE7xqCSx05hiU1cBvGy3lci2b+snhEgiPC5w=;
 b=XFCrAcx4RD1Zc3SHDB2TyWSCS0Nl76MaSRR199J2TxaKw1AilMQKVITMML36Z6KzHH
 iK/RH3BBP9zj7UGLXn+ZL63lt0Y+XHnvMv3Kgki198bWLjup1nsGBhlRQZVb3MXm4wNX
 vv7BaZgKU8b89lW6i8HPl33Jp4qj41Mj8+fOe9sLf9p58XXeG0AAdnJww6Pu4mENbDbH
 rm5hiYP9uB+gD8ikRFgi9azxbnyc5wNfF0WmfBtIKKbGsLcHbOQ78oBTpeIN7lq/evXW
 p0175+Q1Y6vzSIDv8R1ccGMemoxJE8X5r47RuyiOfp+R87ukLW+VK/82fvRPnmjbODbe
 bYFQ==
X-Gm-Message-State: AOJu0YwF/uY0P45E+33qIkN2BInmlOP80xfHSjZbGi+ZwKBuCCvoP84o
 2DaDEMKfBhdotSoLXn68bb5YJ+BTcLr179EGVLwbk3kHggQBT+T/CMQle3wwBU4G9wicFsh6A49
 X0n+dTkoe6JJvTQYI7tFelKhjnaYcvrDQae6WKzArTsJ/DntsWO26MyoNg4z4poK6eLXhCJAXyL
 o3wCnom2CxqCN3NzW6M7lMI9v6+8yk3wnsUXyJ2rsegm8=
X-Gm-Gg: ASbGnct3RLqk8wCdodTnFcuHFKiBCGy7be+2xsj5h1rznh9vWOauFhk2xIv88qVsaid
 eQyouLP5g0IFKh330ReBwqT7ScJTueAnKbNo6cJy5AipjpAnQ1rcuXA24/8j3pTVrNtlUusAMNK
 lOBQ/xKG7SM4DuiaUfbM38bLWCYMunMryl1nk984ahNPo5/om2vb+UoAnupo9VNIiSmAKM7OhOD
 aAlTPqKT1EQZGuAGQ95ACK9LrLi+n99N4qT99yXYTG2bmTFhiFr1TtWEepQfENuFJM9eWzrR1Xm
 c1YJabHqlJy9PYvMYKzatGVyzdz4UbXFPva7LjIgrAj2IobTLR26nhl5npS36UcsFkELisehaW/
 OC5wQekDHjKRna9/iYHNkhM/SLvjU3tb9X5NGY0L1sr7x6y+z
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr41445395e9.23.1759996273980; 
 Thu, 09 Oct 2025 00:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQWHFlSbyyhOh/uM+oPcIJ35RkNmWpcnYrefdqO+fMmCvOfGmhIcdQjJAR8RG22VqqLZ2lvw==
X-Received: by 2002:a05:600c:529a:b0:46e:4912:d02a with SMTP id
 5b1f17b1804b1-46fa9aef4cbmr41445225e9.23.1759996273518; 
 Thu, 09 Oct 2025 00:51:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6bb2sm32514984f8f.10.2025.10.09.00.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 21/35] target/i386/mshv: Implement mshv_get_special_regs()
Date: Thu,  9 Oct 2025 09:50:11 +0200
Message-ID: <20251009075026.505715-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Retrieve special registers (e.g. segment, control, and descriptor
table registers) from MSHV vCPUs.

Various helper functions to map register state representations between
Qemu and MSHV are introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-16-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |   1 +
 target/i386/mshv/mshv-cpu.c | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index b0a79296ad9..c6e6e8af307 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -59,6 +59,7 @@ void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_get_standard_regs(CPUState *cpu);
+int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4e3eee113bb..bc75686f828 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -53,6 +53,26 @@ static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
     HV_X64_REGISTER_RFLAGS,
 };
 
+static enum hv_register_name SPECIAL_REGISTER_NAMES[17] = {
+    HV_X64_REGISTER_CS,
+    HV_X64_REGISTER_DS,
+    HV_X64_REGISTER_ES,
+    HV_X64_REGISTER_FS,
+    HV_X64_REGISTER_GS,
+    HV_X64_REGISTER_SS,
+    HV_X64_REGISTER_TR,
+    HV_X64_REGISTER_LDTR,
+    HV_X64_REGISTER_GDTR,
+    HV_X64_REGISTER_IDTR,
+    HV_X64_REGISTER_CR0,
+    HV_X64_REGISTER_CR2,
+    HV_X64_REGISTER_CR3,
+    HV_X64_REGISTER_CR4,
+    HV_X64_REGISTER_CR8,
+    HV_X64_REGISTER_EFER,
+    HV_X64_REGISTER_APIC_BASE,
+};
+
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -255,6 +275,84 @@ int mshv_get_standard_regs(CPUState *cpu)
     return 0;
 }
 
+static inline void populate_segment_reg(const hv_x64_segment_register *hv_seg,
+                                        SegmentCache *seg)
+{
+    memset(seg, 0, sizeof(SegmentCache));
+
+    seg->base = hv_seg->base;
+    seg->limit = hv_seg->limit;
+    seg->selector = hv_seg->selector;
+
+    seg->flags = (hv_seg->segment_type << DESC_TYPE_SHIFT)
+                 | (hv_seg->present * DESC_P_MASK)
+                 | (hv_seg->descriptor_privilege_level << DESC_DPL_SHIFT)
+                 | (hv_seg->_default << DESC_B_SHIFT)
+                 | (hv_seg->non_system_segment * DESC_S_MASK)
+                 | (hv_seg->_long << DESC_L_SHIFT)
+                 | (hv_seg->granularity * DESC_G_MASK)
+                 | (hv_seg->available * DESC_AVL_MASK);
+
+}
+
+static inline void populate_table_reg(const hv_x64_table_register *hv_seg,
+                                      SegmentCache *tbl)
+{
+    memset(tbl, 0, sizeof(SegmentCache));
+
+    tbl->base = hv_seg->base;
+    tbl->limit = hv_seg->limit;
+}
+
+static void populate_special_regs(const hv_register_assoc *assocs,
+                                  X86CPU *x86cpu)
+{
+    CPUX86State *env = &x86cpu->env;
+
+    populate_segment_reg(&assocs[0].value.segment, &env->segs[R_CS]);
+    populate_segment_reg(&assocs[1].value.segment, &env->segs[R_DS]);
+    populate_segment_reg(&assocs[2].value.segment, &env->segs[R_ES]);
+    populate_segment_reg(&assocs[3].value.segment, &env->segs[R_FS]);
+    populate_segment_reg(&assocs[4].value.segment, &env->segs[R_GS]);
+    populate_segment_reg(&assocs[5].value.segment, &env->segs[R_SS]);
+
+    populate_segment_reg(&assocs[6].value.segment, &env->tr);
+    populate_segment_reg(&assocs[7].value.segment, &env->ldt);
+
+    populate_table_reg(&assocs[8].value.table, &env->gdt);
+    populate_table_reg(&assocs[9].value.table, &env->idt);
+
+    env->cr[0] = assocs[10].value.reg64;
+    env->cr[2] = assocs[11].value.reg64;
+    env->cr[3] = assocs[12].value.reg64;
+    env->cr[4] = assocs[13].value.reg64;
+
+    cpu_set_apic_tpr(x86cpu->apic_state, assocs[14].value.reg64);
+    env->efer = assocs[15].value.reg64;
+    cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
+}
+
+
+int mshv_get_special_regs(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    size_t n_regs = ARRAY_SIZE(SPECIAL_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get special registers");
+        return -errno;
+    }
+
+    populate_special_regs(assocs, x86cpu);
+    return 0;
+}
+
 int mshv_load_regs(CPUState *cpu)
 {
     int ret;
@@ -265,6 +363,12 @@ int mshv_load_regs(CPUState *cpu)
         return -1;
     }
 
+    ret = mshv_get_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load special registers");
+        return -1;
+    }
+
     return 0;
 }
 
-- 
2.51.0


