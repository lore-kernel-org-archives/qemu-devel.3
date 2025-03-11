Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF7EC35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts255-0007D2-Gx; Tue, 11 Mar 2025 12:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts22A-00041M-64
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts226-0005hY-Mu
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nWszQmqouRumPlbII1dV2LPkhLnNaMA7EcBowO/kG4=;
 b=Zre0RGnePSlPrXKb7ltjvLe/hXf94ldA1SB7zRPLYfHZovaJAtsZRm4NKwDKEF/tOrf0Bp
 ud49kzU0PsKPJQ7TSZdc0ww5bqJ5/7zHOzRMagBMyzzbhbe6c+9XJKfSxJv0o9fmvTlOF6
 MX+S19sXrn9wwnmbbkIW4IAThpmole8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-q-A9w9HrP1evJoX2FFhbxg-1; Tue,
 11 Mar 2025 12:00:38 -0400
X-MC-Unique: q-A9w9HrP1evJoX2FFhbxg-1
X-Mimecast-MFC-AGG-ID: q-A9w9HrP1evJoX2FFhbxg_1741708837
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C589A1800875
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:00:37 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB07B195608F; Tue, 11 Mar 2025 16:00:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 07/10] ui/vdagent: keep "connected" state
Date: Tue, 11 Mar 2025 19:59:29 +0400
Message-ID: <20250311155932.1472092-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
---
 ui/vdagent.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index ddd8990318..011a9057ee 100644
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
2.47.0


