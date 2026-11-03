Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9611606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.fau.de header.i=@cs.fau.de header.a=rsa-sha256 header.s=r20250630-faui40 header.b=a1TYbZGk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFtd-0006Wd-DI; Tue, 03 Nov 2026 09:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schober@cs.fau.de>)
 id 1xOFta-0006WI-Gl; Tue, 03 Nov 2026 09:53:54 -0500
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schober@cs.fau.de>)
 id 1xOFtU-0007Vc-N6; Tue, 03 Nov 2026 09:53:54 -0500
Received: from i4laptop29.pool.uni-erlangen.de
 (i4laptop29.informatik.uni-erlangen.de [10.188.34.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: schober)
 by faui40.informatik.uni-erlangen.de (Postfix) with ESMTPSA id
 4jJs5R2dScz1RF7R; Tue, 03 Nov 2026 15:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.fau.de;
 s=r20250630-faui40; t=1793717616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wq8CRXCfTqp1OjqieDyO9/BFFT2lhkTJEQig9iU5ZcE=;
 b=a1TYbZGkAMEPEldjg/tzz7E0T5JoDK63/yUitNQFLLcZG2aHzfbvO4VjlXlH5JPnrKudJ5
 uK5nBhlsHpSDLSuTGuuHjX2VAlFKmnV9FaNNtUCn9YlFE0LMQ4gjbyDn0Se4mGcI+Yh7v4
 3TDnVVOG4kHlplCIqj1lC1Z7UkUY4L1CLISkiNZb8tSt2FexXKHbiLpIs6ect2TJxD1Kxr
 +MQ45J/PPtsroDQWYZLJRahY+0UKp/KM0QeKMnlAxm+fQBoeQPaG9glN0TRL+BXmvxwHHI
 PFdYXwEhTouzTYf360N8cWsHbI/PLon40+AjsO0sa49/bmq0Z9vLTjNgvhopag==
From: Ferdinand Schober <schober@cs.fau.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ferdinand Schober <schober@cs.fau.de>,
 qemu-stable@nongnu.org
Subject: [PATCH] arm/cpu: fix GIC v3 flag for a64fx
Date: Tue,  3 Nov 2026 15:52:54 +0100
Message-ID: <20261103145254.1543907-1-schober@cs.fau.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=131.188.34.40; envelope-from=schober@cs.fau.de;
 helo=faui40.informatik.uni-erlangen.de
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The a64fx CPU model wrongfully set GIC bits in the
processor feature register (ID_AA64PFR0).

I traced this back to e31c70ac04001df5e540b79843834277e283fa71,
where A64FX got added.

This bit is supposed to get set conditionally in id_aa64pfr0_read,
depending on whether or not a gicv3 is present, from what I can tell.
Qemu picks gic-version=2 by default, while v3 gets advertised due to this flag.
Recent EDK2 firmware accesses ICC_SRE_EL2 in this case and crashes.

Clear the GIC field, as the other CPU models do.

Cc: qemu-stable@nongnu.org
Fixes: e31c70ac0400 ("target-arm: Add support for Fujitsu A64FX")
Signed-off-by: Ferdinand Schober <schober@cs.fau.de>
---
To reproduce: UEFI firmware (version edk2-20260812-8.fc44 built at 00:00:00 on Sep  9 2026)
(edk2-aarch64-20260812-8.fc44.noarch from Fedora 44)

qemu-system-aarch64 -m 1G -cpu a64fx \
  -machine virt,virtualization=on,iommu=smmuv3 -nographic \
  -bios /usr/share/edk2/aarch64/QEMU_EFI.fd

 target/arm/tcg/cpu64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 60c701e5d7..3a0f8b623c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -504,7 +504,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     SET_IDREG(isar, REVIDR, 0);
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
-    SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
+    /* No RAS Extensions, GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR0, 0x0000000100111111);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408);
     SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000);
-- 
2.56.0


