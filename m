Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D65CFD62B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTVH-0004rI-P1; Wed, 07 Jan 2026 08:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTVA-0004ex-39
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdTV6-00056r-Tn
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767792180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=yeKFGZB9+gJSq195IaW/Pt1I2thdpGCpcsFHPG8zrPU=;
 b=JMRwrLiSSeJeYb3heKqAH5BmU38iYXRc5wpML4TbgYW8RAPBO/2rlS7uNR04VOlfmT05zZ
 m8hO+q93r1AIngdOfeJK1dhUf5Cy0tCxhQyvR8s4bsgwBzQ/EaErXi1IXModVfuEeulS2U
 7s7y+WDbX7BRAcG8DOAH6EnTgZaKZGk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-Za9l_g-jOcqZ8YlX56m8vA-1; Wed,
 07 Jan 2026 08:22:58 -0500
X-MC-Unique: Za9l_g-jOcqZ8YlX56m8vA-1
X-Mimecast-MFC-AGG-ID: Za9l_g-jOcqZ8YlX56m8vA_1767792177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0D7E1800350; Wed,  7 Jan 2026 13:22:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DBCD19560B4; Wed,  7 Jan 2026 13:22:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BCD821E6934; Wed, 07 Jan 2026 14:22:55 +0100 (CET)
Resent-To: philmd@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 07 Jan 2026 14:22:55 +0100
Resent-Message-ID: <87sechimkw.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Wed Jan  7 13:43:41 2026
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4708421E61AE; Wed, 07 Jan 2026 13:43:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/17] error: Strip trailing '\n' from error string arguments
 (again)
Date: Wed,  7 Jan 2026 13:43:30 +0100
Message-ID: <20260107124341.1093312-7-armbru@redhat.com>
In-Reply-To: <20260107124341.1093312-1-armbru@redhat.com>
References: <20260107124341.1093312-1-armbru@redhat.com>
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



