Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDF6CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpL-0002rg-Gz; Tue, 23 Jun 2026 03:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpF-0002bt-0o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpD-0008Aa-KZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fy9FDnBBuQA6XOva2yHkr/+J1a7o999MtLZIJzCYeGU=;
 b=W8Ra/2zus8I6/xEvf2Kx5h9/Y3+PnkLKFLBKLMrQjM1I6zYA6ZpeKZT+o0OemgQhSE0kh2
 p12EUKxp95BtKfS3K4NeqKAPUh72ZS6qBgjRsZrrEqDyX3YlVix59EBBEJWuZtLY3UEzOY
 BgJEV56VPo/bECGOtKFgRR6Eoa69CIg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-gOnD82rtMlOWcb05YFZJCg-1; Tue,
 23 Jun 2026 03:45:35 -0400
X-MC-Unique: gOnD82rtMlOWcb05YFZJCg-1
X-Mimecast-MFC-AGG-ID: gOnD82rtMlOWcb05YFZJCg_1782200734
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBAE4195605B; Tue, 23 Jun 2026 07:45:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C03A195608C; Tue, 23 Jun 2026 07:45:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:25 +0400
Subject: [PATCH v4 10/34] ui/qmp: keep a reference of console across yield
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-10-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nFUMF9aw2NB5tNGhWCH8b3CLuYQw1GaCHR49bKZmaWs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldRqqv1je+E1MNVmKJ97owRmE80A6m1+RZu
 Q93aWrj2N2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5T8CD/9GlXxtFbe6pzVRch2CArMWIax+6H1pqL43T6NNlRbrahDHJtMtm54OP3gLQvP07BLTaIo
 zWm4GJ5egANjua0Bd0tW54wmdo/tH5SuMg/ExpNz4tL8K7pCPpURl3Rllzv0NqmwkA0J5QN2GHY
 123VJiA7pgyW99mGIKsHq9X9j6lcZnFBTwcBFN2hrik+/hDe4XSyJ4z1q/P8mzShpxestExU7e1
 8rXqLWqzlVEVMMjZuxWp6aHxRoAEsOKanmHk3faF5eCcXPNnymDTRqkO+Z8jsIrPNG0OHGINjS9
 XXe8VFrdrSLULyYekVyuRki5cDv3Am7X/IN7mvJEVmHNGitRss2xi2WCrHgsyTLVLBYxpwMZmYX
 0w8L/hwv2psgYWs8EacAxDa+0xs37Cj6fFKTf1tQDAa8xcG1wAL8yMiEZBEBdwihJi4HKYDA8Wr
 8IViVLXJxRT3Y1ietZzFp4U9/8j6RlNDiUI9JUiKo8bGvaPAoPvHoxv5V6bqSRnuBBeeLOG9dgn
 y1Bo5Z/pG2e7nka6Od93GHYMYXFUPNITWYkOzUkzlCwLx9vB/bCnsy+fB6eqifo85ymk8d9wtOA
 UzGqUPYJqtjwnpIB6oX+PzKOiImHpBHAmc4b9m+twy4b2Enf+1RzIjfNo2W3We1jhgMqcxkzk1t
 YFCC5hFmQ6QP2XA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While the coroutine is waiting, the console could be finalized. Keep a
reference to prevent this.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/ui-qmp-cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 1173c82cf7f..753cc2bf522 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -348,6 +348,7 @@ qmp_screendump(const char *filename, const char *device,
         }
     }
 
+    object_ref(con);
     qemu_console_co_wait_update(con);
 
     /*
@@ -358,9 +359,11 @@ qmp_screendump(const char *filename, const char *device,
     surface = qemu_console_surface(con);
     if (!surface) {
         error_setg(errp, "no surface");
+        object_unref(con);
         return;
     }
     image = pixman_image_ref(surface->image);
+    object_unref(con);
 
     fd = qemu_create(filename, O_WRONLY | O_TRUNC | O_BINARY, 0666, errp);
     if (fd == -1) {

-- 
2.54.0


