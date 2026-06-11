Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7EDCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbLU-0002HP-66; Thu, 11 Jun 2026 05:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLT-0002CW-9U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbLR-0004nw-Im
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqraKUc6uDUOWv6dsveBCmO1J/oGh5rlye3uFwFBek=;
 b=MW7l1PZdZqKiiKpNWBvMDrZ7xUV+MYK8B4znH9G3p5kGy5E4zJFEYz7pCy7YUU6OlSHOlo
 mTCgnVY00bZvzBlP8U9CRaH/Lm1PNOcN82jL+V+60uBvE+SyUkndXRsvwx/fuaJWw2VVLg
 qoH7AgTz85rrdvHryd7zpNgLkxyUQ38=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-69KLTbCJMkicEASBIejhNw-1; Thu,
 11 Jun 2026 05:04:56 -0400
X-MC-Unique: 69KLTbCJMkicEASBIejhNw-1
X-Mimecast-MFC-AGG-ID: 69KLTbCJMkicEASBIejhNw_1781168695
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 098411800675; Thu, 11 Jun 2026 09:04:55 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72CE3008B34; Thu, 11 Jun 2026 09:04:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:29 +0400
Subject: [PATCH v3 14/35] ui/spice: remove dead spice_displays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-14-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=924;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nHts4H7Pj0xNu20cVIrWwmkK5/oJi1JsNd5AGFPzVAM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnfzCLc49yQbGVY2qV3/eWcXa3ofPXle7rvr
 i57bn2Idu2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53wAKCRDa6OEJdZac
 5aFpEACILvVbUNHpQqe0O5gBg6+8bM47/k7mf+clhaW/vBLOBFzW9D4iJUt6DxxoXH9PUCSGn4o
 Djennc4SHbcQuNA4m0aZUG2bkGWw4zUEvQ+m7KhqRdw0uJp/Z/vykW2aJG8iqbFufgqW4sCPwH8
 Zm4CZ7CZ3uPZCmgCymjFb9S5PyDUDzxjb4F0rO7J1VHZ5VD8nUVL0bFB76Gc1Yrjds/O50SC7g0
 ew9iR+Z0qUPp7qBvTNEKMM6R7arBwgupq3n3+J70R5iMFk51bim2dpmXdDnNSK0e5vvwhoD0hfT
 qgHvYbg9jATYjCERb/Lwphv5RPcZH+aLdwogIMPsM3fmB50VfILaRxSmKXt6NolKN7sF1jdbDEo
 inkJN/Me8IaBKhqWFFSQKV2luLCMWajBRgz60pjCbx5JIIigOlxRFEE7X6HI35ttsZVMnExCVTD
 n/rdHdFMLkWYBLsmzUf7pHYCVaTX4jtqo+3QCyVNLUDy60Mbiq7CAu+iCl0bvO+1UH/lp2Lriu1
 KMDw5Lj/7UaNDVbmUzsADce5YK9rbrrPjVKwbS5q/Xr9ruxUgNu7RSwgIlMKV/7dfrsH4COgfCO
 donXGUNdC5VHkExWVnwRfLTGxgR2A4laMXhvOosbyTU6axpT65OQ3CulgCaIhN2utnwqiPrpayR
 8+7ZmTm/fCwOXZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is left-over from commit 9fa032866da ("spice: fix multihead support")

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-spice.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 111a09ceca3..59a68cd9833 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -33,13 +33,6 @@ bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
-
-#else  /* CONFIG_SPICE */
-
-#include "qemu/error-report.h"
-
-#define spice_displays 0
-
 #endif /* CONFIG_SPICE */
 
 static inline bool qemu_using_spice(Error **errp)

-- 
2.54.0


