Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA7FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDg-0001Qp-Pk; Fri, 29 May 2026 07:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDf-0001QE-Cp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDd-0008L8-W6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcFD3eGKhNYPPn3etCR+FB+6qCGmANbtAookYVP4Y8w=;
 b=EXK5Huep0RV66X8hnJ6zrm9SOXOLL29XgYyk86MBmvxhql87vLsiIGyQn/7v71/vxvsXN4
 ROz8XlCe4zWofrVl2YL4lT7zYXjDdDSMRdBeI3pBUiZ0iSP0q4//4rddp0MaR9L/DBN/dJ
 tL449YqW9Tddkweh1yjZKP1iN8CpPVA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-3ILKgsvnPqiez2vz-DrG9Q-1; Fri,
 29 May 2026 07:17:32 -0400
X-MC-Unique: 3ILKgsvnPqiez2vz-DrG9Q-1
X-Mimecast-MFC-AGG-ID: 3ILKgsvnPqiez2vz-DrG9Q_1780053451
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B8551956080; Fri, 29 May 2026 11:17:31 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1776C30001BB; Fri, 29 May 2026 11:17:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:29 +0400
Subject: [PATCH 08/32] ui/qmp: keep a reference of console across yield
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-8-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0olnm0BeIdXkJ0+wwoqLifsBYBl2XPr7D4I8xkjuhkU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPVLLCzPc3rqkr/xqAtSmVT+mB1jI7R+sy3
 ZN0dMIE2OeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5U/GD/98/ZclwQMV2LAQY3RXlGIe2jXdZ+7fu8CEEANVEBx3fTQQjrO7676ZKeuSGIZQuOZsvbt
 shXH7W7MMr5RBxCxmlcSE+8GGKU8PuAzKAUFRU5FHe3HRNG0TPaeMX8imcNxa6r2AtP9KwiWGjy
 KpuOqBF1HI3yMyEf6qeoDDLjzEFXi1/TPtcWl8HjmGbeYPw7OrztLDICCBs93nYP3Fuu2P2arwm
 WToJoWmT1WUUsmxbVcV2kAA5keJAI9e7yC70A+rjmyLc0SZ9c8ExQ6o5i9gDX/Lh1hIBme7IWLU
 ab0jIj0PmfVL/WqZPktEZugYhmMsI0aCUMBl/QggaVI0Tc6bHLBiJzNeSTJwCO1lp6WVOhHd2Kf
 4TlqEV0gDwSXP/NmdnxsGwWDXQRquv1kmRdFTyt88C4ngc1KK2ToeGYG/+qOXjH76t+Y5W/9Ukn
 Um/Erkoxi5LVju2oE4M3DHzIokRPO8S5XWyfA48Z1cCtsnFMv6f1BfSgU56HAnbqA/cjRBWO/fL
 ypYfsEbWYcJrbCHO/kLBSi9u1xaeFgh41+k992E5e6yOBS0k4rRumA8Q5tcnFmqTWcQXLa2d4xy
 mw13YOUzeFf+qdeoWZV/Fr6SM95hgCkUMiOMv+0O1PfOCCC0v6LCrDoK7YatkEra7mwmV0imL74
 dHk5/x6WZGEnsig==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

While the coroutine is waiting, the console could be finalized. Keep a
reference to prevent this.

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


