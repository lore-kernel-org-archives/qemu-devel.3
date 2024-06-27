Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A42C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrwK-000340-T7; Thu, 27 Jun 2024 12:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMrwD-0002p9-Jq; Thu, 27 Jun 2024 12:25:33 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMrw8-0002Vw-I6; Thu, 27 Jun 2024 12:25:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2799:0:640:ddd6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 78BAF61469;
 Thu, 27 Jun 2024 19:25:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:227::1:3a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9PUR6J0IiCg0-c2tkSPvN; Thu, 27 Jun 2024 19:25:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719505522;
 bh=hFypxwmyFaCxrHHUSBLg/l70hhX3SKgqnjxSZ87PaG4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=iriiqXWutNMcQXeAGRod7Fu1XcsaURW3SbRssFrJ01B2LG5ev2Q3olztQEXM1zCb0
 Wj/Bd0xRNMpoRszFGp+y/HS9Fq1Rzu8Jud+i/NYll3gtZHvZs7BpzDxVwG4F9lM813
 aHBwkQNBWwkxE8DfATn8JLIvBpsRRHA67XQteSck=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, qemu-trivial@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] hw/core/loader: gunzip(): fix memory leak on error path
Date: Thu, 27 Jun 2024 19:25:07 +0300
Message-Id: <20240627162507.598352-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We should call inflateEnd() like on success path to cleanup state in s
variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2f8105d7de..a3bea1e718 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -610,6 +610,7 @@ ssize_t gunzip(void *dst, size_t dstlen, uint8_t *src, size_t srclen)
     r = inflate(&s, Z_FINISH);
     if (r != Z_OK && r != Z_STREAM_END) {
         printf ("Error: inflate() returned %d\n", r);
+        inflateEnd(&s);
         return -1;
     }
     dstbytes = s.next_out - (unsigned char *) dst;
-- 
2.34.1


