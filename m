Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E948DCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRx6e-0000YJ-HI; Tue, 26 May 2026 15:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6O-0000NI-0c; Tue, 26 May 2026 15:06:17 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRx6L-0004dz-8E; Tue, 26 May 2026 15:06:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34B4E60120;
 Tue, 26 May 2026 19:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980B71F00A3A;
 Tue, 26 May 2026 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779822362;
 bh=/5CGgZ/X7uMiJB5eErY0sF7KyvBhWLSMYSs2M1AmyjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wq+k3sEEzsKuqSqsP70oMVOoqzKo6K5R5vEaC9KfgVLbQG1VEyEP1N3sGlJxUkPlH
 mDivh+G6Xn8KeCttNBrM4x0SxkLck67fFr+iFd8jXLJcIQNB9aKtlZ07vN2HKrzZxz
 L0ukvNh/jGgRqDMoSpLRGXdMyVDyQQq3a94mNQ7KoMUlZBBayW3eKgCvMz89KySg2l
 Zr7C6SfO6edS1QjDFczOpMNhY0JOwdYUCHQ0x0WxrEq+01P0RuX+F1z6uoGLNFMX+W
 qmLV4PzuQUTkCMReHOwJTHCdwPpI7PMiYFlQ3fqU7h8tlo2ptaSIaloMAeLifs04Ss
 ofhyVbKuIP8TA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 06/12] target/sh4: sync fp_status when gdb writes FPSCR
Date: Tue, 26 May 2026 21:05:29 +0200
Message-ID: <20260526190535.10833-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526190535.10833-1-deller@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Matt Turner <mattst88@gmail.com>

sh4_cpu_gdb_write_register() wrote the incoming FPSCR value straight
into env->fpscr, leaving the derived env->fp_status (rounding mode and
flush-to-zero) stale, so a gdb-initiated FPSCR change did not take
effect for subsequent FP operations. Use cpu_load_fpscr() instead, the
same way the adjacent case already uses cpu_write_sr() for SR.

Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/sh4/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 4f36e800d2..bdc8c1d164 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -113,7 +113,7 @@ int superh_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->fpul = ldl_p(mem_buf);
         break;
     case 24:
-        env->fpscr = ldl_p(mem_buf);
+        cpu_load_fpscr(env, ldl_p(mem_buf));
         break;
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
-- 
2.54.0


