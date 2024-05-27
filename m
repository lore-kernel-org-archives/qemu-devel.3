Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EABC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUj0-0007ld-NA; Mon, 27 May 2024 03:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUiu-0007hD-Jj; Mon, 27 May 2024 03:24:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUis-0006Bh-ML; Mon, 27 May 2024 03:24:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2B42D6A4C1;
 Mon, 27 May 2024 10:25:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 68186D845E;
 Mon, 27 May 2024 10:24:35 +0300 (MSK)
Received: (nullmailer pid 52881 invoked by uid 1000);
 Mon, 27 May 2024 07:24:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 04/21] hw/loongarch/virt: Fix memory leak
Date: Mon, 27 May 2024 10:24:14 +0300
Message-Id: <20240527072435.52812-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Song Gao <gaosong@loongson.cn>

The char pointer 'ramName' point to a block of memory,
but never free it. Use 'g_autofree' to automatically free it.

Resolves: Coverity CID 1544773

Fixes: 0cf1478d6 ("hw/loongarch: Add numa support")
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240507022239.3113987-1-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 54c52ec719fb8c83bbde54cb87b58688ab27c166)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in hw/loongarch/virt.c due to missing-in-8.2
      v9.0.0-266-gd771ca1c10 "hw/loongarch: Move boot functions to boot.c")

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4b7dc67a2d..713ba26dff 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -749,7 +749,6 @@ static void loongarch_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
-    char *ramName = NULL;
     struct loaderparams loaderparams = { };
 
     if (!cpu_model) {
@@ -800,7 +799,7 @@ static void loongarch_init(MachineState *machine)
 
     for (i = 1; i < nb_numa_nodes; i++) {
         MemoryRegion *nodemem = g_new(MemoryRegion, 1);
-        ramName = g_strdup_printf("loongarch.node%d.ram", i);
+        g_autofree char *ramName = g_strdup_printf("loongarch.node%d.ram", i);
         memory_region_init_alias(nodemem, NULL, ramName, machine->ram,
                                  offset,  numa_info[i].node_mem);
         memory_region_add_subregion(address_space_mem, phyAddr, nodemem);
-- 
2.39.2


