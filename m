Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F4CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJP8-0006Xg-Ps; Sun, 04 Oct 2026 06:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJP1-00061q-0i
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOx-0002wx-7K
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9afB6ieT2GdJIlREWrhqHNqpWAWxhn3DbycNBx8iPY=;
 b=f46gI5ONQ2ZyV0bzL8hNqjiz35m0pWr8ZHMT8S/207FvT0SIY2g/0z404DCFDH+rPk1tNl
 GbEYRoETncF2TYTcgGQOv7doadLtC/0OOAZ3rHSOT4kVrIa9xUcoVrkuxk8WOXlkx3QITj
 nGs2Xa+vVjXwijZTe6SS1zo6qCyXf4E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-Pu_-pKd_MEeNOs5pGcOSUg-1; Sun,
 04 Oct 2026 06:24:56 -0400
X-MC-Unique: Pu_-pKd_MEeNOs5pGcOSUg-1
X-Mimecast-MFC-AGG-ID: Pu_-pKd_MEeNOs5pGcOSUg_1791109496
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E75361955E9D
 for <qemu-devel@nongnu.org>; Sun,  4 Oct 2026 10:24:55 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 090C4418; Sun,  4 Oct 2026 10:24:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:36 +0400
Subject: [PATCH 22/63] chardev/char-udp: clarify read_poll return value
 with pending data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-22-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=847;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eZK94XyFRiuiO4HXp7XuY0uJilUSVtXsP/5dE+NfcIA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikiMBGN2su/BN8SA2puGgn8JzLA6kmWCqDws
 eNOq+J8mo2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5bR2D/987XGxur4MVr5JoSvJbaeKb4WQDC5K/JAy5JohZwgY3Aw+OS7gbyryUU/naIghBMmbWBY
 CNfLih9qGzrDrxRRj3FiUBtM8WgCXuLH7idF6DBETNsR3FhY3dLfQoprjeWX59ruZJrqmVnBH1Y
 gMYeoyIMFScJjYTBb5wiRmf8NKsqp/Bdfs9/7NXytgNqzoi9y4YsOZKnLCbxyWmCNn1gLC1QfKV
 g7qElfCCl89Whz3BKv/bbja+g2+/+zAB/tPerx8WBtNXAOAifgzZ/QYwnFlavt9GyQP4WjiYqHv
 cJWcm4fka2to3PjRDynDaCl+o/CcJR/lLcWCazPNETgOwDvzhJdN0GlVDA6K+jTn4dBCsW/61re
 1h/Xf5YGbVMDfv2np5bZUSOa3OjqutQ9lrQCl4DasmlRboF/bT84ogPMo6sehWnlApsUAP85qDp
 bLjxJSvUucQbU9/0GHkQ7KbW3v1Zegbp3XBSdbaPV2+fVmvKXlgG8mBDtP2QviFWuZVxTbBB4NH
 ypxqYSh2yNSVum41jlO6xqmTOeJe+sPRyxQAb/HJPlf9NUmhjOWohubMUgFXAHZodXkDLOtIp1J
 1bwRv/7SrtsYX2Y5YBEahjq1BzhRVrKuti/duOJK4d81U0Jfno50InB+iJ6buwFZMrLq3plfqw0
 TsDJctmm20N73vw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Add a comment explaining why returning s->max_size is safe when
there is unflushed data in the buffer: udp_chr_flush_buffer()
loops while max_size > 0, so max_size is guaranteed to be 0 when
pending data remains.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-udp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 423000832ffb..618fd8f135a0 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -81,6 +81,10 @@ static int udp_chr_read_poll(void *opaque)
      */
     udp_chr_flush_buffer(s);
 
+    /*
+     * udp_chr_flush_buffer() loops while max_size > 0 && bufptr < bufcnt,
+     * so when pending data remains it must be because max_size hit 0.
+     */
     return s->max_size;
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


