Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D3DF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRX-0005gm-Uz; Fri, 10 Apr 2026 15:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRW-0005c3-06
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRU-00021j-ML
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kWlbYarbpq8q7vX6x2MmnM15GIOhf9S8XQMmsXaO9s=;
 b=ViSOSgB46VTQ2vjXVYQn1EPr7yqUVsKGKaSvkYMAuJr6RuyTJFYGekpMwGfSq9C560rPnc
 uWugUJwdGPnUTeM/NvQwCJPhpXKc5qc3YqrIL0u1nYCCgcC7VCJhlbW4HzoG6Lc71lBIqt
 KyrV6GWc4xPT14Qk0LBfATwVM31NzKE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-l0V46jO-MjK_dbROrs67Qg-1; Fri,
 10 Apr 2026 15:22:57 -0400
X-MC-Unique: l0V46jO-MjK_dbROrs67Qg-1
X-Mimecast-MFC-AGG-ID: l0V46jO-MjK_dbROrs67Qg_1775848976
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5335519560A7; Fri, 10 Apr 2026 19:22:56 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F00A2195608E; Fri, 10 Apr 2026 19:22:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:02 +0400
Subject: [PATCH v2 40/67] ui/vnc: assert preconditions instead of silently
 returning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-40-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=da7UZtFscHYGKLrYZuUkMO/YLUmJ4YfpeTA/WP9zdYE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0Vydsrx4tA+tY+1afN3tj6rYtyIpSK7bgbm
 IT1fiD91F+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5fyHD/4y5jUz4y1iEgQGRBG23K69av/mdL8wDipxaueP84smEmQfsl1dHylFCM2mkcAoqUPozQn
 mMXESWJ9p78HXK21oCYmRN3hPfBoLPho+afJJtuw4IB1TT7j7NYiMFF4lE9waR0ZLjOZ3ClJw5o
 2DAF6T9O9IL9+Ekfh/qKLlTqzYWKBlTBJel6FDrvAR9NL07tQyOgSjn9JmGzuKn689TCE/3Nsvo
 nBL2U73PRbZSbY0Wjs9vBtdK/AS4ab8h+4sjsv1Jr7DTULDkzZMpMeTlqTP0VlZWH2t3sRz2WhM
 rUjVrINzOBfPadKFGTBjklt/G+KwHwPeQtkAEqmXE7RIc2FlnqV/PpiqapTnvKgaUrQWGk1arLx
 cU0GFVHOyfU0GSHPGpHh3tK3QRyfSTc56Qs7/0Xe77Xn8zfItpi88tDadGqkHPacxBkmFebycOr
 TC539gu3QxOx7Movx3c9CCbAGXDhUbsJl64dChTjrO8Bo6fkkHC9zpJXPmNBiKsAwiKIYpKuyQJ
 Gaa2rEPN4ma7JxwCUg4D3VP+iKwGcJjIEOethhMpLIqhjW2hW8vpBUWR2DkcG4akuqS4Nr9R9H1
 bq0CG+8cBVbo6t8M9viuofLfQguk/aFlnp/fKL9gjzqRB8JCuCgXloBVafQMNcMthJGpr13EPg+
 +dPKwbIgrFI5/Lw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Replace defensive NULL guards with assert() in vnc_display_close()
and vnc_display_open(). These are internal functions whose callers
guarantee non-NULL arguments, so a NULL value would indicate a
programming error rather than a runtime condition.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9c8fe280bc9..3633fbeb6ce 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3465,9 +3465,7 @@ void vnc_display_init(const char *id, Error **errp)
 
 static void vnc_display_close(VncDisplay *vd)
 {
-    if (!vd) {
-        return;
-    }
+    assert(vd);
 
     if (vd->listener) {
         qio_net_listener_disconnect(vd->listener);
@@ -4068,15 +4066,10 @@ void vnc_display_open(const char *id, Error **errp)
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


