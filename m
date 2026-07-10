Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6A9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 00:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whzS6-00009W-Jk; Thu, 09 Jul 2026 20:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS3-00008v-7Z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:47 -0400
Received: from out-184.mta0.migadu.com ([2001:41d0:1004:224b::b8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS1-0005dD-44
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:47 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783644639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RhHtW2icY+xvS+w/LmbdvKpn6cXmtf66tQcvtAixaj8=;
 b=xUPouLoxYQiKRzmhFoTOKXr4L9ph494qSghGDcWMp9YrsbItvGnE4wfE85HBCtYulv19ar
 PDI+7Y7IA3PPXDuc25malqHXiDFQDCbXnpjm3hXUoVhTLvRdaqHToF1x34NwXVni+8u9vO
 u2KgwUsIWjF8mbBSrGAopXWReRzkumM=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 0/3] target/loongarch: advertise pv features per vCPU
Date: Fri, 10 Jul 2026 08:50:26 +0800
Message-ID: <20260710005029.345378-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b8;
 envelope-from=cui.tao@linux.dev; helo=out-184.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tao Cui <cuitao@kylinos.cn>

kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
per-vCPU setting, but it was called from kvm_arch_put_registers() under a
function-local static guard and so ran only once for the whole VM: only the
first vCPU got its pv features pushed to KVM, and on SMP guests the others
never saw KVM_FEATURE_IPI / KVM_FEATURE_STEAL_TIME.

  1/3: drop the static guard and push pv features per vCPU under
       KVM_PUT_FULL_STATE, like kvm_set_stealtime(); host detection stays in
       kvm_arch_init_vcpu().
  2/3: add pv_features (the value of pseudo-register CPUCFG_KVM_FEATURE) to
       the vCPU VMState as a subsection so it travels across migration.
  3/3: add a no_pv_feature compat flag (LoongArchCPU + virt machine class)
       so the new behavior is gated per machine version: 11.1 keeps pv
       advertisement off, the new 11.2 enables it.

Compiled and boot-tested on a loongarch64 KVM host; migration verified
virt-11.2->virt-11.2 and virt-11.1->virt-11.1.

Changes in v2 (per Bibo Mao's review):
- Revert v1's move to kvm_arch_init_vcpu(); keep kvm_set_pv_features() in
  kvm_arch_put_registers(), drop the static guard, push per vCPU under
  KVM_PUT_FULL_STATE.
- Migrate pv_features (CPUCFG_KVM_FEATURE) via a VMState subsection.
- Add no_pv_feature compat flag: 11.1 off, 11.2 on.
- Split into three patches (fix / migrate / compat).

Tao Cui (3):
  target/loongarch/kvm: advertise pv features per vCPU
  target/loongarch: migrate pv_features in the vCPU VMState
  target/loongarch: add no_pv_feature compat flag

 hw/loongarch/virt.c         | 14 +++++++++++++-
 include/hw/loongarch/virt.h |  9 ++++++++-
 target/loongarch/cpu.h      |  1 +
 target/loongarch/kvm/kvm.c  | 20 +++++++++++---------
 target/loongarch/machine.c  | 19 +++++++++++++++++++
 5 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.43.0


