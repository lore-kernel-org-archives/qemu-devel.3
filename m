Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2892BCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFst-0005sM-GJ; Wed, 24 Jun 2026 01:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFrk-00045b-SO; Wed, 24 Jun 2026 01:09:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFri-0005zJ-LJ; Wed, 24 Jun 2026 01:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=A1MCwyl77Bp0YQFINDzK2G0lg+C2TQkZSW5Vst+i5pI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Yr6skYU4uSOEwTEmw+jzmqo4urWRmIDc534R0RRxBSmxoiYG46GLXQLecWtsBQ5Ov
 UFtjfE3bpNlb99ibwqoUxV0vESTlHf8ncPE4hAyOa129bRz+6rExjTnU/0D/OlHZSJ
 AvEimcPD1j+A20qrbqHkY4b930GstD0mJqtNMd+6fcBT8oJz81zncyHi9Lm398HILO
 MjFakALB/6Ag66R1ERv5n566j7ZUy2lcv0k76GpOemyOJJ5HG7hIwRQoMB/5wnq50O
 11RWvITBddkmT50spgPRiUPR1LRecnKRelsGz0nPUr70WSI3gjAE1si4G5ELIck373
 DQRIsSwO2/yag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF8351BA673;
 Wed, 24 Jun 2026 08:07:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9934D3DDB10;
 Wed, 24 Jun 2026 08:07:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mathias Krause <minipli@grsecurity.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 85/95] gdbstub: Update x86 control register bits
Date: Wed, 24 Jun 2026 08:05:20 +0300
Message-ID: <20260624050541.395079-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Mathias Krause <minipli@grsecurity.net>

The control register bits haven't been updated in a few years, making
them lack behind features QEMU ganied in these years.

Update them to the current version of the SDM and sort the 32bit version
to be in line with all the other definitions (descending order).

This should remove confusion when debugging, for example, CET-enabled
guests:

- before the change:
  (gdb) info registers cr4
  cr4            0x8000f0            [ PGE MCE PAE PSE ]

- after the change:
  (gdb) info registers cr4
  cr4            0x8000f0            [ CET PGE MCE PAE PSE ]

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20260327143413.254227-1-minipli@grsecurity.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 88d39a2937ebad64b8aed8247450e1a6ddf274be)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/gdb-xml/i386-32bit.xml b/gdb-xml/i386-32bit.xml
index 7a66a02b67..1dec40e1d2 100644
--- a/gdb-xml/i386-32bit.xml
+++ b/gdb-xml/i386-32bit.xml
@@ -87,27 +87,34 @@
   </flags>
 
   <flags id="i386_cr4" size="4">
-	<field name="VME" start="0" end="0"/>
-	<field name="PVI" start="1" end="1"/>
-	<field name="TSD" start="2" end="2"/>
-	<field name="DE" start="3" end="3"/>
-	<field name="PSE" start="4" end="4"/>
-	<field name="PAE" start="5" end="5"/>
-	<field name="MCE" start="6" end="6"/>
-	<field name="PGE" start="7" end="7"/>
-	<field name="PCE" start="8" end="8"/>
-	<field name="OSFXSR" start="9" end="9"/>
-	<field name="OSXMMEXCPT" start="10" end="10"/>
-	<field name="UMIP" start="11" end="11"/>
-	<field name="LA57" start="12" end="12"/>
-	<field name="VMXE" start="13" end="13"/>
-	<field name="SMXE" start="14" end="14"/>
-	<field name="FSGSBASE" start="16" end="16"/>
-	<field name="PCIDE" start="17" end="17"/>
-	<field name="OSXSAVE" start="18" end="18"/>
-	<field name="SMEP" start="20" end="20"/>
-	<field name="SMAP" start="21" end="21"/>
+	<field name="LAM_SUP" start="28" end="28"/>
+	<field name="LASS" start="27" end="27"/>
+	<field name="UINTR" start="25" end="25"/>
+	<field name="PKS" start="24" end="24"/>
+	<field name="CET" start="23" end="23"/>
+	<field name="PKE" start="22" end="22"/>
 	<field name="PKE" start="22" end="22"/>
+	<field name="SMAP" start="21" end="21"/>
+	<field name="SMEP" start="20" end="20"/>
+	<field name="KL" start="19" end="19"/>
+	<field name="OSXSAVE" start="18" end="18"/>
+	<field name="PCIDE" start="17" end="17"/>
+	<field name="FSGSBASE" start="16" end="16"/>
+	<field name="SMXE" start="14" end="14"/>
+	<field name="VMXE" start="13" end="13"/>
+	<field name="LA57" start="12" end="12"/>
+	<field name="UMIP" start="11" end="11"/>
+	<field name="OSXMMEXCPT" start="10" end="10"/>
+	<field name="OSFXSR" start="9" end="9"/>
+	<field name="PCE" start="8" end="8"/>
+	<field name="PGE" start="7" end="7"/>
+	<field name="MCE" start="6" end="6"/>
+	<field name="PAE" start="5" end="5"/>
+	<field name="PSE" start="4" end="4"/>
+	<field name="DE" start="3" end="3"/>
+	<field name="TSD" start="2" end="2"/>
+	<field name="PVI" start="1" end="1"/>
+	<field name="VME" start="0" end="0"/>
   </flags>
 
   <flags id="i386_efer" size="4">
diff --git a/gdb-xml/i386-64bit.xml b/gdb-xml/i386-64bit.xml
index 6d88969211..9ac9164e6a 100644
--- a/gdb-xml/i386-64bit.xml
+++ b/gdb-xml/i386-64bit.xml
@@ -102,9 +102,16 @@
   </flags>
 
   <flags id="x64_cr4" size="8">
+	<field name="FRED" start="32" end="32"/>
+	<field name="LAM_SUP" start="28" end="28"/>
+	<field name="LASS" start="27" end="27"/>
+	<field name="UINTR" start="25" end="25"/>
+	<field name="PKS" start="24" end="24"/>
+	<field name="CET" start="23" end="23"/>
 	<field name="PKE" start="22" end="22"/>
 	<field name="SMAP" start="21" end="21"/>
 	<field name="SMEP" start="20" end="20"/>
+	<field name="KL" start="19" end="19"/>
 	<field name="OSXSAVE" start="18" end="18"/>
 	<field name="PCIDE" start="17" end="17"/>
 	<field name="FSGSBASE" start="16" end="16"/>
-- 
2.47.3


