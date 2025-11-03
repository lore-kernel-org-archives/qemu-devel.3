Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A31CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1At-0003iS-FE; Mon, 03 Nov 2025 15:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1An-0003ZR-0O
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Ak-0007eP-Bx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762201740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWzTGc3AvYUES9HKYfYuHSoNeIyyzbhENNJcxTClcds=;
 b=TUWNPyBFrcRDZ/UOhqcutwdfSQGzFyqPxkc7vxkIrorbp/30JcjsbI17omWko7UFmfC7Y3
 E0EkXpKUDR/jOSKLhvyVR9vDwpEMZxv5z6SJs7WvZeRYsK+NO+0BJoNN2/bStXEm9zaYAW
 lhP7w+9qB3VHMIG0nSVou3gYnobtZJo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-_ZorKTfSNQKk-sl1pHfREg-1; Mon,
 03 Nov 2025 15:28:59 -0500
X-MC-Unique: _ZorKTfSNQKk-sl1pHfREg-1
X-Mimecast-MFC-AGG-ID: _ZorKTfSNQKk-sl1pHfREg_1762201738
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EC8C180057A; Mon,  3 Nov 2025 20:28:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19F5E30001A1; Mon,  3 Nov 2025 20:28:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 2/8] qio: Minor optimization when callback function is
 unchanged
Date: Mon,  3 Nov 2025 14:10:53 -0600
Message-ID: <20251103202849.3687643-12-eblake@redhat.com>
In-Reply-To: <20251103202849.3687643-10-eblake@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In qemu-nbd and other NBD server setups where parallel clients are
supported, it is common that the caller will re-register the same
callback function as long as it has not reached its limit on
simultaneous clients.  In that case, there is no need to tear down and
reinstall GSource watches in the GMainContext.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/net-listener.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index 0adbc409cf2..e89286ea63c 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -147,6 +147,10 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;

+    if (listener->io_func == func && listener->io_data == data) {
+        return;
+    }
+
     if (listener->io_func) {
         trace_qio_net_listener_watch_disabled(listener, "set_client_func");
     }
-- 
2.51.1


