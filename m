Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D670C10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B7Y-0002MM-0W; Mon, 30 Mar 2026 07:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7B7J-0002Kd-MY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:49:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w7B7G-0005cN-Lu
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAJj8ZslZgsOIkvnpDadAqH4+KJQwmg5EMAcBGW7ihY=;
 b=dew0pccTg2ERuzRlfCh2KLYtLspExlbRmb9trAepk4QFrrUkLnalEKVEt1Is9et33yASXi
 woXOzWDefgE3dq45y0Y9XEoc9U3ZJ5glIAbwvcdYFcutc9ZcBgOYxrW3fhfjaEa5NmOo+K
 rJtvlVJMLvcj4tHRAxUKN2VxHXp9kc8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-K7dyrpZNN9WcygoxjbJ20Q-1; Mon,
 30 Mar 2026 07:49:02 -0400
X-MC-Unique: K7dyrpZNN9WcygoxjbJ20Q-1
X-Mimecast-MFC-AGG-ID: K7dyrpZNN9WcygoxjbJ20Q_1774871341
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CC2819560A2; Mon, 30 Mar 2026 11:49:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D46911800351; Mon, 30 Mar 2026 11:48:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: linhuang <linhuang@ruijie.com.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/2] net/ftgmac100: preserve full VLAN TCI in TX tag insertion
Date: Mon, 30 Mar 2026 13:48:53 +0200
Message-ID: <20260330114853.638753-3-clg@redhat.com>
In-Reply-To: <20260330114853.638753-1-clg@redhat.com>
References: <20260330114853.638753-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

From: linhuang <linhuang@ruijie.com.cn>

The VLAN tag insertion helper took vlan_tci as an 8-bit value, while
the descriptor provides a 16-bit VLAN TCI. This truncated egress tags
and caused VLAN ID corruption (for example, 4088/0x0ff8 became
248/0x00f8 at the receiver).

Change vlan_tci to uint16_t in the TX VLAN insertion path so the full
802.1Q TCI is preserved and transmitted correctly.

Fixes: c2ab73fcbe79 ("ftgmac100: Fix integer overflow in ftgmac100_do_tx()")
Signed-off-by: linhuang <linhuang@ruijie.com.cn>
Link: https://lore.kernel.org/qemu-devel/1471e413d3589b6734819bda2b59b725b74f273a.d551129b.99fc.47f6.86dc.0759227268a2@feishu.cn
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 2f05bba11d01..b3da48c343c7 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -498,7 +498,7 @@ static int ftgmac100_write_bd(FTGMAC100Desc *bd, dma_addr_t addr)
 }
 
 static int ftgmac100_insert_vlan(FTGMAC100State *s, int frame_size,
-                                  uint8_t vlan_tci)
+                                 uint16_t vlan_tci)
 {
     uint8_t *vlan_hdr = s->frame + (ETH_ALEN * 2);
     uint8_t *payload = vlan_hdr + sizeof(struct vlan_header);
-- 
2.53.0


