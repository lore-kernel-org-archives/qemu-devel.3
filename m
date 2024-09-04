Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998FFCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sln2X-0004Y4-7x; Wed, 04 Sep 2024 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sln2M-0003uN-M2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:14:55 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sln2L-0002iw-26
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:14:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9F50B5C56EA;
 Wed,  4 Sep 2024 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F230C4CEC2;
 Wed,  4 Sep 2024 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725444891;
 bh=9l+qCXYoMaahzPy0jmL22EU3kbNbb8JoG9AUupuLTvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IOpuXQ1xaRGFk2oFreTa51a9qtpfL9BHABBGVdYD+Ihd3DjbGLA/Ii2YF8H7/qyCj
 w8VtiUn8SBfvZ1eokVO4zJuc9/iZOrqHZ3bZ52NN5yW7JLeSrIpi4xmnTXwu17kxlF
 3NqZTtmx1GymOpqmM3v8l01Zt4mnK3fR1kQ1dlmANNS+lLcjo3EACiP7L3PuwX9NGV
 DDIkpitTsjG1FjxjFQJFcgjQhz43SeVmuCCchFHt8exWEJj+FMqIuPoljUZVCI6JTZ
 YvZULAqMhRapHmtX+xwYR10DSMwvRfGuB/bW6BeEER4f3bRHyLyxq1G3RLgdvEWPM5
 Qc9XocRUuO4/Q==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 2/2] target/hppa: Fix random 32-bit linux-user crashes
Date: Wed,  4 Sep 2024 12:14:45 +0200
Message-ID: <20240904101445.4127-3-deller@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904101445.4127-1-deller@kernel.org>
References: <20240904101445.4127-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

The linux-user hppa target crashes randomly for me since commit
081a0ed188d8 ("target/hppa: Do not mask in copy_iaoq_entry").

That commit dropped the masking of the IAOQ addresses while copying them
from other registers and instead keeps them with all 64 bits up until
the full gva is formed with the help of hppa_form_gva_psw().

So, when running in linux-user mode on an emulated 64-bit CPU, we need
to mask to a 32-bit address space at the very end in hppa_form_gva_psw()
if the PSW-W flag isn't set (which is the case for linux-user on hppa).

Fixes: 081a0ed188d8 ("target/hppa: Do not mask in copy_iaoq_entry")
Cc: qemu-stable@nongnu.org # v9.1+
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 5478b183dc..43074d80bf 100644
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
-- 
2.46.0


