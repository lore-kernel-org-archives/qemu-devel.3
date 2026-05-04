Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9ABFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdS-00084F-HS; Mon, 04 May 2026 07:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdQ-0007p6-OJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdP-0001KB-7w
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GxczfIUezB8LDmHE3u3mH9fTJmiCKopfl79kKH/Kww=;
 b=Rff7229Q+bFglJrSohySWC4XbCWvXFuLNcuy4Be3vMpb3SIsMq+BraOIadTYV7oFK87qjL
 B7I8BFyRUFjsk46IUz/CUY4ifQjFkqYQXfK91aV3ds1tOiM+OY/XsUvHIC8Ezvv6XGVR8Q
 xdYHEwmNOeya1L58Wls/7tXzGTEZcxw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-gridOgSdM9ahhmp1Rg4obQ-1; Mon,
 04 May 2026 07:38:45 -0400
X-MC-Unique: gridOgSdM9ahhmp1Rg4obQ-1
X-Mimecast-MFC-AGG-ID: gridOgSdM9ahhmp1Rg4obQ_1777894724
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A59D195609E
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:38:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F87F1800480; Mon,  4 May 2026 11:38:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:24 +0400
Subject: [PATCH v2 36/46] hw/arm/aspeed: free fmc_model and spi_model on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-36-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PkTZRbkufOoEKwzeptnlFgLn3nglmLBi5Zuslh0iOS0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtJxDqxwfr091qv+GTM7qI3HJ3ULK1xpqnJ
 TcJlry/lFqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5co/D/9AXzA/rYOf0bjnSKTbPvAyqkm9LAH19htqAe/i598peTuTux1ZI33zRMtjnnW8gYmswsV
 fmhycaAg/5PWIqsKpIApvKHz6h11oTWGXmIlE0TYmddYqiQSEmP72+VKihtJuu+wi46022CqQw1
 xGr8kb6eKrwuazz7/LzsAVB621masF8cLOWS82z8OatCxZNjh6i1ShoauShq0OIehJEn3K7Y0Q8
 ziUoXMGRwSBsENHLe3YbFIA702uZsAdTYVtLc4xVUxr6hCIH4pctxJbqyXtpcbgydUtWYlJ6CUZ
 QbThNwRA55t0ePfZkiLQcXCWOqOWFk+7WkPEEvnBai7qzQPWRsmOE9ovXiAIZdN/oMpJZw0JvaB
 b79I/dAxrqeu/uLkXM2G2H/xPZFrv1QbaibtTFeGc0nzY8mi75eDBilA7GVjKMiI2aLbQnqjDsZ
 SGORiEHjGheOUWF8MfrVUfrPJsHON/AWhUulCFlOei7niFErqv3R0tjOaxAVezaTnEPvYHDgJou
 0BsQ77m90xVIsh5E3htRR15jzWO3uP0wWYcsn59y7dl3PMuQo5/1dKXHWQhwjinMCFUjYWRsvAU
 B5hH5ZdOUuNBhAv3p65ErqosRgxq0l0rnrexFj1ZZdy0eTnGMsONewz1M5I/PycWc663trdi9Dp
 M67IDp5pf8xJYkQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

The fmc_model and spi_model strings are allocated via g_strdup in
property setters but never freed when the machine object is destroyed.

Fixes: 9820e52fbef7 ("hw/arm/aspeed: Add machine properties to define the flash models")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/aspeed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a3db3406c5f..a48c4420583 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -419,12 +419,21 @@ static void aspeed_machine_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_props_init(oc);
 }
 
+static void aspeed_machine_instance_finalize(Object *obj)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    g_free(bmc->fmc_model);
+    g_free(bmc->spi_model);
+}
+
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
         .instance_size = sizeof(AspeedMachineState),
         .instance_init = aspeed_machine_instance_init,
+        .instance_finalize = aspeed_machine_instance_finalize,
         .class_size    = sizeof(AspeedMachineClass),
         .class_init    = aspeed_machine_class_init,
         .abstract      = true,

-- 
2.54.0


