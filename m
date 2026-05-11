Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC30CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOw8-0002ZJ-Pj; Mon, 11 May 2026 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+6085685b407fe13b1958+8296+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1wMOvx-0002Xi-G4; Mon, 11 May 2026 07:36:26 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+6085685b407fe13b1958+8296+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1wMOvs-0004xR-DH; Mon, 11 May 2026 07:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=OwraUMPj44azzHjsCBNcpC0TxHLfIYry5JR+tU2kWzE=; b=kGCmmJbj3kESM9ZOntfltwRahh
 LGPM2byfft+6VWPkiJE2LPJ1HH9tWTb4mvcFRky9RRA1MVtUj1osdAIt1ps2TDTQFzVj8XAk6JxXQ
 PReIuNpManjsHCT9IE2r4T6mfNclw4hyIDJ+y81CU8JJwR8XmfDJW1yuvczUushyidC6b+1ouCUxF
 EduelHUEKP3nOrEpkVV/LheMBej2HIs7jjByoOLJ00mayZ34bHTcJtfTmkbzeLJSO8pzv/8BU1DDg
 mEkaoYRwQxevwZhXWeoZmQq1epXoIpGGKEB8e9RpvgWQpR2lN6Ob1xbHsWdKshTnbgOJrnQ5fBupg
 ZFeb3lxA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMOvY-000000084dN-2GkW; Mon, 11 May 2026 11:36:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1wMOvY-0000000Dx0g-1DlN;
 Mon, 11 May 2026 12:36:00 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Sascha Bischoff <Sascha.Bischoff@arm.com>,
 Eric Auger <eric.auger@redhat.com>,
 Raghavendra Rao Ananta <rananta@google.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Kees Cook <kees@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] KVM: arm64: selftests: Add GICv2 IGROUPR writability
 test
Date: Mon, 11 May 2026 12:30:46 +0100
Message-ID: <20260511113558.3325004-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511113558.3325004-1-dwmw2@infradead.org>
References: <20260511113558.3325004-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+6085685b407fe13b1958+8296+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Test that GICv2 IGROUPR writability is consistently gated by the IIDR
implementation revision for both guest and userspace paths:

  Default (no IIDR write): implementation_rev defaults to 3, groups
    writable from both guest and userspace.
  Rev 1: IGROUPR reads as zero (group 0), writes ignored from both
    guest and userspace.
  Rev 2: IGROUPR is writable from both guest and userspace.

This test requires GICv2 emulation support (GICv3 with GICv2 compat
CPU interface) and will be skipped on hardware without it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/arm64/vgic_group_v2.c       | 226 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/arm64/vgic_group_v2.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 8cadfed4d79a..6bc295d0b776 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -178,6 +178,7 @@ TEST_GEN_PROGS_arm64 += arm64/set_id_regs
 TEST_GEN_PROGS_arm64 += arm64/smccc_filter
 TEST_GEN_PROGS_arm64 += arm64/vcpu_width_config
 TEST_GEN_PROGS_arm64 += arm64/vgic_group_iidr
+TEST_GEN_PROGS_arm64 += arm64/vgic_group_v2
 TEST_GEN_PROGS_arm64 += arm64/vgic_init
 TEST_GEN_PROGS_arm64 += arm64/vgic_irq
 TEST_GEN_PROGS_arm64 += arm64/vgic_lpi_stress
diff --git a/tools/testing/selftests/kvm/arm64/vgic_group_v2.c b/tools/testing/selftests/kvm/arm64/vgic_group_v2.c
new file mode 100644
index 000000000000..f2b384a816ba
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/vgic_group_v2.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vgic_group_v2.c - Test GICv2 IGROUPR behaviour across IIDR revisions
+ *
+ * Validate that the GICD_IIDR implementation revision controls GICv2
+ * IGROUPR writability for both guest and userspace:
+ *   Default (no IIDR write): groups writable (implementation_rev defaults to 3)
+ *   Rev 1: IGROUPR reads as zero (group 0), writes ignored
+ *   Rev 2: IGROUPR is guest and userspace configurable
+ */
+#include <linux/sizes.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "gic.h"
+#include "gic_v3.h"
+#include "vgic.h"
+
+#define NR_IRQS		64
+
+#define V2_DIST_BASE	0x8000000ULL
+#define V2_CPU_BASE	0x8010000ULL
+#define V2_DIST_GVA	((volatile void *)V2_DIST_BASE)
+
+#define SPI_IGROUPR	(GICD_IGROUPR + (32 / 32) * 4)
+
+static uint64_t shared_rev;
+static uint64_t guest_result;
+
+static void guest_code(void)
+{
+	uint32_t before, after;
+
+	before = readl(V2_DIST_GVA + SPI_IGROUPR);
+	writel(0x5a5a5a5a, V2_DIST_GVA + SPI_IGROUPR);
+	after = readl(V2_DIST_GVA + SPI_IGROUPR);
+
+	guest_result = ((uint64_t)before << 32) | after;
+	GUEST_DONE();
+}
+
+static int create_v2_gic(struct kvm_vm *vm)
+{
+	uint32_t nr_irqs = NR_IRQS;
+	uint64_t addr;
+	int gic_fd;
+
+	gic_fd = __kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V2);
+	if (gic_fd < 0)
+		return gic_fd;
+
+	addr = V2_DIST_BASE;
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			    KVM_VGIC_V2_ADDR_TYPE_DIST, &addr);
+	addr = V2_CPU_BASE;
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			    KVM_VGIC_V2_ADDR_TYPE_CPU, &addr);
+
+	virt_map(vm, V2_DIST_BASE, V2_DIST_BASE,
+		 vm_calc_num_guest_pages(vm->mode, SZ_64K));
+	virt_map(vm, V2_CPU_BASE, V2_CPU_BASE,
+		 vm_calc_num_guest_pages(vm->mode, SZ_64K));
+
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
+			    0, &nr_irqs);
+	return gic_fd;
+}
+
+static void run_test(int set_iidr_rev)
+{
+	struct kvm_vcpu *vcpus[1];
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint32_t before, after, igroupr, iidr;
+	int gic_fd;
+	bool expect_writable;
+
+	if (set_iidr_rev >= 0)
+		pr_info("Testing GICv2 IIDR revision %d\n", set_iidr_rev);
+	else
+		pr_info("Testing GICv2 IIDR default (no write)\n");
+
+	test_disable_default_vgic();
+	vm = vm_create_with_vcpus(1, guest_code, vcpus);
+
+	gic_fd = create_v2_gic(vm);
+	TEST_REQUIRE(gic_fd >= 0);
+
+	if (set_iidr_rev >= 0) {
+		kvm_device_attr_get(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+				    GICD_IIDR, &iidr);
+		iidr &= ~GICD_IIDR_REVISION_MASK;
+		iidr |= set_iidr_rev << GICD_IIDR_REVISION_SHIFT;
+		kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+				    GICD_IIDR, &iidr);
+	}
+
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
+
+	/*
+	 * Default (no IIDR write) gets implementation_rev=3 from vgic_init(),
+	 * so groups should be writable. Rev 1 = not writable. Rev 2+ = writable.
+	 */
+	expect_writable = (set_iidr_rev != 1);
+
+	/* Test userspace IGROUPR write */
+	igroupr = 0xa5a5a5a5;
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+			    SPI_IGROUPR, &igroupr);
+	igroupr = 0;
+	kvm_device_attr_get(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+			    SPI_IGROUPR, &igroupr);
+
+	if (expect_writable)
+		TEST_ASSERT(igroupr == 0xa5a5a5a5,
+			    "Userspace write should succeed: got 0x%08x", igroupr);
+	else
+		TEST_ASSERT(igroupr == 0x00000000,
+			    "Userspace write should be ignored: got 0x%08x", igroupr);
+
+	/* Reset IGROUPR to 0 via userspace for rev 2+ before guest test */
+	if (expect_writable) {
+		igroupr = 0;
+		kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+				    SPI_IGROUPR, &igroupr);
+	}
+
+	/* Test guest IGROUPR write */
+	sync_global_to_guest(vm, guest_result);
+	vcpu_run(vcpus[0]);
+
+	switch (get_ucall(vcpus[0], &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+
+	sync_global_from_guest(vm, guest_result);
+	before = guest_result >> 32;
+	after = guest_result & 0xffffffff;
+
+	TEST_ASSERT(before == 0x00000000,
+		    "Initial IGROUPR should be 0 (group 0): got 0x%08x", before);
+
+	if (expect_writable)
+		TEST_ASSERT(after == 0x5a5a5a5a,
+			    "Guest write should succeed: got 0x%08x", after);
+	else
+		TEST_ASSERT(after == 0x00000000,
+			    "Guest write should be ignored: got 0x%08x", after);
+
+	close(gic_fd);
+	kvm_vm_free(vm);
+}
+
+/*
+ * Test QEMU-style save/restore: the guest writes IGROUPR, then userspace
+ * reads it back (save) and writes it again (restore) — all without ever
+ * writing GICD_IIDR.  This exercises the bug where v2_groups_user_writable
+ * gated userspace writes but not guest writes, so userspace could observe
+ * guest-modified groups but couldn't restore them.
+ */
+static void run_save_restore_test(void)
+{
+	struct kvm_vcpu *vcpus[1];
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint32_t igroupr;
+	int gic_fd;
+
+	pr_info("Testing GICv2 IGROUPR save/restore (no IIDR write)\n");
+
+	test_disable_default_vgic();
+	vm = vm_create_with_vcpus(1, guest_code, vcpus);
+
+	gic_fd = create_v2_gic(vm);
+	TEST_REQUIRE(gic_fd >= 0);
+
+	/* Do NOT write GICD_IIDR — mimicking QEMU */
+
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
+
+	/* Let the guest write 0x5a5a5a5a to IGROUPR */
+	sync_global_to_guest(vm, guest_result);
+	vcpu_run(vcpus[0]);
+	TEST_ASSERT(get_ucall(vcpus[0], &uc) == UCALL_DONE,
+		    "Guest failed");
+
+	/* Save: userspace reads IGROUPR — should see guest's write */
+	igroupr = 0;
+	kvm_device_attr_get(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+			    SPI_IGROUPR, &igroupr);
+	TEST_ASSERT(igroupr == 0x5a5a5a5a,
+		    "Save: expected 0x5a5a5a5a, got 0x%08x", igroupr);
+
+	/* Restore: userspace writes a different value — should succeed */
+	igroupr = 0x12345678;
+	kvm_device_attr_set(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+			    SPI_IGROUPR, &igroupr);
+
+	/* Verify: read back should reflect the restore */
+	igroupr = 0;
+	kvm_device_attr_get(gic_fd, KVM_DEV_ARM_VGIC_GRP_DIST_REGS,
+			    SPI_IGROUPR, &igroupr);
+	TEST_ASSERT(igroupr == 0x12345678,
+		    "Restore: expected 0x12345678, got 0x%08x", igroupr);
+
+	close(gic_fd);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	run_test(-1);  /* default */
+	run_test(1);   /* rev 1 */
+	run_test(2);   /* rev 2 */
+	run_save_restore_test();
+	return 0;
+}
-- 
2.51.0


