Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8641BCD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 15:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqDkG-0008Rq-VL; Fri, 29 Mar 2024 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rqDkD-0008QX-SI
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rqDk9-0002f6-RP
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711724527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3JWsUApzBe/yU9PQWWAVMof614cOiCLUxZ5SkbW/Fy4=;
 b=MOc4H7uBw9+XuHM0wDlI0WRUzWpj/S0Z7dYnF7lcgS7PAS9aMDGCOG4SeKezrBQYRBzXZK
 Eu1TPRpOTSCD/3xu5RvKvX1HuTD9rqh9KhSP6BkLKiQzt8hg1ZSeoI/NrE7muAGFoSdNxA
 JkBJw8sbDDYeBW7vH/E8eUFul2Ne+bU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-h0vDhlnVOeqYbcAwUyoXyg-1; Fri, 29 Mar 2024 11:02:02 -0400
X-MC-Unique: h0vDhlnVOeqYbcAwUyoXyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC2F3101CC67;
 Fri, 29 Mar 2024 15:02:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92A732166B31;
 Fri, 29 Mar 2024 15:02:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] raspi4b: Reduce RAM to 1Gb on 32-bit hosts
Date: Fri, 29 Mar 2024 16:01:54 +0100
Message-ID: <20240329150155.357043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change the board revision number and RAM size to 1Gb on 32-bit hosts.
On these systems, RAM has a 2047 MB limit and this breaks the tests.

Fixes: 7785e8ea2204 ("hw/arm: Introduce Raspberry PI 4 machine")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/raspi4b.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index cb1b1f2f147e8685a1dba6f137335ea0bc89bca5..85877880fc706d216de04ff1e081d66e6080ebac 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -112,7 +112,11 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+#if HOST_LONG_BITS == 32
+    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
+#else
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
+#endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->init = raspi4b_machine_init;
 }
-- 
2.44.0


