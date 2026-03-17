Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A2EF3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDz-0004uZ-PV; Tue, 17 Mar 2026 04:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCQ-0002ya-KD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCM-0006p1-KM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGn1kwoZqRzEPfZ7L3thAtcBGbOjUmNNivIgdm7tnB4=;
 b=iAwotrkE+NFsN4VCBVNSEPMfPd4xKoj6s9cvPw2RbJGGGNyXWNdXx1lm44+XW/lSHP2fRy
 Ix07aBFdLccLG66R4iaLazGTMNTYhO04jXb83xTpD3r3pPl33uMXg+gEip5/Fo1luMTkLs
 2cdtRBq7CY8zCNIvPa7UaQBNdQ0ktYA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-vjqSHQFIMKmtsS1Bya0MvA-1; Tue,
 17 Mar 2026 04:54:44 -0400
X-MC-Unique: vjqSHQFIMKmtsS1Bya0MvA-1
X-Mimecast-MFC-AGG-ID: vjqSHQFIMKmtsS1Bya0MvA_1773737683
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EBB1955EAC
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9D0F3000223
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:56 +0400
Subject: [PATCH 42/60] ui/vnc: assert preconditions instead of silently
 returning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-42-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=X4qgBvBliW+YREf4/3xvNHw7a1+98eJKhFPoGll8W5U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXcZtehu9FXAyg/a/h3Cxam+x/WwH2exmBUm
 I/XHSeKVpyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5bJGD/9KmQSyeiVeb0H5irkKizDwFX0zWB8Lgtt3ePAAn8/HgiJugvyJXr6xnkQBomJ65xQSFR7
 LZGT9Y0LNT9ypFXMCZPo1RTTEa/kbNNSplad7Yb+xx7s0VNkovbvrooIz1etEHRxWs7Ph092SI2
 1lWLK5uQLp8Ku4jH0Ixngn53DvayT/a9kzoN3wUw0BSDBCSA6uC5nLtcyIqHkywji+EJ5AMLwVY
 XYn4thYhOKvs8uIjcJAOrVjkdDBCiacmRa9CFNaJSqQqZ4o+f8liKxolEWktpL/6Xs3C14P/W3f
 cnxk6CZSdXkNaeofrYimv3HIR2fMseekkDBve5E4/LWat0JpV8JYvU48oG4MI7kfANmSr3H2dvn
 c8JF2j1WmuxqVfH9n/nvfjROR+MDACd0cu24LjRMHVy2LGvMZ1rmlvUuIMDS7njdLdvYFsj3JSI
 hEmAJBSxhTuQscVwIb6xSNP4W8DqNU0lzVNg90WeD0YV8igkrNCd56nAXS0Xr1oTR4WKgmuP1eH
 wqdVtNS/xddBcaibxr0ZWWcVNXghJIp8Pp3fkS9fh5mZsmCkOw1qgQmmhG8EnoBRMqYTBd9UABr
 1b5qRVPrGquByVr7FO3yhHxaMPZGk4kJSm+Xz9ij+ioCQrwH0BCWns9yIewvIkh9BwMnxJjV5tC
 8kvKInN6aPxmKQA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace defensive NULL guards with assert() in vnc_display_close()
and vnc_display_open(). These are internal functions whose callers
guarantee non-NULL arguments, so a NULL value would indicate a
programming error rather than a runtime condition.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 87ec3e6d799..605e5117b7f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3464,9 +3464,7 @@ void vnc_display_init(const char *id, Error **errp)
 
 static void vnc_display_close(VncDisplay *vd)
 {
-    if (!vd) {
-        return;
-    }
+    assert(vd);
 
     if (vd->listener) {
         qio_net_listener_disconnect(vd->listener);
@@ -4067,15 +4065,10 @@ void vnc_display_open(const char *id, Error **errp)
     const char *audiodev;
     const char *passwordSecret;
 
-    if (!vd) {
-        error_setg(errp, "VNC display not active");
-        return;
-    }
-    vnc_display_close(vd);
+    assert(vd);
+    assert(opts);
 
-    if (!opts) {
-        return;
-    }
+    vnc_display_close(vd);
 
     reverse = qemu_opt_get_bool(opts, "reverse", false);
     if (vnc_display_get_addresses(opts, reverse, &saddr_list, &wsaddr_list,

-- 
2.53.0


