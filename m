Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909BCC61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 17:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0NCj-0001bX-Gh; Sat, 29 Aug 2026 13:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=SizC=GW=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1x0NCg-0001bH-Rk
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 13:50:54 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=SizC=GW=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1x0NCf-0005bd-1t
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 13:50:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 9CE0BA03C0;
 Sat, 29 Aug 2026 19:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1788025849; bh=0j0jQMNP9Rs0OcCqzo+iiZhXE7dCLI4j6dw38FzVbvA=;
 h=From:To:Cc:Subject:Date:From;
 b=hqtLO43jExICrv5wX0SIv6vMIpfBr98I7kIga8Go17uQOjnRdnl6TpwRULHkgcguI
 QGYE1t87cqrAowpvbkmEbns039m5K8JaOgqhtByinWGReHTQ6yx0GZbyxJmtAZRYcR
 FnU4SgR7ITEs6JAUfOWM2+BojxAvTdAI7hqr5qA7OBFLJUteDOyh7qLiPfrM0zKkEK
 HKfzW7aWBkva1t0nuo2j16fw7F3OKWyP2b/f2WKnWQvBzSyeONUo2cWj87srYhfueG
 U0b/8S0jwayhtK9d4u3RPitDy7kHLQhBLq2+CtVoXaVmbYWXDWlwyjn9IuWhLp71fs
 VgJCVNZlqtF+g==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NoK7VeSqtYi; Sat, 29 Aug 2026 19:50:49 +0200 (CEST)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 62C26A03B7;
 Sat, 29 Aug 2026 19:50:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1788025849; bh=0j0jQMNP9Rs0OcCqzo+iiZhXE7dCLI4j6dw38FzVbvA=;
 h=From:To:Cc:Subject:Date:From;
 b=hqtLO43jExICrv5wX0SIv6vMIpfBr98I7kIga8Go17uQOjnRdnl6TpwRULHkgcguI
 QGYE1t87cqrAowpvbkmEbns039m5K8JaOgqhtByinWGReHTQ6yx0GZbyxJmtAZRYcR
 FnU4SgR7ITEs6JAUfOWM2+BojxAvTdAI7hqr5qA7OBFLJUteDOyh7qLiPfrM0zKkEK
 HKfzW7aWBkva1t0nuo2j16fw7F3OKWyP2b/f2WKnWQvBzSyeONUo2cWj87srYhfueG
 U0b/8S0jwayhtK9d4u3RPitDy7kHLQhBLq2+CtVoXaVmbYWXDWlwyjn9IuWhLp71fs
 VgJCVNZlqtF+g==
Received: from samy by end with local (Exim 4.100-RC3)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1x0NCa-0000000BN8G-34nV; Sat, 29 Aug 2026 19:50:48 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org, adam@os.inf.tu-dresden.de, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Revert 9696846600ca ("multiboot: Prevent loading of x86_64
 images")
Date: Sat, 29 Aug 2026 19:50:47 +0200
Message-ID: <20260829175047.2710519-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=SizC=GW=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Loading x86_64 images in multiboot was disabled on the ground that since
multiboot actually boots 64bit kernels in 32bit mode, the binary would
have to be 32bit.

https://lists.gnu.org/archive/html/qemu-devel/2010-08/msg00913.html

But making the binary 32bit makes using debugging tools such as gdb
unnecessarily complex since they don't understand what architecture the
kernel actually is.  Letting qemu load x86_64 images and boot them in 32bit
mode is completely fine, works, and is what the multiboot standard actually
expects.

This notably fixes loading gnumach in x86_64 mode.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 hw/i386/multiboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index d544b62afb..004d5185fb 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -196,11 +196,6 @@ int load_multiboot(X86MachineState *x86ms,
         int kernel_size;
         fclose(f);
 
-        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
-            error_report("Cannot load x86-64 image, give a 32bit one.");
-            exit(1);
-        }
-
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
                                &elf_low, &elf_high, NULL,
                                ELFDATA2LSB, I386_ELF_MACHINE, 0, 0);
-- 
2.53.0


