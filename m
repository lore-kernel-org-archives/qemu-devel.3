Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE6DCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSJq-0002N4-LB; Wed, 10 Apr 2024 03:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSJh-0001ZO-E2; Wed, 10 Apr 2024 03:24:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSJf-0003y3-Ir; Wed, 10 Apr 2024 03:24:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 907585D67F;
 Wed, 10 Apr 2024 10:25:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 34AA9B02C0;
 Wed, 10 Apr 2024 10:23:05 +0300 (MSK)
Received: (nullmailer pid 4191693 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nick Briggs <nicholas.h.briggs@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 16/87] Avoid unaligned fetch in ladr_match()
Date: Wed, 10 Apr 2024 10:21:49 +0300
Message-Id: <20240410072303.4191455-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Nick Briggs <nicholas.h.briggs@gmail.com>

There is no guarantee that the PCNetState is allocated such that
csr[8] is allocated on an 8-byte boundary.  Since not all hosts are
capable of unaligned fetches the 16-bit elements need to be fetched
individually to avoid a potential fault.  Closes issue #2143

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2143
Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 6a5287ce80470bb8df95901d73ee779a64e70c3a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index a7e123e60d..7d574f487b 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -632,7 +632,7 @@ static inline int ladr_match(PCNetState *s, const uint8_t *buf, int size)
 {
     struct qemu_ether_header *hdr = (void *)buf;
     if ((*(hdr->ether_dhost)&0x01) &&
-        ((uint64_t *)&s->csr[8])[0] != 0LL) {
+        (s->csr[8] | s->csr[9] | s->csr[10] | s->csr[11]) != 0) {
         uint8_t ladr[8] = {
             s->csr[8] & 0xff, s->csr[8] >> 8,
             s->csr[9] & 0xff, s->csr[9] >> 8,
-- 
2.39.2


