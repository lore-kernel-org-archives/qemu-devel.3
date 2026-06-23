Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C8BCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpY-0003BN-5I; Tue, 23 Jun 2026 03:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpW-00038d-Kc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpV-0008Ck-4T
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkqraKUc6uDUOWv6dsveBCmO1J/oGh5rlye3uFwFBek=;
 b=db5dTdcBwuT8UE4oTl9U+Qy7KpWSmo6jBbJCXjN920Nq6m+kFW+dXLm1EdaKwkUxLpCPW+
 XHAlSEW+5ZCPW/KS/GGX6SqMwlIZjlIkpaQKtbjOhwBCkAhoybRwg7ws7Lk0bUPgjY0NaT
 THtA+RLiUVExku/ZTgFYyiHA3Blkq6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-QFOKc7F7PFCSXFfBfI0Tog-1; Tue,
 23 Jun 2026 03:45:51 -0400
X-MC-Unique: QFOKc7F7PFCSXFfBfI0Tog-1
X-Mimecast-MFC-AGG-ID: QFOKc7F7PFCSXFfBfI0Tog_1782200750
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E673918052DF; Tue, 23 Jun 2026 07:45:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98D9D195608C; Tue, 23 Jun 2026 07:45:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:28 +0400
Subject: [PATCH v4 13/34] ui/spice: remove dead spice_displays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-13-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjld4rRXdnCqBIwHVqMczr9PEI6vn54mmLXJ4
 Xu2LGkI0IGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5fjfEACcW07lkCTSp/rMK7QkmlGekN2Dz8gvwXr7EewER1OPGmbnDVvM7td/xN4iw7DspvQUKcl
 2kaJQ7wesZHQ6GM199PCutsD5wDWe9AhyphN6fYleiR5PG2i8wW2gJv4w0SoXfhX6ifhKajpuQ4
 42i1bd+AoBGNpZ5lldSR8qvSUqmBj9Vj6FE8sAxa/lG+KugEG23wNPq2gD1avONYVB1Jz5NkWP/
 1lk2ijFegg7P1TfpgCARbf88PdDjVGjCZKiOepTBdr1LUhfOMx09SufbaOAo5VvShLdohvv7fdz
 MsCh32dc2wdsY9xWpBPk4hg+ElLqacdX3yTWlyYHrltVRpPMXXpoEKH059AZKVqJyiNWntt1QlS
 0ClAOfoP0a6vKJ8KFej8tgN84wyyVI56PJa0RAXzxarbdc5JHcULL+2fZ20uYah6WmTlRQDwOBY
 lyIKxVScDRocUP5GJQgtsh49rh67MGTPCDk+edVeGmamKeHJILlEJdnbUoAJyVOTWJ/S4hlDTEd
 5cGYo+nMWIVBe5j/4HEEqTDZ8cMR3jRkpbZpKxJM8rW5SeXjnYklN212j/CVuGG6K/vBV8d6WUw
 Zu4sanqNuZYpfMJRqfaSYJrEqhRIcpOW5d9pUslIoAxrFq+RBS/C1GEwsPuL5C3Zs5muhKrliR3
 QkUo35FbahBCW1g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


