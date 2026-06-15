Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BADCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ63X-0005Dd-FB; Mon, 15 Jun 2026 08:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZ33l-0006ly-9P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:52:45 -0400
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZ33g-0005Ot-KS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:52:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781513554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7JXHIDoJ4Z4EUEsj0Lp6DsW3Mflz5YG/zBTv4Z1pkrc=;
 b=t+3wz49XD5XXWvzxZgYVLwb2p6tXE+0CXsMekVY9iRzAYr9vRoQ8d8kMtUEnDVU5mqJTCp
 Y3tbu/gqtbfa2fRqylMQl7ZmiMdFWH73elKld8bR628RFBoz6JmwIEd72szuNRgmlcWkf4
 N3kjE5F/C2hdTu2hBAZprSIAE2cQTpg=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] target/loongarch: PV TLB flush advertisement
Date: Mon, 15 Jun 2026 16:52:12 +0800
Message-ID: <20260615085214.44526-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ae;
 envelope-from=cui.tao@linux.dev; helo=out-174.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:04:30 -0400
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

Advertise the LoongArch paravirtual TLB flush feature (KVM_FEATURE_PV_TLB_FLUSH)
to the guest when the host KVM supports it.  This pairs with the corresponding
KVM/guest-kernel PV TLB flush series posted to the kernel.

Patch 1 syncs the UAPI definitions into linux-headers.
Patch 2 adds the probe, the CPUCFG feature advertisement, and a
kvm-pv-tlb-flush CPU property (on/off/auto, default auto).

The feature is only advertised when the host actually supports it, so a
guest never observes KVM_FEATURE_PV_TLB_FLUSH on a host that cannot
service PV TLB flush requests.

Tao Cui (2):
  linux-headers: Add LoongArch PV TLB flush definitions
  target/loongarch: Enable PV TLB flush advertisement to the guest

 linux-headers/asm-loongarch/kvm.h      |  1 +
 linux-headers/asm-loongarch/kvm_para.h |  1 +
 target/loongarch/cpu.h                 |  2 ++
 target/loongarch/kvm/kvm.c             | 38 ++++++++++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c  |  4 +--
 5 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.43.0


