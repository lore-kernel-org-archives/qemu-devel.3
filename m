Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC882C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 07:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5JaK-0005X7-2n; Thu, 17 Apr 2025 03:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1u5JaG-0005Wi-I5; Thu, 17 Apr 2025 03:22:52 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1u5JaD-0000IO-Vn; Thu, 17 Apr 2025 03:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1744874541; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=etC8tz+N8jpqIabFPp0WtZQxw9N/+xszbsiRzYqDFylrXe0wz1Xlo/v29NZwUen7Lid1rc1Q4Z3Q3T3mK+qu7SCf5YnxnKHt9cULw8P97qIELDVBqCB/X46yGJYNNXTdL+5Qx2hxLnyX6Dok8ALnxp0OrXJIDeOsLHz58aYoOgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1744874541;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xKsO1uho/0nTL/EI6evKCLfwRNYH8HmHj6cAJA8H24w=; 
 b=GN5GHIdLpWJ/YG+RF+rCvd+SX3e0Q7FJoVYJPWzOhOGwiBPze3joLvzI52TichJUlVUHnVWuhfvEnpSY7n3TojbZsh6VccmbGgPERxWenF+Rq4CnGYmozrt+S5zvts8WcREaDBJHWJ8WC1Gg2HQoLV8jU9U6gZ72/AZDK4SPLUs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744874541; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xKsO1uho/0nTL/EI6evKCLfwRNYH8HmHj6cAJA8H24w=;
 b=ZKgPlvc3UGzOsGUxej+8N/VIP2v5twszjIprFtndw2lq94GEMD+iYmIs1SwYwwr7
 qPtGCxAKP68+ES7Qab/npTxWBYWoNV5hAbdpV8E8izkADLaufvMsL5y01LnIqTbkcK+
 tbdkybaqkzW02TyQWCfDsckHcSvksaYZPCt8bByPM1f3Ct+XlmH/ykZ4KDEGiwwur9e
 1diimrx3F7bnQK1uaLQFWWdLW515KSspf86QJDWfkqgPC3D29yJ/sIGqxQmY4Kt1aF7
 ESui+wTyoqHbv/+odvlZGEewnTz3U7QAUj4Jh5wNagjo5LY5hZOCFYkevogWoQzyLeY
 rSUsIUQE/Q==
Received: by mx.zohomail.com with SMTPS id 174487453811922.435879893512833;
 Thu, 17 Apr 2025 00:22:18 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Riku Voipio <riku.voipio@iki.fi>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] common-user/host/riscv: use tail pseudoinstruction for
 calling tail
Date: Thu, 17 Apr 2025 15:22:06 +0800
Message-ID: <20250417072206.364008-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The j pseudoinstruction maps to a JAL instruction, which can only handle
a jump to somewhere with a signed 20-bit destination. In case of static
linking and LTO'ing this easily leads to "relocation truncated to fit"
error.

Switch to use tail pseudoinstruction, which is the standard way to
tail-call a function in medium code model (emits AUIPC+JALR).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
P.S.
It seems that moving it to common-user/ makes the file out of the
MAINTAINERS section of "RISC-V TCG CPUS". I Manually added the
maintainers there, but the MAINTAINERS file seems to need a change on
this.

 common-user/host/riscv/safe-syscall.inc.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host/riscv/safe-syscall.inc.S
index dfe83c300e..c8b81e33d0 100644
--- a/common-user/host/riscv/safe-syscall.inc.S
+++ b/common-user/host/riscv/safe-syscall.inc.S
@@ -69,11 +69,11 @@ safe_syscall_end:
 
         /* code path setting errno */
 0:      neg     a0, a0
-        j       safe_syscall_set_errno_tail
+        tail    safe_syscall_set_errno_tail
 
         /* code path when we didn't execute the syscall */
 2:      li      a0, QEMU_ERESTARTSYS
-        j       safe_syscall_set_errno_tail
+        tail    safe_syscall_set_errno_tail
 
         .cfi_endproc
         .size   safe_syscall_base, .-safe_syscall_base
-- 
2.49.0


