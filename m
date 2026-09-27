Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A01C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksY-0008SY-UA; Sun, 27 Sep 2026 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrH-00026u-Dh; Sun, 27 Sep 2026 05:07:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrF-0008FH-FS; Sun, 27 Sep 2026 05:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=BfTdZbj+ebsWldqWdkfa8kSg3370PgB+vAdII6ain/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WrlZ0nRQnu4OElvvTglF/ET7y9AM0L/e3mORjQg4LRdH6tHLIT0g89/dP3sMEV7oQ
 tzwJuH3hEK6dVOXYHLyWgoqwqrtFV6GrQiaqB6AMsjMCIdUy2UuuSLruVHH53WO3rA
 N5+57bJw0V2XfDTB+bmcko2oDA9zwaoHfYP8Wm7WFJEad0dd6kuEak65fulu52LkDh
 RrO0pIuOm7H/7CUakJZIEdjXQE3v+zO6RaAGphU6BhHbOe+l66qjqrcA4y2m2P/C1Z
 GmH0TXFyPnRK5UME2TtKCrP/8yAJ8fpdT6upefx1fnwOEFGczVAYOcBDjEMQ4o4bjM
 J0cZP628oq7rw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E0D91D8B23;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7B3844320DC;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E9F245E677; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 82/86] target/i386: Update FPU tag word for FSTP
Date: Sun, 27 Sep 2026 12:05:29 +0300
Message-ID: <20260927090540.102811-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Simon Scherer <scherer.simon89@gmail.com>

FSTP ST(i) copies the value in ST(0) into ST(i) and then pops the
register stack. ST(i) should end up marked valid in the FPU tag word
and the old ST(0) should end up marked empty.

helper_fmov_STN_ST0() copies the value into ST(i) but never touches
its tag. So if ST(i) happened to be tagged empty beforehand, it is
still wrongly tagged empty afterwards.

Mark the destination tag to valid in helper_fmov_STN_ST0().
This also fixes FST ST(i), which shares the same helper.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Link: https://lore.kernel.org/r/20260902120419.212855-2-scherer.simon89@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f2357fdcd984c37fb0f3f64698a38ba1f55fd9c5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e215dbc1c00..a5096e640f6 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -510,6 +510,7 @@ void helper_fmov_ST0_STN(CPUX86State *env, int st_index)
 void helper_fmov_STN_ST0(CPUX86State *env, int st_index)
 {
     ST(st_index) = ST0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
 }
 
 void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
-- 
2.47.3


