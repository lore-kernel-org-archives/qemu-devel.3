Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D1DD262B2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSy5-0004ri-OK; Wed, 21 Jan 2026 02:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSxp-0004d2-53
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSxl-0003UL-Tc
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768981752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSTY9AYqm8TFkjdqYG3z7M0nSb+Cdbm/Nbr6mi6s0+w=;
 b=g9tptkiGRk0Yp+c3ettOhoQNWskJAeuxC8ICWKRCsCmubx8Oy6+jWTJIOMW9XBz6S1/FNM
 FqMuFWXZiF5c502JwFCowvLfCvUqWbw1hNJrmoI2RY1m6I7EbeiAjhbTT99c31lZNBGOYA
 C2Vj6uK7k+Z9ivTRBr/WhjgrZTEMN6U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-tcVLkrVYOESXOLxsKjqGGA-1; Wed,
 21 Jan 2026 02:49:09 -0500
X-MC-Unique: tcVLkrVYOESXOLxsKjqGGA-1
X-Mimecast-MFC-AGG-ID: tcVLkrVYOESXOLxsKjqGGA_1768981747
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C486618005B2; Wed, 21 Jan 2026 07:49:07 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F46F19560A7; Wed, 21 Jan 2026 07:49:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v5 05/11] kvm-all: Enforce hidden regs are never accessed
Date: Wed, 21 Jan 2026 08:46:42 +0100
Message-ID: <20260121074834.1900677-6-eric.auger@redhat.com>
In-Reply-To: <20260121074834.1900677-1-eric.auger@redhat.com>
References: <20260121074834.1900677-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On ARM we want to be able to hide some registers which are exposed
by KVM. To mitigate some migration failures that occur when a new
register is exposed and does not exist on the destination, some
registers are tagged "hidden" and their state won't be saved. As the
state is not saved and they are expected not to be used, we want to
enforce they aren't. So let's check this. The new CPUClass hide_reg()
callback is optional and will be implemented on ARM in a subsequent
patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>

---

v3 -> v4:
- don't use blacklist terminology (Connie & Sebastian) and reword
  the commit title to something clearer
---
 include/hw/core/cpu.h |  2 ++
 accel/kvm/kvm-all.c   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f6f17df9e64..3e30e1cbddf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -142,6 +142,7 @@ struct SysemuCPUOps;
  * the caller will not g_free() it.
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
+ * @hide_reg: Check if a register must be hidden (optional)
  * address before attempting to match it against watchpoints.
  * @deprecation_note: If this CPUClass is deprecated, this field provides
  *                    related information.
@@ -167,6 +168,7 @@ struct CPUClass {
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
     vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
+    bool (*hide_reg)(CPUState *cpu, uint64_t regidex);
 
     const char *gdb_core_xml_file;
     const char * (*gdb_arch_name)(CPUState *cpu);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f85eb42d78b..bcbf45cee8d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3784,9 +3784,15 @@ bool kvm_device_supported(int vmfd, uint64_t type)
 
 int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source)
 {
+    CPUClass *cc = CPU_GET_CLASS(cs);
     struct kvm_one_reg reg;
     int r;
 
+    if (cc->hide_reg && cc->hide_reg(cs, id)) {
+        error_report("%s reg 0x%"PRIx64" is hidden and shall never been accessed",
+                     __func__, id);
+        g_assert_not_reached();
+    }
     reg.id = id;
     reg.addr = (uintptr_t) source;
     r = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
@@ -3798,9 +3804,15 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source)
 
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
 {
+    CPUClass *cc = CPU_GET_CLASS(cs);
     struct kvm_one_reg reg;
     int r;
 
+    if (cc->hide_reg && cc->hide_reg(cs, id)) {
+        error_report("%s reg 0x%"PRIx64" is hidden and shall never been accessed",
+                     __func__, id);
+        g_assert_not_reached();
+    }
     reg.id = id;
     reg.addr = (uintptr_t) target;
     r = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
-- 
2.52.0


