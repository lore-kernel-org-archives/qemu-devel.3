Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96187F3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QAS-0006pQ-Cd; Tue, 17 Mar 2026 04:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9Q-0005nM-1H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9N-0002ku-QC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULKC/GyOqhO9BitzpnZ4orgYTBW0IIWBoIGM1x15EWU=;
 b=Duui/yHCwzl3zoqDCFLrcwoA4A1qc5fg5r+kXz2d9Kq2ZrBerfNAJqXhAZLcM2L0zJnSuy
 eP2cRwSDQBGfxcIcSS0agFhhJnanJ8xnTYRJ+QHLJkTbiIMGrJ6I8LCVnJqQsXnQrBkBeh
 +mxPQGB14RU43Y0NlcgmG+lzrgOaL8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-pgRGtbn4O42leeWyAvH-xA-1; Tue,
 17 Mar 2026 04:51:38 -0400
X-MC-Unique: pgRGtbn4O42leeWyAvH-xA-1
X-Mimecast-MFC-AGG-ID: pgRGtbn4O42leeWyAvH-xA_1773737497
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9C08195605E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91F9519560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:24 +0400
Subject: [PATCH 10/60] ui/console-vc: fix off-by-one in CSI J 2 (clear
 entire screen)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-10-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VebFzA6zCZ8jkFSjyM/gHzN3UDC+mBf8iDhH+bXfkmg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXa6QDNgIaWXjDZad7c3VqGktw1WJjc4+HDN
 xE3t/ESUBuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5eemD/9GIIRhLMbnYIZaDCrhZGH8cCaXzdjDW+bbTgoYmaLBIkjGZbgaZAVM85vPOVHrR7CRc02
 EGoRkx1phP754krSFqWQ51jiat6mgKp0AwaeZx5fpd1GAkS566iXUZ33i0D+qJu25a54ILvKPq2
 MfoioXE0+n9IY51EHUQexy1LyT1nmPZYqTc5qGRy/9lkvo2SF+UYxsQUdt4Llpu2GTGjp8+NWEe
 1WdW1Wp54ZI8CiTSLWXGBWtzkgKixmO6lNwO2oI5Mm4p4TTcTPVuTcNMLvt9I8QS4hkMtPUMiWp
 22x26KuUAWW4mGEpMZ0k+aVFMsG/J9fVS19XRthB7MV24DN9tS4rBs5XODoEp2FVHnIEvf0HGU9
 Tp21P6UFbElB+ytxdR9WY/O6CSlwfNn9f2JqbP0zYLA7CduyijSuv99IsnbokDcyFV8jj/kE567
 Sn8sr1Ez+HB7YlBoAgMRSVWFS/8KlAzT5laJmMYO+dQlm93JFQMihYJWKlvOOVdJPQyw7ygOy1T
 jSaNH62XxAeo8GoEKn8rFamEhUtnl1Vc8R5BlrvhqkaRBqrEyR3y8KnI4HIAi5Rj8MReDyICdRg
 kZUFvpz3xvQtqaOV1tp6U8bKAQHbBYQkKycwI/YxTQCh6KM3uxe5HO1vyKwGq8hkjpYL45gsy3p
 jfvU4P5gIVzDvLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The loop condition used `y <= s->height` instead of `y < s->height`,
causing vc_clear_xy() to be called with y == s->height. This clears
a row in the scrollback buffer beyond the visible screen.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index f22806fed79..8dee1f9bd01 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -899,7 +899,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 2:
                     /* clear entire screen */
-                    for (y = 0; y <= s->height; y++) {
+                    for (y = 0; y < s->height; y++) {
                         for (x = 0; x < s->width; x++) {
                             vc_clear_xy(vc, x, y);
                         }

-- 
2.53.0


