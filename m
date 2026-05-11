Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF586CD4842
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOwE-0002ab-Gw; Mon, 11 May 2026 07:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+667e1f4f50efa285cc0a+8296+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1wMOvy-0002Xk-7y; Mon, 11 May 2026 07:36:26 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+667e1f4f50efa285cc0a+8296+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1wMOvv-0004xu-4v; Mon, 11 May 2026 07:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=wvcz1NQ1762dWyW3ikY0T2Hu3cBKQuR9OWUU0jS07tQ=; b=BLRc22X8JobnVWQx1+w28cGjTs
 P1+3b1A6VDdwLivNi/8y4wi33PZq9BlyUH+hxqjqPGRkD5bEskzLCIUva597dRmJJf5ENwTtNMGhM
 e48FcpfH11lIXmG1/+gDixtEVjCkZDP8c3db+s67jZA07VRzP4Ahdbo3oqnhMCLajZnmFDfz1hHB2
 Ufw3J1fc/Quz5MlvlRJ2niZ4vCb8MOmiv+268PXylNSqQQ6IfTJsWcqJdXY7O1RIZ3wBfiyL3I6eK
 +73Go0bqEsS5w3Uewv1iSXLdk+aoicmZywLC6nqN9jVAs3EnKUyjyBjEV+pCNm+AutV0hTkrFZI8Y
 ktN2IYBQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMOvZ-0000000BUT9-285J; Mon, 11 May 2026 11:36:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1wMOvY-0000000Dx0c-14Kk;
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
Subject: [PATCH v3 3/4] KVM: arm64: vgic: Remove v2_groups_user_writable and
 use IIDR revision directly
Date: Mon, 11 May 2026 12:30:45 +0100
Message-ID: <20260511113558.3325004-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511113558.3325004-1-dwmw2@infradead.org>
References: <20260511113558.3325004-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+667e1f4f50efa285cc0a+8296+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

The v2_groups_user_writable flag was introduced to gate GICv2 userspace
IGROUPR writes until userspace explicitly wrote the IIDR, signalling
awareness of the group semantics. However, the guest write path through
vgic_mmio_write_group() was never gated by this flag, allowing a GICv2
guest to modify interrupt groups regardless of whether userspace had
opted in.

Rather than adding the same flag check to the guest path, remove the
flag entirely and make both guest and userspace IGROUPR writability
follow the IIDR implementation revision directly. Groups are writable
when the revision is >= 2, which is the case when userspace explicitly
sets the IIDR to revision 2 or 3. When userspace does not write the
IIDR, vgic_init() defaults to KVM_VGIC_IMP_REV_LATEST (currently 3),
so the behaviour is unchanged for userspace that doesn't set the IIDR.

This also fixes the inconsistency where GICv2 userspace could not write
IGROUPR at the default revision, even though the guest could.

As far as I can tell, QEMU commit eb8b9530b0c ("hw/intc/arm_gic_kvm.c:
Save and restore GICD_IGROUPRn state") made QEMU attempt to save/restore
the GICD_IGROUPR registers (which, again, are guest-writable but not
userspace-writable by default) without ever actually setting GICD_IIDR.

Fixes: 32f8777ed92d ("KVM: arm/arm64: vgic: Let userspace opt-in to writable v2 IGROUPR")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/kvm/vgic/vgic-mmio-v2.c | 16 +++++-----------
 include/kvm/arm_vgic.h             |  3 ---
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v2.c b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
index e5714f7fd2ec..e5fc673a1ea9 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
@@ -84,21 +84,15 @@ static int vgic_mmio_uaccess_write_v2_misc(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 
 		/*
-		 * If we observe a write to GICD_IIDR we know that userspace
-		 * has been updated and has had a chance to cope with older
-		 * kernels (VGICv2 IIDR.Revision == 0) incorrectly reporting
-		 * interrupts as group 1, and therefore we now allow groups to
-		 * be user writable.  Doing this by default would break
-		 * migration from old kernels to new kernels with legacy
-		 * userspace.
+		 * Allow userspace to select the GICv2 IIDR revision.
+		 * Group writability follows the revision directly:
+		 * groups are guest/user writable for revision >= 2.
 		 */
 		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, val);
 		switch (reg) {
+		case KVM_VGIC_IMP_REV_1:
 		case KVM_VGIC_IMP_REV_2:
 		case KVM_VGIC_IMP_REV_3:
-			vcpu->kvm->arch.vgic.v2_groups_user_writable = true;
-			fallthrough;
-		case KVM_VGIC_IMP_REV_1:
 			dist->implementation_rev = reg;
 			return 0;
 		default:
@@ -114,7 +108,7 @@ static int vgic_mmio_uaccess_write_v2_group(struct kvm_vcpu *vcpu,
 					    gpa_t addr, unsigned int len,
 					    unsigned long val)
 {
-	if (vcpu->kvm->arch.vgic.v2_groups_user_writable)
+	if (vgic_get_implementation_rev(vcpu) >= KVM_VGIC_IMP_REV_2)
 		vgic_mmio_write_group(vcpu, addr, len, val);
 
 	return 0;
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 16811ec03d54..a9490e43d98d 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -377,9 +377,6 @@ struct vgic_dist {
 #define KVM_VGIC_IMP_REV_3	3 /* GICv3 GICR_CTLR.{IW,CES,RWP} */
 #define KVM_VGIC_IMP_REV_LATEST	KVM_VGIC_IMP_REV_3
 
-	/* Userspace can write to GICv2 IGROUPR */
-	bool			v2_groups_user_writable;
-
 	/* Do injected MSIs require an additional device ID? */
 	bool			msis_require_devid;
 
-- 
2.51.0


