Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33733CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1SbQ-0008L1-Gk; Wed, 24 Sep 2025 12:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Sb1-0008Ih-Ee
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:44:01 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Sap-0000zp-Fe
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:43:59 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55ce508d4d6so6206112e87.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758732223; x=1759337023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E92Sk4SPBUbSpMQbQtf55NOqIlFUSOxuPXOd/rMzn0s=;
 b=XI/V+YxcniPF0uxT1v5iUS11abKJb+zSET5G0xdEdjehf4ASQGmre7ANmTH2+3HbEh
 8xiLmUYWKOkxUKkusDU7HEsHkzoyKI2cks6W1CmPpgcR/iOzikn5nK1N31106m5KT3XU
 fIltlw/O9frLNGf3ArhHChMYFvf5XQ1yJaBBFdJO/qkE1FZ7+CGVwZyhHB+CdAcxHCxk
 Rxv+GIFRVBCZLWZXy75wr3cSDVeeXrnI3s6hgoFl83kRXAkORL1NWhYbtr/0HXTfJLZF
 fH1DT/HR0ZqNb1MQBrYnhPKipgjDT/UFxy+V8wyEfGCKn6UY35abfSns6SJW9r1ZwiFs
 Oiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732223; x=1759337023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E92Sk4SPBUbSpMQbQtf55NOqIlFUSOxuPXOd/rMzn0s=;
 b=CHR7zdlJPNjiqgOuQ/Zf0KT8epOoQOIPlPI7Vs8TO3XII0Pj5QF/81H+BhQIvK/yI9
 nyVF7JeK+GbRf2PRFqtZdVK2YZ9dV7PYTCN3/1qW34IK9QIfXYaZcmoADoQgNVx1fJFh
 ArJCytC9pNoz4q5bhV+GtA1ixTu8GeQKCtYdJ9rrQPLOiH/Wq1OdOIvVdwUk2lxAJcNh
 NuLVoiu38PHZzsZmGy3Uy5VgypTQfsDyAC2wHKJ4qB4az/hy96w+901R8nCbB8JcoCif
 q24xjHS3dCnYLwrwN0XCCGcxVwFPpVRzrJIpgX8fiqBfy7ow2g0cMCYkq3BKvNu1MO0a
 GeVQ==
X-Gm-Message-State: AOJu0Yy50t8TDjGhqLWPxd8WcUxoAjjRIdyF6+SwGN9ItWGFkCTkGhhW
 YORPRdub0may2ozYo/4KeXpMrFYti/LR86Q5K5vriWD3W5k+K6GjEcns9oUR0ln4bisz4j+qTk9
 MoiaSC6zHog==
X-Gm-Gg: ASbGncvoxHryb47eAi54QcqrcYak10J7TvjzONLQ4e8sRERUvqM5DZT7+XtrYdL2IGa
 6E8IucNC5cM/OPFK3Whcxk18S7//GB6IV06Nz1w2gFczQxFFxzuf8G3WnKJ9pEvNYaJboBQ1eO/
 9+ygq/KDsfn61zqpu1z/yl5YS1evPTvrBiE7D5qslypCF8LXlTRq4ARRFpVHAHF4UVnvDGeDFkC
 YbX+yprIDMzCKazkZukSyHzXXrwHLi7nGG5yRI009uxbRdknpvHcZScl2CiKfeSgDIB4LVjIWWy
 zCcxIh9Lp+eTucuMdF80QSzv2iaVuA1sZ18rUXHvrQMLWhaQCyc93bmW8QuihQ6uGsfYi/gV7dm
 YM5DE7YvEBWDd9XaNneCzotptNf42jSnisIg3Z4qeSSWxNvt9hR17YfuAeL/rb5BMbjiM2/1dtw
 qFfH78Fv4=
X-Google-Smtp-Source: AGHT+IH3PwzLGvqFU0zVPn86CPx+bgUrZZSFcQkdIoFv4SUd+3dj5hmjWDfawgMN5lCSXkCzSxLg3A==
X-Received: by 2002:a05:6000:2410:b0:3ee:13ba:e133 with SMTP id
 ffacd0b85a97d-40e4354d631mr586118f8f.1.1758732210993; 
 Wed, 24 Sep 2025 09:43:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-407f579c1e9sm5662534f8f.46.2025.09.24.09.43.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 09:43:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Darren Kenny <darren.kenny@oracle.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/avr: Mark I/O space mapped cpu regs as reentrancy-safe
Date: Wed, 24 Sep 2025 18:43:29 +0200
Message-ID: <20250924164329.51644-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The test_avr_mega2560.py functional test hangs displaying:

  qemu-system-avr: warning: Blocked re-entrant IO on MemoryRegion: avr-cpu-reg2 at addr: 0x5

Mark the I/O space mapped cpu regs as reentrancy-safe to avoid that.

Process 71455 stopped
* thread #4, stop reason = breakpoint 1.1
    frame #0: 0x1000a2d30 access_with_adjusted_size(addr=5, value=0x16ff9e4f0, size=1, access_size_min=<unavailable>, access_size_max=4, access_fn=(memory_region_read_accessor at memory.c:435), mr=0x12101bce0, attrs=MemTxAttrs @ x7) at memory.c:547:13
   544 	    if (mr->dev && !mr->disable_reentrancy_guard &&
   545 	        !mr->ram_device && !mr->ram && !mr->rom_device && !mr->readonly) {
   546 	        if (mr->dev->mem_reentrancy_guard.engaged_in_io) {
-> 547 	            warn_report_once("Blocked re-entrant IO on MemoryRegion: "
   548 	                             "%s at addr: 0x%" HWADDR_PRIX,
   549 	                             memory_region_name(mr), addr);
   550 	            return MEMTX_ACCESS_ERROR;
Target 0: (qemu-system-avr) stopped.
(lldb) bt
* thread #4, stop reason = breakpoint 1.1
  * frame #0: 0x1000a2d30 access_with_adjusted_size(addr=5, value=0x16ff9e4f0, size=1, access_size_min=<unavailable>, access_size_max=4, access_fn=(memory_region_read_accessor at memory.c:435), mr=0x12101bce0, attrs=MemTxAttrs @ x7) at memory.c:547:13
    frame #1: 0x1000a27a4 memory_region_dispatch_read [inlined] memory_region_dispatch_read1(mr=0x12101bce0, addr=5, pval=0x16ff9e4f0, size=1, attrs=MemTxAttrs @ x21) at memory.c:0
    frame #2: 0x1000a2768 memory_region_dispatch_read(mr=0x12101bce0, addr=5, pval=<unavailable>, op=<unavailable>, attrs=<unavailable>) at memory.c:1484:9
    frame #3: 0x1000af89c flatview_read_continue_step(attrs=MemTxAttrs @ x24, buf="", len=<unavailable>, mr_addr=5, l=0x16ff9e568, mr=0x12101bce0) at physmem.c:3061:18
    frame #4: 0x1000afb4c flatview_read [inlined] flatview_read_continue(fv=0x0000600003993b40, addr=8388701, attrs=MemTxAttrs @ x21, ptr=0x16ff9e5c0, len=1, mr_addr=5, l=1, mr=<unavailable>) at physmem.c:3102:19
    frame #5: 0x1000afb3c flatview_read(fv=0x0000600003993b40, addr=8388701, attrs=MemTxAttrs @ x21, buf=0x16ff9e5c0, len=1) at physmem.c:3132:12
    frame #6: 0x1000b50bc subpage_read(opaque=<unavailable>, addr=<unavailable>, data=0x16ff9e630, len=1, attrs=<unavailable>) at physmem.c:2615:11
    frame #7: 0x1000a9150 memory_region_read_with_attrs_accessor(mr=0x104096400, addr=93, value=0x16ff9e790, size=1, shift=0, mask=255, attrs=<unavailable>) at memory.c:461:9
    frame #8: 0x1000a2c9c access_with_adjusted_size(addr=93, value=<unavailable>, size=<unavailable>, access_size_min=<unavailable>, access_size_max=<unavailable>, access_fn=<unavailable>, mr=<unavailable>, attrs=<unavailable>) at memory.c:566:18
    frame #9: 0x1000a27a4 memory_region_dispatch_read [inlined] memory_region_dispatch_read1(mr=0x104096400, addr=93, pval=0x16ff9e790, size=1, attrs=MemTxAttrs @ x21) at memory.c:0
    frame #10: 0x1000a2768 memory_region_dispatch_read(mr=0x104096400, addr=93, pval=<unavailable>, op=<unavailable>, attrs=<unavailable>) at memory.c:1484:9
    frame #11: 0x100163034 do_ld_mmio_beN [inlined] int_ld_mmio_beN(cpu=<unavailable>, full=<unavailable>, ret_be=0, addr=93, size=1, mmu_idx=<unavailable>, type=<unavailable>, ra=<unavailable>, mr=<unavailable>, mr_offset=93) at cputlb.c:1963:13
    frame #12: 0x100163004 do_ld_mmio_beN(cpu=0x121018ec0, full=0x121027400, ret_be=<unavailable>, addr=<unavailable>, size=<unavailable>, mmu_idx=1, type=MMU_DATA_LOAD, ra=12884916912) at cputlb.c:1997:12
    frame #13: 0x1001536f0 helper_ldub_mmu [inlined] do_ld_1(cpu=<unavailable>, p=0x16ff9e800, mmu_idx=<unavailable>, type=MMU_DATA_LOAD, ra=12884916912) at cputlb.c:2262:16
    frame #14: 0x1001536dc helper_ldub_mmu [inlined] do_ld1_mmu(cpu=<unavailable>, addr=<unavailable>, oi=<unavailable>, ra=<unavailable>, access_type=MMU_DATA_LOAD) at cputlb.c:2338:12
    frame #15: 0x1001536dc helper_ldub_mmu(env=0x12101baf0, addr=<unavailable>, oi=<unavailable>, retaddr=12884916912) at ldst_common.c.inc:19:12
    frame #16: 0x300003ae4
    frame #17: 0x10013c6dc cpu_tb_exec(cpu=<unavailable>, itb=<unavailable>, tb_exit=<unavailable>) at cpu-exec.c:439:11
    frame #18: 0x10013d418 cpu_exec_loop [inlined] cpu_loop_exec_tb(cpu=0x121018ec0, tb=<unavailable>, pc=<unavailable>, last_tb=<unavailable>, tb_exit=0x16ff9ee0c) at cpu-exec.c:878:10
    frame #19: 0x10013d400 cpu_exec_loop(cpu=0x121018ec0, sc=0x16ff9eed0) at cpu-exec.c:991:13
    frame #20: 0x10013cc00 cpu_exec_setjmp(cpu=0x121018ec0, sc=0x16ff9eed0) at cpu-exec.c:1011:12
    frame #21: 0x10013cb24 cpu_exec(cpu=0x121018ec0) at cpu-exec.c:1037:11
    frame #22: 0x100165830 tcg_cpu_exec(cpu=0x121018ec0) at tcg-accel-ops.c:98:11
    frame #23: 0x10016607c mttcg_cpu_thread_routine [inlined] mttcg_cpu_exec(cpu=0x121018ec0) at tcg-accel-ops-mttcg.c:154:11
    frame #24: 0x100166070 mttcg_cpu_thread_routine(arg=0x121018ec0) at tcg-accel-ops-mttcg.c:113:21
    frame #25: 0x100334218 qemu_thread_start(args=<unavailable>) at qemu-thread-posix.c:393:9

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a6df71d0205..306c3590f23 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -151,6 +151,7 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
 
     memory_region_init_io(&cpu->cpu_reg2, OBJECT(cpu), &avr_cpu_reg2, env,
                           "avr-cpu-reg2", 8);
+    cpu->cpu_reg2.disable_reentrancy_guard = true;
     memory_region_add_subregion(get_system_memory(),
                                 OFFSET_DATA + 0x58, &cpu->cpu_reg2);
 }
-- 
2.51.0


