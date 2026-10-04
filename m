Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BC0CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJRG-0005Lb-Oa; Sun, 04 Oct 2026 06:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJRF-0005Aa-5G
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJRD-0003WI-PJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxDiqCDT0NJ3JfL32/e9xX5tlCLU1nWQTe+YAmylX90=;
 b=HUoOVmRI32f+tp+nJ2VKCci5evLUu441GJAII59Apcx/BWMWE3O4XtjQihZaw4LFw5Y4G7
 itWlHP3vW/qNtv66Ny0lC74yRnKI99JnppvXPWGTfdPC7rParnU91F4EIl1xCwJVURfG1b
 TA/AEe2OPWE75yjtQSGcjjxwRKOE0o0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-lfFzYA21NxWW20rKe6ixbQ-1; Sun,
 04 Oct 2026 06:27:21 -0400
X-MC-Unique: lfFzYA21NxWW20rKe6ixbQ-1
X-Mimecast-MFC-AGG-ID: lfFzYA21NxWW20rKe6ixbQ_1791109641
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22A4B19541BE
 for <qemu-devel@nongnu.org>; Sun,  4 Oct 2026 10:27:21 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1802240E; Sun,  4 Oct 2026 10:27:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:24:17 +0400
Subject: [PATCH 63/63] hw/input/virtio-input: document queue preservation
 on device reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-63-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KPvJpNC1Gbi5WL7rRtH5tY+KWoI9rP6ZFikXIOK/LT0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwiklAyKlZ2a+hz4qoKnGKeN92kJsRC+oLs5Qh
 +Yl3CZANYeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJQAKCRDa6OEJdZac
 5VNdEACrUGf3Qi/KAIhVuPFuLHmu90R7p1MKHoVa93e8yAbf6nFKahryyfe3Biu2BZ+aWVIbAQW
 ZqUIeJK017ovXSogBI8Hu20qg/5YP3RyqYnGIEC7BqyUbOvYr5llA4YNvfV8C/tdySFjVJoL6/l
 kFj+7ljc49g+dkYGTYKrpjIXqIXDsBxAmtMl5d5MOhrQHrAWqv/Lxdj+6YPDnR4BWDG1JnXvC0A
 6Z7dRP+Gmcxau3GnTqitHJypU6YvL0Khf0+SPO7leeNxIFT4pln8PBXZBYTKKBkOJzsLxi4Z2NB
 AXEHBLnnHpxIqpTNpK+HnFNN4Yma7FQHXjP0XKLPFS4mdX/40MuRxMKjGAjKdwAhxzHbjcX8C6s
 fsa48cppkuikrjhckhPU//Y/41O47yyTpBDpvM7MF0mRwZh7lvGfXSY8a+pn+xCDqZdU0LKq9xc
 TkfO2DD8ajn+mnRWtGnHmrdQzE/IialpP256ztsXhKm5wugVOYuKfeNAGi9gH1bH5Hxjo/LXLi4
 dWoqrkkL7XmGKYo1EVFp0cmwWvccNUUgw2r8ILaLVyeIyD0e9QJNgZv9Me/HBWMeaxtX2CnZAq0
 gImIPeNnfBesyHzJ5oJzpcyI899HgzWryz+5q/zDXwYR/v/cgrixQQiIJcSFf3BlW0XRp+f58jw
 UHBnakh7d2Hk24g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

The queue and qindex are host-side input event buffering, not device
state. They accumulate events until a SYN_REPORT is received,
at which point they are delivered to the guest. The elem pointers
are only live within a single virtio_input_send call, so there is
no stale pointer issue across reset.

Add a comment documenting this intentional design.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index dfd2964ae122..aefe02d14ef3 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -217,6 +217,10 @@ static void virtio_input_reset(VirtIODevice *vdev)
             vic->change_active(vinput);
         }
     }
+    /*
+     * Don't reset qindex: the queue holds host-side input events
+     * not yet batched (no SYN_REPORT yet), not device state.
+     */
 }
 
 static int virtio_input_post_load(void *opaque, int version_id)

-- 
2.56.0.rc0.29.g47ce80527c56


