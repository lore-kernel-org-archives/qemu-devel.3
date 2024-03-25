Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA23C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rok4y-0004Da-52; Mon, 25 Mar 2024 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rok4w-0004DM-0N; Mon, 25 Mar 2024 09:09:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rok4u-0002yO-5J; Mon, 25 Mar 2024 09:09:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F345058BAD;
 Mon, 25 Mar 2024 16:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6B1B0A27D7;
 Mon, 25 Mar 2024 16:09:24 +0300 (MSK)
Received: (nullmailer pid 349893 invoked by uid 1000);
 Mon, 25 Mar 2024 13:09:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios build
Date: Mon, 25 Mar 2024 16:09:20 +0300
Message-Id: <20240325130920.349521-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When building qemu with smbios but not legacy mode (eg minimal microvm build),
link fails with:

  hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'

This is because fw_cfg interface can call this function if CONFIG_SMBIOS
is defined.  Made this code block to depend on CONFIG_SMBIOS_LEGACY.

Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/fw_cfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d802d2787f..d5e78a9183 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -70,6 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
+#ifdef CONFIG_SMBIOS_LEGACY
     if (pcmc->smbios_legacy_mode) {
         smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
                                                 &error_fatal);
@@ -77,6 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
                          smbios_tables, smbios_tables_len);
         return;
     }
+#endif
 
     /* build the array of physical mem area from e820 table */
     mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());
-- 
2.39.2


