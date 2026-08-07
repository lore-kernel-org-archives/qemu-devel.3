Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F6C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKbP-00018a-LQ; Fri, 07 Aug 2026 09:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbF-00014j-Up
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:03 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wsKbE-0007gu-2I
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:01 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14CE9415DD;
 Fri,  7 Aug 2026 13:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F961F000E9;
 Fri,  7 Aug 2026 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786109218;
 bh=MXiSPGD6+09XxF16dgSei5RtIuqDo4QIh9rc7D6E5Q8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B7da/mpnvi/TrldIjL10DqVf/hZSwsJZZWsKapr7wNxQ1/sXKi/uBWtnlSwcYSu9v
 uEtjdQxezdAi884pEe6HrilcopKZEAy9lkMCg+zeRdt/gpK/h8OeX2tSVkM9gLnuvx
 7eT3Q+/n346ZMUNYCoOkkQxDtJvrEQ6Mc7ehsmBEnvajO/lYji5qiDhLj8vygl8e6O
 G6j3qtxp9rBIVI5ijjgRFN+aUtKC8240jR4Fal3NFDb8ZeHO1+DBIR8OGxdnn30BI0
 E7zqg8EyYP6ZHru6Dnfq1oFSOL+MbwJ24VtbTFTrFIyOEWXEctcxDupQegQhHb0zOe
 eLuEx73Qg//xQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, deller@gmx.de,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/3] linux-user/sh4: Deliver SIGILL on invalid instruction
Date: Fri,  7 Aug 2026 15:26:50 +0200
Message-ID: <20260807132652.9687-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807132652.9687-1-deller@kernel.org>
References: <20260807132652.9687-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
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

From: Mikulas Patocka <mpatocka@redhat.com>

On invalid instruction, deliver SIGILL rather than crashing the whole
process unconditionally.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/sh4/cpu_loop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index ee2958d0d9..0815b9c9bf 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -64,6 +64,13 @@ void cpu_loop(CPUSH4State *env)
             cpu_exec_step_atomic(cs);
             arch_interrupt = false;
             break;
+        case 0x180:
+            /* Illegal instruction */
+            /* fallthrough */
+        case 0x1a0:
+            /* Illegal instruction in delay slot */
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
+            break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
             cpu_dump_state(cs, stderr, 0);
-- 
2.54.0


