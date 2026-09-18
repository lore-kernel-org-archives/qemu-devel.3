Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60668C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fDx-0001Ni-GQ; Fri, 18 Sep 2026 16:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDh-0001Lj-M4; Fri, 18 Sep 2026 16:30:08 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDg-0003Go-4R; Fri, 18 Sep 2026 16:30:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26749602CC;
 Fri, 18 Sep 2026 20:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8400D1F000FF;
 Fri, 18 Sep 2026 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789763402;
 bh=asPIaTGgeFGi4ggVE4WnRKSL7JKJp/8r0pxfPYBWrs4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cK7ss4yWWAYC3ednHqU8D9PTcC0usDRRVsbFx0l0U/yDVlrylDdWUsOxNu6UZc9/m
 w3PRBRWsiOqKfHHELZ0+0L2GKOlsgIWQY+0cvAfbfm4PUrajWPBqSZPdjyVHhYocPa
 5JIzJX+DALDXjYDBzdMNryK4eZ5WYzUyCGdJL0AbE5y9GTO7g7eNhsN1tklV6VAmlN
 YbxbrvjKy6xi2B84odpjPPyd88OVm+Pe2b3faeoJSqRhEnUQ0OXS9jJM5Y6roluHwe
 lDcp4kp+PBjdMpduM94myO/JQpWQZT3UfHS7UMyObMXEV3QbWTcXPPwo3x0yoJmCkI
 KFyrmT6ZTTzRw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 4/4] linux-user/loongarch64: Detect vector stores in
 host_signal_write()
Date: Fri, 18 Sep 2026 22:29:47 +0200
Message-ID: <20260918202947.5322-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918202947.5322-1-deller@kernel.org>
References: <20260918202947.5322-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: SignKirigami <prcups@krgm.moe>

Recognize LSX/LASX stores in the LoongArch host signal handler to fix
internal QEMU crashes when RISC-V vector stores hit write-protected code
pages through host memcpy.

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/include/host/loongarch64/host-signal.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/include/host/loongarch64/host-signal.h b/linux-user/include/host/loongarch64/host-signal.h
index d33c3fc03e..eb4308cf09 100644
--- a/linux-user/include/host/loongarch64/host-signal.h
+++ b/linux-user/include/host/loongarch64/host-signal.h
@@ -61,6 +61,10 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
             return true;
         }
         break;
+    case 0b001011: /* v{ld,st}, xv{ld,st} */
+        return (insn >> 22) & 1;
+    case 0b001100: /* v{ldrepl,stelm}, xv{ldrepl,stelm} */
+        return (insn >> 24) & 1;
     case 0b001110: /* indexed, atomic, bounds-checking memory operations */
         switch ((insn >> 15) & 0b11111111111) {
         case 0b00000100000: /* stx.b */
@@ -69,6 +73,8 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
         case 0b00000111000: /* stx.d */
         case 0b00001110000: /* fstx.s */
         case 0b00001111000: /* fstx.d */
+        case 0b00010001000: /* vstx */
+        case 0b00010011000: /* xvstx */
         case 0b00011101100: /* fstgt.s */
         case 0b00011101101: /* fstgt.d */
         case 0b00011101110: /* fstle.s */
-- 
2.54.0


