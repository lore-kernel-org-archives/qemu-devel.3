Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41643CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQg6-00054U-LA; Tue, 16 Jun 2026 06:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQg4-00054E-KY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:52 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQg3-00031t-6Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:52 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c86484d35d1so1502490a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604350; x=1782209150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlNApQvq+hxRElznEGdr32LHf8f5Yc0YPosDc+WuXao=;
 b=Ik/WtS7+f2rJF1U1/50CkvKhe/Tn6O2hSPMnI/4QGn4yDeeDvh2YsDrzCEjIfGarf0
 hJHPYXn5jJypIVcq5Di2ve5vvPq9BbKouxZ0ij7LjkrmSBB9qQF9+X2l7DFzTzmYaAtD
 h1oMUSHppDRG5yiMRRwFiJgM/LelMp3feAhTbFUGEB61r58Le0JBMLcixB5o59y4qoqV
 bWyLaKYNcqAO2JSrVtOoPQfp6u9arIkSIRrZTyne90yfFfPFZY/KpFLVSTPtDhTVLGsh
 rS9XOedKanD7e6ojkdVnn6uUKnzH+10rVMv0VlMzEIOCSIwU2wMa7uwikSl5oYD3DHkQ
 ylRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604350; x=1782209150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlNApQvq+hxRElznEGdr32LHf8f5Yc0YPosDc+WuXao=;
 b=n8ROWzHHtJms54dR2udpKAzYTdH3Buo4g7MLN+z9lmIM2N0xu5n0vV/szDryCtQqme
 jeFnM6T419QO+UAzTiNX3XzzqCLDvRxivZDNGmwAsAhfqFnAUIPgq1Gct7Lo5nfrTa/u
 +t54DPe77X7kEJwJM3PBMUrdddMP/bzruh7N+BQCFXYAWKtC36txMGnRfdmgsbYCo43R
 V7HvhgJPtP0RKlfg/IePnekBfjgXuTzqDYyjCSUtLHmmY9PTzAtaNU4Z+2p/333h34wA
 6pTjxcpXag0WXWBP4J0UJINmcInE+88KbeAvnn+QltNMkFTgbtovgiA21gKIFUa2WXds
 Bykw==
X-Gm-Message-State: AOJu0YwpQoo5WLc+xoQs0DmHd58G7sp2dG6kolLSZcFW8geym1Z0lpmR
 XEt/GQhw2vFC8LtEkQktS/GKpaR4+J4jR9ZOIPD4TTecQXVqs8V1xuES8uLIuaBD
X-Gm-Gg: Acq92OHxUM5K4p5IHx88OrWvIs+pjXG5iEXyUPRvLNDgq9Br7Fs4hSF2AKjrZWJfNRM
 gao8RKGAL7RweXkviNPh/y/VPZveWFWVsThm3CL4vINbgjSb2Xrweyf1PU+PMHGuiIMlpH21XLk
 KKGXXflU3fzrJcnyOH9lbWS4xt0o1EP5eM4NHnw6WvmU0HpEdZEqKoTj1EBn6fQmTKLCU71fcSP
 IObpv1hZa3avfG17BRbXkzhrIe4ejzQQvaK4mBZW3OBQJT/iPVjnq12eOvzBHva1YjWmfpu/27e
 1Aq6tgAa66WMwaUxCJAYRBXnKmjLFKdcoN3mENgfeQA2VJjRm6g6VuqhgNqqVMCAsHbW6bgGZcq
 Qd1Inql7s68eeqBiV/N3Q8AXdSt4mtMxM1e52zmwGvjKlWXwStIWXGDApqkc5fhPwoBFCgaVOKQ
 18HAXUwyZS1zGWoLePKuLEmqgOSvPlAWimGvnfq23J
X-Received: by 2002:a05:6a20:d52a:b0:3b4:913c:296a with SMTP id
 adf61e73a8af0-3b79637c208mr17023031637.21.1781604349716; 
 Tue, 16 Jun 2026 03:05:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/83] target/riscv/csr.c: do not allow mstatus MPV/GVA writes
Date: Tue, 16 Jun 2026 20:04:07 +1000
Message-ID: <20260616100527.1939565-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The priv spec states the following about mstatus.MPV:

"The MPV bit (Machine Previous Virtualization Mode) is written by the
implementation whenever a trap is taken into M-mode."

And, about mstatus.GVA:

"Field GVA (Guest Virtual Address) is written by the implementation
whenever a trap is taken into M-mode."

Both are written during riscv_cpu_do_interrupt().  They're not supposed
to be written by userspace.  As far as write_mstatus goes these fields
are read only.  The same applies for mstatush.MPV/mstatush.GVA.

Fixes: 03dd405dd5 ("target/riscv: Support MSTATUS.MPV/GVA only when RVH is enabled")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5514e0f455..83ca354bf0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2044,9 +2044,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
-        if (riscv_has_ext(env, RVH)) {
-            mask |= MSTATUS_MPV | MSTATUS_GVA;
-        }
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
         }
@@ -2083,7 +2080,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
+    uint64_t mask = 0;
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-- 
2.54.0


