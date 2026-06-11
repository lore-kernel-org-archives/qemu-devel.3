Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C77CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKK-00005k-CH; Thu, 11 Jun 2026 05:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKI-00005W-T3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKH-0004On-6i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dqc3xN1aXUIUrHWS9ggdBtgBTtuuRl396MsYkRuz4Q=;
 b=SNMNt25gSm4cn78WJNM/qI0gUAi20tSUGCQPE929Tr/HQVbXF+kD3273EigEkPYb2OCihC
 /PmrH5RbopBc8P/R8tz2e0IllFP0fAwB6xefy7FEyC1/gJuQ2LsZYkvSVx0e+WdJXLVuDg
 dTSUrNsorWKfILiqPxfjYc2AxdghYso=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-y52BmiBuMTy9evHdRWebFA-1; Thu,
 11 Jun 2026 05:03:45 -0400
X-MC-Unique: y52BmiBuMTy9evHdRWebFA-1
X-Mimecast-MFC-AGG-ID: y52BmiBuMTy9evHdRWebFA_1781168623
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9501195606E; Thu, 11 Jun 2026 09:03:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69F1436512; Thu, 11 Jun 2026 09:03:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:16 +0400
Subject: [PATCH v3 01/35] ui/gtk: fix bad widget realize on non-GFX VC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-1-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=847;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yZPCBoGjIn899rr3uGbGHNkKHH9rsNhzwmZ5Ol69PMI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnci7ul/cfy0Xg8nzrxRtKUGcIs45uPXIJAg
 Rfe/QjzpZ2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53AAKCRDa6OEJdZac
 5cn4D/0ZVZWkxjM55OLT5VNlvkJfkUytixWIjtvMk5ArRGgtRn8HG3zu3Ik5Dl1onSZsuYYKejA
 Wp1m5Qq+Azg3UrDC0LfMuu+y178uuWwAnryGGuq45dx5IikgoeSAsr5rfoIK5/gozrjafyPhYnz
 otbFk6IkRJ8RC3h0uqeHP53qMeUrTxqWRcXTWA2hgODtNh82s8cwalqovij0mqrWlxDIURO04bX
 NJ/9BPXMFvrzCRhRM7LfZHcbzWFFSZ1wArU93szjJChpeRio75kc07vVuIjm8M4eyf77/vvBeaf
 d1AGOKCVY1PpvB2FueO3Ucfe7Nu8r6G6NboV3EJ0k6pP9626lC6RfxP1gi9e/eYtUCGcE/T+KeH
 9x0GJQu24r7MzX6LZhS2Q0q6MbQLs0efCkO+j4uSYEXbo8C74QtGVODYzxgDRKG2pbOG+TlMMX5
 yKkCGT+xxnXfKJHcmUFiOPKbIKz49NLocupDAqpOEUGiTkDBeE9xYDGQQYTp6EA5e85vGitiORI
 fD7RXGu+KvhVvuEkxKvGAs1aMftD6QxFQo3qWVIq2dVDWwyzKwKUsBBEbDwfNL15MTHDIcjOrF4
 i7qJe29tcjKNcDH0JI4xwD70aDiF2vgaQ/KhacVezhNTRKizSPNoo/stcWenhbSaP8hw5fJ0wpL
 j81JB7MslGIUc7w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The GTK VirtualConsole is a union, it may be .gfx or .vte depending on
the type.

Fixes: 565f85a9c2 ("ui/gtk: force realization of drawing area")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 4f706c6bbb2..2ee826b56fb 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2585,7 +2585,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
         if (!con) {
             break;
         }
-        gtk_widget_realize(s->vc[idx].gfx.drawing_area);
+        if (s->vc[idx].type == GD_VC_GFX) {
+            gtk_widget_realize(s->vc[idx].gfx.drawing_area);
+        }
     }
 
     if (opts->u.gtk.has_show_menubar &&

-- 
2.54.0


