Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C1FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDTN-0005Ic-Dp; Mon, 13 Jul 2026 06:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjDTJ-0005Hw-8y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjDTG-0005g7-EV
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783936863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAKV/0hA3vBMIU+Kfh+10fGOHdLI6vb+aoQO7VLXW5c=;
 b=BzQMPG2po4h/TXWsUSLApO/E4h2K1djGjwB+ghcqFjgHkunsxE8QPKQQJliD6sOjbNGt+3
 JsXZFTeHKatKY70N1AqmZ/5OBVLExsZ4XosnCEuTA2Y9ctJ9EjSEAoTQ/pXAGdHRkGKbh1
 z2zLQQ3adQP20qk43JjsS0gRWBdv89w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-1g_Y__WSMVqdG-guNcDjwA-1; Mon,
 13 Jul 2026 06:01:02 -0400
X-MC-Unique: 1g_Y__WSMVqdG-guNcDjwA-1
X-Mimecast-MFC-AGG-ID: 1g_Y__WSMVqdG-guNcDjwA_1783936861
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 710661955EA0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:01:01 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A0471686; Mon, 13 Jul 2026 10:00:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/vnc: validate SetPixelFormat field ranges
Date: Mon, 13 Jul 2026 14:00:56 +0400
Message-ID: <20260713100056.4104383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
values, but PixelFormat stores them as uint8_t. A client sending a
max value above 255 (e.g. 0x0100) passes the existing non-zero check
but silently truncates to 0 on assignment, leading to a division by
zero in the Tight PNG palette path.

Similarly, the shift values are read as uint8_t from the wire but
used in left-shift expressions (red_max << red_shift). Shifts >= 32
are undefined behavior in C for 32-bit operands.

Add explicit range checks for both: reject the connection if any
channel max exceeds UINT8_MAX, or any shift is >= 32.

Fixes: CVE-2026-15578
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
Reported-by: dong ling
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index dfc8262d42a..c4ee4738b28 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2276,6 +2276,16 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
         return;
     }
 
+    if (red_max > UINT8_MAX || green_max > UINT8_MAX || blue_max > UINT8_MAX) {
+        vnc_client_error(vs);
+        return;
+    }
+
+    if (red_shift >= 32 || green_shift >= 32 || blue_shift >= 32) {
+        vnc_client_error(vs);
+        return;
+    }
+
     vs->client_pf.rmax = red_max ? red_max : 0xFF;
     vs->client_pf.rbits = ctpopl(red_max);
     vs->client_pf.rshift = red_shift;
-- 
2.55.0


