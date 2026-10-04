Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A217CA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOl-00051t-08; Sun, 04 Oct 2026 06:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOY-0004gy-Lf
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOW-0002v8-CV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEab9JG0Tz5AfaVXFnh0gQeV2su/2M4TGIg6I24dabE=;
 b=XagAalklJ3kSsRLHv1BmQmYCG0y82ShHuheROiIOLJJ2d/VP+wvDUdom2UI9VfPFSvVZSV
 HgEnCdyCIH6mc/+YoVf+MlmD2cvQyk1aEXJ4MkMh9yswvMzWAywLy0wvcR1jnlWXo5+mqW
 umWk6kcj9QMH3KWPma3jGnJCePx7Kog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-WN5BHHf6OJ-7mcuhW5Racw-1; Sun,
 04 Oct 2026 06:24:32 -0400
X-MC-Unique: WN5BHHf6OJ-7mcuhW5Racw-1
X-Mimecast-MFC-AGG-ID: WN5BHHf6OJ-7mcuhW5Racw_1791109471
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 454711828ABC; Sun,  4 Oct 2026 10:24:31 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C61D426; Sun,  4 Oct 2026 10:24:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:29 +0400
Subject: [PATCH 15/63] ui/console: use QLIST_FOREACH_SAFE in dpy_refresh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-15-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0W7D+nrLls1xmI3VLtwCnwqZ3XvK4/+d11RmLadi2cQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikih1ZhtZC3Q8h6oWah+0JdVx75M+NEq80jm
 Pc3CzecxueJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5f/pD/9MsxVaOgfn1C+OMGJM2vZtjeOtfvh/Fyor7tJnpZ1uXJlWSpto52idaOdZc+lL6C8AI5X
 ooRgSw4vCe85EUwIFZHr9QjEc4kgFx2Un57fjcI7RpgSMR5RKXz8erpdiugcYcFwsGpLgQFJrUx
 jmIzZT+7JYrVCgxIVxoahwIW5D61hAzADs/Hn2ogBOJiX0CtZlr/J9PrcwXr65FB2kr5v9vK9CV
 f4B9eVs84aBnuL0fI8BAOF6d7usjWSwfBAXLa7QJgf7r4+PapoIxRXNVfO2fGy+XpKKbN09+fBE
 EcMMELm4+ACUT2jV8YWPjmVdGGXOxmaE+5kQYUAyhIqI13Vgpnb0ILgbKTmAPeXRzPBg3q3NNPo
 AoQqOJw2MLEmSP+JZUspsnCBa1nrYpgTMH6vzIu+tuad1JtAxsuDUVSp7xcertz9AsIRoDIM4Of
 mdf0atEDHLapDhkwSSBTU54YVExyuiXWNtbOXojkHh0u1GTd0j0OF/hXeUF3B08zpqzFJ0U/k8V
 Mn7zw7dbRvBzcz6O1w+v3scPQMUMB5AYkbeylDCzNSla7O5vOGWC6H+o1t9RWI8vD5BSwbJ8UX+
 6TKgQDpB0UwWiDXRq3XOof7lIBMWjvqjoGBVvZOmxNTGXqEC6fvlu6Qdnj+Hj1Q4jHqGABir4Oy
 bXQAiXOz6nqC+RA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A display listener's dpy_refresh callback could potentially unregister
itself from the listener list, which would invalidate the iteration
pointer. Switch to QLIST_FOREACH_SAFE to allow safe removal during
traversal.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 795c9857de82..b7357172007e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -828,9 +828,9 @@ bool qemu_console_check_format(QemuConsole *con,
 
 static void dpy_refresh(DisplayState *s)
 {
-    DisplayChangeListener *dcl;
+    DisplayChangeListener *dcl, *next_dcl;
 
-    QLIST_FOREACH(dcl, &s->listeners, next) {
+    QLIST_FOREACH_SAFE(dcl, &s->listeners, next, next_dcl) {
         if (dcl->ops->dpy_refresh) {
             dcl->ops->dpy_refresh(dcl);
         }

-- 
2.56.0.rc0.29.g47ce80527c56


