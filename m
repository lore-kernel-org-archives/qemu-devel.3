Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23CCCFB454
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtEn-0005Ap-Jf; Mon, 07 Oct 2024 15:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEm-0005A8-Cs; Mon, 07 Oct 2024 15:17:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtEk-0004BH-M6; Mon, 07 Oct 2024 15:17:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A5379624C;
 Mon,  7 Oct 2024 22:16:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D756314F72C;
 Mon,  7 Oct 2024 22:16:55 +0300 (MSK)
Received: (nullmailer pid 2592746 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Fea.Wang" <fea.wang@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 15/32] softmmu/physmem.c: Keep transaction attribute in
 address_space_map()
Date: Mon,  7 Oct 2024 22:16:32 +0300
Message-Id: <20241007191654.2592616-15-mjt@tls.msk.ru>
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

From: "Fea.Wang" <fea.wang@sifive.com>

The follow-up transactions may use the data in the attribution, so keep
the value of attribution from the function parameter just as
flatview_translate() above.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Cc: qemu-stable@nongnu.org
Fixes: f26404fbee ("Make address_space_map() take a MemTxAttrs argument")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240912070404.2993976-2-fea.wang@sifive.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit d8d5ca40048b04750de5a0ae0b2b9f153a391951)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/physmem.c b/system/physmem.c
index d71a2b1bbd..dc1db3a384 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3274,7 +3274,7 @@ void *address_space_map(AddressSpace *as,
         bounce->len = l;
 
         if (!is_write) {
-            flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
+            flatview_read(fv, addr, attrs,
                           bounce->buffer, l);
         }
 
-- 
2.39.5


