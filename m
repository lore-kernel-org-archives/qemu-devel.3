Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4129C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 16:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMqtG-0002Ha-Vd; Wed, 04 Jun 2025 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMqtE-0002H1-Sj
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 12:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uMqtC-0002Tm-Ps
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 12:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749054172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waeG/WPzOXTZyR7c/T8yClE/5mR5pnYJDMCmjqrOhP8=;
 b=PKBYNewMrRvgxBZov9yfnPe9ynv4Fwehvs8IXTIyU28vVCDi6tC+uzeU1MNonJh9Qxl5P2
 Mn7fyvuhsKUhbLR1RCawvID+CJnkwi+BiI/8RizSYpmZYgFUqSgFcTj9uksNKIXEkgcpT9
 UPJ4ROuYKAu/cJ9lDupEOMmc6XwfARY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-lL936bvnMJCzPPwzx_OLQg-1; Wed,
 04 Jun 2025 12:22:50 -0400
X-MC-Unique: lL936bvnMJCzPPwzx_OLQg-1
X-Mimecast-MFC-AGG-ID: lL936bvnMJCzPPwzx_OLQg_1749054169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A36D6195608E
 for <qemu-devel@nongnu.org>; Wed,  4 Jun 2025 16:22:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.60])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2EFB30002C8; Wed,  4 Jun 2025 16:22:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] ui: fix setting client_endian field defaults
Date: Wed,  4 Jun 2025 17:22:42 +0100
Message-ID: <20250604162243.452791-2-berrange@redhat.com>
In-Reply-To: <20250604162243.452791-1-berrange@redhat.com>
References: <20250604162243.452791-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

When a VNC client sends a "set pixel format" message, the
'client_endian' field will get initialized, however, it is
valid to omit this message if the client wants to use the
server's native pixel format. In the latter scenario nothing
is initializing the 'client_endian' field, so it remains set
to 0, matching neither G_LITTLE_ENDIAN nor G_BIG_ENDIAN. This
then results in pixel format conversion routines taking the
wrong code paths.

This problem existed before the 'client_be' flag was changed
into the 'client_endian' value, but the lack of initialization
meant it semantically defaulted to little endian, so only big
endian systems would potentially be exposed to incorrect pixel
translation.

The 'virt-viewer' / 'remote-viewer' apps always send a "set
pixel format" message so aren't exposed to any problems, but
the classical 'vncviewer' app will show the problem easily.

Fixes: 7ed96710e82c385c6cfc3d064eec7dde20f0f3fd
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index d095cd7da3..51872d1838 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2329,6 +2329,7 @@ static void pixel_format_message (VncState *vs) {
     char pad[3] = { 0, 0, 0 };
 
     vs->client_pf = qemu_default_pixelformat(32);
+    vs->client_endian = G_BYTE_ORDER;
 
     vnc_write_u8(vs, vs->client_pf.bits_per_pixel); /* bits-per-pixel */
     vnc_write_u8(vs, vs->client_pf.depth); /* depth */
-- 
2.49.0


