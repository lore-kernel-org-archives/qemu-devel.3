Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7369CCD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWaw-0001nO-RG; Tue, 03 Sep 2024 12:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1slWav-0001fc-3c
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:41:29 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1slWat-0007ZF-DU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:41:28 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 929175C55E2;
 Tue,  3 Sep 2024 16:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7815EC4CEC4;
 Tue,  3 Sep 2024 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725381685;
 bh=N5itbBNwcKzNlXtLrNFjkDqkY6ASrGrYF8VbZ4aaX+4=;
 h=Date:From:To:Cc:Subject:From;
 b=dJ+nWiG2H4IzhJD3NfVHSEzPs9Vy0X/uOsB6OGBTo2NiIvw17ULialHLDWir17fpk
 vtD7xAbABIhX3QX4MAjtDRuAXSh1hUxQS07q7SYPGvohCzTAiZVITq2/k3RaljmMty
 04nsgl5qsvqCq5JoX0gwr8vtA8zcEBtI3jsCqifTHQk+T4+Uqza38TqtlyNA9fsvDZ
 GHfikp4zZcw6tynBRCN9YjawiRHmWpaURRPWGlAQzBxvtisZdLALfvyrm2YChmSrPQ
 icD8vZqNJeISRdilIuADlwngp8RdZpT514daRK4hi4s9l89eg6+ohB7f6bj+ThPkJd
 /79HPUjmGg8EA==
Date: Tue, 3 Sep 2024 18:41:21 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: linux-parisc@vger.kernel.org
Subject: [PATCH] target/hppa: Fix random 32-bit linux-user crashes
Message-ID: <Ztc8MaxI8SfD71mx@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The linux-user hppa target crashes randomly for me since commit
081a0ed188d8 ("target/hppa: Do not mask in copy_iaoq_entry").

That commit dropped the masking of the IAOQ addresses while copying them
from other registers and instead keeps them with all 64 bits up until
the full gva is formed with the help of hppa_form_gva_psw().

So, when running in linux-user mode on an emulated 64-bit CPU, we need
to mask to a 32-bit address space at the very end in hppa_form_gva_psw()
if the PSW-W flag isn't set (which is the case for linux-user on hppa).

Fixes: 081a0ed188d8 ("target/hppa: Do not mask in copy_iaoq_entry")
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 2bcb3b602b..56d9568d6c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -319,7 +319,7 @@ static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
                                              target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
-    return off;
+    return off & gva_offset_mask(psw);
 #else
     return spc | (off & gva_offset_mask(psw));
 #endif

