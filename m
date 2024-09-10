Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0DEECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 05:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sntdg-0003vV-5O; Tue, 10 Sep 2024 01:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1sntdU-0003ui-Es
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 01:41:58 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1sntdN-000873-Mx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 01:41:55 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 36F32DA073A;
 Tue, 10 Sep 2024 07:41:46 +0200 (CEST)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=weilnetz.de
 (policy=quarantine); 
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id D66AE460030; Tue, 10 Sep 2024 07:41:45 +0200 (CEST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] migration/multifd: Fix loop conditions in
 multifd_zstd_send_prepare and multifd_zstd_recv
Date: Tue, 10 Sep 2024 07:41:38 +0200
Message-Id: <20240910054138.1458555-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36F32DA073A
X-Spamd-Bar: +++
X-Spamd-Result: default: False [3.90 / 14.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[99.99%];
 DMARC_POLICY_QUARANTINE(1.50)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; R_DKIM_NA(0.00)[];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 R_SPF_SOFTFAIL(0.00)[~all:c]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[weilnetz.de:mid,weilnetz.de:email]
X-Rspamd-Server: v2201612906741603
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

GitHub's CodeQL reports four critical errors which are fixed by this commit:

    Unsigned difference expression compared to zero

An expression (u - v > 0) with unsigned values u, v is only false if u == v,
so all changed expressions did not work as expected.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

I don't know what effect the errors will have.
Please check whether the fix should be backported to existing versions of QEMU.

And I think that it might be a good idea to add the security check to
https://github.com/qemu/qemu, too. The critical errors here and in net/colo-compare.c
were not reported by other static code analyzers as far as I know.
Paolo, if desired, I can send a patch for CodeQL.

Stefan W.

 migration/multifd-zstd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 53da33e048..abed140855 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -123,9 +123,9 @@ static int multifd_zstd_send_prepare(MultiFDSendParams *p, Error **errp)
          */
         do {
             ret = ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);
-        } while (ret > 0 && (z->in.size - z->in.pos > 0)
-                         && (z->out.size - z->out.pos > 0));
-        if (ret > 0 && (z->in.size - z->in.pos > 0)) {
+        } while (ret > 0 && (z->in.size > z->in.pos)
+                         && (z->out.size > z->out.pos));
+        if (ret > 0 && (z->in.size > z->in.pos)) {
             error_setg(errp, "multifd %u: compressStream buffer too small",
                        p->id);
             return -1;
@@ -243,7 +243,7 @@ static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
          */
         do {
             ret = ZSTD_decompressStream(z->zds, &z->out, &z->in);
-        } while (ret > 0 && (z->in.size - z->in.pos > 0)
+        } while (ret > 0 && (z->in.size > z->in.pos)
                          && (z->out.pos < page_size));
         if (ret > 0 && (z->out.pos < page_size)) {
             error_setg(errp, "multifd %u: decompressStream buffer too small",
-- 
2.39.2


