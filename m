Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72287C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXP-0004Ch-5W; Tue, 25 Aug 2026 15:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXM-0004AC-AA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXK-0003s8-SN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHUWUIlV1L88EuNWpXBRzIO9zHPWAXRW9+Hdx8pgeCk=;
 b=EBk9A8WVyC0iHicVRUZ4P41JGnHSqSCmPq9wnmm5HoyAvv6lzrHtuTCDOHvZvH3+flEFnI
 h9ZCk1fLf9g+xk+11pDw9donLBNkCpCxvICn05Pd54Yroak8CFEtVTFz+T2HXNaglIC/TK
 Mu6fD8jbTW/uqGV/81RbBZf9sSjIUwE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-ZfBIOGurMdeyrZeKPlDRJg-1; Tue,
 25 Aug 2026 15:10:13 -0400
X-MC-Unique: ZfBIOGurMdeyrZeKPlDRJg-1
X-Mimecast-MFC-AGG-ID: ZfBIOGurMdeyrZeKPlDRJg_1787685012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57CA119792FF; Tue, 25 Aug 2026 19:10:12 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47FA91944B2A; Tue, 25 Aug 2026 19:10:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:09 +0400
Subject: [PATCH v4 02/49] vl: fix -monitor none prefix matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-2-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3iiRReSd94lLGBmuGE+7JzjtOZA9/s2KBjEkNLxXG5k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiG6yuY0SXZH0k2TWbkiJeU6z499lzz1k/50
 2FlqemqTjSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohgAKCRDa6OEJdZac
 5cMOD/4gd0HmVtyGCWOWTpMi6RAxPpLX7SmNNoVb53qDN+Jlz2J+EqC+nyHuvxRjGZsyndwl4sX
 bO4WT6jeZ/0ffkuFl+oNl0Jn8BewB23lsG56XBiL60ApKUv5i+79eCIGOMvufCzj7fABsjOWSTX
 OrXC9Shh95LpU/xiGSE8bnqRvDbGQavg6bado2+prOUpXuFBauoDkhSyyeEAfgN34gAvzfQ2uki
 KRZB1Ru2yPITbaA3sPn1tBzzlIi35PxGCjSqnW4xYVw5a6HRu0niGm+Orjvx8uU3bewF0GTKYkY
 ADcGTIIjr/6m4UuGdl+aMQ0cQ9QO7z3W6yWB6ZwF/hf4Zq7S8Bjq2+anUoHsOTX47yyR/dTRHER
 rCTJCoXuIaapPcpsBbzs++vbzMwwCjlLaB/Pb2Ua6rDTjm1SGnems22JPPC9WLPLrP5ksTbEmWI
 KQe4jjQpPCLCfHDIhGyUhj5FBl6iY3EyUiBhH+mcS6DPn4XOqymPy5k71kS9IyN5g3DAiuKplDR
 kmAEdm4JyMB2lhhHIW65XQyj2YptN+BBSz+VLU0WKZhyc+vLNFM3At3hwWIeuM237YIpNk65OKm
 hdFzdgVVBE6akGBuL3ifVdCdYevgkAz4BvCd9VejA1Qv7MAKC9Jd98DDsuKnRF27p5WsUQdt3I7
 3f8PZYVB6ura+9A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use g_strcmp0() for exact match instead of strncmp() which would
incorrectly treat any string starting with "none" as disabling
the monitor.

Fixes: 70e098af88f ("monitor: allow to disable the default monitor")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 061cbdf860bf..5ccc19282ba2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3226,7 +3226,7 @@ void qemu_init(int argc, char **argv)
                 }
             case QEMU_OPTION_monitor:
                 default_monitor = 0;
-                if (strncmp(optarg, "none", 4)) {
+                if (g_strcmp0(optarg, "none")) {
                     monitor_parse(optarg, "readline", false);
                 }
                 break;

-- 
2.55.0.543.g5ebe2ebe4ea8


