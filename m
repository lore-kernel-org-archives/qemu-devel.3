Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A761C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 19:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb2gq-00080h-3s; Thu, 23 Jan 2025 14:16:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gJ-0007xu-P7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gI-0003Cr-8e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737659756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4idOmdaT2Lwr+HmD5ha5reAkr+A38GhsY764Z9KdUw=;
 b=hVnoCmibeVcCZdKQCj5EmqVIssg4RKBBD6yMpuEwbI/caTPTpCkAFD33RIeXxkJP3f+hy6
 GcUkKGg4K5ANql++tyKvlQyxzSY6jRdd6uV/FwGalZFkcelGDzbOF/SGyotH9ZT/Q6Tjjd
 p5thsb7mTYmLUEa0dkLWWPrqW+cm9ro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-5_8EwfKSNxyP7Zr-CiQHrQ-1; Thu,
 23 Jan 2025 14:15:54 -0500
X-MC-Unique: 5_8EwfKSNxyP7Zr-CiQHrQ-1
X-Mimecast-MFC-AGG-ID: 5_8EwfKSNxyP7Zr-CiQHrQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FE46195608B
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:15:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8B163003FD3; Thu, 23 Jan 2025 19:15:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 4/6] ui/vnc: pre-multiply alpha with alpha cursor
Date: Thu, 23 Jan 2025 19:15:34 +0000
Message-ID: <20250123191536.142753-5-berrange@redhat.com>
In-Reply-To: <20250123191536.142753-1-berrange@redhat.com>
References: <20250123191536.142753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

The RFB specification for the alpha cursor encoding requires that the
alpha channel is pre-multiplied into the RGB components. This worked
by luck previously since the virtio-gpu device was not reversing the
pre-multiplication on data received from the guest. Now virtio-gpu is
fixed, the VNC server must apply pre-multiplication itself.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9241caaad9..5ffb50109d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -996,6 +996,7 @@ static int vnc_cursor_define(VncState *vs)
     }
 
     if (vnc_has_feature(vs, VNC_FEATURE_ALPHA_CURSOR)) {
+        g_autoptr(QEMUCursor) tmpc = cursor_copy(c);
         vnc_lock_output(vs);
         vnc_write_u8(vs,  VNC_MSG_SERVER_FRAMEBUFFER_UPDATE);
         vnc_write_u8(vs,  0);  /*  padding     */
@@ -1003,7 +1004,11 @@ static int vnc_cursor_define(VncState *vs)
         vnc_framebuffer_update(vs, c->hot_x, c->hot_y, c->width, c->height,
                                VNC_ENCODING_ALPHA_CURSOR);
         vnc_write_s32(vs, VNC_ENCODING_RAW);
-        vnc_write(vs, c->data, c->width * c->height * 4);
+
+        // Alpha is required to be pre-multiplied into RGB components
+        cursor_multiply_alpha(tmpc);
+
+        vnc_write(vs, tmpc->data, c->width * c->height * 4);
         vnc_unlock_output(vs);
         return 0;
     }
-- 
2.47.1


