Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA89CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvD1-00018R-9Z; Fri, 29 May 2026 07:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvCx-000187-H7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvCw-0008Aq-5H
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1gkuruH5XWMTJyA5erpca7lqSDKedkWZ3gg3SM5nBk=;
 b=RvGJxSqum+a5GdWPhVirTt7HIcbDfn4s+qcNT3MDJW/qAN7unSr4GzgbolPmb5Z80EOOcB
 6W6wrlmrGNw4pv9dDCadvhZQpNOVz74aCwB8aw5+YuDZ032nMFpixIwcqXE9vz9fuUndIR
 2/EQ5h3Zz9ItDBUuPs9i+lxkp5Tkg1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-mOyaV5zZPbKa7p0Yrbm52A-1; Fri,
 29 May 2026 07:16:49 -0400
X-MC-Unique: mOyaV5zZPbKa7p0Yrbm52A-1
X-Mimecast-MFC-AGG-ID: mOyaV5zZPbKa7p0Yrbm52A_1780053408
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBEFE19560AA; Fri, 29 May 2026 11:16:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8128F1800465; Fri, 29 May 2026 11:16:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:22 +0400
Subject: [PATCH 01/32] ui/gtk: fix bad widget realize on non-GFX VC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-1-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=791;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1HVXF5aqswsOauiRIK5zGEQJ8C97FyfNU89DV/WKbEw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWOskEjR/vEs5J+/EpbbP+f2L2xsszcPsvlw
 ChwTff/bCGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jgAKCRDa6OEJdZac
 5RQlD/9fDXRMC6jg4cWoUbn8/dxaepND95H6stMp1jUCJ1/z3iy2ly/wMhMjjN5uEuqxxw7E5/t
 LHNDND/qfwK2pYlClSxxxUpYPYbbPctdyT8h1iI9nu3nyQrbqJR+xJnaVesLbCN4wwD9XNC+OqP
 V1CxYdzOlum4sJ/v33XCUiEWxo4GnR6EOR67Jfu55oVDx+f0Tn62jOiz7dO1+ASiNKxDPXxrg1g
 pymmeNMcCten2CQUGcPVXs7u+MDuIyTMl7gYiR19Dzv9TMUJS3gWnFcy2S3wCSUXD5fE4AoBeE+
 6jgSLyUURBctNp1X6mW51NbUQWYRkIZV9sAD3iGgugdOnXoP8dxN4W+5VRa4RrDXys+gnNWEa8G
 +U05wLGD7MNqFPmmmrD+lbVJZddVsxmDngVysE2+tgNDe0DdrZ+hM4hVfwAofRjbnDYAvjefAsb
 FOlcmRdeTG9Hi0Yk/cp1/5Qn/H4b9Ewv0yf/Nby6PuL768iHFUqFsPxi7eh0hat3xM70EBiH2xo
 AiPAeIOH6fmaaVyE91T9EzlMoIEMftBF+vYntC0vGnJXuM0enCn5gsjh+E7/R8o8LTJyU0GAVL3
 vW/xBPZJaSKkpTcK3qxgtiPnLCVeNJMsUrT0mu/01wifL5Tf9oKLr4zqIVSMH74vEZGikMmYW6d
 R8Xq6jr4nEUEelA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


