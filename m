Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57364FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRs7-0001kZ-W6; Mon, 27 Apr 2026 15:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrf-0001Fs-UP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRrb-0007nw-P5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777319005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FfbGAaXb/Oy6tWZC1/CKBN/B78na+K25Zj2q9/5zhY=;
 b=QVqupSye8CI4Y0DpoO4NuitxFdO/jsXZDn7HMFgDYjN7tfDl3jgx8FuRy1UQYkFUG4SMzW
 q9P4M9WJwj3TxCmdIKuQo1EqujNgTWCbCbCdvodWAsCpyqn356/oVMukl9TmbXvyVLkDGi
 1Xma8FkN7S/4Jrva3RL6KluKeZBTKqc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-yCwMi048NfGGtorr2jsrJg-1; Mon,
 27 Apr 2026 15:43:20 -0400
X-MC-Unique: yCwMi048NfGGtorr2jsrJg-1
X-Mimecast-MFC-AGG-ID: yCwMi048NfGGtorr2jsrJg_1777318999
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28DC519560AD; Mon, 27 Apr 2026 19:43:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D3C81800349; Mon, 27 Apr 2026 19:43:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:08 +0400
Subject: [PATCH 09/41] RFC hw/remote: guard listener unregister in finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-9-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 jag.raman@oracle.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HH5UXO7Edv6cxrRxb3xlPtP6qMYIGzXppxNCDLNUXEA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUiV+S5EUisFrZViZ+m3Nvqw0to9nqOnaOc
 tRJUi6J4laJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5UUkD/9zXw3TYjSmRzTZpwlOtteDS9BC4gvxSY5EseEfOP+gPCIVtJti4fK1AwLPFy/C9SSE1ya
 HA39QXEnaRB3NeV77F5J9uS6H556gpMUUo4xz3pOWCZqeP80a1GuvXMlusBfWDy/sW1uwhQ+22y
 8Sw7mbkQqAvMFK4zvZ34v5ROjhYnObYWwGZIBebGQJPVqGyNpdWcCyOrTnxWPbFMNKrQv0/p8Nd
 XnoCp3JUo8Yamsq1ismFUqkbIJ3/WC9iiylo1JIjOogcw+qq7O13AWcXG8G8SgCcVijQzcT++oU
 P2rWXFarjSvWozuaKlSL/1aR8Cj5OS/ZJUVlOQS08nihrVDKrumC1QgMQ0JcOs7snCFlSeGBaRe
 byWTwZE8VjG+ctxAdF4wKlIdqExGGVbwrQuOkdc89HdgOsJZiwBGR/xS+qsIezrTjOVRAuSo5SJ
 t7Ft0sxrigmGnQvzG11NV0VTxa9SlQ0gndXVHozDKJtgPE3HfgvH2YemHCzBM98QC7Py+PXb3zA
 Q42EFweeI2NPMCLPScnD3NxUwHu3bZB7uHtck0VZ7nMWsSUGCWcP8eP7vNpq6PEG9c0Oyx3oXBO
 AcsIiXnjz9VYB0GV+EegxIA98AGKWzme4f5jtamgBSQD57AQ5FdYl0Eo/I7Ekr+3RdzUoofhwOs
 EqxLL68PBMJwHBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Guard the unregister by checking whether the listener callback was
set, which only happens right before registration.

This is probably better addressed by "[PATCH] qdev: test if DeviceListener
is in use". Just adding this patch for completeness.

Cc: jag.raman@oracle.com
Fixes: c7d80c7c1d9 ("multi-process: Associate fd of a PCIDevice with its object")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/remote/remote-obj.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 86192dc8dad..4e74ae76158 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -154,7 +154,9 @@ static void remote_object_finalize(Object *obj)
     RemoteObjectClass *k = REMOTE_OBJECT_GET_CLASS(obj);
     RemoteObject *o = REMOTE_OBJECT(obj);
 
-    device_listener_unregister(&o->listener);
+    if (o->listener.unrealize) {
+        device_listener_unregister(&o->listener);
+    }
 
     if (o->ioc) {
         qio_channel_shutdown(o->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);

-- 
2.53.0


