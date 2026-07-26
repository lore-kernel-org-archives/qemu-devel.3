Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0012C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 15:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0t8-0004Hn-MN; Sun, 26 Jul 2026 11:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wo0t4-00040t-Go
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 11:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wo0t2-0003xU-Je
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 11:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785080131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqNf/DiNMUITJUHX6Lq0t2UzFtILqcQX4S1Y5wertN0=;
 b=e8lKepvokqoo16VjPVWAf/1K+o6Z+CKkYW/BDvQTOFffG4N1mLiUk496IkeSYCwhDxnUxJ
 zy2oLl9xRjygX1hJqTDMTERYmTp9aRLxhB8DoiiGSz3KOQH+s1FltWM28e4HwQaI83oLsI
 sdgUx0Qn7+CwYkxcGHMPgHJeqgWMb0M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-h0TNje-SN9aIs_6A2pnzgw-1; Sun,
 26 Jul 2026 11:35:28 -0400
X-MC-Unique: h0TNje-SN9aIs_6A2pnzgw-1
X-Mimecast-MFC-AGG-ID: h0TNje-SN9aIs_6A2pnzgw_1785080126
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D1FF180047F; Sun, 26 Jul 2026 15:35:26 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA5EB180025F; Sun, 26 Jul 2026 15:35:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v7 17/18] target/arm/kvm: add utility to write idregs in
 scratch vcpu
Date: Sun, 26 Jul 2026 17:29:55 +0200
Message-ID: <20260726153221.24773-18-eric.auger@redhat.com>
In-Reply-To: <20260726153221.24773-1-eric.auger@redhat.com>
References: <20260726153221.24773-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm_arm.h    |  3 +++
 target/arm/kvm-stub.c   |  6 +++++
 target/arm/kvm.c        | 51 +++++++++++++++++++++++++++++++++++++++++
 target/arm/trace-events |  1 +
 4 files changed, 61 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2b3474cc36..68e0597ac6 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -250,4 +250,7 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
+bool kvm_idreg_write_scratch_vcpu(int cpufd, Visitor *v, const char *name,
+                                  void *opaque, Error **errp);
+
 #endif
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 88cbe8d85c..264938d2c5 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -119,3 +119,9 @@ char *kvm_print_register_name(uint64_t regidx)
 {
     g_assert_not_reached();
 }
+
+bool kvm_idreg_write_scratch_vcpu(int cpufd, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index fceffee262..e95c6e14ec 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -340,6 +340,57 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
     return NULL;
 }
 
+bool kvm_idreg_write_scratch_vcpu(int cpufd, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
+    uint64_t mask, old_reg_val, new_reg_val, oldfv, newfv;
+    struct kvm_one_reg reg;
+    int lower = field->shift;
+    int length = field->length;
+    int index = field->index;
+    uint64_t kidx;
+    int ret;
+
+    mask = MAKE_64BIT_MASK(lower, length);
+
+    if (!visit_type_uint64(v, name, &newfv, errp)) {
+        return false;
+    }
+
+    kidx = idregs_sysreg_to_kvm_reg(id_register_sysreg[index]);
+    ret = read_sys_reg64(cpufd, &old_reg_val, kidx);
+    if (ret) {
+        error_setg(errp, "failed to read the scratch vcpu value for field %s %m",
+                   field->name);
+        return false;
+    }
+    oldfv = (old_reg_val & mask) >> lower;
+
+    new_reg_val = old_reg_val & ~mask;
+    new_reg_val |= newfv << lower;
+
+    reg.id = kidx;
+    reg.addr = (uintptr_t)&new_reg_val;
+    ret = ioctl(cpufd, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        error_setg(errp, "failed to apply new value 0x%"PRIx64" for field %s "
+                   "(previous is 0x%"PRIx64"): %m", newfv, field->name, oldfv);
+        return false;
+    } else {
+        uint64_t check_val, actualfv;
+
+        ret = read_sys_reg64(cpufd, &check_val, kidx);
+        if (ret) {
+            error_setg(errp, "failed to read the new reg value: %m");
+            return false;
+        }
+        actualfv = (check_val & mask) >> lower;
+        trace_kvm_idreg_write_scratch_vcpu(field->name, oldfv, newfv, actualfv);
+    }
+    return true;
+}
+
 static void set_sysreg_prop(Object *obj, Visitor *v,
                             const char *name, void *opaque,
                             Error **errp)
diff --git a/target/arm/trace-events b/target/arm/trace-events
index e67730de6b..71a2f5770c 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -20,6 +20,7 @@ get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
 set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
 nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
 unexpected_writable_reserved_field(const char *reg_name, const char *field_name, int lower, int upper) "Unexpected writable reserved field: %s.%s [%d,%d], skip it ..."
+kvm_idreg_write_scratch_vcpu(const char *name, uint64_t oldfv, uint64_t newfv, uint64_t actualfv) "successful dry-run for %s old=0x%"PRIx64" new=0x%"PRIx64" actual=0x%"PRIx64
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.53.0


