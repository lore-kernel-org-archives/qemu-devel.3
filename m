Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FEC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHbD-0002rf-UW; Thu, 03 Jul 2025 06:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXHb7-0002ma-1k
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:22 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXHb4-0000ZN-HN
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:1a88:0:640:421c:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0E3CA60C51;
 Thu,  3 Jul 2025 13:55:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:73d::1:28])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BtZDqQ0FieA0-fXzqSqxA; Thu, 03 Jul 2025 13:55:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751540111;
 bh=3Mrwbefvrcn1WEr6p5kBz3zCiVEFVKwBqtJ+4hKe6PU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=FpHGA5VbnY1zhZOqIfo0CGk/VEw+PRDBBXq5kX/hpni+D3b2FytvRLTTavjns+oUj
 8L1F4DHvLCBBXAmV9lDhZv0Mehfy85+W2quwB0xtlPT17HTO+5WMiFrjMEa3+Js4wf
 fY09r2t38vUfyaxVfbQNXoZvg2FZcr//dB7vYadI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH] net/tap: drop too small packets
Date: Thu,  3 Jul 2025 13:55:08 +0300
Message-ID: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Theoretically tap_read_packet() may return size less than
s->host_vnet_hdr_len, and next, we'll work with negative size
(in case of !s->using_vnet_hdr). Let's avoid it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index ae1c7e39832..20d0dc2eb35 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -172,6 +172,11 @@ static void tap_send(void *opaque)
             break;
         }
 
+        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {
+            /* Invalid packet */
+            break;
+        }
+
         if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
             buf  += s->host_vnet_hdr_len;
             size -= s->host_vnet_hdr_len;
-- 
2.48.1


