Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88840CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXX-0006ve-18; Tue, 13 Oct 2026 09:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVQ-0002zo-4S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVO-0004p3-HK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8guiPiutqO1bWlLBvrv1sXzBZcH0sq11If75yHCDGs=;
 b=WQ75OZyTOHHEGqQ6To/RnY6qbRhbckWBb4/7auBsEmgEoBjp7eVRTYiZ98Rk5vJM0oFJxA
 egw9dKO8d2lBLknV2MRWfOkkg11IV0BHFbOIHfbLD8Fy7AhmmOCfTCvyDmy3rDZs1z37O/
 nOoQ7PBIWGex4WcBRhugUpQkqzTPqmc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-GFGBzOngOGuR9zL3yJuwDQ-1; Tue,
 13 Oct 2026 13:25:12 +0000
X-MC-Unique: GFGBzOngOGuR9zL3yJuwDQ-1
X-Mimecast-MFC-AGG-ID: GFGBzOngOGuR9zL3yJuwDQ_1791897911
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B9E4193E88A; Tue, 13 Oct 2026 13:25:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ED8C427; Tue, 13 Oct 2026 13:25:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:27 +0400
Subject: [GIT PULL 30/40] ui/clipboard: clean up vm change state handler on
 last peer unregister
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-30-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XI80s0mXsyM2ofXVtXwcZJPgJ0P1pxUp8mQPbVnrJao=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEb9SDKL2g7+UD2ZlWX1rDtFFvZCNczPeFq
 SHg8DHeJiWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5QaYD/9YcFVORJ9Pg91wbOJYerKiV2CXQ6CVOIZdbQFcTcLdDdj733CuaBQKxwMbIACaATYds88
 yOilH6+3wtEjh4+VXnFA4U2JVd2AyTN8+E3seIPHTF3Sy9mUSvasUdy2Emr8eot+bhIm57jWfBX
 iHPSghLiXVZWahC6jd4UTw4WZ3UlSgC1o6N6A9galhO8afrU4ljcczSTjuVdRfuUS4T+k/sBbDq
 MP7CQDVOCU+BuVhR7RA9B8+36I2/V5WH29O7jKhEmVjIoSQ2PRBHTVwbOQ5ZBIxqju761IKkUPo
 mZlZ4P5fg4cxHmFcYmxdU1if39eMXh7Pde7G+3Eu1nvfdmd+5Qr/m+uw7/++WhZy6XqEox3dni2
 GE3wv0fTgJOvrm8onI2Gz+LpBAKoN38D0f/SFGQ4FH8rtJkdh2Q30gYDNzEmGoNxCJxbWzJYV5h
 MJowjqJngMdmrX1x9K2brTiBEPwtmGbWaKja1SRUQiu0+It8tQ3vZmsdFyKZB92tn0wvMhwVZtF
 GtaMkTLQOHk77OWIjVG4u9O7r2mnFjPNc+7lotJuI7y3lHCAG3FjixzDt+lCWAluJg9+hr4f9Ho
 eQdMgN2E6Pyq/+QV86IaUieJDuq3AI2+kRXWPHt8Laz9fB44eD+6Dps8p7XZWY3MIoiMGnByH11
 tApaSFQ0j1eoCKg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

When the last clipboard peer unregisters, the vm change state handler
is left dangling. Remove it to avoid stale callbacks after all peers
are gone.

Fixes: c967ff606b99 ("ui/clipboard: delay clipboard update when not running")
Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-13-ccbef537cbeb@redhat.com>
---
 ui/clipboard.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/clipboard.c b/ui/clipboard.c
index e3d8a31ba9f7..46e602dfef43 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -76,6 +76,10 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+    if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
+        g_clear_pointer(&cb_change_state_entry,
+                        qemu_del_vm_change_state_handler);
+    }
 }
 
 bool qemu_clipboard_peer_owns(QemuClipboardPeer *peer,

-- 
2.56.0.116.g6de20f6092dc


