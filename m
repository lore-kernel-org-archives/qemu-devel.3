Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC8CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXeU6-00012p-Fr; Tue, 14 Jan 2025 05:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tXeU4-00012P-PB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tXeU3-0006SS-6j
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736851758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vuOXz/FMmveVaX83PK8mbmXnusd2fVvNMvvztVwsWN4=;
 b=eq036aTxqsjtYlJs6cM79ZSWjLXKBte6f8Bu2kMQKjdTxKI1WSwJpMUBO0l7Wap5bkdJQK
 Yh7Kq7gkwSZdk9ULeGQnRmFh2qCO63T/ltTnl4LyvcRHNpHCuz5gqGp6+JZyuCcwQB+9Qu
 zVR7dxrqG5xvY6EJ2BWwkv9UaBj69A0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-f1ts0h4eNLOdAwMoLHcMGQ-1; Tue,
 14 Jan 2025 05:48:09 -0500
X-MC-Unique: f1ts0h4eNLOdAwMoLHcMGQ-1
X-Mimecast-MFC-AGG-ID: f1ts0h4eNLOdAwMoLHcMGQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988D21955DD8
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:48:08 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F1D619560A7; Tue, 14 Jan 2025 10:48:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/dbus: clarify the kind of win32 handle that is shared
Date: Tue, 14 Jan 2025 14:48:03 +0400
Message-ID: <20250114104803.2612599-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

"-display dbus" hands over a file mapping handle to the peer
process (not a file handle).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-display1.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index e70f2848b7..d702253431 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -527,14 +527,14 @@
   <interface name="org.qemu.Display1.Listener.Win32.Map">
     <!--
         ScanoutMap:
-        @handle: the shared map handle value.
+        @handle: the shared file mapping handle value (not a file handle)
         @offset: mapping offset.
         @width: display width, in pixels.
         @height: display height, in pixels.
         @stride: stride, in bytes.
         @pixman_format: image format (ex: ``PIXMAN_X8R8G8B8``).
 
-        Resize and update the display content with a shared map.
+        Resize and update the display content with a shared file mapping object.
     -->
     <method name="ScanoutMap">
       <arg type="t" name="handle" direction="in"/>
-- 
2.47.0


