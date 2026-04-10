Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A9EF45A0E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSd-0006gM-UV; Fri, 10 Apr 2026 15:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSc-0006aF-53
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSa-0002IX-0o
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5EA9qSQCNA47jzrSjzbVaC3/g32Fx5iKVDCU8M/Wzw=;
 b=BeAbsDFBSn95Oa7Ckc0w7FCSfInAd8rZUcn/ydWxWVqJK/z4RxeTX/CQM/sCnlGHm7+V2E
 dVdx1Va9nEraEHvIUl0vOFPHH/NcTdE5ouiT3wGRQ2UnPJVkbZIwVXRBHu+MousyGYl8Qr
 epcSalaFOsxSFoazkptwMIuAu+SCZaM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-6tXDd8LzPZSsak-KGNla7w-1; Fri,
 10 Apr 2026 15:24:06 -0400
X-MC-Unique: 6tXDd8LzPZSsak-KGNla7w-1
X-Mimecast-MFC-AGG-ID: 6tXDd8LzPZSsak-KGNla7w_1775849045
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57FA0195608F
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:24:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 324A319560AB; Fri, 10 Apr 2026 19:24:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:14 +0400
Subject: [PATCH v2 52/67] ui/vnc: expose vnc_disconnect_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-52-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VgRiT+iClPrrXXrZKR4eliNBjks4fxV4ogsV96pOHUU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WCLUZEYmMmLgvaJ+Kbro3dICK3oMCxRlof
 4U48ZpvyiGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5eG7EACEpozKLq7w7nWx2xKsy1WHcqogL93ik7w7BdkJCSiGYIWny7mdjNlwmS4uIUSsubb+VMm
 DO2XcW8e/tJTEqFJOGZvHUM3yFgLn90IeMxZUpbUQ3sPDnaDHDq9XHmmcaK+9bxDQU+PHuXWWYc
 ztXE7HZM/2+ZhsrpSINoYf3F3/sbDJdSR1186ZecvTOjmthFUwekVt+4ulfF1Gv2bm43KDG4XEJ
 /ibtTd1UCgZmDn1Gf7PYS1tN7XmhUTy0LJLTjcSNksCUbd5u9t+VoSEg12QZDHBfczSlAiUelnX
 kcnPnTT9wZK1rI+OWNk2mhhcHYDoC4ivR26DBXZ1TKtniAUkHkD4QRf+vwTDbrRo7qgnWrnXcQr
 ZTpmAkJ5jJt0mOmad4MMloYDF3Ot/rI8w3+qemKiqgvDc3lp9+oZuz2ejGFga71XRfzXcaqbasL
 MkIFSuVCRBp5kgWQ2dJwYlhseHiUjMbKammo4NKq89sz7gEQsqOZ/vCODbu++rrOjRLgV5z8MoI
 Qbahf7DBF337t6JjoEKhzDVUd8R7yBP3hnhNKGuJ6L6XPz9S6sUxyvDWtePLdHp34JfBdzUbiui
 wSyYstigOra1K8zveUWm5n2W2Ogp2QHGHVTk2qJA6WWB5rKKbVTmar9Fe2ix8nZgdTFxOTKAl1m
 6TYVvrO3FnDycdQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This allows VncDisplay users to tear down all clients before freeing the
VncDisplay for example.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 1 +
 ui/vnc.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index de41517be48..794341265b3 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -560,6 +560,7 @@ void vnc_display_free(VncDisplay *vd);
  *****************************************************************************/
 
 /* Event loop functions */
+void vnc_disconnect_start(VncState *vs);
 gboolean vnc_client_io(QIOChannel *ioc,
                        GIOCondition condition,
                        void *opaque);
diff --git a/ui/vnc.c b/ui/vnc.c
index 747b1c44e36..6fef80e98c4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -617,7 +617,6 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
 */
 
 static int vnc_update_client(VncState *vs, int has_dirty);
-static void vnc_disconnect_start(VncState *vs);
 
 static void vnc_colordepth(VncState *vs);
 static void framebuffer_update_request(VncState *vs, int incremental,
@@ -1296,7 +1295,7 @@ static void audio_del(VncState *vs)
     }
 }
 
-static void vnc_disconnect_start(VncState *vs)
+void vnc_disconnect_start(VncState *vs)
 {
     if (vs->disconnecting) {
         return;

-- 
2.53.0


