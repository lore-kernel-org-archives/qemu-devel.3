Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495BF1061B08
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0z-0000pz-I3; Mon, 30 Mar 2026 17:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0x-0000pG-J3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:15 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0w-0003kP-BP
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E7C0C60142;
 Mon, 30 Mar 2026 21:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3489C4AF09;
 Mon, 30 Mar 2026 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905553;
 bh=odEaddXKvNX8iluvKti5gftibq7UJ7OHwzuPqWjSmaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dd49DotskDvcGLFH7QKjjjeGVj66HFeXL2at04MpC8X+19UENolCkYw9p6CW+STvt
 dFoJq6C20rojI2b1Htkas3+r4M3RpG4pR37KpOV1SdIAofIYJ5eA5YLrI8IXafH3e6
 W6lM6OvO0akwsVsPGa0Mv4uhK38WR5uc7QsgBhILRkvzDvs1sZrkpuQfT0VwzxsE5h
 MNaPJ8usfGAFYs/QJrAYxfRNrR5JBn90Q3gWRh0smOCtYzDRb9n83QUw/E+IyiogYM
 UdNgf5h461W1yCwFPUWU0iAr1gnvcKJue4nSHkNlUL81clUt+ibl0/utM3Za0AMyEA
 PaRdsT091VM5Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 09/11] target/hppa: Fix TOC handler for 64-bit CPUs
Date: Mon, 30 Mar 2026 23:18:56 +0200
Message-ID: <20260330211859.19317-10-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

When the TOC handler is triggered, e.g. by using the "NMI" command
in the QEMU monitor, make sure to call the full 64-bit TOC handler
address in SeaBIOS-hppa firmware.
This fixes the TOC handler on 64-bit CPUs (and 64-bit SeaBIOS).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/int_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index d5a20cd549..fd4b99069e 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -203,7 +203,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
     /* step 7 */
     if (i == EXCP_TOC) {
-        env->iaoq_f = hppa_form_gva(env, 0, FIRMWARE_START);
+        env->iaoq_f = hppa_form_gva(env, 0,
+                ((uint64_t) FIRMWARE_HIGH) << 32 | FIRMWARE_START);
         /* help SeaBIOS and provide iaoq_b and iasq_back in shadow regs */
         env->gr[24] = env->cr_back[0];
         env->gr[25] = env->cr_back[1];
-- 
2.53.0


