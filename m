Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01651C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLz-00055n-N7; Tue, 25 Aug 2026 07:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLp-0004r5-6Y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLn-00066C-6F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWgAZ1AyegSTTW4gj89kS8+r1JbK1pHytcOIVnLqzyQ=;
 b=d+jUFggIIBRP/u4M/fIgwscI4WuNOffR+wSBc5EDxAvQUT7CiGgHTwxHj8LkUmKYDiz+U0
 uap2j53yNbIGyZkviGWlSsaH0semCIY6zIYwp9LcvG7qIwwvB4ZcUmjfsnf1VzUE6ukRbn
 AjdW+nSqW4ov4OWXrQv7rtaJ7KoxVAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-EQOlTFwDMdCQ5FjpL2-xow-1; Tue,
 25 Aug 2026 07:29:50 -0400
X-MC-Unique: EQOlTFwDMdCQ5FjpL2-xow-1
X-Mimecast-MFC-AGG-ID: EQOlTFwDMdCQ5FjpL2-xow_1787657390
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C0E8185BE9B; Tue, 25 Aug 2026 11:29:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F69B30002EF; Tue, 25 Aug 2026 11:29:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:01 +0400
Subject: [GIT PULL 11/19] chardev: Don't unregister yank upon async path
 connection failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-11-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gd0spWDHKZEABG/sZGft7YCGTAOdSumlGndxgUzlP/g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrUEOnQPGIrT6mP3SfqplVtPuBf52POnBsVe
 ghw1hDpZd2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5Ri2EACowYh7xLznSd2mlfGWRDn8OHHR1WZlfHO0JLOQIlO3IpMCcDOl9qxxpHhaYZ9B7ODv7us
 j7Bn9rkDGqwPLlvt3hGljBeT97qS+vq3Ysr6/2vysGCpsJGCcqDiqGYDbhPDKzJx03RNb0DE8D2
 xStWVRma/ih40D2QQHd1bZlBQRjaUWlm6GedOFKfucwIAXVCbtZlyLK0kknMrOPAamUof9rbv0C
 L5RJpxkrspL+kM70tesPNd4EBoGBldDIQivLEVCiPpmXNuJmqAJ41gp2ETIldCdhZ2iR+TONvMi
 X2xv+dv4O/kkgARkGd07bkVMbkWV3cp69jNUgA9OuapIlHBR18FUGYtKyptPeOp3j1q/2QvbDR6
 KMdWXjnNDCSPR9rs7UXBEyKiOccFKIVqVeSOIB3tRDERXu/6qRNxUe6009jcVsvvWApMJZV7Xnt
 MQcN5yZiqLNRuKpYEfl0rHhmKCTgQqWrQUkFPEKbn+FEWr1YxK9wTp28v6RbPSXpjZeAzifPZV4
 xLBxVERW/pMogL8K9KN380CWjNwuBbisXlM6PaJZDi0uaY9KYj+9nGG9qh5WXyw/WCK49QWYzOI
 Ehi5YzDdFUzWUuIO+euriOyO+zoSJKdF83opx9YALt9F+m/F7kyHYSDIs4rYJEm9U5FLxy7ZKam
 qhtqdU/mwQjn6Lg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Commit 5c102ac9 ("chardev: Consolidate yank registration") has moved
yank registration in the tcp_chr_connect_client_async() path to after
the connection is successful. If qio_channel_socket_connect_sync()
fails early, there will be no yank registered to be unregistered in
the error path, leading to assert.

Remove the now-extraneous unregister.

Cc: qemu-stable@nongnu.org
Fixes: 5c102ac9 ("chardev: Consolidate yank registration")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3528
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260603141137.1108963-1-farosas@suse.de>
---
 chardev/char-socket.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index b629575fcf80..81bac42a1587 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1128,11 +1128,6 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 
     if (qio_task_propagate_error(task, &err)) {
         tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
-        if (s->registered_yank) {
-            yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
-                                     char_socket_yank_iochannel,
-                                     QIO_CHANNEL(sioc));
-        }
         check_report_connect_error(chr, err);
         goto cleanup;
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


