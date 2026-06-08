Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B5CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUES-0007XY-4o; Mon, 08 Jun 2026 03:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEM-0007WO-Sx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEJ-0008HU-SX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1gkuruH5XWMTJyA5erpca7lqSDKedkWZ3gg3SM5nBk=;
 b=PqFJAUko4e1xrF9RnAwHqInYq9FjPbC1PIRpI7E7HAXNYgX26mJ71imIKushM9dlsC13Hp
 /NBnAoj6NyymgKQVug5/aebGmDIQzr5LNv7mzEniJtjDO4JfzD9aljROxP8ONRsXO+rkO4
 cYAvWlZE3Cv5NELT0Ng240jq7FxWLZU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-9Se4UYf7OW25JBe7gUa4sg-1; Mon,
 08 Jun 2026 03:16:58 -0400
X-MC-Unique: 9Se4UYf7OW25JBe7gUa4sg-1
X-Mimecast-MFC-AGG-ID: 9Se4UYf7OW25JBe7gUa4sg_1780903016
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE4B195DBB0; Mon,  8 Jun 2026 07:16:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2666018005B8; Mon,  8 Jun 2026 07:16:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:19 +0400
Subject: [PATCH v2 01/33] ui/gtk: fix bad widget realize on non-GFX VC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-1-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxH+40tXh3vUuws3fBfWhUU/KuHRbFHr7anI
 JHj/XIeMkiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsRwAKCRDa6OEJdZac
 5RkBEACdtCwfpIBmh9tf1qnj3HIbATMG0/pvV9K/vScLGbn2TxqTrpUqfEvkVvOPLrtzdCM2USm
 5rpUOJAJsjflMxewHpOr4X8w2cMMgQT1R5TdxZ7dd/aWgC+lmxg3qUaDA5/sDJ61LkvVSddZLRW
 jzbqUoImH3MJcj0Le2y3x3BAcBvZ+5HsM7W6W6cjd5cdr4D4HGPQE1+z1X9tzmWFFNXo9mK88qM
 f9tNGkmOePuuZbeANmW6/I1G4tmeH3qgg7rsYXPUzayg0+ZbiLvHTFU6ujfmOL+19fhjGy4rL0q
 dmOGVFvXzhwg+HSLc7vlJJXmrJpTJuJXCs1uC/VPc+35kE21DuDIrYymfgPLZ229iVCKxAS2xdX
 FHTdyBGaOAKC8UJQ4d2M8S5Umzu9uL44cYXjMRWLs2Vej5yUVVu9KWLUQQkuLSV3pxxtMq+E8Gc
 IiDD0wj5MoY66mD0TUmVUr0UQN/IYoZwbWF7VIsAIP73uF8Ns6Pq7hB5VU3y+xT3ede7JGoh5DF
 0ZSWmtT9kMD9n9thefd/mmyoeBDmjysv06pCldF0BQIap3TE4FmZ3pHnqocKBzy+oaHi+/BeB03
 YzO/eZ9p653r7cYFn1Zc9izfTAXufqRq7jmcSP8nihaAymCSwwlVBrv0GDZ2x9qxeDKbmHb5ejK
 aoPG26wLOXlaTkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


