Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E964CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQF-0001X0-5V; Sun, 04 Oct 2026 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPn-00082L-95
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPl-0003Me-S6
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAYO4kjmdBL6QKxjX7X6D+1DzUdIYLYCJAqz+PrzrfQ=;
 b=Ct1yhJUR4pSivTNy5X5SocVijIxFz88pky5cYEJ/vOAi0tMdBNQHStJqXECIrHQo5+SRFh
 k1JwXKLWmcdweVvxoSuVRvSzjA+8si6BNBhvYDhihxfcBcArsu8UbsVv4NwMPvJIDSNJ+3
 MU7RZ57r1D85JCReOcAN0K0GhL7mXIk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-UE_y47ZFOcmKP24fGJGcKA-1; Sun,
 04 Oct 2026 06:25:50 -0400
X-MC-Unique: UE_y47ZFOcmKP24fGJGcKA-1
X-Mimecast-MFC-AGG-ID: UE_y47ZFOcmKP24fGJGcKA_1791109549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E0381955F7D; Sun,  4 Oct 2026 10:25:49 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 429501800348; Sun,  4 Oct 2026 10:25:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:51 +0400
Subject: [PATCH 37/63] hw/char/sh_serial: use rx_cnt for available FIFO space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-37-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=US7JjDmwSjC1mBto9Z23Xnyhadyq94wCL5VYYIB2aoA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjhGY1JvLPGQPIZke28C9vU1BBC7ipQ2t8T
 dUh+XUsB0WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5bl2D/4nf5SxvlYlRD3xbnKQnVuYEyosKdlgKbazZ0WLISTBugPNFdn3cO1ieTB5MwOduBai9Ft
 gLLY6vIg4K+HUOoJA64u51q1+eXaF1VT380cjvXKLwh3WTSV5JmG/B4qaaJ+3o9tkQhMaER8Eer
 JxSuzZJ8Vl813nYQpFfcJnJcGWrIfC3ml/KtmKB7/Q8xct3iJ2jU+k5ZNtZxKwuuP7e7IjLuU2P
 tssm1+0uN1HBjA6uBipFfJIpQOEOk7TMMNxO/OaWtRzK+bza97SfxjExynoLnQMHojTFp4Og6an
 2vg5zxVerSppXC33h0j6H/MQPVKIIwvTIxQKGlBnCmKGsQaltgN8e9IW5Q1qDyEwtz1Us0AvVO/
 wBl3Xo0exsBzjnJM0wDyUpm12JWdM98BjfHWGruUpsnTJbDhWTXHDTCzEmPVR2sS9JgI8b4yhU9
 S0nrw4qsfl3+a5ST0advJUUFB2pLUq+f6KzGgOwU/LdcnidCwJ3U44AAgd6t04wT73Vqj1+Kdhs
 z5p3y5HFbevpJJUc7qo1cs/XlHt0OvI+UaBwCxphPHkrkFQgfehp9seXJsOr0pWwHfjnP3QjFGK
 LF25g9blTc04cQ5isJmQB5Irk2fKkDCJwrxf6BgtIxOF7BXx/wrWDBRBDR9S6li09bGv6KKVOly
 /ejw3KOljbUc72Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

sh_serial_can_receive() used rx_head (the circular buffer write pointer)
to compute available space. Since rx_head wraps around, this could
overestimate or underestimate the remaining capacity.  Use rx_cnt, which
tracks the actual number of buffered bytes.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 543671d9907f ("hw/char/sh_serial: Return correct number of empty RX FIFO elements")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/sh_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 30a22ea2d1c0..8728842b84e0 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -316,7 +316,7 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 
 static int sh_serial_can_receive(SHSerialState *s)
 {
-    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_head : 0;
+    return s->scr & (1 << 4) ? SH_RX_FIFO_LENGTH - s->rx_cnt : 0;
 }
 
 static void sh_serial_receive_break(SHSerialState *s)

-- 
2.56.0.rc0.29.g47ce80527c56


