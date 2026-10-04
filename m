Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1165ACA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPm-0007wQ-Ox; Sun, 04 Oct 2026 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPL-0007Da-OV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJPH-00037N-QX
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDvmUrpSZFbddxMZ2XSTXnx0hcAOXC1b8GHxaOnNf50=;
 b=OpX/YFmyG/DgO5AN2J8VtOT/3xk275m5YJgGCCP7AdMS/4kK0mJSzmG3GcCtpkQPglfnri
 jOenGqr42jQyPdH9GUBE9yQrKUhYDQt56Adf2q6E9E8QUgcFL/1UJmZn/tjx6vZRUm5raH
 cx+ZdI9WkTBgeb2M3QJTJ7gls/F5OEA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-w4UG-ivdO8iZh5Ldv5L_-Q-1; Sun,
 04 Oct 2026 06:25:19 -0400
X-MC-Unique: w4UG-ivdO8iZh5Ldv5L_-Q-1
X-Mimecast-MFC-AGG-ID: w4UG-ivdO8iZh5Ldv5L_-Q_1791109517
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACE411944B3C; Sun,  4 Oct 2026 10:25:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7F65180036E; Sun,  4 Oct 2026 10:25:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:42 +0400
Subject: [PATCH 28/63] hw/char/cadence_uart: validate FIFO indices in post_load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-28-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hEggC17mQKnDL+zbUCHoL/9wM64254M76J07w+8IBzg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikjNcnwVYctptFYwKfQD4T6kQNedaZu/6LBZ
 h62U7dHsUSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIwAKCRDa6OEJdZac
 5X/ID/9D6aDM+qKugifxU1GHzLAz9+ZRzh2rRr035ZZ+49HH7iMWI2HvJGCpKjt/luRt4yUoAtZ
 rt6fkUYBAsyJv1povhnebOZK2JxK4zEKTKu55ANCK20ZXaisZ3J6KtfDdEIeW+8fn+9H2ce7WuZ
 uDfVNAo+7cGOC4xnT4P9a24w+7ZP/BhnAlr1BlP9U0QYKaWLs1n+0QxJUoK9qIaK5evd3ly8xRf
 6HKog7oKKLtG/yGsZNtVJNf4oq9mBuQ/T4qvNq9BZkTZ/qlu31YlDOkVTP2e8be3AnWoav1CEGi
 0XDxzAvOiV/3fUzyb7lCBIUAmjIob1E0z7gUfJ0+If5Puc3Oj7+IzEOQODnNO1uEFwYXce5JmRh
 8V2bAYjeS+hU7+ku+yV4QZN3m9Y/WTTJEzv+52+iBZxJSi1Ppjh3I1Ol5oXL9l+rZT8DpHVmRHN
 rSpnZQQkVEtdxJ8cAlP6rd49oLEC4KHEpUKPOsxv51WtSNBoXTcBWCcwoorLRib1hgQebY3B+Oe
 seaLVmuRTULdWJzlDYAYtvdMZlOqNH1kM3KhpCWuRbc0j8R+taPKkDECqK/AlhzRw55OC1+CjX9
 MbsZpPDkPtdVU1xEppSK6vCxgeYojpEw2ZUEY5wrF/yvWhuM1rU+r9Sml2kTS3HdwgTND3GXjrU
 2nsZEwBE3zLFosQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Check that tx_count, rx_count, and rx_wpos are within valid bounds
after migration to prevent out-of-bounds memory access from a
corrupted or malicious migration stream.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 35548b06cf55 ("cadence_uart: initial version of device model")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/cadence_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index c790372e98fb..1a065e2429eb 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -586,6 +586,11 @@ static int cadence_uart_post_load(void *opaque, int version_id)
 {
     CadenceUARTState *s = opaque;
 
+    if (s->tx_count > CADENCE_UART_TX_FIFO_SIZE ||
+        s->rx_count > CADENCE_UART_RX_FIFO_SIZE ||
+        s->rx_wpos >= CADENCE_UART_RX_FIFO_SIZE) {
+        return -EINVAL;
+    }
     /* Ensure these two aren't invalid numbers */
     if (s->r[R_BRGR] < 1 || s->r[R_BRGR] & ~0xFFFF ||
         s->r[R_BDIV] <= 3 || s->r[R_BDIV] & ~0xFF) {

-- 
2.56.0.rc0.29.g47ce80527c56


