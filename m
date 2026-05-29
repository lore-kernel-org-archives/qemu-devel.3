Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A3CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvE0-0002au-C4; Fri, 29 May 2026 07:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDw-0002JP-EF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDu-0008Ma-Ux
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgSJ8GIemylwK2Rz+k6Wvgj6TCAI6JvDZRNWAtchu4s=;
 b=Grqbx7WtqGL84D+p1QgRxw/F+eaCjCYuzINxjyl9epoji9w8JOCGPqHw5+0qirMPrE6zNo
 LsykU3zSwLq8vb5U6sK8zldGIZiEM/x1UnvUMdsTsuLz7Ur+LUWURxNqTExLkM0wPJsf/g
 hy4yY2L4p88m0DJX0rms2jQoEX4uT1o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-5N2GbwZ6PbO19PuSTVCZiA-1; Fri,
 29 May 2026 07:17:50 -0400
X-MC-Unique: 5N2GbwZ6PbO19PuSTVCZiA-1
X-Mimecast-MFC-AGG-ID: 5N2GbwZ6PbO19PuSTVCZiA_1780053469
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F12EA1956046; Fri, 29 May 2026 11:17:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 742B219560A3; Fri, 29 May 2026 11:17:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:32 +0400
Subject: [PATCH 11/32] ui/spice: remove dead spice_displays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-11-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=868;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=s60ojf6CttJ409AzZo9Cfg75xyybBgiiGTPP9biqSiE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPnx61QN2ZW9+8go94ELYVjFGko8GC2cbm/
 4N++ZlRLnuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5S4kD/97m4rrAnsGETRA+EGtb1nxhHOyPu0oJeUorHua/ZOEC5Un1B0igmfnlWndPBl4aw5OhZJ
 +JBGQ0A2kHQzTwkEeN+0F24bzIj+XrH2uhJarXK4IigEcXyMqhq6zgARf9dsyznE/R/kXyDstu3
 K1KHbh5YcUZtDBdjpLM/sBDK4Mzafbgv+5vTqN93LBY33DEhDq0E7s2bnNhO0sMtsgWUWflQW+c
 vEz+SxPNIJM0z4J6VG4B76gEhHMlEZbUJ/pYwNBOhGgPP/9P2C6tW+HadgQGx6/zNbURvcMPisS
 q0GbKadRZ6K1vH3FSOhM0wdMyHP9mt9ia9073B1XZ4R5a0cUnZEkQXz4BLBF+bQe7VBWKpEndH9
 0IL3FeQZXykg7ZFkde7a+avnMyetjJY7XU8ganhcCynh+8LnkzQIMnmR/QqDuSdR0autf3uDqpH
 wUwhzzGI6EApt3Zu2z5T86oarTEe41JqorVB55jrQrnhGVCrrhpFkgbdqVoFWVLLmw58vwonAXd
 pAxT3tD/ZPk7twQBXWudg66uphQLGJvzvn4iDOqOo1b7lewhWaiJ4kPxEzdQsaytjAjzTxmDFQD
 k7UBDV+gUttGQT8+ERVJXRdIMYVWSf9l/jfw2Z4iLd4+vqx6T/g61vMrxcok8eag3iadsdhG9eO
 ru6qXI61GpJJ5xw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is left-over from commit 9fa032866da ("spice: fix multihead support")

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


