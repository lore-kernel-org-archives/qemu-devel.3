Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073AAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Lv1-0000wy-Ra; Mon, 29 Apr 2024 03:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1Luy-0000qT-3U
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1Luw-0004D8-Ig
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714377557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y14kT3to8gmEzHZb6tZDDijnuELitRC4BVu6UM95dms=;
 b=dV1+Mmw6zMvMKpBG9eazTMgGmHTQWN9evw6PHoJA6N8ggXdT5WhUxUnqCUtZQ/mdfY8ZE1
 1yM4ADE4eLk3zjc6KIKVV4sb42vM6RVBOmf+oO0yM2vOwPuIY6LEiXfyBagSgTIqzVSAxM
 qfnDsyNn/FbQjc8HwN9KNbUU2p6fLNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-vpMbdjVfN22Bcsqz2amiAQ-1; Mon, 29 Apr 2024 03:59:11 -0400
X-MC-Unique: vpMbdjVfN22Bcsqz2amiAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23DE28032FA;
 Mon, 29 Apr 2024 07:59:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4452166B31;
 Mon, 29 Apr 2024 07:59:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/char/stm32l4x5_usart: Fix memory corruption by adding
 correct class_size
Date: Mon, 29 Apr 2024 09:59:08 +0200
Message-ID: <20240429075908.36302-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"make check-qtest-aarch64" recently started failing on FreeBSD builds,
and valgrind on Linux also detected that there is something fishy with
the new stm32l4x5-usart: The code forgot to set the correct class_size
here, so the various class_init functions in this file wrote beyond
the allocated buffer when setting the subc->type field.

Fixes: 4fb37aea7e ("hw/char: Implement STM32L4x5 USART skeleton")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/char/stm32l4x5_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 2627aab832..02f666308c 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -617,6 +617,7 @@ static const TypeInfo stm32l4x5_usart_types[] = {
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(Stm32l4x5UsartBaseState),
         .instance_init  = stm32l4x5_usart_base_init,
+        .class_size     = sizeof(Stm32l4x5UsartBaseClass),
         .class_init     = stm32l4x5_usart_base_class_init,
         .abstract       = true,
     }, {
-- 
2.44.0


