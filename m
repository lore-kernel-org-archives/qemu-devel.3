Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB0DC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFe-0002hL-P6; Fri, 31 Jul 2026 01:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeMA-0005v1-EM; Thu, 30 Jul 2026 23:56:22 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM8-0002Jd-Mp; Thu, 30 Jul 2026 23:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470176; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=g1senpRrIBKAyuBFOowp2ZlL3plOZU6OwVUYin/8o/Q=;
 b=U6TV8DUNGzMY4fCtIN1BHCZsyDf8bPLDMNrxQhQIcXBTMMp2Xx35fOmIVLd5GXyUUJBe5ALQQUsDAfKpDloFkM+nmoNWBjllAevF0ZX2LYxlEOK6gbSh/oZTUmjS1NqJABQyOrxkMnH1vTHLhNpFu4PV2uHy9am1IaDLUasVA9E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwXT_1785469863; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwXT_1785469863 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:51:04 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 16/17] accel/kvm: terminate on a system event of a CoVE
 guest
Date: Fri, 31 Jul 2026 11:50:10 +0800
Message-Id: <20260731035011.4178103-17-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
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

The TSM does not honour a power off request for a TEE VM: the vCPU
re-enters KVM_RUN and reports the same system event again, so QEMU never
shuts the guest down.  Terminate the process instead.

This works around a missing piece of the TSM ABI rather than something
QEMU should be doing.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 accel/kvm/kvm-all.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7b33a9aa3a..938bbebcd1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3613,6 +3613,17 @@ int kvm_cpu_exec(CPUState *cpu)
             break;
         case KVM_EXIT_SYSTEM_EVENT:
             trace_kvm_run_exit_system_event(cpu->cpu_index, run->system_event.type);
+            /*
+             * The TSM does not honour power_off for a TVM: the vCPU would
+             * re-enter KVM_RUN and report the same event forever, so
+             * terminate QEMU right away.
+             */
+            if (riscv_cove_vm_active()) {
+                warn_report("CoVE VM: system event %d, terminating",
+                            run->system_event.type);
+                exit(run->system_event.type == KVM_SYSTEM_EVENT_SHUTDOWN ?
+                     0 : 1);
+            }
             switch (run->system_event.type) {
             case KVM_SYSTEM_EVENT_SHUTDOWN:
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-- 
2.34.1


