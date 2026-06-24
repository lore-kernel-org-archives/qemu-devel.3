Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8FACDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzF-0007YR-GU; Wed, 24 Jun 2026 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzE-0007YG-Ba
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzC-0007Xf-Vx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rwvm0heZz3R0LqIqZgisrHF0J2mZ0hz0l/+i0BlB8Uc=;
 b=Gohphz5QFpDDkbKHcr3BaCsEuXEqq2P8EOJPRR6uO/YSACise7bc0h7m4vSMyjLVVjJrPL
 /OhTtkzgf190qNbhuDMOjrVr8Xk50xjdNcEOU+zqPkGMd6gSPhaWMrylGumVZQpdNH1QNk
 PoLhTcrBjQJ3ZjG0DB4XdWzmRuggWk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-Hjf9siIxMRSIX_w-GjRrmA-1; Wed,
 24 Jun 2026 07:41:40 -0400
X-MC-Unique: Hjf9siIxMRSIX_w-GjRrmA-1
X-Mimecast-MFC-AGG-ID: Hjf9siIxMRSIX_w-GjRrmA_1782301299
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77DEF195604F
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:41:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60DCE1955F7A; Wed, 24 Jun 2026 11:41:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:23 +0400
Subject: [GIT PULL 01/35] ui/gtk: fix bad widget realize on non-GFX VC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-1-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Lphq9o9GHi5BJsk5K9YAkkrWmRehPIkRbHAIo+f0RAM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jm9vWMl3ly5O/1xbR71zKKLKj5Y8PaEeAEr
 u9oQ8nQnoWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZgAKCRDa6OEJdZac
 5chrEACLG4RR0hTp9d9AL9KwnLpIx0blkT3Ax1bGxee0mplXmwKdMr+KJhkU5simyVBIkCN2P6J
 CiJchlB5t8b7O8FH5vBZrvZKVQTizlAmVD/q5YvUkBhRo1vgSsleFM59GUcDqSdBOUb/d8Rjm8C
 g/sS3o7w4nrHdTFFkg6Di17yvqvCckrjAUeZ7uWQjxqiL2y86DaSGYRRUEjxZlDfHl5KCv83gCY
 jfF4/GPp9gKPPeCvNArO8TqyLanl21kSCnJK/VYaHZ5VD7+H4OagVbAphgS7LUEjcAWoyAp6kG3
 Bh1EmWlarz4aQ1JMag8Trju+zMbgG8DIex/x1aNPXDPSQvzkpXfBlZHOoevgBveH3haWdNaXaIR
 Om3kmLfsD+NGrnj70PzBWLi+2aGWMesHbz5S4iflD5pCYqtOBQcwQEqcMPuqGXjrCkDeiKvqd6n
 /L8XFRNfWFS1WscRJVHlnDrzeb8LZrfCR6CblTHoeenws1TNVm3VxKtbTQmJSdtZoylBB+lRlhK
 ja6O1oXL5qaOCKrI+ZQ5HuaIhsqxqiYjY1LhKOjxhL/0RjNY1wZUxdYFE4+nyXUaRq7e4TDm4wF
 eg0JGSWSp5ErPozEPtCu68vu33TNFvFRVtBPi+WPK8ldP7mR/UoeqDy/xDHCVjvdBiwCgZZF+L1
 syo3fh0RMdiJojg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-1-4656aec3398d@redhat.com>
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


