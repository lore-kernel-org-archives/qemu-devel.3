Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6E9C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdgA-00049n-Je; Thu, 30 May 2024 07:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdg8-00048f-OO
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sCdg2-0008Ka-TS
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717067433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVzW8ryhx2CZcJ4RMVULMysmm1Bvws8nOF96mzl1BzM=;
 b=gTzSaTlhTbu2Dp+XM13419ercW8OWtuPYbaDE+Z3eNp9lvBMHYg6OhNMI5UcKW0z+2SsFX
 5Y+rpSyOGBhfrJKb7YhQfBPtJYdDmUtrHzEbKIVxUdShUB5YsRgHtD58zn5jX9Ku3PyG1M
 0p9DDc75qHsTIUIX0BPyePY+gD2+QD8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-qSccE-1TOjOI35m5EagTLg-1; Thu,
 30 May 2024 07:10:31 -0400
X-MC-Unique: qSccE-1TOjOI35m5EagTLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3BBC1C05122
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 11:10:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39FF73C27;
 Thu, 30 May 2024 11:10:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2680F18000A9; Thu, 30 May 2024 13:10:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] vnc: increase max display size
Date: Thu, 30 May 2024 13:10:29 +0200
Message-ID: <20240530111029.1726329-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It's 2024.  4k display resolutions are a thing these days.
Raise width and height limits of the qemu vnc server.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1596
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 4521dc88f792..e5fa2efa3e5d 100644
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
2.45.1


