Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E734CCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZN5-0004re-5l; Wed, 24 Jun 2026 21:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZN2-0004rF-Pp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:59:12 -0400
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZN0-0002Mz-Gn
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:59:12 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782352740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yl+G12n6U76G5aKeImvGDrolg+9ZhWMgI25SFB+53fU=;
 b=bXi1G/dvjT9Z10YT4MpYV9qreaX+DRCAe0cRf3KQ/FfYrYpj3UWUbArIh2Aed2rW9A0uZx
 rkOQeusUP7oaJQNui16zw4vwLmxwmypNtg3WTyPvRvXXZR+bJqCklCsq09xbS5DVCYf1lI
 +YheedTzo2D8v31VNeHM4auwkjIQZHI=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/4] target/loongarch/kvm: cpucfg and device attr fixes
Date: Thu, 25 Jun 2026 09:58:30 +0800
Message-ID: <20260625015835.678819-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::bd;
 envelope-from=cui.tao@linux.dev; helo=out-189.mta0.migadu.com
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

A few small robustness fixes around cpucfg register sync and kvm device
attribute handling in the LoongArch KVM target.

  1/4: kvm_check_cpucfg2() discarded the return value of
       KVM_GET_DEVICE_ATTR and used an uninitialized val to mask
       cpucfg[2]; check the return value and initialize val.

  2/4: kvm_get_stealtime(), kvm_set_stealtime() and kvm_set_pv_features()
       pass a struct kvm_device_attr by value to the variadic
       kvm_vcpu_ioctl(), which expects a pointer. Pass &attr.

  3/4: drop the redundant trace_kvm_failed_get/put_cpucfg() calls and
       their now-unused trace events; kvm_get/set_one_reg() already trace
       on failure.

  4/4: kvm_loongarch_get/put_cpucfg() overwrite ret on each iteration, so
       only the last register's result is returned and earlier failures
       are lost; on a failed read, get_cpucfg() also stores a stale val.
       Accumulate errors with ret |= and only store on a successful read.

Compiled and boot-tested on a loongarch64 KVM host.

Tao Cui (4):
  target/loongarch/kvm: fix uninitialized val and unchecked GET in
    cpucfg2 check
  target/loongarch/kvm: pass device attr by reference to kvm_vcpu_ioctl
  target/loongarch/kvm: remove redundant cpucfg failure traces
  target/loongarch/kvm: fix cpucfg sync error handling

 target/loongarch/kvm/kvm.c    | 39 ++++++++++++++++++-----------------
 target/loongarch/trace-events |  2 --
 2 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.43.0


