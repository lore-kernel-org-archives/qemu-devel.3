Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463E7CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQr-0004Fz-LJ; Sun, 04 Oct 2026 06:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQm-0003pg-P9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQl-0003TL-9f
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mYguefsKtjpw3Axb+YuOOHGH+GKmeeXao/xbTg7TcY=;
 b=Q1pSrgcqEdbigEMA86MSmnSsDymBlkgfm/wt4PFBRQp4rWj303LzQGAzswGHT7DOz1v929
 31xnwtxIlJg4DSNymWAMKIfxejijUyfC3JiP86tP7kNn5tY4E/k2/vafb5Ie21CVbDRGsZ
 vtTgekVCci3Ny6XXIdp1vLTaAniIX2g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-AFCDAc4DOXCXBcjRbmpTcA-1; Sun,
 04 Oct 2026 06:26:51 -0400
X-MC-Unique: AFCDAc4DOXCXBcjRbmpTcA-1
X-Mimecast-MFC-AGG-ID: AFCDAc4DOXCXBcjRbmpTcA_1791109610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 456961954238; Sun,  4 Oct 2026 10:26:50 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B783180034F; Sun,  4 Oct 2026 10:26:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:08 +0400
Subject: [PATCH 54/63] hw/input/adb-kbd: guard parent_unrealize against
 NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-54-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KcXSbMVnsuTd6AAcm9tkevUL9tTzOX5r97HV0TTwowQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikltW01qmHoATT2xj+TLkT6LcmODhoU/adqO
 ospVRi56DWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5VhIEACLoy6zvxJyQWYIxgeg2rnqON4yH/VXqtVr7vLH7TuGUCQVhVu/z8boQdEX/YIWSKNsM3g
 /27CEgKNkPw3T8RXBJa0G9Sg/Ouzge5BEQUwe9KWA05/bVNmTJdOqcl7Wvj5TWRgKwW35ALDs1r
 ZaaUHW9BWv0NPQq5/YiBpuR8JBoCr9WeyxaZbZkmZapkF3ZKp/bpusn9IyrZcuasLRPJVkjIExo
 nOYwtpBiexLPnyp8Ns9MRGMF1NHVkJMNPACFw0zm2vQKkmzSBw0+IEYMRFsZAXpc0hsaimteFEo
 FxatN/QhMmbMdQYAMCPox0of3wCsZh8Y3N1tlGyxGEw7bq84tnHapDG84cUpr9kC9V6h97/iqDZ
 sF5X/Y+V20wdZoGMYW/sT/btmX4MyvenrFpbQXi29AnHZ52GIETrHdWyqbfSVtvX/N6E0HOxQzh
 IOeDdSMuTcQg9nvv5I9bxmDoW+uAi16VLqWvMiQciDdtAjXMEUeEJYY87D7RNj6GKDYHvwcSong
 qJpie6ps7a79XxaYUCqkoOkWSZg1u0qhc9NFHChXWcA9VAg/uTcgQhlhJusB+MjBUFhbdMHHAv3
 9EXu3goi3XRpD46eU/d6ADVnKvhRLvk5oeooPvkWfTP3G4Bxi+1KT3DyKAOXF2/sfMnOoravJy3
 B9utqAXfgjVj+iQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

parent_unrealize is NULL since neither ADBDeviceClass nor
DeviceClass sets dc->unrealize. Guard the call to prevent
a NULL dereference during device teardown.

Fixes: 6a935957d60e ("hw/input: keep QemuInputHandlerState in adb-kbd")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/adb-kbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index d4a131dc1295..43c0ead60c59 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -401,7 +401,9 @@ static void adb_kbd_unrealizefn(DeviceState *dev)
     ADBKeyboardClass *akc = ADB_KEYBOARD_GET_CLASS(dev);
 
     g_clear_pointer(&s->hs, qemu_input_handler_unregister);
-    akc->parent_unrealize(dev);
+    if (akc->parent_unrealize) {
+        akc->parent_unrealize(dev);
+    }
 }
 
 static void adb_kbd_initfn(Object *obj)

-- 
2.56.0.rc0.29.g47ce80527c56


