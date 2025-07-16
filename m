Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A5C83F2D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 07:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubwZk-0000x8-HH; Wed, 16 Jul 2025 03:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubwZi-0000sx-9Q
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:29:10 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubwZe-0008E1-9t
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 03:29:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 282E3C0151;
 Wed, 16 Jul 2025 10:28:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:748::1:e])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tSGfVF0GwiE0-9xcylu02; Wed, 16 Jul 2025 10:28:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1752650936;
 bh=tevAFdVUBjnHSaFGZQIwdDr3jmIGLGbxnsXQaNZ76+I=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=s+hNaCK4KmcEvLgkOzyqlArTlDoZl2+dXXdBIgsiiMjxI9dHXnSVuiD1LLwQufQhK
 T9QAtEazGztMvBgH1NMlcHkJLhfmgHJOLFfKvwvgd/q9STxlDy9RN0amlPVq1tTSbS
 OW7ZHcEqR1PHejf1n3UuFpdS+nsKtzkHszWKAWr8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	jasowang@redhat.com
Cc: vsementsov@yandex-team.ru, d-tatianin@yandex-team.ru, leiyang@redhat.com
Subject: [PATCH v2] net/tap: drop too small packets
Date: Wed, 16 Jul 2025 10:28:53 +0300
Message-ID: <20250716072854.13403-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Don't proceed with size == s->host_vnet_hdr_len as well in case
of !s->using_vnet_hdr, it doesn't make sense.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v2: change "<" -> "<="

 net/tap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index 23536c09b46..2a859360193 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -190,6 +190,11 @@ static void tap_send(void *opaque)
             break;
         }
 
+        if (s->host_vnet_hdr_len && size <= s->host_vnet_hdr_len) {
+            /* Invalid packet */
+            break;
+        }
+
         if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
             buf  += s->host_vnet_hdr_len;
             size -= s->host_vnet_hdr_len;
-- 
2.48.1


