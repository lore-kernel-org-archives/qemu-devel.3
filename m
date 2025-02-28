Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA679C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxc5-0002uK-22; Fri, 28 Feb 2025 05:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbO-0002Dp-VB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbJ-0002y6-O6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jI0P046drzVSwOS//1JBbdRJU1PObALwlHHKiBVo7aM=;
 b=bskmiXS3OLfJvZpkdjJIUPhCSD5hZd9uLZgoIVPkhtr/QNI7ZIyZ8V6GR4o3O7ydL1OULp
 /3aFe54wcg6tA6KU1uTTXrxdsuDAxtF/I3w+bVcT3n6T3r3b+NxMRVmFOnz7/6Zxh3NOF3
 hHlzMI6l8/119FXbl2+zSkYGa02PLN0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-RAI4lRYUNvWiU0zuu8Nn7A-1; Fri, 28 Feb 2025 05:28:11 -0500
X-MC-Unique: RAI4lRYUNvWiU0zuu8Nn7A-1
X-Mimecast-MFC-AGG-ID: RAI4lRYUNvWiU0zuu8Nn7A_1740738490
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ab5baf62cso14350815e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738488; x=1741343288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jI0P046drzVSwOS//1JBbdRJU1PObALwlHHKiBVo7aM=;
 b=KF8jZpUN893KJif1bezHV45Hap5LIgfvAesZv5OOYOum/6ipMYXgpydu0HhT9Dtu+e
 qd25pbwUi1mQWqOss38afaCf4EU9hl1jDndQOjWLNK4GCjnMdCCsi+Tab49O2sbZ8gwj
 MmgzH1aqhnnn/pmyVt9+Bk4afJI2jtYtw3f2NPAgzQN/Q0078bS9UdmjEeRjXPwCdJ0P
 bjs7uqHOMGmH0VP7sZ9Vn7OjyHdSELgyLBoDLMyJFCH6geCIQLhMJx2uxu88em9ejADf
 /ajURlOzA1++OrRE8qNUxdjAwm9eryYrsagczoO95wjdmRcJxgdWE2E/Gwjsa+JoS4Ro
 xNqw==
X-Gm-Message-State: AOJu0YzMmmywTBrpHM8SWSSdnBDN0eLpbx44c9lBqHc1w/NpLAWX+8yd
 A67jmmhyRHqbGUT05HUYvBYwXyJ5N/5giCLeRjz4BIyqN9kX5yU9SQNp6Bs8Tt+nvtMM41OjaGR
 c7JbdXACoR16wKmWbqy0CXXAxuCzDnCqzXNhx2xtGQz1wOyU5e4iHoov+Yqzi6tdR0z1iBZ0U+e
 oNbGtL1XZ7GGdEz3pxIyW0dxn6n0NphqwfA0rqrGA=
X-Gm-Gg: ASbGnctlnV8cD2+fFsfIfPNkbKZMAvL4aw0Em9eYVOveqwteYcJ3ZOC8/+x+mG/IgtL
 7p4zVG0PmtKByL1EvhNMjGsvk6mZjN05cPoeqY/cB/x/tW0or7/zy9BTePfLJ3PyJcrNK4SyyK1
 guftsf0j6Ut40J81aSAtquDHFAaMpSI0JQnd8ivIzy6rMpirXBgqTZdpudEoNExflCia44qr2Qt
 lGZY/4CZjx/EYMXsE+i9vg2yvS86cq3HZU+BePiA/sSu3sUHtx8LSbjqr0W9m9E64OT00D+6bfE
 adqdIauAdELQQ4CpcmbJ
X-Received: by 2002:a05:600c:3c93:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43ba66cfe5dmr21711875e9.4.1740738487776; 
 Fri, 28 Feb 2025 02:28:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG42C6d4/8ME3iam5MTsKc85kyJrOQKfc/Nwep/v7TW3tEqW0PQBp099ZCMDsvksPK6aKBAng==
X-Received: by 2002:a05:600c:3c93:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43ba66cfe5dmr21710015e9.4.1740738484084; 
 Fri, 28 Feb 2025 02:28:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab374da3esm82977225e9.1.2025.02.28.02.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 07/22] target/riscv: add more RISCVCPUDef fields
Date: Fri, 28 Feb 2025 11:27:31 +0100
Message-ID: <20250228102747.867770-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Allow using RISCVCPUDef to replicate all the logic of custom .instance_init
functions.  To simulate inheritance, merge the child's RISCVCPUDef with
the parent and then finally move it to the CPUState at the end of
TYPE_RISCV_CPU's own instance_init function.

STRUCT_FIELD is introduced here because I am not sure it is needed;
it is a bit ugly and I wanted not to have it in the patch that
introduces cpu_cfg_fields.h.inc.  I don't really understand why satp_mode
is included in RISCVCPUConfig; therefore, the end of the series includes
a patch to move satp_mode directly in RISCVCPU, thus removing the need
for STRUCT_FIELD; it can be moved before this one in a non-RFC posting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  4 ++++
 target/riscv/cpu.c         | 30 +++++++++++++++++++++++++++++-
 target/riscv/kvm/kvm-cpu.c |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a038122f80c..8c9e73c68cc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -533,6 +533,10 @@ struct ArchCPU {
 
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    uint32_t misa_ext;
+    int priv_spec;
+    int32_t vext_spec;
+    RISCVCPUConfig cfg;
 } RISCVCPUDef;
 
 /**
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 91dd63edc9f..c513d7ce32d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -74,6 +74,13 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
 
+static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
+{
+#define BOOL_FIELD(x) dest->x |= src->x;
+#define TYPED_FIELD(type, x) if (src->x) dest->x = src->x;
+#include "cpu_cfg_fields.h.inc"
+}
+
 #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
     {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
 
@@ -432,7 +439,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
 }
 
 static void set_satp_mode_max_supported(RISCVCPU *cpu,
-                                        uint8_t satp_mode)
+                                        int satp_mode)
 {
     bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
     const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
@@ -1480,6 +1487,16 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     cpu->cfg.max_satp_mode = -1;
 #endif /* CONFIG_USER_ONLY */
+
+    env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
+    riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
+
+    if (mcc->def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.priv_ver = mcc->def->priv_spec;
+    }
+    if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
+        cpu->env.vext_ver = mcc->def->vext_spec;
+    }
 }
 
 static void riscv_bare_cpu_init(Object *obj)
@@ -2974,6 +2991,17 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
             assert(def->misa_mxl_max <= MXL_RV128);
             mcc->def->misa_mxl_max = def->misa_mxl_max;
         }
+        if (def->priv_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->priv_spec <= PRIV_VERSION_LATEST);
+            mcc->def->priv_spec = def->priv_spec;
+        }
+        if (def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
+            assert(def->vext_spec != 0);
+            mcc->def->vext_spec = def->vext_spec;
+        }
+        mcc->def->misa_ext |= def->misa_ext;
+
+        riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
     }
 
     if (!object_class_is_abstract(c)) {
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f3ec4f33931..8259cb4deee 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1992,10 +1992,12 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
         .class_data = &((const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV32,
+            .cfg.max_satp_mode = -1,
         },
 #elif defined(TARGET_RISCV64)
         .class_data = &((const RISCVCPUDef) {
             .misa_mxl_max = MXL_RV64,
+            .cfg.max_satp_mode = -1,
         },
 #endif
     }
-- 
2.48.1


