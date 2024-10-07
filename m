Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A77CCFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtGp-0008IC-8F; Mon, 07 Oct 2024 15:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtFi-0006TY-Qv; Mon, 07 Oct 2024 15:18:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtFh-0004Lb-1z; Mon, 07 Oct 2024 15:18:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D87396255;
 Mon,  7 Oct 2024 22:16:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 75DB814F735;
 Mon,  7 Oct 2024 22:16:56 +0300 (MSK)
Received: (nullmailer pid 2592774 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 24/32] tcg: Fix iteration step in 32-bit gvec operation
Date: Mon,  7 Oct 2024 22:16:41 +0300
Message-Id: <20241007191654.2592616-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

The loop in the 32-bit case of the vector compare operation
was incorrectly incrementing by 8 bytes per iteration instead
of 4 bytes. This caused the function to process only half of
the intended elements.

Cc: qemu-stable@nongnu.org
Fixes: 9622c697d1 (tcg: Add gvec compare with immediate and scalar operand)
Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240904142739.854-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 9d8d5a5b9078a16b4c0862fe54248c5cc8435648)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0308732d9b..78ee1ced80 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3939,7 +3939,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
         uint32_t i;
 
         tcg_gen_extrl_i64_i32(t1, c);
-        for (i = 0; i < oprsz; i += 8) {
+        for (i = 0; i < oprsz; i += 4) {
             tcg_gen_ld_i32(t0, tcg_env, aofs + i);
             tcg_gen_negsetcond_i32(cond, t0, t0, t1);
             tcg_gen_st_i32(t0, tcg_env, dofs + i);
-- 
2.39.5


