Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B1EC54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmt-0008Q3-IB; Sat, 24 May 2025 13:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmh-0008Ds-6l
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmf-0000ii-1T
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uX4W6oscBViDkzVCmMiWL2OgGFIZSnMNoIBKHZYTsUQ=;
 b=M0aNwNlaTT8o/lnUZ5KnDREP+B+eDbTF94LecN9wWwC1zlVwfH2idb+nmQrcYHY/Bd3Voq
 yxmjE7L7Wi4QZ48/Ct6kdIns+28wcYM5NwlyfNXnWsDki45MrbvEUk7t4vAYtN/Yl9kSVh
 S5/oJjMjWpyH4DGbxA5s0Xef+d6PXqM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-jBiUQ04TPvK_5ZgVc5dpkg-1; Sat,
 24 May 2025 13:35:42 -0400
X-MC-Unique: jBiUQ04TPvK_5ZgVc5dpkg-1
X-Mimecast-MFC-AGG-ID: jBiUQ04TPvK_5ZgVc5dpkg_1748108141
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C31911800446
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 17:35:41 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F422D19560AF; Sat, 24 May 2025 17:35:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com
Subject: [PULL 07/19] ui/vdagent: keep "connected" state
Date: Sat, 24 May 2025 19:35:00 +0200
Message-ID: <20250524173514.317886-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

During post-load of migration, virtio will notify of fe_open state.
However vdagent code will handle this as a reconnection. This will
trigger a connection reset/caps with the agent.

Check if the state actually changed before resetting the connection.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vdagent.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 4027126b7d..210b8c14ca 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -40,6 +40,7 @@ struct VDAgentChardev {
     bool clipboard;
 
     /* guest vdagent */
+    bool connected;
     uint32_t caps;
     VDIChunkHeader chunk;
     uint32_t chunksize;
@@ -858,6 +859,7 @@ static void vdagent_disconnect(VDAgentChardev *vd)
 {
     trace_vdagent_disconnect();
 
+    vd->connected = false;
     g_byte_array_set_size(vd->outbuf, 0);
     vdagent_reset_bufs(vd);
     vd->caps = 0;
@@ -876,6 +878,10 @@ static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
 
     trace_vdagent_fe_open(fe_open);
 
+    if (vd->connected == fe_open) {
+        return;
+    }
+
     if (!fe_open) {
         trace_vdagent_close();
         vdagent_disconnect(vd);
@@ -885,6 +891,7 @@ static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
         return;
     }
 
+    vd->connected = true;
     vdagent_send_caps(vd, true);
 }
 
-- 
2.49.0


