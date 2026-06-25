Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234BCCDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWb-0006bT-1i; Thu, 25 Jun 2026 17:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWa-0006as-8z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWY-0003z5-KY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGuygaw90nyfUcdlBzft+Etf4fff8VkgQ5bDUxaELbM=;
 b=T4w00+k8SDV4bBOJoLyY1Z1Qbm1nIJLO/813Zu/c1jddnTXhMRqKPVtzm5AsD2PONkp9aC
 IdiFaKfM1UJS1P7jaig+kAR5D/FDfScbfM7XgeQ7NeFpc9aP0NGuotKKvWncUWhFqlp1a3
 0qdDSGlaAF6CEGxxlRqxkqJlONMVZss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-mwdW4xrOOciurxJK2Bp-Pg-1; Thu,
 25 Jun 2026 17:22:10 -0400
X-MC-Unique: mwdW4xrOOciurxJK2Bp-Pg-1
X-Mimecast-MFC-AGG-ID: mwdW4xrOOciurxJK2Bp-Pg_1782422529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98DEB1873123; Thu, 25 Jun 2026 21:22:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64AF21800586; Thu, 25 Jun 2026 21:22:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:30 +0400
Subject: [PATCH v2 29/39] monitor: reject readline monitor when HMP is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-qemu-no-hmp-v2-29-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SdR1H1AX7SN41gTLzd1ShW5/r4BEAKXdex8EICuZOEw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtd0Ppuna9n2940R3OXSRUP4iTrICQxg88yP
 MWrBQz+F66JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5fcsEACt8f8AbCaJhxdktf0x6v2xzs96Rkk/Td99kn3WW73knCIXeBqDcM3K7y3DSA8VTxotVi6
 IdbfpwucVVd93cp7UGYje30R2eg88s89JkJL6YXzbExy31g7X7Yu1aY7oX8bl56W1pCXXnYFJEV
 AULVUkF1krLYpqbw78zUEQUM2TT4yHYQXpBzdt5eVE4yPTRU2oo8yVvBdmt/PYcuZOtb7Dp5lLQ
 Xv5zBeVyWAD25lR2U1tF2DIzr+OZuAtYFYSrCDs21/hvZ/LGTTUPO4DDTWRvrXSiljxmuEDX8eL
 wqPkx89ozYlT4fNtZd4wkya4qmtps6fvKnCOBxeS/GgQ7gOo7O2eDKxjKt0MLoBGbPiJTsITfVl
 zWS9Qqq5vj0f419TDuGbXF0MXJAOvv2CKcxOIpIZzEjAWOj+5D6EsPOHIq8E4xnmlVbP2/jKXc9
 lrzfFTRtb9Dyp2wWG9rEB8iIdLmd6IZo/Ki72/tsxi2A9Sko1hCtBvXtvUrE66fsQfYpVmwJM4J
 XsNAdxRJY5aOsUGZR334L7oTbiveiDHhx5LUMIzsdFQUqgXRA32vktJoQyLndSqx7GMfhar1AJJ
 DmOXBn1PmgAoWbyu7kk+vw00NBvyjBJd0vRzLrRJcgbcm6gtEdU3/mMqSDFBsDuyGiXhrY89Hdo
 BIh3zuEkGvQ8zMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When QEMU is built without HMP support, reject '-monitor' (which
requests readline/HMP mode) early in monitor_init_opts() with a
clear error message directing users to '-qmp' instead.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2dec0e299af..f443f406b4c 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -764,6 +764,16 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
     MonitorOptions *options;
     int ret;
 
+#ifndef CONFIG_HMP
+    const char *mode = qemu_opt_get(opts, "mode");
+    /* readline is HMP..  */
+    if (mode && g_str_equal(mode, "readline")) {
+        error_setg(errp, "HMP monitor is not available,"
+                   " use '-qmp' instead of '-monitor'");
+        return -1;
+    }
+#endif
+
     v = opts_visitor_new(opts);
     visit_type_MonitorOptions(v, NULL, &options, errp);
     visit_free(v);

-- 
2.54.0


