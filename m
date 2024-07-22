Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54232C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzIw-00019e-3b; Mon, 22 Jul 2024 16:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzIs-00017O-4k
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sVzIp-00027J-1N
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721678793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpIYkPtIFl9GDRrx7vbHRdm4IlgMiiShAArC0FXdW7w=;
 b=H9eEnaw9lHH2l8YWqLIIknlu8yzldOxoP1DwrjVJ2Fl2GesBcZwo8Xs0I+FaKjVCHnbk7q
 RVFHmA76dz/Po26pHDZ90mT5a7bxhcGh3xWdrYWs5oK9nSwe9SoyvDu6PFezwQBX4Z3bxa
 0ktU9Bj0OIxEhp9yaYaJoO2C6OQceZE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-I6q5Hzt7Ps2VKevMa098fg-1; Mon,
 22 Jul 2024 16:06:29 -0400
X-MC-Unique: I6q5Hzt7Ps2VKevMa098fg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2D3E192DE1A; Mon, 22 Jul 2024 20:06:28 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48CE219560B2; Mon, 22 Jul 2024 20:06:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/8] vnc: increase max display size
Date: Tue, 23 Jul 2024 00:06:11 +0400
Message-ID: <20240722200619.135163-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240722200619.135163-1-marcandre.lureau@redhat.com>
References: <20240722200619.135163-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

It's 2024.  4k display resolutions are a thing these days.
Raise width and height limits of the qemu vnc server.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1596
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240530111029.1726329-1-kraxel@redhat.com>
---
 ui/vnc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 4521dc88f7..e5fa2efa3e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -81,8 +81,8 @@ typedef void VncSendHextileTile(VncState *vs,
 
 /* VNC_MAX_WIDTH must be a multiple of VNC_DIRTY_PIXELS_PER_BIT. */
 
-#define VNC_MAX_WIDTH ROUND_UP(2560, VNC_DIRTY_PIXELS_PER_BIT)
-#define VNC_MAX_HEIGHT 2048
+#define VNC_MAX_WIDTH ROUND_UP(5120, VNC_DIRTY_PIXELS_PER_BIT)
+#define VNC_MAX_HEIGHT 2160
 
 /* VNC_DIRTY_BITS is the number of bits in the dirty bitmap. */
 #define VNC_DIRTY_BITS (VNC_MAX_WIDTH / VNC_DIRTY_PIXELS_PER_BIT)
-- 
2.45.2.827.g557ae147e6


