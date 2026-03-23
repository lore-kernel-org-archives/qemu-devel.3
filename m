Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88762F46124
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4frg-00031z-TE; Mon, 23 Mar 2026 10:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4foZ-0000RL-0Q
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:40 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4foW-0006xI-HO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:29 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 01C4720B6F12;
 Mon, 23 Mar 2026 06:59:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01C4720B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274357;
 bh=JjZO2/X3lUM54v7gEfoxaHgi6BZofDR2FWQNRjmIZ3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EdTpaejezyNCqSnBHdwFIFM4AsUnJFV6TB9ExJskiAIaH2I/xiWhRE4gcvppAbvkD
 OvbDelpoc+sNVyggAWiHp3Vpj5sm6fb+J+iD6MuaLub0HMX3QBgcxqlDRkven0BVrn
 FjGit/rrNlDterxKu/jRGDcqzhWk91DeO1Po6G9c=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 16/32] target/i386/mshv: move msr code to arch
Date: Mon, 23 Mar 2026 14:57:56 +0100
Message-Id: <20260323135812.383509-17-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The MSR code is x86 specific, hence it's better suited in the arch
tree.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/meson.build            | 1 -
 target/i386/mshv/meson.build      | 1 +
 {accel => target/i386}/mshv/msr.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {accel => target/i386}/mshv/msr.c (100%)

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index c1b1787c5e..e433187cde 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
-  'msr.c',
   'mshv-all.c'
 ))
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 5eb6e833a6..f44e84688d 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -3,6 +3,7 @@ i386_mshv_ss = ss.source_set()
 i386_mshv_ss.add(files(
   'mshv-apic.c',
   'mshv-cpu.c',
+  'msr.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
diff --git a/accel/mshv/msr.c b/target/i386/mshv/msr.c
similarity index 100%
rename from accel/mshv/msr.c
rename to target/i386/mshv/msr.c
-- 
2.34.1


