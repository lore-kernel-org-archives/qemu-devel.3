Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C91FC9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksV-0008CC-9o; Sun, 27 Sep 2026 05:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrA-00022Q-AH; Sun, 27 Sep 2026 05:07:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkr8-0008C3-BX; Sun, 27 Sep 2026 05:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=mIvXdJUxUMhLAEdO2CPFT9e+y7xZtouO3Jy/dliCiKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=atQhXKO8VlTJvBgAbN0Jm1gMv3JuAQ0XiK1up7kEJdXIbChYPB/1ErRuokjHOrJzj
 6yibIYlCsIoPesXx8BFZKh2Mcg2tco76F5hfVduIrbQ243TIWxR/uS77TRXNJfFE8b
 72YWwY2+mWE7FJfb6yjioPekw8a7dgXf3AUqDwBev+EvC20AlFiTD8karHFUHGl02t
 THaQxZ3f0cRtx9v1piAYN/kj8Z+z2DHPHhKxiOxPV7pfSNrwV3IO6EhYSeV7vmic2V
 4PPwLocw+KyLFhGnAjxGVVycNbjZ16lQM/CPMPz0mI9Va8JmzyJaHX01xsJvaVl/fN
 GoWeaUpCmhKYA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65F211D8B20;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 635034320D9;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E0D585E671; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 79/86] target/ppc: Stop vCPU thread before calling
 parent_unrealize
Date: Sun, 27 Sep 2026 12:05:26 +0300
Message-ID: <20260927090540.102811-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

During CPU hot-unplug (e.g. via dynamic reconfiguration unplug),
ppc_cpu_unrealize() invoked pcc->parent_unrealize(dev) before calling
cpu_remove_sync(CPU(cpu)).

pcc->parent_unrealize() calls cpu_common_unrealize(), which triggers
accel_cpu_common_unrealize() -> tcg_exec_unrealizefn() -> tlb_destroy().
This immediately frees the CPU's TLB tables and structures. Because the
vCPU thread had not yet been stopped and joined via cpu_remove_sync(),
the vCPU thread was still actively running its event loop and processing
queued CPU work (such as tcg_commit_cpu / tlb_flush).

This resulted in a race where the running vCPU thread accessed and freed
already-destroyed TLB tables concurrently with tlb_destroy(), leading to
Segfault (due to heap corruption).

AddressSanitizer build reported a double-free:

=================================================================
==121930==ERROR: AddressSanitizer: attempting double-free on 0x7ef8f3438800 in thread T14:
    #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
    #2 0x558bf6a391b1 in tlb_mmu_resize_locked accel/tcg/cputlb.c:249
    #3 0x558bf6a396b5 in tlb_flush_one_mmuidx_locked accel/tcg/cputlb.c:296
    #4 0x558bf6a39f91 in tlb_flush_by_mmuidx_async_work accel/tcg/cputlb.c:390
    #5 0x558bf6a3a200 in tlb_flush_by_mmuidx accel/tcg/cputlb.c:417
    #6 0x558bf6a3a22a in tlb_flush accel/tcg/cputlb.c:422
    #7 0x558bf73f31ac in tcg_commit_cpu system/physmem.c:3068
    #8 0x558bf6987c55 in process_queued_cpu_work cpu-common.c:378
    #9 0x558bf73a9913 in qemu_process_cpu_events_common system/cpus.c:402
    #10 0x558bf73a9a46 in qemu_process_cpu_events system/cpus.c:421
    #11 0x558bf6a65974 in mttcg_cpu_thread_fn accel/tcg/tcg-accel-ops-mttcg.c:90

0x7ef8f3438800 is located 0 bytes inside of 65536-byte region [0x7ef8f3438800,0x7ef8f3448800)
freed by thread T9 here:
    #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
    #2 0x558bf6a39a91 in tlb_destroy accel/tcg/cputlb.c:345
    #3 0x558bf6a16354 in tcg_exec_unrealizefn accel/tcg/cpu-exec.c:1094
    #4 0x558bf693d073 in accel_cpu_common_unrealize accel/accel-common.c:117
    #5 0x558bf6980e37 in cpu_common_unrealize hw/core/cpu-common.c:279
    #6 0x558bf6980dfa in cpu_common_unrealizefn hw/core/cpu-common.c:267
    #7 0x558bf763ef65 in ppc_cpu_unrealize target/ppc/cpu_init.c:6965
    #8 0x558bf7872199 in device_set_realized hw/core/qdev.c:618
    #14 0x558bf756068f in spapr_unrealize_vcpu hw/ppc/spapr_cpu_core.c:209

Fix this by moving cpu_remove_sync() before pcc->parent_unrealize(dev)
in ppc_cpu_unrealize(), ensuring the vCPU thread is stopped, has
finished processing its events, and is joined before CPU resources
and accelerator state are destroyed.

Cc: qemu-stable@nongnu.org
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Message-ID: <20260923121444.154175-1-shivangu@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit cbbd4d74eb298e2b407018185a40cb813435527e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 191f5726f69..e9f51943979 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6969,10 +6969,10 @@ static void ppc_cpu_unrealize(DeviceState *dev)
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    pcc->parent_unrealize(dev);
-
     cpu_remove_sync(CPU(cpu));
 
+    pcc->parent_unrealize(dev);
+
     destroy_ppc_opcodes(cpu);
 }
 
-- 
2.47.3


