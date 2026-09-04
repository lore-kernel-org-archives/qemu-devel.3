Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3582C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a5X-0003zf-TD; Fri, 04 Sep 2026 16:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5H-00039z-Mi
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a5F-0008Gh-So
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qAFNoyvj+YXGqN0JpON0sM385oGtzFD4MoEk+w0Iq28=;
 b=MbAg/xrPrUKutSRARMgVbPxVGd2Y9bwTKaFxp9/CHG5mtpzgiVOXmpyMIkxOevQZheK47g
 2+dylL3S79xEhYNb1/kCZCiOqG9WLJ7mvHHnwKYIn/NW9tEpTXX2MnNX4FBV+kYw9K7+zA
 VrnRSMrjPU6N2VjeOGaLkzEYKy8t32I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-H7Z-CmNuNMSrD92pUATM4Q-1; Fri,
 04 Sep 2026 16:00:15 -0400
X-MC-Unique: H7Z-CmNuNMSrD92pUATM4Q-1
X-Mimecast-MFC-AGG-ID: H7Z-CmNuNMSrD92pUATM4Q_1788552013
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 575E018E9B3D; Fri,  4 Sep 2026 20:00:13 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F178423; Fri,  4 Sep 2026 20:00:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:17 +0400
Subject: [PATCH v4 34/75] accel/tcg: fix "tb-size" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-34-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=976;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MfnRvRly2UY5P5uzJJrkX8tLTLJ7e9JP810t3Z45rWc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLKqoOy7BqTwzbLYDEwqKC5s6zutHMZKAQeJ
 372p0eXkpGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiygAKCRDa6OEJdZac
 5Ws8D/906VcPWjevEynfPGOxPfLreonNITA9QeGQbDjlZ1Om7xDA8RHGsN+ij97tGqHpyxkEOic
 i3I6XKRlDT4qX0ECpRIJ2IOxEV5ecIrjzYAkNAQxbhNpB1+bDS+sg6NIxRVAAFlT+Xr+f1mprut
 kKAWBcXr682H+G2Lhertv4RXRJy3KG95ii+5nzyP6s7zK6/xXbg6n9zBnIQEOxUOYXJR8Ns0zv3
 te9DHF5LBkvLmdGFTNfbtN88UluJL9UebsH1K6dKl9PZa7YHrZCV1Y02qqeC709BrEputKqI7Bz
 5tIa5P1vw0QFLLqjHygI8M3Hk++oZFTqNEH1tjoxmKtihgX7gFShhijCQLlrM7sSAq92m5laIAW
 IfgJLZVxGJ4kVP7mF83LKgCfNhZyfehHy5aFvoRJSStMKE1CgcFtWMAcHzOfbLxWaRL4trZ4+L7
 Lg/muVlmy7AsmS/Aov8OLjiOD07RrgJjvA9l0mZuPejC/cBerdzy1ceVrm3iRsgJJMhWB9//xX5
 isHaeUIqdAojVPXlRXPNM0PkP1qTPF61BXJreKIkdb21yymbW73KChIu1ccydFhxs4Omm+d3NSS
 cN/hVAb4sKqeMVpCxZeZpH6/YCOBXmmreMP2Ahmma4tJ+sR9UFvUd0sGFymhvS6adbZAnUghWdA
 4EvrEvLutQs9tcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The getter and setter use visit_type_uint32, not visit_type_int.

Fixes: fe174132478b ("tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7186c10cf022..767e8805552f 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -270,7 +270,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                   tcg_get_thread,
                                   tcg_set_thread);
 
-    object_class_property_add(oc, "tb-size", "int",
+    object_class_property_add(oc, "tb-size", "uint32",
         tcg_get_tb_size, tcg_set_tb_size,
         NULL, NULL);
     object_class_property_set_description(oc, "tb-size",

-- 
2.55.0.543.g5ebe2ebe4ea8


