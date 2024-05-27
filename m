Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1269C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVhm-0002bd-89; Mon, 27 May 2024 04:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVfA-0005Np-Mx; Mon, 27 May 2024 04:25:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVf9-0001FO-5x; Mon, 27 May 2024 04:25:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 583316A584;
 Mon, 27 May 2024 11:22:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 84F46D8521;
 Mon, 27 May 2024 11:21:41 +0300 (MSK)
Received: (nullmailer pid 66471 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 39/44] hw/loongarch: Fix fdt memory node wrong 'reg'
Date: Mon, 27 May 2024 11:21:30 +0300
Message-Id: <20240527082138.66217-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
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

The right fdt memory node like [1], not [2]

  [1]
        memory@0 {
                device_type = "memory";
                reg = <0x00 0x00 0x00 0x10000000>;
        };
  [2]
        memory@0 {
                device_type = "memory";
                reg = <0x02 0x00 0x02 0x10000000>;
        };

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240426091551.2397867-10-gaosong@loongson.cn>
(cherry picked from commit b11f9814526b833b3a052be2559457b1affad7f5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e3042af7bb..8f39254880 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -333,7 +333,7 @@ static void fdt_add_memory_node(MachineState *ms,
     char *nodename = g_strdup_printf("/memory@%" PRIx64, base);
 
     qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, 0, size);
     qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
 
     if (ms->numa_state && ms->numa_state->num_nodes) {
-- 
2.39.2


