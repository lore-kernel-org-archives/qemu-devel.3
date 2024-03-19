Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8FAC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma6E-0004Va-Un; Tue, 19 Mar 2024 10:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma68-0004Pj-Tq
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma67-0008Ng-FR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710857146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeuJyXmk87ew7gCuQ5ySXtgH3p1fHidr/s3r/qeVRMI=;
 b=P/oc62qXbsaannbhCjIPESS40TPVjNrkCpKqv6MKPCI9gteUKRZNQSPk1h4mO1Tllnl+AA
 XXu3PfcJ6XCKa1Lb+96Mj1icNu997uVF1pkBcI1zCO6tKMpl9+MRjZ4OVWvNWLdZhL75oC
 AkgfKUhbPmXlYHZbl5R6x2BjybpQHf4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-WGZLw505Okya4wVKHccKhg-1; Tue,
 19 Mar 2024 10:05:42 -0400
X-MC-Unique: WGZLw505Okya4wVKHccKhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAA041C04B5B;
 Tue, 19 Mar 2024 14:05:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4DBB3C21;
 Tue, 19 Mar 2024 14:05:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] ppc/pnv: I2C controller is not user creatable
Date: Tue, 19 Mar 2024 15:05:15 +0100
Message-ID: <20240319140516.392542-3-clg@redhat.com>
In-Reply-To: <20240319140516.392542-1-clg@redhat.com>
References: <20240319140516.392542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The I2C controller is a subunit of the processor. Make it so and avoid
QEMU crashes.

  $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
  qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize: Assertion `i2c->chip' failed.
  Aborted (core dumped)

Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/ppc/pnv_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index 4581cc5e5d4645ab3e358d983a633e33a214c425..eec5047ce83f842108b53a6e2bd9869a81f14ac1 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -557,6 +557,9 @@ static void pnv_i2c_class_init(ObjectClass *klass, void *data)
 
     xscomc->dt_xscom = pnv_i2c_dt_xscom;
 
+    /* Reason: This device is part of the CPU and cannot be used separately */
+    dc->user_creatable = false;
+
     dc->desc = "PowerNV I2C";
     dc->realize = pnv_i2c_realize;
     device_class_set_props(dc, pnv_i2c_properties);
-- 
2.44.0


