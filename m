Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0ABC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6At2-0004zg-Jv; Mon, 14 Sep 2026 13:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6Asf-0004vD-1a
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:16 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x6AsX-0000Ii-Gb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:54:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1d16:0:640:f28c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 31F7FC0ACF;
 Mon, 14 Sep 2026 20:53:57 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:a2b::1:d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rrX9s30iEKo0-gWyxg7YT; Mon, 14 Sep 2026 20:53:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789408436;
 bh=hF/+wVRAyIB/gBpuoyjJv9bboAzjjKe0ul2q5jIbrWA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=K6hbpwTi1SN6AMDi12PCESMf8vfE1E3b9/ACDfCAhCOCbqsceGOK4D/4Z0Kel0dQA
 DZlSDRvAdoqke/FIGAfWTN+Zw6WlzRrN2qrskjffMJwNjXkDfxSi6+0gQy2zyJ3egu
 TGizeNjuTTeS+Ssn+7shFEVdKtYXmYQQXjAXxsxc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, peterx@redhat.com,
 farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru
Subject: [PATCH 2/5] net/tap: tap_post_load(): poll only on success
Date: Mon, 14 Sep 2026 20:53:48 +0300
Message-ID: <20260914175351.393680-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914175351.393680-1-vsementsov@yandex-team.ru>
References: <20260914175351.393680-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We shouldn't call tap_read_poll() if s->fd < 0.
Let's move tap_read_poll() to the end, after check
and vhost initialization.

Fixes: c4d884bb54441 "net/tap: support local migration with virtio-net"
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d71e3dd1175..8039b4e388c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -490,8 +490,6 @@ static bool tap_post_load(void *opaque, int version_id, Error **errp)
     ERRP_GUARD();
     TAPState *s = opaque;
 
-    tap_read_poll(s, true);
-
     if (s->fd < 0) {
         error_setg(errp, "FD was not loaded during incoming migration");
         return false;
@@ -503,6 +501,7 @@ static bool tap_post_load(void *opaque, int version_id, Error **errp)
         return false;
     }
 
+    tap_read_poll(s, true);
     return true;
 }
 
-- 
2.43.0


