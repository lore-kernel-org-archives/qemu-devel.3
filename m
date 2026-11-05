Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D0606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=jX6BJtKj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvqM-0002Lu-B4; Thu, 05 Nov 2026 06:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvqE-0002Kh-KM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:41:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvqC-0005ID-Nu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Dm7yRTs9+WTDMpbYYDlub46jSLGEtOdO/ql88BsjPWk=; b=jX6BJtKjlJh9kr1
 yVFjaBl+faxg1zEcewd80o0PWRb9dplxvf+h/MFPHhhfNRlLuZez+k6PpKNF8CknJl6VDvgEHh9CL
 KHqtjN3evBlcLfW3DO1X8ThhhM1wOSSCyu3qGWqbXTHmh0SjwxWn6zKyyfXJF+pKRGKsEWnxa+0Ig
 bQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 4/4] linux-user/hexagon: Reset hlx_ctx pointer on cpu clone
Date: Thu,  5 Nov 2026 12:46:33 +0100
Message-ID: <20261105114633.597-5-anjo@rev.ng>
In-Reply-To: <20261105114633.597-1-anjo@rev.ng>
References: <20261105114633.597-1-anjo@rev.ng>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently hlx_ctx retains the pointer to the hlx_user_ctx of its parent.
Another way to go is similar to hvx_ctx, which in user-mode, is just the
struct itself rather than a pointer to the struct.

Fixes: cf0bfbc338eaeef2b ("target/hexagon: manage HLX contexts through CCR")
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 linux-user/hexagon/target_cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/hexagon/target_cpu.h b/linux-user/hexagon/target_cpu.h
index ecb76e9268..6c36b7166f 100644
--- a/linux-user/hexagon/target_cpu.h
+++ b/linux-user/hexagon/target_cpu.h
@@ -25,6 +25,7 @@ static inline void cpu_clone_regs_child(CPUHexagonState *env,
         env->gpr[HEX_REG_SP] = newsp;
     }
     env->gpr[0] = 0;
+    env->hlx_ctx = &env->hlx_user_ctx;
 }
 
 static inline void cpu_clone_regs_parent(CPUHexagonState *env, unsigned flags)
-- 
2.52.0


