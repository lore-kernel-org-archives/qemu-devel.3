Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF81D148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6W-0006zn-Gl; Thu, 08 Jan 2026 02:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6S-0006p7-8u
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6P-0006c7-Nd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeKFGZB9+gJSq195IaW/Pt1I2thdpGCpcsFHPG8zrPU=;
 b=Svrw/Th9xnZLBhgvQXGBtfCPExeXiFEwgPYkV0bPMDWNj0rI+DJ2pdYVfWAOuFEqdDtBuA
 tJq4Ir7zVXMkcNC77y0Fg8fryfpN6bUku4SxKGmD4SUYLOgqVvuS7lSbK7DGR0oC6xIwJB
 Y558cyBgPtfmCW9uQg0cUvKjl3lJ9/Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-VrUDGTsqNnqU1RaVc4S0FQ-1; Thu,
 08 Jan 2026 02:06:33 -0500
X-MC-Unique: VrUDGTsqNnqU1RaVc4S0FQ-1
X-Mimecast-MFC-AGG-ID: VrUDGTsqNnqU1RaVc4S0FQ_1767855991
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80083195609E; Thu,  8 Jan 2026 07:06:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BBFD19560A7; Thu,  8 Jan 2026 07:06:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 096CE21E61AE; Thu, 08 Jan 2026 08:06:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 06/17] error: Strip trailing '\n' from error string
 arguments (again)
Date: Thu,  8 Jan 2026 08:06:14 +0100
Message-ID: <20260108070625.1586474-7-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tracked down with scripts/coccinelle/err-bad-newline.cocci.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251121121438.1249498-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/es1370.c | 2 +-
 ui/gtk.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 9873ffadab..566f93f1ea 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -228,7 +228,7 @@ static void print_sctl(uint32_t val)
 #undef a
         error_report("es1370: "
                 "%s p2_end_inc %d, p2_st_inc %d,"
-                " r1_fmt %s, p2_fmt %s, p1_fmt %s\n",
+                " r1_fmt %s, p2_fmt %s, p1_fmt %s",
                 buf,
                 (val & SCTRL_P2ENDINC) >> SCTRL_SH_P2ENDINC,
                 (val & SCTRL_P2STINC) >> SCTRL_SH_P2STINC,
diff --git a/ui/gtk.c b/ui/gtk.c
index 48571bedbf..e83a366625 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1197,7 +1197,7 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
         type = INPUT_MULTI_TOUCH_TYPE_END;
         break;
     default:
-        warn_report("gtk: unexpected touch event type\n");
+        warn_report("gtk: unexpected touch event type");
         return FALSE;
     }
 
-- 
2.52.0


