Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861C0F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRy-0005sf-Oi; Fri, 10 Apr 2026 15:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRx-0005s4-HX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRw-00024m-3z
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhExG9TArFQDlmGymQu8tjVvDR/BAoOXKx/Gp/p2Yt4=;
 b=ab4zImlej5PiEGVHC1T85LUsxwjJf13epZxkFOG94y27lmxXyCsZtMl9B1zT8+VwGRCdRp
 pcHZUEaewMthzBKKf2EGpdBjJsGMmLzCbDpJNYEQLBEfwYD3Mm246SO8z94pLHO7GuLz4D
 wMuSw1lhz3e9mlqJfoKynj+qMBT/QUQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-ZNyNI8IxPbOBTe_AAGtJ4Q-1; Fri,
 10 Apr 2026 15:23:26 -0400
X-MC-Unique: ZNyNI8IxPbOBTe_AAGtJ4Q-1
X-Mimecast-MFC-AGG-ID: ZNyNI8IxPbOBTe_AAGtJ4Q_1775849005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65D29180062A
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E4331800B7F; Fri, 10 Apr 2026 19:23:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:07 +0400
Subject: [PATCH v2 45/67] ui/vnc: make vnc_disconnect_finish() private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-45-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TI0Ey03CiCOcFcFkocFPywnSpvg2ppZYx+CVIUcYMR4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0W48bMUDp+7T96KrzO9AXMeSYuc2ttt9gAu
 4rN/ot5KraJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5c2kD/9t8wr5w0D/np3Cw1eTSFqQ9mjsoDAIircW1D9WMmzwSUPWVjhh4uzr99uz8tlrjQG6kDJ
 sYWZ0Al3fCEyYzVH9g/Q3J1uY+F2zifMcWbdolu/6JYEwd+PTtE/D81oJxoSlirUMtR20U2uVy3
 tDuag5O2V0kXu3relHlACMbv6MrsnqSSw62POIoMsU5jRIkScR67Nto1IxpFq3hr2xZ0Xo8PFBz
 mQrcizLcCjqoGl9obv0AKijNPG1WDFzqYcV1+Z/cK4fs4mNPxpJqIpEr4AbCBu/g2Smf6AlOd4R
 6DbYqM8fikTgVlZNELK1QG1fCBMqDLxt6v7W6jQzmM402eCPKK78tymgA2oPsFADQISMvY4+moE
 kFEfvd3w5OqPdpfLhu3zjDElQK+MFCKJgrLOcQjWk3sxVbwSIVkKdcXFFCpcYB0qaFHxU2poEAb
 isaLJ9Wykgvdb9bVYwYHbGlkxMMmzmupBU99aFDVfFG3R1pGEnOsKthrE9dKbP4iFltYlo+2M9W
 Vxw70WWGnYSZEEe8Jg0rQLb2AfTGoRvQJmxV+5Lv95lBAtowlsNGeX09OAJtrNzy7YivCu6tmuw
 441vlOPnXTfa5GFY/lONWg+rnfYVBdlUdPNTUgkKGaNllR4cm9tycTZ2BHhguLIzBqG/IoCRlx3
 r/2HOtCE4qG/P1Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 1 -
 ui/vnc.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index c5d678ac31e..110c2bd4600 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -570,7 +570,6 @@ void vnc_write_u16(VncState *vs, uint16_t value);
 void vnc_write_u8(VncState *vs, uint8_t value);
 void vnc_flush(VncState *vs);
 void vnc_read_when(VncState *vs, VncReadEvent *func, size_t expecting);
-void vnc_disconnect_finish(VncState *vs);
 void vnc_start_protocol(VncState *vs);
 
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 512e11d687e..ba7376360e6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -71,6 +71,7 @@ static QTAILQ_HEAD(, VncDisplay) vnc_displays =
 
 static int vnc_cursor_define(VncState *vs);
 static void vnc_update_throttle_offset(VncState *vs);
+static void vnc_disconnect_finish(VncState *vs);
 
 static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
 {
@@ -1307,7 +1308,7 @@ static void vnc_disconnect_start(VncState *vs)
     vs->disconnecting = TRUE;
 }
 
-void vnc_disconnect_finish(VncState *vs)
+static void vnc_disconnect_finish(VncState *vs)
 {
     VncConnection *vc = container_of(vs, VncConnection, vs);
 

-- 
2.53.0


