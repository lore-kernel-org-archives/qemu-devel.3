Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E1C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 07:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rggS2-0001tW-I8; Sun, 03 Mar 2024 02:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggS1-0001sM-4z; Sun, 03 Mar 2024 02:40:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRz-0001mr-Ke; Sun, 03 Mar 2024 02:40:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66C4D5275B;
 Sun,  3 Mar 2024 10:40:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 126668E850;
 Sun,  3 Mar 2024 10:39:35 +0300 (MSK)
Received: (nullmailer pid 1350619 invoked by uid 1000);
 Sun, 03 Mar 2024 07:39:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Vladim=C3=ADr=20Bene=C5=A1?= <vbenes@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 54/54] target/i386: the sgx_epc_get_section stub is
 reachable
Date: Sun,  3 Mar 2024 10:39:33 +0300
Message-Id: <20240303073934.1350568-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The sgx_epc_get_section stub is reachable from cpu_x86_cpuid.  It
should not assert, instead it should just return true just like
the "real" sgx_epc_get_section does when SGX is disabled.

Reported-by: Vladimír Beneš <vbenes@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20220201190941.106001-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 219615740425d9683588207b40a365e6741691a6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 26833eb233..16b1dfd90b 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -34,5 +34,5 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
 
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
-    g_assert_not_reached();
+    return true;
 }
-- 
2.39.2


